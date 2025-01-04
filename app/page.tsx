 "use client";
import { useEffect, useState } from 'react';
export default function Home() {
  interface ApiResponse {
    message: string;
  }
  const [data, setData] = useState<ApiResponse|null>(null);

  useEffect(() => {
    fetch('/api/hello')
      .then((response) => response.json())
      .then((data) => setData(data));
  }, []);
  if (!data) {
    return <div>Loading...</div>;
  }
  return (
    <div>
      <h1>API Response:{data.message}</h1>
      <pre>{JSON.stringify(data, null, 2)}</pre> {/* For debugging */}
    </div>
  );
}
