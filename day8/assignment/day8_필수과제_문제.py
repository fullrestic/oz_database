from pymongo import MongoClient


# 1. 특정 장르의 책 찾기
def search_fantasy_book() :
    client = MongoClient('mongodb://localhost:27017/')
    db = client.local

    query = {"genre" : "fantasy"}
    for doc in db.books.find(query) : 
        print(doc)

    client.close()


# 2.감독별 평균 영화 평점 계산
def director_average_rating() :
    client = MongoClient('mongodb://localhost:27017/')
    db = client.local

    query = [{"$group" : {"_id" : "$director", "average" : {"$avg" : "$rating"}}}]
    for doc in db.movies.aggregate(query) : 
        print(doc)

    client.close()


# 3. 특정 사용자의 최근 행동 조회
def user_recent_action() :
    client = MongoClient('mongodb://localhost:27017/')
    db = client.local

    query = {"user_id" : 1}
    for doc in db.user_actions.find(query).sort({"timestamp" : -1}).limit(5) : 
        print(doc)

    client.close()


# 4. 출판 연도별 책의 수 계산
def count_books_year() :
    client = MongoClient('mongodb://localhost:27017/')
    db = client.local

    query = [{"$group" : {"_id" : "$year", "count" : {"$sum" : 1}}},{"$sort" : {"count" : -1}}]
    for doc in db.books.aggregate(query) :
        print(doc)

    client.close()


# 5. 특정 사용자의 행동 유형 업데이트
def update_user_action() :
    client = MongoClient('mongodb://localhost:27017/')
    db = client.local
    
    db.user_actions.update_many({"user_id" : 1, "timestamp" : {"$lt" : "2023-04-10T00:00:00Z"}, "action" : "view"}, {"$set" : {"action" : "seen"}})

    client.close()



if __name__ == "__main__":
    search_fantasy_book()
    director_average_rating()
    user_recent_action()
    count_books_year()
    update_user_action()