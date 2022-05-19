//
//  TodayView.swift
//  kakeibo
//
//  Created by Lucas Barbosa de Oliveira on 12/05/22.
//

// view "principal do codigo"

import Foundation
import SwiftUI
import CoreData
//contas variaveis
struct VariableBills:Identifiable {
    let id = UUID()
    var name: String
    var bill: Int
}
//contas fixas
struct MonthBills:Identifiable {
    let id = UUID()
    var name: String
    var bill: Int
}
//struct que mostra esse mES
struct ThisMonth:Identifiable {
    let id = UUID()
    var month: String
    var variableBills:[VariableBills]
    var monthBills:[MonthBills]
    var staticIncome: [StaticIncome]
    var variableIncome: [VariableIncome]
}

struct StaticIncome:Identifiable{
    let id = UUID()
    var name:String
    var value: Int
    
}

struct VariableIncome:Identifiable{
    let id = UUID()
    var name:String
    var value: Int
    
}



struct TodayView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //variaveis locais
    
    @State private var showAddView = false
    //variaveis state
    @State private var showEditView = false
    
    @State private var PreenchimentoVariavel = [
        VariableBills(name: "Academia", bill: 10),
        VariableBills(name: "Jogo", bill: 150)
    ]
    @State private var PreenchimentoContas = [
        MonthBills(name: "Transporte", bill: 150),
        MonthBills(name: "Comida", bill: 240)
    ]
    @State private var PreenchimentoRenda = [
        VariableIncome(name: "Salário", value: 10000)
    ]
    @State private var PreenchimentoRendaVariavel = [
        StaticIncome(name: "B3", value: 230)
    ]
    
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section(header: Text("Gastos Variaveis")){
                        ForEach(PreenchimentoVariavel){ (PV) in
                            HStack{
                                Text(PV.name)
                                Spacer()
                                Text("\(PV.bill)").foregroundColor(.green)
                            }
                        }
                        
                    }
                    Section(header: Text("Gastos Essenciais") ){
                        ForEach(PreenchimentoContas){ (PC) in
                            HStack{
                                Text(PC.name)
                                Spacer()
                                Text("\(PC.bill)").foregroundColor(.green)
                            }
                        }
                                            }
                    Section(header: Text("Renda Fixa")){
                        ForEach(PreenchimentoRenda){ (PR) in
                            HStack{
                                Text(PR.name)
                                Spacer()
                                Text("\(PR.value)").foregroundColor(.green)
                            }
                        }
                        
                    }
                    Section(header: Text("Renda Variável")){
                        ForEach(PreenchimentoRendaVariavel){ (PRV) in
                            HStack{
                                Text(PRV.name)
                                Spacer()
                                Text("\(PRV.value)").foregroundColor(.green)
                            }
                        }
                        

                    }

                }
                //titulo do pagina com botao de edicao
            }.navigationTitle("Mês").toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Editar"){
                        self.showEditView.toggle()
                    }.sheet(isPresented: $showEditView){
                        EditView(showEditView: self.$showEditView)
                    }

                    
                            }
                
                
            }
        }
        
    }
}







