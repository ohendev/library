#GLOBAL VARAIBLES here:

$books = {
    :J_K_Rowling => "Harry Potter",
    :Antoine_de_Saint_Expury => "Le Petit Prince",
    :Agatha_Christie => "Le crime de l'Orient-Express",
    :Albert_Camus => "L'Etranger",
    :Charles_Baudelaire => "Les Fleurs du mal",
    :Boris_Vian => "L'écume des jours"
}

$my_books = {}

$favorite_books = []

#end of GLOBAL VARAIBLES

#method to display all books in the library
def display_books
    $books.each do |author, title|
        puts "#{title} by #{clean(author.to_s, "_", " ")}"
    end
end  

#method to display my books
def display_my_books
    if $my_books.empty? 
        puts "You didn't borrowed any book"
    else    
        $my_books.each do |author, title|
            puts "I borrowed #{title} from the Library"
        end
    end
end  

#this method replaces the underscore in symbols to string by a white space
def clean(string, old, rep)
    string.gsub(old, rep)
end  

#method to add books to the Library
def add_book(author, title)
    $books.merge!("#{author}": title)
    puts "Book added! #{title} by #{author}"
end   

#method to borrow a book from the Library
def borrow_book(title)
    $my_books = $books.select { |key, value| value == title } 
    $books.delete($books.key(title))
    puts "Book borrowed! #{title}"
end   

#method to return a book to the Library
def return_book(title)
    $books_to_return = $my_books.select { |key, value| value == title } 
    $books.merge($books_to_return)
    $my_books.delete($my_books.key(title))
    puts "Book returned! #{title}"
end   

def menu
    stop = ""
    until stop.upcase == "STOP"
        puts "Welcome to the Library!"
        puts "What would you like to do today?"
        puts "'A' for add a book"
        puts "'B' for borrow a book"
        puts "'R' for return a book"
        puts "'D' for display books in the Library"
        puts "'Y' for display your books"
        answer = gets.chomp
        answer.upcase!
        case answer
        when "A"
            puts "Please enter the author name"
            author_name = gets.chomp
            puts "Ok now, enter the title of the book, please"
            book_title = gets.chomp
            $books[clean(author_name, " ", "_").to_sym] = book_title
        when "B"
            puts "Please enter the title of the book you want to borrow"
            book_to_borrow = gets.chomp
            borrow_book(book_to_borrow)   
        when "R"
            puts "Please enter the title of the book you want to return"
            book_to_return = gets.chomp
            return_book(book_to_return)
        when "D"
            display_books()
        when "Y"
            display_my_books()  
        else
            puts "Error! You didn't type A, B, R, D or Y" 
        end   
    end    
end

menu()
