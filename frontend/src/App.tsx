import { useState } from "react"; // Import useState
import androidLogo from "/android.svg";
import "./App.css";
import {
  MDBCard,
  MDBCardBody,
  MDBCardTitle,
  MDBCardText,
  MDBCardImage,
  MDBBtn,
  MDBInput,
} from "mdb-react-ui-kit";

import sendMessage, { MessageData } from "./services/messageService";

export default function App() {
  const [message, setMessage] = useState(""); // Add state for the message

  const handleSendMessage = () => {
    const messageData: MessageData = {
      sessionId: "123",
      message: message,
      timeStamp: new Date().toISOString(),
      language: "en",
      userName: "John Doe",
    };
    sendMessage(messageData); // Use the state variable here
  };

  return (
    <>
      <MDBCard>
        <MDBCardImage
          src={androidLogo}
          style={{ width: "10%", aspectRatio: 1 }}
          position="top"
          alt="..."
        />
        <MDBCardBody>
          <MDBCardTitle>Content</MDBCardTitle>
          <MDBCardText>
            POC for deploying a React app an AWS S3 with Terraform.
          </MDBCardText>
        </MDBCardBody>
      </MDBCard>
      <MDBCard>
        <MDBInput
          label="Message"
          id="typeText"
          type="text"
          aria-describedby="textDescription"
          value={message} // Bind the input value to the state
          onChange={(e) => setMessage(e.target.value)} // Update the state on input change
        />
        <div id="textDescription" className="form-text">
          This text will be sent to the backend.
        </div>
        <MDBBtn onClick={handleSendMessage}>Send</MDBBtn>
      </MDBCard>
    </>
  );
}
