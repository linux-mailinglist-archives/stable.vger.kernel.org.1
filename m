Return-Path: <stable+bounces-7760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC8817623
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCB71C2529F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2A4498B4;
	Mon, 18 Dec 2023 15:42:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299749889
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2628107a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914143; x=1703518943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8b5Rlf8rrx6A97KpCnNwhoVqNSXsbxLcYLe/C/RCjZA=;
        b=ssejwY2vE+CQQMaueKo0H4P62u+0HwFQWwVI2K8JP2lZvB3HIvakifme3Wk0+EFViO
         qogMwdpfp1YpONzbYQZdCePRhM0k+0AagrMh4IhSYnFTS0Gaw9PIxHSiTUC1YwOy3H//
         Korb2JgIsua5qpHdi5G4kXPfC2Ab3i3tvF7Yu2wS7v7qCPxJcL1xgbC5aW0diC+NQUMF
         NfygSN5fwpROUWbTNshz9VM0EZ3y2DiPea0hDF9EUmVA92NJY4hsdVO6YQMCFg7fpk/K
         N3roej5VJzkoy1cKQ5PHWK/wo0y6xHky37UnyU9hwdF4V0LG/boSIfs1CvRUczNBsNAx
         kP2g==
X-Gm-Message-State: AOJu0Yy1OcwV1/0BYvcBaC64KtciL2SRz9pgE9LUK0pNzpy456iGzxrH
	JStkVB69t17eL30lkg6cu7Y=
X-Google-Smtp-Source: AGHT+IEti6A9R7SrnMN1MBCphL5WTLI05vbGoRe5YPKI1tPRL3M2KVKDGHqNPmPLBcWcRbyxg/l4eQ==
X-Received: by 2002:a17:90a:4e4e:b0:28b:4d42:ef55 with SMTP id t14-20020a17090a4e4e00b0028b4d42ef55mr1553443pjl.90.1702914142975;
        Mon, 18 Dec 2023 07:42:22 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:22 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	luosili <rootlab@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 131/154] ksmbd: fix race condition between session lookup and expire
Date: Tue, 19 Dec 2023 00:34:31 +0900
Message-Id: <20231218153454.8090-132-linkinjeon@kernel.org>
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

[ Upstream commit 53ff5cf89142b978b1a5ca8dc4d4425e6a09745f ]

 Thread A                        +  Thread B
 ksmbd_session_lookup            |  smb2_sess_setup
   sess = xa_load                |
                                 |
                                 |    xa_erase(&conn->sessions, sess->id);
                                 |
                                 |    ksmbd_session_destroy(sess) --> kfree(sess)
                                 |
   // UAF!                       |
   sess->last_active = jiffies   |
                                 +

This patch add rwsem to fix race condition between ksmbd_session_lookup
and ksmbd_expire_session.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c        |  2 ++
 fs/ksmbd/connection.h        |  1 +
 fs/ksmbd/mgmt/user_session.c | 10 +++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 9e12738a56c6..28b65a43fa39 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -84,6 +84,8 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
 
+	init_rwsem(&conn->session_lock);
+
 	down_write(&conn_list_lock);
 	list_add(&conn->conns_list, &conn_list);
 	up_write(&conn_list_lock);
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index ab2583f030ce..3c005246a32e 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -50,6 +50,7 @@ struct ksmbd_conn {
 	struct nls_table		*local_nls;
 	struct unicode_map		*um;
 	struct list_head		conns_list;
+	struct rw_semaphore		session_lock;
 	/* smb session 1 per user */
 	struct xarray			sessions;
 	unsigned long			last_active;
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 8a5dcab05614..b8be14a96cf6 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -174,7 +174,7 @@ static void ksmbd_expire_session(struct ksmbd_conn *conn)
 	unsigned long id;
 	struct ksmbd_session *sess;
 
-	down_write(&sessions_table_lock);
+	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
 		if (sess->state != SMB2_SESSION_VALID ||
 		    time_after(jiffies,
@@ -185,7 +185,7 @@ static void ksmbd_expire_session(struct ksmbd_conn *conn)
 			continue;
 		}
 	}
-	up_write(&sessions_table_lock);
+	up_write(&conn->session_lock);
 }
 
 int ksmbd_session_register(struct ksmbd_conn *conn,
@@ -227,7 +227,9 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 			}
 		}
 	}
+	up_write(&sessions_table_lock);
 
+	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
 		unsigned long chann_id;
 		struct channel *chann;
@@ -244,7 +246,7 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 			ksmbd_session_destroy(sess);
 		}
 	}
-	up_write(&sessions_table_lock);
+	up_write(&conn->session_lock);
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
@@ -252,9 +254,11 @@ struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 {
 	struct ksmbd_session *sess;
 
+	down_read(&conn->session_lock);
 	sess = xa_load(&conn->sessions, id);
 	if (sess)
 		sess->last_active = jiffies;
+	up_read(&conn->session_lock);
 	return sess;
 }
 
-- 
2.25.1


