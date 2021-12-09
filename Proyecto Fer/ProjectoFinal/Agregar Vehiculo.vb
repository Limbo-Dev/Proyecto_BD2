Imports System.Data.SqlClient

Public Class Form2
    Dim connection As New SqlConnection("Data Source=.;Initial Catalog=db_Delta;Integrated Security=True")

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        connection.Open()
        Dim cmd As New SqlCommand()
        cmd.Connection = connection
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@NUMPLACA", TextBox1.Text))
        cmd.Parameters.Add(New SqlParameter("@MARCA", TextBox2.Text))
        cmd.Parameters.Add(New SqlParameter("@DISTRIBUIDOR", TextBox3.Text))
        cmd.Parameters.Add(New SqlParameter("@TIPO_MOTOR", TextBox4.Text))
        cmd.Parameters.Add(New SqlParameter("@TIPO_VEHICULO", TextBox5.Text))
        cmd.Parameters.Add(New SqlParameter("@AUTO_ANIO", TextBox6.Text))
        cmd.Parameters.Add(New SqlParameter("@PRECIO_ALQUILER", TextBox7.Text))
        cmd.CommandText = "INSERTAR_AUTO"
        cmd.ExecuteNonQuery()
        connection.Close()
        Form1.showdata()
        Me.Hide()
    End Sub

    Private Sub Form2_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub
End Class