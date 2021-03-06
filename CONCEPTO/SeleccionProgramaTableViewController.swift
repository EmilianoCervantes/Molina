//
//  SeleccionProgramaTableViewController.swift
//  CONCEPTO
//
//  Created by Alfredo on 3/24/17.
//  Copyright © 2017 Alfredo. All rights reserved.
//

import UIKit

class SeleccionProgramaTableViewController: UITableViewController {

    //paso 8 definir direccion
    //let direccion = "http://199.233.252.86/datos/datos.json"
    var direccion = "http://conceptoradial.000webhostapp.com/json/podcasts3.json"
    
    var datos = ["Podcast1","Podcast2","Podcast3"]
    
    var tipo: String = ""
    
    
    //paso 1 definir json estatico
    //let datosJSON = "[ {\"marca\": \"FORD\", \"agencias\": 21},{\"marca\": \"BMW\", \"agencias\": 35}]"
    
    var datosJSON = "[{\"título\": \"pod1\", \"URL\": \"http://mx.ivoox.com/es/sintonia-capital-seguridad-mexico-14-mar_mf_17565955_feed_1.mp3?_=1\"}]"
    
    
    
    
    //"Podcast1-Titulo\",\"URL\":\"http://podcastcdn-16.ivoox.com/audio/6/4/4/1/influenzaestacional-wernickebroca-ivoox13631446.mp3?secure=er6bQJv-_jNawcvIS9l4tw==,1489892439\"}]"
    
    //paso 2 definir nuevo arreglo
    var nuevoArray:[Any]?
    
    //paso 3 convertir json en diccionario
    func JSONParseArray(_ string: String) -> [AnyObject]{
        if let data = string.data(using: String.Encoding.utf8){
            do{
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [AnyObject]{
                    return array
                }
            }catch{
                print("error")
            }
        }
        return [AnyObject]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //paso 4 llenamos el arreglo
        //nuevoArray = (JSONParseArray(datosJSON) as NSArray) as? [Any]
        
        if tipo == "Sintonía Capital"{
            direccion = "http://conceptoradial.000webhostapp.com/json/sintonia.json"
        }else if tipo == "A Ciencia Cierta"{
            direccion = "http://conceptoradial.000webhostapp.com/json/cienciacierta.json"
        }else if tipo == "Detrás de Escena"{
            direccion = "http://conceptoradial.000webhostapp.com/json/detrasescena.json"
        }else if tipo == "Marketeando"{
            direccion = "http://conceptoradial.000webhostapp.com/json/marketeando.json"
        }else if tipo == "Salud con H"{
            direccion = "http://conceptoradial.000webhostapp.com/json/saludconh.json"
        }else if tipo == "Wernicke y la Broca"{
            direccion = "http://conceptoradial.000webhostapp.com/json/wernicke.json"
        }else if tipo == "Blaring"{
            direccion = "http://conceptoradial.000webhostapp.com/json/blaring.json"
        }else if tipo == "La Báscula"{
            direccion = "http://conceptoradial.000webhostapp.com/json/labascula.json"
        }else if tipo == "Medio Actual"{
            direccion = "http://conceptoradial.000webhostapp.com/json/medioactual.json"
        }else if tipo == "Shakespeare Inmortal"{
            direccion = "http://conceptoradial.000webhostapp.com/json/shakespeare.json"
        }else if tipo == "De Ida y Vuelta"{
            direccion = "http://conceptoradial.000webhostapp.com/json/idavuelta.json"
        }else if tipo == "La Minuta"{
            direccion = "http://conceptoradial.000webhostapp.com/json/laminuta.json"
        }else if tipo == "Medio Equis"{
            direccion = "http://conceptoradial.000webhostapp.com/json/medioequis.json"
        }else{
            direccion = "http://conceptoradial.000webhostapp.com/json/cajonsistor.json"
        }
        
        //paso 9
        //convierto mi linea string en url
        let url = URL(string: direccion)
        //trae el contenido de la nube
        let datos = try? Data(contentsOf: url!)
        nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //paso 5 regresamos el numero de elementos del arreglo
        return (nuevoArray?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NombrePrograma", for: indexPath)
        
        //cell.textLabel?.text = datos[indexPath.row]
        
        // Configure the cell...
        
        //paso 6 saco el renglon
        let objetoPodcast = nuevoArray?[indexPath.row] as! [String: Any]
        //determino el valor del renglon que quiero
        let s: String = objetoPodcast["título"] as! String
        
        cell.textLabel?.text = s
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let siguienteVista = segue.destination as! ReproducirPodcastViewController
        
        let indice = self.tableView.indexPathForSelectedRow?.row
        
        //siguienteVista.marca = datos[indice!]
        //paso 7
        let objetoMarca = nuevoArray?[indice!] as! [String: Any]
        let s =  objetoMarca["título"]
        let t = objetoMarca["URL"]
        siguienteVista.nombre = s as! String
        siguienteVista.link = t as! String
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
