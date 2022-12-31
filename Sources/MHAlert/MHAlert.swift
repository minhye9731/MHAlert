//
//  MHAlert.swift
//  MHAlert
//
//  Created by 강민혜 on 12/30/22.
//

import UIKit

@available(iOS 13.0, *)
open class MHAlert: UIView {
    private var contentView: UIView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var lineView: UIView!
    private var confirmButton: UIButton!
    private var cancelButton: UIButton!
    
    private var titleText: String?
    private var messageText: String?
    private var confirmText: String?
    private var completion: (() -> Void)?
    
    public convenience init(title: String, message: String, confirm: String, completion: (() -> Void)?) {
        self.init(frame: CGRect.zero)
        
        self.titleText = title
        self.messageText = message
        self.confirmText = confirm
        self.completion = completion
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView = UIView()
        titleLabel = UILabel()
        messageLabel = UILabel()
        lineView = UIView()
        confirmButton = UIButton(type: .custom)
        cancelButton = UIButton(type: .custom)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func show(in superview: UIView) {
        setAttribute()
        
        superview.addSubview(self)
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        
        self.addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        
        contentView.addSubview(messageLabel)
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 28).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        contentView.addSubview(lineView)
//        lineView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15).isActive = true
        lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        contentView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true

        contentView.addSubview(confirmButton)
        confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        confirmButton.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        confirmButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    open func setAttribute() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        contentView.layer.cornerRadius = 14.0
        contentView.backgroundColor = .white
        
        lineView.backgroundColor = .lightGray
        
        titleLabel.text = titleText ?? "Title"
        messageLabel.text = messageText ?? "Message"
        messageLabel.numberOfLines = 0
        
        confirmButton.setTitle(confirmText ?? "confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        cancelButton.setTitle("cancel", for: .normal)
    }
    
    
    @objc private func confirmAction() {
        self.removeFromSuperview()
        completion?()
    }
    
}





