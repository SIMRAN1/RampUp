//
//  RampPickerVC.swift
//  rampup
//
//  Created by Apple on 02/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SceneKit

class RampPickerVC: UIViewController {
    

    var sceneView: SCNView!
    var size: CGSize!
    weak var rampPlacerVC:RampPlacerVC!
    
    init(size: CGSize) {
        super.init(nibName: nil,bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        let scene = SCNScene(named: "art.scnassets/ramps.scn")!
        sceneView.scene = scene
        let camera = SCNCamera()
        camera.usesOrthographicProjection =  true
        scene.rootNode.camera = camera
        let tapGesturerecog = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesturerecog)
        
        let node = Ramp.getpipe()
        Ramp.startRotation(node: node)
        scene.rootNode.addChildNode(node)
        preferredContentSize = size
        
        let nodep = Ramp.getPyramid()
        Ramp.startRotation(node: nodep)
        scene.rootNode.addChildNode(nodep)
        preferredContentSize = size
        
        let nodeq = Ramp.getQuarter()
        Ramp.startRotation(node: nodeq)
        scene.rootNode.addChildNode(nodeq)
        preferredContentSize = size
        
        // Do any additional setup after loading the view.
    }
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let p = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            let node = hitResults[0].node
            print(node.name!)
              rampPlacerVC.onRampSelected(node.name!)
            
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
