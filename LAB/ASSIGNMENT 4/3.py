import psycopg2

# Connect to the PostgreSQL database
conn = psycopg2.connect( database="moviedb",
			 			 user="postgres",
			 			 password="123456",
			 			 host="localhost" )

# Create a cursor object
cursor = conn.cursor()

cursor.execute("SELECT max(act_id) FROM actor")

recent_act_id = cursor.fetchone();

print("Add movie id and roles to actor id : ", recent_act_id)
print()

cursor.execute("Begin")

no_of_movies = int( input( "Enter the number of movies: " ) )

exit = False;

llist = []

i_i = 0

for i in range(no_of_movies):
	print( "Enter movie id of movie number ", i+1, " : ", end="" )
	mov_id = int( input() )
	print( "Enter the role of the actor in the movie number ", i+1, " : ", end="" )
	role = input()
	cursor.execute("SELECT 1 FROM movie_cast WHERE mov_id = %s", (mov_id,))
	row = cursor.fetchone()
	if row is None:
		i_i = i+1
		exit = True
	else:
		llist.append((mov_id, role))
    	
if( exit == False ):
	for m, r in llist:
		cursor.execute("INSERT INTO movie_cast (mov_id, act_id, role) VALUES (%s, %s, %s)", (m, recent_act_id, r))
	cursor.execute("COMMIT")
	print("Database update successful")
else:
	print("Movie number ", i_i, " does not exists. Database is not updated")
	cursor.execute("ROLLBACK")


# Close the cursor and the connection
cursor.close()
conn.close()

