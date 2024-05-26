from flask import Flask, render_template, request, redirect, url_for, flash, session
import mysql.connector
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Change this to a secure secret key

# Define the MySQL database connection
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'gbs'
}

UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def get_db_connection():
    connection = mysql.connector.connect(**db_config)
    return connection

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route("/", methods=["GET", "POST"])
def login_or_signup():
    if request.method == "POST":
        action = request.form.get("action")
        if action == "login":
            user_id = request.form.get("user_id")
            psw = request.form.get("psw")
            
            connection = get_db_connection()
            cursor = connection.cursor(dictionary=True)
            cursor.execute("SELECT * FROM User WHERE user_id = %s AND psw = %s", (user_id, psw))
            user = cursor.fetchone()
            connection.close()
            
            if user:
                session['user_id'] = user_id
                flash("Login successful!", "success")
                return redirect(url_for("homepage"))
            else:
                flash("Invalid credentials. Please try again.", "danger")
                
        elif action == "signup":
            user_id = request.form.get("user_id")
            psw = request.form.get("psw")
            name = request.form.get("name")
            year = request.form.get("year")
            branch = request.form.get("branch")
            address = request.form.get("address")
            contact = request.form.get("contact")
            user_img = request.form.get("user_img")
            
            connection = get_db_connection()
            cursor = connection.cursor()
            cursor.execute(
                "INSERT INTO User (user_id, psw, name, year, branch, Addrs, Contact, user_img) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
                (user_id, psw, name, year, branch, address, contact, user_img)
            )
            connection.commit()
            connection.close()
            
            flash("Signup successful! Please login.", "success")
            return redirect(url_for("login_or_signup"))

    return render_template("login_or_signup.html")

@app.route("/homepage")
def homepage():
    if 'user_id' in session:
        return render_template("homepage.html", user_id=session['user_id'])
    else:
        flash("You need to login first.", "warning")
        return redirect(url_for("login_or_signup"))

@app.route("/cart")
def cart():
    if 'user_id' not in session:
        flash("You need to login first.", "warning")
        return redirect(url_for("login_or_signup"))

    user_id = session['user_id']
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("""
        SELECT b.book_id, b.book_name, b.cost, u.name AS seller_name, u.Contact AS seller_contact
        FROM book_order bo
        JOIN Book b ON bo.book_id = b.book_id
        JOIN User u ON b.user_id = u.user_id
        WHERE bo.user_id = %s
    """, (user_id,))
    orders = cursor.fetchall()
    connection.close()

    return render_template("cart.html", orders=orders)

@app.route("/new_used_textbooks")
def new_used_textbooks():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("""
        SELECT b.book_id, b.book_name, b.book_descr, b.book_cond, b.cost, b.stat,
               u.user_id as seller_id, u.name as seller_name, u.Contact as seller_contact
        FROM Book b
        JOIN User u ON b.user_id = u.user_id
        WHERE b.book_type = 'Textbook'
    """)
    textbooks = cursor.fetchall()
    connection.close()

    return render_template("new-used-textbooks.html", textbooks=textbooks)

@app.route("/class_notes")
def class_notes():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("""
        SELECT b.book_id, b.book_name, b.book_descr, b.book_cond, b.cost, b.stat,
               u.user_id as seller_id, u.name as seller_name, u.Contact as seller_contact
        FROM Book b
        JOIN User u ON b.user_id = u.user_id
        WHERE b.book_type = 'notes'
    """)
    notes = cursor.fetchall()
    connection.close()

    return render_template("class-notes.html", notes=notes)

@app.route("/used_story_books")
def used_story_books():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("""
        SELECT b.book_id, b.book_name, b.book_descr, b.book_cond, b.cost, b.stat,
               u.user_id as seller_id, u.name as seller_name, u.Contact as seller_contact
        FROM Book b
        JOIN User u ON b.user_id = u.user_id
        WHERE b.book_type = 'story'
    """)
    story_books = cursor.fetchall()
    connection.close()

    return render_template("used-story-books.html", story_books=story_books)

@app.route("/add_to_cart", methods=["POST"])
def add_to_cart():
    if 'user_id' not in session:
        flash("You need to login first.", "warning")
        return redirect(url_for("login_or_signup"))

    user_id = session['user_id']
    book_id = request.form.get('book_id')
    
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("""
        INSERT INTO book_order (book_id, user_id, ord_date) 
        VALUES (%s, %s, CURDATE())
    """, (book_id, user_id))
    connection.commit()
    connection.close()

    flash("Book added to cart!", "success")
    return redirect(url_for("cart"))
