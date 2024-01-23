Return-Path: <stable+bounces-15503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC82838D98
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2411C21ADE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BD5D753;
	Tue, 23 Jan 2024 11:39:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3675D73B
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009997; cv=none; b=f5RAD3CibDWMhEclnTjV8bMgqPW9DQOu7HHp0hHzcTQBTtfflFnexziykWHXzt2Uu4kexXBl5PTeYWE1NSDywJxyFxZeP06kCsmokZP0PmtOLJmn3VDyH5RXU20qj2zDGDRiQXLRgieLmzW2EPGRSBGfDDPDPiqPxikNqIk2TtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009997; c=relaxed/simple;
	bh=tK6v9aORzX4ixcv0LSWjDn1VygpILM01+OlKHVyuh/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAM/N49DiKSD5ytvP9AVJageWkJJLPbemKOQfGXBYN5nxWv50dvspeCEudMkWJ3/XBRvLvHhGbVGV9tSzMeGrWZ4c2/IpzN9KYRIU4T/x3k+LQibzgxWNlhy000dcfxl3QvklDlhvsx0vunVEbo7oU2FAem7zCgBeFxXceGMmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-361ae51a4c6so13953345ab.1
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009995; x=1706614795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20gUQOJAZW0kG7Ci1YYJ0HN2QiW6jLcyMlXsRmSf2b8=;
        b=f3yPLhu5bdg5ZzudRbT/AB/echfwyF5fLfDQO17erKDJESKi+51WQaiNqt02c3bwqZ
         neq1QaaUq6Sjro2Kg979Rz9sELahJDeKp0N3HVBDDXOXHakp6wOoV89+kLkMUIZh0a/+
         VZ2//3IwZxhdqOCT4JtvDsZrt2iq30ZPxomro5tJ7eoJ8j6srbRVPc7zBbhs+JZ1MMNQ
         rOrvHeJqLOsqPTuWYhK1SdgTP08x8GBB8D5hyB8n/+t84HY1y2mGOMoAgLvR8umcMfGF
         nh2yGAjlHxJEeWEyKGIaRirRc9MXfyPr+7GVi9f0NPggUp/2Xi07AePSX0StDtbbTt7j
         guGg==
X-Gm-Message-State: AOJu0YxbBaPC/aIb8JOLl04HZN5MazR09AT9NbcwC53uuJKj43BgI91v
	rRE9m5lpQRKz99HNyc4/JIe7B8JpmhQyLGFj65M6xC+4UTOs7Ikh
X-Google-Smtp-Source: AGHT+IHwRJiySrqb5W5IVZ42Pv5fM4xiflVtOSHd3c/EWfzuES9hFp0p5nTU15kWdGq86sK8ctRJgg==
X-Received: by 2002:a05:6e02:788:b0:360:906:2198 with SMTP id q8-20020a056e02078800b0036009062198mr3777375ils.49.1706009995000;
        Tue, 23 Jan 2024 03:39:55 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b005ce033f3b54sm10139779pgg.27.2024.01.23.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:39:54 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 5/5] ksmbd: Add missing set_freezable() for freezable kthread
Date: Tue, 23 Jan 2024 20:38:54 +0900
Message-Id: <20240123113854.194887-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123113854.194887-1-linkinjeon@kernel.org>
References: <20240123113854.194887-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 8fb7b723924cc9306bc161f45496497aec733904 ]

The kernel thread function ksmbd_conn_handler_loop() invokes
the try_to_freeze() in its loop. But all the kernel threads are
non-freezable by default. So if we want to make a kernel thread to be
freezable, we have to invoke set_freezable() explicitly.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/connection.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 7977827c6541..09e1e7771592 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -284,6 +284,7 @@ int ksmbd_conn_handler_loop(void *p)
 		goto out;
 
 	conn->last_active = jiffies;
+	set_freezable();
 	while (ksmbd_conn_alive(conn)) {
 		if (try_to_freeze())
 			continue;
-- 
2.25.1


