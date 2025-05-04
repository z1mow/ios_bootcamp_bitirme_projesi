//
//  UrunDetayViewModels.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import Foundation

class UrunDetayViewModels {
    
    private let urun: Urun
    private var adet: Int = 1
    
    var adetDegisti: ((Int) -> Void)?
    var sepeteEklemeBasarili: (() -> Void)?
    var hataOlustu: ((String) -> Void)?

    init(urun: Urun) {
        self.urun = urun
    }
    
    func adetArttir() {
        adet += 1
        adetDegisti?(adet)
    }
    
    func adetAzalt() {
        if adet > 1 {
            adet -= 1
            adetDegisti?(adet)
        }
    }
    
    func adetAyarla(adet: Int) {
        if adet > 0 {
            self.adet = adet
            adetDegisti?(adet)
        }
    }
    
    func toplamFiyatHesapla() -> Int {
        return urun.fiyat * adet
    }
    
    func sepeteEkle() {
        AgServisi.shared.sepeteEkle(urun: urun, adet: adet) { [weak self] sonuc in
            guard let self = self else { return }
            
            switch sonuc {
            case .basarili:
                self.sepeteEklemeBasarili?()
                
            case .hatali(let hata):
                self.hataOlustu?(hata.localizedDescription)
            }
        }
    }
    
    func getUrun() -> Urun {
        return urun
    }
    
    func getAdet() -> Int {
        return adet
    }
} 
