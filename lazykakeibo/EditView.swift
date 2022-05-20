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
    @State private var showMonthBillView = false
    @State private var showStaticIncomeView = false
    @State private var showVariableIncomeView = false
    
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
                            
                            self.showMonthBillView.toggle()
                        }.sheet(isPresented: $showMonthBillView){
                            MonthBillView(showMonthBillView: self.$showMonthBillView)
                        }
                    }
                    Section{
                        Button("Renda fixa"){
                            
                            self.showStaticIncomeView.toggle()
                        }.sheet(isPresented: $showStaticIncomeView){
                            StaticIncomeView(showStaticIncomeView: self.$showStaticIncomeView)
                        }
                    }
                    Section{
                        Button("Renda Variada"){
                            
                            self.showVariableIncomeView.toggle()
                        }.sheet(isPresented: $showVariableIncomeView){
                            VariableIncomeView(showVariableIncomeView: self.$showVariableIncomeView)
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

