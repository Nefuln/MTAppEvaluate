//
// ViewController.swift

// 日期：2018/7/3.
// 作者：Nolan   

import UIKit

class ViewController: UIViewController {

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
        let mgr = MTAppEvaluateManager(appID: "1257686774", type: MTAppEvaluateType.OutApp, delegate: self)
        return mgr
    }()

}

extension ViewController {
    @objc fileprivate func handleTapAction() {
        self.appEvaluateMgr.show()
    }
}

extension ViewController: MTAppEvaluateProtocol {
    func MT_AppEvaluateTipAlert(comment: (()->Void)?, like: (()->Void)?) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "给个五星好评吧~", preferredStyle: UIAlertControllerStyle.alert)
        let commentAction = UIAlertAction(title: "我要吐槽", style: UIAlertActionStyle.default) { (action) in
            comment?()
        }
        let waitAction = UIAlertAction(title: "看看再说", style: UIAlertActionStyle.default, handler: nil)
        let admireAction = UIAlertAction(title: "给好评", style: UIAlertActionStyle.cancel) { (action) in
            like?()
        }
        alert.addAction(commentAction)
        alert.addAction(waitAction)
        alert.addAction(admireAction)
        return alert
    }
}

