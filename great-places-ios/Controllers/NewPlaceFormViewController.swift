//
//  NewPlaceFormViewController.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 14/05/24.
//


import UIKit
import Kingfisher
import CoreLocation

class NewPlaceFormViewController: UIViewController {
    
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    
    private lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var titleTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Título"
        textfield.borderStyle = .roundedRect
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var mapLocationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.50
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        return imageView
    }()
    
    private lazy var buttonActionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(systemName: "mappin")
//        configuration.imagePadding = 4
        configuration.title = "Localização atual"
//        configuration.background.backgroundColor = .yellow
        
        button.configuration = configuration
        button.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectOnMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(systemName: "map")
//        configuration.imagePadding = 4
//        configuration.background.backgroundColor = .red
        configuration.title = "Escolher no mapa"
        
        button.configuration = configuration
        button.addTarget(self, action: #selector(selectOnMapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var addLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .link
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 8
        configuration.title = "Adicionar"
        button.configuration = configuration
        button.addTarget(self, action: #selector(addLocationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var editLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Editar"
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        title = "Adicionar novo local"
        view.backgroundColor = .systemBackground
        view.addSubview(titleTextfield)
        view.addSubview(mapLocationImageView)
        view.addSubview(buttonActionStackView)
        view.addSubview(addLocationButton)
        view.addSubview(placeImageView)
        placeImageView.addSubview(editLabel)
        
        for view in [currentLocationButton, selectOnMapButton] {
            buttonActionStackView.addArrangedSubview(view)
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showBottomSheet))
        placeImageView.addGestureRecognizer(tapGesture)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            placeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeImageView.widthAnchor.constraint(equalToConstant: 100),
            placeImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleTextfield.heightAnchor.constraint(equalToConstant: 45),
            titleTextfield.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 20),
            titleTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mapLocationImageView.topAnchor.constraint(equalTo: titleTextfield.bottomAnchor, constant: 16),
            mapLocationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapLocationImageView.widthAnchor.constraint(equalToConstant: 350),
            mapLocationImageView.heightAnchor.constraint(equalToConstant: 200),
            
            buttonActionStackView.topAnchor.constraint(equalTo: mapLocationImageView.bottomAnchor, constant: 16),
            buttonActionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            buttonActionStackView.heightAnchor.constraint(equalToConstant: 45),
            buttonActionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            editLabel.bottomAnchor.constraint(equalTo: placeImageView.bottomAnchor),
            editLabel.leadingAnchor.constraint(equalTo: placeImageView.leadingAnchor),
            editLabel.trailingAnchor.constraint(equalTo: placeImageView.trailingAnchor),
            editLabel.heightAnchor.constraint(equalToConstant: 20),
            
            addLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addLocationButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc private func addLocationButtonTapped() {
        
    }
    
    @objc private func currentLocationButtonTapped() {
        Task {
            guard let location = locationManager.location?.coordinate else { return }
            
            do {
                let locationImageUrlString = try LocationService.shared.generateLocationPreviewImage(latitude: location.latitude, longitude: location.longitude)
                guard let locationImageUrl = URL(string: locationImageUrlString) else { return }
                
                mapLocationImageView.kf.setImage(with: locationImageUrl)
            } catch {
                print("Failed to generate location preview image: \(error)")
            }
        }
    }

    @objc private func selectOnMapButtonTapped() {
        let viewController = SelectMapViewController()
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc private func showBottomSheet() {
        let alert = UIAlertController(title: "Adicionar foto", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { [weak self] _ in
            self?.imageViewTapped(source: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { [weak self] _ in
            self?.imageViewTapped(source: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func imageViewTapped(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension NewPlaceFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextfield.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension NewPlaceFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            placeImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension NewPlaceFormViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.first {
            locationManager.stopUpdatingLocation()
        }
    }
}
