# Description

vbkick - simple bash tool for building Virtualbox Guests and Vagrant Base Boxes (replacement to Veewee).

## Model and Philosophy

Model (base on Unix model):
 - lots of small tools that can be combined in lots of useful ways

Philosophy (also base on Unix Philosophy)
 - do one thing well,
 - small is beautiful, easy to write and easy to maintain,
 - gracefully handle errors and signals,
 - more: Mike Gancarz [The UNIX Philosophy](http://en.wikipedia.org/wiki/Unix_philosophy#Mike_Gancarz:_The_UNIX_Philosophy).

If you think vbkick is great then use it. If you think it is a piece of shit then forget it.

## Why ?

After vagrant 1.1 release veewee stop working in nice way (veewee conflicts with vagrant 1.1+, dependency issues and other blablabla) - there are of course someworkaround available, but mixing installed vagrant package, gem, rvm, bundle in not pleasant in use (read: it is f*** madness).
 - https://github.com/jedi4ever/veewee/issues/607
 - https://github.com/jedi4ever/veewee/issues/611
 - https://github.com/mitchellh/vagrant/blob/v1.2.0/CHANGELOG.md#110-march-14-2013

I decide write something light, what do one thing well, a tool that I can rely on.

There is one job to do: talk to Virtualbox and build a new Guest and/or Vagrant base box for me - nothing more.

Task is mostly about run VBoxManage command in proper order with proper options - bash is perfect for that kind of job - no wrappers (python subprocess.Popen, ruby IO.popen/Kernel.exec, etc.) are needed.


# Getting Started

## Prelude
```
    # clone repo including submodules e.g. templates
    git clone --recursive git@github.com:wilas/vbkick.git

    # default (master) branch is for development, if you prefere use more stable version - choose stable branch
    git checkout stable
```

## Easy install/uninstall

```
    sudo make install
    sudo make uninstall
```

## Manual install/uninstall

```
    sudo install -m 0755 -p vbkick convert_2_scancode.py /usr/local/bin/
    sudo cd /usr/local/bin/ && rm -f vbkick convert_2_scancode.py
```

## Create own box definition

 - look into [examples](examples) and choose method
 - look into [templates](templates) and choose OS (learn also how to organize own definitions)
 - read about [available options](docs/DEFINITION_CFG.md) in definition.cfg

## Usage

```
    vbkick build newVM
    # vbkick postinstall newVM
    vbkick export newVM
    vagrant box add newVM newVM.box
    vagrant box list
```

# Commands

## vbkick

Tested currently only in bash 4.

If you have trouble using script in bash 3, let me know - create issue or send mail to help.vbkick[at]gmail.com.

Note: Probably will be ported to shell instead of bash.

```
    cd to_directory_with definition.cfg

    vbkick help

    vbkick  <action>     <vm_name>
    vbkick  build        VM_NAME        # build VM
    vbkick  postinstall  VM_NAME        # run postinstall scripts via ssh
    vbkick  validate     VM_NAME        # Not Implemented yet !!!
    vbkick  export       VM_NAME        # export VM and create Vagrant VM_NAME.box
    vbkick  destroy      VM_NAME        # destroy VM
```

## convert_2_scancode.py

convert_2_scancode.py is a [filter](http://en.wikipedia.org/wiki/Filter_%28Unix%29) - handle input from pipe or file.

Help enter key-strokes into a VirtualBox guest programmatically from the host.

Works in both python 2.6+ and python 3.

Example:
```
    $ VBoxManage controlvm VM_NAME keyboardputscancode $(printf "Hello VM" | convert_2_scancode.py)
    $ VBoxManage controlvm VM_NAME keyboardputscancode $(printf "<Multiply(Hello, 3)> VM" | convert_2_scancode.py)
```

Example keyboard scancodes:
```
    $ printf "Hello VM" | convert_2_scancode.py
    2a 23 a3 aa 12 92 26 a6 26 a6 18 98 39 b9 2a 2f af aa 2a 32 b2 aa

    $ printf "<Multiply(H,3)>" | convert_2_scancode.py
    2a 23 a3 aa 2a 23 a3 aa 2a 23 a3 aa
    
    $ printf "<Multiply(<Wait>,3)>" | convert_2_scancode.py
    wait wait wait 
```

Special keys:

`<Wait>` -  help control boot flow within vbkick (FYI: can not be use directly with VBoxManage)

`<Multiply(what, N)>` - repeat "what" N times

```
    $ VBoxManage controlvm VM_NAME keyboardputscancode $(printf "Hello <Wait> VM" | convert_2_scancode.py)
    VBoxManage: error: Error: 'wait' is not a hex byte!
```

# TODO:

```
vbkick:275:    # todo [MEDIUM]: wait until machine will be rebooted and ssh start working (before kickstart_timeout),
vbkick:377:        # todo [MEDIUM]: shutdown VM using ssh and halt/poweroff cmd (nicer for OS)
vbkick:437:    # todo [MEDIUM]: test should be smart enought to check what I really want to test

consider change bash to sh -> to increase portability
```

# Bibliography

 - !! veewee: https://github.com/jedi4ever/veewee
 - !! vagrant: https://github.com/mitchellh/vagrant
 - virtualbox manual: http://www.virtualbox.org/manual/ch08.html
 - controle vm with api: http://www.jedi.be/blog/2009/11/17/controlling-virtual-machines-with-an-API/
 - !! Unix Philosophy: http://en.wikipedia.org/wiki/Unix_philosophy
 - Filter (Unix): http://en.wikipedia.org/wiki/Filter_%28Unix%29
 - well-behave Python cmd line app: http://www.slideshare.net/gjcross/tutorial1-14045370

