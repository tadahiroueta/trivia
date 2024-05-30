//
//  structure.swift
//  trivia
//
//  Created by Ueta, Lucas T on 2/21/24.
//

import UIKit

func addScreenStack(to view: UIView) -> UIStackView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    view.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
    ])
    return stack
}
