//
//  ViewController.swift
//  BridgeCup
//
//  Created by Leonardo Schlüter on 18/04/18.
//  Copyright © 2018 Bridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, OnSyncFinishedListener {

    @IBOutlet weak var table: UITableView!
    var grupos: [Grupo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.dataSource = self
        self.table.delegate = self
        SyncGrupos(year: 2018, listener: self).sync()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.grupos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrupoTableViewCell", for: indexPath) as! GrupoTableViewCell
        cell.setFieldValue(grupo: self.grupos[indexPath.item])
        return cell
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.table.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }


    func onGruposSyncFinished(grupos: [Grupo]) {
        self.grupos = grupos
        self.table.reloadData()
    }
}

