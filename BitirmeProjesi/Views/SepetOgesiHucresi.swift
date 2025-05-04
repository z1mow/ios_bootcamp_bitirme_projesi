//
//  SepetOgesiHucresi.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import UIKit

class SepetOgesiHucresi: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let urunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0)
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let urunAdiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let markaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fiyatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0) // Mavi ton
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let adetContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0) // Hafif gri
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let adetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let silButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 1.0) // Kırmızı ton
        button.backgroundColor = UIColor(red: 0.97, green: 0.9, blue: 0.9, alpha: 1.0) // Hafif kırmızı arka plan
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var silButtonHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        adetLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            UIView.animate(withDuration: 0.2) {
                self.containerView.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.containerView.transform = CGAffineTransform.identity
            }
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            UIView.animate(withDuration: 0.2) {
                self.containerView.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.containerView.transform = CGAffineTransform.identity
            }
        }
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(urunImageView)
        containerView.addSubview(urunAdiLabel)
        containerView.addSubview(markaLabel)
        containerView.addSubview(fiyatLabel)
        containerView.addSubview(adetContainer)
        adetContainer.addSubview(adetLabel)
        containerView.addSubview(silButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            urunImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            urunImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            urunImageView.widthAnchor.constraint(equalToConstant: 80),
            urunImageView.heightAnchor.constraint(equalToConstant: 80),
            
            urunAdiLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            urunAdiLabel.leadingAnchor.constraint(equalTo: urunImageView.trailingAnchor, constant: 12),
            urunAdiLabel.trailingAnchor.constraint(equalTo: silButton.leadingAnchor, constant: -12),
            
            markaLabel.topAnchor.constraint(equalTo: urunAdiLabel.bottomAnchor, constant: 4),
            markaLabel.leadingAnchor.constraint(equalTo: urunImageView.trailingAnchor, constant: 12),
            markaLabel.trailingAnchor.constraint(equalTo: silButton.leadingAnchor, constant: -12),
            
            fiyatLabel.topAnchor.constraint(equalTo: markaLabel.bottomAnchor, constant: 8),
            fiyatLabel.leadingAnchor.constraint(equalTo: urunImageView.trailingAnchor, constant: 12),
            
            adetContainer.centerYAnchor.constraint(equalTo: fiyatLabel.centerYAnchor),
            adetContainer.leadingAnchor.constraint(equalTo: fiyatLabel.trailingAnchor, constant: 12),
            adetContainer.widthAnchor.constraint(equalToConstant: 80),
            adetContainer.heightAnchor.constraint(equalToConstant: 28),
            
            adetLabel.centerYAnchor.constraint(equalTo: adetContainer.centerYAnchor),
            adetLabel.centerXAnchor.constraint(equalTo: adetContainer.centerXAnchor),
            adetLabel.leadingAnchor.constraint(equalTo: adetContainer.leadingAnchor, constant: 4),
            adetLabel.trailingAnchor.constraint(equalTo: adetContainer.trailingAnchor, constant: -4),
            
            silButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            silButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            silButton.widthAnchor.constraint(equalToConstant: 40),
            silButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        silButton.addTarget(self, action: #selector(silButtonTapped), for: .touchUpInside)
        
        silButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        silButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    @objc private func buttonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.silButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc private func buttonTouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.silButton.transform = CGAffineTransform.identity
        }
    }
    
    func configure(with sepetOge: SepetOgesi) {
        urunAdiLabel.text = sepetOge.ad
        markaLabel.text = sepetOge.marka
        fiyatLabel.text = "₺\(sepetOge.fiyat)"
        adetLabel.text = "\(sepetOge.siparisAdeti) adet"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(sepetOge.resim)") {
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
    
    @objc private func silButtonTapped() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        
        silButtonHandler?()
    }
}
