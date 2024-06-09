//
//  PLaceListViewController.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 14/05/24.
//

import UIKit
import CoreData

class PLaceListViewController: UIViewController {

    // MARK: - Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [PlaceItem]()
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(PlaceListViewCell.self, 
                           forCellReuseIdentifier: PlaceListViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
        getAllPlaces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllPlaces()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Great Places iOS"
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    @objc private func addButtonTapped() {
        let viewController = NewPlaceFormViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func getAllPlaces() {
        do {
            models = try context.fetch(PlaceItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // Error
        }
    }
}

extension PLaceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let placeModel = models[indexPath.row]
        
        let place = Place(id: placeModel.id ?? UUID(),
                          title: placeModel.title ?? "",
                          location: PlaceLocation(latitude: 0.0, 
                                                  longitude: 0.0,
                                                  address: placeModel.address),
                          image: placeModel.image ?? Data())
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceListViewCell.identifier,
                                                 for: indexPath) as! PlaceListViewCell
        
        cell.configureCell(with: place)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Navigate to details screen
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // TODO: Implement delete functionality
}
