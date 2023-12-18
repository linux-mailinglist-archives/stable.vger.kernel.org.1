Return-Path: <stable+bounces-7718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1260D8175ED
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8007A1F24E70
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA649882;
	Mon, 18 Dec 2023 15:40:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5F71448
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28b6218d102so1368837a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914007; x=1703518807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwd7Xcwz5gh48eBYOPWqDvLlKPPPKwj3cgXScjwIRiw=;
        b=SlYvTgwm3JBcaaWGpvwNC6sNuCHTdA0AYVF7XHxb853Hn1QqiATr4d/8eoFGblIxI0
         cw30+9IjfyY0EWmphkcMNTwN0X3HGQmBq8eRXxglUnwIhfi/0HmgmaRQCfq0qWHJGoP3
         77JL+Ijs0aDFITZTVkPz/3ux+4KvXpSvMrmmk40wOreetL+rG+tDplz++BWOU8QCO9sB
         S7e+dNuae+7WTCB6a8tdlPgLdhfUNYYM4vWl2eTh6/41qA4quqeffRLMWxcZnv+1Jft2
         ys6R6ssTnBhfrynuprUfJB6mtjn/I2GtZcz9IgEHR8YVKcyfo/+7LbhmDhNPoXrQUCKZ
         KcMw==
X-Gm-Message-State: AOJu0YyQoJEaBEblFgV34SRjXHyiyNfWKf34HfRBltvOwKx8Kx7a+2FH
	xu+POd/DtEt8mLn3ZOdWOW9wGbGMLHU=
X-Google-Smtp-Source: AGHT+IFmLsKDYk514qpoKaICTE2CagMRINzr5rsaUHaHXJq8+cXvGLUf3pHiOpKE/2Oh3aYjnw4T6w==
X-Received: by 2002:a17:90a:1d06:b0:28b:65c6:8aae with SMTP id c6-20020a17090a1d0600b0028b65c68aaemr1342588pjd.58.1702914006922;
        Mon, 18 Dec 2023 07:40:06 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:06 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 089/154] ksmbd: destroy expired sessions
Date: Tue, 19 Dec 2023 00:33:49 +0900
Message-Id: <20231218153454.8090-90-linkinjeon@kernel.org>
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

[ Upstream commit ea174a91893956450510945a0c5d1a10b5323656 ]

client can indefinitely send smb2 session setup requests with
the SessionId set to 0, thus indefinitely spawning new sessions,
and causing indefinite memory usage. This patch limit to the number
of sessions using expired timeout and session state.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20478
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/user_session.c | 68 ++++++++++++++++++++----------------
 fs/ksmbd/mgmt/user_session.h |  1 +
 fs/ksmbd/smb2pdu.c           |  1 +
 fs/ksmbd/smb2pdu.h           |  2 ++
 4 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 68d40025cfbf..3840de7773b9 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -165,70 +165,73 @@ static struct ksmbd_session *__session_lookup(unsigned long long id)
 	struct ksmbd_session *sess;
 
 	hash_for_each_possible(sessions_table, sess, hlist, id) {
-		if (id == sess->id)
+		if (id == sess->id) {
+			sess->last_active = jiffies;
 			return sess;
+		}
 	}
 	return NULL;
 }
 
+static void ksmbd_expire_session(struct ksmbd_conn *conn)
+{
+	unsigned long id;
+	struct ksmbd_session *sess;
+
+	xa_for_each(&conn->sessions, id, sess) {
+		if (sess->state != SMB2_SESSION_VALID ||
+		    time_after(jiffies,
+			       sess->last_active + SMB2_SESSION_TIMEOUT)) {
+			xa_erase(&conn->sessions, sess->id);
+			ksmbd_session_destroy(sess);
+			continue;
+		}
+	}
+}
+
 int ksmbd_session_register(struct ksmbd_conn *conn,
 			   struct ksmbd_session *sess)
 {
 	sess->dialect = conn->dialect;
 	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
+	ksmbd_expire_session(conn);
 	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
-static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
+static void ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
 	struct channel *chann;
 
 	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
 	if (!chann)
-		return -ENOENT;
+		return;
 
 	kfree(chann);
-
-	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 {
 	struct ksmbd_session *sess;
+	unsigned long id;
 
-	if (conn->binding) {
-		int bkt;
-
-		down_write(&sessions_table_lock);
-		hash_for_each(sessions_table, bkt, sess, hlist) {
-			if (!ksmbd_chann_del(conn, sess)) {
-				up_write(&sessions_table_lock);
-				goto sess_destroy;
-			}
+	xa_for_each(&conn->sessions, id, sess) {
+		ksmbd_chann_del(conn, sess);
+		if (xa_empty(&sess->ksmbd_chann_list)) {
+			xa_erase(&conn->sessions, sess->id);
+			ksmbd_session_destroy(sess);
 		}
-		up_write(&sessions_table_lock);
-	} else {
-		unsigned long id;
-
-		xa_for_each(&conn->sessions, id, sess) {
-			if (!ksmbd_chann_del(conn, sess))
-				goto sess_destroy;
-		}
-	}
-
-	return;
-
-sess_destroy:
-	if (xa_empty(&sess->ksmbd_chann_list)) {
-		xa_erase(&conn->sessions, sess->id);
-		ksmbd_session_destroy(sess);
 	}
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id)
 {
-	return xa_load(&conn->sessions, id);
+	struct ksmbd_session *sess;
+
+	sess = xa_load(&conn->sessions, id);
+	if (sess)
+		sess->last_active = jiffies;
+	return sess;
 }
 
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
@@ -237,6 +240,8 @@ struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
+	if (sess)
+		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -315,6 +320,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	if (ksmbd_init_file_table(&sess->file_table))
 		goto error;
 
+	sess->last_active = jiffies;
 	sess->state = SMB2_SESSION_IN_PROGRESS;
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index b6a9e7a6aae4..f99d475b28db 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -59,6 +59,7 @@ struct ksmbd_session {
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
 	struct ksmbd_file_table		file_table;
+	unsigned long			last_active;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index ef4550152721..2ebd252894de 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1875,6 +1875,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
+			sess->last_active = jiffies;
 			sess->state = SMB2_SESSION_EXPIRED;
 			if (try_delay)
 				ssleep(5);
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 9cde1f8e8428..a774889e0aa5 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -619,6 +619,8 @@ struct create_context {
 	__u8 Buffer[0];
 } __packed;
 
+#define SMB2_SESSION_TIMEOUT		(10 * HZ)
+
 struct create_durable_req_v2 {
 	struct create_context ccontext;
 	__u8   Name[8];
-- 
2.25.1


