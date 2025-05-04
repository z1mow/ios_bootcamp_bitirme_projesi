//
//  UrunDetayViewController.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import UIKit

class UrunDetayViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let urunImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let urunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detayContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let favorileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 1.0)
        button.backgroundColor = UIColor(red: 0.97, green: 0.9, blue: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let urunAdiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let markaStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let markaBaslikLabel: UILabel = {
        let label = UILabel()
        label.text = "Marka:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let markaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ayiracCizgi: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fiyatBaslikLabel: UILabel = {
        let label = UILabel()
        label.text = "Fiyat"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fiyatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let adetBaslikLabel: UILabel = {
        let label = UILabel()
        label.text = "Adet"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let adetKontrolContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let adetAzaltButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let adetLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let adetArttirButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0), for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let toplamBaslikLabel: UILabel = {
        let label = UILabel()
        label.text = "Toplam"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toplamFiyatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sepeteEkleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sepete Ekle", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.shadowColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 0.3).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.8
        
        return button
    }()
    
    private let urun: Urun
    private var viewModel: UrunDetayViewModels!
    private var isFavorite = false
    
    init(urun: Urun) {
        self.urun = urun
        super.init(nibName: nil, bundle: nil)
        self.viewModel = UrunDetayViewModels(urun: urun)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        updateUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.navigationBar.topItem?.backButtonTitle = "Ürünler"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.tintColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(urunImageContainer)
        urunImageContainer.addSubview(urunImageView)
        
        contentView.addSubview(detayContainer)
        
        detayContainer.addSubview(urunAdiLabel)
        detayContainer.addSubview(favorileButton)
        
        markaStack.addArrangedSubview(markaBaslikLabel)
        markaStack.addArrangedSubview(markaLabel)
        detayContainer.addSubview(markaStack)
        
        detayContainer.addSubview(ayiracCizgi)
        detayContainer.addSubview(fiyatBaslikLabel)
        detayContainer.addSubview(fiyatLabel)
        
        detayContainer.addSubview(adetBaslikLabel)
        detayContainer.addSubview(adetKontrolContainer)
        
        adetKontrolContainer.addSubview(adetAzaltButton)
        adetKontrolContainer.addSubview(adetLabel)
        adetKontrolContainer.addSubview(adetArttirButton)
        
        detayContainer.addSubview(toplamBaslikLabel)
        detayContainer.addSubview(toplamFiyatLabel)
        
        detayContainer.addSubview(sepeteEkleButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            urunImageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            urunImageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            urunImageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            urunImageContainer.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            urunImageView.topAnchor.constraint(equalTo: urunImageContainer.topAnchor, constant: 16),
            urunImageView.leadingAnchor.constraint(equalTo: urunImageContainer.leadingAnchor, constant: 16),
            urunImageView.trailingAnchor.constraint(equalTo: urunImageContainer.trailingAnchor, constant: -16),
            urunImageView.bottomAnchor.constraint(equalTo: urunImageContainer.bottomAnchor, constant: -16),
            
            detayContainer.topAnchor.constraint(equalTo: urunImageContainer.bottomAnchor, constant: 16),
            detayContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detayContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detayContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            urunAdiLabel.topAnchor.constraint(equalTo: detayContainer.topAnchor, constant: 24),
            urunAdiLabel.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            urunAdiLabel.trailingAnchor.constraint(equalTo: favorileButton.leadingAnchor, constant: -16),
            
            favorileButton.topAnchor.constraint(equalTo: detayContainer.topAnchor, constant: 24),
            favorileButton.trailingAnchor.constraint(equalTo: detayContainer.trailingAnchor, constant: -24),
            favorileButton.widthAnchor.constraint(equalToConstant: 50),
            favorileButton.heightAnchor.constraint(equalToConstant: 50),
            
            markaStack.topAnchor.constraint(equalTo: urunAdiLabel.bottomAnchor, constant: 16),
            markaStack.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            markaStack.trailingAnchor.constraint(lessThanOrEqualTo: detayContainer.trailingAnchor, constant: -24),
            
            ayiracCizgi.topAnchor.constraint(equalTo: markaStack.bottomAnchor, constant: 16),
            ayiracCizgi.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            ayiracCizgi.trailingAnchor.constraint(equalTo: detayContainer.trailingAnchor, constant: -24),
            ayiracCizgi.heightAnchor.constraint(equalToConstant: 1),
            
            fiyatBaslikLabel.topAnchor.constraint(equalTo: ayiracCizgi.bottomAnchor, constant: 16),
            fiyatBaslikLabel.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            
            fiyatLabel.topAnchor.constraint(equalTo: fiyatBaslikLabel.bottomAnchor, constant: 8),
            fiyatLabel.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            
            adetBaslikLabel.topAnchor.constraint(equalTo: fiyatLabel.bottomAnchor, constant: 16),
            adetBaslikLabel.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            
            adetKontrolContainer.topAnchor.constraint(equalTo: adetBaslikLabel.bottomAnchor, constant: 8),
            adetKontrolContainer.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            adetKontrolContainer.widthAnchor.constraint(equalToConstant: 140),
            adetKontrolContainer.heightAnchor.constraint(equalToConstant: 40),
            
            adetAzaltButton.leadingAnchor.constraint(equalTo: adetKontrolContainer.leadingAnchor, constant: 10),
            adetAzaltButton.centerYAnchor.constraint(equalTo: adetKontrolContainer.centerYAnchor),
            adetAzaltButton.widthAnchor.constraint(equalToConstant: 40),
            adetAzaltButton.heightAnchor.constraint(equalToConstant: 40),
            
            adetLabel.centerXAnchor.constraint(equalTo: adetKontrolContainer.centerXAnchor),
            adetLabel.centerYAnchor.constraint(equalTo: adetKontrolContainer.centerYAnchor),
            adetLabel.widthAnchor.constraint(equalToConstant: 40),
            
            adetArttirButton.trailingAnchor.constraint(equalTo: adetKontrolContainer.trailingAnchor, constant: -10),
            adetArttirButton.centerYAnchor.constraint(equalTo: adetKontrolContainer.centerYAnchor),
            adetArttirButton.widthAnchor.constraint(equalToConstant: 40),
            adetArttirButton.heightAnchor.constraint(equalToConstant: 40),
            
            toplamBaslikLabel.topAnchor.constraint(equalTo: adetKontrolContainer.bottomAnchor, constant: 24),
            toplamBaslikLabel.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            
            toplamFiyatLabel.centerYAnchor.constraint(equalTo: toplamBaslikLabel.centerYAnchor),
            toplamFiyatLabel.trailingAnchor.constraint(equalTo: detayContainer.trailingAnchor, constant: -24),
            
            sepeteEkleButton.topAnchor.constraint(equalTo: toplamBaslikLabel.bottomAnchor, constant: 24),
            sepeteEkleButton.leadingAnchor.constraint(equalTo: detayContainer.leadingAnchor, constant: 24),
            sepeteEkleButton.trailingAnchor.constraint(equalTo: detayContainer.trailingAnchor, constant: -24),
            sepeteEkleButton.heightAnchor.constraint(equalToConstant: 50),
            sepeteEkleButton.bottomAnchor.constraint(equalTo: detayContainer.bottomAnchor, constant: -24)
        ])
        
        adetAzaltButton.addTarget(self, action: #selector(adetAzaltButtonTapped), for: .touchUpInside)
        adetArttirButton.addTarget(self, action: #selector(adetArttirButtonTapped), for: .touchUpInside)
        sepeteEkleButton.addTarget(self, action: #selector(sepeteEkleButtonTapped), for: .touchUpInside)
        favorileButton.addTarget(self, action: #selector(favorileButtonTapped), for: .touchUpInside)
        
        addButtonPressAnimation(to: adetAzaltButton)
        addButtonPressAnimation(to: adetArttirButton)
        addButtonPressAnimation(to: sepeteEkleButton)
        addButtonPressAnimation(to: favorileButton)
    }
    
    private func addButtonPressAnimation(to button: UIButton) {
        button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    @objc private func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    private func setupBindings() {
        viewModel.adetDegisti = { [weak self] adet in
            DispatchQueue.main.async {
                self?.adetLabel.text = "\(adet)"
                self?.toplamFiyatGuncelle()
            }
        }
        
        viewModel.sepeteEklemeBasarili = { [weak self] in
            DispatchQueue.main.async {
                self?.basariMesajiGoster("Ürün sepete eklendi")
            }
        }
        
        viewModel.hataOlustu = { [weak self] hataMesaji in
            DispatchQueue.main.async {
                self?.hataMesajiGoster(hataMesaji)
            }
        }
    }
    
    private func updateUI() {
        title = urun.ad
        
        urunAdiLabel.text = urun.ad
        markaLabel.text = urun.marka
        fiyatLabel.text = "₺\(urun.fiyat)"
        
        favorileButton.isSelected = urun.favori ?? false
        
        toplamFiyatGuncelle()
        
        if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(urun.resim)") {
            resimYukle(from: url)
        }
    }
    
    private func toplamFiyatGuncelle() {
        let toplamFiyat = viewModel.toplamFiyatHesapla()
        toplamFiyatLabel.text = "₺\(toplamFiyat)"
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
    
    @objc private func adetAzaltButtonTapped() {
        viewModel.adetAzalt()
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    @objc private func adetArttirButtonTapped() {
        viewModel.adetArttir()
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    @objc private func favorileButtonTapped() {
        favorileButton.isSelected.toggle()
        UIView.animate(withDuration: 0.1, animations: {
            self.favorileButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.favorileButton.transform = CGAffineTransform.identity
            }
        }
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    @objc private func sepeteEkleButtonTapped() {
        viewModel.sepeteEkle()
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    private func hataMesajiGoster(_ mesaj: String) {
        let alert = UIAlertController(title: "Hata", message: mesaj, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    private func basariMesajiGoster(_ mesaj: String) {
        let alert = UIAlertController(title: "✓ Başarılı", message: mesaj, preferredStyle: .alert)
        alert.view.tintColor = UIColor(red: 0.0, green: 0.6, blue: 0.3, alpha: 1.0)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}
