//
//  CategoryJokeViewController.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 14.01.2024.
//

import Foundation
import UIKit

final class CategoryJokeViewController: UIViewController {
    
    private var categories: [String] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        NetworkService.requestCategories {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self?.categories = categories
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CategoryJokeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = UIListContentConfiguration.cell()
        let category = categories[indexPath.row]
        content.text = category
        cell.contentConfiguration = content
        return cell
    }
    
    
}

extension CategoryJokeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        let viewController = JokesAtCategoryViewController(category: category)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
