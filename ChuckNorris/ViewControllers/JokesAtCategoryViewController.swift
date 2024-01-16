//
//  JokesAtCategoryViewController.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 15.01.2024.
//

import Foundation
import UIKit

final class JokesAtCategoryViewController: UIViewController {
    
    let category: String
    var jokesAtCategory: [Joke] = []
    var jokeRealmService = JokeRealmService()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    init(category: String) {
            self.category = category
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        jokesAtCategory = jokeRealmService.fetchJokes().filter({ $0.category.contains(where: {$0 == category})})
        print(jokesAtCategory)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.title = category.uppercased()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension JokesAtCategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokesAtCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let joke = jokesAtCategory[indexPath.row]
        print(joke)
        content.text = jokesAtCategory[indexPath.row].value
        content.secondaryText = joke.downloadDate.formatted()
        cell.contentConfiguration = content
        return cell
    }
    
}

extension JokesAtCategoryViewController: UITableViewDelegate {
    
}
