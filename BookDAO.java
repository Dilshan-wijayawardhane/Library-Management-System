package library_management_system_dao;

import library_management_system.Book;
import library_management_system.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class for Book entity.
 * Handles CRUD operations with the database.
 */
public class BookDAO {
	    public boolean addBook(Book book) {
        if (!book.getId().matches("^B\\d+$")) {
            System.out.println("Invalid Book ID! Must start with 'B' followed by numbers.");
            return false;
        }

        String libraryItemId = book.getId().replaceFirst("^B", "LI");

        String insertLibraryItem = "INSERT INTO LibraryItem (item_id, title, borrowed, type, author) VALUES (?,?,?,?,?)";
        String insertBook = "INSERT INTO Book (book_id, title, author, borrowed) VALUES (?,?,?,?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psItem = conn.prepareStatement(insertLibraryItem);
                 PreparedStatement psBook = conn.prepareStatement(insertBook)) {

              
                psItem.setString(1, libraryItemId);
                psItem.setString(2, book.getTitle());
                psItem.setBoolean(3, book.isBorrowed());
                psItem.setString(4, "Book");
                psItem.setString(5, book.getAuthor());
                psItem.executeUpdate();

              
                psBook.setString(1, book.getId());
                psBook.setString(2, book.getTitle());
                psBook.setString(3, book.getAuthor());
                psBook.setBoolean(4, book.isBorrowed());
                psBook.executeUpdate();

                conn.commit();
                return true;

            } catch (SQLException ex) {
                conn.rollback();
                ex.printStackTrace();
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return false;
    }

    public List<Book> getAllBooksFromDB() {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT * FROM Book";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String id = rs.getString("book_id");
                String title = rs.getString("title");
                String author = rs.getString("author");
                boolean borrowed = rs.getBoolean("borrowed");

                Book book = new Book(id, title, author);
                if (borrowed) book.borrow();
                list.add(book);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
  
    public Book getBookByIdFromDB(String id) {
        String sql = "SELECT * FROM Book WHERE book_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
            	rs.getString("book_id");
                String title = rs.getString("title");
                String author = rs.getString("author");
                boolean borrowed = rs.getBoolean("borrowed");

                Book book = new Book(id, title, author);
                if (borrowed) book.borrow();
                return book;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
   
    public boolean updateItem(LibraryItem item) {

       
        if (!(item instanceof Book)) {
            System.out.println("updateItem supports Book only.");
            return false;
        }

        Book book = (Book) item;

        String sql = "UPDATE Book SET title=?, author=?, borrowed=? WHERE book_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setBoolean(3, book.isBorrowed());
            ps.setString(4, book.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

  
    public boolean deleteBook(String bookId) {
        String libraryItemId = bookId.replaceFirst("^B", "LI");

        String deleteBookSQL = "DELETE FROM book WHERE book_id=?";
        String deleteItemSQL = "DELETE FROM libraryitem WHERE item_id=?";

        try (Connection conn = DBConnection.getConnection()) {

            conn.setAutoCommit(false);

            try (PreparedStatement psBook = conn.prepareStatement(deleteBookSQL);
                 PreparedStatement psItem = conn.prepareStatement(deleteItemSQL)) {

                psBook.setString(1, bookId);
                int bookRows = psBook.executeUpdate();

                psItem.setString(1, libraryItemId);
                int itemRows = psItem.executeUpdate();

                if (bookRows == 0 || itemRows == 0) {
                    conn.rollback();
                    return false;
                }

                conn.commit();
                return true;

            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}