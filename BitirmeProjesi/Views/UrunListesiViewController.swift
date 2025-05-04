//
//  UrunListesiViewController.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 28.04.2025.
//

import UIKit

class UrunListesiViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UrunHucresi.self, forCellWithReuseIdentifier: "UrunHucresi")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let viewModel: UrunListesiViewModels
    private let sadeceFavoriler: Bool
    
    init(sadeceFavoriler: Bool = false) {
        self.sadeceFavoriler = sadeceFavoriler
        self.viewModel = UrunListesiViewModels(sadeceFavoriler: sadeceFavoriler)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.sadeceFavoriler = false
        self.viewModel = UrunListesiViewModels()
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
        setupBindings()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.urunleriYukle()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = sadeceFavoriler ? "Favorilerim" : "Ürünler"
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
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0)
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Ürün Ara"
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(red: 0.0, green: 0.4, blue: 0.9, alpha: 1.0)
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupBindings() {
        viewModel.urunlerYuklendi = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.collectionView.reloadData()
                
                self?.animateCollectionViewCells()
            }
        }
        
        viewModel.hataOlustu = { [weak self] hataMesaji in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.hataMesajiGoster(hataMesaji)
            }
        }
    }
    
    private func animateCollectionViewCells() {
        let cells = collectionView.visibleCells
        for (index, cell) in cells.enumerated() {
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: 50)
            
            UIView.animate(
                withDuration: 0.4,
                delay: 0.05 * Double(index),
                options: [.curveEaseInOut],
                animations: {
                    cell.alpha = 1
                    cell.transform = CGAffineTransform.identity
                }
            )
        }
    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        viewModel.urunleriYukle()
    }
    
    private func hataMesajiGoster(_ mesaj: String) {
        let alert = UIAlertController(title: "Hata", message: mesaj, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    private func urunDetayiniGoster(urun: Urun) {
        let detayVC = UrunDetayViewController(urun: urun)
        navigationController?.pushViewController(detayVC, animated: true)
    }
    
    private func basariMesajiGoster(_ mesaj: String) {
        let alert = UIAlertController(title: "Başarılı", message: mesaj, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    private func hizliSepeteEkle(urun: Urun, adet: Int) {
        viewModel.sepeteEkle(urun: urun, adet: adet)
        
        let toastContainer = UIView(frame: CGRect(x: view.frame.width/2 - 120, y: view.frame.height - 130, width: 240, height: 50))
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastContainer.layer.cornerRadius = 25
        toastContainer.clipsToBounds = true
        toastContainer.alpha = 0
        
        let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        checkmarkImageView.tintColor = .white
        checkmarkImageView.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        
        let toastLabel = UILabel(frame: CGRect(x: 45, y: 0, width: 180, height: 50))
        toastLabel.textColor = .white
        toastLabel.text = "Sepete eklendi"
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        toastContainer.addSubview(checkmarkImageView)
        toastContainer.addSubview(toastLabel)
        view.addSubview(toastContainer)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            toastContainer.alpha = 1
            toastContainer.transform = CGAffineTransform(translationX: 0, y: -20)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseIn, animations: {
                toastContainer.alpha = 0
                toastContainer.transform = CGAffineTransform.identity
            }, completion: { _ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}

extension UrunListesiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.urunSayisi
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UrunHucresi", for: indexPath) as? UrunHucresi else {
            return UICollectionViewCell()
        }
        
        let urun = viewModel.urunGetir(index: indexPath.item)
        cell.configure(with: urun)
        
        cell.sepeteEkleButtonHandler = { [weak self] in
            guard let self = self else { return }
            self.hizliSepeteEkle(urun: urun, adet: 1)
        }
        
        cell.favorileButtonHandler = { [weak self] in
            self?.viewModel.favoriyeEkleCikar(urunId: urun.id)
        }
        
        return cell
    }
}

extension UrunListesiViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urun = viewModel.urunGetir(index: indexPath.item)
        urunDetayiniGoster(urun: urun)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

extension UrunListesiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 * 2 + 16
        let availableWidth = collectionView.bounds.width - padding
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: 220)
    }
}

extension UrunListesiViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.urunleriFiltrele(aramaMetni: searchText)
    }
}

