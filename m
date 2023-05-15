Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060AC7036E8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbjEORPF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbjEOROm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495F10E7B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0130062B9D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6472C433EF;
        Mon, 15 May 2023 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170774;
        bh=VH89LrmH2athmmN/ojQCPqTotKDAEx2Pprh9W0W2TiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uvkdbfdx8VjdE62fH5XiuLg2SsKjpsMoWFboM2/Q1lh4D22jlAiCH67TcTGo5M7ov
         rfsPQ030NYMsalhUvf/11BskUCPhvkRXedfPw8MOYKHwW4v192exL8KP3ycAyerSPG
         TMB4qd2sd3pgAlo+qfTjjXxA8vItIQ7kSR5LWBHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, zdi-disclosures@trendmicro.com
Subject: [PATCH 6.1 213/239] ksmbd: fix racy issue from session setup and logoff
Date:   Mon, 15 May 2023 18:27:56 +0200
Message-Id: <20230515161728.117087678@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/connection.c        | 14 ++++----
 fs/ksmbd/connection.h        | 39 ++++++++++++---------
 fs/ksmbd/mgmt/user_session.c |  1 +
 fs/ksmbd/server.c            |  3 +-
 fs/ksmbd/smb2pdu.c           | 67 +++++++++++++++++++++++-------------
 fs/ksmbd/transport_tcp.c     |  2 +-
 6 files changed, 77 insertions(+), 49 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index b8f9d627f241d..3cb88853d6932 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -56,7 +56,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 		return NULL;
 
 	conn->need_neg = true;
-	conn->status = KSMBD_SESS_NEW;
+	ksmbd_conn_set_new(conn);
 	conn->local_nls = load_nls("utf8");
 	if (!conn->local_nls)
 		conn->local_nls = load_nls_default();
@@ -149,12 +149,12 @@ int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
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
@@ -245,7 +245,7 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	if (!ksmbd_server_running())
 		return false;
 
-	if (conn->status == KSMBD_SESS_EXITING)
+	if (ksmbd_conn_exiting(conn))
 		return false;
 
 	if (kthread_should_stop())
@@ -305,7 +305,7 @@ int ksmbd_conn_handler_loop(void *p)
 		pdu_size = get_rfc1002_len(hdr_buf);
 		ksmbd_debug(CONN, "RFC1002 header %u bytes\n", pdu_size);
 
-		if (conn->status == KSMBD_SESS_GOOD)
+		if (ksmbd_conn_good(conn))
 			max_allowed_pdu_size =
 				SMB3_MAX_MSGSIZE + conn->vals->max_write_size;
 		else
@@ -314,7 +314,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > max_allowed_pdu_size) {
 			pr_err_ratelimited("PDU length(%u) excceed maximum allowed pdu size(%u) on connection(%d)\n",
 					pdu_size, max_allowed_pdu_size,
-					conn->status);
+					READ_ONCE(conn->status));
 			break;
 		}
 
@@ -418,7 +418,7 @@ static void stop_sessions(void)
 		if (task)
 			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
 				    task->comm, task_pid_nr(task));
-		conn->status = KSMBD_SESS_EXITING;
+		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
 			read_unlock(&conn_list_lock);
 			t->ops->shutdown(t);
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 0e3a848defaf3..98bb5f199fa24 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -162,6 +162,8 @@ void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops);
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
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index a2b128dedcfcf..69b85a98e2c35 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -324,6 +324,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	if (ksmbd_init_file_table(&sess->file_table))
 		goto error;
 
+	sess->state = SMB2_SESSION_IN_PROGRESS;
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
 	xa_init(&sess->ksmbd_chann_list);
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 8c2bc513445c3..8a0ad399f2456 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -93,7 +93,8 @@ static inline int check_conn_state(struct ksmbd_work *work)
 {
 	struct smb_hdr *rsp_hdr;
 
-	if (ksmbd_conn_exiting(work) || ksmbd_conn_need_reconnect(work)) {
+	if (ksmbd_conn_exiting(work->conn) ||
+	    ksmbd_conn_need_reconnect(work->conn)) {
 		rsp_hdr = work->response_buf;
 		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
 		return 1;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index ac79d4c86067f..6c26934272ad5 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -247,7 +247,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 
 	rsp = smb2_get_msg(work->response_buf);
 
-	WARN_ON(ksmbd_conn_good(work));
+	WARN_ON(ksmbd_conn_good(conn));
 
 	rsp->StructureSize = cpu_to_le16(65);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
@@ -277,7 +277,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
 	conn->use_spnego = true;
 
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 	return 0;
 }
 
@@ -567,7 +567,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	    cmd == SMB2_SESSION_SETUP_HE)
 		return 0;
 
-	if (!ksmbd_conn_good(work))
+	if (!ksmbd_conn_good(conn))
 		return -EINVAL;
 
 	sess_id = le64_to_cpu(req_hdr->SessionId);
@@ -600,7 +600,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
-		chann->conn->status = KSMBD_SESS_EXITING;
+		ksmbd_conn_set_exiting(chann->conn);
 }
 
 /**
@@ -1067,7 +1067,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Received negotiate request\n");
 	conn->need_neg = false;
-	if (ksmbd_conn_good(work)) {
+	if (ksmbd_conn_good(conn)) {
 		pr_err("conn->tcp_status is already in CifsGood State\n");
 		work->send_no_response = 1;
 		return rc;
@@ -1222,7 +1222,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	}
 
 	conn->srv_sec_mode = le16_to_cpu(rsp->SecurityMode);
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 
 err_out:
 	if (rc < 0)
@@ -1643,6 +1643,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	rsp->SecurityBufferLength = 0;
 	inc_rfc1001_len(work->response_buf, 9);
 
+	ksmbd_conn_lock(conn);
 	if (!req->hdr.SessionId) {
 		sess = ksmbd_smb2_session_create();
 		if (!sess) {
@@ -1690,6 +1691,12 @@ int smb2_sess_setup(struct ksmbd_work *work)
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
@@ -1714,12 +1721,20 @@ int smb2_sess_setup(struct ksmbd_work *work)
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
@@ -1749,8 +1764,10 @@ int smb2_sess_setup(struct ksmbd_work *work)
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
@@ -1772,8 +1789,10 @@ int smb2_sess_setup(struct ksmbd_work *work)
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
 
@@ -1841,14 +1860,13 @@ int smb2_sess_setup(struct ksmbd_work *work)
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
 
@@ -2073,21 +2091,24 @@ int smb2_session_logoff(struct ksmbd_work *work)
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
@@ -2099,9 +2120,7 @@ int smb2_session_logoff(struct ksmbd_work *work)
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
-
-	/* let start_tcp_sess free connection info now */
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 	return 0;
 }
 
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index 20e85e2701f26..eff7a1d793f00 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -333,7 +333,7 @@ static int ksmbd_tcp_readv(struct tcp_transport *t, struct kvec *iov_orig,
 		if (length == -EINTR) {
 			total_read = -ESHUTDOWN;
 			break;
-		} else if (conn->status == KSMBD_SESS_NEED_RECONNECT) {
+		} else if (ksmbd_conn_need_reconnect(conn)) {
 			total_read = -EAGAIN;
 			break;
 		} else if (length == -ERESTARTSYS || length == -EAGAIN) {
-- 
2.39.2



