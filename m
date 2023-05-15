Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241087038C6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbjEORes (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbjEORe2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:34:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB1614E73
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 990B562D2D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69607C433D2;
        Mon, 15 May 2023 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171947;
        bh=Ngne0TTRKEGTks0EhbuSzIM6eC1MHJfQG3PlwdiAmJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9HxEHzegjPyXCKqZgsZREdALKBq26sJ0gtptJJaYiID1XqK0yXUf//RUW4dJ/Zqv
         omtZ+fsjmtB6mcePyYCOyTJxc1Iidky1Ug2PtlVPzP9+XWhMzblphP3WvGcUpPBf0h
         vYZebdkTEjIeXljWrrS1o97FunNquDBR9qkbWh3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 112/134] ksmbd: replace sessions list in connection with xarray
Date:   Mon, 15 May 2023 18:29:49 +0200
Message-Id: <20230515161706.858496177@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit e4d3e6b524c0c928f7fc9e03e047885c4951ae60 ]

Replace sessions list in connection with xarray.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 7b4323373d84 ("ksmbd: fix deadlock in ksmbd_find_crypto_ctx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/connection.c        |  3 ++-
 fs/ksmbd/connection.h        |  2 +-
 fs/ksmbd/mgmt/user_session.c | 31 +++++++------------------------
 fs/ksmbd/mgmt/user_session.h |  5 ++---
 fs/ksmbd/smb2pdu.c           | 13 +++++++++----
 5 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 21cda82f156de..b4c79359ef8b7 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -36,6 +36,7 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	list_del(&conn->conns_list);
 	write_unlock(&conn_list_lock);
 
+	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
 	kfree(conn);
@@ -66,12 +67,12 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 
 	init_waitqueue_head(&conn->req_running_q);
 	INIT_LIST_HEAD(&conn->conns_list);
-	INIT_LIST_HEAD(&conn->sessions);
 	INIT_LIST_HEAD(&conn->requests);
 	INIT_LIST_HEAD(&conn->async_requests);
 	spin_lock_init(&conn->request_lock);
 	spin_lock_init(&conn->credits_lock);
 	ida_init(&conn->async_ida);
+	xa_init(&conn->sessions);
 
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index f3367d7760d7e..7838cc46497d6 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -55,7 +55,7 @@ struct ksmbd_conn {
 	struct nls_table		*local_nls;
 	struct list_head		conns_list;
 	/* smb session 1 per user */
-	struct list_head		sessions;
+	struct xarray			sessions;
 	unsigned long			last_active;
 	/* How many request are running currently */
 	atomic_t			req_running;
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 0fa467f2c8973..8fe08df668582 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -154,8 +154,6 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 	if (!atomic_dec_and_test(&sess->refcnt))
 		return;
 
-	list_del(&sess->sessions_entry);
-
 	down_write(&sessions_table_lock);
 	hash_del(&sess->hlist);
 	up_write(&sessions_table_lock);
@@ -183,42 +181,28 @@ static struct ksmbd_session *__session_lookup(unsigned long long id)
 	return NULL;
 }
 
-void ksmbd_session_register(struct ksmbd_conn *conn,
-			    struct ksmbd_session *sess)
+int ksmbd_session_register(struct ksmbd_conn *conn,
+			   struct ksmbd_session *sess)
 {
 	sess->conn = conn;
-	list_add(&sess->sessions_entry, &conn->sessions);
+	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 {
 	struct ksmbd_session *sess;
+	unsigned long id;
 
-	while (!list_empty(&conn->sessions)) {
-		sess = list_entry(conn->sessions.next,
-				  struct ksmbd_session,
-				  sessions_entry);
-
+	xa_for_each(&conn->sessions, id, sess) {
+		xa_erase(&conn->sessions, sess->id);
 		ksmbd_session_destroy(sess);
 	}
 }
 
-static bool ksmbd_session_id_match(struct ksmbd_session *sess,
-				   unsigned long long id)
-{
-	return sess->id == id;
-}
-
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id)
 {
-	struct ksmbd_session *sess = NULL;
-
-	list_for_each_entry(sess, &conn->sessions, sessions_entry) {
-		if (ksmbd_session_id_match(sess, id))
-			return sess;
-	}
-	return NULL;
+	return xa_load(&conn->sessions, id);
 }
 
 int get_session(struct ksmbd_session *sess)
@@ -316,7 +300,6 @@ static struct ksmbd_session *__session_create(int protocol)
 		goto error;
 
 	set_session_flag(sess, protocol);
-	INIT_LIST_HEAD(&sess->sessions_entry);
 	xa_init(&sess->tree_conns);
 	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index e241f16a38512..8b08189be3fc2 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -57,7 +57,6 @@ struct ksmbd_session {
 	__u8				smb3decryptionkey[SMB3_ENC_DEC_KEY_SIZE];
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
-	struct list_head		sessions_entry;
 	struct ksmbd_file_table		file_table;
 	atomic_t			refcnt;
 };
@@ -84,8 +83,8 @@ void ksmbd_session_destroy(struct ksmbd_session *sess);
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id);
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id);
-void ksmbd_session_register(struct ksmbd_conn *conn,
-			    struct ksmbd_session *sess);
+int ksmbd_session_register(struct ksmbd_conn *conn,
+			   struct ksmbd_session *sess);
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn);
 struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
 					       unsigned long long id);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index bb8126deeaf29..d41995f89befe 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -595,7 +595,8 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	return -EINVAL;
 }
 
-static void destroy_previous_session(struct ksmbd_user *user, u64 id)
+static void destroy_previous_session(struct ksmbd_conn *conn,
+				     struct ksmbd_user *user, u64 id)
 {
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
@@ -614,6 +615,7 @@ static void destroy_previous_session(struct ksmbd_user *user, u64 id)
 	}
 
 	put_session(prev_sess);
+	xa_erase(&conn->sessions, prev_sess->id);
 	ksmbd_session_destroy(prev_sess);
 }
 
@@ -1452,7 +1454,7 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 	/* Check for previous session */
 	prev_id = le64_to_cpu(req->PreviousSessionId);
 	if (prev_id && prev_id != sess->id)
-		destroy_previous_session(user, prev_id);
+		destroy_previous_session(conn, user, prev_id);
 
 	if (sess->state == SMB2_SESSION_VALID) {
 		/*
@@ -1575,7 +1577,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	/* Check previous session */
 	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
 	if (prev_sess_id && prev_sess_id != sess->id)
-		destroy_previous_session(sess->user, prev_sess_id);
+		destroy_previous_session(conn, sess->user, prev_sess_id);
 
 	if (sess->state == SMB2_SESSION_VALID)
 		ksmbd_free_user(sess->user);
@@ -1664,7 +1666,9 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 		rsp->hdr.SessionId = cpu_to_le64(sess->id);
-		ksmbd_session_register(conn, sess);
+		rc = ksmbd_session_register(conn, sess);
+		if (rc)
+			goto out_err;
 	} else if (conn->dialect >= SMB30_PROT_ID &&
 		   (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   req->Flags & SMB2_SESSION_REQ_FLAG_BINDING) {
@@ -1845,6 +1849,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
+			xa_erase(&conn->sessions, sess->id);
 			ksmbd_session_destroy(sess);
 			work->sess = NULL;
 			if (try_delay)
-- 
2.39.2



