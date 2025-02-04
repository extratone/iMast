//
//  AddAccountSelectLoginMethodViewController.swift
//  iMast
//
//  Created by rinsuki on 2017/04/23.
//  
//  ------------------------------------------------------------------------
//
//  Copyright 2017-2019 rinsuki and other contributors.
// 
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
// 
//      http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import SafariServices
import Eureka
import iMastiOSCore

class AddAccountSelectLoginMethodViewController: FormViewController {
    
    var app: MastodonApp!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.Login.Authorize.title
        
        let authMethodSection = Section {
            ButtonRow { row in
                row.title = L10n.Login.Authorize.Method.safari
                row.cellUpdate { cell, row in
                    cell.accessibilityIdentifier = "loginWithSafari"
                    cell.textLabel?.textAlignment = .left
                    cell.accessoryType = .disclosureIndicator
                    cell.textLabel?.textColor = nil
                }
                row.onCellSelection { [weak self] cell, row in
                    self?.safariLoginButton(prefersEphemeralWebBrowserSession: false)
                }
            }
            ButtonRow { row in
                row.title = L10n.Login.Authorize.Method.safariEphemeral
                row.cellUpdate { cell, row in
                    cell.accessibilityIdentifier = "loginWithSafariEphemeral"
                    cell.textLabel?.textAlignment = .left
                    cell.accessoryType = .disclosureIndicator
                    cell.textLabel?.textColor = nil
                }
                row.onCellSelection { [weak self] cell, row in
                    self?.safariLoginButton(prefersEphemeralWebBrowserSession: true)
                }
            }
        }
        
        let tosSection = Section(header: L10n.Login.Authorize.Tos.header) {
            OpenSafariRow(title: L10n.Login.Authorize.Tos.rules, url: URL(string: "https://\(app.instance.hostName)/about/more")!)
            OpenSafariRow(title: L10n.Login.Authorize.Tos.termsOfService, url: URL(string: "https://\(app.instance.hostName)/terms")!)
        }
        
        form.append {
            authMethodSection
            tosSection
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var loginSafari: LoginSafari?
    
    func safariLoginButton(prefersEphemeralWebBrowserSession: Bool) {
        loginSafari = getLoginSafari()
        loginSafari?.open(
            url: self.app!.getAuthorizeUrl(),
            viewController: self,
            prefersEphemeralWebBrowserSession: prefersEphemeralWebBrowserSession
        )
    }
}
