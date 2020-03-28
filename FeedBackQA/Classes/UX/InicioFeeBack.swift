//
//  InicioViewController.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import UIKit

class InicioFeeBack: UIViewController {
    
    @IBOutlet var btnEnviar: FBQAButton!
    @IBOutlet var btnCancelar: FBQAButton!
    @IBOutlet var img1: UIImageView!
    @IBOutlet var viewContent: UIView!
    
    @IBOutlet var lblModelo: UILabel!
    @IBOutlet var lblversion: UILabel!
    @IBOutlet var lblVerisonSO: UILabel!
    @IBOutlet var lblFechae: UILabel!
    @IBOutlet var lblError: UILabel!
    @IBOutlet var txtMensaje: UITextView!

    var vSpinner : UIView?
    var appid:String = ""
    var imgScreenshot:UIImage!
    var imgMarco:UIImage!
    var bug: BugModel = BugModel(
        id: UUID().uuidString,
        modelo: UIDevice.modelName,
        version: "",
        versionSO: UIDevice.current.systemVersion,
        fecha: "",
        mensaje: "",
        foto: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img1.image = imgScreenshot
        img1.layer.cornerRadius = 5
        img1.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        img1.layer.borderWidth = 1
        
        initModel()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initView(){
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        txtMensaje.layer.cornerRadius = 5
        txtMensaje.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        txtMensaje.layer.borderWidth = 1
        
        lblModelo.text = bug.modelo
        lblversion.text = bug.version
        lblVerisonSO.text = bug.versionSO
        lblFechae.text = bug.fecha
        
        txtMensaje.text = ""
        lblError.text = ""
    }
    
    func initModel(){
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let imageData:NSData = imgScreenshot.pngData()! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        
        let date = Date()
        let formatDate = Date.getFormattedDate(date: date, format: "yyyy-MM-dd HH:mm:ss")

        
        bug.version = appVersion ?? "NN"
        bug.foto = strBase64
        bug.fecha = formatDate
    }
    
    static func getController() -> InicioFeeBack {
        let storyboard = UIStoryboard.init(name: "MainFeedBack", bundle: Bundle(for: self))
        let homeVC = storyboard.instantiateViewController(withIdentifier: "InicioFeeBack") as! InicioFeeBack
        return homeVC
    }
    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enviarReporte(_ sender: Any) {
        bug.mensaje = txtMensaje.text
        lblError.text = ""
        self.view.endEditing(true)
        sendData()
    }
    
    @IBAction func cerrarTeclado(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.viewContent.frame.size.height = self.view.frame.size.height
            self.viewContent.frame.origin.y = 30
        }
    }

    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.viewContent.frame.size.height = 268
            self.viewContent.frame.origin.y = self.view.frame.size.height - 268
        }
    }
    
    
    func sendData(){
        showSpinner(onView: self.view)
        
        let url = URL(string: "https://feedback-qa-ce24d.firebaseio.com/\(appid)/ios/bugs/\(bug.id).json")
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(bug)
            request.httpBody = jsonData
        } catch {
            print("error coding")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.removeSpinner()
            if let error = error {
                self.mostrarRespuesta("Error al enviar le informe: \(error)", error: true)
                return
            }
     
            if let data = data, let _ = String(data: data, encoding: .utf8) {
                self.mostrarRespuesta()
            }
        }
        task.resume()
    }
    
    func mostrarRespuesta(_ mensaje:String = "", error:Bool = false){
        if error {
            lblError.text = mensaje
        }else{
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
}
