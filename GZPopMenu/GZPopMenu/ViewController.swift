//
//  ViewController.swift
//  GZPopMenu
//
//  Created by 李果洲 on 16/5/19.
//  Copyright © 2016年 李果洲. All rights reserved.
//

import UIKit

let screenBounds = UIScreen.mainScreen().bounds
let heightForRow:CGFloat = 50
let heightForFooter:CGFloat = 48
class ViewController: UIViewController{
    
    var menuView:GZPopMenu!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setMenu()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    /// 初始化菜单选项 需要几个选项传几个选项
    func setMenu(){
        // 这里图片名称是否写成枚举？
        let collectImage = UIImage(named: "line_detail_ctrl_collect")
        let cancleColletctImage = UIImage(named: "line_detail_ctrl_collect_cancel")
        let deleteImage = UIImage(named: "line_detail_ctrl_delete")
        let unionImage = UIImage(named: "line_detail_ctrl_union")
        let downloadAllimage = UIImage(named: "line_detail_ctrl_download_all")
        let downloadMapImage = UIImage(named: "line_detail_ctrl_download_map")
        let downloadLineInamge = UIImage(named: "line_detail_ctrl_download_line")
        let editImage = UIImage(named: "line_detail_ctrl_edit")
        let navImage = UIImage(named: "line_detail_ctrl_nav")
        /// 菜单控件的菜单名字图片点击动作集合
        var itemsTitlesAndImagesAndActions :[(name:String,image:UIImage?,handler:ClickMenuItemHandler)] = []
        /// 某个选项的名字图片点击动作
        for i  in 0...7 {
            var singleItem:(name:String,image:UIImage?,handler:ClickMenuItemHandler)? = nil
            switch i {
//            case 0:
//                let action =  {
//                    print("点击了取消收藏")
//                }
//                singleItem = ("取消收藏",cancleColletctImage,action)
            case 1:
                let action =  {
                    print("点击了收藏")
                }
                singleItem = ("收藏",collectImage,action)
            case 2:
                let action =  {
                    print("点击了删除")
                }
                singleItem = ("删除",deleteImage,action)
            case 3:
                let action =  {
                    print("点击了合并")
                }
                singleItem = ("合并",unionImage,action)
            case 4:
                let action =  {
                    print("点击了下载全部")
                }
                singleItem = ("下载全部",downloadAllimage,action)
            case 5:
                let action =  {
                    print("点击了下载地图")
                }
                singleItem = ("下载地图",downloadMapImage,action)
            case 6:
                let action =  {
                    print("点击了下载路线")
                }
                singleItem = ("下载路线",downloadLineInamge,action)
//            case 7:
//                let action =  {
//                    print("点击了编辑")
//                }
//                singleItem = ("编辑",editImage,action)
//            case 8:
//                let action =  {
//                    print("点击了导航")
//                }
//                singleItem = ("导航",navImage,action)
            default:
                break
            }
            // 保证不为空才添加
            if singleItem != nil{
                itemsTitlesAndImagesAndActions.append(singleItem!)
            }
        }
        // 菜单选项的顺序为添加的顺序第一个添加的在最上面
        // 每一个选项的高度为50 多少个选项多少个50, 底部的x占48的大小
        let height:CGFloat = CGFloat(itemsTitlesAndImagesAndActions.count) * heightForRow + heightForFooter
        let popMenu = GZPopMenu(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: height), style: .Plain, itemTitlesAndImagesAndActions: itemsTitlesAndImagesAndActions)
        // 这个地方应该是最顶层的superview
        self.menuView = popMenu
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        self.menuView.showMenuInView(self.view)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func clickItemWithIndex(index: Int) {
        
        print(index)
    }
    
}

