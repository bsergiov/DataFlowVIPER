//
//  MainView.swift
//  DataFlowVIPER
//
//  Created by BSergio on 01.06.2022.
//

import Foundation
import UIKit

// ViewController
// protocol
// reference presenter

protocol MainViewProtocol: AnyObject {
    var presentet: MainPresenterProtocol? { get set }
    
    func update(with data: [MainModel])
    func update(with error: String)
}

class MainViewController: UIViewController, MainViewProtocol {
    
    // MARK: - Public Properties
    unowned var presentet: MainPresenterProtocol?
    var models: [MainModel] = []
    
    // MARK: - UI Elements
    lazy private var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    lazy private var errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(errorLabel)
        
        view.addSubview(tableView)
        view.backgroundColor = .orange
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        errorLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        errorLabel.center = view.center
    }
    
    func update(with data: [MainModel]) {
        print("from vc dat \(data)")
        DispatchQueue.main.async {
            self.models = data
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.models = []
            self.tableView.isHidden = true
            self.errorLabel.text = error
            self.errorLabel.isHidden = false
        }
    }
}

// MARK: - Protocols TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = models[indexPath.row].namess
        
        return cell
    }
}
