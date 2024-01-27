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
        
        viewModel.$characters
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.namberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(viewModel.characters[indexPath.row].name)"
//        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

