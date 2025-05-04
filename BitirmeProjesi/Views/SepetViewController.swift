//
//  SepetViewController.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import UIKit

class SepetViewController: UIViewController {
    
    // MARK: - UI Bileşenleri
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none // Ayırıcı çizgileri kaldır
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0) // Hafif gri arka plan
        tableView.register(SepetOgesiHucresi.self, forCellReuseIdentifier: "SepetOgesiHucresi")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false // Scroll göstergesini gizle
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0) // İçerik kenar boşluğu ekle
        tableView.layer.cornerRadius = 12 // Köşeleri yuvarla
        return tableView
    }()
    
    private let altPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 12
        view.layer.cornerRadius = 24 // Yukarıdaki köşeleri yuvarla
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Sadece üst köşeleri yuvarla
        
        // Arka plana hafif bir gradiend ekle
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(red: 0.98, green: 0.98, blue: 1.0, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
        gradientLayer.cornerRadius = 24
        gradientLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tutarlarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0)
        view.layer.cornerRadius = 16
        
        // Görsel ilgiyi artırmak için hafif bir border ekle
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.95, alpha: 1.0).cgColor
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let urunTutariLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor.darkGray
        label.text = "Ürün Tutarı:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let urunTutariDegerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor.darkGray
        label.text = "₺0"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kargoTutariLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor.darkGray
        label.text = "Kargo Ücreti:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kargoTutariDegerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor.darkGray
        label.text = "₺0"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ayiracCizgi: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let toplamTutarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.text = "Toplam:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toplamTutarDegerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0) // Mavi ton
        label.text = "₺0"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let siparisOnaylaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Siparişi Onayla", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0) // Mavi ton
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        
        // Gradient arka planı oluştur
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.1, green: 0.5, blue: 1.0, alpha: 1.0).cgColor, 
            UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 52)
        gradientLayer.cornerRadius = 16
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bostaSepetView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0) // Hafif gri arka plan
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bostaSepetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cart")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bostaSepetLabel: UILabel = {
        let label = UILabel()
        label.text = "Sepetiniz boş"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bostaSepetAltLabel: UILabel = {
        let label = UILabel()
        label.text = "Hemen alışverişe başlayın ve sepetinizi doldurun"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alisverisButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Alışverişe Başla", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0) // Mavi ton
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        
        // Gradient arka planı oluştur
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.1, green: 0.5, blue: 1.0, alpha: 1.0).cgColor, 
            UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 52)
        gradientLayer.cornerRadius = 16
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0) // Mavi ton
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Properties
    private let viewModel = SepetViewModels()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sepetOgeleriniYukle()
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentSizeGuncelle()
    }
    
    // MARK: - UI Setup
    private func setupNavigationBar() {
        title = "Sepetim"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32, weight: .bold)
        ]
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0) // Hafif gri arka plan
        
        // TableView setup
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tableView)
        view.addSubview(altPanel)
        
        altPanel.addSubview(tutarlarContainerView)
        
        tutarlarContainerView.addSubview(urunTutariLabel)
        tutarlarContainerView.addSubview(urunTutariDegerLabel)
        tutarlarContainerView.addSubview(kargoTutariLabel)
        tutarlarContainerView.addSubview(kargoTutariDegerLabel)
        tutarlarContainerView.addSubview(ayiracCizgi)
        tutarlarContainerView.addSubview(toplamTutarLabel)
        tutarlarContainerView.addSubview(toplamTutarDegerLabel)
        
        altPanel.addSubview(siparisOnaylaButton)
        
        view.addSubview(bostaSepetView)
        bostaSepetView.addSubview(bostaSepetImageView)
        bostaSepetView.addSubview(bostaSepetLabel)
        bostaSepetView.addSubview(bostaSepetAltLabel)
        bostaSepetView.addSubview(alisverisButton)
        
        view.addSubview(activityIndicator)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: altPanel.topAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Table View'in contentView içinde görünmesini sağla
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Alt panelin ekranın en altında sabit kalmasını sağla
            altPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            altPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            altPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            altPanel.heightAnchor.constraint(equalToConstant: 220),
            
            tutarlarContainerView.topAnchor.constraint(equalTo: altPanel.topAnchor, constant: 20),
            tutarlarContainerView.leadingAnchor.constraint(equalTo: altPanel.leadingAnchor, constant: 20),
            tutarlarContainerView.trailingAnchor.constraint(equalTo: altPanel.trailingAnchor, constant: -20),
            tutarlarContainerView.heightAnchor.constraint(equalToConstant: 120),
            
            urunTutariLabel.topAnchor.constraint(equalTo: tutarlarContainerView.topAnchor, constant: 15),
            urunTutariLabel.leadingAnchor.constraint(equalTo: tutarlarContainerView.leadingAnchor, constant: 15),
            
            urunTutariDegerLabel.topAnchor.constraint(equalTo: tutarlarContainerView.topAnchor, constant: 15),
            urunTutariDegerLabel.trailingAnchor.constraint(equalTo: tutarlarContainerView.trailingAnchor, constant: -15),
            
            kargoTutariLabel.topAnchor.constraint(equalTo: urunTutariLabel.bottomAnchor, constant: 10),
            kargoTutariLabel.leadingAnchor.constraint(equalTo: tutarlarContainerView.leadingAnchor, constant: 15),
            
            kargoTutariDegerLabel.topAnchor.constraint(equalTo: urunTutariDegerLabel.bottomAnchor, constant: 10),
            kargoTutariDegerLabel.trailingAnchor.constraint(equalTo: tutarlarContainerView.trailingAnchor, constant: -15),
            
            ayiracCizgi.topAnchor.constraint(equalTo: kargoTutariLabel.bottomAnchor, constant: 12),
            ayiracCizgi.leadingAnchor.constraint(equalTo: tutarlarContainerView.leadingAnchor, constant: 15),
            ayiracCizgi.trailingAnchor.constraint(equalTo: tutarlarContainerView.trailingAnchor, constant: -15),
            ayiracCizgi.heightAnchor.constraint(equalToConstant: 1),
            
            toplamTutarLabel.topAnchor.constraint(equalTo: ayiracCizgi.bottomAnchor, constant: 12),
            toplamTutarLabel.leadingAnchor.constraint(equalTo: tutarlarContainerView.leadingAnchor, constant: 15),
            
            toplamTutarDegerLabel.topAnchor.constraint(equalTo: ayiracCizgi.bottomAnchor, constant: 12),
            toplamTutarDegerLabel.trailingAnchor.constraint(equalTo: tutarlarContainerView.trailingAnchor, constant: -15),
            
            siparisOnaylaButton.topAnchor.constraint(equalTo: tutarlarContainerView.bottomAnchor, constant: 16),
            siparisOnaylaButton.leadingAnchor.constraint(equalTo: altPanel.leadingAnchor, constant: 16),
            siparisOnaylaButton.trailingAnchor.constraint(equalTo: altPanel.trailingAnchor, constant: -16),
            siparisOnaylaButton.heightAnchor.constraint(equalToConstant: 52),
            
            bostaSepetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bostaSepetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bostaSepetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bostaSepetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bostaSepetImageView.centerXAnchor.constraint(equalTo: bostaSepetView.centerXAnchor),
            bostaSepetImageView.centerYAnchor.constraint(equalTo: bostaSepetView.centerYAnchor, constant: -80),
            bostaSepetImageView.widthAnchor.constraint(equalToConstant: 120),
            bostaSepetImageView.heightAnchor.constraint(equalToConstant: 120),
            
            bostaSepetLabel.topAnchor.constraint(equalTo: bostaSepetImageView.bottomAnchor, constant: 16),
            bostaSepetLabel.centerXAnchor.constraint(equalTo: bostaSepetView.centerXAnchor),
            bostaSepetLabel.leadingAnchor.constraint(equalTo: bostaSepetView.leadingAnchor, constant: 20),
            bostaSepetLabel.trailingAnchor.constraint(equalTo: bostaSepetView.trailingAnchor, constant: -20),
            
            bostaSepetAltLabel.topAnchor.constraint(equalTo: bostaSepetLabel.bottomAnchor, constant: 8),
            bostaSepetAltLabel.centerXAnchor.constraint(equalTo: bostaSepetView.centerXAnchor),
            bostaSepetAltLabel.leadingAnchor.constraint(equalTo: bostaSepetView.leadingAnchor, constant: 40),
            bostaSepetAltLabel.trailingAnchor.constraint(equalTo: bostaSepetView.trailingAnchor, constant: -40),
            
            alisverisButton.topAnchor.constraint(equalTo: bostaSepetAltLabel.bottomAnchor, constant: 30),
            alisverisButton.centerXAnchor.constraint(equalTo: bostaSepetView.centerXAnchor),
            alisverisButton.widthAnchor.constraint(equalToConstant: 200),
            alisverisButton.heightAnchor.constraint(equalToConstant: 52),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Add button actions with animation
        siparisOnaylaButton.addTarget(self, action: #selector(siparisOnaylaButtonTapped), for: .touchUpInside)
        alisverisButton.addTarget(self, action: #selector(alisverisButtonTapped), for: .touchUpInside)
        
        // Buton basma animasyonu ekle
        addButtonPressAnimation(to: siparisOnaylaButton)
        addButtonPressAnimation(to: alisverisButton)
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
        viewModel.sepetGuncellendi = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
                self?.toplamTutarGuncelle()
                self?.durumGuncelle()
                self?.contentSizeGuncelle()
            }
        }
        
        viewModel.hataOlustu = { [weak self] hataMesaji in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.hataMesajiGoster(hataMesaji)
            }
        }
    }
    
    private func sepetOgeleriniYukle() {
        activityIndicator.startAnimating()
        viewModel.sepetOgeleriniYukle()
    }
    
    private func toplamTutarGuncelle() {
        let toplamTutar = viewModel.toplamTutarHesapla()
        urunTutariDegerLabel.text = "₺\(toplamTutar)"
        
        let kargoUcreti = 0
        kargoTutariDegerLabel.text = "₺\(kargoUcreti)"
        
        let genelToplam = toplamTutar + kargoUcreti
        toplamTutarDegerLabel.text = "₺\(genelToplam)"
        
        // Animasyonlu guncelleme yap
        UIView.animate(withDuration: 0.3) {
            self.toplamTutarDegerLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.toplamTutarDegerLabel.transform = CGAffineTransform.identity
            }
        }
    }
    
    private func durumGuncelle() {
        let sepetBos = viewModel.sepetOgeSayisi == 0
        
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.scrollView.isHidden = sepetBos
            self.altPanel.isHidden = sepetBos
            self.bostaSepetView.isHidden = !sepetBos
        }, completion: nil)
    }
    
    private func hataMesajiGoster(_ mesaj: String) {
        let alert = UIAlertController(title: "Hata", message: mesaj, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    @objc private func siparisOnaylaButtonTapped() {
        // Sepet boşsa işlem yapma
        if viewModel.sepetOgeSayisi == 0 {
            let alert = UIAlertController(title: "Hata", message: "Sepetiniz boş", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Sipariş onaylama işlemleri - modernize edilmiş başarı bildirimi
        let alert = UIAlertController(title: "Başarılı!", message: "Siparişiniz onaylandı", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func alisverisButtonTapped() {
        // Ürünler sayfasına geçiş animasyonlu
        UIView.animate(withDuration: 0.2, animations: {
            self.alisverisButton.alpha = 0.7
        }) { (_) in
            UIView.animate(withDuration: 0.2, animations: {
                self.alisverisButton.alpha = 1.0
            })
            self.tabBarController?.selectedIndex = 0 // İlk tab'a geç (Ürünler)
        }
    }
}

// MARK: - UITableViewDataSource
extension SepetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sepetOgeSayisi
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SepetOgesiHucresi", for: indexPath) as? SepetOgesiHucresi else {
            return UITableViewCell()
        }
        
        let sepetOge = viewModel.sepetOgesiGetir(index: indexPath.row)
        cell.configure(with: sepetOge)
        
        cell.silButtonHandler = { [weak self] in
            // Silme işlemi animasyonlu
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
                cell.alpha = 0
            }) { (_) in
                self?.viewModel.sepettenCikar(index: indexPath.row)
            }
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SepetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Hücre animasyonu
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(withDuration: 0.3, delay: 0.05 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    // TableView yüksekliğinin içeriğe göre ayarlanması için
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // TableView yüksekliğini içeriğe göre ayarla
        self.contentSizeGuncelle()
    }
}

// MARK: - Ek Fonksiyonlar
extension SepetViewController {
    // ContentView boyutunu tableView içeriğine göre ayarla
    private func contentSizeGuncelle() {
        // TableView'ın içeriğine göre contentView'ın yüksekliğini ayarla
        if viewModel.sepetOgeSayisi > 0 {
            let contentHeight = CGFloat(viewModel.sepetOgeSayisi) * 120 + 40 // 120: hücre yüksekliği, 40: ekstra boşluk
            let minimumHeight = scrollView.frame.height
            
            // ContentView'ın yüksekliğini ayarla (en az scrollView kadar yüksek olsun)
            let newHeight = max(contentHeight, minimumHeight)
            
            // ContentView'ın yükseklik constraint'ini güncelle
            NSLayoutConstraint.activate([
                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: newHeight)
            ])
            
            contentView.layoutIfNeeded()
        }
    }
}
