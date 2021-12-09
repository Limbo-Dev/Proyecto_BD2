using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Proyecto
{
    class Program
    {
        static void Main(string[] args)
        {
            char op = 'y';
            string texto = string.Empty;
            while (op == 'y')
            {
                Console.WriteLine("Escriba un mensaje para encriptar: ");
                texto = Console.ReadLine();

                using (Aes myAes = Aes.Create())
                {

                    // Encriptamos el mensaje a un array de bytes.
                    byte[] encrypted = EncryptStringToBytes_Aes(texto, myAes.Key, myAes.IV);

                    // descriframos el array de bytes a un mensaje string.
                    string roundtrip = DecryptStringFromBytes_Aes(encrypted, myAes.Key, myAes.IV);

                    //mostramos el mensaje original, el mensaje encriptado y decifrado.
                    Console.WriteLine("Mensaje original:   {0}", texto);
                    Console.WriteLine("Mensaje encriptado: " + ByteArrayToString(encrypted));
                    Console.WriteLine("Mensaje descriptado: {0}", roundtrip);
                }
                

                Console.WriteLine("desea volver encriptar otro mensaje? y/n");
                op = char.Parse(Console.ReadLine().ToLower());
            }
        }
        static byte[] EncryptStringToBytes_Aes(string plainText, byte[] Key, byte[] IV)
        {
            // Verificamos de que las variables recibidas no esten vacias.
            if (plainText == null || plainText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");
            byte[] encrypted;

            // Creamos un objeto Aes
            // Con la llave y IV especificado.
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Creamos un encriptor para realizar la transformacion de la secuencia.
                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                // Creamos el canal o memoria utilizado para la encriptacion.
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            //Escribimos todos los datos en el canal o memoria.
                            swEncrypt.Write(plainText);
                        }
                        encrypted = msEncrypt.ToArray();
                    }
                }
            }

            // Devolvemos los bytes cifrados del canal de la memoria.
            return encrypted;
        }

        static string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
        {
            // Verificamos los datos no sean nulos.
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");

            // Declaramos una variable string para 
            // guardar el texto desencriptado.
            string plaintext = null;

            // Creamos un objeto AES
            // con la llave y IV especificado.
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Creamos un desencriptor para realizar la transformacion de la secuencia de bytes.
                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                // Creamos el canal o memoria utilizado para la desencriptacion.
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {

                            // Leemos los bytes descifrados del canal de desencriptacion
                            // y lo guardamos en la variable string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }

            // Devolvemos el texto descifrado
            return plaintext;
        }

        // Esta funcion es utlizado para guardar el mensaje cifrado en bytes
        public static string ByteArrayToString(byte[] ba)
        {
            // Utilizamos un stringbuilder para concatenar los valores del array para
            // completar el mensaje encriptado
            StringBuilder hex = new StringBuilder(ba.Length * 2);
            foreach (byte b in ba)
                hex.AppendFormat("{0:x2}", b);
            return hex.ToString();
        }
    }
}


