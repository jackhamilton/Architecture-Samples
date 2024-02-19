//
//  MenuRowView.swift
//  MVVM_SwiftUI
//
//  Created Jack Hamilton on 2/18/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct MenuRowView: View {
    @State private var viewModel: MenuRowViewModel
    
    init(item: MenuItem) {
        self.viewModel = MenuRowViewModel(item: item)
    }
    
    var body: some View {
        HStack {
            //If we have an image, we want a height-constrained view of equal size to the image, aligned top
            if let image = viewModel.image {
                textContainer
                .frame(height: 80, alignment: .top)
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    .cornerRadius(12)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            } else {
                //Otherwise just make it tall enough for the text to fit
                textContainer
            }
        }
        .padding(16)
    }
    
    var textContainer: some View {
        VStack {
            //We are not using the specified fonts here - System font is only available in custom size without scaling, so a system font of size 18, for example, will ignore Dynamic Type and break accessibility. If a font were specified, we'd instead do a .custom([...], ofSize: 18, scaledTo: .headline)
            if let title = viewModel.title {
                Text(title)
                    .font(.headline)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
            }
            Text(viewModel.description)
                .font(.caption)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
            
            
        }
    }
}

//MARK: Preview
struct MenuRowViewPreview: View {
    var body: some View {
        MenuRowView(item: MenuItem(title: "Samosas", imageURL: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/c7e28663-edb9-4e84-a83b-3f909a63e661-retina-large-jpeg", description: "Crispy, flaky & delicious homemade samosas, potato stuffed. Extra spicy."))
    }
}

#Preview {
    MenuRowViewPreview()
}
