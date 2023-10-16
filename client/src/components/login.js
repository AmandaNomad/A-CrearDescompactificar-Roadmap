import React, { useState } from 'react';
import { Avatar, Grid, Paper, TextField, Typography, Link } from '@mui/material';
import LockPersonIcon from '@mui/icons-material/LockPerson';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import Button from '@mui/material/Button';
import { Formik, Field, Form, ErrorMessage } from 'formik'
import * as Yup from 'yup'
import axios from 'axios'

const Login = ({ handleChange }) => {
    const endPointBase = "http://localhost:3000";
    const searchUserLoginEndpoint = endPointBase + "/api/login";
    const paperStyle = { padding: 20, height: '73vh', width: 390, margin: "0 auto" }
    const avatarStyle = { backgroundColor: '#1CEA15' }
    const btnstyle = { margin: '8px 0' }
    const initialValues = {
        email: '',
        passwd: '',
        recordar: false
    };

    const validationSchema = Yup.object().shape({
        email: Yup.string().email("Por favor ingrese un correo valido").required("Required"),
        passwd: Yup.string().required("Required")
    });

    const [errorMessage, setErrorMessage] = useState("");

    const onSubmit = (values, props) => {
        axios
          .post(searchUserLoginEndpoint, values)
          .then((response) => {
            if (response.status === 200) { 
              // Inicio de sesión exitoso, redirige al usuario a la página principal
              window.location.reload();
            } else {
                alert("fallido")
              // Inicio de sesión fallido, muestra un mensaje de error en la interfaz de usuario
              
              // Habilita el botón de inicio de sesión sin recargar la página
              props.setSubmitting(false);
            }
          })
          .catch((error) => {
            // Error en el servidor, muestra un mensaje de error en la interfaz de usuario
            setErrorMessage("Correo o contraseña incorrectos");
            // Habilita el botón de inicio de sesión sin recargar la página
            props.setSubmitting(false);
          });
      };


    return (
        <Grid>
            <Paper style={paperStyle}>
                <Grid align="center" >
                    <Avatar style={avatarStyle}><LockPersonIcon /></Avatar>
                    <h2>Iniciar Sesion</h2>
                </Grid>
                <Formik initialValues={initialValues} validationSchema={validationSchema} onSubmit={onSubmit}>
                    {(props) => (
                        <Form>
                            {errorMessage && <div style={{ color: 'red' }}>{errorMessage}</div>}
                            <Field as={TextField} label='Email' name="email" placeholder='Ingresar nombre de usuario' fullWidth required helperText={<ErrorMessage name="email" />} style={{ marginBottom: '10px' }} />
                            <Field as={TextField}  label='Contraseña' name ="passwd" placeholder='Ingresar contraseña' type='password' fullWidth required helperText={<ErrorMessage name="passwd" />}  />
                            <Field as={FormControlLabel} name="recordar" control={<Checkbox color='primary' />} label="Recordar" />

                            <Button type='submit' color='primary' variant="contained" disabled={props.isSubmitting} style={btnstyle} fullWidth >{props.isSubmitting ? "Cargando" : "Iniciar sesion"}</Button>
                        </Form>
                    )}
                </Formik>
                <Typography>
                    <Link href="#"
                    >¿Olvidaste tu contraseña?</Link>
                </Typography>
                <Typography> ¿No tienes una cuenta?
                    <Link href="#" onClick={() => handleChange("event", 1)}
                    >Registrate</Link>
                </Typography>

            </Paper>
        </Grid>
    )
}

export default Login;
