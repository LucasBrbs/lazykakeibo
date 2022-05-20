
import Foundation
import SwiftUI
import CoreData

struct VariableIncomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var variableIncome: FetchedResults<VariableIncome>
    
    @Binding var showVariableIncomeView: Bool
    
    @State private var showAddVariableIncomeView = false
    
    private func deleteVariableIncome(offsets: IndexSet){
        for index in offsets{
            let variableIncomes = variableIncome[index]
            viewContext.delete(variableIncomes)
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
                    ForEach(variableIncome, id:\.self){ (PV2) in
                        HStack{
                            Text(PV2.name ?? "untitled")
                            Spacer()
                            Text("\(PV2.value, specifier: "%.2f")").foregroundColor(.green)
                        }
                    }.onDelete(perform: { indexSet in
                        //teste.remove(atOffsets: indexSet)
                        deleteVariableIncome(offsets:indexSet)
                    })
                }
                
                
            }.navigationTitle("Renda Fixa").toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    Button("<Voltar"){
                        self.showVariableIncomeView = false
                        
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Adicionar"){
                        self.showAddVariableIncomeView.toggle()
                    }.sheet(isPresented: $showAddVariableIncomeView){
                        AddVariableIncomeView(showAddVariableIncomeView: self.$showAddVariableIncomeView)
                    }
                }

            }
        }
        
    }

struct AddVariableIncomeView: View{
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showAddVariableIncomeView:Bool
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
            self.showAddVariableIncomeView = false
            let newVariableIncome = VariableIncome(context: viewContext)
            
            newVariableIncome.name = name
            newVariableIncome.value = value
            
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
