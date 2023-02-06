//
//  PDF Viewer.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit
import PDFKit

class PDFViewer: UIViewController{
    let viewer = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(viewer)
        view.backgroundColor = .white
        viewer.contentMode = .scaleAspectFit
        viewer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func config(name: String){
        viewer.image = UIImage(named: name)
    }
}
