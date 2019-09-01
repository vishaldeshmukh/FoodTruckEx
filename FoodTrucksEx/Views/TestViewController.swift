//
//  TestViewController.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/30/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import NotificationCenter
import UIKit
import SwiftUI



class TestViewController: UIViewController, NCWidgetProviding {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        //viewCtrl.rootView.
        
    }

//    @IBAction func buttonClick(_ sender: Any) {
//        let swiftUIView = ButtonContentView() // swiftUIView is View
//        let viewCtrl = UIHostingController(rootView: swiftUIView)
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBSegueAction func sequeToSwiftuI(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ButtonContentView())
    }
}
struct ViewControllerWrapper: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: TestViewController, context: UIViewControllerRepresentableContext<ViewControllerWrapper>) {
        
    }
    

    
    typealias UIViewControllerType = TestViewController
    



    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewControllerWrapper>) -> ViewControllerWrapper.UIViewControllerType {
        //return TestViewController()
        return UIStoryboard(name: "TestStoryboard", bundle: nil).instantiateViewController(identifier: String(describing: ViewControllerWrapper.self)) as! TestViewController

        }
    

}

struct ButtonContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button(action: {
            self.showingSheet = true
        }) {
            Text("Show Action Sheet")
        }
        .actionSheet(isPresented: $showingSheet) {
            ActionSheet(title: Text("What do you want to do?"), message: Text("There's only one choice..."), buttons: [.default(Text("Dismiss Action Sheet"))])
        }
    }
}
