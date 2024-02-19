//
//  MenuView.swift
//  MVVM_SwiftUI
//
//  Created Jack Hamilton on 2/18/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @State private var viewModel = MenuViewModel()
    
    var body: some View {
        //Remove the spacers and padding in the list to fit spec
        List(viewModel.items) { item in
            MenuRowView(item: item)
                .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
    }
}

//MARK: Preview
struct MenuViewPreview: View {
    var body: some View {
        MenuView()
    }
}

#Preview {
    MenuViewPreview()
}
