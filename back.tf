trigger:
- main  # or the branch you want to trigger the build

pool:
  vmImage: 'ubuntu-latest'  # The build agent used (Ubuntu image)

variables:
  pythonVersion: '3.8'  # Specify Python version

steps:
# Step 1: Install dependencies (similar to the 'install' phase in CodeBuild)
- task: UsePythonVersion@0
  inputs:
    versionSpec: '$(pythonVersion)'
    addToPath: true

- script: |
    echo Installing dependencies...
    pip install -r requirements.txt
  displayName: 'Install dependencies'

# Step 2: Package the Lambda function (similar to the 'build' phase in CodeBuild)
- script: |
    echo Packaging the Lambda function...
    zip -r backup.zip .
  displayName: 'Package Lambda function'

# Step 3: Publish the artifact (similar to 'artifacts' section in CodeBuild)
- publish: $(Build.ArtifactStagingDirectory)/backup.zip
  artifact: drop
  displayName: 'Publish Lambda artifact'
