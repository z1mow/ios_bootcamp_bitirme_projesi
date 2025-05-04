//
//  SepetViewModels.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import Foundation

class SepetViewModels {
    
    private var sepetOgeleri: [SepetOgesi] = []
    
    var sepetGuncellendi: (() -> Void)?
    var hataOlustu: ((String) -> Void)?
    
    var sepetOgeSayisi: Int {
        return sepetOgeleri.count
    }
    
    func sepetOgeleriniYukle() {
        AgServisi.shared.sepettekiUrunleriGetir { [weak self] sonuc in
            guard let self = self else { return }
            
            switch sonuc {
            case .basarili(let sepetOgeleri):
                self.sepetOgeleri = sepetOgeleri
                self.sepetGuncellendi?()
                
            case .hatali(let hata):
                if let agHata = hata as? AgHatasi, agHata == AgHatasi.jsonCozumlemeHatasi {
                    self.sepetOgeleri = []
                    self.sepetGuncellendi?()
                } else {
                    self.hataOlustu?(hata.localizedDescription)
                }
            }
        }
    }
    
    func sepettenCikar(index: Int) {
        let sepetOge = sepetOgeleri[index]
        
        AgServisi.shared.sepettenCikar(sepetId: sepetOge.sepetId) { [weak self] sonuc in
            guard let self = self else { return }
            
            switch sonuc {
            case .basarili:
                self.sepetOgeleri.remove(at: index)
                self.sepetGuncellendi?()
                
            case .hatali(let hata):
                self.hataOlustu?(hata.localizedDescription)
            }
        }
    }
    
    func sepetOgesiGetir(index: Int) -> SepetOgesi {
        return sepetOgeleri[index]
    }
    
    func toplamTutarHesapla() -> Int {
        return sepetOgeleri.reduce(0) { $0 + ($1.fiyat * $1.siparisAdeti) }
    }
} 
