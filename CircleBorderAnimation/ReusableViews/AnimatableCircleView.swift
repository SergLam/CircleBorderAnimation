//
//  AnimatableCircleView.swift
//  CircleBorderAnimation
//
//  Created by Akshit Zaveri on 02/05/20.
//  Copyright © 2020 Akshit Zaveri. All rights reserved.
//

import UIKit

final class AnimatableCircleView: UIView {
    
    // MARK: - UI objects
    private lazy var circleView: UIView = UIView()
    private lazy var miniCircleView: UIView = UIView()
    
    // MARK: - Initializers and Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        miniCircleView.layer.cornerRadius = miniCircleView.frame.width / 2.0
        miniCircleView.center = getPoint(for: -90)
    }
    
    // MARK: - Animation
    func startAnimating() {
        
        let path = UIBezierPath()
        
        let initialPoint = getPoint(for: -90)
        path.move(to: initialPoint)
        
        for angle in -89...0 {
            path.addLine(to: getPoint(for: angle))
        }
        for angle in 1...270 {
            path.addLine(to: getPoint(for: angle))
        }
        
        path.close()
        
        animate(view: miniCircleView, path: path)
    }
    
    private func animate(view: UIView, path: UIBezierPath) {
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = path.cgPath
        
        animation.repeatCount = 1
        
        animation.duration = 2
        
        view.layer.add(animation, forKey: "animation")
    }
    
    private func getPoint(for angle: Int) -> CGPoint {
        
        let radius = Double(self.circleView.layer.cornerRadius)
        
        let radian = Double(angle) * Double.pi / Double(180)
        
        let newCenterX = radius + radius * cos(radian)
        let newCenterY = radius + radius * sin(radian)
        
        return CGPoint(x: newCenterX, y: newCenterY)
    }
    
    // MARK: - Private functions
    private func setup() {
        
        clipsToBounds = false
        
        addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .red
        circleView.clipsToBounds = true
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(miniCircleView)
        miniCircleView.translatesAutoresizingMaskIntoConstraints = false
        miniCircleView.backgroundColor = .orange
        NSLayoutConstraint.activate([
            miniCircleView.widthAnchor.constraint(equalToConstant: 24),
            miniCircleView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
}
