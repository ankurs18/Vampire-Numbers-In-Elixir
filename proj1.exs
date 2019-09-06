# Task.start_link(fn -> VampireNumber.Test.start() end)
# VampireNumber.Test.start()

# VampireNumber.Find.fetch(100_000, 200_000)

# VampireNumber.Find2.fetch(100_000, 200_000)

VampireNumber.CLI.run(System.argv())

# task = Task.async(fn -> VampireNumber.CLI.run(System.argv()) end)
# IO.inspect(task, label: "task")
# IO.inspect(Task.await(task))
