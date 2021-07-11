//
//  ViewController.swift
//  tictactoehame
//
//  Created by Shazad Babaycon on 07/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl_turn: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    var board = [String]()
   
    var currentplayer = ""
    var players = [String]()
    

    
    let rules = [[0,1,2],
                 [3,4,5],
                 [6,7,8],
                 [0,3,6],
                 [1,4,7],
                 [2,5,8],
                 [0,4,8],
                 [2,4,6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterplayers()
        loadboard()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        enterplayers()
        lbl_turn.text = currentplayer
        
        
    }
    
    @IBAction func btn_crossround(_ sender: UIButton) {
        let player1 = players[0]
        let player2 = players[1]
        
        let index = buttons.firstIndex(of:sender)!
        
        if !board[index].isEmpty {
            return
        }
            if  currentplayer == player1
            {
            lbl_turn.text = player1
            sender.setTitle("X", for: .normal)
            currentplayer = player2
            board[index] = player2
            }
            else 
            {
            lbl_turn.text = player2
            sender.setTitle("O", for: .normal)
            currentplayer = player1
            board[index] = player1
            }
            win()
    }
    
    @IBAction func btn_reset(_ sender: Any) {
        reset()
    }
}
    
extension ViewController
{

    func enterplayers(){
        let alert = UIAlertController(title: "Welcome", message: "Enter Players Name", preferredStyle:.alert )
        alert.addTextField(configurationHandler: {player1 in
            player1.placeholder="Enter Player 1 Name:"
            player1.textAlignment = .center
            
        })
        alert.addTextField(configurationHandler: {player2 in
            player2.placeholder="Enter Player 2 Name:"
            player2.textAlignment = .center
            
        })
        let ok = UIAlertAction(title: "OK", style: .default) {ACTION in
            self.players.append(alert.textFields![0].text!)
            self.players.append(alert.textFields![1].text!)
            self.lbl_turn.text = alert.textFields![0].text!
        }
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
        
    }
    
  
    
    
    func showalert(msg:String){
            let alert = UIAlertController(title: "Results", message: msg, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.reset()
                })
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        
        func reset(){
            board.removeAll()
            loadboard()
            players.removeAll()
            enterplayers()
            for button in buttons {
                button.setTitle(nil, for: .normal)
            }
        }
        func win(){
            for rule in rules {
                let playerat0 = board[rule[0]]
                let playerat1 = board[rule[1]]
                let playerat2 = board[rule[2]]
                
                if playerat0 == playerat1,
                playerat1 == playerat2,
                !playerat0.isEmpty {
                    print("Winner is \(playerat0)")
                    showalert(msg: "Winner is \(playerat0)")
                }
            }
            if !board.contains("") {
                showalert(msg:"Its a tie")
            }
        }
        
        func loadboard (){
            for i in 0..<buttons.count {
                board.append("")
            }
        }
        
    }
    
    

