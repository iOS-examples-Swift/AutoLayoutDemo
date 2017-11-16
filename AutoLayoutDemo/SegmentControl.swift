//
//  SegmentControl.swift
//  Pods
//
//  Created by Steve on 2017/7/3.
//
//

import SnapKit

public class SegmentControl: UIView {

    private var titles: [String] = []
    private var selectedIndex: ((Int) -> Void)?
    private var bottomLine: UIView!
    private var items: [UIButton] = []
    private var style: SetmentStyle!
    private var lastVeiw: UIButton?

    public init(style: SetmentStyle? = nil, titles: [String], selectedIndex: ((Int) -> Void)? = nil) {
        super.init(frame: .zero)
        self.titles = titles
        self.selectedIndex = selectedIndex
        self.style = style
        loadSubview()
    }

    func loadSubview() {
        self.backgroundColor = style.backgroundColor
        let itemWidth = UIScreen.main.bounds.width / CGFloat(titles.count)
        for (idx, title) in self.titles.enumerated() {
            let item = UIButton()
            item.tag = idx
            item.isSelected = idx == 0 ? true : false
            item.titleLabel?.font = self.style.titleFont
            item.setTitleColor(self.style.selectedColor, for: .selected)
            item.setTitleColor(self.style.normalColor, for: .normal)
            item.setTitle(title, for: .normal)
            item.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
            addSubview(item)
            self.items.append(item)
        }
        let margin = 10
        for (idx, item) in items.enumerated() {
            item.backgroundColor = UIColor.random
            if items.count < 2 { return }
            if idx == 0 {
                item.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalTo(self.snp.left).offset(margin)
                    make.width.equalTo(items[idx + 1])
                    make.right.equalTo(items[idx + 1].snp.left).offset(-margin)
                })
            } else if idx == items.count - 1 {
                item.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.right.equalTo(self.snp.right).offset(-margin)
                })
            } else {
                item.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.right.equalTo(items[idx + 1].snp.left).offset(-margin)
                    make.width.equalTo(items[idx + 1].snp.width)

                })
            }
        }
        let lineWidth = min(itemWidth, style.bottomLineMaxwidth)
        bottomLine = UIView()
        bottomLine.backgroundColor = style.selectedColor
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.centerX.equalTo(items[0].snp.centerX)
            make.width.equalTo(lineWidth)
            make.height.equalTo(2)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }

    }

    @objc func click(sender: UIButton)  {
        UIView.animate(withDuration: 0.3) {
            sender.isSelected = true
            self.items.filter({ $0.tag != sender.tag }).forEach({ $0.isSelected = false })
            self.bottomLine.center = CGPoint(x: sender.center.x, y: self.bottomLine.center.y)
        }
        self.selectedIndex?(sender.tag)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public struct SetmentStyle {

    var backgroundColor: UIColor = .white
    var bottomLineMaxwidth: CGFloat = 60
    var selectedColor: UIColor = UIColor.orange
    var normalColor: UIColor = UIColor.black
    var titleFont: UIFont = UIFont.systemFont(ofSize: 13.0)

    init(
        backgroundColor: UIColor? = .white,
        bottomLineMaxwidth: CGFloat? = 60,
        selectedColor: UIColor? = UIColor.orange,
        normalColor: UIColor? = UIColor.gray,
        titleFont: UIFont? = UIFont.systemFont(ofSize: 13.0)
        ) {
        self.backgroundColor = backgroundColor!
        self.bottomLineMaxwidth = bottomLineMaxwidth!
        self.selectedColor = selectedColor!
        self.normalColor = normalColor!
        self.titleFont = titleFont!
    }
}

extension UIColor {
    /// Returns random UIColor with random alpha(default: 1.0)
    static var random: UIColor {
        return UIColor(
            red: CGFloat(arc4random_uniform(256)) / CGFloat(255),
            green: CGFloat(arc4random_uniform(256)) / CGFloat(255),
            blue: CGFloat(arc4random_uniform(256)) / CGFloat(255),
            alpha: 1.0
        )
    }
}

public extension Array where Element: Equatable {
    
    /// The index method returns the first index at which a given element can be found in the array, or -1 if it is not present.
    ///
    /// - Parameter element: a given element
    /// - Returns: The index of the element at the array
    @discardableResult
    func index(of element: Element) -> Int {
        return index(of: element) ?? -1
    }
    
    /// Remove first collection element that is equal to the given `object`:
    ///
    /// - Parameter object: The element will remove form the array
    mutating func remove(_ object: Element) {
        if index(of: object) < 0 {
            return
        }
        remove(at: index(of: object))
    }
}

