//
//  NewsViewController.swift
//  Ultimate
//
//  Created by Kenta Kawaguchi on 1/8/17.
//  Copyright © 2017 Kenta Kawaguchi. All rights reserved.
//

import UIKit
import TwitterKit

class NewsViewController: TWTRTimelineViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        self.dataSource = TWTRListTimelineDataSource(listSlug: "ultimate", listOwnerScreenName: "ultimatebot16", apiClient: client)
        
    }
}

