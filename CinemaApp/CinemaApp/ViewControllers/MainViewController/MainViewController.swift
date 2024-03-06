//
//  MainViewController.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/2/27.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    @IBOutlet weak var dataTableView: UITableView!
    
    var subscriptions = [AnyCancellable]()
    
    var viewModel = MainViewModel()
    var cellSubscription: [IndexPath: AnyCancellable] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
        bindViewModel()
    }
    
    
    func setupData() {
        viewModel.action.send(.fetchData)
    }
    
    func setupUI() {
        self.title = "Main View"
        dataTableView.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
        dataTableView.estimatedRowHeight = 150
        dataTableView.rowHeight = UITableView.automaticDimension
    }
    
    func bindViewModel() {
        
        viewModel.$movies
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .sink { _ in
                print("Log binding table \(self.viewModel.numberOfRows(in: 1))")
                self.cellSubscription.removeAll()
                self.dataTableView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.state
            .sink { [weak self] state in
                if case .reloadCell(let indexPath) = state {
                    self?.dataTableView.reloadRows(at: [indexPath], with: .fade)
                }else if case .error(let message) = state {
                    print("Log show error:\(message)")
                }
            }
            .store(in: &subscriptions)
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell
        else {
            return UITableViewCell()
        }
        
        let vm = viewModel.movieCellViewModel(at: indexPath)
        cell.viewModel = vm
        storeCellCancellable(indexPath: indexPath, cell: cell)
        return cell
    }
    
    func storeCellCancellable(indexPath: IndexPath, cell: MovieTableViewCell) {
        guard !cellSubscription.keys.contains(indexPath) else {
            return
        }
        
        let cancellable = cell.downloadPublisher
            .debounce(for: 0.1, scheduler: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.viewModel.action.send(.downloadImage(indexPath: indexPath))
            }
        cellSubscription[indexPath] = cancellable
    }
}
