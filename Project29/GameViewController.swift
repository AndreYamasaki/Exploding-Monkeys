//
//  GameViewController.swift
//  Project29
//
//  Created by user on 17/08/21.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    //MARK: - Attributes
    var currentGame: GameScene?
    
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var launchButton: UIButton!
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var newGameButton: UIButton!
    
    @IBOutlet var player1ScoreLabel: UILabel!
    @IBOutlet var player2ScoreLabel: UILabel!
    
    // challenge 1
        var player1Score: Int = 0 {
            didSet {
                player1ScoreLabel.text = "Score: \(player1Score)"
            }
        }
        var player2Score: Int = 0 {
            didSet {
                player2ScoreLabel.text = "Score: \(player2Score)"
            }
        }
    
    // challenge 1
        var gameStopped = false {
            didSet {
                newGameButton.isHidden = !gameStopped
            }
        }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1ScoreLabel.text = "Score: \(player1Score)"
        player2ScoreLabel.text = "Score: \(player2Score)"
        
        angleChanged(angleSlider)
        velocityChanged(velocitySlider)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame?.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        angleChanged(self)
        velocityChanged(self)
    }
    
    //MARK: - Methods

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func angleChanged(_ sender: Any) {
        
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
                
        angleSlider.isHidden = true
            angleLabel.isHidden = true

            velocitySlider.isHidden = true
            velocityLabel.isHidden = true

            launchButton.isHidden = true

            currentGame?.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }

        angleSlider.isHidden = false
        angleLabel.isHidden = false

        velocitySlider.isHidden = false
        velocityLabel.isHidden = false

        launchButton.isHidden = false
    }
    
    func gameControls(isHidden: Bool) {
            angleSlider.isHidden = isHidden
            angleLabel.isHidden = isHidden
            velocitySlider.isHidden = isHidden
            velocityLabel.isHidden = isHidden
            launchButton.isHidden = isHidden
        }
        
        // challenge 1
        func playerScored(player: Int) {
            if player == 1 {
                player1Score += 1
            }
            else {
                player2Score += 1
            }
            
            if player1Score == 3 {
                playerNumber.text = "PLAYER 1 WINS"
                stopGame()
            }
            else if player2Score == 3 {
                playerNumber.text = "PLAYER 2 WINS"
                stopGame()
            }
        }
        
        // challenge 1
        func stopGame() {
            gameControls(isHidden: true)
            gameStopped = true
        }
        
        // challenge 1
        @IBAction func newGameAction(_ sender: Any) {
            gameStopped = false
            player1Score = 0
            player2Score = 0
            currentGame?.newGame()
        }
}
