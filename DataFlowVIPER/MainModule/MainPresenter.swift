//
//  MainPresenter.swift
//  DataFlowVIPER
//
//  Created by BSergio on 01.06.2022.
//

import Foundation

// Object
// protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol MainPresenterProtocol: AnyObject {
    var models: [MainModel] { get set }
    var router: MainRouterProtocol? { get  set }
    var interactor: MainInteractorProtocol? { get set }
    var view: MainViewProtocol? { get set }
    
    func interactorDidFetch(with result: Result<[MainModel], Error>)
}

class MainPresenter: MainPresenterProtocol {
    
    var models: [MainModel] = []
    
    unowned var router: MainRouterProtocol?
    
    unowned var interactor: MainInteractorProtocol? {
        didSet {
            interactor?.getData()
        }
    }
    
    unowned var view: MainViewProtocol?
    
    func interactorDidFetch(with result: Result<[MainModel], Error>) {
        print("from interactorDidFetch")
        switch result {
            
        case .success(let entities):
            models = entities
            view?.update()
        case .failure(let error):
            view?.update(with: "Fetch failed: \(error)")
        }
    }
}
