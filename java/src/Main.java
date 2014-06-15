import java.io.*;
import java.util.*;

public class Main {


	public static void main(String[] args) {

		if (args.length == 0) {
			System.out.println("missing <filename>");
			return;
		}

		JarScanner scanner = new JarScanner();
		File file = new File(args[0]);

		try {

			Map<String, List<Class<?>>> classes = scanner.loadAndScan(file);

			List<String> names = Arrays.asList("interfaces", "classes", "annotations", "enums");

			for (String s : names) {
				List<Class<?>> list = classes.get(s);

				if (list.size() == 0) continue;

				System.out.println(s + "(" + list.size() + ")");
				for (Class<?> c : list) {
					System.out.println("  " + c.toString());
				}
			}
		}
		catch (Exception e) {
			System.out.println(e);
		}

	}

	

}