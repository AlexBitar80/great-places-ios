//
//  SelectMapViewController.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 28/05/24.
//

import UIKit
import GoogleMaps

class SelectMapViewController: UIViewController {
    
    // MARK: - Properties
    
    private var currentMarker: GMSMarker?
    
    private lazy var mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        return mapView
    }()
    
    // MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        title = "Selecionar localização"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
        view.addSubview(mapView)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func addButtonTapped() {}
}

extension SelectMapViewController: GMSMapViewDelegate {
   
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        Task {
            currentMarker?.map = nil
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            currentMarker = marker
            
            do {
                let address = try await LocationService.shared.getAddressFrom(latitude: coordinate.latitude,
                                                                              longitude: coordinate.longitude)
                print(address)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
