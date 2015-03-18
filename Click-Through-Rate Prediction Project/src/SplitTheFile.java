import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;


public class SplitTheFile {
	public int NumOfLines;
	
	public void start(){
		
		Scanner scan = new Scanner(System.in);
		System.out.println("How much size (in MB) should each file be of?");
		NumOfLines=scan.nextInt();
		
		String csvFile = "C:\\Users\\Kedar\\Documents\\USC\\MachineLearning\\Project\\test_data.csv";
		
		BufferedReader br = null;
		FileWriter fw = null;
		BufferedWriter bw = null;
		
		String line = "", Headline="";
		String cvsSplitBy = ",";
		try {
			br = new BufferedReader(new FileReader(csvFile));
			boolean flag=true; 
			for(int i=1; flag; i++){
				int count=0;
				String OutFile = "C:\\Users\\Kedar\\Documents\\USC\\MachineLearning\\Project\\newSplitTest200\\test_data_out";
				OutFile += ""+i+".csv";
				fw = new FileWriter(OutFile);
				bw = new BufferedWriter(fw);
				if(i==1){
					Headline= br.readLine();
				}
				while (count<=NumOfLines) {
					if(count==0){
						bw.write(Headline);
						bw.newLine();						
					}else{
						if((line = br.readLine())!=null){
							bw.write(line);
							bw.newLine();
						}
						else{
							flag=false;
							break;
						}
					}
					count++;
				}
				bw.flush();
				bw.close();
				fw.close();
			}
	 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		System.out.println("Done!");
	} 

}
