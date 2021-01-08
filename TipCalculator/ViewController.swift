//
//  ViewController.swift
//  TipCalculator
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-06.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    var marginTopBor = CGFloat()
    
    let tipAmountLabel : UILabel = {
        
        let l = UILabel()
        l.text = "$ 00.00"
        l.font = UIFont(name: "HelveticaNeue-UltraLight", size: 50)
        l.shadowColor = .gray;
        l.shadowOffset = CGSize(width: 2, height: 2)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let billAmountLabel : UILabel = {
        let l = UILabel()
        l.text = "Total Amount"
        l.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var billAmountTextFiel : UITextField = {
        let tf = UITextField()
        tf.text = "Bill Amount"
        tf.font = UIFont(name: "HelveticaNeue-UltraLight", size: 25)
        tf.textColor = UIColor.lightGray
        tf.textAlignment = .center
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1.0;
        tf.layer.cornerRadius = 8;
        tf.keyboardType = .decimalPad
        tf.addTarget(self , action: #selector(cleanField), for: .editingDidBegin)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let tipPercentageLabel : UILabel = {
        let l = UILabel()
        l.text = "Tip Percentage"
        l.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    let tipPercentageSlider : UISlider = {
        let s = UISlider()
        s.minimumValue = 0.0
        s.maximumValue = 1.0
        s.tintColor = .cyan
        s.thumbTintColor = .cyan
        s.value = 0.15
        s.addTarget(self , action: #selector(adjustTipPercentage), for: .valueChanged)
        
        return s
    }()
    
    let tipPercentageSladerValor : UILabel = {
        let l = UILabel()
        l.text = "15 %"
        l.textAlignment = .center
        l.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
    }()
    
    let calculateTipButton : UIButton = {
        let b = UIButton()
        b.setTitle("Calculate Tip", for: .normal)
        b.titleLabel?.font =  UIFont(name: "AvenirNextCondensed-regular", size: 30)
        b.setTitleShadowColor(UIColor.lightGray, for: .normal)
        b.titleLabel?.shadowOffset = CGSize(width: -2, height: -3)
        b.backgroundColor = .cyan
        b.addTarget(self , action: #selector(calculateTip), for: .touchUpInside)
        return b
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.matchParent()
        scrollView.backgroundColor = .white
   
        let tipAmountSV = VerticalStackView(arrangedSubviews: [tipAmountLabel], spacing: 0, alignment: .fill, distribution: .fill)
        
        
        
        let amountSV = VerticalStackView(arrangedSubviews: [billAmountLabel,billAmountTextFiel], spacing: 0, alignment: .fill, distribution: .fill)
        billAmountLabel.constraintWidth(equalToConstant: 50)
        billAmountTextFiel.constraintHeight(equalToConstant: 50)
        
        
        let tipSV = VerticalStackView(arrangedSubviews: [tipPercentageLabel,tipPercentageSlider,tipPercentageSladerValor], spacing: 0, alignment: .fill, distribution: .fillProportionally)
        
        let buttonSV = VerticalStackView(arrangedSubviews: [calculateTipButton], spacing: 0, alignment: .fill, distribution: .fill)
        
        calculateTipButton.matchParent()
        calculateTipButton.constraintHeight(equalToConstant: 40)
        
        calculateTipButton.centerYAnchor.constraint(equalTo: buttonSV.centerYAnchor).isActive = true
        
        let verticalSV = VerticalStackView(arrangedSubviews: [tipAmountSV, amountSV, tipSV, buttonSV], spacing: 0, alignment: .fill, distribution: .fillProportionally)
        
        scrollView.addSubview(verticalSV)
        verticalSV.centerXYin(scrollView)
        marginTopBor = view.frame.height * 0.45 / 2
        verticalSV.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -marginTopBor).isActive = true
        verticalSV.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: marginTopBor).isActive = true
        verticalSV.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -20).isActive = true
        verticalSV.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 20).isActive = true
        
    

        tipAmountSV.anchors(topAnchor: verticalSV.topAnchor, leadingAnchor: verticalSV.leadingAnchor, trailingAnchor: verticalSV.trailingAnchor, bottomAnchor: amountSV.topAnchor)

        amountSV.anchors(topAnchor: tipAmountSV.bottomAnchor, leadingAnchor: verticalSV.leadingAnchor, trailingAnchor: verticalSV.trailingAnchor, bottomAnchor: tipSV.topAnchor)

        tipSV.anchors(topAnchor: amountSV.bottomAnchor, leadingAnchor: verticalSV.leadingAnchor, trailingAnchor: verticalSV.trailingAnchor, bottomAnchor: calculateTipButton.topAnchor)

        buttonSV.anchors(topAnchor: tipSV.bottomAnchor, leadingAnchor: verticalSV.leadingAnchor, trailingAnchor: verticalSV.trailingAnchor, bottomAnchor: verticalSV.bottomAnchor)

        registerForKeyboardNotification()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        
        
      }
      
      @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
      }
    
    
    @objc func calculateTip(){
        let tipPer = Double(round(tipPercentageSlider.value * 100.0))
        
        if(tipAmountLabel.text == "$ 00.00") {
            tipPercentageSlider.addTarget(self , action: #selector(calculateTip), for: .touchUpInside)
            billAmountTextFiel.addTarget(self , action: #selector(calculateTip), for: .editingChanged)
        }
        
        if let bill = billAmountTextFiel.text {
            if bill != "" && bill != "Bill Amount" {
                let tipBill = Double(bill)! * (tipPer / 100 + 1)
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                
                tipAmountLabel.text = "$ \(formatter.string(from: NSNumber(value: tipBill))!)"
            } else {
                tipAmountLabel.text = "$ 00.00"
            }
        }
        
    }
    
    @objc func cleanField() {
        if billAmountTextFiel.text == "Bill Amount" {
            billAmountTextFiel.text = ""
        }
        
    }
    
    @objc func adjustTipPercentage() {
        let tipPer = Int(round(tipPercentageSlider.value * 100))
        tipPercentageSladerValor.text = "\(tipPer) %"
    }
    
    fileprivate func registerForKeyboardNotification() {
      // 1. I want to listen to the keyboard showing / hiding
      //    - "hey iOS, tell(notify) me when keyboard shows / hides"
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
      // 2. When notified, I want to ask iOS the size(height) of the keyboard
      guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
      
      let keyboardFrame = keyboardFrameValue.cgRectValue
      let keyboardHeight = keyboardFrame.size.height - marginTopBor
      
      // 3. Tell scrollview to scroll up (height)
      let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }

    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
      // 2. When notified, I want to ask iOS the size(height) of the keyboard
      // 3. Tell scrollview to scroll down (height)
      let insets = UIEdgeInsets.zero
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }

  
}

