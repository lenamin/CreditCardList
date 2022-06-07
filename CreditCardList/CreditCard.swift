//
//  CreditCard.swift
//  CreditCardList
//
//  Created by Lena on 2022/06/07.
//

import Foundation

struct CreditCard: Codable {
    let id: Int
    let rank: Int
    let name: String
    let cardImageURL: String
    let promotionDetail: PromotionDetail // 객체 안에 객체가 있으므로
    let isSelected: Bool? // 추후 카드를 선택했을 때 생성될 것, 그 전까지는 nil로 되어있어야 하므로 옵셔널로 선언
}

struct PromotionDetail: Codable {
    let companyName: String
    let period: String
    let amount: Int
    let condition: String
    let benefitCondition: String
    let benefitDate: String
}
