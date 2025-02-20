//Total number of books per genre query
db.books.aggregate([
    {
        $unwind: "$genre_ids"
    },
    {
        $group: {
            _id: "$genre_ids",
            totalBooks: { $sum: 1 }
        }
    },
    {
        $lookup: {
            from: "genres",
            localField: "_id",
            foreignField: "_id",
            as: "genreDetails"
        }
    },
    {
        $unwind: "$genreDetails"
    },
    {
        $project: {
            _id: 0,
            genre: "$genreDetails.name",
            totalBooks: 1
        }
    }
]);


//Average rating of each book query
db.books.aggregate([
    {
        $unwind: "$reviews"
    },
    {
        $group: {
            _id: "$_id",
            title: { $first: "$title" },
            avgRating: { $avg: "$reviews.rating" }
        }
    },
    {
        $project: {
            _id: 0,
            bookId: "$_id",
            title: 1,
            avgRating: 1
        }
    }
]);


//Top 3 Authors by number of books query
db.books.aggregate([
    {
        $unwind: "$author_ids"
    },
    {
        $group: {
            _id: "$author_ids",
            bookCount: { $sum: 1 }
        }
    },
    {
        $sort: { bookCount: -1 }
    },
    {
        $limit: 3
    },
    {
        $lookup: {
            from: "authors",
            localField: "_id",
            foreignField: "_id",
            as: "authorDetails"
        }
    },
    {
        $unwind: "$authorDetails"
    },
    {
        $project: {
            _id: 0,
            authorName: "$authorDetails.name",
            bookCount: 1
        }
    }
]).pretty();
