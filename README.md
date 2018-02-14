# Test-Falsy
A Falsy Checking Powershell Utility. Evaluating falsy in powershell is not fun. This is a handy utility I include in almost all my scripts. Feel free to use it.

# Getting Started

1) Clone
```bash
git clone https://github.com/jakobii/test-falsy.git
```

2) Import
```powershell
import-module ".\test-falsy\test-falsy.psm1"
```

3) Use

```powershell
Test-Falsy -Evaluate $foo
```


# Parameter 
```powershell
Test-Falsy -Evaluate <Any> [-AsFalse <switch>] [-Verbosely <Switch>] 
```

### Description
***Falsy*** is any value that should equal the boolean *false* when being evaluated by a [conditional statement](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators). Examples of Powershell conditional statements are *If* , *While* , *-eq* , and *-ne*. By default Test-Falsy returns the boolean true to signify a positive match to a falsy definition.

Falsy definitions
- [int] Zero
- [float] Zero
- [string] Empty
- [string] Whitespace
- [dbnull] SqlServer
- [null] SqlServer


### Alias
The module will set *Test-Falsy* with an alias of ***tf***

### -Evaluate
The value that will be tested as falsy.
- Parameter type: **Undefined**
- Required: **True**
- Alias: **-e**

### -AsFalse
Causes Test-Falsy to return the boolean FALSE when the value provided equates to a qualifying Falsy definition
- Parameter type: **Switch**
- Required: **False**
- Alias: **-af**

### -Verbosely
Will cause Test-Falsy to write to the host the falsy definition that is matched.
- Parameter type: **Switch**
- Required: **False**
- Alias: **-v**



# Examples
These are some common situation I find myself in.

If $Foo is falsy perform some action.
```powershell
If(tf $Foo){
    #DO SOMETHING..
} 
```

Or Perform Some action until $Foo is no longer falsy.
```Powershell
do{
    #DO SOMETHING..
}
until(tf $Foo -af) 
```