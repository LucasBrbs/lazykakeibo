

import Foundation
import SwiftUI
import CoreData

struct StaticIncomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var staticIncome: FetchedResults<StaticIncome>
    
    @Binding var showStaticIncomeView: Bool
    
    @State private var showAddStaticIncomeView = false
    
    private func deleteStaticIncome(offsets: IndexSet){
        for index in offsets{
            let staticIncomes = staticIncome[index]
            viewContext.delete(staticIncomes)
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
                    ForEach(staticIncome, id:\.self){ (PV2) in
                        HStack{
                            Text(PV2.name ?? "untitled")
                            Spacer()
                            Text("\(PV2.value, specifier: "%.2f")").foregroundColor(.green)
                        }
                    }.onDelete(perform: { indexSet in
                        //teste.remove(atOffsets: indexSet)
                        deleteStaticIncome(offsets:indexSet)
                    })
                }
                
                
            }.navigationTitle("Renda Fixa").toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    Button("<Voltar"){
                        self.showStaticIncomeView = false
                        
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Adicionar"){
                        self.showAddStaticIncomeView.toggle()
                    }.sheet(isPresented: $showAddStaticIncomeView){
                        AddStaticIncomeView(showAddStaticIncomeView: self.$showAddStaticIncomeView)
                    }
                }

            }
        }
        
    }

struct AddStaticIncomeView: View{
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showAddStaticIncomeView:Bool
    @State private var name:String = ""
    @State private var value:Float = 0
    
    var body: some View {
        VStack{
            Text("Adicionar nome").font(.body)
            TextField("Nome do ganho", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            Text("Adicionar Valor").font(.body)
            TextField("valor do ganho", value: $value,format: .number).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
        }
        Button("Adicionar"){
            self.showAddStaticIncomeView = false
            let newStaticIncome = StaticIncome(context: viewContext)
            
            newStaticIncome.name = name
            newStaticIncome.value = value
            
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
