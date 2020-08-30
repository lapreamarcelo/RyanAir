//
//  FlightsViewController.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import UIKit

class FlightsViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    var flightPresenter: FlightsPresenter?
    
    private var cellIdentifier = "FlightTableViewCell"
    
    // MARK: - Initialization
        
    init(flightPresenter: FlightsPresenter) {
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
        self.flightPresenter = flightPresenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flightPresenter?.update(view: self)
        tableView.reloadData()
        
        setup()
    }
    
    private func setup() {
        title = "FLIGHTS"
        
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: - Extension FlightsView

extension FlightsViewController: FlightsView {

}

extension FlightsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if flightPresenter?.flights?.trips?.isEmpty ?? true {
            return 0
        }
        
        return flightPresenter?.flights?.trips?.first?.dates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flightPresenter?.flights?.trips?.isEmpty ?? true {
            return 0
        }
        
        return flightPresenter?.flights?.trips?.first?.dates?[section].flights.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FlightTableViewCell else {
            return UITableViewCell()
        }
        
        let singleFlight = flightPresenter?.flights?.trips?.first?.dates?[indexPath.section].flights[indexPath.row]
        
        cell.bind(origin: flightPresenter?.flights?.trips?.first?.origin, destination: flightPresenter?.flights?.trips?.first?.destination, singleFlight: singleFlight)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let flight = flightPresenter?.flights?.trips?.first?.dates?[section]
        
        let dateOut = Date.formatDateFromString(formatToConvert: "MMM dd, yyyy", fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS", stringDate: flight?.dateOut ?? "")
        return dateOut
    }
}
