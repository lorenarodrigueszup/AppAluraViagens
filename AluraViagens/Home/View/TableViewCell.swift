//
//  TableViewCell.swift
//  AluraViagens
//
//  Created by Lorena Rodrigues Bruno on 25/09/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

   
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelQantidadeDias: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var imagemViagem: UIImageView!
    
    
    func configuraCelula(viagem: Viagem) {
        labelTitulo.text = viagem.titulo
        labelQantidadeDias.text = viagem.quantidadeDeDias == 1 ? "1 dia" : "\(viagem.quantidadeDeDias) dias"
        labelPreco.text = "R$ \(viagem.preco)"
        imagemViagem.image = UIImage(named: viagem.caminhoDaImagem)
        
        imagemViagem.layer.cornerRadius = 10 //bordas arredondadas
        imagemViagem.layer.masksToBounds = true //bordas arredondadas
    }
}
