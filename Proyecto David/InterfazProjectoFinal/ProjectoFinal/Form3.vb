Imports System.Data.SqlClient
Public Class Form3
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
        cmd.CommandText = "ACTUALIZAR_AUTO"
        cmd.ExecuteNonQuery()
        connection.Close()
        Form1.showdata()
    End Sub

    Private Sub Form3_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        TextBox1.Text = Form1.DataGridView1.Item("NUMPLACA", Form1.DataGridView1.CurrentRow.Index).Value
        TextBox2.Text = Form1.DataGridView1.Item("MARCA", Form1.DataGridView1.CurrentRow.Index).Value
        TextBox3.Text = Form1.DataGridView1.Item("DISTRIBUIDOR", Form1.DataGridView1.CurrentRow.Index).Value
        TextBox4.Text = Form1.DataGridView1.Item("TIPO_MOTOR", Form1.DataGridView1.CurrentRow.Index).Value
        TextBox5.Text = Form1.DataGridView1.Item("TIPO_VEHICULO", Form1.DataGridView1.CurrentRow.Index).Value
        TextBox6.Text = Form1.DataGridView1.Item("AUTO_ANIO", Form1.DataGridView1.CurrentRow.Index).Value
        TextBox7.Text = Form1.DataGridView1.Item("PRECIO_ALQUILER", Form1.DataGridView1.CurrentRow.Index).Value
    End Sub
End Class