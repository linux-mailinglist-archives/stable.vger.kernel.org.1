Return-Path: <stable+bounces-8086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A024D81A479
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50B01C24600
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71D48795;
	Wed, 20 Dec 2023 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oAI2Em4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EB41A86;
	Wed, 20 Dec 2023 16:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB50C433C8;
	Wed, 20 Dec 2023 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088869;
	bh=HTi9zvIoQ3ovi+wjOo27c2gbmoCU3uZCD57CV/WTDJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAI2Em4CV2HX6hsl34i0dluvw76N2SnSNJtHGZfr6lWBblEO4bIF9g38sLi55lR0B
	 EGrc1M/9nFGqJa9ssDYxFd+sKjCjJWaX+1bcAwnSFPu+NyOt22i6Cfnu/8ma2nR48v
	 Xy5VoH8OJwEqyZ7UmMaJXLf0JpfPlYq35gUyV+R8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 088/159] ksmbd: fix racy issue from session setup and logoff
Date: Wed, 20 Dec 2023 17:09:13 +0100
Message-ID: <20231220160935.480188228@linuxfoundation.org>
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

[ Upstream commit f5c779b7ddbda30866cf2a27c63e34158f858c73 ]

This racy issue is triggered by sending concurrent session setup and
logoff requests. This patch does not set connection status as
KSMBD_SESS_GOOD if state is KSMBD_SESS_NEED_RECONNECT in session setup.
And relookup session to validate if session is deleted in logoff.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20481, ZDI-CAN-20590, ZDI-CAN-20596
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/connection.c        |   14 ++++----
 fs/ksmbd/connection.h        |   39 ++++++++++++++-----------
 fs/ksmbd/mgmt/user_session.c |    1 
 fs/ksmbd/server.c            |    3 +
 fs/ksmbd/smb2pdu.c           |   67 +++++++++++++++++++++++++++----------------
 fs/ksmbd/transport_tcp.c     |    2 -
 6 files changed, 77 insertions(+), 49 deletions(-)

--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -56,7 +56,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void
 		return NULL;
 
 	conn->need_neg = true;
-	conn->status = KSMBD_SESS_NEW;
+	ksmbd_conn_set_new(conn);
 	conn->local_nls = load_nls("utf8");
 	if (!conn->local_nls)
 		conn->local_nls = load_nls_default();
@@ -147,12 +147,12 @@ int ksmbd_conn_try_dequeue_request(struc
 	return ret;
 }
 
-static void ksmbd_conn_lock(struct ksmbd_conn *conn)
+void ksmbd_conn_lock(struct ksmbd_conn *conn)
 {
 	mutex_lock(&conn->srv_mutex);
 }
 
-static void ksmbd_conn_unlock(struct ksmbd_conn *conn)
+void ksmbd_conn_unlock(struct ksmbd_conn *conn)
 {
 	mutex_unlock(&conn->srv_mutex);
 }
@@ -243,7 +243,7 @@ bool ksmbd_conn_alive(struct ksmbd_conn
 	if (!ksmbd_server_running())
 		return false;
 
-	if (conn->status == KSMBD_SESS_EXITING)
+	if (ksmbd_conn_exiting(conn))
 		return false;
 
 	if (kthread_should_stop())
@@ -303,7 +303,7 @@ int ksmbd_conn_handler_loop(void *p)
 		pdu_size = get_rfc1002_len(hdr_buf);
 		ksmbd_debug(CONN, "RFC1002 header %u bytes\n", pdu_size);
 
-		if (conn->status == KSMBD_SESS_GOOD)
+		if (ksmbd_conn_good(conn))
 			max_allowed_pdu_size =
 				SMB3_MAX_MSGSIZE + conn->vals->max_write_size;
 		else
@@ -312,7 +312,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > max_allowed_pdu_size) {
 			pr_err_ratelimited("PDU length(%u) exceeded maximum allowed pdu size(%u) on connection(%d)\n",
 					pdu_size, max_allowed_pdu_size,
-					conn->status);
+					READ_ONCE(conn->status));
 			break;
 		}
 
@@ -417,7 +417,7 @@ again:
 		if (task)
 			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
 				    task->comm, task_pid_nr(task));
