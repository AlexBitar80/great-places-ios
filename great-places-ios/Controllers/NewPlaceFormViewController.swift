import UIKit

class NewPlaceFormViewController: UIViewController {

    // MARK: - Properties
    
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
        imageView.contentMode = .scaleAspectFill
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
        configuration.image = UIImage(systemName: "mappin")
        configuration.imagePadding = 8
        configuration.title = "Localização atual"
        
        button.configuration = configuration
        button.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectOnMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "map")
        configuration.imagePadding = 8
        configuration.title = "Selecionar no mapa"
        
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
    
    // MARK: - Helpers
    
    private func configureUI() {
        title = "New Place Form"
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
    
    @objc private func addLocationButtonTapped() {}
    
    @objc private func currentLocationButtonTapped() {}
    
    @objc private func selectOnMapButtonTapped() {}
    
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
            print(selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
