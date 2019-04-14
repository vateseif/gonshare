//
//  sharingRideCell.swift
//  GondolaShare
//
//  Created by SEIF EL FREJ ISMAIL on 10/04/2019.
//  Copyright © 2019 SEIF EL FREJ ISMAIL. All rights reserved.
//

import UIKit

class sharingRideCell: BaseCell {
    
    
    
    
    let personImage : UIImageView = {
        let im = UIImageView()
        im.tintColor = nil
        im.translatesAutoresizingMaskIntoConstraints=false
        return im
    }()
    
    let joinButton : UIButton = {
        let but = UIButton(type: .system)
        but.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1)
        but.layer.cornerRadius = 7
        but.setTitle("Join", for: .normal)
        but.setTitleColor(UIColor.white, for: .normal)
        but.translatesAutoresizingMaskIntoConstraints=false
        
        return but
    }()
    
    let fullImageView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        v.backgroundColor = UIColor.red
        v.layer.cornerRadius = 7
        return v
    }()
    
    let emptyImageView : UIView = {
        let v = UIView()
        return v
    }()
    
    
    let personWaitingLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Bochra is with 3 other people"
        lab.translatesAutoresizingMaskIntoConstraints=false
        return lab
    }()
    
    
    
    
    override func setupViews() {
        super.setupViews()
        
        personImage.image = UIImage(named: "output-onlinepngtools")//imageByMakingWhiteBackgroundTransparent()
        
        addSubview(joinButton)
        addSubview(fullImageView)
        addSubview(personWaitingLabel)
        addSubview(personImage)
        
        
        addButtonConstraint()
        addFullViewConstraint()
        addPersonWaitingConstraint()
        addImageConstraint()
        
        
    }
    
    
    func imageByMakingWhiteBackgroundTransparent() -> UIImage? {
        
        let image = UIImage(named: "people_gonshare")
        let rawImageRef: CGImage = (image?.cgImage!)!
        
        let colorMasking: [CGFloat] = [200, 255, 200, 255, 200, 255]
        UIGraphicsBeginImageContext(image!.size);
        
        let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking)
        UIGraphicsGetCurrentContext()?.translateBy(x: 0.0,y: image!.size.height)
        UIGraphicsGetCurrentContext()?.scaleBy(x: 1.0, y: -1.0)
        UIGraphicsGetCurrentContext()?.draw(maskedImageRef!, in: CGRect.init(x: 0, y: 0, width: image!.size.width, height: image!.size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return result
        
    }
    
    
    
    func addButtonConstraint(){
        joinButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive=true
        joinButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14).isActive=true
        joinButton.widthAnchor.constraint(equalToConstant: 59).isActive=true
        joinButton.heightAnchor.constraint(equalToConstant: 50).isActive=true
    }
    
    
    func addFullViewConstraint(){
        fullImageView.widthAnchor.constraint(equalToConstant: 290).isActive=true
        fullImageView.heightAnchor.constraint(equalToConstant: 50).isActive=true
        fullImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive=true
        fullImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive=true
    }
    
    
    func addPersonWaitingConstraint(){
        personWaitingLabel.widthAnchor.constraint(equalToConstant: 240).isActive=true
        personWaitingLabel.heightAnchor.constraint(equalToConstant: 50).isActive=true
        personWaitingLabel.bottomAnchor.constraint(equalTo: fullImageView.topAnchor, constant: -8).isActive=true
        personWaitingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 57).isActive=true
    }
    
    func addImageConstraint(){
        personImage.widthAnchor.constraint(equalToConstant: 29).isActive=true
        personImage.heightAnchor.constraint(equalToConstant: 29).isActive=true
        personImage.centerYAnchor.constraint(equalTo: personWaitingLabel.centerYAnchor).isActive=true
        personImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive=true
        
    }
}




