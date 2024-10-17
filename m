Return-Path: <stable+bounces-86675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB759A2C07
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A9F1F25742
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0E1DEFE1;
	Thu, 17 Oct 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXJd+9Lv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773151DE8B8
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189189; cv=none; b=cmv09MJxXf2AJYMs4KLVA+igx46ln+ZhIsycbSYay39ZBWKu3AfR4iYd7CKhORq2XuZmQRRBhDMUQiZr3ntxNgyCj4R+/d/rdm9jTTO4OAVxuamGa5OuTGrRVHe2ob9OJzKNfu3QIkxPrv4N2OR8U/92FeUdJ4tp5hMFMlB7NsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189189; c=relaxed/simple;
	bh=xtpvklJlymGtbtPho/vOw/un3Sepj9G+AmTLS44RAdo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q5fNMSnw3qUTR6ywz2oB2NsKUYiiyyVHxJp5WhiwBApiwEfWjxSvMdxflo/q0a2TRve1cygQW4cODfQ7iEK35t2QqmD6uEL7KHwKuB+sybIrEdALgZ+yYByiK/UXbQBcON4GrutegClrRm96xkJQdPbylYMXfyiCi+ScZQ7BIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXJd+9Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9658EC4CEC3;
	Thu, 17 Oct 2024 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729189189;
	bh=xtpvklJlymGtbtPho/vOw/un3Sepj9G+AmTLS44RAdo=;
	h=Subject:To:Cc:From:Date:From;
	b=VXJd+9Lv6iqXKM3lKMIgZhOOonDvWuRgdSy4/ThtIGb0E2dnM4St09vJCxDZdwQCG
	 iYHzS0t7vxT7bVyRB14/X8xSTaAtNsZqbytb5atGFcWUfSv4Q1rIv+A9S+JMbJHhcM
	 1d+bcniawq19Q9epwZBl+7zq4KcHQ++BCRQx1ET4=
Subject: FAILED: patch "[PATCH] ksmbd: fix user-after-free from session log off" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Oct 2024 20:19:45 +0200
Message-ID: <2024101744-fence-valiant-9382@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7aa8804c0b67b3cb263a472d17f2cb50d7f1a930
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101744-fence-valiant-9382@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7aa8804c0b67b3cb263a472d17f2cb50d7f1a930 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 8 Oct 2024 22:42:57 +0900
Subject: [PATCH] ksmbd: fix user-after-free from session log off

There is racy issue between smb2 session log off and smb2 session setup.
It will cause user-after-free from session log off.
This add session_lock when setting SMB2_SESSION_EXPIRED and referece
count to session struct not to free session while it is being used.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-25282
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 99416ce9f501..1e4624e9d434 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -177,9 +177,10 @@ static void ksmbd_expire_session(struct ksmbd_conn *conn)
 
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
@@ -269,8 +270,6 @@ struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
-	if (sess)
-		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -289,6 +288,22 @@ struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
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
@@ -393,6 +408,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 	rwlock_init(&sess->tree_conns_lock);
+	atomic_set(&sess->refcnt, 1);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
diff --git a/fs/smb/server/mgmt/user_session.h b/fs/smb/server/mgmt/user_session.h
index dc9fded2cd43..c1c4b20bd5c6 100644
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
@@ -104,4 +106,6 @@ void ksmbd_release_tree_conn_id(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name);
 void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id);
+void ksmbd_user_session_get(struct ksmbd_session *sess);
+void ksmbd_user_session_put(struct ksmbd_session *sess);
 #endif /* __USER_SESSION_MANAGEMENT_H__ */
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 231d2d224656..9670c97f14b3 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -238,6 +238,8 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	} while (is_chained == true);
 
 send:
+	if (work->sess)
+		ksmbd_user_session_put(work->sess);
 	if (work->tcon)
 		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 797b0f24097b..599118aed205 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -605,8 +605,10 @@ int smb2_check_user_session(struct ksmbd_work *work)
 
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
@@ -1740,6 +1742,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		}
 
 		conn->binding = true;
+		ksmbd_user_session_get(sess);
 	} else if ((conn->dialect < SMB30_PROT_ID ||
 		    server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   (req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
@@ -1766,6 +1769,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		}
 
 		conn->binding = false;
+		ksmbd_user_session_get(sess);
 	}
 	work->sess = sess;
 
@@ -2228,7 +2232,9 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	}
 
 	ksmbd_destroy_file_table(&sess->file_table);
+	down_write(&conn->session_lock);
 	sess->state = SMB2_SESSION_EXPIRED;
+	up_write(&conn->session_lock);
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;


