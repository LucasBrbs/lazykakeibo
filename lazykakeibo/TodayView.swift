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
struct VariableBills {
    var Name: String
    var Bill: Double
}
//contas fixas
struct MonthBills {
    var Name: String
    var Bill: Double
}
//struct que mostra esse mES
struct ThisMonth {
    var Month: String
    var variableBills:[VariableBills]
    var monthBills:[MonthBills]
    var StaticIncome: String
    var VariableIncome: String
}

//CRIACAO DE structs testes
var test = VariableBills(Name: "Test", Bill: 10.0)

struct TodayView: View {
    //variaveis locais
    var contador = 2
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Verba R$1200")
                    .foregroundColor(Color.green)
                Form{
                    Section(header: Text("Renda")){
                        HStack{
                            Text("Fixa")
                            Text("a").foregroundColor(.green)
                        }
                        HStack{
                            Text("Variável")
                            Text("a").foregroundColor(.green)
                        }
                        
                    }
                    Section{
                            HStack{
                                Text("\(test.Name)")
                                Text("\(test.Bill)").foregroundColor(.green)
                        }
                    }
                    Section{
                        HStack{
                            Text("Variável")
                            Text("a").foregroundColor(.green)
                        }
                    }
                }
                //titulo do pagina com botao de edicao
            }.navigationTitle("Mês").toolbar{
                ToolbarItem(){
                    Button{
                        
                    }label: {
                        Image(systemName: "square.and.pencil").foregroundColor(Color.black)
                    }
                }
            }
        }
        
    }
}

struct AddTodoView:View{
    var body: some View{
        Text("a")
    }
}
