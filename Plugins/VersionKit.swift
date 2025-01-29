import PackagePlugin

@main
struct VersionKit: BuildToolPlugin {
    /// Entry point for creating build commands for targets in Swift packages.
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let toolCommand = Command.prebuildCommand(
            displayName: "Git describe",
            executable: try context.tool(named: "git").path,
            arguments: ["describe", "--tags", "--abbrev=0"],
            outputFilesDirectory: context.pluginWorkDirectory
        )

        return [toolCommand]
    }
}
