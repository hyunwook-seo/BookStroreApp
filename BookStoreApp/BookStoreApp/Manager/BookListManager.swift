//
//  BookListManager 2.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/6/25.
//


import CoreData
import UIKit

class BookListManager {
    static let shared = BookListManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init() {}

    
    func fetchBooks() -> [Book] {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "SavedBook")
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { savedBook in
                Book(
                    title: savedBook.value(forKey: "title") as? String ?? "제목 없음",
                    author: savedBook.value(forKey: "author") as? String ?? "저자 없음",
                    price: savedBook.value(forKey: "price") as? String ?? "가격 없음",
                    description: savedBook.value(forKey: "bookDescription") as? String ?? "설명 없음",
                    imageUrl: savedBook.value(forKey: "imageUrl") as? String ?? ""
                )
            }
        } catch {
            print("Error fetching books: \(error)")
            return []
        }
    }

    func addBook(_ book: Book) {
        guard let entity = NSEntityDescription.entity(forEntityName: "SavedBook", in: context) else {
            print("엔티티를 찾을 수 없습니다.")
            return
        }

        let savedBook = NSManagedObject(entity: entity, insertInto: context)
        savedBook.setValue(book.title, forKey: "title")
        savedBook.setValue(book.author, forKey: "author")
        savedBook.setValue(book.price, forKey: "price")
        savedBook.setValue(book.description, forKey: "bookDescription")
        savedBook.setValue(book.imageUrl, forKey: "imageUrl")

        saveContext()
    }

    func deleteBook(_ book: Book) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SavedBook")
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND author == %@", book.title, book.author)
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                if let managedObject = object as? NSManagedObject {
                    context.delete(managedObject)
                }
            }
            saveContext()
        } catch {
            print("Error deleting book: \(error)")
        }
    }

    func deleteAllBooks() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SavedBook")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("Error deleting all books: \(error)")
        }
    }


    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Changes saved successfully.")
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
