Return-Path: <stable+bounces-87326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CADA9A6473
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653B41C20E33
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B81EF93F;
	Mon, 21 Oct 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kOtjms3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0F1E3DF3;
	Mon, 21 Oct 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507271; cv=none; b=Bg0zsq/E5XiJuq0T9LrLzmw7rD8jgg3B6ScggCGdEqXT3jJWIqRasBn/QwjlEZeMZxCQv2YjMrFcAIXtEBdcSa/wCbN3KQDaSIH6NTfM/rBeBh0FKTFaodyNeFSFc0NOOmZ81hBvCXukDPYqWnneCU4dlPx3EPFjwD6d0TSX/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507271; c=relaxed/simple;
	bh=ObphCfngXRde0m7QoMtDMyVH9tEodP5V1TtpbQ6UYAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbA0293iYrKXlySJxdkd3CE6Kr5uOba0LEXr3f0rjXzeVhiZiSFHJZTn1OeIXXjuEs/4WXS9w0KTGK77qHsy/xku3XZvlT3PxQqsxcX6NYbb7zT+xCPq5CE/B8KHy9fvr1WUBYl96aCC4yAUcdOcqOCsO01LbLU4XrU4efACFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kOtjms3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C51DC4CEC3;
	Mon, 21 Oct 2024 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507270;
	bh=ObphCfngXRde0m7QoMtDMyVH9tEodP5V1TtpbQ6UYAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOtjms3W/zeMhuLqpR34pXIQLcc/ndIQQdsIGed+k2boEfj4ox5kOdCwHhZpqxtHK
	 qv2advE87ItpjOdsN7pF+0AC/pmH90EojIwQkfkAItU6l7IHZ3HXXpwi4L9qnUQTie
	 pIsFghKQA1C/nInv8g7ZMYorcy6ZrwcDcDIDo/lg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 6.1 03/91] ksmbd: fix user-after-free from session log off
Date: Mon, 21 Oct 2024 12:24:17 +0200
Message-ID: <20241021102249.930971205@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
References: <20241021102249.791942892@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 7aa8804c0b67b3cb263a472d17f2cb50d7f1a930 upstream.

There is racy issue between smb2 session log off and smb2 session setup.
It will cause user-after-free from session log off.
This add session_lock when setting SMB2_SESSION_EXPIRED and referece
count to session struct not to free session while it is being used.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-25282
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/mgmt/user_session.c |   26 +++++++++++++++++++++-----
 fs/smb/server/mgmt/user_session.h |    4 ++++
 fs/smb/server/server.c            |    2 ++
 fs/smb/server/smb2pdu.c           |    8 +++++++-
 4 files changed, 34 insertions(+), 6 deletions(-)

--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -176,9 +176,10 @@ static void ksmbd_expire_session(struct
 
 	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
-		if (sess->state != SMB2_SESSION_VALID ||
-		    time_after(jiffies,
-			       sess->last_active + SMB2_SESSION_TIMEOUT)) {
+		if (atomic_read(&sess->refcnt) == 0 &&
+		    (sess->state != SMB2_SESSION_VALID ||
+		     time_after(jiffies,
+			       sess->last_active + SMB2_SESSION_TIMEOUT))) {
 			xa_erase(&conn->sessions, sess->id);
 			hash_del(&sess->hlist);
 			ksmbd_session_destroy(sess);
@@ -268,8 +269,6 @@ struct ksmbd_session *ksmbd_session_look
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
-	if (sess)
-		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -288,6 +287,22 @@ struct ksmbd_session *ksmbd_session_look
 	return sess;
 }
 
+void ksmbd_user_session_get(struct ksmbd_session *sess)
+{
+	atomic_inc(&sess->refcnt);
+}
+
+void ksmbd_user_session_put(struct ksmbd_session *sess)
+{
+	if (!sess)
+		return;
+
+	if (atomic_read(&sess->refcnt) <= 0)
+		WARN_ON(1);
+	else
+		atomic_dec(&sess->refcnt);
+}
+
 struct preauth_session *ksmbd_preauth_session_alloc(struct ksmbd_conn *conn,
 						    u64 sess_id)
 {
@@ -356,6 +371,7 @@ static struct ksmbd_session *__session_c
 	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 	rwlock_init(&sess->tree_conns_lock);
+	atomic_set(&sess->refcnt, 1);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
@@ -61,6 +61,8 @@ struct ksmbd_session {
 	struct ksmbd_file_table		file_table;
 	unsigned long			last_active;
 	rwlock_t			tree_conns_lock;
+
+	atomic_t			refcnt;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
@@ -101,4 +103,6 @@ void ksmbd_release_tree_conn_id(struct k
 int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name);
 void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id);
+void ksmbd_user_session_get(struct ksmbd_session *sess);
+void ksmbd_user_session_put(struct ksmbd_session *sess);
 #endif /* __USER_SESSION_MANAGEMENT_H__ */
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -238,6 +238,8 @@ static void __handle_ksmbd_work(struct k
 	} while (is_chained == true);
 
 send:
+	if (work->sess)
+		ksmbd_user_session_put(work->sess);
 	if (work->tcon)
 		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -604,8 +604,10 @@ int smb2_check_user_session(struct ksmbd
 
 	/* Check for validity of user session */
 	work->sess = ksmbd_session_lookup_all(conn, sess_id);
-	if (work->sess)
+	if (work->sess) {
+		ksmbd_user_session_get(work->sess);
 		return 1;
+	}
 	ksmbd_debug(SMB, "Invalid user session, Uid %llu\n", sess_id);
 	return -ENOENT;
 }
@@ -1759,6 +1761,7 @@ int smb2_sess_setup(struct ksmbd_work *w
 		}
 
 		conn->binding = true;
+		ksmbd_user_session_get(sess);
 	} else if ((conn->dialect < SMB30_PROT_ID ||
 		    server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   (req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
@@ -1785,6 +1788,7 @@ int smb2_sess_setup(struct ksmbd_work *w
 		}
 
 		conn->binding = false;
+		ksmbd_user_session_get(sess);
 	}
 	work->sess = sess;
 
@@ -2240,7 +2244,9 @@ int smb2_session_logoff(struct ksmbd_wor
 	}
 
 	ksmbd_destroy_file_table(&sess->file_table);
+	down_write(&conn->session_lock);
 	sess->state = SMB2_SESSION_EXPIRED;
+	up_write(&conn->session_lock);
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;



