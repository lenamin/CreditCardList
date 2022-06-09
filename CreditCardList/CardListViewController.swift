//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by Lena on 2022/06/01.
//
import UIKit
import Kingfisher

class CardListViewController: UITableViewController {
    var creditCardList: [CreditCard] = [] // 전달된 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil) // nib 이름
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        // 이렇게 생성한 nib name을 가지는 것에 register를 한다
    }
    
    // 데이터를 셀에 전달한다
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 카드배열의 인덱스 수가 곧 테이블뷰의 row수
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() }
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        // Kingfisher에서 이미지를 불러오기 위해 우선 imageURL을 만든다
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        // string을 URL 타입으로 타입변환 해줌
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    // 셀의 높이 지정하기
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
