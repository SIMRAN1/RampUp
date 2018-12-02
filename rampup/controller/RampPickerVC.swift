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
        
        
        
        let obj  = SCNScene(named: "art.scnassets/pyramid.dae")!
        let node = obj.rootNode.childNode(withName: "pyramid", recursively: true)!
        node.scale = SCNVector3Make(0.0042, 0.0042, 0.0042)
        node.position = SCNVector3Make(-1, 0.7, -1)
        scene.rootNode.addChildNode(node)
        preferredContentSize = size
        
        // Do any additional setup after loading the view.
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
