//
//  ViewController.swift
//  rampup
//
//  Created by Apple on 29/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class RampPlacerVC: UIViewController, ARSCNViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var rotateButton: UIButton!
    
    @IBOutlet weak var upArrowButton: UIButton!
    
    @IBOutlet weak var downArrowButton: UIButton!
    
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var selectedRampName: String?
    var selectedRamp: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/main.scn")!
        sceneView.autoenablesDefaultLighting = true
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    override  func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let results = sceneView.hitTest(touch.location(in: sceneView), types: .featurePoint)
        guard let hitFeature = results.last else {
            return
        }
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        placeRamp(position: hitPosition)
        }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func RampButtonPressed(_ sender: UIButton) {
        let rampPickerVC = RampPickerVC(size: CGSize(width: 250, height: 500))
        rampPickerVC.rampPlacerVC = self
        rampPickerVC.modalPresentationStyle = .popover
        rampPickerVC.popoverPresentationController?.delegate = self
        present(rampPickerVC,animated: true,completion: nil)
        rampPickerVC.popoverPresentationController?.sourceView = sender
        rampPickerVC.popoverPresentationController?.sourceRect = sender.bounds
        
    }
    
    func onRampSelected(_ rampName: String) {
        selectedRampName = rampName
        
    }
    
    func placeRamp(position: SCNVector3) {
        if let rampName = selectedRampName {
            let ramp = Ramp.getRampForName(rampName: rampName)
            selectedRamp = ramp
            ramp.position = position
            ramp.scale = SCNVector3Make(0.01, 0.01, 0.01)
            sceneView.scene.rootNode.addChildNode(ramp)
        }
    }
    
    @IBAction func onRemovedPressed(_ sender: Any) {
        
        if let ramp = selectedRamp {
            ramp.removeFromParentNode()
            selectedRamp = nil
        }
    }
}
