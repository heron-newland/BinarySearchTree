//
//  HLLBinarySearchTree.swift
//  BinarySearchTree
//
//  Created by isec on 2019/7/12.
//  Copyright © 2019 isec. All rights reserved.
//
//https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search%20Tree
import UIKit

public class HLLBinarySearchTree<T:Comparable> {
    
    /// 树的根节点的值
    private(set) public var value: T
    
    /// 父节点
    private(set) public var parent: HLLBinarySearchTree?
    
    /// 左子树
    private(set) public var left: HLLBinarySearchTree?
    
    /// 右子树
    private(set) public var right: HLLBinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    
    public var isRoot: Bool{
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasBothChildren: Bool {
        return left != nil && right != nil
    }
    
    /// 树所包含元素的个数
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    
    /// 高度
    ///
    /// - 从子节点(高度为1)到某个节点所经过的路径
    public func height() -> Int {
        if isLeaf {
            return 0
        }else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    /// 深度
    ///
    /// - 从根节点(深度为1)到某个给定的子节点的所经过的路径
    public func depth() -> Int {
        var node = self
        var edges = 0
        while  let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    /// 前驱
    ///
    /// - Returns: 比当前节点小的所有节点中的最大值
    public func predecessor() -> HLLBinarySearchTree<T>? {
        if let left = left {
            return left.maximum()
        }else{
            var node = self
            while let parent = node.parent {
                if parent.value < value {
                    return parent
                }
                node = parent
            }
            return nil
        }
    }
    
    /// 后继
    ///
    /// - Returns: 比当前节点大的所有节点中的最小值
    public func successor() -> HLLBinarySearchTree<T>? {
        if let right = right {
            return right.minimum()
        }else{
            var node = self
            while let parent = node.parent {
                if parent.value > value {
                    return parent
                }
                node = parent
            }
            return nil
        }
    }
    
    /// 检验二叉树是否为搜索二叉树
    ///
    /// - Parameters:
    ///   - minValue: 最小值
    ///   - maxValue: 最大值
    /// - Returns: 检验结果
    public func isBinarySearchTree(minValue: T, maxValue: T) -> Bool {
        if value < minValue || value > maxValue { return false }
        let leftBST = left?.isBinarySearchTree(minValue: minValue, maxValue: value) ?? true
        let rightBST = right?.isBinarySearchTree(minValue: value, maxValue: maxValue) ?? true
        return leftBST && rightBST
    }
    
    /// 数转换为有序数组
    ///
    /// - Returns:
    public func toArray() -> [T] {
        return map { $0 }
    }
    
    /// 树中的最小值
    func minimum() -> HLLBinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    
    /// 树中的最大值
    func maximum() -> HLLBinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }

}

// MARK: - 增,删,查
extension HLLBinarySearchTree {
    /// 插入节点
    /// 必须从根节点开始插入, 如果试图从子节点插入,则会破坏树的有序性,错误代码如下:
    /*
     ** 1 不是树的根节点
     if let node1 = tree.search(1) {
     node1.insert(100)
     }
     */
    /// - Parameter value: 插入的新值
    public func insert(value:T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            }else{
                left = HLLBinarySearchTree(value: value)
                left?.parent = self
            }
        }else{
            if let right = right {
                right.insert(value: value)
            }else{
                right = HLLBinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    
    
    /// 搜索
    ///
    /// - Parameter value: 要搜索的值
    /// - Returns: 搜索的结果
    public func search(_ value: T) -> HLLBinarySearchTree? {
        if value < self.value {
            return left?.search(value)
        }else if value > self.value{
            return right?.search(value)
        }else{
            return self
        }
    }
    
    /// 从根节点开始删除
    ///
    /// - Returns: 删除根节点之后的树
    @discardableResult public func remove() -> HLLBinarySearchTree? {
        let replacement: HLLBinarySearchTree?
        
        // Replacement for current node can be either biggest one on the left or
        // smallest one on the right, whichever is not nil
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()
        
        // Place the replacement on current node's position
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node:replacement)
        
        // The current node is no longer part of the tree, so clean it up.
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
}
// MARK: - 高阶函数
extension HLLBinarySearchTree {
    
    public func map(formula: (T) -> T) -> [T] {
        var res = [T]()
        if let left = left {
            res += left.map(formula: formula)
        }
        res.append(formula(value))
        if let right = right {
            res += right.map(formula: formula)
        }
        return res
    }
}
// MARK: - Traverse: 遍历, 前,中,后序遍历
extension HLLBinarySearchTree {
    
    /// 中序遍历
    ///
    /// - Parameter process: 遍历行为
    public func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }
    
    /// 前序遍历
    ///
    /// - Parameter process: 遍历行为
    public func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    
    /// 后序遍历
    ///
    /// - Parameter process: 遍历行为
    public func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
}
// MARK: - 便利构造器通过数组转化为搜索二叉树
extension HLLBinarySearchTree{
    
    /// 数组转化为搜索二叉树
    ///
    /// - Parameter array: 数据源
    public convenience init(array:[T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
}

// MARK: - 自定义log样式
extension HLLBinarySearchTree: CustomStringConvertible{
    public var description: String {
        var s = ""
        if let left = left{
            s += "(\(left.description)) <-"
        }
        s += "\(value)"
        if let right = right {
            s += "-> (\(right.description))"
        }
        return s
    }
}

// MARK: - private func
extension HLLBinarySearchTree {
    private func reconnectParentTo(node: HLLBinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            }else{
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    
}
