//
//  MainViewModel.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/2/27.
//

import Foundation
import Combine
import UIKit

class MainViewModel {
    
    enum State {
        case initial
        case fetched
        case error(message: String)
        case reloadCell(indexPath: IndexPath)
    }
    
    enum Action {
        case fetchData
        case reset
        case downloadImage(indexPath: IndexPath)
    }
    
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    
    let action = PassthroughSubject<Action, Never>()
    let state = CurrentValueSubject<State, Never>(.initial)
    
    var subscription = [AnyCancellable]()
    var movieCancellable = [AnyCancellable]()
    
    init() {
        state.sink { [weak self] state in
            self?.processState(state)
        }.store(in: &subscription)
        
        action.sink { [weak self] action in
            self?.processAction(action)
        }.store(in: &subscription)
    }
    
    private func processAction(_ action: Action) {
        switch action {
        case .fetchData:
            print("Log ViewModel process action: fetchData")
             fetchData()
            break
        case .reset:
            print("Log ViewModel process action: reset")
            movies = []
             fetchData()
            break
        case .downloadImage(let indexPath):
            print("Log ViewModel process action: downloadImage row: \(indexPath.row)")
            downloadImage(indexPath: indexPath)
            break
        }
    }
    
    private func processState(_ state: State) {
        switch state {
        case .initial:
            print("Log ViewModel process inital")
            isLoading = false
            break
        case .fetched:
            print("Log ViewModel process fetched")
            isLoading = true
            break
        case .error(let message):
            print("Log ViewModel process error:\(message)")
            break
        case .reloadCell(let indexPath):
            print("Log ViewModel process reloadCell:\(indexPath.row)")
            break
        }
    }
    
    func fetchData() {
        movieCancellable = []
        
        getMoivesFromLocal()
            .receive(on: DispatchQueue.main)
            .map(\.results)
            .replaceError(with: [])
            .assign(to: \.movies, on: self)
            .store(in: &movieCancellable)
    }
    
    func downloadImage(indexPath: IndexPath) {
        guard indexPath.row < movies.count else {
            return
        }
        
        guard let path = movies[indexPath.row].posterPath else {
            return
        }
        loadImage(path: path)
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .sink (receiveValue: { [weak self] image in
                self?.movies[indexPath.row].thumbnailImage = image
                self?.state.send(.reloadCell(indexPath: indexPath))
            }).store(in: &movieCancellable)
    }
}

extension MainViewModel {
    func numberOfRows(in section: Int) -> Int {
        return movies.count
    }
    
    func movieCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return MovieCellViewModel(movie: movies[indexPath.row])
    }
    
    func getMovies() -> AnyPublisher<MovieModel, APIError> {
        let endPointType = MovieEndPointType.movies(Constant.API.key)
        return APIManager.shared.request(modelType: MovieModel.self, endPointType: endPointType)
            .eraseToAnyPublisher()
    }
    
    func getMoivesFromLocal() -> AnyPublisher<MovieModel, APIError> {
        let endPointType = MovieEndPointType.movies()
        return MockAPIManager.shared.request(modelType: MovieModel.self, endPointType: endPointType)
            .eraseToAnyPublisher()
    }
    
    func loadImage(path: String) -> AnyPublisher<UIImage?, APIError> {
        let endPointType = ImageEndPointType.poster(path)
        return APIManager.shared.download(endPointType: endPointType).eraseToAnyPublisher()
    }
}
