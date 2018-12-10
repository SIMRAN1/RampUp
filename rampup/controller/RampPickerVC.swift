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
        
        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        
        let obj  = SCNScene(named: "art.scnassets/pipe.dae")!
        let node = obj.rootNode.childNode(withName: "pipe", recursively: true)!
        node.runAction(rotate)
        node.scale = SCNVector3Make(0.0015, 0.0015, 0.0015)
        node.position = SCNVector3Make(0, 1.1, -1)
        scene.rootNode.addChildNode(node)
        preferredContentSize = size
        
        let objectPyramid  = SCNScene(named: "art.scnassets/pyramid.dae")!
        let nodep = objectPyramid.rootNode.childNode(withName: "pyramid", recursively: true)!
        nodep.runAction(rotate)
        nodep.scale = SCNVector3Make(0.0050, 0.0050, 0.0050)
        nodep.position = SCNVector3Make(0, 0.3, -1)
        scene.rootNode.addChildNode(nodep)
        preferredContentSize = size
        
        let objectq  = SCNScene(named: "art.scnassets/quarter.dae")!
        let nodeq = objectq.rootNode.childNode(withName: "quarter", recursively: true)!
        nodeq.runAction(rotate)
        nodeq.scale = SCNVector3Make(0.0050, 0.0050, 0.0050)
        nodeq.position = SCNVector3Make(0, -0.5, -1)
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
