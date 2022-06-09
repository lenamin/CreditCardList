//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by Lena on 2022/06/09.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController {
    var promotionDetail: PromotionDetail?
    // 해당 라벨에 받아올 값들을 가져올 변수 선언
    
    @IBOutlet weak var lottieView: AnimationView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "money") // 1. animationView 선언 및 가져올 json 파일 이름
        lottieView.contentMode = .scaleToFill
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop // 반복 설정
        animationView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = promotionDetail else { return }
        // 만약 못받을 경우를 대비해 옵셔널 처리
        titleLabel.text = """
        \(detail.companyName)카드 쓰면
        \(detail.amount)만원 드려요
        """
        periodLabel.text = detail.period
        conditionLabel.text = detail.condition
        benefitLabel.text = detail.benefitCondition
        // benefitDetailLabel.text = detail.benefitDetail
        benefitDateLabel.text = detail.benefitDate
    }
}
