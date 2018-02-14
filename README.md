# Test-Falsy
A Falsy Checking Powershell Utility


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


# Parameters
```powershell
Test-Falsy -Evaluate <Any> [-AsFalse <switch>] [-Verbosely <Switch>] 
```

### -Evaluate
The value that will be Evaluated as falsy.
- Falsy Values
    - [int] Zero
    - [float] Zero
    - [string] Empty
    - [string] Whitespace
    - [dbnull] SqlServer
    - [null] SqlServer

- Parameter type: **Undefined**
- Required: **True**
- Alias: **-e**

### -AsFalse
Cause Test-Falsy to return [bool]$False when the value provided qualifies as blank or null.
- Parameter type: **Switch**
- Required: **False**
- Alias: **-af**

### -Verbosely
Will cause Test-Falsy to write to the host the type that is matched if null is found.
- Parameter type: **Switch**
- Required: **False**
- Alias: **-v**

### Alias
The module will set *Test-Falsy* with an alias of ***tf***


# Examples
Evaluating blanks and nulls as falsy in powershell is not fun. This is a handy utility I include in almost all my scripts. These are some common situation I find myself in.

If $Foo is null perform some action.
```powershell
If(tf $Foo){
    #DO SOMETHING..
} 
```

Or Perform Some action until $Foo is no longer null.
```Powershell
do{
    #DO SOMETHING..
}
until(tf $Foo -af) 
```

Not having to worry if a string is null or emtpy is nice.
```powershell
# Powershell converts $null into an empty string "" automatically
[string]$foo = $null

# RETURNS [bool]False. Empty string is not equal to null.
$foo -eq $null

# RETURNS [bool]True. Empty strings are Falsy to sane people.
tf $foo
```