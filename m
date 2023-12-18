Return-Path: <stable+bounces-7674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 481F38175B7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A047CB246AD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31793D574;
	Mon, 18 Dec 2023 15:37:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAD4FF81
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b82dc11e6so478220a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913867; x=1703518667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1tU10hOz5EN8/7Ku56scOTQlGkK60X3mpOMYOeqw+c=;
        b=fmCq5buinThextqcz3p+ItvhX6p92E7YwGy18BJ+DZTIz4W8i99GiVgyEgeKQigZ+F
         hG3/EJ4PNXi1hwRqacjTcvJ+5+1uLEksLHSLyr5345wNQvHV8uxdH6AePGm/MhWLfgfQ
         JGlnmA+sH6feXxYhWKGxL2+DLZBY57y4mvWNJVsS6Py7LjJ2jXhFfrNF9d9/nrNAAQ7p
         SkM2try1VjwRKRwBhPnKB/7oZ08CWMyQU9ifB27x3x/5bHVXfzZ/Grb/I9UsMT0l2BHu
         qSpcOH3BwZXsFfcUFsFmcT5nYzTzRWkw9FSR8vId/RSqf3DMmZ/f0ep4fGJliXC/Giya
         x0Gw==
X-Gm-Message-State: AOJu0Yz7+AfyEeQZI3+Fy5Vi3tOgfVL468suSemRt4iaa9oyzHuWri7I
	ciAHeU6bvOKUhtNThzkaUJb9F3UWfvs=
X-Google-Smtp-Source: AGHT+IEYWpSvbqR/dVa21y2g4b3FVVALMCzDID8zGmCw0nsyKPQoUDYa8kldkhTB3fBElMPBZZfvsw==
X-Received: by 2002:a17:90a:4897:b0:286:c166:4db0 with SMTP id b23-20020a17090a489700b00286c1664db0mr7038059pjh.46.1702913867243;
        Mon, 18 Dec 2023 07:37:47 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:46 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 045/154] ksmbd: use wait_event instead of schedule_timeout()
Date: Tue, 19 Dec 2023 00:33:05 +0900
Message-Id: <20231218153454.8090-46-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit a14c573870a664386adc10526a6c2648ea56dae1 ]

ksmbd threads eating masses of cputime when connection is disconnected.
If connection is disconnected, ksmbd thread waits for pending requests
to be processed using schedule_timeout. schedule_timeout() incorrectly
is used, and it is more efficient to use wait_event/wake_up than to check
r_count every time with timeout.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c |  6 +++---
 fs/ksmbd/connection.h |  1 +
 fs/ksmbd/oplock.c     | 35 ++++++++++++++++++++++-------------
 fs/ksmbd/server.c     |  8 +++++++-
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 192646b8920e..be1f8ffa4a78 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -66,6 +66,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 	conn->outstanding_credits = 0;
 
 	init_waitqueue_head(&conn->req_running_q);
+	init_waitqueue_head(&conn->r_count_q);
 	INIT_LIST_HEAD(&conn->conns_list);
 	INIT_LIST_HEAD(&conn->requests);
 	INIT_LIST_HEAD(&conn->async_requests);
@@ -165,7 +166,6 @@ int ksmbd_conn_write(struct ksmbd_work *work)
 	struct kvec iov[3];
 	int iov_idx = 0;
 
-	ksmbd_conn_try_dequeue_request(work);
 	if (!work->response_buf) {
 		pr_err("NULL response header\n");
 		return -EINVAL;
@@ -358,8 +358,8 @@ int ksmbd_conn_handler_loop(void *p)
 
 out:
 	/* Wait till all reference dropped to the Server object*/
-	while (atomic_read(&conn->r_count) > 0)
-		schedule_timeout(HZ);
+	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
+
 
 	unload_nls(conn->local_nls);
 	if (default_conn_ops.terminate_fn)
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index e0a25cddbb29..a8c367c481e8 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -58,6 +58,7 @@ struct ksmbd_conn {
 	unsigned int			outstanding_credits;
 	spinlock_t			credits_lock;
 	wait_queue_head_t		req_running_q;
+	wait_queue_head_t		r_count_q;
 	/* Lock to protect requests list*/
 	spinlock_t			request_lock;
 	struct list_head		requests;
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index ae5fc4b2c133..b527f451d7a4 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -616,18 +616,13 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	struct ksmbd_file *fp;
 
 	fp = ksmbd_lookup_durable_fd(br_info->fid);
-	if (!fp) {
-		atomic_dec(&conn->r_count);
-		ksmbd_free_work_struct(work);
-		return;
-	}
+	if (!fp)
+		goto out;
 
 	if (allocate_oplock_break_buf(work)) {
 		pr_err("smb2_allocate_rsp_buf failed! ");
-		atomic_dec(&conn->r_count);
 		ksmbd_fd_put(work, fp);
-		ksmbd_free_work_struct(work);
-		return;
+		goto out;
 	}
 
 	rsp_hdr = smb2_get_msg(work->response_buf);
@@ -668,8 +663,16 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 
 	ksmbd_fd_put(work, fp);
 	ksmbd_conn_write(work);
+
+out:
 	ksmbd_free_work_struct(work);
-	atomic_dec(&conn->r_count);
+	/*
+	 * Checking waitqueue to dropping pending requests on
+	 * disconnection. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
+		wake_up(&conn->r_count_q);
 }
 
 /**
@@ -732,9 +735,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 
 	if (allocate_oplock_break_buf(work)) {
 		ksmbd_debug(OPLOCK, "smb2_allocate_rsp_buf failed! ");
-		ksmbd_free_work_struct(work);
-		atomic_dec(&conn->r_count);
-		return;
+		goto out;
 	}
 
 	rsp_hdr = smb2_get_msg(work->response_buf);
@@ -772,8 +773,16 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	inc_rfc1001_len(work->response_buf, 44);
 
 	ksmbd_conn_write(work);
+
+out:
 	ksmbd_free_work_struct(work);
-	atomic_dec(&conn->r_count);
+	/*
+	 * Checking waitqueue to dropping pending requests on
+	 * disconnection. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
+		wake_up(&conn->r_count_q);
 }
 
 /**
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 049d68831ccd..1d5e46d71070 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -266,7 +266,13 @@ static void handle_ksmbd_work(struct work_struct *wk)
 
 	ksmbd_conn_try_dequeue_request(work);
 	ksmbd_free_work_struct(work);
-	atomic_dec(&conn->r_count);
+	/*
+	 * Checking waitqueue to dropping pending requests on
+	 * disconnection. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
+		wake_up(&conn->r_count_q);
 }
 
 /**
-- 
2.25.1


