const { MongoClient, ObjectId} = require('mongodb');

async function main(){
	const uri = "mongodb://localhost:27017";
	const client = new MongoClient(uri);
	
	try{
		await client.connect();
		const database = client.db('onlineBookstore');
		
		const booksCollection = database.collection('books');
		const authorsCollection = database.collection('authors');
		const genresCollection = database.collection('genres');
		const reviewsCollection = database.collection('reviews');
		
		//Sample Authors data
		const authors = [
			{_id: new ObjectId(), name: "Author One", bio: "Bio of Author One"},
			{_id: new ObjectId(), name: "Author Two", bio: "Bio of Author Two"},
			{_id: new ObjectId(), name: "Author Three", bio: "Bio of Author Three"},
			{_id: new ObjectId(), name: "Author Four", bio: "Bio of Author Four"},
			{_id: new ObjectId(), name: "Author Five", bio: "Bio of Author Five"}
		];
		
		//Sample Genres data
		const genres =[
			{_id: new ObjectId(), name: "Fantasy", description: "Fantasy books"},
			{_id: new ObjectId(), name: "Fiction", description: "Fiction books"},
			{_id: new ObjectId(), name: "Mystery", description: "Mystery books"},
			{_id: new ObjectId(), name: "Non-Fiction", description: "Non-Fiction books"},
			{_id: new ObjectId(), name: "Science Fiction", description: "Science Fiction books"}
		];
		
		//Sample Books data
		const books = [
			{
				_id: new ObjectId(),
				title= "Book One",
				isbn= "123456789",
				author_ids: [authors[0]._id],
				genre_ids: [genres[0]._id],
				year_published: new Date("2010-01-01"),
				reviews: [
					{customer_name: "Customer One", rating: 5, review_text: "Great Book", review_date: new Date("2010-02-04")},
					{customer_name: "Customer Two", rating: 4, review_text: "Good Book", review_date: new Date("2010-02-08")},
				]
			},
			{
				_id: new ObjectId(),
				title= "Book Two",
				isbn= "123456782",
				author_ids: [authors[1]._id],
				genre_ids: [genres[1]._id],
				year_published: new Date("2012-01-01"),
				reviews: [
					{customer_name: "Customer Three", rating: 5, review_text: "Great Book", review_date: new Date("2012-02-04")}				]
			},
			{
				_id: new ObjectId(),
				title= "Book Three",
				isbn= "123456783",
				author_ids: [authors[2]._id, authors[3]._id],
				genre_ids: [genres[3]._id],
				year_published: new Date("2013-01-01"),
				reviews: [
					{customer_name: "Customer Four", rating: 5, review_text: "Great Book", review_date: new Date("2013-02-04")}				]
			},
			{
				_id: new ObjectId(),
				title= "Book Four",
				isbn= "123456784",
				author_ids: [authors[2]._id, authors[4]._id],
				genre_ids: [genres[2]._id],
				year_published: new Date("2014-01-01"),
				reviews: [
					{customer_name: "Customer Five", rating: 5, review_text: "Great Book", review_date: new Date("2014-02-04")}				]
			},
			{
				_id: new ObjectId(),
				title= "Book Five",
				isbn= "123456785",
				author_ids: [authors[4]._id],
				genre_ids: [genres[4]._id],
				year_published: new Date("2015-01-01"),
				reviews: [
					{customer_name: "Customer Six", rating: 5, review_text: "Great Book", review_date: new Date("2015-02-04")}				]
			}
		];
		
		//Sample reviews data
		const reviews =[
			{book_id: books[0]._id, customer_name: "Customer One", rating: 5, review_text: "Great Book", review_date: new Date("2010-02-04")},
			{book_id: books[0]._id, customer_name: "Customer Two", rating: 4, review_text: "Good Book", review_date: new Date("2010-02-08")},
			{book_id: books[1]._id, customer_name: "Customer Three", rating: 5, review_text: "Great Book", review_date: new Date("2012-02-04")},
			{book_id: books[2]._id, customer_name: "Customer Four", rating: 5, review_text: "Great Book", review_date: new Date("2013-02-04")},
			{book_id: books[3]._id, customer_name: "Customer Five", rating: 5, review_text: "Great Book", review_date: new Date("2014-02-04")},
			{book_id: books[4]._id, customer_name: "Customer Six", rating: 5, review_text: "Great Book", review_date: new Date("2015-02-04")}		
		];
		
		//Insert Data to collections
		await authorsCollection.insertMany(authors);
		await genresCollection.insertMany(genres);
		await booksCollection.insertMany(books);
		await reviewsCollection.insertMany(reviews);
		
	}
	finally{
		await client.close();
	}
	}
}