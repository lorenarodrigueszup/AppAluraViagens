//
//  DetalhesVIagensViewController.swift
//  AluraViagens
//
//  Created by Lorena Rodrigues Bruno on 26/09/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class DetalhesVIagensViewController: UIViewController {

    @IBOutlet weak var imagemPacoteViagem: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    @IBOutlet weak var labelDescricaoPacoteViagem: UILabel!
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    @IBOutlet weak var labelPrecoPacoteViagem: UILabel!
    @IBOutlet weak var textFieldData: UITextField!
    
    @IBOutlet weak var scrollPrincipal: UIScrollView!
    
    var pacoteSelecionado: PacoteViagem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(aumentaScroll(notification:)), name: .UIKeyboardWillShow, object: nil)
        if let pacote = pacoteSelecionado {
            self.imagemPacoteViagem.image = UIImage(named: pacote.viagem.caminhoDaImagem)
            self.labelTituloPacoteViagem.text = pacote.viagem.titulo
            self.labelDescricaoPacoteViagem.text = pacote.descricao
            self.labelQuantidadeDias.text = "\(pacote.viagem.quantidadeDeDias) dias"
            self.labelDataViagem.text = "válido para o periodo de: \(pacote.dataViagem)"
            self.labelPrecoPacoteViagem.text = "\(pacote.viagem.preco)"
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func aumentaScroll(notification: Notification) {
        self.scrollPrincipal.contentSize = CGSize(width: self.scrollPrincipal.frame.width, height: self.scrollPrincipal.frame.height + 320)
    }
    
    @objc func exibeDataTextField(sender: UIDatePicker) {
        let formatador = DateFormatter()
        formatador.dateFormat = "dd MM yyyy"
        self.textFieldData.text = formatador.string(from: sender.date)
    }
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textFieldEntrouFoco(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(exibeDataTextField(sender:)), for: .valueChanged)
    }
    
    @IBAction func botaoFinalizarCompra(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "confirmacaoPagamento") as! ConfirmacaoPagamentoViewController
        controller.pacoteComprado = pacoteSelecionado
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
