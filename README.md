# Rector TYPO3 test project

## Introduction

Preinstalled TYPO3 project for testing purposes.

## Installation & Usage

Start and wait for your fresh TYPO3CMS installation with introduction package:

```bash
docker-compose up --build -d
docker-compose logs  -f  # to see the logs
```

### Commands

table of commands:

| Command                        | Description                                        |
| ------------------------------ | -------------------------------------------------- |
| `docker-compose up --build -d` | Start TYPO3CMS with introduction package.          |
| `bin/bash`                     | Open bash shell in TYPO3CMS container.             |
| `bin/typo3`                    | Runs _typo3_ cli command in TYPO3CMS container.    |
| `bin/typo3cms`                 | Runs _typo3cms_ cli command in TYPO3CMS container. |
| `bin/rector`                   | Runs _rector_ command in TYPO3CMS container.       |

### Rector

An specific rector for TYPO3CMS was added automatically to the root directory.
So you can run it with:

```bash
./bin/rector process public/typo3conf/ext/introduction --dry-run
```

#### Result

```diff
 16/16 [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓] 100%
2 files with changes
====================

1) public/typo3conf/ext/introduction/ext_emconf.php:18

    ---------- begin diff ----------
@@ @@
     'category' => 'distribution',
     'version' => '4.4.1',
     'state' => 'stable',
-    'clearcacheonload' => 1,
+    'clearCacheOnLoad' => true,
     'author' => 'Introduction Package Team',
     'author_email' => '',
     'constraints' => [
    ----------- end diff -----------

Applied rules:
 * ExtEmConfRector (https://docs.typo3.org/m/typo3/reference-coreapi/master/en-us/ExtensionArchitecture/DeclarationFile/Index.html)


2) public/typo3conf/ext/introduction/ext_localconf.php:12

    ---------- begin diff ----------
@@ @@
  * The TYPO3 project - inspiring people to share!
  */

-defined('TYPO3_MODE') or die('Access denied.');
+defined('TYPO3') or die('Access denied.');

 \TYPO3\CMS\Core\Utility\ExtensionManagementUtility::addTypoScriptSetup('
   module.tx_form.settings.yamlConfigurations.100 = EXT:introduction/Configuration/Form/CustomFormSetup.yaml
    ----------- end diff -----------

Applied rules:
 * SubstituteConstantsModeAndRequestTypeRector (https://docs.typo3.org/c/typo3/cms-core/master/en-us/Changelog/11.0/Deprecation-92947-DeprecateTYPO3_MODEAndTYPO3_REQUESTTYPEConstants.html)

 [OK] 2 files would have changed (dry-run) by Rector

```

## Use other TYPO3 versions

Edit the `TYPO3_VERSION` environment variable in `.env` file.
Abailable versions: 8,9,10,11
