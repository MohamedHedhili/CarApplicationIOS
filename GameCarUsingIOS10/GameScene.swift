//
//  GameScene.swift
//  GameCarUsingIOS10
//
//  Created by Mac mini on 27/04/2017.
//  Copyright © 2017 Mac mini. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var  leftCar = SKSpriteNode()
    var  rightCar = SKSpriteNode()
    
    var canMove = false
    var leftToMoveLeft = true
    var rightCarToMoveRight = true
    
    var leftCarAtRight = false
    var rightCarAtLeft = false
    var centerPoint : CGFloat!
    
    let leftCarMinimumX :CGFloat = -280
    let leftCarMaximumX : CGFloat = -100
    
    let rightCarMinimumX :CGFloat = 100
    let rightCarMaximumX :CGFloat = 280
    var stopEverything = true

    
    
       override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
       setup ()
        createRoadStrip()
        Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(GameScene.createRoadStrip), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: TimeInterval(Helper().randomBetweenTwoNumbers(firstNumber: 0.8, secondNumber: 1.8)), target: self, selector: #selector(GameScene.leftTraffic), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: TimeInterval(Helper().randomBetweenTwoNumbers(firstNumber: 0.8, secondNumber: 1.8)), target: self, selector: #selector(GameScene.rightTraffic), userInfo: nil, repeats: true)



       
        }
    override func update(_ currentTime: TimeInterval) {
        if canMove{
            move(leftSide:leftToMoveLeft)
           moveRightCar(rightSide: rightCarToMoveRight)
        }
        showRoadStrip()
    }
    func setup ()
    {
 
    leftCar = self.childNode(withName: "leftCar") as! SKSpriteNode
    rightCar = self.childNode(withName: "rightCar") as! SKSpriteNode
    centerPoint = self.frame.size.width / self.frame.size.height
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if touchLocation.x > centerPoint{
                if rightCarAtLeft{
                    rightCarAtLeft = false
                    rightCarToMoveRight = true
                }else{
                    rightCarAtLeft = true
                    rightCarToMoveRight = false
                }
            }else{
                if leftCarAtRight{
                    leftCarAtRight = false
                    leftToMoveLeft = true
                }else{
                    leftCarAtRight = true
                    leftToMoveLeft = false
                }
                
            }
            canMove = true
        }
    }
    
    
    func createRoadStrip(){
        let leftRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 40))
        leftRoadStrip.strokeColor = SKColor.white
        leftRoadStrip.fillColor = SKColor.white
        leftRoadStrip.alpha = 0.4
        leftRoadStrip.name = "leftRoadStrip"
        leftRoadStrip.zPosition = 10
        leftRoadStrip.position.x = -187.5
        leftRoadStrip.position.y = 700
        addChild(leftRoadStrip)
        
        let rightRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 40))
        rightRoadStrip.strokeColor = SKColor.white
        rightRoadStrip.fillColor = SKColor.white
        rightRoadStrip.alpha = 0.4
        rightRoadStrip.name = "rightRoadStrip"
        rightRoadStrip.zPosition = 10
        rightRoadStrip.position.x = 187.5
        rightRoadStrip.position.y = 700
        addChild(rightRoadStrip)
    }
    
    func removeItems(){
        for child in children{
            if child.position.y < -self.size.height - 100{
                child.removeFromParent()
            }
        }
        
    }
    
    func move(leftSide:Bool){
        if leftSide{
            leftCar.position.x -= 20
            if leftCar.position.x < leftCarMinimumX{
                leftCar.position.x = leftCarMinimumX
            }
        }else{
            leftCar.position.x += 20
            if leftCar.position.x > leftCarMaximumX{
                leftCar.position.x = leftCarMaximumX
            }
            
            
        }
    }
    func moveRightCar(rightSide:Bool){
        if rightSide{
            rightCar.position.x += 20
            if rightCar.position.x > rightCarMaximumX{
                rightCar.position.x = rightCarMaximumX
            }
        }else{
            rightCar.position.x -= 20
            if rightCar.position.x < rightCarMinimumX{
                rightCar.position.x = rightCarMinimumX
                
            }
        }
    }
    
    
    
    
    func showRoadStrip() {
        enumerateChildNodes(withName: "leftRoadStrip", using: { (roadStrip, stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        })
        
        enumerateChildNodes(withName: "rightRoadStrip", using: { (roadStrip, stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        })
        enumerateChildNodes(withName: "car_green_1", using: { (leftCar, stop) in
            let car = leftCar as! SKSpriteNode
            car.position.y -= 15
        })
        
        enumerateChildNodes(withName: "car_red_1", using: { (rightCar, stop) in
            let car = rightCar as! SKSpriteNode
            car.position.y -= 15
        })

    
    }
    
    
    
    func leftTraffic(){
       
            let leftTrafficItem : SKSpriteNode!
            let randonNumber = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 8)
            switch Int(randonNumber) {
            case 1...4:
                leftTrafficItem = SKSpriteNode(imageNamed: "car_green_1")
                leftTrafficItem.name = "car_green_1"
                break
            case 5...8:
                leftTrafficItem = SKSpriteNode(imageNamed: "car_red_1")
                leftTrafficItem.name = "car_red_1"
                break
            default:
                leftTrafficItem = SKSpriteNode(imageNamed: "car_green_1")
                leftTrafficItem.name = "car_green_1"
            }
            leftTrafficItem.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            leftTrafficItem.zPosition = 10
            let randomNum = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 10)
            switch Int(randomNum) {
            case 1...4:
                leftTrafficItem.position.x = -280
                break
            case 5...10:
                leftTrafficItem.position.x = -100
                break
            default:
                leftTrafficItem.position.x = -280
            }
            leftTrafficItem.position.y = 700
           
            addChild(leftTrafficItem)
        
    }
    func rightTraffic(){
        
            let rightTrafficItem : SKSpriteNode!
            let randonNumber = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 8)
            switch Int(randonNumber) {
            case 1...4:
                rightTrafficItem = SKSpriteNode(imageNamed: "car_green_1")
                rightTrafficItem.name = "car_green_1"
                break
            case 5...8:
                rightTrafficItem = SKSpriteNode(imageNamed: "car_red_1")
                rightTrafficItem.name = "car_red_1"
                break
            default:
                rightTrafficItem = SKSpriteNode(imageNamed: "car_green_1")
                rightTrafficItem.name = "car_green_1"
            }
            rightTrafficItem.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            rightTrafficItem.zPosition = 10
            let randomNum = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 10)
            switch Int(randomNum) {
            case 1...4:
                rightTrafficItem.position.x = 280
                break
            case 5...10:
                rightTrafficItem.position.x = 100
                break
            default:
                rightTrafficItem.position.x = 280
            }
            rightTrafficItem.position.y = 700
      
            addChild(rightTrafficItem)
        
    }
    
}
