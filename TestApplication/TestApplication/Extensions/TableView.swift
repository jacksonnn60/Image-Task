//
//  TableView.swift
//  TestApplication
//
//  Created by Jackie basss on 28.06.2021.
//

import UIKit

extension UITableView {
    func refresh(cell row: Int, with animation: RowAnimation) {
        self.beginUpdates()
        self.reloadRows(at: [IndexPath(row: row, section: 0)], with: animation)
        self.endUpdates()
    }
}
