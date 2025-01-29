import PackagePlugin

@main
struct VersionKit: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let executable = try context.tool(named: "git").path
        let arguments = ["describe", "--tags", "--abbrev=0"]

        let toolCommand = Command.prebuildCommand(
            displayName: "Show the most recent git tag",
            executable: executable,
            arguments: arguments,
            outputFilesDirectory: context.pluginWorkDirectory
        )

        return [toolCommand]
    }
}
