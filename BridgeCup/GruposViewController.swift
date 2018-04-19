//
//  GruposViewController.swift
//  BridgeCup
//
//  Created by Leonardo Schlüter on 18/04/18.
//  Copyright © 2018 Bridge. All rights reserved.
//

import UIKit

class GrupoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, OnSyncFinishedListener  {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!

    var grupos: [Grupo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.text]
        self.table.dataSource = self
        self.table.delegate = self
        SyncGrupos(year: 2018, listener: self).sync()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // usado para recacular a altura da tabela baseado na quantidade de itens
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.grupos.count
    }

    // atualiza uma celula da tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrupoTableViewCell", for: indexPath) as! GrupoTableViewCell
        cell.setFieldValue(grupo: self.grupos[indexPath.item])
        return cell
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.table.reloadData()
    }

    // altura de cada celula da tabela
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }


    func onGruposSyncFinished(grupos: [Grupo]) {
        self.grupos = grupos
        self.table.reloadData()
    }
}

