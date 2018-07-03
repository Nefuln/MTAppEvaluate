//
// MTAppEvaluateProtocol.swift

// 日期：2018/7/3.
// 作者：Nolan   

import UIKit

protocol MTAppEvaluateProtocol {
    
    /// 显示的评论提示的AlertController
    ///
    /// - Parameters:
    ///   - comment: 去吐槽的事件触发回调
    ///   - like: 去好评的事件触发回调
    /// - Returns: 显示的评论提示的AlertController
    func MT_AppEvaluateTipAlert(comment: (()->Void)?, like: (()->Void)?) -> UIAlertController
    
    /// 吐槽的页面
    ///
    /// - Returns: 吐槽的页面，不实现或传nil跳转到AppStore撰写评论页
    func MT_AppEvaluateCommentViewController() -> UIViewController?
}

// MARK: - 默认实现
extension MTAppEvaluateProtocol {
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
    
    func MT_AppEvaluateCommentViewController() -> UIViewController? {
        return nil
    }
}
