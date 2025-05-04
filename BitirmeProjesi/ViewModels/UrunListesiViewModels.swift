//
//  UrunListesiViewModels.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import Foundation

class UrunListesiViewModels {
    
    private var urunler: [Urun] = []
    private var filtrelenmisUrunler: [Urun] = []
    private var filtrelemeAktif: Bool = false
    private var sadeceFavoriler: Bool = false
    
    private let userDefaults = UserDefaults.standard
    private let favorilerKey = "favoriler"
    
    var urunlerYuklendi: (() -> Void)?
    var hataOlustu: ((String) -> Void)?
    var sepeteEklemeBasarili: (() -> Void)?
    
    init(sadeceFavoriler: Bool = false) {
        self.sadeceFavoriler = sadeceFavoriler
    }
    
    var urunSayisi: Int {
        return filtrelemeAktif ? filtrelenmisUrunler.count : (sadeceFavoriler ? favoriUrunler().count : urunler.count)
    }
    
    func urunleriYukle() {
        AgServisi.shared.tumUrunleriGetir { [weak self] sonuc in
            guard let self = self else { return }
            
            switch sonuc {
            case .basarili(let urunler):
                self.urunler = urunler
                // Kayıtlı favorileri yükle
                self.favoriDurumuGuncelle()
                // Filtre var mı kontrol et
                if self.sadeceFavoriler {
                    self.filtrelenmisUrunler = self.favoriUrunler()
                } else {
                    self.filtrelenmisUrunler = urunler
                }
                self.urunlerYuklendi?()
                
            case .hatali(let hata):
                self.hataOlustu?(hata.localizedDescription)
            }
        }
    }
    
    func urunleriFiltrele(aramaMetni: String) {
        let kaynak = sadeceFavoriler ? favoriUrunler() : urunler
        
        if aramaMetni.isEmpty {
            filtrelemeAktif = false
            filtrelenmisUrunler = kaynak
        } else {
            filtrelemeAktif = true
            filtrelenmisUrunler = kaynak.filter { urun in
                return urun.ad.lowercased().contains(aramaMetni.lowercased()) ||
                       urun.kategori.lowercased().contains(aramaMetni.lowercased()) ||
                       urun.marka.lowercased().contains(aramaMetni.lowercased())
            }
        }
        urunlerYuklendi?()
    }
    
    func urunGetir(index: Int) -> Urun {
        if filtrelemeAktif {
            return filtrelenmisUrunler[index]
        } else if sadeceFavoriler {
            return favoriUrunler()[index]
        } else {
            return urunler[index]
        }
    }
    
    func favoriDurumuGuncelle() {
        // UserDefaults'tan favori ID'lerini al
        if let favoriIdleri = userDefaults.array(forKey: favorilerKey) as? [Int] {
            // Her ürünün favori durumunu güncelle
            for i in 0..<urunler.count {
                urunler[i].favori = favoriIdleri.contains(urunler[i].id)
            }
        }
    }
    
    func favoriUrunler() -> [Urun] {
        return urunler.filter { $0.favori == true }
    }
    
    func favoriyeEkle(urunId: Int) {
        var favoriIdleri = userDefaults.array(forKey: favorilerKey) as? [Int] ?? []
        
        if !favoriIdleri.contains(urunId) {
            favoriIdleri.append(urunId)
            userDefaults.set(favoriIdleri, forKey: favorilerKey)

            if let index = urunler.firstIndex(where: { $0.id == urunId }) {
                urunler[index].favori = true
            }
            
            urunlerYuklendi?()
        }
    }
    
    func favoridenCikar(urunId: Int) {
        var favoriIdleri = userDefaults.array(forKey: favorilerKey) as? [Int] ?? []

        if let index = favoriIdleri.firstIndex(of: urunId) {
            favoriIdleri.remove(at: index)
            userDefaults.set(favoriIdleri, forKey: favorilerKey)
            
            if let index = urunler.firstIndex(where: { $0.id == urunId }) {
                urunler[index].favori = false
            }
            
            urunlerYuklendi?()
        }
    }
    
    func favoriyeEkleCikar(urunId: Int) {
        let favoriIdleri = userDefaults.array(forKey: favorilerKey) as? [Int] ?? []
        
        if favoriIdleri.contains(urunId) {
            favoridenCikar(urunId: urunId)
        } else {
            favoriyeEkle(urunId: urunId)
        }
    }
    
    func sepeteEkle(urun: Urun, adet: Int) {
        let detayViewModel = UrunDetayViewModels(urun: urun)
        detayViewModel.adetAyarla(adet: adet)
        
        detayViewModel.sepeteEklemeBasarili = { [weak self] in
            self?.urunlerYuklendi?()
            self?.sepeteEklemeBasarili?()
        }
        
        detayViewModel.hataOlustu = { [weak self] hataMesaji in
            self?.hataOlustu?(hataMesaji)
        }
        
        detayViewModel.sepeteEkle()
    }
} 
