  Feature:Dummy api test

  Background: Define URL
      Given url apiUrl

    Scenario: List users

      Given path 'users'
      When method Get
      Then status 200
    Scenario: Get specific user
       Given param id = 2
       Given path 'users'
       When method Get
       Then status 200
       And match response.data.first_name == 'Janet'
       And match response.data.last_name == '#string'

     Scenario: Not found user
       Given path 'users'
       Given param id = 1001
       When method Get
       Then status 404

     Scenario: Create and update user
       Given path 'users'
       And request
       """
         {
         "data":
       {
           "id": 100,
           "email": "test.bluth@reqres.in",
           "first_name": "Test",
           "last_name": "Bluth",
           "avatar": "https://reqres.in/img/faces/1-image.jpg"
       }
     }
       """
       When method Post
       Then status 201

       * def userID = response.data.id

      
       Given path 'users', userID
       And request 
       """
         {
           data:
           {
            "id": 100,
           "email": "test.bluth@reqres.in",
           "first_name": "Berfin",
           "last_name": "Sert",
           "avatar": "https://reqres.in/img/faces/1-image.jpg"
           }
         }
       """
       When method Put
       Then status 200
       And match response.data.last_name != 'Bluth'

     Scenario: Delete user
      Given path 'users/2'
      And request 
      """
        {
          data:
          {
            "id": 2,
            "first_name":'Janet'
          }
        }
      """
        When method Delete
        Then status 204

     Scenario: Update user
      Given path 'users/2'
      And request
      """
        {
          data:
          {
            "id": 1,
            "first_name": 'Asdasd'
          }
        }
      """
        When method Put
        Then status 200

        Given path 'users'
        When method Get
        Then status 200
    






  