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

    public init(style: SetmentStyle? = SetmentStyle(), titles: [String], selectedIndex: ((Int) -> Void)? = nil) {
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
        for (idx, item) in items.enumerated() {
            if items.count < 2 { return }
            if idx == 0 {
                item.snp.makeConstraints({ (make) in
                    make.left.top.bottom.equalTo(self)
                    make.width.equalTo(items[idx + 1])
                    make.right.equalTo(items[idx + 1].snp.left)
                })
            } else if idx == items.count - 1 {
                item.snp.makeConstraints({ (make) in
                    make.right.top.bottom.equalTo(self)
                    make.width.equalTo(items[idx - 1])
                })
            } else {
                item.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(self)
                    make.left.equalTo(items[idx - 1].snp.right)
                    make.width.equalTo(items[idx - 1].snp.width)
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

    func click(sender: UIButton)  {
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
    var normalColor: UIColor = UIColor.gray
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


