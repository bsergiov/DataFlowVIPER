//
//  MainRouter.swift
//  DataFlowVIPER
//
//  Created by BSergio on 01.06.2022.
//


import UIKit
typealias EntryPoint = MainViewProtocol & UIViewController
// Object
// Entry point

protocol MainRouterProtocol: AnyObject {
    var entry: EntryPoint? { get }
    
    static func start() -> MainRouterProtocol
}


class MainRouter: MainRouterProtocol {
    
    var entry: EntryPoint?
    
    static func start() -> MainRouterProtocol {
        let router = MainRouter()
        // Assign View Interactor Presenter
        let view: MainViewProtocol = MainViewController()
        let presenter: MainPresenterProtocol = MainPresenter()
        let interactor: MainInteractorProtocol = MainInteractor()
        
        interactor.presenter = presenter
        view.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        return router
    }
}
