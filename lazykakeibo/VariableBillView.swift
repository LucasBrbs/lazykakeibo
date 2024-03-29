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
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var variableBill: FetchedResults<VariableBill>
    
    @Binding var showVariableBillView: Bool
    
    @State private var showAddVariableBillView = false
    
    private func deleteVariableBill(offsets: IndexSet){
        for index in offsets{
            let variableBills = variableBill[index]
            viewContext.delete(variableBills)
        }
        do{
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error)")
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(variableBill, id:\.self){ (PV2) in
                        HStack{
                            Text(PV2.name ?? "untitled")
                            Spacer()
                            Text("\(PV2.bill, specifier: "%.2f")").foregroundColor(.green)
                        }
                    }.onDelete(perform: { indexSet in
                        //teste.remove(atOffsets: indexSet)
                        deleteVariableBill(offsets:indexSet)
                    })
                }
                
                
            }.navigationTitle("Gastos Variaveis").toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    Button("<Voltar"){
                        self.showVariableBillView = false
                        
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Adicionar"){
                        self.showAddVariableBillView.toggle()
                    }.sheet(isPresented: $showAddVariableBillView){
                        AddVariableBillView(showAddVariableBillView: self.$showAddVariableBillView)
                    }
                }

            }
        }
        
    }

struct AddVariableBillView: View{
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showAddVariableBillView:Bool
    @State private var name:String = ""
    @State private var value:Float = 0
    
    var body: some View {
        VStack{
            Text("Adicionar nome").font(.body)
            TextField("Nome da conta/fatura", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            Text("Adicionar Valor").font(.body)
            TextField("valor da conta/fatura", value: $value,format: .number).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
        }
        Button("Adicionar"){
            self.showAddVariableBillView = false
            let newVariableBill = VariableBill(context: viewContext)
            
            newVariableBill.name = name
            newVariableBill.bill = value
            
            do{
                try viewContext.save()
            }
            catch{
                let error = error as NSError
                fatalError("Unresolved error:\(error)")
            }
        }
    }
}
}
