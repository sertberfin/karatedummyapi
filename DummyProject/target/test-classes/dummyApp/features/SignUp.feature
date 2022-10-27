Feature: New user sign up

Background: Preconditions
    Given url apiUrl

Scenario: Sign up
    Given path 'register'
    And request
    """
        
            {
            "email": 'eve.holt@reqres.in',
            "password": 'pistol'
        }
        
    """
    When method Post
    Then status 200
    And match response.id == 4

Scenario: Missing password

    Given path 'register'
    And request
    """
        
        {
            "email": "sydney@fife"
        }
        
    """
    When method Post
    Then status 400

Scenario: Login
    Given path 'login'
    And request
    """
        {
    "email": "eve.holt@reqres.in",
    "password": "cityslicka"
}
    """
    When method Post
    Then status 200
    And match response.token == 'QpwL5tke4Pnpja7X4'

Scenario: Login missing password
    Given path 'login'
    And request
    """
        {
            "email": "peter@klaven"
       }

    """
    When method Post
    Then status 400

Scenario: Delayed Response
    Given path 'users?delay=3'
    When method Get
    Then status 200
