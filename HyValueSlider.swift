//
//  HyValueSlider.swift
//  GLKViewTest
//
//  Created by hopy on 2019/1/27.
//  Copyright © 2019 hopy. All rights reserved.
//

import UIKit

/// 带值显示的Slider控件
class HyValueSlider:UISlider{
    private var valueLbl:UILabel!
    // 值文本的颜色
    var valueTextColor:UIColor = .gray{
        didSet{
            valueLbl.textColor = valueTextColor
        }
    }
    
    // 值文本的字体
    var valueTextFont:UIFont = UIFont.systemFont(ofSize: 12){
        didSet{
            valueLbl.font = valueTextFont
        }
    }
    
    // 返回把手当前所在的Rect
    private var thumbRect:CGRect{
        let trackRect = self.trackRect(forBounds: self.bounds)
        let thumbRect = self.thumbRect(forBounds: self.bounds, trackRect: trackRect, value: self.value)
        //let rectInView = view.convert(thumbRect, from: slider)
        return thumbRect
    }
    
    // 返回把手的大小
    private var thumbSize:CGSize{
        return thumbRect.size
    }
    
    // 更新valueLbl中显示的值
    private func updateValueLbl(){
        let valueString = String(format: "%.1f", self.value)
        valueLbl.text = "\(valueString)"
    }
    
    // 每次拖动把手都会调用layoutSubviews()
    override func layoutSubviews() {
        super.layoutSubviews()
        let rect = thumbRect
        let center = CGPoint(x: rect.midX, y: rect.midY)
        valueLbl.center = center
        updateValueLbl()
        // 需要在layoutSubviews()中将valueLbl前置,在setup()中无效
        self.bringSubview(toFront: valueLbl)
    }
    
    // Slider内部的初始化设置
    private func setup(){
        valueLbl = UILabel(frame: CGRect(origin: .zero, size: thumbSize))
        valueLbl.textAlignment = .center
        valueLbl.textColor = valueTextColor
        valueLbl.font = valueTextFont
        //valueLbl.text = "1.0"
        
        valueLbl.shadowColor = .darkGray
        valueLbl.shadowOffset = CGSize(width: 0.5, height: 0.5)
        
        self.addSubview(valueLbl)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
