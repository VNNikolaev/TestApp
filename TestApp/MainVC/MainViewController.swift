//
//  ViewController.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

import Combine
import UIKit

class MainViewController: UIViewController {
    let viewModel: MainViewModel
    private var cancellable: Set<AnyCancellable> = []
    
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(networkFacade: NetworkFacade) {
        viewModel = MainViewModel(networkFacade: networkFacade)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - реализовать настройку на фреймах
        setupViewWithConstraint()
        setupConstraint()
        setupTableView()
        viewModel.fetchCharacters()
        
        viewModel.$cellDataSource
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellable)
    }
}

extension MainViewController {
    private func setupViewWithConstraint() {
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(MainConstraintCell.self, forCellReuseIdentifier: MainConstraintCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.namberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainConstraintCell.identifier, for: indexPath) as? MainConstraintCell else { return UITableViewCell() }
        let cellViewModel = viewModel.cellDataSource[indexPath.row]
        cell.setupCell(with: cellViewModel)
        return cell
    }
}

