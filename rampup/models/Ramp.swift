//
//  Ramp.swift
//  rampup
//
//  Created by Apple on 10/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import SceneKit

class Ramp {
    class func getpipe() -> SCNNode {
        let obj  = SCNScene(named: "art.scnassets/pipe.dae")!
        let node = obj.rootNode.childNode(withName: "pipe", recursively: true)!
        node.runAction(rotate)
        node.scale = SCNVector3Make(0.0015, 0.0015, 0.0015)
        node.position = SCNVector3Make(0, 1.1, -1)
        return node
    }
}
