//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by Lena on 2022/06/01.
//
import UIKit
import Kingfisher
import FirebaseDatabase

class CardListViewController: UITableViewController {
    var ref: DatabaseReference! // Firebase Realtime Database
    var creditCardList: [CreditCard] = [] // 전달된 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil) // nib 이름
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        // 이렇게 생성한 nib name을 가지는 것에 register를 한다
        ref = Database.database().reference()
        // firebase가 우리의 database를 잡아내고 앞으로의 데이터 흐름들을 주고받는다
        
        ref.observe(.value) { snapshot in
            // snapshot 이용해서 데이터를 불러온다
            // 레퍼런스에서 값을 지켜보고 있다가 객체를 이용한다.
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                
                // 이렇게 가져온 카드리스트를 미리 만들어놓은 creditcard list에 넣어준다
                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
                
                // 테이블뷰 리로드 해줄 것임 (UI의 움직임)
                // 메인스레드에서 작동해야 하므로 dispatchQueue를 해준 것 
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                } // 테이블뷰 업데이트
                
            } catch let error {
                print("ERROR JSON parsing \(error.localizedDescription)")
            }
        }
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
    
    // 각 셀이 표현하고 있는 상세화면으로 갈 수 있도록 전달해줄 델리게이트
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController else { return }
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
    }
}
