//
//  PacotesViagensViewController.swift
//  AluraViagens
//
//  Created by Lorena Rodrigues Bruno on 25/09/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class PacotesViagensViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UISearchBarDelegate {
    

    @IBOutlet weak var colecaoPacotesViagem: UICollectionView!
    
    @IBOutlet weak var pesquisarViagens: UISearchBar!
    
    @IBOutlet weak var labelContadorPacotes: UILabel!
    
    let listaComTodasViagens: Array<PacoteViagem> = PacoteViagemDAO().retornaTodasAsViagens()
    var listaViagens: Array<PacoteViagem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaViagens = listaComTodasViagens
        colecaoPacotesViagem.dataSource = self
        colecaoPacotesViagem.delegate = self
        pesquisarViagens.delegate = self
        self.labelContadorPacotes.text = self.atualizaContadorLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listaViagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacoteViagemCollectionViewCell
        let pacoteAtual = listaViagens[indexPath.row]
        celulaPacote.configuraCelula(pacoteViagem: pacoteAtual)
        return celulaPacote
    }
    
    
    //método que ajusta o tamanho da célula de acordo com o tamanho da tela
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pacote = listaViagens[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesVIagensViewController
        controller.pacoteSelecionado = pacote        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listaViagens = listaComTodasViagens
        if searchText != "" {
            //let filtroListaViagem = NSPredicate(format: "titulo contains[c] %@", searchText) //verifica se a busca do usuário está contida no título de alguma viagem
            let filtroListaViagem = NSPredicate(block: { (_ obj:Any?, _ modifier: [String: Any]?) -> Bool in
                guard let obj=obj as? Viagem else {
                    return true
                }
                return obj.titulo.contains(searchText)
            })
            let listaFiltrada: Array<PacoteViagem> = (listaViagens as NSArray).filtered(using: filtroListaViagem) as! Array
            listaViagens = listaFiltrada

        }	
        self.labelContadorPacotes.text = self.atualizaContadorLabel()
        colecaoPacotesViagem.reloadData()

    }
    
    func atualizaContadorLabel() -> String {
        return listaViagens.count == 1 ? "1 pacote encontrado" : "\(listaViagens.count) pacotes encontrados "
    }
}

