import androidLogo from "/android.svg";
import "./App.css";
import { Button, Card } from "react-bootstrap";

function App() {
  return (
    <>
      <div></div>
      <h1>Minimal POC deployment</h1>
      <Card className="mb-3" style={{ color: "#000" }}>
        <Card.Img
          class="card-img-top"
          src={androidLogo}
          style={{ width: "10%" }}
        />
        <Card.Body>
          <Card.Title>React Bootstrap</Card.Title>
          <Card.Text>
            This is a minimal POC deployment of a React App with React Bootstrap
            and Typescript.
          </Card.Text>
        </Card.Body>
        <Button variant="primary">Go somewhere</Button>
      </Card>
    </>
  );
}

export default App;
