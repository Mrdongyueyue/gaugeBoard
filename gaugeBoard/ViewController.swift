//
//  ViewController.swift
//  gaugeBoard
//
//  Created by 董知樾 on 2017/4/25.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let allCount = 150.0
    let duration = 5.0
    var labelArray : [UILabel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shapeLayer1 = CAShapeLayer()
        let replicatorLayer1 = CAReplicatorLayer()
        
        let bezierPath1 = UIBezierPath()
        bezierPath1.move(to: CGPoint(x: 4, y: 667/2.0))
        bezierPath1.addLine(to: CGPoint(x: 16, y: 667/2.0))
        shapeLayer1.path = bezierPath1.cgPath
        shapeLayer1.lineWidth = 1
        shapeLayer1.strokeColor = UIColor.cyan.cgColor
        
        
        replicatorLayer1.addSublayer(shapeLayer1)
        
        replicatorLayer1.bounds = view.bounds
        replicatorLayer1.position = view.center
        replicatorLayer1.preservesDepth = true
        
        view.layer.addSublayer(replicatorLayer1)
        
        
        let count1 = allCount
        replicatorLayer1.instanceDelay = 1/allCount
        replicatorLayer1.instanceCount = Int(count1 + 1);
        replicatorLayer1.instanceTransform = CATransform3DMakeRotation(CGFloat((Double.pi) / count1), 0, 0, 1.0);
        
        
        let animation1 = CABasicAnimation(keyPath: "instanceCount")
        animation1.duration = duration
        animation1.repeatCount = 1
//        animation.autoreverses = true
        animation1.fromValue = 1
        animation1.toValue = count1 + 1
        replicatorLayer1.add(animation1, forKey: nil)
        
        let animation11 = CABasicAnimation(keyPath: "strokeColor")
        animation11.duration = 0.5
        animation11.repeatCount = MAXFLOAT
        animation11.fromValue = UIColor.cyan.cgColor
        animation11.toValue = UIColor.orange.cgColor
        shapeLayer1.add(animation11, forKey: nil)
        
        
        let shapeLayer2 = CAShapeLayer()
        
        let bezierPath2 = UIBezierPath()
        bezierPath2.move(to: CGPoint(x: 0, y: 667/2.0))
        bezierPath2.addLine(to: CGPoint(x: 20, y: 667/2.0))
        shapeLayer2.path = bezierPath2.cgPath
        shapeLayer2.lineWidth = 1
        shapeLayer2.strokeColor = UIColor.cyan.cgColor
        
        let replicatorLayer2 = CAReplicatorLayer()
        
        
        replicatorLayer2.addSublayer(shapeLayer2)
        
        replicatorLayer2.bounds = view.bounds
        replicatorLayer2.position = view.center
        replicatorLayer2.preservesDepth = true
        
        view.layer.addSublayer(replicatorLayer2)
        
        
        let count2 = allCount/10
        replicatorLayer2.instanceDelay = 0.1
        replicatorLayer2.instanceCount = Int(count2 + 1);
        replicatorLayer2.instanceTransform = CATransform3DMakeRotation(CGFloat((Double.pi) / count2), 0, 0, 1.0);
        
        
        let animation2 = CABasicAnimation(keyPath: "instanceCount")
        animation2.duration = duration
        animation2.repeatCount = 1
        animation2.fromValue = 1
        animation2.toValue = count2 + 1
        replicatorLayer2.add(animation2, forKey: nil)
        
        
        let arcLayer = CAShapeLayer()
        let arcPath = UIBezierPath()
        
        arcPath.addArc(withCenter: view.center, radius: 375 / 2.0 - 10, startAngle: CGFloat(Double.pi), endAngle: 0, clockwise: true)
        
        arcLayer.path = arcPath.cgPath
        arcLayer.lineWidth = 2
        arcLayer.strokeColor = UIColor.cyan.cgColor
        arcLayer.fillColor = UIColor.clear.cgColor
        
        
        arcLayer.bounds = arcPath.bounds
        arcLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        arcLayer.position = view.center
        
        view.layer.addSublayer(arcLayer)
        
        let arcAnimation = CABasicAnimation(keyPath: "strokeEnd")
        arcAnimation.duration = duration
        arcAnimation.repeatCount = 1
        arcAnimation.fromValue = 0
        arcAnimation.toValue = 1
        arcLayer.add(arcAnimation, forKey: nil)
        
        addLabel()
    }

    func addLabel() {
        let count = allCount/10
        let radius = 375/2.0 - 30
        
        let utilAngle = Double.pi / count
        for i in 0..<Int(count + 1) {
            let y = 667/2.0 - sin(utilAngle * Double(i)) * radius
            let x = 375/2.0 - cos(utilAngle * Double(i)) * radius
            
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.init(colorLiteralRed: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            label.text = String.init(format: "%d", i * 10)
            
            let text = label.text! as NSString
            let size = text.boundingRect(with: CGSize(width: 100, height: 100), options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName : label.font], context: nil).size
            label.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            label.center = CGPoint(x: x, y: y)
            label.alpha = 0
            view.addSubview(label)
            labelArray.append(label)
        }
        labelArray[0].alpha = 1
        animationShow(index: 1)
    }
    
    func animationShow( index : Int) {
        var index = index
        UIView.animate(withDuration: 0, delay: duration/(allCount/10), options: [.curveLinear], animations: {
            self.labelArray[index].alpha = 1
        }) { (complete) in
            index += 1
            if index >= self.labelArray.count {
                return
            }
            self.animationShow(index: index)
        }
        
    }
    


}