@app.route("/sell")
def sell():
    return render_template("sell.html")
@app.route("/contact")
def contact():
    return render_template("contact.html")

@app.route("/sell_class_notes", methods=["GET", "POST"])
def sell_class_notes():
    if request.method == "POST":
        if 'user_id' not in session:
            flash("You need to login first.", "warning")
            return redirect(url_for("login_or_signup"))

        user_id = session['user_id']
        product_name = request.form.get("productName")
        descr = request.form.get("descr")
        condition = request.form.get("condition")
        price = request.form.get("price")
        images = request.files.getlist("images")

        image_paths = []
        for image in images:
            if image and allowed_file(image.filename):
                filename = secure_filename(image.filename)
                image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                image.save(image_path)
                image_paths.append(image_path)

        # Convert the list of image paths to a single string to store in the database
        image_paths_str = ",".join(image_paths)

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO Book (user_id, book_name, book_type, book_cond, book_descr, book_img, cost, tags, stat)
            VALUES (%s, %s, %s, %s, %s, %s, %s, '', 'Available')
        """, (user_id, product_name, 'Class Notes', condition, descr, image_paths_str, price))
        connection.commit()
        connection.close()

        flash("Class notes listed for sale!", "success")
        return redirect(url_for("homepage"))

    return render_template("sell_class_notes.html")
@app.route("/sell_textbook", methods=["GET", "POST"])
def sell_textbook():
    if request.method == "POST":
        if 'user_id' not in session:
            flash("You need to login first.", "warning")
            return redirect(url_for("login_or_signup"))

        user_id = session['user_id']
        product_name = request.form.get("productName")
        descr = request.form.get("descr")
        condition = request.form.get("condition")
        price = request.form.get("price")
        images = request.files.getlist("images")

        image_paths = []
        for image in images:
            if image and allowed_file(image.filename):
                filename = secure_filename(image.filename)
                image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                image.save(image_path)
                image_paths.append(image_path)

        # Convert the list of image paths to a single string to store in the database
        image_paths_str = ",".join(image_paths)

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO Book (user_id, book_name, book_type, book_cond, book_descr, book_img, cost, tags, stat)
            VALUES (%s, %s, %s, %s, %s, %s, %s, '', 'Available')
        """, (user_id, product_name, 'GTextbook', condition, descr, image_paths_str, price))
        connection.commit()
        connection.close()

        flash("Class notes listed for sale!", "success")
        return redirect(url_for("homepage"))

    return render_template("sell_textbook.html")
@app.route("/sell_storybook", methods=["GET", "POST"])
def sell_storybook():
    if request.method == "POST":
        if 'user_id' not in session:
            flash("You need to login first.", "warning")
            return redirect(url_for("login_or_signup"))

        user_id = session['user_id']
        product_name = request.form.get("productName")
        descr = request.form.get("descr")
        condition = request.form.get("condition")
        price = request.form.get("price")
        images = request.files.getlist("images")

        image_paths = []
        for image in images:
            if image and allowed_file(image.filename):
                filename = secure_filename(image.filename)
                image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                image.save(image_path)
                image_paths.append(image_path)

        # Convert the list of image paths to a single string to store in the database
        image_paths_str = ",".join(image_paths)

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO Book (user_id, book_name, book_type, book_cond, book_descr, book_img, cost, tags, stat)
            VALUES (%s, %s, %s, %s, %s, %s, %s, '', 'Available')
        """, (user_id, product_name, 'GTextbook', condition, descr, image_paths_str, price))
        connection.commit()
        connection.close()

        flash("Class notes listed for sale!", "success")
        return redirect(url_for("homepage"))

    return render_template("sell_storybook.html")
@app.route("/profile")
def profile():
    if 'user_id' in session:
        user_id = session['user_id']
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM User WHERE user_id = %s", (user_id,))
        user = cursor.fetchone()
        connection.close()

        if user:
            return render_template("profile.html", user=user)
        else:
            flash("User not found!", "danger")
            return redirect(url_for("login_or_signup"))
    else:
        flash("You need to login first.", "warning")
        return redirect(url_for("login_or_signup"))
    
    return render_template("profile.html")


if __name__ == "__main__":
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)
    app.run(debug=True)
