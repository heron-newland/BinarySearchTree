//
//  ViewController.swift
//  BinarySearchTree
//
//  Created by isec on 2019/7/12.
//  Copyright © 2019 isec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var tree = HLLBinarySearchTree(array: [7, 2, 5,10,11])
    
    var tree_enum: HLLBST = { () -> HLLBST<Int> in
        var tree = HLLBST.leaf(7)
        tree = tree.insert(newValue: 4)
        tree = tree.insert(newValue: 10)
        tree = tree.insert(newValue: 5)
        tree = tree.insert(newValue: 1)
        return tree
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(tree)
//        getDepth()
//        getHeight()
//        isBST()
//        findMin_Max_enum()
//        creatAVL()
        RBTree()
    }
    
    func RBTree() {
        let redBlackTree = RedBlackTree<Double>()
        
        let randomMax = Double(0x10000000)
        var values = [Double]()
        for i in 0..<1000 {
            let value = Double(arc4random()) / randomMax
            values.append(value)
            redBlackTree.insert(key: value)
            
            if i % 100 == 0 {
                redBlackTree.verify()
            }
        }
        redBlackTree.verify()
        
        
        for i in 0..<1000 {
            let rand = arc4random_uniform(UInt32(values.count))
            let index = Int(rand)
            let value = values.remove(at: index)
            redBlackTree.delete(key: value)
            
            if i % 100 == 0 {
                redBlackTree.verify()
            }
        }
        redBlackTree.verify()
        
    }
    func creatAVL() {
        let avl = AVLTree<Int, String>()
        avl.insert(key: 4, payload: "four")
        print(avl)
        avl.insert(key: 1, payload: "one")
        print(avl)
        avl.insert(key: 11, payload: "eleven")
        print(avl)
        avl.insert(key: 20, payload: "twenty")
        print(avl)
    
        print(avl.search(input: 20))
        
        avl.delete(key: 1)
        print(avl)
    }
    func findMin_Max_enum() {
        print(tree_enum)
        let min = tree_enum.minimum
        print(min)
        let max = tree_enum.maximum
        print(max)
    }
    func isBST() {
        print(tree.isBinarySearchTree(minValue: Int.min, maxValue: Int.max))
        let res = tree.search(2)
        res?.insert(value: 100)
        print(tree.search(100))//nil,因为已经不是二叉搜索树了
        print(tree.isBinarySearchTree(minValue: Int.min, maxValue: Int.max))
    }
    func getDepth() {
        let res = tree.search(10)
       let depth = res?.depth()
        print(depth)
    }
    func getHeight() {
        let res = tree.search(10)
       let height = res?.height()
        print(height)
    }
    func delete() {
        let res = tree.search(7)
        res?.remove()
        print(tree)
    }
    func search() {
       let res = tree.search(5)
        print(res?.value)
    }
    
    func insertion() {
        
        let tree = HLLBinarySearchTree(value: 10)
        tree.insert(value: 11)
        tree.insert(value: 5)
        tree.insert(value: 7)
        print(tree)
        
        
    }
    
}

