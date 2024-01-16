//
//  JokeListViewController.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 14.01.2024.
//

import Foundation
import UIKit

final class JokeListViewController: UIViewController {
    
    private let jokeRealmService = JokeRealmService()
    private var jokeList: [Joke]
    
    private var isSorted: Bool = true
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init() {
        self.jokeList = jokeRealmService.fetchJokes()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        print(jokeList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jokeList = jokeRealmService.fetchJokes()
        tableView.reloadData()
    }
    
    @objc private func tapButtonAction() {
        if isSorted {
            jokeList.sort(by: { $0.downloadDate > $1.downloadDate })
            tableView.reloadData()
            isSorted = false
        } else {
            jokeList.sort(by: { $0.downloadDate < $1.downloadDate })
            tableView.reloadData()
            isSorted = true
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(tapButtonAction))
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension JokeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let joke = jokeList[indexPath.row]
        content.text = joke.value
        content.secondaryText = joke.downloadDate.formatted()
        cell.contentConfiguration = content
        return cell
    }
    
    
}

extension JokeListViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.reloadData()
        }
    }
    
}