-		conn->status = KSMBD_SESS_EXITING;
+		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
 			read_unlock(&conn_list_lock);
 			t->ops->shutdown(t);
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -162,6 +162,8 @@ void ksmbd_conn_init_server_callbacks(st
 int ksmbd_conn_handler_loop(void *p);
 int ksmbd_conn_transport_init(void);
 void ksmbd_conn_transport_destroy(void);
+void ksmbd_conn_lock(struct ksmbd_conn *conn);
+void ksmbd_conn_unlock(struct ksmbd_conn *conn);
 
 /*
  * WARNING
@@ -169,43 +171,48 @@ void ksmbd_conn_transport_destroy(void);
  * This is a hack. We will move status to a proper place once we land
  * a multi-sessions support.
  */
-static inline bool ksmbd_conn_good(struct ksmbd_work *work)
+static inline bool ksmbd_conn_good(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_GOOD;
+	return READ_ONCE(conn->status) == KSMBD_SESS_GOOD;
 }
 
-static inline bool ksmbd_conn_need_negotiate(struct ksmbd_work *work)
+static inline bool ksmbd_conn_need_negotiate(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_NEED_NEGOTIATE;
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_NEGOTIATE;
 }
 
-static inline bool ksmbd_conn_need_reconnect(struct ksmbd_work *work)
+static inline bool ksmbd_conn_need_reconnect(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_NEED_RECONNECT;
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_RECONNECT;
 }
 
-static inline bool ksmbd_conn_exiting(struct ksmbd_work *work)
+static inline bool ksmbd_conn_exiting(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_EXITING;
+	return READ_ONCE(conn->status) == KSMBD_SESS_EXITING;
 }
 
-static inline void ksmbd_conn_set_good(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_new(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_GOOD;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEW);
 }
 
-static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_good(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_NEED_NEGOTIATE;
+	WRITE_ONCE(conn->status, KSMBD_SESS_GOOD);
 }
 
-static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_NEED_RECONNECT;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_NEGOTIATE);
 }
 
-static inline void ksmbd_conn_set_exiting(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_EXITING;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_RECONNECT);
+}
+
+static inline void ksmbd_conn_set_exiting(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_EXITING);
 }
 #endif /* __CONNECTION_H__ */
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -315,6 +315,7 @@ static struct ksmbd_session *__session_c
 	if (ksmbd_init_file_table(&sess->file_table))
 		goto error;
 
