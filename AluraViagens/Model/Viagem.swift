//
//  Viagem.swift
//  AluraViagens
//
//  Created by Lorena Rodrigues Bruno on 25/09/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

@objc class Viagem: NSObject {
    @objc let titulo: String
    let quantidadeDeDias: Int
    let preco: String
    let caminhoDaImagem: String
    
    init(titulo: String, quantidadeDeDias: Int, preco: String, caminhoDaImagem: String) {
        self.titulo = titulo
        self.quantidadeDeDias = quantidadeDeDias
        self.preco = preco
        self.caminhoDaImagem = caminhoDaImagem
    }
}
