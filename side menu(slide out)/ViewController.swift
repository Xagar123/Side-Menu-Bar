//
//  ViewController.swift
//  side menu(slide out)
//
//  Created by Admin on 21/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    

    var sideBarView: UIView!
    var tableView: UITableView!
    

    //creating a variable for checking sideBar view is open or not
    var isEnableSideBarView:Bool = false
    
    //creating array for title and image
    var arrData = ["Download","Language","Setting"]
    var arrImage:[UIImage] = [UIImage(imageLiteralResourceName: "Download"),UIImage(imageLiteralResourceName: "Language"),UIImage(imageLiteralResourceName: "Setting")]
    
    var imageV:UIImageView!
    var lbl:UILabel!
    
    //creating swipe gesture Recognizer
    var swipeToRight = UISwipeGestureRecognizer()
    var swipeToLeft = UISwipeGestureRecognizer()
    
    // to close side bar on tapping
    var tempView = UIView()
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bar button item
//        var menubtn = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(menuBtnClick))
        //setting image in bar button item
        var menubtn = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(menuBtnClick))
        self.navigationItem.leftBarButtonItem = menubtn
                 
        //Side bar view frame
        sideBarView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        
        //table view frame
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        //register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //add side bar view in view as sub view
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(tableView)
        
        swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedToRight))
        //setting the direction of swipe
        swipeToRight.direction = .right
        //adding gesture recognizer on view
        self.view.addGestureRecognizer(swipeToRight)
        
        swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
        swipeToLeft.direction = .left
        self.view.addGestureRecognizer(swipeToLeft)
        
        tempView = UIView(frame: CGRect(x: self.view.bounds.width/1.5, y: 0, width: self.view.bounds.width-(self.view.bounds.width/1.5), height: self.view.bounds.height))
        //tempView.backgroundColor = .blue
        self.view.addSubview(tempView)
        //it should be visible only when side bar is open
        tempView.isHidden = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideBarView))
        tempView.addGestureRecognizer(tapGesture)
        
        //remove line between two cell
        tableView.separatorStyle = .none
        
    }
    
    @objc func closeSideBarView(){
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        UIView.animate(withDuration: 0.5) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            
            self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
        }
        self.tempView.isHidden = true
        isEnableSideBarView = false
        
        
    }
    
    //Gesture action
    @objc func swipedToRight(){
        self.view.addGestureRecognizer(swipeToLeft)
        self.view.removeGestureRecognizer(swipeToRight)
        
        UIView.animate(withDuration: 0.5) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
            
            self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
        }
        self.tempView.isHidden = false
        isEnableSideBarView = true
    }
    
    @objc func swipedToLeft(){
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        
        UIView.animate(withDuration: 0.5) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            
            self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
        }
        self.tempView.isHidden = true
        isEnableSideBarView = false
    }
    
    @objc func menuBtnClick(){
        
        print("menu click")
        
        if isEnableSideBarView{
            print("side bar close")
            self.view.addGestureRecognizer(swipeToRight)
            self.view.removeGestureRecognizer(swipeToLeft)
            UIView.animate(withDuration: 0.5) {
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                
                self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            }
            self.tempView.isHidden = true
            isEnableSideBarView = false
            
        }else{
            //this part is for opening the side bar view
            print("side bar open")
            self.view.addGestureRecognizer(swipeToLeft)
            self.view.removeGestureRecognizer(swipeToRight)
            
            UIView.animate(withDuration: 0.5) {
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
                
                self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
                
            }
            self.tempView.isHidden = false
            isEnableSideBarView = true
            
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        
        imageV = UIImageView(frame: CGRect(x: 8, y: 8, width: cell.bounds.height-16, height: cell.bounds.height-16))
        imageV.contentMode = .scaleToFill
        imageV.image = self.arrImage[indexPath.row]
        cell.addSubview(imageV)
        
        lbl = UILabel(frame: CGRect(x: self.imageV.bounds.width+16, y: 8, width: cell.bounds.width-(self.imageV.bounds.width+24), height: cell.bounds.height-16))
        lbl.text = self.arrData[indexPath.row]
        lbl.font = UIFont.systemFont(ofSize: 21)
        cell.addSubview(lbl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       if indexPath.row == 0 {
            let downloadVC = self.storyboard?.instantiateViewController(withIdentifier: "DownloadViewController") as! DownloadViewController
            self.navigationController?.pushViewController(downloadVC, animated: true)
        }
        else if indexPath.row == 1 {
            let languageVC = self.storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
            self.navigationController?.pushViewController(languageVC, animated: true)
        }
        else if indexPath.row == 2 {
            let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
        else{
            print(self.arrData[indexPath.row])
        }
    }
}
