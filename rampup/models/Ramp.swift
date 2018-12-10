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
    
    class func getRampForName(rampName: String) -> SCNNode{
        switch rampName {
        case "pipe":
            return Ramp.getpipe()
        case "pyramid":
            return Ramp.getPyramid()
        case "quarter":
            return Ramp.getQuarter()
        default:
            return Ramp.getpipe()
        }
        
    }
    
    class func getpipe() -> SCNNode {
        let obj  = SCNScene(named: "art.scnassets/pipe.dae")!
        let node = obj.rootNode.childNode(withName: "pipe", recursively: true)!
        node.scale = SCNVector3Make(0.0015, 0.0015, 0.0015)
        node.position = SCNVector3Make(0, 1.1, -1)
        return node
    }
    
    class func getPyramid() -> SCNNode {
        let objectPyramid  = SCNScene(named: "art.scnassets/pyramid.dae")!
        let nodep = objectPyramid.rootNode.childNode(withName: "pyramid", recursively: true)!
        nodep.scale = SCNVector3Make(0.0050, 0.0050, 0.0050)
        nodep.position = SCNVector3Make(0, 0.3, -1)
        return nodep
    }
    
    class func getQuarter() -> SCNNode {
        let objectq  = SCNScene(named: "art.scnassets/quarter.dae")!
        let nodeq = objectq.rootNode.childNode(withName: "quarter", recursively: true)!
        nodeq.scale = SCNVector3Make(0.0050, 0.0050, 0.0050)
        nodeq.position = SCNVector3Make(0, -0.5, -1)
        return nodeq
    }
    
    class func startRotation(node : SCNNode) {
         let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        node.runAction(rotate)
    }
}
