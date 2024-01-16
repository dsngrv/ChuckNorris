//
//  RandomJokeViewController.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 14.01.2024.
//

import UIKit

class RandomJokeViewController: UIViewController {
    
    private let jokeRealmService = JokeRealmService()
        
    private lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var downloadJokeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Download Joke", for: .normal)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(downloadJoke), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    @objc private func downloadJoke() {
        NetworkService.requestJoke { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let joke):
                    self?.jokeRealmService.addJoke(joke: joke)
                    self?.jokeLabel.text = joke.value
                case .failure(let error):
                    self?.presentAlert(title: "Something went wrong:", message: error.localizedDescription)
                }
            }
        }
    }

    private func setupLayout() {
        view.backgroundColor = .white
        [jokeLabel, downloadJokeButton].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            jokeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            jokeLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            jokeLabel.widthAnchor.constraint(equalToConstant: 300),
            
            downloadJokeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            downloadJokeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            downloadJokeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

}

