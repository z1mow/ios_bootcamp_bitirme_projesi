//
//  UrunHucresi.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import UIKit

class UrunHucresi: UICollectionViewCell {
    
    // MARK: - UI Bileşenleri
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let urunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0)
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Sadece üst köşeleri yuvarla
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favorileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 1.0)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let urunAdiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let markaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fiyatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sepeteEkleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
        button.backgroundColor = UIColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 1.0)
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    var sepeteEkleButtonHandler: (() -> Void)?
    var favorileButtonHandler: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        urunImageView.image = nil
        urunAdiLabel.text = nil
        markaLabel.text = nil
        fiyatLabel.text = nil
        favorileButton.isSelected = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Gradient arka plan ekle - bunu burada yapmalıyız çünkü frame değişebilir
        addGradientIfNeeded()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        // Add subviews
        contentView.addSubview(containerView)
        
        containerView.addSubview(urunImageView)
        containerView.addSubview(urunAdiLabel)
        containerView.addSubview(markaLabel)
        containerView.addSubview(fiyatLabel)
        containerView.addSubview(favorileButton)
        containerView.addSubview(sepeteEkleButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            urunImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            urunImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            urunImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            urunImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.55),
            
            favorileButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            favorileButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            favorileButton.widthAnchor.constraint(equalToConstant: 30),
            favorileButton.heightAnchor.constraint(equalToConstant: 30),
            
            urunAdiLabel.topAnchor.constraint(equalTo: urunImageView.bottomAnchor, constant: 12),
            urunAdiLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            urunAdiLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            markaLabel.topAnchor.constraint(equalTo: urunAdiLabel.bottomAnchor, constant: 4),
            markaLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            markaLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            fiyatLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            fiyatLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            sepeteEkleButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            sepeteEkleButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            sepeteEkleButton.widthAnchor.constraint(equalToConstant: 36),
            sepeteEkleButton.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        // Add button actions with animations
        favorileButton.addTarget(self, action: #selector(favorileButtonTapped), for: .touchUpInside)
        sepeteEkleButton.addTarget(self, action: #selector(sepeteEkleButtonTapped), for: .touchUpInside)
        
        // Add button press animations
        addButtonPressAnimation(to: favorileButton)
        addButtonPressAnimation(to: sepeteEkleButton)
    }
    
    private func addButtonPressAnimation(to button: UIButton) {
        button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    @objc private func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc private func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    private func addGradientIfNeeded() {
        // Layer TAG'i kontrol et - eğer zaten gradient varsa tekrar oluşturma
        if let layers = containerView.layer.sublayers, layers.contains(where: { $0.name == "gradientBackground" }) {
            return
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradientBackground"
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(red: 0.98, green: 0.98, blue: 1.0, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = containerView.bounds
        gradientLayer.cornerRadius = 20
        
        containerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Configuration
    func configure(with urun: Urun) {
        urunAdiLabel.text = urun.ad
        markaLabel.text = urun.marka
        fiyatLabel.text = "₺\(urun.fiyat)"
        
        // Favori durumunu güncelle
        favorileButton.isSelected = urun.favori ?? false
        
        if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(urun.resim)") {
            resimYukle(from: url)
        }
    }
    
    private func resimYukle(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Resim yükleme hatası: \(error?.localizedDescription ?? "Bilinmeyen hata")")
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    UIView.transition(with: self?.urunImageView ?? UIImageView(),
                                     duration: 0.3,
                                     options: .transitionCrossDissolve,
                                     animations: {
                        self?.urunImageView.image = image
                    }, completion: nil)
                }
            }
        }.resume()
    }
    
    // MARK: - Actions
    @objc private func favorileButtonTapped() {
        // Favori durumunu değiştirmeden önce tıklama animasyonu
        favorileButton.isSelected.toggle()
        
        // Daha yumuşak bir animasyon
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.favorileButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.favorileButton.transform = CGAffineTransform.identity
            }
        }
        
        // Haptik geri bildirim ekle
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        
        favorileButtonHandler?()
    }
    
    @objc private func sepeteEkleButtonTapped() {
        // Sepete ekle buton efekti
        UIView.animate(withDuration: 0.1, animations: {
            self.sepeteEkleButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.sepeteEkleButton.transform = CGAffineTransform.identity
            }
        }
        
        // Haptik geri bildirim ekle
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        
        sepeteEkleButtonHandler?()
    }
}
