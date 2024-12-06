# Home Assistant Addons Repository - RobertVPettigrew

![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/t/RobertVPettigrew/Java-MC-Homeasistant-Addon/main?style=plastic&logo=Github)
![GitHub repo size](https://img.shields.io/github/repo-size/RobertVPettigrew/Java-MC-Homeasistant-Addon?style=plastic&logo=Github)
![GitHub language count](https://img.shields.io/github/languages/count/RobertVPettigrew/Java-MC-Homeasistant-Addon?style=plastic&logo=Github)
![GitHub top language](https://img.shields.io/github/languages/top/RobertVPettigrew/Java-MC-Homeasistant-Addon?style=plastic&logo=Github)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/RobertVPettigrew/Java-MC-Homeasistant-Addon/main?style=plastic&logo=Github)

This repository contains several custom Home Assistans Addons for education, testing and more.
To add this to your Home Assistant instance you can use the button below.

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FRobertVPettigrew%2FJava-MC-Homeasistant-Addon)

<!--
Add-on documentation: <https://developers.home-assistant.io/docs/add-ons>
 -->

## Addons

This repository contains the following add-ons

<!--
### [Spawn Point Bedrock](./addon-ha-spawn-point-bedrock)
 -->

### Spawn Point Bedrock

![Static Badge](https://img.shields.io/badge/release-2024.10.0-blue?style=plastic&label=release)
![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_Minecraft Server Bedrock Edition_

A Minecraft Server Bedrock which is fully configured with the Home Assistant add-on configuartion UI.

<!--

Notes to developers after forking or using the github template feature:
- While developing comment out the 'image' key from 'example/config.yaml' to make the supervisor build the addon
  - Remember to put this back when pushing up your changes.
- When you merge to the 'main' branch of your repository a new build will be triggered.
  - Make sure you adjust the 'version' key in 'example/config.yaml' when you do that.
  - Make sure you update 'example/CHANGELOG.md' when you do that.
  - The first time this runs you might need to adjust the image configuration on github container registry to make it public
  - You may also need to adjust the github Actions configuration (Settings > Actions > General > Workflow > Read & Write)
- Adjust the 'image' key in 'example/config.yaml' so it points to your username instead of 'home-assistant'.
  - This is where the build images will be published to.
- Rename the example directory.
  - The 'slug' key in 'example/config.yaml' should match the directory name.
- Adjust all keys/url's that points to 'home-assistant' to now point to your user/fork.
- Share your repository on the forums https://community.home-assistant.io/c/projects/9
- Do awesome stuff!
 -->

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green?style=plastic
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green?style=plastic
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green?style=plastic
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green?style=plastic
[i386-shield]: https://img.shields.io/badge/i386-yes-green?style=plastic

#### References
- Thanks to [aph-le] (https://github.com/aph-le/home-assistant-addons) for this project
- Thanks to [itzg](https://github.com/itzg/docker-minecraft-bedrock-server) for the minecraft server docker image inspiration.
- Thanks to [williamcorsel](https://github.com/williamcorsel/hassio-addons) for the home assistant minecraft addon inspiration.
- Thanks to [TheRemote](https://github.com/TheRemote/Legendary-Java-Minecraft-Geyser-Floodgate) for the minecraft Java/Geyser/Floddgate inspiration.
