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
    var bill: Float
}
//contas fixas
struct MonthBills:Identifiable {
    let id = UUID()
    var name: String
    var bill: Float
}
//struct que mostra esse mES
struct ThisMonth:Identifiable {
    let id = UUID()
    var month: String
    var variableBills:[VariableBills]
    var monthBills:[MonthBills]
    var staticIncome: [StaticIncomes]
    var variableIncome: [VariableIncomes]
}

struct StaticIncomes:Identifiable{
    let id = UUID()
    var name:String
    var value: Float
    
}

struct VariableIncomes:Identifiable{
    let id = UUID()
    var name:String
    var value: Float
    
}



struct TodayView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var variableBill: FetchedResults<VariableBill>
    @FetchRequest(sortDescriptors: []) private var monthBill: FetchedResults<MonthBill>
    @FetchRequest(sortDescriptors: []) private var staticIncome: FetchedResults<StaticIncome>
    @FetchRequest(sortDescriptors: []) private var variableIncome: FetchedResults<VariableIncome>
    //variaveis locais
    
    @State private var showAddView = false
    //variaveis state
    @State private var showEditView = false
    
    
    
    private func colectValues() -> Float {
        
        var value:Float = 0.0
        
        for i in variableBill {
            value -= i.bill
        }
        for i in monthBill {
            value -= i.bill
        }
        for i in staticIncome {
            value += i.value
        }
        for i in variableIncome {
            value += i.value
        }
        
        
        return value
    }
    
    var body: some View {
        NavigationView{
            VStack{
                if(colectValues() >= 0){
                    Text("Saldo:\(colectValues(),specifier: "%.2f")").foregroundColor(.green)
                }
                else{
                    Text("Saldo:\(colectValues())").foregroundColor(.red)
                }
                
                List{
                    Section(header: Text("Gastos Variaveis")){
                        ForEach(variableBill, id:\.self){ (PV) in
                            HStack{
                                Text(PV.name ?? "untitled")
                                Spacer()
                                //pode dar erro
                                Text("\(PV.bill, specifier: "%.2f")").foregroundColor(.green)
                            }
                        }
                        
                    }
                    Section(header: Text("Gastos Essenciais") ){
                        ForEach(monthBill){ (PC) in
                            HStack{
                                Text(PC.name ?? "untitled")
                                Spacer()
                                Text("\(PC.bill, specifier: "%.2f")").foregroundColor(.green)
                            }
                        }
                                            }
                    Section(header: Text("Renda Fixa")){
                        ForEach(staticIncome){ (PR) in
                            HStack{
                                Text(PR.name ?? "untitled")
                                Spacer()
                                Text("\(PR.value, specifier: "%.2f")").foregroundColor(.green)
                            }
                        }
                        
                    }
                    Section(header: Text("Renda Variável")){
                        ForEach(variableIncome){ (PRV) in
                            HStack{
                                Text(PRV.name ?? "untitled")
                                Spacer()
                                Text("\(PRV.value, specifier: "%.2f")").foregroundColor(.green)
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







