// Path: frontend/src/services/messageService.ts
import config from "../config.json";
// import { getAuthToken } from "./cognitoService"; // Adjust the import based on your actual cognito service

export interface MessageData {
  sessionId: string;
  timeStamp: string;
  language: string;
  userName: string;
  message: string;
}

const sendMessage = async (messageData: MessageData): Promise<void> => {
  const apiEndpoint = config.API_URL + config.MethodPath;
  // const authToken = await getAuthToken();

  try {
    const response = await fetch(apiEndpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        // Authorization: `Bearer ${authToken}`,
        // Include other headers as required
      },
      body: JSON.stringify(messageData),
    });

    if (!response.ok) {
      throw new Error("Failed to send message");
    }
    console.log("Message sent successfully");
  } catch (error) {
    console.error("Error sending message:", error);
  }
};

export default sendMessage;
