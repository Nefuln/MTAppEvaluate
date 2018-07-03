//
// ViewController.swift

// 日期：2018/7/3.
// 作者：Nolan   

import UIKit

class ViewController: UIViewController, MTAppEvaluateProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        btn.setTitle("好评", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(ViewController.handleTapAction), for: UIControlEvents.touchUpInside)
        btn.center = self.view.center
        self.view.addSubview(btn)
    }
    
    lazy var appEvaluateMgr: MTAppEvaluateManager = {
        let mgr = MTAppEvaluateManager(appID: "1257686774", type: MTAppEvaluateType.Alert, delegate: self)
        return mgr
    }()
}

extension ViewController {
    @objc fileprivate func handleTapAction() {
        self.appEvaluateMgr.show()
    }
}

