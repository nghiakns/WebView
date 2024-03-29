//
//  UrlDetailViewController.swift
//  WebView
//
//  Created by Kim Nghĩa on 08/03/2023.
//


import UIKit
import DropDown
enum SettingMode: Int {
    case autoload
}
class UrlDetailViewController: UIViewController, didSeclectImage {

    @IBOutlet weak var imageDropDownI: UIImageView!
    @IBOutlet weak var dropDownDomainButton: UIButton!
    @IBOutlet weak var IPView: UIView!
    @IBOutlet weak var IPDomainTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var paramTextfield: UITextField!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var accTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var dropDownHomeButton: UIButton!
    @IBOutlet weak var imageHome: UIImageView!
    @IBOutlet weak var domainView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var SwitchAutoLoadUrl: UISwitch!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var headerTitle: UILabel!
    
    var model: [ModelsUrl] = []
    let DropdownDomain = DropDown()
    let DropdownHome = DropDown()
    let urlSevices = ModelSevices()
    var imageIcon: UIImage?
    var index: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        imageDropDownI.setImageColor(color: UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1))
        imageHome.setImageColor(color: UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1))
        configEditController()
    }
    
    func didSeclectImage(image: UIImage) {
        self.iconImage.image = image
        imageIcon = image
    }
    
    private func configure() {
        deleteImage.isHidden = true
        deleteButton.isHidden = true
        addButton.setTitle("Add URL", for: .normal)
        headerView.backgroundColor = ResourceColor.headerView
        DropdownDomain.anchorView = dropDownDomainButton
        DropdownDomain.dataSource = DropdownData.dropdownDomain
        DropdownHome.anchorView = dropDownHomeButton
        let isLogin = WebViewUserDefault.getIsLogin()
        if isLogin {
            DropdownHome.dataSource = DropdownData.homeDropDownLogin
        } else {
            DropdownHome.dataSource = DropdownData.homeDropDown
        }
        dropDownDomainButton.layer.borderColor = UIColor.lightGray.cgColor
        dropDownDomainButton.layer.borderWidth = 1
        dropDownDomainButton.layer.cornerRadius = 4
        dropDownDomainButton.layer.masksToBounds = true
        IPView.layer.borderWidth = 1
        IPView.layer.cornerRadius = 25
        IPView.layer.masksToBounds = true
        homeView.layer.borderWidth = 1
        homeView.layer.cornerRadius = 25
        homeView.layer.masksToBounds = true
        addButton.layer.borderWidth = 1
        addButton.layer.cornerRadius = 25
        addButton.layer.masksToBounds = true
        domainView.layer.borderWidth = 1
        domainView.layer.cornerRadius = 25
        domainView.layer.masksToBounds = true
        coradius(textfield: nameTextfield)
        coradius(textfield: paramTextfield)
        coradius(textfield: passTextField)
        coradius(textfield: accTextfield)
        //nguyen
        dropDownDomainButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        DropdownDomain.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dropDownDomainButton.setTitle(item, for: .normal)
            WebViewUserDefault.saveDropdownProtocols(item: item.getDomain())
        }
        DropdownDomain.bottomOffset = CGPoint(x: 0, y: dropDownDomainButton.bounds.height)
        dropDownHomeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        DropdownHome.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dropDownHomeButton.setTitle(item, for: .normal)
            WebViewUserDefault.saveDropdownHome(item: item.getHome())
        }
        DropdownHome.bottomOffset = CGPoint(x: 0, y: dropDownHomeButton.bounds.height)
    }
    
    func configEditController() {
        if let index = self.index {
            headerTitle.text = "Edit Url"
            addButton.setTitle("Edit URL", for: .normal)
            deleteImage.isHidden = false
            deleteButton.isHidden = false
            IPDomainTextField.text = self.model[index].domain ?? ""
            if let protocols = self.model[index].protocols {
                switch protocols {
                case "http":
                    DropdownDomain.selectRow(0)
                case "https":
                    DropdownDomain.selectRow(1)
                case "rtsp":
                    DropdownDomain.selectRow(2)
                default:
                    dropDownDomainButton.setTitle(self.model[index].protocols ?? "-", for: .normal)
                }
            }
            dropDownDomainButton.setTitle(self.model[index].protocols ?? "-", for: .normal)
            nameTextfield.text = self.model[index].name ?? ""
            accTextfield.text = self.model[index].user ?? ""
            passTextField.text = self.model[index].password ?? ""
            SwitchAutoLoadUrl.isOn = self.model[index].autoLoad ?? false
            if let autoLoadPage = self.model[index].autoLoadPage {
                switch autoLoadPage {
                case "Touch":
                    DropdownHome.selectRow(0)
                case "Scada-Vis":
                    DropdownHome.selectRow(1)
                case "Schedulers":
                    DropdownHome.selectRow(2)
                case "Mosaic":
                    DropdownHome.selectRow(3)
                case "Assistant":
                    DropdownHome.selectRow(4)
                case "Premium":
                    DropdownHome.selectRow(5)
                default:
                    dropDownHomeButton.setTitle(self.model[index].autoLoadPage ?? "-", for: .normal)
                }
            }
            dropDownHomeButton.setTitle(self.model[index].autoLoadPage ?? "-", for: .normal)
            paramTextfield.text = self.model[index].params ?? ""
            let image = self.model[index].icon ?? ""
            if !image.isEmpty {
                if let data = Data(base64Encoded: self.model[index].icon ?? "", options: .ignoreUnknownCharacters) {
                    iconImage.image = UIImage(data: data)
                } else {
                    iconImage.image = UIImage(named: "logo_gmt")
                }
            } else {
                iconImage.image = UIImage(named: "logo_gmt")
            }
        } 
        
    }
    

    func coradius(textfield: UITextField) {
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 25
        textfield.layer.masksToBounds = true
    }
    
    @IBAction func didTapAddUrl(_ sender: Any) {
        let domainTextField = IPDomainTextField.text
        let nameTextField = nameTextfield.text
        let data = iconImage.image
        let convertImage = data?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        let protocols = DropdownDomain.selectedItem ?? ""
        let IPDomain = IPDomainTextField.text ?? ""
        let subDomain = String("://")
        let url = protocols + subDomain + IPDomain
        if deleteButton.isHidden {
            if domainTextField == "" || nameTextField == ""  {
                let alert = UIAlertController(title: "Thông Báo", message: "Bạn còn chưa điền đầy đủ hết thông tin, bạn hay" , preferredStyle: .alert)
                let defaultAction: UIAlertAction = UIAlertAction(title: "ok".localized, style: .default, handler:nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true)
            } else {
                let task = ModelsUrl(domain: IPDomainTextField.text, protocols: DropdownDomain.selectedItem, name: nameTextfield.text, user: accTextfield.text, password: passTextField.text, icon: convertImage, autoLoad: SwitchAutoLoadUrl.isOn, autoLoadPage: DropdownHome.selectedItem, params: paramTextfield.text, url: url)
                do {
                    try urlSevices.saveTask(task: task, isAutoLoad: SwitchAutoLoadUrl.isOn)
                    self.navigationController?.popViewController(animated: true)
                } catch let error{
                    print(error)
                }
            }
        } else {
            if let index = self.index {
                let newTask = ModelsUrl(domain: IPDomainTextField.text, protocols: DropdownDomain.selectedItem, name: nameTextfield.text, user: accTextfield.text, password: passTextField.text, icon: convertImage, autoLoad: SwitchAutoLoadUrl.isOn, autoLoadPage: DropdownHome.selectedItem, params: paramTextfield.text, url: url)
                do {
                    try urlSevices.editTask(task: newTask, index: index, isAutoLoad: SwitchAutoLoadUrl.isOn)
                    self.navigationController?.popViewController(animated: true)
                } catch let error{
                    print(error)
                }
            }
        }
    }
    
    @IBAction func PodViewHomeTapButton(_ sender: Any) {
        let UIStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let VC = UIStoryBoard.instantiateViewController(withIdentifier: "UrlDetailViewController") as? UrlDetailViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dropDownHome(_ sender: Any) {
        DropdownHome.show()
    }
    @IBAction func dropDownDomainTapButton(_ sender: Any) {
        DropdownDomain.show()
    }
    
    @IBAction func AlertTapButton(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertIconViewController") as? AlertIconViewController else { return }
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.view.backgroundColor = .clear
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        if let index = self.index {
            let task = model[index]
            do {
                try urlSevices.removeTask(task: task, index: index)
                self.navigationController?.popViewController(animated: true)
            } catch let error{
                print(error)
            }
        }
    }
    
}


extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
