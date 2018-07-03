//
// MTAppEvaluateManager.swift

// 日期：2018/7/3.
// 作者：Nolan   

import UIKit
import StoreKit

enum MTAppEvaluateType {
    case Alert      // 弹窗样式，只在10.3以上系统适用，10.3以下此模式==InApp
    case InApp      // App内跳转到App Store评论页面
    case OutApp     // App跳转到App Store评论页面
}

class MTAppEvaluateManager: NSObject {
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - appID: AppStore的产品ID
    ///   - type: 评论的样式
    ///   - delegate: 代理
    init(appID: String, type: MTAppEvaluateType = .Alert, delegate: MTAppEvaluateProtocol) {
        self.appID = appID
        self.type = type
        self.delegate = delegate
        super.init()
    }
    
    /// AppStore的产品ID
    var appID: String
    
    /// 评论的样式
    var type: MTAppEvaluateType
    
    /// 协议
    fileprivate(set) var delegate: MTAppEvaluateProtocol
    
    /// 弹出的基于评论页面
    var baseViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
    
    /// App内部评论控制器
    fileprivate lazy var storeProductVC: SKStoreProductViewController = {
        let vc = SKStoreProductViewController()
        vc.delegate = self
        return vc
    }()
    
    /// 展示评论弹窗
    public func show() {
        let alert = self.delegate.MT_AppEvaluateTipAlert(comment: { [weak self] in
            guard let commentVC = self?.delegate.MT_AppEvaluateCommentViewController() else {
                self?.commentByAppStore()
                return
            }
            self?.baseViewController?.present(commentVC, animated: true, completion: nil)
        }) { [weak self] in
            self?.showEvaluate()
        }
        self.baseViewController?.present(alert, animated: true, completion: nil)
    }
}

extension MTAppEvaluateManager {
    
    /// 展示评论页面
    fileprivate func showEvaluate() {
        switch self.type {
        case .Alert:
            self.showByAlert()
        case .InApp:
            self.showByInApp()
        case .OutApp:
            self.showByOutApp()
        }
    }
    
    fileprivate func commentByAppStore() {
        let urlStr = "https://itunes.apple.com/us/app/id\(self.appID)?ls=1&mt=8&action=write-review"
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.openURL(url)
    }
    
    /// App内部弹窗，只支持10.3以上系统，10.3以下系统自动转为App内部评论
    private func showByAlert() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            self.showByInApp()
        }
    }
    
    /// App内部评论
    private func showByInApp() {
        self.storeProductVC.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier : self.appID]) { (isSuccess, error) in
            if error != nil {
                debugPrint("无法打开评论页面")
                return
            }
            self.baseViewController?.present(self.storeProductVC, animated: true, completion: nil)
        }
    }
    
    /// 跳转到AppStore评论
    private func showByOutApp() {
        let urlStr = "https://itunes.apple.com/us/app/id\(self.appID)?ls=1&mt=8"
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.openURL(url)
    }
}

// MARK: - SKStoreProductViewControllerDelegate
extension MTAppEvaluateManager: SKStoreProductViewControllerDelegate {
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        self.storeProductVC.dismiss(animated: true, completion: nil)
    }
}