+	sess->state = SMB2_SESSION_IN_PROGRESS;
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
 	xa_init(&sess->ksmbd_chann_list);
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -93,7 +93,8 @@ static inline int check_conn_state(struc
 {
 	struct smb_hdr *rsp_hdr;
 
-	if (ksmbd_conn_exiting(work) || ksmbd_conn_need_reconnect(work)) {
+	if (ksmbd_conn_exiting(work->conn) ||
+	    ksmbd_conn_need_reconnect(work->conn)) {
 		rsp_hdr = work->response_buf;
 		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
 		return 1;
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -265,7 +265,7 @@ int init_smb2_neg_rsp(struct ksmbd_work
 
 	rsp = smb2_get_msg(work->response_buf);
 
-	WARN_ON(ksmbd_conn_good(work));
+	WARN_ON(ksmbd_conn_good(conn));
 
 	rsp->StructureSize = cpu_to_le16(65);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
@@ -295,7 +295,7 @@ int init_smb2_neg_rsp(struct ksmbd_work
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
 	conn->use_spnego = true;
 
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 	return 0;
 }
 
@@ -574,7 +574,7 @@ int smb2_check_user_session(struct ksmbd
 	    cmd == SMB2_SESSION_SETUP_HE)
 		return 0;
 
-	if (!ksmbd_conn_good(work))
+	if (!ksmbd_conn_good(conn))
 		return -EIO;
 
 	sess_id = le64_to_cpu(req_hdr->SessionId);
@@ -625,7 +625,7 @@ static void destroy_previous_session(str
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
-		chann->conn->status = KSMBD_SESS_EXITING;
+		ksmbd_conn_set_exiting(chann->conn);
 }
 
 /**
@@ -1081,7 +1081,7 @@ int smb2_handle_negotiate(struct ksmbd_w
 
 	ksmbd_debug(SMB, "Received negotiate request\n");
 	conn->need_neg = false;
-	if (ksmbd_conn_good(work)) {
+	if (ksmbd_conn_good(conn)) {
 		pr_err("conn->tcp_status is already in CifsGood State\n");
 		work->send_no_response = 1;
 		return rc;
@@ -1236,7 +1236,7 @@ int smb2_handle_negotiate(struct ksmbd_w
 	}
 
 	conn->srv_sec_mode = le16_to_cpu(rsp->SecurityMode);
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 
 err_out:
 	if (rc < 0)
@@ -1658,6 +1658,7 @@ int smb2_sess_setup(struct ksmbd_work *w
 	rsp->SecurityBufferLength = 0;
 	inc_rfc1001_len(work->response_buf, 9);
 
+	ksmbd_conn_lock(conn);
 	if (!req->hdr.SessionId) {
 		sess = ksmbd_smb2_session_create();
 		if (!sess) {
@@ -1705,6 +1706,12 @@ int smb2_sess_setup(struct ksmbd_work *w
 			goto out_err;
 		}
 
+		if (ksmbd_conn_need_reconnect(conn)) {
+			rc = -EFAULT;
+			sess = NULL;
+			goto out_err;
+		}
+
 		if (ksmbd_session_lookup(conn, sess_id)) {
 			rc = -EACCES;
 			goto out_err;
@@ -1729,12 +1736,20 @@ int smb2_sess_setup(struct ksmbd_work *w
 			rc = -ENOENT;
 			goto out_err;
 		}
+
+		if (sess->state == SMB2_SESSION_EXPIRED) {
+			rc = -EFAULT;
+			goto out_err;
+		}
+
+		if (ksmbd_conn_need_reconnect(conn)) {
+			rc = -EFAULT;
+			sess = NULL;
+			goto out_err;
+		}
 	}
 	work->sess = sess;
 
-	if (sess->state == SMB2_SESSION_EXPIRED)
-		sess->state = SMB2_SESSION_IN_PROGRESS;
-
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
 	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer) ||
@@ -1764,8 +1779,10 @@ int smb2_sess_setup(struct ksmbd_work *w
 				goto out_err;
 			}
 
-			ksmbd_conn_set_good(work);
-			sess->state = SMB2_SESSION_VALID;
+			if (!ksmbd_conn_need_reconnect(conn)) {
+				ksmbd_conn_set_good(conn);
+				sess->state = SMB2_SESSION_VALID;
+			}
 			kfree(sess->Preauth_HashValue);
 			sess->Preauth_HashValue = NULL;
 		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
@@ -1787,8 +1804,10 @@ int smb2_sess_setup(struct ksmbd_work *w
 				if (rc)
 					goto out_err;
 
-				ksmbd_conn_set_good(work);
-				sess->state = SMB2_SESSION_VALID;
+				if (!ksmbd_conn_need_reconnect(conn)) {
+					ksmbd_conn_set_good(conn);
+					sess->state = SMB2_SESSION_VALID;
+				}
 				if (conn->binding) {
 					struct preauth_session *preauth_sess;
 
@@ -1856,14 +1875,13 @@ out_err:
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
-			xa_erase(&conn->sessions, sess->id);
-			ksmbd_session_destroy(sess);
-			work->sess = NULL;
+			sess->state = SMB2_SESSION_EXPIRED;
 			if (try_delay)
 				ssleep(5);
 		}
 	}
 
+	ksmbd_conn_unlock(conn);
 	return rc;
 }
 
@@ -2087,21 +2105,24 @@ int smb2_session_logoff(struct ksmbd_wor
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_logoff_rsp *rsp = smb2_get_msg(work->response_buf);
-	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_session *sess;
+	struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
-	/* setting CifsExiting here may race with start_tcp_sess */
-	ksmbd_conn_set_need_reconnect(work);
+	ksmbd_conn_set_need_reconnect(conn);
 	ksmbd_close_session_fds(work);
 	ksmbd_conn_wait_idle(conn);
 
+	/*
+	 * Re-lookup session to validate if session is deleted
+	 * while waiting request complete
+	 */
+	sess = ksmbd_session_lookup(conn, le64_to_cpu(req->hdr.SessionId));
 	if (ksmbd_tree_conn_session_logoff(sess)) {
-		struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
-
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
@@ -2113,9 +2134,7 @@ int smb2_session_logoff(struct ksmbd_wor
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
-
-	/* let start_tcp_sess free connection info now */
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 	return 0;
 }
 
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -333,7 +333,7 @@ static int ksmbd_tcp_readv(struct tcp_tr
 		if (length == -EINTR) {
 			total_read = -ESHUTDOWN;
 			break;
-		} else if (conn->status == KSMBD_SESS_NEED_RECONNECT) {
+		} else if (ksmbd_conn_need_reconnect(conn)) {
 			total_read = -EAGAIN;
 			break;
 		} else if (length == -ERESTARTSYS || length == -EAGAIN) {



