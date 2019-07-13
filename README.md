### Swift实现搜索二叉树(BST)

二叉搜索树（BST）
关于索索二叉树[这里](https://www.raywenderlich.com/990-swift-algorithm-club-swift-binary-search-tree-data-structure)有详细的教程,下面我们主要针对二叉树的一些特点,来一步一步使用Swift来编写一个具有搜索二叉树功能的类,以及后面优化之后的枚举.

二叉搜索树是一种特殊的[二叉树](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Tree)（每个节点最多有两个子节点的树），它执行插入和删除，以便始终对树进行排序。

有关树的更多信息，请首先[阅读](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Tree)。

#### “总是有序的”

以下是有效二叉搜索树的示例：

![二叉搜索树]()

==注意每个左子节点小于其父节点，每个右子节点大于其父节点。这是二叉搜索树的关键特性。==

例如，2小于7，所以它在左边; 5大于2，所以它在右边。

#### 插入新节点

执行插入时，我们首先将新值与根节点进行比较。如果新值较小，我们采用左分支; 如果更大，我们采取右分支。我们沿着这条路向下走，直到找到一个空位，我们可以插入新值。

假设我们要插入新值9：

*   我们从树的根（具有值的节点7）开始，并将其与新值进行比较9。
*   9 > 7，所以我们沿着右边的分支向下重复相同的过程，但这次是在节点上10。
*   因为9 < 10，我们走左边的分支。
*   我们现在到了一个没有值可以比较的点。9在该位置插入新节点。

这是插入新值后的树9：

![]()

只有一个可能的位置可以在树中插入新元素。找到这个地方通常很快。它需要O（h）时间，其中h是树的高度。

注意：==节点的高度是从该节点到最低叶子所需的步骤数。整棵树的高度是从根到最低叶子的距离。二叉搜索树上的许多操作都以树的高度表示==。

通过遵循这个简单的规则 - 左边较小的值，右边较大的值 - 我们保持树的排序，所以每当我们查询它时，我们可以检查一个值是否在树中。

#### 搜索树

要在树中查找值，我们执行与插入相同的步骤：

* 如果该值小于当前节点，则采用左分支。
* 如果该值大于当前节点，请采用右分支。
* 如果该值等于当前节点，我们就找到了它！

像大多数树操作一样，这是递归执行的，直到我们找到我们正在查找的内容或用完要查看的节点。

以下是搜索值5的示例：

![]()

使用树的结构搜索很快。它在O（h）时间内运行。如果你有一个拥有一百万个节点的均衡树，那么在这棵树中找到任何东西只需要大约20步。（这个想法非常类似于数组中的二进制搜索。）

#### 遍历树

有时您需要查看所有节点而不是仅查看一个节点。

遍历二叉树有三种方法：

1. 有序（或深度优先）：首先查看节点的左子节点，然后查看节点本身，最后查看其右子节点。
2. 预购：首先看一个节点然后看它的左右儿童。
3. 后序：首先查看左右子节点并最后处理节点本身。

遍历树也是递归发生的。

如果按顺序遍历二叉搜索树，它会查看所有节点，就好像它们从低到高排序一样。对于示例树，它将打印1, 2, 5, 7, 9, 10：

![穿越树](4)

#### 删除节点

删除节点很容易。删除节点后，我们将节点替换为==左侧最大子节点或右侧最小子节==点。这样，树在移除后仍然会被排序。在以下示例中，将删除10并替换为9（图2）或11（图3）。

![删除包含两个子节点的节点](5)

请注意，==当节点至少有一个子节点时，需要进行替换。如果它没有子节点，您只需将其与其父节点断开连接==：

![删除叶节点](6)

### 代码（解决方案1）

这个理论太多了。让我们看看如何在Swift中实现二叉搜索树。您可以采取不同的方法。首先，我将向您展示如何制作基于类的版本，但我们还将介绍如何使用枚举来实现同样的功能。

这是一个HLLBinarySearchTree类的示例：

    public class HLLHLLBinarySearchTree<T:Comparable> {
        
        /// 树的根节点的值
        private(set) public var value: T
        
        /// 父节点
        private(set) public var parent: HLLHLLBinarySearchTree?
        
        /// 左子树
        private(set) public var left: HLLHLLBinarySearchTree?
        
        /// 右子树
        private(set) public var right: HLLHLLBinarySearchTree?
        
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
    
==此类仅描述单个节点而不是整个树==。它是泛型类型，因此节点可以存储任何类型的数据。它也有它的引用left和right子节点和parent节点。

以下是如何使用它：

    let tree = HLLHLLBinarySearchTree < Int >（value：7）

该`count`属性确定此节点描述的子树中有多少个节点。这不仅仅计算节点的直接孩子，还计算他们的孩子和孩子的孩子，等等。如果此特定对象是根节点，则它计算整个树中有多少个节点。最初，count = 0。

注意：==因为left，right和parent是可选的，我们可以很好地利用Swift的可选链接（?）和零合并运算符（??）。你也可以写这种东西if let，但这不那么简洁。==

#### 插入节点

树节点本身是无用的，所以这里是如何向树添加新节点：

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
                    left = HLLHLLBinarySearchTree(value: value)
                    left?.parent = self
                }
            }else{
                if let right = right {
                    right.insert(value: value)
                }else{
                    right = HLLHLLBinarySearchTree(value: value)
                    right?.parent = self
                }
            }
        }
        
