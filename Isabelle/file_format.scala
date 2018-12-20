/*
Authors: Makarius (2018)

Support for NaProChe / ForTheL files in Isabelle/PIDE.
*/

package isabelle.naproche

import isabelle._


object File_Format
{
  class Agent extends isabelle.File_Format.Agent
  {
    private val process =
      Bash.process("""export PATH="$E_HOME:$SPASS_HOME:$PATH"; exec "$NAPROCHE_EXE" --server""",
        cwd = Path.explode("$NAPROCHE_HOME").file)

    private val server_info: Option[Server.Info] =
      for {
        line <- File.read_line(process.stdout)
        info <- Server.Info.parse(line)
      } yield info

    private val process_result = Future.thread("Naproche-SAD") { process.result() }

    if (server_info.isEmpty) {
      Thread.sleep(50)
      process.terminate
      val errs = process_result.join.err_lines
      error(cat_lines("Naproche-SAD server failure" :: errs))
    }

    override def toString: String = server_info.get.toString

    override def prover_options(options: Options): Options =
      options +
        ("naproche_server", server_info.get.address) +
        ("naproche_server_password", server_info.get.password)

    override def stop
    {
      process.terminate
      process_result.join
    }
  }
}

class File_Format extends isabelle.File_Format
{
  val format_name: String = "forthel"
  val file_ext: String = "ftl"

  override def theory_suffix: String = "forthel_file"
  override def theory_content(name: String): String =
    """theory "ftl" imports Naproche.Naproche begin forthel_file """ + quote(name) + """ end"""

  override def start(session: Session): File_Format.Agent = new File_Format.Agent
}
