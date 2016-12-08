//
//  ViewController.swift
//  TurtleLeaps
//
//  Created by kvanadev5 on 08/12/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*world kvana*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "SignInViewController"), animated: true)
    }


}