像许多其他树操作一样，插入最容易实现递归。我们将新值与现有节点的值进行比较，并决定是将其添加到左侧分支还是右侧分支。

如果没有更多的左或右子进行查看，我们`HLLBinarySearchTree`为新节点创建一个对象，并通过设置其`parent`属性将其连接到树。

注意：==因为二叉搜索树的整个点是左边有较小的节点而右边有较大的节点，所以你应该总是在根处插入元素，以确保它仍然是一个有效的二叉树！==

要从示例构建完整的树，您可以执行以下操作：

    let tree = HLLBinarySearchTree(value: 10)
    tree.insert(value: 11)
    tree.insert(value: 5)
    tree.insert(value: 7)
    

> 注意：由于稍后会明确的原因，您应该以随机顺序插入数字。如果按排序顺序插入它们，则树的形状将不正确。

为方便起见，我们添加一个init方法来调用insert()数组中的所有元素：

     public convenience init(array:[T]) {
            precondition(array.count > 0)
            self.init(value: array.first!)
            for v in array.dropFirst() {
                insert(value: v)
            }
        }
      
现在你可以简单地这样做：

    let tree = HLLBinarySearchTree(array: [7,2,5,10,9,1])

数组中的第一个值成为树的根。

#### 调试模式的输出

使用复杂的数据结构时，拥有人类可读的调试输出很有用。

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

当你这样做时print(tree)，你应该得到这样的东西：

    ((1) <- 2 -> (5)) <- 7 -> ((9) <- 10)

根节点位于中间。有了一些想象力，您应该看到这确实对应于以下树：

![](7)

您可能想知道插入重复项时会发生什么？我们总是在正确的分支中插入它们。试试看！

#### 树的搜索

现在我们在树上有一些价值，我们该怎么办？当然，搜索它们！快速查找项目是二叉搜索树的主要目的。:-)

这是执行search()：

    public func search(_ value: T) -> HLLBinarySearchTree? {
        if value < self.value {
            return left?.search(value)
        }else if value > self.value{
            return right?.search(value)
        }else{
            return self
        }
    }
  
我希望逻辑清楚：这从当前节点（通常是根节点）开始并比较值。如果搜索值小于节点的值，我们继续在左侧分支中搜索; 如果搜索值更大，我们会进入右分支。

如果没有更多的节点可以查看 - 当left或者right为nil时 - 那么我们返回nil以指示搜索值不在树中。

注意：==在Swift中，可以通过可选链接方便地完成; 当你left?.search(value)自动写它时，如果left是零，则返回nil。没有必要使用if语句明确检查这一点。==

搜索是一个递归过程，但您也可以使用简单的循环来实现它：

  public func search(_ value: T) -> HLLBinarySearchTree? {
    var node: HLLBinarySearchTree? = self
    while let n = node {
      if value < n.value {
        node = n.left
      } else if value > n.value {
        node = n.right
      } else {
        return node
      }
    }
    return nil
  }
  
