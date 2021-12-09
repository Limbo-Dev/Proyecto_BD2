Imports System.Data.SqlClient
Public Class Form4
    Dim connection As New SqlConnection("Data Source=.;Initial Catalog=db_Delta;Integrated Security=True")
    Private Sub Form4_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        connection.Open()
        Dim QueryString As String = "select * from DISTRIBUIDOR"
        Dim table As New DataTable()
        Dim Command As New SqlCommand(QueryString, connection)
        Dim adapter As New SqlDataAdapter(Command)
        adapter.Fill(table)
        DataGridView1.DataSource = table
        connection.Close()
    End Sub
End Class