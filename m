Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D1B7036E0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbjEOROq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbjEORO1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186C3DDBD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E04E562B95
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E4DC433EF;
        Mon, 15 May 2023 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170771;
        bh=jdE4W9sWacXA89HjHKlWdnHP9Iwudj0NT5QRXnKOz/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQjrPhaVCsHS+0Far2moV41gElks3MmhSismVaZQ7MqcQ9F0ZvLdpBZul5FIBfYHY
         hdqY/F5oyF2uJSeabvvzQroge9WF71w/j4bTgCWNTkt6yFvKvEHvAslb4yGMwTDYri
         dQ+bw63r9g/b6rzufjcfUG78xLJPpNErw29+CGJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dawei Li <set_pte_at@outlook.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 212/239] ksmbd: Implements sess->ksmbd_chann_list as xarray
Date:   Mon, 15 May 2023 18:27:55 +0200
Message-Id: <20230515161728.087986944@linuxfoundation.org>
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

From: Dawei Li <set_pte_at@outlook.com>

[ Upstream commit 1d9c4172110e645b383ff13eee759728d74f1a5d ]

For some ops on channel:
1. lookup_chann_list(), possibly on high frequency.
2. ksmbd_chann_del().

Connection is used as indexing key to lookup channel, in that case,
linear search based on list may suffer a bit for performance.

Implements sess->ksmbd_chann_list as xarray.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f5c779b7ddbd ("ksmbd: fix racy issue from session setup and logoff")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/mgmt/user_session.c | 61 ++++++++++++++----------------------
 fs/ksmbd/mgmt/user_session.h |  4 +--
 fs/ksmbd/smb2pdu.c           | 34 +++-----------------
 3 files changed, 30 insertions(+), 69 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 92b1603b5abeb..a2b128dedcfcf 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -30,15 +30,15 @@ struct ksmbd_session_rpc {
 
 static void free_channel_list(struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
+	struct channel *chann;
+	unsigned long index;
 
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		list_del(&chann->chann_list);
+	xa_for_each(&sess->ksmbd_chann_list, index, chann) {
+		xa_erase(&sess->ksmbd_chann_list, index);
 		kfree(chann);
 	}
-	write_unlock(&sess->chann_lock);
+
+	xa_destroy(&sess->ksmbd_chann_list);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -190,21 +190,15 @@ int ksmbd_session_register(struct ksmbd_conn *conn,
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
-
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		if (chann->conn == conn) {
-			list_del(&chann->chann_list);
-			kfree(chann);
-			write_unlock(&sess->chann_lock);
-			return 0;
-		}
-	}
-	write_unlock(&sess->chann_lock);
+	struct channel *chann;
+
+	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	if (!chann)
+		return -ENOENT;
 
-	return -ENOENT;
+	kfree(chann);
+
+	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
@@ -234,7 +228,7 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 	return;
 
 sess_destroy:
-	if (list_empty(&sess->ksmbd_chann_list)) {
+	if (xa_empty(&sess->ksmbd_chann_list)) {
 		xa_erase(&conn->sessions, sess->id);
 		ksmbd_session_destroy(sess);
 	}
@@ -320,6 +314,9 @@ static struct ksmbd_session *__session_create(int protocol)
 	struct ksmbd_session *sess;
 	int ret;
 
+	if (protocol != CIFDS_SESSION_FLAG_SMB2)
+		return NULL;
+
 	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
 	if (!sess)
 		return NULL;
@@ -329,30 +326,20 @@ static struct ksmbd_session *__session_create(int protocol)
 
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
-	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
+	xa_init(&sess->ksmbd_chann_list);
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
-	rwlock_init(&sess->chann_lock);
-
-	switch (protocol) {
-	case CIFDS_SESSION_FLAG_SMB2:
-		ret = __init_smb2_session(sess);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
 
+	ret = __init_smb2_session(sess);
 	if (ret)
 		goto error;
 
 	ida_init(&sess->tree_conn_ida);
 
-	if (protocol == CIFDS_SESSION_FLAG_SMB2) {
-		down_write(&sessions_table_lock);
-		hash_add(sessions_table, &sess->hlist, sess->id);
-		up_write(&sessions_table_lock);
-	}
+	down_write(&sessions_table_lock);
+	hash_add(sessions_table, &sess->hlist, sess->id);
+	up_write(&sessions_table_lock);
+
 	return sess;
 
 error:
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 8934b8ee275ba..44a3c67b2bd92 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -21,7 +21,6 @@ struct ksmbd_file_table;
 struct channel {
 	__u8			smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	struct ksmbd_conn	*conn;
-	struct list_head	chann_list;
 };
 
 struct preauth_session {
@@ -50,8 +49,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
-	rwlock_t			chann_lock;
-	struct list_head		ksmbd_chann_list;
+	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
 	struct list_head		rpc_handle_list;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index acd66fb40c5f0..ac79d4c86067f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -74,14 +74,7 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)
 
 struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
 {
-	struct channel *chann;
-
-	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
-		if (chann->conn == conn)
-			return chann;
-	}
-
-	return NULL;
+	return xa_load(&sess->ksmbd_chann_list, (long)conn);
 }
 
 /**
@@ -592,6 +585,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
 	struct channel *chann;
+	long index;
 
 	if (!prev_sess)
 		return;
@@ -605,10 +599,8 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 		return;
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
-	write_lock(&prev_sess->chann_lock);
-	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
+	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
 		chann->conn->status = KSMBD_SESS_EXITING;
-	write_unlock(&prev_sess->chann_lock);
 }
 
 /**
@@ -1520,19 +1512,14 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1606,19 +1593,14 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	}
 
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -8428,14 +8410,11 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return 0;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key) {
@@ -8495,14 +8474,11 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, work->conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key)
-- 
2.39.2