验证您是否理解这两个实现是等效的。就个人而言，我更喜欢使用迭代代码而不是递归代码，但您的意见可能会有所不同。;-)

以下是如何测试搜索：

    tree.search(5)
    tree.search(2)
    tree.search(7)
    tree.search(6)   // nil


前三行返回相应的BinaryTreeNode对象。最后一行返回，nil因为没有带有值的节点6。

注意：如果树中存在重复项，则search()返回“最高”节点。这是有道理的，因为我们开始从根向下搜索。

#### 树的遍历

还记得有三种不同的方法可以查看树中的所有节点吗？他们来了：

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
  
它们都以不同的顺序工作。请注意，所有工作都是递归完成的。

要打印出从低到高排序的树的所有值，您可以编写：

    traverseInOrder { value in  print（value）}

这打印出以下内容：

    1
    2
    5
    7
    9
    10
    
您还可以向树中添加map()和filter()之类似的内容。例如，这是map的实现：

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
  
这将调用formula树中每个节点上的闭包，并在数组中收集结果。map()通过按顺序遍历树来工作。

一个非常简单的如何使用的例子map()：

      public  func  toArray（）- > [T] {
         return map { $ 0 }
      }
注意: ==使用return调用尾随闭包时,系统不会自动识别为随闭包,如果想使用尾随闭包,先不使用return, 写完闭包之后再把return加上==

这会将树的内容转换为已排序的数组。在操场上试一试：

    tree.toArray（）    // [ 1,2,5,7,9,10 ]

作为练习，看看你是否可以实现过滤和减少。

#### 删除节点

我们可以通过定义一些辅助函数来使代码更具可读性。

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

在更改树涉及到更改一堆parent和left和right指针。此功能有助于实现此功能。它接受当前节点的父节点 - 即self- 并将其连接到另一个节点，该节点将是其中一个子节点self。

我们还需要一个返回节点最小值和最大值的函数：


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

其余的代码是不言自明的：

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
    
#### 深度和高度
##### 概念
- 对于整棵树来说，最深的叶结点的深度就是树的深度；树根的高度就是树的高度。这样树的高度和深度是相等的。
- 对于树中相同深度的每个结点来说，它们的高度不一定相同，这取决于每个结点下面的叶结点的深度。
 
回想一下节点的高度是到最低叶子的距离。我们可以用以下函数来计算：

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
  
我们看一下左右分支的高度并取最高分。同样，这是一个递归过程。由于这会查看此节点的所有子节点，因此性能为O（n）。

试试看：

    tree.height（）   // 2

您还可以计算节点的深度，即到根的距离。这是代码：

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
    
它按照parent指针向上逐步穿过树，直到我们到达根节点（其parent为零）。这需要O（h）时间。这是一个例子：

    if let node9 = tree.search(9) {
        node9.depth()
    }


#### 前驱和后继

二叉搜索树总是“排序”，但这并不意味着连续的数字实际上在树中彼此相邻。

![](8)

请注意，7只需查看其左子节点，就无法找到之前的数字。左边的孩子2不是5。同样对于之后的数字7。

该predecessor()函数以排序顺序返回其值在当前值之前的节点：

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
    
    
如果我们有一个左子树很容易。在这种情况下，前一个前一个是该子树中的最大值。您可以在上面的图片中验证5确实7是左分支中的最大值。

如果没有左子树，那么我们必须查看父节点，直到找到一个较小的值。如果我们想知道前一个节点是什么9，我们会一直向上，直到找到第一个具有较小值的父节点，即7。

代码以successor()相同的方式工作但镜像：

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
    
这两种方法都在O（h）时间内运行。

注意：==有一种称为“线程”二叉树的变体，其中“未使用的”左右指针被重新用于在前任节点和后继节点之间建立直接链接。非常聪明！==

#### 搜索树有效性判断

如果您打算进行破坏，可以通过调用insert()非根节点将二叉搜索树变为无效树。这是一个例子：

    if let node1 = tree.search(1) {
      node1.insert(100)
    }

