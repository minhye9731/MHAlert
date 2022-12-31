//
//  MHAlert.swift
//  MHAlert
//
//  Created by 강민혜 on 12/30/22.
//

import UIKit

@available(iOS 13.0, *)
public enum MHAlertButtonStyle {
    case basic
    case colored
    case lined
    case shadow
}


@available(iOS 13.0, *)
open class MHAlert: UIView {
    private var contentView: UIView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var lineView: UIView!
    private var verticalLineView: UIView!
    private var confirmButton: UIButton!
    private var cancelButton: UIButton!
    
    private var titleText: String?
    private var messageText: String?
    private var confirmText: String?
    private var cancelText: String?
    private var completion: (() -> Void)?
    private var pointColor: UIColor = .lightGray
    
    private var alertButtonStyle: MHAlertButtonStyle = .basic
    
    public convenience init(title: String, message: String? = nil, style: MHAlertButtonStyle, confirm: String, cancel: String? = nil, color: UIColor? = nil, completion: (() -> Void)? = nil) {
        self.init(frame: CGRect.zero)
        
        self.titleText = title
        self.messageText = message
        self.confirmText = confirm
        self.cancelText = cancel
        self.alertButtonStyle = style
        self.completion = completion
        self.pointColor = color ?? .lightGray
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView = UIView()
        titleLabel = UILabel()
        messageLabel = UILabel()
        lineView = UIView()
        verticalLineView = UIView()
        confirmButton = UIButton(type: .custom)
        cancelButton = UIButton(type: .custom)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func show(in superview: UIView) {
        setAttribute()
        configureUI(superview)
        setConstraints(superview)
    }
    
    private func configureUI(_ superview: UIView) {
        superview.addSubview(self)
        self.addSubview(contentView)
        [titleLabel, messageLabel, confirmButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setConstraints(_ superview: UIView) {
        
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        switch alertButtonStyle {
        case .basic:
            contentView.addSubview(lineView)
            lineView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 35).isActive = true
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            
            contentView.addSubview(cancelButton)
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            cancelButton.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            cancelButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            cancelButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true

            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            confirmButton.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
            confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            confirmButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            confirmButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
            
            contentView.addSubview(verticalLineView)
            verticalLineView.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
            verticalLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            verticalLineView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            verticalLineView.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
            
        case .colored:
            messageLabel.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -15).isActive = true
            
            confirmButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6).isActive = true
            confirmButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            confirmButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
            confirmButton.layer.cornerRadius = 22
            
        case .lined:
            contentView.addSubview(lineView)
            lineView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 25).isActive = true
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            confirmButton.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
            confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            confirmButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            
        case .shadow:
            messageLabel.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -20).isActive = true
            
            confirmButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6).isActive = true
            confirmButton.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
            confirmButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
            confirmButton.layer.cornerRadius = 18
        }
    }
    
    
    open func setAttribute() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 14.0
        contentView.clipsToBounds = true
        
        titleLabel.text = titleText ?? "Title"
        titleLabel.textAlignment = .center
        
        messageLabel.text = messageText ?? "Message"
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .lightGray
        
        confirmButton.setTitle(confirmText ?? "confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmActionTapped), for: .touchUpInside)
        
        switch alertButtonStyle {
        case .basic:
            lineView.backgroundColor = .lightGray
            verticalLineView.backgroundColor = .lightGray
            
            cancelButton.setTitle(cancelText ?? "cancel", for: .normal)
            cancelButton.setTitleColor(.black, for: .normal)
            cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
            
            titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
            titleLabel.textColor = .black
            messageLabel.font = .systemFont(ofSize: 16, weight: .medium)
            
            confirmButton.backgroundColor = .white
            confirmButton.setTitleColor(.black, for: .normal)
            confirmButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            
        case .colored:
            titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
            titleLabel.textColor = pointColor
            messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
            
            confirmButton.backgroundColor = pointColor
            confirmButton.setTitleColor(.white, for: .normal)
            confirmButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
            
        case .lined:
            lineView.backgroundColor = .lightGray
            
            titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
            titleLabel.textColor = pointColor
            messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
            
            confirmButton.backgroundColor = .white
            confirmButton.setTitleColor(pointColor, for: .normal)
            confirmButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            
        case .shadow:
            titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
            titleLabel.textColor = pointColor
            messageLabel.font = .systemFont(ofSize: 16, weight: .regular)
            
            confirmButton.backgroundColor = .white
            confirmButton.setTitleColor(pointColor, for: .normal)
            confirmButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
            confirmButton.layer.borderWidth = 1
            confirmButton.layer.borderColor = pointColor.cgColor
            confirmButton.layer.shadowColor = UIColor.gray.cgColor
            confirmButton.layer.shadowOpacity = 0.2
            confirmButton.layer.shadowOffset = CGSize.zero
            confirmButton.layer.shadowRadius = 10
        }
    }
    
    @objc private func cancelButtonTapped() {
        self.removeFromSuperview()
    }
    
    @objc private func confirmActionTapped() {
        self.removeFromSuperview()
        completion?()
    }
    
}





