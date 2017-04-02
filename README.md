# ASP.NET Core Hello World CodeFresh Demo

[![Codefresh build status]( https://g.codefresh.io/api/badges/build?repoOwner=dzirkler&repoName=aspnetcorehelloworld&branch=master&pipelineName=aspnetcorehelloworld&accountName=dzirkler&type=cf-1)]( https://g.codefresh.io/repositories/dzirkler/aspnetcorehelloworld/builds?filter=trigger:build;branch:master;service:58e07d37cc95fd01008e4e16~aspnetcorehelloworld)

This was set up as a proof-of-concept to perform a CodeFresh build for an ASP.NET Core app. The app can be found in 
the `/hwweb` folder, and is simply the result of a `dotnet new mvc -o hwweb` command.

I wanted to be able to use [CodeFresh](http://codefresh.io) to enable Continuous Integration for ASP.NET Core apps.
Microsoft provides both `[aspnet](https://hub.docker.com/r/microsoft/aspnet/)` (runtime) and 
`[aspnet-build](https://hub.docker.com/r/microsoft/aspnet-build/)` builds for ASP.NET Core. Unforutnately, to build an 
ASP.NET Core app from source code, you need to use the `aspnet-build`, which includes a lot of extra bulk. I've chosen 
to pre-compile using the SDK. Once you have the files built, you can use the built files in the `aspnet` container. 
This enables us to have a smaller container, and only contain the minimum to run our application (which also enhances 
security by not including the sdk). Additionally, we do not need to include our source code in the container!

The way this works, is we fire up a container with the SDK and perform a build on a mounted volume. Then, we use
the output folder from the build (`/out`) to create a new image. The same paradigm works in CodeFresh and locally.


## Build locally for testing:

1. From the project directory (where this readme is located), build the app:  
`docker run -it --rm -v "$(pwd):/src" --workdir /src microsoft/dotnet:1.1.1-sdk /bin/bash /src/build.sh`
1. Build the docker image:  
`docker build . --tag organizaton/repo:tag`  
    * Use your own org and repo names here.
1. Run the new image:  
`docker run -d -p 8000:80 organization/repo:tag`
    * Open your browser to http://localhost:8000/ and you should see the boilerplate website.


## Build using CI in CodeFresh

1. Fork Repo to your own GitHub Org
1. Update `codefresh.yml` with your docker hub repo and image name.
1. Configure a new repo in [CodeFresh](http://codefresh.io) to build from your new forked repo
    * Be sure you use the `codefresh.yml` option
1. Marvel at the awesomeness of your own .NET Core app auto build!


## Thanks
The general approach was borrowed from [Steve Lasker's Blog](https://blogs.msdn.microsoft.com/stevelasker/2016/09/29/building-optimized-docker-images-with-asp-net-core/)

