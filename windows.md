
# How to Make Signed Commits in GitHub

Signing, or code signing specifically, is the process of using cryptography to digitally add a signature to data. The receiver of the data can verify that the signature is authentic, and therefore must've come from the signatory. It's like physical signatures, but digital and more reliable


# Quick Guide to Sign Your Git Commits

### Why Should I Sign Git Commits?

Clearly, this is the first question that bumps into your mind after hearing about signing Git commits.

Okay, if you’re into Git, you might have already known that you can change git commit author name and email in a simple command.

### GitHub Config SetUp
```bash
git config --global user.name "YOUR_GITHUB_USERNAME"
git config --global user.email "YOUR_GITHUB_EMAIL"
```


### Download and install GPG4Win: https://www.gpg4win.org/get-gpg4win.html (Use local account when prompted to avoid admin!)

1.Open PowerShell With Admin and Type this
which.exe gpg 

copy the output 

open the Start menu and search for "Environment Variables."

Select "Edit the system environment variables."

Click the "Environment Variables" button.

Under "System Variables," scroll down and find "Path."

Click "Edit."

Click "New" and add paste the path to the GPG executable file

Click "OK" to close all the windows.

Open a new command prompt or terminal window and try running the "gpg" command again.


Open CMD 
and type gpg

if no error then all good

### When Running for the First Time it will ask for Name , Email , Password , Passphrase
```bash
  gpg --full-generate-key
```
## Screenshots

![App Screenshot](https://i.imgur.com/wxY80w3.png)
![App Screenshot](https://i.imgur.com/7YF5e75.png)

### Get Your KEY ID
```bash
  gpg --list-secret-keys --keyid-format LONG
```

### Example :

```bash
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec 4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                        Hubot 
ssb 4096R/42B317FD4BA89E7A 2016-03-10
```

 #### Here The Key ID is **3AA5C34371567BD2**

### Make your key public and recognizable around Internet now. Run this command:

```bash
gpg --send-keys 3AA5C34371567BD2
```
Don’t worry, this command will send public key only, it never sends your secret key!


### Add key to Github
Now, let’s export your public key from key ID.

```bash
gpg --armor --export 3AA5C34371567BD2
```

### Example 
Copy From  ---- BEGIN PGP to KEY BLOCK -------
```bash
-----BEGIN PGP PUBLIC KEY BLOCK-----
<Long Random Text>
-----END PGP PUBLIC KEY BLOCK-----
```

### Go to Settings > SSH and GPG keys section on Github.

### Click green button to add New GPG Key.

### Copy and paste above public key and click button to add.




## Screenshots

![App Screenshot](https://i.imgur.com/FcedzuI.png)

![App Screenshot](https://i.imgur.com/YCdWSAT.png)




### Check Where is gpg in your Folders
## Open PowerShell and Type this

```bash
where.exe gpg
```
### Example

```bash
C:\Program Files (x86)\GnuPG\bin\gpg.exe
```

### Add Path 


```bash
git config --global gpg.program "C:\Program Files (x86)\GnuPG\bin\gpg.exe"
```

### Check your Key ID


```bash
gpg --list-secret-keys --keyid-format LONG

/home/suhail/.gnupg/pubring.kbx
-------------------------------
sec   rsa3072/3AA5C34371567BD2 2022-10-30 [SC] [expires: 2024-10-29]
      F7EFC23FF92C79301F40847852AE60C1EE3A6501
uid                 [ultimate] suhailroushan <suhailroushan13@gmail.com>
ssb   rsa3072/AD20B7AA5EFC0B10 2022-10-30 [E] [expires: 2024-10-29]
```

Your Key ID Is **3AA5C34371567BD2** from sec 

### Add the Signing Key to your global git config so that all your git commits are verified

```bash
git config --global user.signingkey 3AA5C34371567BD2
git config --global commit.gpgsign true
```



