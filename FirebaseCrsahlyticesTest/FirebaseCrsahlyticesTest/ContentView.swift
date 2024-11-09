//
//  ContentView.swift
//  FirebaseCrsahlyticesTest
//
//  Created by Shafiq  Ullah on 11/8/24.
//

import SwiftUI
import FirebaseCrashlytics

final class CrashManager{
    static let shared = CrashManager()
    
    private init(){
        
    }
    
    func setUserId(userId: String){
        Crashlytics.crashlytics().setUserID(userId)
    }
    
    func setValue(value: String, key : String){
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
    }
    
    func addLog(_ log: String){
        Crashlytics.crashlytics().log(log)
    }
    
    func sendNonFatal(eror: Error){
        Crashlytics.crashlytics().record(error: eror)
    }
}


struct ContentView: View {
    var body: some View {
        VStack{
            Button("Crash 1") {
                CrashManager.shared.addLog("Button 1 clicked")
                let opVariable : String?  = nil
                let newVal = opVariable!
            }
            
            Button("Crash 2") {
                CrashManager.shared.addLog("Button 2 clicked")
                let arr = [Int]()
                let val = arr[0]
            }
            
            Button("Crash 3") {
                CrashManager.shared.addLog("Button 3 clicked")
                fatalError("This was fatal error..!!")
            }
            
            Button("Non Fetal error") {
                CrashManager.shared.addLog("Button 4 clicked")
                let opVariable : String?  = nil
                guard let opVariable = opVariable else {
                    CrashManager.shared.sendNonFatal(eror: URLError(.notConnectedToInternet ))
                    return
                }

                let newVal = opVariable
            }
        }
        .onAppear {
            CrashManager.shared.setUserId(userId: "shafiq04")
            CrashManager.shared.setValue(value: "this is custome value", key: "custome_key ")
            CrashManager.shared.addLog("This is my first log, hello Google ")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
