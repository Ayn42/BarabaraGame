//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by 福井彩乃 on 2020/05/07.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var imgView1: UIImageView!//上の画像
    @IBOutlet var imgView2: UIImageView!//真ん中の画像
    @IBOutlet var imgView3: UIImageView!//下の画像
    @IBOutlet var resultLabel: UILabel!//スコアを表示するラベル
    @IBAction func stop(){ //ストップボタンを押したら
        if timer.isValid == true{//もしタイマーが動いていたら
            timer.invalidate()}
        for i in 0..<3{
            score = score - abs(Int(width/2 - positionX[i]))*2}//スコアの計算をする
        resultLabel.text = "Score : " + String(score)//結果ラベルにスコアを表示する
        resultLabel.isHidden = false //結果ラベルを隠さない＝表す
        
        let highScore1: Int = defaults.integer(forKey: "score1")//ユーザデフォルトにscore1というキーの値を取得
        let highScore2: Int = defaults.integer(forKey: "score2")
        let highScore3: Int = defaults.integer(forKey: "score3")
        
        if score > highScore1{//ランキング１位の記録を更新したら
            defaults.set(score, forKey:"score1")//score1というキーでscoreを保存
            defaults.set(highScore1, forKey:"score2")//score2で元一位の記録を保存
            defaults.set(highScore2, forKey:"score3")}//score3でhighscore2を保存
        else if score > highScore2{//ランキング2位の記録を更新したら
            defaults.set(score, forKey:"score2")//score2というキーでscoreを保存
            defaults.set(highScore2, forKey:"score3")//score3で元2位を保存
        }
        else if score > highScore3{
            defaults.set(score, forKey:"score3")//score3というキーでscoreを保存
        }
    }
    @IBAction func retry(){
        score = 1000//スコアの値をリセットする
        positionX = [width/2, width/2, width/2]//画像の位置を真ん中に戻す
        if timer.isValid == false{
            self.start()}
    }
    @IBAction func toTop(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func up(){
              for i in 0..<3{  //端にきたら動かす向きを逆にする
                if positionX[i] > width || positionX[i] < 0{
                    dx[i] = dx[i] * (-1)
                }
              positionX[i] += dx[i] //画像の位置をdx分ずらす
          }
    imgView1.center.x = positionX[0]//上の画像をずらした位置に移動させる
    imgView2.center.x = positionX[1]//真ん中の画像をずらした位置に移動させる
    imgView3.center.x = positionX[2]//下の画像をずらした位置に移動させる
    }
    var timer: Timer! //画像を動かすためのタイマー
    var score: Int = 1000 //スコアの値
    let defaults: UserDefaults = UserDefaults.standard //スコアを保存するための変数
    
    let width: CGFloat = UIScreen.main.bounds.size.width //画面幅
    
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]//画像の位置の配列
    
    var dx: [CGFloat] = [1.0, 0.5, -1.0]//画像を動かす幅の配列
    
    func start(){
        //結果を見えなくする
        resultLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self,
                                     selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2]//画像の位置を画面幅の中心にする
        self.start()//前ページで書いたstartというメソッドを呼び出す

        // Do any additional setup after loading the view.
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
