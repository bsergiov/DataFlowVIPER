//
//  MainInteractor.swift
//  DataFlowVIPER
//
//  Created by BSergio on 01.06.2022.
//

import Foundation
// object
// protocol
// ref to presenter

// https://jsonplaceholder.typicode.com/users

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    
    func getData()
}

class MainInteractor: MainInteractorProtocol {
    
    var presenter: MainPresenterProtocol?
    
    func getData() {
        print("start fetch")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                self.presenter?.interactorDidFetch(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([MainModel].self, from: data)
                print("from getData")
                self.presenter?.interactorDidFetch(with: .success(entities))
            }
            catch {
                print("faile fetch data \(error)")
                self.presenter?.interactorDidFetch(with: .failure(error))
            }
            
        }
        task.resume()
    }
}
