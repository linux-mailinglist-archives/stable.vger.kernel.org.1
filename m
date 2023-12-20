Return-Path: <stable+bounces-8088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AEF81A47B
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AC21C20C1A
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74941C97;
	Wed, 20 Dec 2023 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AdAQRGoV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FD4184A;
	Wed, 20 Dec 2023 16:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323DDC433C8;
	Wed, 20 Dec 2023 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088875;
	bh=nYBCrW8kh6hkocaF/ZBEOJauPKNoBsvc72bEnD8TllQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdAQRGoVPnRa/GgdLL/VgxTrU1s7VxeRqJzGXBGI1Hj9PPLs7iczndpWg0Rf23Gg4
	 ElK5poEG9hXohA8tyPztPSPo0sK7ij0jOspOUWIqIDqj7o0eDp4ROv8YocViM0A1pn
	 4O/aVlFz91LJTqE0CVqccmwFEDbdf2q7zJ1r0fQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 089/159] ksmbd: destroy expired sessions
Date: Wed, 20 Dec 2023 17:09:14 +0100
Message-ID: <20231220160935.531835291@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit ea174a91893956450510945a0c5d1a10b5323656 ]

client can indefinitely send smb2 session setup requests with
the SessionId set to 0, thus indefinitely spawning new sessions,
and causing indefinite memory usage. This patch limit to the number
of sessions using expired timeout and session state.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20478
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/mgmt/user_session.c |   68 +++++++++++++++++++++++--------------------
 fs/ksmbd/mgmt/user_session.h |    1 
 fs/ksmbd/smb2pdu.c           |    1 
 fs/ksmbd/smb2pdu.h           |    2 +
 4 files changed, 41 insertions(+), 31 deletions(-)

--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -165,70 +165,73 @@ static struct ksmbd_session *__session_l
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
-		}
-		up_write(&sessions_table_lock);
-	} else {
-		unsigned long id;
-
-		xa_for_each(&conn->sessions, id, sess) {
-			if (!ksmbd_chann_del(conn, sess))
-				goto sess_destroy;
+	xa_for_each(&conn->sessions, id, sess) {
+		ksmbd_chann_del(conn, sess);
+		if (xa_empty(&sess->ksmbd_chann_list)) {
+			xa_erase(&conn->sessions, sess->id);
+			ksmbd_session_destroy(sess);
 		}
 	}
-
-	return;
-
-sess_destroy:
-	if (xa_empty(&sess->ksmbd_chann_list)) {
-		xa_erase(&conn->sessions, sess->id);
-		ksmbd_session_destroy(sess);
-	}
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
@@ -237,6 +240,8 @@ struct ksmbd_session *ksmbd_session_look
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
+	if (sess)
+		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -315,6 +320,7 @@ static struct ksmbd_session *__session_c
 	if (ksmbd_init_file_table(&sess->file_table))
 		goto error;
 
+	sess->last_active = jiffies;
 	sess->state = SMB2_SESSION_IN_PROGRESS;
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -59,6 +59,7 @@ struct ksmbd_session {
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
 	struct ksmbd_file_table		file_table;
+	unsigned long			last_active;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1875,6 +1875,7 @@ out_err:
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
+			sess->last_active = jiffies;
 			sess->state = SMB2_SESSION_EXPIRED;
 			if (try_delay)
 				ssleep(5);
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



