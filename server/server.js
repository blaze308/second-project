const express = require('express');
const bcrypt = require("bcrypt");
const cors = require('cors');
const { Pool } = require('pg');
require("dotenv").config();

const app = express();
const port = 5000;

const pool = new Pool({
  user: process.env.POSTGRES_USER,
  host: process.env.POSTGRES_HOST,
  database: process.env.POSTGRES_DATABASE,
  password: process.env.POSTGRES_PASSWORD,
  port: process.env.POSTGRES_PORT, 
});

app.use(cors());
app.use(express.json());

// app.use('*', (req, res, next) => {
//   console.log(req.originalUrl)
//   next()
// })

//fetch data
app.get('/data', (req, res) => {
  pool.query('SELECT * FROM public."Products" ORDER BY id DESC', (error, result) => {
    if (error) {
      console.log(error);
      res.status(500).send('Error retrieving data');
    } else {
      res.json(result.rows);
    }
  });
});

//add user
app.post("/api/signup",  async (req, res) => {
  //get 3 from req.body destructuring
    const {username, email, password} = req.body;

    try {
          const checkQuery = 'SELECT * FROM public."Users" WHERE email = $1 OR username = $2';
          const checkResult = await pool.query(checkQuery, [email, username]);
      
          if (checkResult.rows.length > 0) {
            res.status(200).json({message: "user exists"});
            return;
          }

        //salt generate
        const salt =  await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        const query = 'INSERT INTO public."Users"(username, email, password) VALUES ($1, $2, $3)';
        const values = [username, email, hashedPassword];
        
        await pool.query(query, values);
        res.status(201).json({message: "User created successfully"});
    }     
    catch (error) {
        console.error("Error executing query or hashing password", error);
        res.status(500).json({error: "Internal server error"}); 
    }
})

// //check if user exists
// app.get("/api/signup/check", async (req, res) => {
//   const  {email, username} = req.query;

//   try {
//     const query = 'SELECT * FROM public."Users" WHERE email = $1 OR username = $2';
//     const result = await pool.query(query, [email, username]);

//     if (result.rows.length > 0) {
//       res.status(200).json({exists: "true"});
//     }
//     // res.status(200).send("OK")
//     else {
//       res.status(200).json({exists: "false"});
//     }
//   } 
  
//   catch (error) {
//     console.error("Error executing query", error);
//     res.sendStatus(500);
//   }
// })


//login 
app.post("/api/login", async (req, res) => {
const {identifier, password} = req.body;

  try {
    const query = 'SELECT * FROM public."Users" WHERE username = $1 OR email = $1';
    // query values expects an array
    const result = await pool.query(query, [identifier]);

    if(result.rows.length === 0) {
      res.status(404).json({error: "User not found"});
      return;
    }

    // //assign first element in array []des
    // const [user] = result.rows;
    // const {password: hashedPassword} = user;
    const user = result.rows[0];
    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch){
      res.status(401).json({error: "Invalid credentials"});
      return;
    }

    res.status(200).json({message: "Login successful"});


  } catch (error) {
    console.error("Error executing query or comparing password", error);
    res.status(500).json({error: "Internal server error"});
  }
})


app.listen(port, () => {
  console.log(`Server is running on port ${port}🚀`);
});
