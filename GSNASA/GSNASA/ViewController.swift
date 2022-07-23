//
//  ViewController.swift
//  GSNASA
//
//  Created by Yogesh2 Gupta on 23/07/22.
//

import UIKit
import MediaPlayer
import AVKit
class ViewController: UIViewController {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UITextView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var tfDatePicker: UITextField!
    @IBOutlet var viewMedia: UIView!
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    private var apodViewModel = ApodHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUISubViews()
        getApod(date: Date())
        // Do any additional setup after loading the view.
    }
    
    func addUISubViews() {
        tfDatePicker.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: Constants.CalenderImage)
        imageView.image = image
        tfDatePicker.rightView = imageView
        self.tfDatePicker.datePicker(target: self,
                                     doneAction: #selector(doneAction),
                                     cancelAction: #selector(cancelAction),
                                     datePickerMode: .date)
        //Add ActivityIndicator
        activityIndicator.color = UIColor.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAtMedia)))
    }
    
    
    
    
    //DatePicker Done Action
    @objc
    func doneAction() {
        if let datePickerView = self.tfDatePicker.inputView as? UIDatePicker {
            
            DispatchQueue.main.async { [self] in
                self.tfDatePicker.resignFirstResponder()
                self.activityIndicator.startAnimating()
                clearUIData()
            }
            //Call Selected Date APod
            getApod(date: datePickerView.date)
        }
    }
    
    //DatePicker Cancel Action
    @objc
    func cancelAction() {
        self.tfDatePicker.resignFirstResponder()
    }
    
    @objc
    func tapAtMedia() {
        if (apodViewModel.media_type == Constants.MediaType.video) {
            if let urlStr = apodViewModel.url , let openUrl = URL(string: urlStr) {
                playVideo(url: openUrl)
            }
        }
    }
    
    
    //Call ViewModel to get Data
    func getApod(date:Date) {
        
        activityIndicator.startAnimating()
        apodViewModel.callApodApi(queryDate: date) { (isSuccess,error) in
            if(isSuccess) {
                self.updateUIData()
            }else {
                self.showAlert(error: error)
            }
        }
    }
    
    //Clear UI Data before New API call
    func clearUIData() {
        
        self.lblTitle.text = ""
        self.lblDescription.text = ""
        self.tfDatePicker.text = ""
        self.imgView.image = nil
    }
    
    //Update UI Data
    func updateUIData() {
        
        DispatchQueue.main.async { [self] in
            
            self.lblTitle.text = apodViewModel.title
            self.lblDescription.text = apodViewModel.explanation
            tfDatePicker.text = apodViewModel.date
            if (apodViewModel.media_type == Constants.MediaType.image) {
                self.imgView.loadImage(withUrl: apodViewModel.url ?? "")
            }else {
                self.imgView.image = UIImage(named: Constants.NoImage)
                //Or Code for Play Video if have direct video URL
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    //Show Error Alert
    func showAlert(error: String?) {
        
        DispatchQueue.main.async {
            
            self.activityIndicator.stopAnimating()
            let alert = UIAlertController(title: Constants.ErrorAlertTitle, message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func playVideo(url: URL){
        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        playerController.showsPlaybackControls = true
        playerController.view.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height+40)
        
        self.present(playerController, animated: false, completion: nil)
        
        player.play()
    }
}

