//
//  AppDelegate.swift
//  Budgie
//
//  Created by Fredrik Lillejordet on 15.06.2017.
//  Copyright © 2017 Fredrik Lillejordet. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var timer = Timer()
    var currency = "ETH"
    var cryptos : [Crypto] = []
    let tickers = ["ETH", "BTC" , "IOT"]
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    @IBOutlet weak var menu: NSMenu!
    
    func updateItems(){
        DispatchQueue.main.async {
            for item in self.menu.items {
                for crypto in self.cryptos{
                    
                    if item.title == crypto.symbol {
                        let label = "\(crypto.symbol) : $\(crypto.price_usd!) : \(crypto.percent_change_1h!)% "
                        
                        item.title = label
                        
                        if crypto.symbol == self.currency {
                            self.statusItem.title = label
                        }
                    }
                }
            }
        }
        
    }
    
    func updateTitle(title: String) {
         if self.cryptos.count > 0 {
            currency = title
            DispatchQueue.main.async {
                self.statusItem.title = title
            }
        }
    }
    
    @objc private func update() {
        let endpoint = "https://api.coinmarketcap.com/v1/ticker/"
        let request = URLRequest(url: URL(string: endpoint)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard error == nil else {return}
            guard let responseData = data else {return}
            
            do{
                self.cryptos = try JSONDecoder().decode([Crypto].self, from: responseData)
                if self.cryptos.count > 0 {
                    self.updateItems()
                }else{
                    self.updateTitle(title: "Connection error")
                }
            }catch{
                self.updateTitle(title: "Connection error")
            }
        })
        
        task.resume()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        updateTitle(title: "loading")
        statusItem.menu = menu
        currency = "ETH"
        self.update()
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
}