根节点的值是7，因此具有值的节点100必须位于树的右侧分支中。但是，您不是插入根，而是插入树左侧分支中的叶节点。所以新100节点在树中的错误位置！

结果，做`tree.search(100)`返回nil。

您可以使用以下方法检查树是否是有效的二叉搜索树：

      public func isBinarySearchTree(minValue: T, maxValue: T) -> Bool {
        if value < minValue || value > maxValue { return false }
        let leftBST = left?.isBinarySearchTree(minValue: minValue, maxValue: value) ?? true
        let rightBST = right?.isBinarySearchTree(minValue: value, maxValue: maxValue) ?? true
        return leftBST && rightBST
    }
    
这将验证左侧分支包含的值是否小于当前节点的值，右侧分支仅包含更大的值。

称其如下：

    if let node1 = tree.search(1) {
      tree.isBinarySearchTree(minValue: Int.min, maxValue: Int.max)  // true
      node1.insert(100)                                 // EVIL!!!
      tree.search(100)                                  // nil
      tree.isBinarySearchTree(minValue: Int.min, maxValue: Int.max)  // false
    }

### 使用枚举方式实现搜索二叉树

我们已将二叉树节点实现为类，但您也可以使用枚举。

区别在于引用语义与值语义。对基于类的树进行更改将更新内存中的相同实例，但基于枚举的树是不可变的 - 任何插入或删除都将为您提供树的全新副本。哪一个最好，完全取决于你想用它做什么。

以下是使用枚举创建二叉搜索树的方法：

    public enum HLLBST<T:Comparable> {
        case empty
        case leaf(T)
        indirect case node(HLLBST, T, HLLBST)
    }
    
枚举有三种情况：

- Empty标记分支的结尾（基于类的版本使用nil了对此的引用）。
- Leaf 对于没有子节点的叶节点。
- Node对于具有一个或两个子节点的节点。这标记indirect为可以保存HLLBinarySearchTree值。没有indirect你不能做递归枚举。

> 注意：此二叉树中的节点没有对其父节点的引用。这不是一个主要障碍，但它会使某些操作实施起来更加麻烦。

这个实现是递归的，枚举的每个情况都将被区别对待。例如，这是您可以计算树中节点数和树高的方法：

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

同样,和类一样我们可以自己实现树的最大值和最小值

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
    
插入新节点如下所示：

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

使用方式如下：

    var tree = HLLBST.Leaf(7)
    tree = tree.insert(2)
    tree = tree.insert(5)
    tree = tree.insert(10)
    tree = tree.insert(9)
    tree = tree.insert(1)

请注意，对于每次插入，都会返回一个新的树对象，因此需要将结果返回给tree变量。

这是最重要的搜索功能：

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
    
大多数这些功能具有相同的结构。

示例代码如下：

    tree.search(10)
    tree.search(1)
    tree.search(11)   // nil

要打印树以进行调试，可以使用以下方法：


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

当你这样做时print(tree)，它将如下所示：

((1 <- 2 -> 5) <- 7 -> (9 <- 10 -> .))

根节点位于中间，点表示该位置没有子节点。

当树变得不平衡时如何处理?

当二进制搜索树的左右子树包含相同数量的节点时，它是平衡的。在这种情况下，树的高度是log（n），其中n是节点数。这是理想的情况。

如果一个分支明显长于另一个分支，则搜索变得非常慢。我们最终检查的价值超出了我们的需要。在最坏的情况下，树的高度可以变为n。这样的树就像链接列表而不是二叉搜索树，性能降低到O（n）。不好！

使二进制搜索树平衡的一种方法是以完全随机的顺序插入节点。平均而言，应该很好地平衡树木，但不保证，也不总是实用。

另一种解决方案是使用自平衡二叉树。插入或删除节点后，此类型的数据结构会调整树以使其保持平衡。要查看示例，请检查[AVL树](https://github.com/raywenderlich/swift-algorithm-club/tree/master/AVL%20Tree)和[红黑树](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Red-Black%20Tree)。


本文参考自 [Swift算法与结构](https://github.com/raywenderlich/swift-algorithm-club)