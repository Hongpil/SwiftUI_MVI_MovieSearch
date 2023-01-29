//
//  ContentView.swift
//  MovieSearch_MVI
//
//  Created by kimhongpil on 2023/01/29.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TestViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear() {
            viewModel.getClubDetail(
                clubId: "53",
                categoryCode: "freeboard_8",
                postId: 277,
                integUid: "ft_u_73bb0e80f68311ec8c4a2bae01ffd812_2022_06_28_01_41_38_443",
                access_token: "6v4vi3i0n8ruur12vs8mvn98nf_2023_01_29_00_43_07_529"
            )
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
