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
		const customersCollection = database.collection('customers');
		
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
		
		// Sample customers data
		const customers = [
			{ _id: new ObjectId(), name: "Customer One", email: "customer1@example.com" },
			{ _id: new ObjectId(), name: "Customer Two", email: "customer2@example.com" },
			{ _id: new ObjectId(), name: "Customer Three", email: "customer3@example.com" },
			{ _id: new ObjectId(), name: "Customer Four", email: "customer4@example.com" },
			{ _id: new ObjectId(), name: "Customer Five", email: "customer5@example.com" }
		];

		//Sample Books data
		const books = [
			{
				_id: new ObjectId(),
				title: "Book One",
				isbn: "123456789",
				author_ids: [authors[0]._id],
				genre_ids: [genres[0]._id],
				year_published: new Date("2010-01-01"),
				reviews: [
					{customerId: customers[0]._id, rating: 5, review_text: "Great Book", review_date: new Date("2010-02-04")},
					{customerId: customers[1]._id, rating: 4, review_text: "Good Book", review_date: new Date("2010-02-08")},
				]
			},
			{
				_id: new ObjectId(),
				title: "Book Two",
				isbn: "123456782",
				author_ids: [authors[1]._id],
				genre_ids: [genres[1]._id],
				year_published: new Date("2012-01-01"),
				reviews: [
					{customerId: customers[1]._id, rating: 5, review_text: "Great Book", review_date: new Date("2012-02-04")}				
				]
			},
			{
				_id: new ObjectId(),
				title: "Book Three",
				isbn: "123456783",
				author_ids: [authors[2]._id, authors[3]._id],
				genre_ids: [genres[3]._id],
				year_published: new Date("2013-01-01"),
				reviews: [
					{customerId: customers[2]._id, rating: 5, review_text: "Great Book", review_date: new Date("2013-02-04")}				
				]
			},
			{
				_id: new ObjectId(),
				title: "Book Four",
				isbn: "123456784",
				author_ids: [authors[2]._id, authors[4]._id],
				genre_ids: [genres[2]._id],
				year_published: new Date("2014-01-01"),
				reviews: [
					{customerId: customers[3]._id, rating: 5, review_text: "Great Book", review_date: new Date("2014-02-04")}				
				]
			},
			{
				_id: new ObjectId(),
				title: "Book Five",
				isbn: "123456785",
				author_ids: [authors[4]._id],
				genre_ids: [genres[4]._id],
				year_published: new Date("2015-01-01"),
				reviews: [
					{customerId: customers[4]._id, rating: 5, review_text: "Great Book", review_date: new Date("2015-02-04")}				
				]
			}
		];		

		//Insert Data to collections
		await authorsCollection.insertMany(authors);
		await genresCollection.insertMany(genres);
		await customersCollection.insertMany(customers);
		await booksCollection.insertMany(books);

		console.log("Data inserted successfully");	
	}
	finally{
		await client.close();
	}	
}

main().catch(console.error);
