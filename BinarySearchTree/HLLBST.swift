//
//  HLLBST.swift
//  BinarySearchTree
//
//  Created by isec on 2019/7/12.
//  Copyright © 2019 isec. All rights reserved.
//

import UIKit

/// BST枚举实现
///
/// - Empty: 空树
/// - Leaf: 叶子节点
/// - Node: 有左节点或者右节点或者二者都有,使用indirect修饰来实现递归
public enum HLLBST<T:Comparable> {
    case empty
    case leaf(T)
    indirect case node(HLLBST, T, HLLBST)
}

// MARK: - Operations
extension HLLBST {
    
    /// 最大值
    public var minimum: HLLBST? {
        switch self {
        case .empty:
            return nil
        case .leaf:
            return self
        case let .node(left, value, _):
            //如果左子树为空,那么最大值就是当前根节点,如果左子树不为空,那么递归插糟
            switch left {
            case .empty:
                return .leaf(value)
            default:
                return left.minimum
            }
        }
    }
    
    /// 最大值
    public var maximum: HLLBST? {
        switch self {
        case .empty:
            return nil
        case .leaf:
            return self
        case let .node(_, value, right):
            //如果右子树为空,那么最大值就是当前根节点,如果右子树不为空,那么递归插糟
            switch right {
            case .empty:
                return .leaf(value)
            default:
            return right.maximum
            }
        }
    }
    /// 元素个数
    public var count: Int {
        switch self {
        case .empty:
            return 0
        case .leaf:
            return 1
        case let .node(left, _, right):
            return left.count + 1 + right.count
        }
    }
    
    /// 树的高度
    public var height: Int {
        switch self {
        case .empty:
            return 0
        case .leaf:
            return 1
        case let .node(left, _, right):
            return 1 + max(left.height, right.height)
        }
    }
    
    /// 插入
    public func insert(newValue: T) -> HLLBST {
        switch self {
        case .empty:
            return .leaf(newValue)
        case .leaf(let value):
            if newValue < value {
                return .node(.leaf(newValue), value, .empty)
            }else{
                return .node(.empty, value, .leaf(newValue))
            }
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.insert(newValue: newValue), value, right)
            }else{
                return .node(left, value, right.insert(newValue: newValue))
            }
        }
    }
    
    /// 查找
    public func search(value:T) -> HLLBST? {
        switch self {
        case .empty:
            return nil
        case .leaf(let x):
            return value == x ? self : nil
        case let .node(left, x, right):
            if value < x {
                return left.search(value: value)
            } else if value > x {
                return right.search(value: value)
            }else{
                return self
            }
        }
    }
}

// MARK: - CustomDebugStringConvertible,方便打印
extension HLLBST: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .empty:
            return "."
        case .leaf(let value):
            return "\(value)"
        case let .node(left, value, right):
            return "(\(left.debugDescription))" + "->" + "\(value)" + "<-" + "(\(right.debugDescription))"
        }
    }
}
