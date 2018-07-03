//
// MTAppEvaluateProtocol.swift

// 日期：2018/7/3.
// 作者：Nolan   

import UIKit

protocol MTAppEvaluateProtocol {
    func MT_AppEvaluateTipAlert(comment: (()->Void)?, like: (()->Void)?) -> UIAlertController
}

extension MTAppEvaluateProtocol {
    func MT_AppEvaluateTipAlert(comment: (()->Void)?, like: (()->Void)?) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "给个五星好评吧~", preferredStyle: UIAlertControllerStyle.alert)
        let commentAction = UIAlertAction(title: "我要吐槽", style: UIAlertActionStyle.default) { (action) in
            comment?()
        }
        let waitAction = UIAlertAction(title: "", style: UIAlertActionStyle.default, handler: nil)
        let admireAction = UIAlertAction(title: "", style: UIAlertActionStyle.cancel) { (action) in
            like?()
        }
        alert.addAction(commentAction)
        alert.addAction(waitAction)
        alert.addAction(admireAction)
        return alert
    }
}
