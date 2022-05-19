//
//  EditView.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 16/05/22.
//

import Foundation
import SwiftUI
import CoreData

struct EditView: View {
    @Binding var showEditView: Bool
    
    @State private var showVariableBillView = false
    
    @State private var fixedIncome:String = ""
    @State private var variableIncomeName:String = ""
    @State private var variableIncomeValue:String = ""
    
    var body: some View{
        NavigationView{
            VStack{
                
                Form{
                    
                    Section{
                        Button("Gastos Variaveis"){
                            self.showVariableBillView.toggle()
                        }.sheet(isPresented: $showVariableBillView){
                            VariableBillView(showVariableBillView: self.$showVariableBillView)
                        }
                    }
                    Section{
                        Button("Gastos Essencias/Fixos"){
                            
                        }
                    }
                    Section{
                        Button("Renda fixa"){
                            
                        }
                    }
                    Section{
                        Button("Renda Variada"){
                            
                        }
                    }
                    
                    
                }
                
            }.navigationTitle("Editar").toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    Button("<Voltar"){
                        self.showEditView = false
                    }
                }
            }
            
        }
        
    }
}

