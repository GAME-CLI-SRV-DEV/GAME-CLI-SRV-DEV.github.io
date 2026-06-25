<img width="201" height="131" alt="image" src="https://github.com/user-attachments/assets/01af02aa-60d4-4303-a49f-fccff0a52d05" />

# Mappy
ViewMultimedia Game Engine Library.

# gradle Dependency
```
plugins {
    id 'com.viewmultimediainternet.game.mappy-compile' 1.12.3-SNAPSHOT
    id 'java'
}

repositories {
    maven { url = uri("https://repo.viewmultimediainternet.com/git") }
}
dependencies {
    implementation("com.viewmultimediainternet.game:mappy:1.12.3-SNAPSHOT") // main
    implementation("com.viewmultimediainternet.game:mappy-obf:1.12.3-SNAPSHOT") // obfuscator
}
```

# Mappy-compile
To Compile Your game, add the mappy-compile
## Mappy
if you compile using mappy-obf, you need to run ./gradlew mappy-jar.
this creates a jar.

if you are not monetizing, this is a good thing.

## Mappy-obf
if you compile using mappy-obf, you need to run ./gradlew mappy-obfuscate-jar.
this obfuscate jarclass and make a mapping system, and embeds it to meta-inf.

if you are monetizing, this is a good thing.

# running
```
user@viewmultimedia MINGW64 /d/viewmultimedia/testserver
$ java -jar minecraft-viewmultimedia.jar
mappy.createobj(1) OK
```

once you execute a jar, mappy will run the code and will execute it.
```
user@viewmultimedia MINGW64 /d/viewmultimedia/testserver
$ java -jar minecraft-viewmultimedia.jar
mappy.createobj(1) OK
mappy.createobj(2) NO
IDException : ID / Name Not found.
```
after the code runs, there is a status code:\
OK - Code ran successfully\
NO - Exception\
(!) - Warning

### Creating a map
to create a map, create a map using
`mappy.build("");`.\
to show your map online, create a mappy server using
`mappy.server(server-ip="", port="")`

## Mappy commander
to use mappy commander type `mappy.cmdinit()`
