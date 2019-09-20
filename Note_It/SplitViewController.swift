//
//  SplitViewController.swift
//  Note_It
//
//  Created by Dominic Egginton on 20/09/2019.
//  Copyright © 2019 Dominic Egginton. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set split view to be visable and not sliding
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    // delegate method to disaply tabeel view as primary view when loading app
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
