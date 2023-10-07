import psycopg2

# Connect to the PostgreSQL database
conn = psycopg2.connect( database="moviedb",
			 user="postgres",
			 password="123456",
			 host="localhost" )

# Create a cursor object
cursor = conn.cursor()

# Get the actor id, first name, last name, and gender from the console
actor_id = int(input("Enter actor id [3 digits]: "))
first_name = input("Enter first name: ")
last_name = input("Enter last name: ")
gender = input("Enter gender [M / F]: ")

# Check if the actor id already exists in the database
cursor.execute("SELECT 1 FROM actor WHERE act_id = %s", (actor_id,))
row = cursor.fetchone()
if row is not None:
    print("Actor ID already exists")
else:
    # Insert the new actor into the database
    cursor.execute("INSERT INTO actor (act_id, act_fname, act_lname, act_gender) VALUES (%s, %s, %s, %s)", (actor_id, first_name, last_name, gender))

    # Commit the changes
    conn.commit()

    print("Actor details inserted into the actor table successfully")

# Close the cursor and the connection
cursor.close()
conn.close()

