<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>智学云 - 在线视频学习平台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #1a237e 0%, #311b92 100%);
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        header {
            text-align: center;
            margin-bottom: 30px;
            width: 100%;
        }
        
        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            margin-bottom: 10px;
        }
        
        .logo i {
            font-size: 3.5rem;
            margin-right: 15px;
            color: #4fc3f7;
        }
        
        .logo h1 {
            font-size: 3rem;
            font-weight: 700;
            background: linear-gradient(to right, #4fc3f7, #29b6f6);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .tagline {
            color: #bbdefb;
            font-size: 1.2rem;
            margin-top: 10px;
            letter-spacing: 1px;
        }
        
        .app-container {
            display: flex;
            width: 100%;
            background-color: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            min-height: 600px;
        }
        
        .welcome-section {
            flex: 1;
            background: linear-gradient(to bottom right, #0d47a1, #311b92);
            color: white;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .welcome-section h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            line-height: 1.2;
        }
        
        .welcome-section p {
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        
        .form-section {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .form-container {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }
        
        .tabs {
            display: flex;
            margin-bottom: 30px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .tab {
            padding: 15px 25px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            color: #777;
            transition: all 0.3s;
            text-align: center;
            flex: 1;
        }
        
        .tab.active {
            color: #1a237e;
            border-bottom: 3px solid #1a237e;
        }
        
        .form {
            display: none;
        }
        
        .form.active {
            display: block;
            animation: fadeIn 0.5s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .form-title {
            font-size: 1.8rem;
            margin-bottom: 25px;
            color: #1a237e;
        }
        
        .input-group {
            margin-bottom: 20px;
            position: relative;
        }
        
        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #444;
        }
        
        .input-group input, .input-group select {
            width: 100%;
            padding: 15px;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s;
        }
        
        .input-group input:focus, .input-group select:focus {
            border-color: #1a237e;
            outline: none;
            box-shadow: 0 0 0 3px rgba(26, 35, 126, 0.1);
        }
        
        .role-selection {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .role-option {
            flex: 1;
            text-align: center;
            padding: 15px 10px;
            border: 2px solid #ddd;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .role-option:hover {
            background-color: #f5f5f5;
        }
        
        .role-option.selected {
            border-color: #1a237e;
            background-color: rgba(26, 35, 126, 0.05);
        }
        
        .role-option i {
            font-size: 1.8rem;
            margin-bottom: 10px;
            display: block;
            color: #555;
        }
        
        .role-option.selected i {
            color: #1a237e;
        }
        
        .btn {
            display: block;
            width: 100%;
            padding: 16px;
            background: linear-gradient(to right, #1a237e, #311b92);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 15px rgba(26, 35, 126, 0.2);
        }
        
        .btn-secondary {
            background: #f5f5f5;
            color: #333;
            margin-top: 15px;
        }
        
        .btn-secondary:hover {
            background: #e0e0e0;
            box-shadow: 0 7px 15px rgba(0, 0, 0, 0.1);
        }
        
        .forgot-password {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .forgot-password a {
            color: #1a237e;
            text-decoration: none;
            font-weight: 600;
        }
        
        .forgot-password a:hover {
            text-decoration: underline;
        }
        
        .message {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            display: none;
        }
        
        .message.success {
            background-color: rgba(76, 175, 80, 0.1);
            color: #2e7d32;
            border: 1px solid #4caf50;
            display: block;
        }
        
        .message.error {
            background-color: rgba(244, 67, 54, 0.1);
            color: #c62828;
            border: 1px solid #f44336;
            display: block;
        }
        
        .admin-panel {
            display: none;
            margin-top: 30px;
            padding: 20px;
            border: 2px dashed #1a237e;
            border-radius: 10px;
            background-color: rgba(26, 35, 126, 0.03);
        }
        
        .admin-panel.active {
            display: block;
        }
        
        .user-list {
            max-height: 200px;
            overflow-y: auto;
            margin-top: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
        }
        
        .user-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }
        
        .user-item:hover {
            background-color: #f9f9f9;
        }
        
        .user-item.selected {
            background-color: #e3f2fd;
            border-left: 4px solid #1a237e;
        }
        
        .user-item:last-child {
            border-bottom: none;
        }
        
        .user-info {
            flex: 1;
        }
        
        .user-role {
            font-size: 0.9rem;
            color: #666;
            margin-top: 3px;
        }
        
        footer {
            margin-top: 30px;
            color: #bbdefb;
            text-align: center;
            font-size: 0.9rem;
            width: 100%;
        }
        
        /* 响应式设计 */
        @media (max-width: 900px) {
            .app-container {
                flex-direction: column;
            }
            
            .welcome-section {
                padding: 30px;
            }
            
            .form-section {
                padding: 30px;
            }
            
            .logo h1 {
                font-size: 2.5rem;
            }
        }
        
        @media (max-width: 500px) {
            .role-selection {
                flex-direction: column;
            }
            
            .logo h1 {
                font-size: 2rem;
            }
            
            .logo i {
                font-size: 2.5rem;
            }
            
            .welcome-section h2 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo">
                <i class="fas fa-cloud-upload-alt"></i>
                <h1>智学云</h1>
            </div>
            <p class="tagline">连接知识，启迪未来 - 您的专属在线学习平台</p>
        </header>
        
        <div class="app-container">
            <div class="welcome-section">
                <h2>欢迎来到智学云</h2>
                <p>智学云是一个集学习、创作、管理于一体的综合性在线视频学习平台。无论您是渴望知识的学习者，还是希望分享智慧的创作者，或是管理平台的系统管理员，这里都能满足您的需求。</p>
                <p>平台提供丰富的学习资源、个性化学习路径和强大的创作工具，帮助您实现知识传递与获取的最佳体验。</p>
            </div>
            
            <div class="form-section">
                <div class="form-container">
                    <%
                        // 数据库连接和业务逻辑处理
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        
                        // 初始化消息变量
                        String message = "";
                        String messageType = "";
                        String currentTab = "login";
                        Map<String, String> userInfo = new HashMap<>();
                        
                        // 加载数据库配置
                        Properties props = new Properties();
                        try {
                            props.load(getClass().getClassLoader().getResourceAsStream("dbconfig.properties"));
                        } catch (Exception e) {
                            // 如果无法从文件加载，使用硬编码配置
                            props.setProperty("db.driver", "org.postgresql.Driver");
                            props.setProperty("db.url", "jdbc:postgresql://localhost:5432/zhixueyun");
                            props.setProperty("db.username", "postgres");
                            props.setProperty("db.password", "800411");
                        }
                        
                        try {
                            // 加载数据库驱动
                            Class.forName(props.getProperty("db.driver"));
                            
                            // 建立数据库连接
                            conn = DriverManager.getConnection(
                                props.getProperty("db.url"),
                                props.getProperty("db.username"),
                                props.getProperty("db.password")
                            );
                            
                            // 处理表单提交
                            String action = request.getParameter("action");
                            if (action != null) {
                                if ("login".equals(action)) {
                                    // 登录处理
                                    String username = request.getParameter("username");
                                    String password = request.getParameter("password");
                                    
                                    // 查询用户
                                    String sql = "SELECT id, username, email, phone, role FROM users WHERE username = ? AND password = ?";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, username);
                                    pstmt.setString(2, sha256(password)); // 使用SHA-256加密
                                    rs = pstmt.executeQuery();
                                    
                                    if (rs.next()) {
                                        // 登录成功，保存用户信息到session
                                        session.setAttribute("userId", rs.getString("id"));
                                        session.setAttribute("username", rs.getString("username"));
                                        session.setAttribute("role", rs.getString("role"));
                                        session.setAttribute("email", rs.getString("email"));
                                        session.setAttribute("phone", rs.getString("phone"));
                                        
                                        // 重定向到主界面
                                        response.sendRedirect("main.jsp");
                                        return;
                                    } else {
                                        message = "用户名或密码错误！";
                                        messageType = "error";
                                    }
                                    
                                } else if ("register".equals(action)) {
                                    // 注册处理
                                    String username = request.getParameter("username");
                                    String password = request.getParameter("password");
                                    String confirmPassword = request.getParameter("confirmPassword");
                                    String role = request.getParameter("role");
                                    
                                    // 验证输入
                                    if (!isValidUsername(username)) {
                                        message = "请输入有效的手机号或邮箱地址！";
                                        messageType = "error";
                                    } else if (password.length() < 6) {
                                        message = "密码长度至少为6位！";
                                        messageType = "error";
                                    } else if (!password.equals(confirmPassword)) {
                                        message = "两次输入的密码不一致！";
                                        messageType = "error";
                                    } else {
                                        // 检查用户是否已存在
                                        String checkSql = "SELECT id FROM users WHERE username = ?";
                                        pstmt = conn.prepareStatement(checkSql);
                                        pstmt.setString(1, username);
                                        rs = pstmt.executeQuery();
                                        
                                        if (rs.next()) {
                                            message = "该用户名已存在，请使用其他用户名！";
                                            messageType = "error";
                                        } else {
                                            // 插入新用户
                                            String insertSql = "INSERT INTO users (username, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";
                                            pstmt = conn.prepareStatement(insertSql);
                                            pstmt.setString(1, username);
                                            
                                            // 判断是邮箱还是手机号
                                            if (username.contains("@")) {
                                                pstmt.setString(2, username);
                                                pstmt.setString(3, null);
                                            } else {
                                                pstmt.setString(2, null);
                                                pstmt.setString(3, username);
                                            }
                                            
                                            pstmt.setString(4, sha256(password));
                                            pstmt.setString(5, role);
                                            
                                            int rows = pstmt.executeUpdate();
                                            if (rows > 0) {
                                                message = "注册成功！欢迎成为" + getRoleName(role);
                                                messageType = "success";
                                                currentTab = "login";
                                            } else {
                                                message = "注册失败，请重试！";
                                                messageType = "error";
                                            }
                                        }
                                    }
                                    
                                } else if ("reset-password".equals(action)) {
                                    // 重置密码处理
                                    String username = request.getParameter("username");
                                    String newPassword = request.getParameter("newPassword");
                                    String confirmNewPassword = request.getParameter("confirmNewPassword");
                                    
                                    if (newPassword.length() < 6) {
                                        message = "密码长度至少为6位！";
                                        messageType = "error";
                                    } else if (!newPassword.equals(confirmNewPassword)) {
                                        message = "两次输入的密码不一致！";
                                        messageType = "error";
                                    } else {
                                        // 更新密码
                                        String updateSql = "UPDATE users SET password = ? WHERE username = ?";
                                        pstmt = conn.prepareStatement(updateSql);
                                        pstmt.setString(1, sha256(newPassword));
                                        pstmt.setString(2, username);
                                        
                                        int rows = pstmt.executeUpdate();
                                        if (rows > 0) {
                                            message = "密码重置成功！请使用新密码登录。";
                                            messageType = "success";
                                            currentTab = "login";
                                        } else {
                                            message = "未找到该用户，请检查输入！";
                                            messageType = "error";
                                        }
                                    }
                                    
                                } else if ("admin-reset".equals(action)) {
                                    // 管理员强制重置密码
                                    String userId = request.getParameter("userId");
                                    String adminNewPassword = request.getParameter("adminNewPassword");
                                    
                                    if (adminNewPassword.length() < 6) {
                                        message = "密码长度至少为6位！";
                                        messageType = "error";
                                    } else {
                                        // 更新密码
                                        String updateSql = "UPDATE users SET password = ? WHERE id = ?";
                                        pstmt = conn.prepareStatement(updateSql);
                                        pstmt.setString(1, sha256(adminNewPassword));
                                        pstmt.setInt(2, Integer.parseInt(userId));
                                        
                                        int rows = pstmt.executeUpdate();
                                        if (rows > 0) {
                                            message = "密码强制重置成功！";
                                            messageType = "success";
                                        } else {
                                            message = "重置密码失败！";
                                            messageType = "error";
                                        }
                                    }
                                }
                            }
                            
                        } catch (Exception e) {
                            e.printStackTrace();
                            message = "数据库连接错误: " + e.getMessage();
                            messageType = "error";
                        } finally {
                            // 关闭资源
                            try { if (rs != null) rs.close(); } catch (SQLException e) {}
                            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
                            try { if (conn != null) conn.close(); } catch (SQLException e) {}
                        }
                    %>
                    
                    <div class="tabs">
                        <div class="tab <%= "login".equals(currentTab) ? "active" : "" %>" data-tab="login">登录</div>
                        <div class="tab <%= "register".equals(currentTab) ? "active" : "" %>" data-tab="register">注册</div>
                    </div>
                    
                    <% if (!message.isEmpty()) { %>
                        <div class="message <%= "success".equals(messageType) ? "success" : "error" %>">
                            <%= message %>
                        </div>
                    <% } %>
                    
                    <!-- 登录表单 -->
                    <form id="login-form" class="form <%= "login".equals(currentTab) ? "active" : "" %>" method="post">
                        <h2 class="form-title">用户登录</h2>
                        <input type="hidden" name="action" value="login">
                        
                        <div class="input-group">
                            <label for="login-username">手机号 / 邮箱</label>
                            <input type="text" id="login-username" name="username" placeholder="请输入手机号或邮箱" required>
                        </div>
                        
                        <div class="input-group">
                            <label for="login-password">密码</label>
                            <input type="password" id="login-password" name="password" placeholder="请输入密码" required>
                        </div>
                        
                        <button type="submit" class="btn">登录</button>
                        
                        <div class="forgot-password">
                            <a href="#" id="forgot-password-link">忘记密码？</a>
                        </div>
                    </form>
                    
                    <!-- 注册表单 -->
                    <form id="register-form" class="form <%= "register".equals(currentTab) ? "active" : "" %>" method="post">
                        <h2 class="form-title">新用户注册</h2>
                        <input type="hidden" name="action" value="register">
                        
                        <div class="input-group">
                            <label for="register-username">手机号 / 邮箱</label>
                            <input type="text" id="register-username" name="username" placeholder="请输入手机号或邮箱" required>
                        </div>
                        
                        <div class="input-group">
                            <label for="register-password">密码</label>
                            <input type="password" id="register-password" name="password" placeholder="请输入密码（至少6位）" required>
                        </div>
                        
                        <div class="input-group">
                            <label for="confirm-password">确认密码</label>
                            <input type="password" id="confirm-password" name="confirmPassword" placeholder="请再次输入密码" required>
                        </div>
                        
                        <div class="input-group">
                            <label>选择您的角色</label>
                            <div class="role-selection">
                                <div class="role-option" data-role="learner">
                                    <i class="fas fa-user-graduate"></i>
                                    <div>学习者</div>
                                </div>
                                <div class="role-option" data-role="creator">
                                    <i class="fas fa-chalkboard-teacher"></i>
                                    <div>创作者</div>
                                </div>
                                <div class="role-option" data-role="admin">
                                    <i class="fas fa-user-shield"></i>
                                    <div>管理员</div>
                                </div>
                            </div>
                            <input type="hidden" id="selected-role" name="role" value="learner">
                        </div>
                        
                        <button type="submit" class="btn">注册</button>
                        <button type="button" class="btn btn-secondary" id="back-to-login">返回登录</button>
                    </form>
                    
                    <!-- 重置密码表单 -->
                    <form id="reset-form" class="form" method="post">
                        <h2 class="form-title">重置密码</h2>
                        <input type="hidden" name="action" value="reset-password">
                        
                        <div class="input-group">
                            <label for="reset-username">手机号 / 邮箱</label>
                            <input type="text" id="reset-username" name="username" placeholder="请输入注册的手机号或邮箱" required>
                        </div>
                        
                        <div class="input-group">
                            <label for="new-password">新密码</label>
                            <input type="password" id="new-password" name="newPassword" placeholder="请输入新密码（至少6位）" required>
                        </div>
                        
                        <div class="input-group">
                            <label for="confirm-new-password">确认新密码</label>
                            <input type="password" id="confirm-new-password" name="confirmNewPassword" placeholder="请再次输入新密码" required>
                        </div>
                        
                        <button type="submit" class="btn">重置密码</button>
                        <button type="button" class="btn btn-secondary" id="back-to-login2">返回登录</button>
                    </form>
                    
                    <!-- 管理员面板 -->
                    <%
                        if (userInfo != null && "admin".equals(userInfo.get("role"))) {
                            try {
                                // 重新连接数据库获取用户列表
                                conn = DriverManager.getConnection(
                                    props.getProperty("db.url"),
                                    props.getProperty("db.username"),
                                    props.getProperty("db.password")
                                );
                                
                                String userSql = "SELECT id, username, email, phone, role FROM users ORDER BY id";
                                pstmt = conn.prepareStatement(userSql);
                                rs = pstmt.executeQuery();
                    %>
                    <div class="admin-panel active" id="admin-panel">
                        <h3>管理员功能：强制重置用户密码</h3>
                        <p>选择要重置密码的用户：</p>
                        <div class="user-list" id="user-list">
                            <% while (rs.next()) { %>
                                <div class="user-item" data-user-id="<%= rs.getInt("id") %>">
                                    <div class="user-info">
                                        <strong><%= rs.getString("username") %></strong>
                                        <div class="user-role"><%= getRoleName(rs.getString("role")) %></div>
                                    </div>
                                    <div><%= rs.getString("email") != null ? rs.getString("email") : rs.getString("phone") %></div>
                                </div>
                            <% } %>
                        </div>
                        <form method="post">
                            <input type="hidden" name="action" value="admin-reset">
                            <input type="hidden" id="selected-user-id" name="userId" value="">
                            <div class="input-group">
                                <label for="admin-new-password">新密码</label>
                                <input type="password" id="admin-new-password" name="adminNewPassword" placeholder="请输入要设置的新密码">
                            </div>
                            <button type="submit" class="btn" id="admin-reset-btn">强制重置密码</button>
                        </form>
                    </div>
                    <%
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try { if (rs != null) rs.close(); } catch (SQLException e) {}
                                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
                                try { if (conn != null) conn.close(); } catch (SQLException e) {}
                            }
                        }
                    %>
                </div>
            </div>
        </div>
        
        <footer>
            <p>© 2023 智学云 版权所有 | 致力于提供最优质的在线学习体验</p>
        </footer>
    </div>

    <script>
        // DOM 元素
        const tabs = document.querySelectorAll('.tab');
        const forms = document.querySelectorAll('.form');
        const loginForm = document.getElementById('login-form');
        const registerForm = document.getElementById('register-form');
        const resetForm = document.getElementById('reset-form');
        const messageDiv = document.querySelector('.message');
        const roleOptions = document.querySelectorAll('.role-option');
        const selectedRoleInput = document.getElementById('selected-role');
        const forgotPasswordLink = document.getElementById('forgot-password-link');
        const backToLoginBtns = document.querySelectorAll('#back-to-login, #back-to-login2');
        const userItems = document.querySelectorAll('.user-item');
        const selectedUserIdInput = document.getElementById('selected-user-id');
        
        // 标签切换
        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                const tabId = tab.getAttribute('data-tab');
                
                // 更新标签
                tabs.forEach(t => t.classList.remove('active'));
                tab.classList.add('active');
                
                // 更新表单显示
                forms.forEach(form => form.classList.remove('active'));
                if (tabId === 'login') {
                    loginForm.classList.add('active');
                } else if (tabId === 'register') {
                    registerForm.classList.add('active');
                }
                
                // 清空消息
                if (messageDiv) {
                    messageDiv.style.display = 'none';
                }
            });
        });
        
        // 角色选择
        if (roleOptions.length > 0) {
            roleOptions.forEach(option => {
                option.addEventListener('click', () => {
                    roleOptions.forEach(opt => opt.classList.remove('selected'));
                    option.classList.add('selected');
                    selectedRoleInput.value = option.getAttribute('data-role');
                });
            });
        }
        
        // 忘记密码链接
        if (forgotPasswordLink) {
            forgotPasswordLink.addEventListener('click', (e) => {
                e.preventDefault();
                // 隐藏所有表单
                forms.forEach(form => form.classList.remove('active'));
                // 显示重置密码表单
                resetForm.classList.add('active');
                // 取消标签选中状态
                tabs.forEach(tab => tab.classList.remove('active'));
            });
        }
        
        // 返回登录按钮
        if (backToLoginBtns.length > 0) {
            backToLoginBtns.forEach(btn => {
                btn.addEventListener('click', () => {
                    // 切换到登录标签
                    tabs.forEach(tab => tab.classList.remove('active'));
                    tabs[0].classList.add('active');
                    
                    forms.forEach(form => form.classList.remove('active'));
                    loginForm.classList.add('active');
                });
            });
        }
        
        // 用户选择（管理员面板）
        if (userItems.length > 0) {
            userItems.forEach(item => {
                item.addEventListener('click', () => {
                    // 切换选中状态
                    userItems.forEach(i => i.classList.remove('selected'));
                    item.classList.add('selected');
                    
                    // 设置选中的用户ID
                    if (selectedUserIdInput) {
                        selectedUserIdInput.value = item.getAttribute('data-user-id');
                    }
                });
            });
        }
        
        // 表单验证
        const registerFormElement = document.getElementById('register-form');
        if (registerFormElement) {
            registerFormElement.addEventListener('submit', (e) => {
                const password = document.getElementById('register-password').value;
                const confirmPassword = document.getElementById('confirm-password').value;
                
                if (password.length < 6) {
                    e.preventDefault();
                    alert('密码长度至少为6位！');
                    return false;
                }
                
                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('两次输入的密码不一致！');
                    return false;
                }
                
                return true;
            });
        }
        
        const resetFormElement = document.getElementById('reset-form');
        if (resetFormElement) {
            resetFormElement.addEventListener('submit', (e) => {
                const newPassword = document.getElementById('new-password').value;
                const confirmNewPassword = document.getElementById('confirm-new-password').value;
                
                if (newPassword.length < 6) {
                    e.preventDefault();
                    alert('密码长度至少为6位！');
                    return false;
                }
                
                if (newPassword !== confirmNewPassword) {
                    e.preventDefault();
                    alert('两次输入的密码不一致！');
                    return false;
                }
                
                return true;
            });
        }
    </script>
</body>
</html>

<%!
    // SHA-256加密方法
    public static String sha256(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    // 验证用户名格式
    public static boolean isValidUsername(String username) {
        // 手机号验证（11位数字，以1开头）
        String phoneRegex = "^1[3-9]\\d{9}$";
        // 邮箱验证
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        
        return username.matches(phoneRegex) || username.matches(emailRegex);
    }
    
    // 获取角色名称
    public static String getRoleName(String role) {
        switch(role) {
            case "learner": return "学习者";
            case "creator": return "创作者";
            case "admin": return "管理员";
            default: return "用户";
        }
    }
%>