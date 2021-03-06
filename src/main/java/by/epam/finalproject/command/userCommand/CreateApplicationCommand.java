package by.epam.finalproject.command.userCommand;

import by.epam.finalproject.command.AbstractCommand;
import by.epam.finalproject.command.ActionCommand;
import by.epam.finalproject.entity.*;
import by.epam.finalproject.exception.ServiceException;
import by.epam.finalproject.resource.MessageManager;
import by.epam.finalproject.service.ApplicationService;
import by.epam.finalproject.service.FacultyService;
import by.epam.finalproject.service.MarkService;
import by.epam.finalproject.service.UserService;
import by.epam.finalproject.utils.ApplicationValidator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import static by.epam.finalproject.command.CommandConstant.*;

public class CreateApplicationCommand extends AbstractCommand implements ActionCommand {

    @Override
    public String execute(HttpServletRequest request) throws ServiceException {

        HttpSession currentSession = request.getSession();

        if (currentSession.getAttribute(APPLICATION_CREATED_ATTRIBUTE) != null ) {
            return MAIN_JSP;
        }

        String facultyId = request.getParameter(FACULTY_ID_PARAMETER);

        FacultyService facultyService = new FacultyService(proxyConnection.getConnection());
        Faculty faculty = facultyService.findFaculty(facultyId);

        List<Mark> marks = new ArrayList<>();
        for (int i = 0; i < faculty.getSubjects().size(); i++) {
            Subject subject = faculty.getSubjects().get(i);
            String subjectId = String.valueOf(subject.getId());
            String subjectMarkValue = request.getParameter(subjectId);
            Mark mark = new Mark(subject, Integer.parseInt(subjectMarkValue));
            marks.add(mark);
        }

        String certificate = request.getParameter(CERTIFICATE_PARAMETER);

        User user = (User) currentSession.getAttribute(USER_ATTRIBUTE);

        Student student = new Student(Integer.valueOf(certificate), marks);

        Application application = new Application(faculty, student);
        ApplicationValidator validator = new ApplicationValidator();
        boolean isValid = validator.validateByPassingPoints(application);
        if (!isValid) {
            request.setAttribute(NOT_PASSING_BALL_ATTRIBUTE, MessageManager.getProperty(NOT_PASSING_BALL_PROPERTY));
            return SHOW_ALL_FACULTIES_GENERAL_JSP;
        }

        UserService userService = new UserService(proxyConnection.getConnection());
        String userId = String.valueOf(user.getId());

        userService.isUpdateCertificate(certificate, userId);

        MarkService markService = new MarkService(proxyConnection.getConnection());
        for (int i = 0; i < marks.size(); i++) {
            markService.isUpdate(userId, String.valueOf(marks.get(i).getSubject().getId()),
                    String.valueOf(marks.get(i).getValue()));
        }

        ApplicationService applicationService = new ApplicationService(proxyConnection.getConnection());
        applicationService.createApplication(facultyId, userId);

        currentSession.setAttribute(APPLICATION_CREATED_ATTRIBUTE, true);

        ShowMyApplicationsCommand showMyApplicationsCommand = new ShowMyApplicationsCommand();
        return showMyApplicationsCommand.execute(request);
    }
}
