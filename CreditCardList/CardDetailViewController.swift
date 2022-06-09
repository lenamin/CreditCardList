//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by Lena on 2022/06/09.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController {
    
    @IBOutlet weak var lottieView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "money") // 1. animationView 선언 및 가져올 json 파일 이름
        lottieView.contentMode = .scaleToFill
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop // 반복 설정
        animationView.play()
    }
}
