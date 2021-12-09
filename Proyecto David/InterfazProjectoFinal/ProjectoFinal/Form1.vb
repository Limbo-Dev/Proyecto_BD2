Imports System.Data.SqlClient
Public Class Form1
    Dim connection As New SqlConnection("Data Source=.;Initial Catalog=db_Delta;Integrated Security=True")
    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        showdata()
    End Sub

    Public Sub showdata()
        connection.Open()
        'Dim QueryString As String = "select AUTO.NUMPLACA, AUTO.MARCA, DISTRIBUIDOR.NOMBRE, AUTO.TIPO_MOTOR, AUTO.TIPO_VEHICULO, AUTO.AUTO_ANIO, AUTO.PRECIO_ALQUILER  from AUTO INNER JOIN DISTRIBUIDOR On AUTO.DISTRIBUIDOR=DISTRIBUIDOR.ID;"
        Dim QueryString As String = "select * from AUTO"
        Dim table As New DataTable()
        Dim Command As New SqlCommand(QueryString, connection)
        Dim adapter As New SqlDataAdapter(Command)
        adapter.Fill(table)
        DataGridView1.DataSource = table
        connection.Close()
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Form2.Show()
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        connection.Open()
        Dim cmd As New SqlCommand()
        Dim data As String = DataGridView1.Item("NUMPLACA", DataGridView1.CurrentRow.Index).Value
        cmd.Connection = connection
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@NUMPLACA", data))
        cmd.CommandText = "ELIMINAR_AUTO"
        cmd.ExecuteNonQuery()
        connection.Close()
        showdata()

    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Form3.Show()
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        connection.Open()
        Dim cmd As New SqlCommand()
        Dim data As String = TextBox1.Text
        Dim table As New DataTable()
        cmd.Connection = connection
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@NUMPLACA", data))
        cmd.CommandText = "SELECCIONAR_AUTO"
        Dim adapter As New SqlDataAdapter(cmd)
        adapter.Fill(table)
        DataGridView1.DataSource = table
        connection.Close()
    End Sub

    Private Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click
        showdata()
    End Sub

    Private Sub Button6_Click(sender As Object, e As EventArgs) Handles Button6.Click
        Form4.Show()
    End Sub
End Class
