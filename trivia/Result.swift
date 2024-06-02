//
//  Result.swift
//  trivia
//
//  Created by Ueta, Lucas T on 2/27/24.
//

import UIKit

class Result: UIViewController {
    var points: Int?, total: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let stack = addScreenStack(to: view)
        stack.spacing = 250
        
        let label = UILabel()
        label.text = "You got \(points!) out of \(total!)!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        stack.addArrangedSubview(label)
        
        let button = UIButton()
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        stack.addArrangedSubview(button)
    }
    
    @objc func handleClick() {
        dismiss(animated: true)
    }
    
}
