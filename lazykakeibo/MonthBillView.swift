//
//  VariableBillView.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 19/05/22.
//

import Foundation
import SwiftUI
import CoreData

struct MonthBillView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var monthBill: FetchedResults<MonthBill>
    
    @Binding var showMonthBillView: Bool
    
    @State private var showAddMonthBillView = false
    
    private func deleteMonthBill(offsets: IndexSet){
        for index in offsets{
            let monthBills = monthBill[index]
            viewContext.delete(monthBills)
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
                    ForEach(monthBill, id:\.self){ (PV2) in
                        HStack{
                            Text(PV2.name ?? "untitled")
                            Spacer()
                            Text("\(PV2.bill, specifier: "%.2f")").foregroundColor(.green)
                        }
                    }.onDelete(perform: { indexSet in
                        //teste.remove(atOffsets: indexSet)
                        deleteMonthBill(offsets:indexSet)
                    })
                }
                
                
            }.navigationTitle("Gastos Essenciais").toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    Button("<Voltar"){
                        self.showMonthBillView = false
                        
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Adicionar"){
                        self.showAddMonthBillView.toggle()
                    }.sheet(isPresented: $showAddMonthBillView){
                        AddMonthBillView(showAddMonthBillView: self.$showAddMonthBillView)
                    }
                }

            }
        }
        
    }

struct AddMonthBillView: View{
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showAddMonthBillView:Bool
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
            self.showAddMonthBillView = false
            let newMonthBill = MonthBill(context: viewContext)
            
            newMonthBill.name = name
            newMonthBill.bill = value
            
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
