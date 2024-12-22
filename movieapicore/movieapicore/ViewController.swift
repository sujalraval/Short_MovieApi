//
//  ViewController.swift
//  movieapicore
//
//  Created by Manthan Mittal on 22/12/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redsiler: UISlider!
    
    @IBOutlet weak var greenslider: UISlider!
    
    @IBOutlet weak var opacityslider: UISlider!
    
    @IBOutlet weak var orangeslider: UISlider!
    
    private var rValue:CGFloat!
    private var gValue:CGFloat!
    private var orValue:CGFloat!
    private var opacityValue:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setColor(r: CGFloat, g: CGFloat, or: CGFloat, o: CGFloat) {
        colorView.backgroundColor =  UIColor(red: r/255, green: g/255, blue: or/255, alpha: o)
        }
    
    func color1(r: CGFloat, g: CGFloat, or: CGFloat, o: CGFloat) {
        
        self.view.backgroundColor = UIColor(red: r/255, green: g/255, blue: or/255, alpha: o)
        
    }

    @IBAction func colorchanger(_ sender: Any) {
        rValue = CGFloat(redsiler.value)
        gValue = CGFloat(greenslider.value)
        orValue = CGFloat(orangeslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        color1(r: rValue, g: gValue, or: orValue, o: opacityValue)
    }
    
    @IBAction func red(_ sender: Any) {
        rValue = CGFloat(redsiler.value)
        gValue = CGFloat(greenslider.value)
        orValue = CGFloat(orangeslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        setColor(r: rValue, g: gValue, or: orValue, o: opacityValue)
    }
    
    @IBAction func green(_ sender: Any) {
        rValue = CGFloat(redsiler.value)
        gValue = CGFloat(greenslider.value)
        orValue = CGFloat(orangeslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        setColor(r: rValue, g: gValue, or: orValue, o: opacityValue)
    }
    
    @IBAction func orange(_ sender: Any) {
        rValue = CGFloat(redsiler.value)
        gValue = CGFloat(greenslider.value)
        orValue = CGFloat(orangeslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        setColor(r: rValue, g: gValue, or: orValue, o: opacityValue)
    }
    
    @IBAction func opacity(_ sender: Any) {
        rValue = CGFloat(redsiler.value)
        gValue = CGFloat(greenslider.value)
        orValue = CGFloat(orangeslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        setColor(r: rValue, g: gValue, or: orValue, o: opacityValue)
    }
    
}

