var XMLHttpRequest = require('xhr2');
var peeps = [
		{"name": "Bob", "word": "All"},
		{"name": "Alice", "word": "is"},
		{"name": "Lewis", "word": "quiet"},
		{"name": "Charles", "word": "on"},
		{"name": "Nancy", "word": "the"},
		{"name": "Karen", "word": "western"},
		{"name": "Joe", "word": "front"},
		{"name": "Fred", "word": "send"},
		{"name": "Barney", "word": "more"},
		{"name": "Thelma", "word": "tea"}
	];

var Person = function(name, word) {
    this.name = name;
    this.word = word;
};

Person.prototype.talk = function(callback) {
    url = "https://api.datamuse.com/words?rel_rhy=" + this.word
    var xhr = new XMLHttpRequest();
    xhr.timeout = 2000;
    return new Promise(function(resolve, reject) {
        xhr.onreadystatechange = function(e) {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    resolve(JSON.parse(xhr.responseText)[0]["word"]);
                } else {
                    reject("Error, status code = " + xhr.status);
                }
            }
        }
        xhr.ontimeout = function() {
            console.log('Timeout');
        }
        xhr.open('get', url, true);
        xhr.send();
    });
};

// Create an array of objects Person, each one has a word
var people = []
peeps.forEach(obj => people.push(new Person(obj["name"], obj["word"])));

var homynyms = []
var words = []

console.log('--------------------- Game of telephone ---------------------');
(async () => {
    for (let person of people) {
        const homynym = await person.talk();
        homynyms.push(homynym);
        words.push(person.word);
        console.log(person.name + ' says ' + person.word + ', listener hears ' + homynym);
    }
    console.log('\n--------------------- words used ---------------------');
    console.log(words.join(' '));
    console.log('\n--------------------- Final ---------------------');
    console.log(homynyms.join(' '));
})(); 
