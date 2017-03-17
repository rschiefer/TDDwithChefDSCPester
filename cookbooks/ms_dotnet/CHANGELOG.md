ms_dotnet CHANGELOG
===================

This file is used to list changes made in each version of the ms_dotnet cookbook.

3.1.0
-----
- b.courtois - Support Windows Server 2016.
- [PR 35][pr-35] b.courtois - Add ability to perform required reboot when installing prerequisites and patches.
- [PR 34][pr-34] b.courtois - Fix patches feature due to invalid prerequisites variable.
- [PR 31][pr-31] Matasx - Add support for .NET version 4.6.2.
- [PR 31][pr-31] Matasx - Resolve `0x80240017 WU_E_NOT_APPLICABLE` [issue with KB2919442][issue-29].

3.0.0
-----

### Improvments

* Introduce new framework LWRP to setup a specific .NET Version with all its prerequisites and patches.
* Detection of the current installed version is now way more accurate.
* Setup of .NET 3.5 is working properly.
* Proper support of .NET 4.6 and .NET 4.6.1.
* Packages and sources overriding is attribute driven.
* Attribute structure is now the same for .NET 2, 3.5 and 4.
* Add chefspecs and rspecs tests.

### Breaking changes

Default recipes and attributes structure have been updated to use the new LWRP.
Refers to the README for description and examples of the new attributes.

2.6.1
-----
- kamaradclimber - Define Windows::VersionHelper::ProductType constants only once

2.6.0
-----
- b.courtois - Use version helper everywhere to remove references to Win32::Version
- b.courtois - Add new helper to retrieve windows version info from ohai
- b.courtois - Use NetFx3ServerFeatures instead of NetFx3 for .NET3.5

2.5.1
-----
- b.courtois - Trust windows_feature behavior in recipe ms_dotnet3

2.5.0
-----
- b.courtois - Supports custom source for .Net 3.5 install
- b.courtois - Use travis container-based infrastructure
- b.courtois - Use travis bundler caching
- b.courtois - Don't test agains ruby 1.9.3 anymore

2.4.0
-----
- Y.Siu - Support .Net3.5 on Windows 8.1 and Server 2012R2.

2.3.0
-----
- b.courtois - Register aspnet to iis once and only if ISS is present.

2.2.1
-----
- minkaotic  - Fix .NET 3.5 install guard clause.

2.2.0
-----
- b.courtois - Do not use the windows_reboot resource and its request action.

2.1.1
-----
- b.courtois - Update constraint to leverage windows cookbook >=1.36.1

2.1.0
-----
- b.courtois - Fix .NET4.5 support on windows 7/Server 2008R2

2.0.0
-----
- b.courtois - Fail chef run when an invalid .NET4 version is specified
- b.courtois - Better support of recents windows version for .NET4
- b.courtois - Add ms_dotnet3 recipe
- b.courtois - Fix ms_dotnet2 recipe and stop to use ms_dotnet2 attributes

1.2.0
-----
- b.courtois - Fail chef run when an invalid .NET4 version is specified

1.1.0
-----
- b.courtois - Fix attributes computation

1.0.0
-----
- b.courtois - Merge recipes ms_dotnet4 and ms_dotnet45
- b.courtois - Add basic support for Server 2012 & 2012R2

0.2.0
-----
- b.courtois - include default recipe on msdotnet2 core install

0.1.0
-----
- j.mauro - Initial release of ms_dotnet

[issue-29]: https://github.com/criteo-cookbooks/ms_dotnet/issues/29
[pr-31]:    https://github.com/criteo-cookbooks/ms_dotnet/pull/31
[pr-34]:    https://github.com/criteo-cookbooks/ms_dotnet/pull/34
[pr-35]:    https://github.com/criteo-cookbooks/ms_dotnet/pull/35
