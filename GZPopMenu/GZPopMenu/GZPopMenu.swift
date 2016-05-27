//
//  GZPopMenu.swift
//  GZPopMenu
//
//  Created by 李果洲 on 16/5/19.
//  Copyright © 2016年 李果洲. All rights reserved.
//

import UIKit
typealias ClickMenuItemHandler = () -> Void
class GZPopMenu: UITableView,UITableViewDataSource,UITableViewDelegate {
    /// 灰色背景
    var bgView:UIControl!
    /// 每个item的图片和名称及点击事件数组
    var itemTitlesAndImagesAndActions:[(name:String,image:UIImage?,handler:ClickMenuItemHandler)]
    init(frame: CGRect, style: UITableViewStyle,itemTitlesAndImagesAndActions:[(name:String,image:UIImage?,handler:ClickMenuItemHandler)]) {
        self.itemTitlesAndImagesAndActions = itemTitlesAndImagesAndActions
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.bounces = false
        // 这个地方的高度大小根据需要进行修改
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: heightForFooter))
        let line = UIView(frame: CGRect(x: 20, y: 0, width:self.frame.size.width - 40, height: 1))
        line.backgroundColor = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1)
        footerView.addSubview(line)
        let cancleButton = UIButton(frame: CGRect(x: (footerView.frame.size.width - 48) / 2, y: 0, width: 48, height: 48))
        cancleButton.addTarget(self, action: #selector(hindenMenu), forControlEvents: .TouchUpInside)
        cancleButton.setBackgroundImage(UIImage(named: "line_detail_ctrl_close"), forState: .Normal)
        footerView.addSubview(cancleButton)
        self.separatorStyle = .None
        self.tableFooterView = footerView
        self.bgView = UIControl(frame:UIScreen.mainScreen().bounds)
        self.bgView.backgroundColor = UIColor.blackColor()
        self.bgView.alpha = 0.3
        self.bgView.addTarget(self, action: #selector(hindenMenu), forControlEvents: .TouchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemTitlesAndImagesAndActions.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GZPopMenuCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        var icon:UIImageView!
        var item:UILabel!
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            icon = UIImageView(frame: CGRect(x: 20, y: 10, width: 30, height: 30))
            icon.tag = 25
            item = UILabel(frame: CGRect(x: 70, y: 10, width: self.frame.size.width - 80, height: 30))
            item.tag = 26
        }
        else{
            icon = cell?.viewWithTag(25) as! UIImageView
            item = cell?.viewWithTag(26) as! UILabel
        }
        let infor = self.itemTitlesAndImagesAndActions[indexPath.row]
        icon.image = infor.image
        item.text = infor.name
        cell?.addSubview(icon)
        cell?.addSubview(item)
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForRow
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.hindenMenu()
        let action = self.itemTitlesAndImagesAndActions[indexPath.row].handler
        action()
    }
    /// 显示菜单
    func showMenuInView(view:UIView){
        if self.superview != nil {
            self.bgView.hidden = false
        }else{
            view.addSubview(self.bgView!)
            self.frame = CGRect(x: self.frame.origin.x, y: UIScreen.mainScreen().bounds.height, width: self.frame.size.width, height: self.frame.size.height)
            view.addSubview(self)
        }
        UIView.animateWithDuration(0.25) {
            self.frame = CGRect(x: self.frame.origin.x, y:UIScreen.mainScreen().bounds.height - self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    /// 隐藏菜单
    func hindenMenu(){
        
        UIView.animateWithDuration(0.25) {
            self.frame = CGRect(x: self.frame.origin.x, y: UIScreen.mainScreen().bounds.height, width: self.frame.size.width, height: self.frame.size.height)
            self.bgView.hidden = true
        }
 
    }
    /// 修改某行的标题和图标以及事件响应
    func setCellNameAndImage(nameAndImage:(name:String,image:UIImage?,handler:ClickMenuItemHandler),index:Int)
    {
        self.itemTitlesAndImagesAndActions.removeAtIndex(index)
        self.itemTitlesAndImagesAndActions.insert(nameAndImage, atIndex: index)
        self.reloadData()
    }
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
