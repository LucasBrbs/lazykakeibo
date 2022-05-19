//
//  VariableBillView.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 19/05/22.
//

import Foundation
import SwiftUI
import CoreData

struct VariableBillView: View {
    @Binding var showVariableBillView: Bool
    
    @State private var showAddVariableBillView = false
    
    @State private var teste = [
        VariableBills(name: "Academia", bill: 10),
        VariableBills(name: "Jogo", bill: 150)
    ]
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(teste){ (PV2) in
                        HStack{
                            Text(PV2.name)
                            Spacer()
                            Text("\(PV2.bill)").foregroundColor(.green)
                        }
                    }.onDelete(perform: { indexSet in
                        teste.remove(atOffsets: indexSet)
                    })
                }
                Button("Confirmar"){
                    self.showVariableBillView = false
                }
            }.navigationTitle("Renda Variavel").toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    Button("<Voltar"){
                        self.showVariableBillView = false
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Adicionar"){
                        self.showAddVariableBillView.toggle()
                    }.sheet(isPresented: $showAddVariableBillView){
                        AddVariableBillView(showAddVariableBillView: self.$showAddVariableBillView, teste:self.$teste)
                    }
                }

            }
        }
        
    }

struct AddVariableBillView: View{
    @Binding var showAddVariableBillView:Bool
    @State private var name:String = ""
    @State private var value = 0
    
    @Binding var  teste:[VariableBills]
    
    var body: some View {
        VStack{
            Text("Adicionar nome").font(.body)
            TextField("Nome da conta/fatura", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            Text("Adicionar Valor").font(.body)
            TextField("valor da conta/fatura", value: $value,format: .number).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
        }
        Button("Adicionar"){
            self.showAddVariableBillView = false
            teste.append(VariableBills(name: "\(name)", bill: value))
        }
    }
}
}
