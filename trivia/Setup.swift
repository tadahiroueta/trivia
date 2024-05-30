//
//  Setup.swift
//  trivia
//
//  Created by Ueta, Lucas T on 2/15/24.
//

import UIKit

class Setup: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let quantityDisplay = UILabel(), quantityError = UILabel()
    
    let categories = TriviaGame.categoryNames
    var selectedCategory: String?
    var selectedQuantity: Int = 10 {
        didSet { quantityDisplay.text = String(selectedQuantity) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedCategory = categories.first
        
        view.backgroundColor = .white
        
        let stack = addScreenStack(to: view)
        stack.spacing = 40

        let title = UILabel()
        title.text = "Trivia"
        title.font = .boldSystemFont(ofSize: 96)
        stack.addArrangedSubview(title)
        
        let content = UIStackView()
        content.axis = .vertical
        content.alignment = .center
        content.spacing = 60
        stack.addArrangedSubview(content)
        
        let categoryStack = UIStackView()
        categoryStack.axis = .vertical
        categoryStack.alignment = .center
        content.addArrangedSubview(categoryStack)
        
        let categoryComment = UILabel()
        categoryComment.text = "Choose a category"
        categoryComment.font = .boldSystemFont(ofSize: 17)
        categoryStack.addArrangedSubview(categoryComment)
        
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryStack.addArrangedSubview(categoryPicker)
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        categoryPicker.heightAnchor.constraint(lessThanOrEqualToConstant: 120).isActive = true
        
        let quantityStack = UIStackView()
        quantityStack.axis = .vertical
        quantityStack.spacing = 20
        content.addArrangedSubview(quantityStack)
        
        let quantityComment = UILabel()
        quantityComment.text = "How many questions?"
        quantityComment.font = .boldSystemFont(ofSize: 17)
        quantityStack.addArrangedSubview(quantityComment)
        
        let stepperStack = UIStackView()
        stepperStack.spacing = 30
        quantityStack.addArrangedSubview(stepperStack)
        
        quantityDisplay.text = String(selectedQuantity)
        quantityDisplay.font = .systemFont(ofSize: 24)
        stepperStack.addArrangedSubview(quantityDisplay)
        
        let quantityStepper = UIStepper()
        quantityStepper.minimumValue = 0
        quantityStepper.maximumValue = 50
        quantityStepper.stepValue = 1
        quantityStepper.value = Double(selectedQuantity)
        quantityStepper.addTarget(self, action: #selector(handleQuantityChange(_:)), for: .valueChanged)
        stepperStack.addArrangedSubview(quantityStepper)
        
        quantityError.text = "Too many questions"
        quantityError.textColor = .systemRed
        quantityError.isHidden = true
        quantityStack.addArrangedSubview(quantityError)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
    
    @objc func handleQuantityChange(_ sender: UIStepper) { selectedQuantity = Int(sender.value) }
    
    
    override func viewWillDisappear(_ animated: Bool) { TriviaGame(categoryName: selectedCategory!, quantity: selectedQuantity) }
}
