Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553EA7038CD
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243545AbjEORfN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbjEORer (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:34:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FAF19BF9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:32:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC66762D73
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE12C433D2;
        Mon, 15 May 2023 17:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171972;
        bh=n/yqkdU4DVrmkvt3i6prlI1K6SNrHKF91WzGpZ4seo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RW5JCWAx1MxbW0rOpHLbGQiFRXTTpgsxIDXIY+lPfmcXhMxz9QToPMMNmaUhx/SV5
         rOQTZ6x9gx0ZnVQHhBJPecZ2SlJxbW9K3SdFHhgrEhINMoC80Up1e6a52LG+ECNUV6
         vZ9aXCPUmJFA3dgeom7nZuvMHZBLC8h2FehdFMLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 115/134] ksmbd: fix racy issue while destroying session on multichannel
Date:   Mon, 15 May 2023 18:29:52 +0200
Message-Id: <20230515161706.964691943@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

[ Upstream commit af7c39d971e43cd0af488729bca362427ad99488 ]

After multi-channel connection with windows, Several channels of
session are connected. Among them, if there is a problem in one channel,
Windows connects again after disconnecting the channel. In this process,
the session is released and a kernel oop can occurs while processing
requests to other channels. When the channel is disconnected, if other
channels still exist in the session after deleting the channel from
the channel list in the session, the session should not be released.
Finally, the session will be released after all channels are disconnected.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 7b4323373d84 ("ksmbd: fix deadlock in ksmbd_find_crypto_ctx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/auth.c              | 56 ++++++++++++++++--------------
 fs/ksmbd/auth.h              | 11 +++---
 fs/ksmbd/connection.h        |  7 ----
 fs/ksmbd/mgmt/tree_connect.c |  5 +--
 fs/ksmbd/mgmt/tree_connect.h |  4 ++-
 fs/ksmbd/mgmt/user_session.c | 67 ++++++++++++++++++++++++------------
 fs/ksmbd/mgmt/user_session.h |  7 ++--
 fs/ksmbd/oplock.c            | 11 +++---
 fs/ksmbd/smb2pdu.c           | 21 +++++------
 fs/ksmbd/smb_common.h        |  2 +-
 fs/ksmbd/vfs.c               |  3 +-
 fs/ksmbd/vfs_cache.c         |  2 +-
 12 files changed, 110 insertions(+), 86 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 4867da417c23a..c1408e922fc6b 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -120,8 +120,8 @@ static int ksmbd_gen_sess_key(struct ksmbd_session *sess, char *hash,
 	return rc;
 }
 
-static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
-			    char *dname)
+static int calc_ntlmv2_hash(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+			    char *ntlmv2_hash, char *dname)
 {
 	int ret, len, conv_len;
 	wchar_t *domain = NULL;
@@ -157,7 +157,7 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
 	}
 
 	conv_len = smb_strtoUTF16(uniname, user_name(sess->user), len,
-				  sess->conn->local_nls);
+				  conn->local_nls);
 	if (conv_len < 0 || conv_len > len) {
 		ret = -EINVAL;
 		goto out;
@@ -181,7 +181,7 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
 	}
 
 	conv_len = smb_strtoUTF16((__le16 *)domain, dname, len,
-				  sess->conn->local_nls);
+				  conn->local_nls);
 	if (conv_len < 0 || conv_len > len) {
 		ret = -EINVAL;
 		goto out;
@@ -214,8 +214,9 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
  *
  * Return:	0 on success, error number on error
  */
-int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
-		      int blen, char *domain_name, char *cryptkey)
+int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+		      struct ntlmv2_resp *ntlmv2, int blen, char *domain_name,
+		      char *cryptkey)
 {
 	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
 	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
@@ -229,7 +230,7 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
 		return -ENOMEM;
 	}
 
-	rc = calc_ntlmv2_hash(sess, ntlmv2_hash, domain_name);
+	rc = calc_ntlmv2_hash(conn, sess, ntlmv2_hash, domain_name);
 	if (rc) {
 		ksmbd_debug(AUTH, "could not get v2 hash rc %d\n", rc);
 		goto out;
@@ -333,7 +334,8 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 	/* process NTLMv2 authentication */
 	ksmbd_debug(AUTH, "decode_ntlmssp_authenticate_blob dname%s\n",
 		    domain_name);
-	ret = ksmbd_auth_ntlmv2(sess, (struct ntlmv2_resp *)((char *)authblob + nt_off),
+	ret = ksmbd_auth_ntlmv2(conn, sess,
+				(struct ntlmv2_resp *)((char *)authblob + nt_off),
 				nt_len - CIFS_ENCPWD_SIZE,
 				domain_name, conn->ntlmssp.cryptkey);
 	kfree(domain_name);
@@ -633,8 +635,9 @@ struct derivation {
 	bool binding;
 };
 
-static int generate_key(struct ksmbd_session *sess, struct kvec label,
-			struct kvec context, __u8 *key, unsigned int key_size)
+static int generate_key(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+			struct kvec label, struct kvec context, __u8 *key,
+			unsigned int key_size)
 {
 	unsigned char zero = 0x0;
 	__u8 i[4] = {0, 0, 0, 1};
@@ -694,8 +697,8 @@ static int generate_key(struct ksmbd_session *sess, struct kvec label,
 		goto smb3signkey_ret;
 	}
 
-	if (sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
-	    sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
 		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L256, 4);
 	else
 		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L128, 4);
@@ -730,17 +733,17 @@ static int generate_smb3signingkey(struct ksmbd_session *sess,
 	if (!chann)
 		return 0;
 
-	if (sess->conn->dialect >= SMB30_PROT_ID && signing->binding)
+	if (conn->dialect >= SMB30_PROT_ID && signing->binding)
 		key = chann->smb3signingkey;
 	else
 		key = sess->smb3signingkey;
 
-	rc = generate_key(sess, signing->label, signing->context, key,
+	rc = generate_key(conn, sess, signing->label, signing->context, key,
 			  SMB3_SIGN_KEY_SIZE);
 	if (rc)
 		return rc;
 
-	if (!(sess->conn->dialect >= SMB30_PROT_ID && signing->binding))
+	if (!(conn->dialect >= SMB30_PROT_ID && signing->binding))
 		memcpy(chann->smb3signingkey, key, SMB3_SIGN_KEY_SIZE);
 
 	ksmbd_debug(AUTH, "dumping generated AES signing keys\n");
@@ -794,30 +797,31 @@ struct derivation_twin {
 	struct derivation decryption;
 };
 
-static int generate_smb3encryptionkey(struct ksmbd_session *sess,
+static int generate_smb3encryptionkey(struct ksmbd_conn *conn,
+				      struct ksmbd_session *sess,
 				      const struct derivation_twin *ptwin)
 {
 	int rc;
 
-	rc = generate_key(sess, ptwin->encryption.label,
+	rc = generate_key(conn, sess, ptwin->encryption.label,
 			  ptwin->encryption.context, sess->smb3encryptionkey,
 			  SMB3_ENC_DEC_KEY_SIZE);
 	if (rc)
 		return rc;
 
-	rc = generate_key(sess, ptwin->decryption.label,
+	rc = generate_key(conn, sess, ptwin->decryption.label,
 			  ptwin->decryption.context,
 			  sess->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE);
 	if (rc)
 		return rc;
 
 	ksmbd_debug(AUTH, "dumping generated AES encryption keys\n");
-	ksmbd_debug(AUTH, "Cipher type   %d\n", sess->conn->cipher_type);
+	ksmbd_debug(AUTH, "Cipher type   %d\n", conn->cipher_type);
 	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
 	ksmbd_debug(AUTH, "Session Key   %*ph\n",
 		    SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
-	if (sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
-	    sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
 		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
 			    SMB3_GCM256_CRYPTKEY_SIZE, sess->smb3encryptionkey);
 		ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
@@ -831,7 +835,8 @@ static int generate_smb3encryptionkey(struct ksmbd_session *sess,
 	return 0;
 }
 
-int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess)
+int ksmbd_gen_smb30_encryptionkey(struct ksmbd_conn *conn,
+				  struct ksmbd_session *sess)
 {
 	struct derivation_twin twin;
 	struct derivation *d;
@@ -848,10 +853,11 @@ int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess)
 	d->context.iov_base = "ServerIn ";
 	d->context.iov_len = 10;
 
-	return generate_smb3encryptionkey(sess, &twin);
+	return generate_smb3encryptionkey(conn, sess, &twin);
 }
 
-int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess)
+int ksmbd_gen_smb311_encryptionkey(struct ksmbd_conn *conn,
+				   struct ksmbd_session *sess)
 {
 	struct derivation_twin twin;
 	struct derivation *d;
@@ -868,7 +874,7 @@ int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess)
 	d->context.iov_base = sess->Preauth_HashValue;
 	d->context.iov_len = 64;
 
-	return generate_smb3encryptionkey(sess, &twin);
+	return generate_smb3encryptionkey(conn, sess, &twin);
 }
 
 int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
diff --git a/fs/ksmbd/auth.h b/fs/ksmbd/auth.h
index 95629651cf266..25b772653de0a 100644
--- a/fs/ksmbd/auth.h
+++ b/fs/ksmbd/auth.h
@@ -38,8 +38,9 @@ struct kvec;
 int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
 			unsigned int nvec, int enc);
 void ksmbd_copy_gss_neg_header(void *buf);
-int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
-		      int blen, char *domain_name, char *cryptkey);
+int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+		      struct ntlmv2_resp *ntlmv2, int blen, char *domain_name,
+		      char *cryptkey);
 int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 				   int blob_len, struct ksmbd_conn *conn,
 				   struct ksmbd_session *sess);
@@ -58,8 +59,10 @@ int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess,
 			       struct ksmbd_conn *conn);
 int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess,
 				struct ksmbd_conn *conn);
-int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess);
-int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess);
+int ksmbd_gen_smb30_encryptionkey(struct ksmbd_conn *conn,
+				  struct ksmbd_session *sess);
+int ksmbd_gen_smb311_encryptionkey(struct ksmbd_conn *conn,
+				   struct ksmbd_session *sess);
 int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
 				     __u8 *pi_hash);
 int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 7838cc46497d6..89eb41bbd1601 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -20,13 +20,6 @@
 
 #define KSMBD_SOCKET_BACKLOG		16
 
-/*
- * WARNING
- *
- * This is nothing but a HACK. Session status should move to channel
- * or to session. As of now we have 1 tcp_conn : 1 ksmbd_session, but
- * we need to change it to 1 tcp_conn : N ksmbd_sessions.
- */
 enum {
 	KSMBD_SESS_NEW = 0,
 	KSMBD_SESS_GOOD,
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index 940385c6a9135..dd262daa2c4a5 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -16,7 +16,8 @@
 #include "user_session.h"
 
 struct ksmbd_tree_conn_status
-ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name)
+ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+			char *share_name)
 {
 	struct ksmbd_tree_conn_status status = {-ENOENT, NULL};
 	struct ksmbd_tree_connect_response *resp = NULL;
@@ -41,7 +42,7 @@ ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name)
 		goto out_error;
 	}
 
-	peer_addr = KSMBD_TCP_PEER_SOCKADDR(sess->conn);
+	peer_addr = KSMBD_TCP_PEER_SOCKADDR(conn);
 	resp = ksmbd_ipc_tree_connect_request(sess,
 					      sc,
 					      tree_conn,
diff --git a/fs/ksmbd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
index 18e2a996e0aab..71e50271dccf0 100644
--- a/fs/ksmbd/mgmt/tree_connect.h
+++ b/fs/ksmbd/mgmt/tree_connect.h
@@ -12,6 +12,7 @@
 
 struct ksmbd_share_config;
 struct ksmbd_user;
+struct ksmbd_conn;
 
 struct ksmbd_tree_connect {
 	int				id;
@@ -40,7 +41,8 @@ static inline int test_tree_conn_flag(struct ksmbd_tree_connect *tree_conn,
 struct ksmbd_session;
 
 struct ksmbd_tree_conn_status
-ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name);
+ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
+			char *share_name);
 
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 			       struct ksmbd_tree_connect *tree_conn);
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 9c4a9c8c02795..92b1603b5abeb 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -153,9 +153,6 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 	if (!sess)
 		return;
 
-	if (!atomic_dec_and_test(&sess->refcnt))
-		return;
-
 	down_write(&sessions_table_lock);
 	hash_del(&sess->hlist);
 	up_write(&sessions_table_lock);
@@ -186,16 +183,58 @@ static struct ksmbd_session *__session_lookup(unsigned long long id)
 int ksmbd_session_register(struct ksmbd_conn *conn,
 			   struct ksmbd_session *sess)
 {
-	sess->conn = conn;
+	sess->dialect = conn->dialect;
+	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
+static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
+{
+	struct channel *chann, *tmp;
+
+	write_lock(&sess->chann_lock);
+	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
+				 chann_list) {
+		if (chann->conn == conn) {
+			list_del(&chann->chann_list);
+			kfree(chann);
+			write_unlock(&sess->chann_lock);
+			return 0;
+		}
+	}
+	write_unlock(&sess->chann_lock);
+
+	return -ENOENT;
+}
+
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 {
 	struct ksmbd_session *sess;
-	unsigned long id;
 
-	xa_for_each(&conn->sessions, id, sess) {
+	if (conn->binding) {
+		int bkt;
+
+		down_write(&sessions_table_lock);
+		hash_for_each(sessions_table, bkt, sess, hlist) {
+			if (!ksmbd_chann_del(conn, sess)) {
+				up_write(&sessions_table_lock);
+				goto sess_destroy;
+			}
+		}
+		up_write(&sessions_table_lock);
+	} else {
+		unsigned long id;
+
+		xa_for_each(&conn->sessions, id, sess) {
+			if (!ksmbd_chann_del(conn, sess))
+				goto sess_destroy;
+		}
+	}
+
+	return;
+
+sess_destroy:
+	if (list_empty(&sess->ksmbd_chann_list)) {
 		xa_erase(&conn->sessions, sess->id);
 		ksmbd_session_destroy(sess);
 	}
@@ -207,27 +246,12 @@ struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 	return xa_load(&conn->sessions, id);
 }
 
-int get_session(struct ksmbd_session *sess)
-{
-	return atomic_inc_not_zero(&sess->refcnt);
-}
-
-void put_session(struct ksmbd_session *sess)
-{
-	if (atomic_dec_and_test(&sess->refcnt))
-		pr_err("get/%s seems to be mismatched.", __func__);
-}
-
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 {
 	struct ksmbd_session *sess;
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
-	if (sess) {
-		if (!get_session(sess))
-			sess = NULL;
-	}
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -308,7 +332,6 @@ static struct ksmbd_session *__session_create(int protocol)
 	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
-	atomic_set(&sess->refcnt, 1);
 	rwlock_init(&sess->chann_lock);
 
 	switch (protocol) {
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 1ec659f0151bf..8934b8ee275ba 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -33,8 +33,10 @@ struct preauth_session {
 struct ksmbd_session {
 	u64				id;
 
+	__u16				dialect;
+	char				ClientGUID[SMB2_CLIENT_GUID_SIZE];
+
 	struct ksmbd_user		*user;
-	struct ksmbd_conn		*conn;
 	unsigned int			sequence_number;
 	unsigned int			flags;
 
@@ -59,7 +61,6 @@ struct ksmbd_session {
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
 	struct ksmbd_file_table		file_table;
-	atomic_t			refcnt;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
@@ -100,6 +101,4 @@ void ksmbd_release_tree_conn_id(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name);
 void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id);
-int get_session(struct ksmbd_session *sess);
-void put_session(struct ksmbd_session *sess);
 #endif /* __USER_SESSION_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index f9dae6ef21150..3f759f9123ea7 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -30,6 +30,7 @@ static DEFINE_RWLOCK(lease_list_lock);
 static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
 					u64 id, __u16 Tid)
 {
+	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	struct oplock_info *opinfo;
 
@@ -38,7 +39,7 @@ static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
 		return NULL;
 
 	opinfo->sess = sess;
-	opinfo->conn = sess->conn;
+	opinfo->conn = conn;
 	opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	opinfo->pending_break = 0;
@@ -972,7 +973,7 @@ int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 	}
 
 	list_for_each_entry(lb, &lease_table_list, l_entry) {
-		if (!memcmp(lb->client_guid, sess->conn->ClientGUID,
+		if (!memcmp(lb->client_guid, sess->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE))
 			goto found;
 	}
@@ -988,7 +989,7 @@ int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 		rcu_read_unlock();
 		if (opinfo->o_fp->f_ci == ci)
 			goto op_next;
-		err = compare_guid_key(opinfo, sess->conn->ClientGUID,
+		err = compare_guid_key(opinfo, sess->ClientGUID,
 				       lctx->lease_key);
 		if (err) {
 			err = -EINVAL;
@@ -1122,7 +1123,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 		struct oplock_info *m_opinfo;
 
 		/* is lease already granted ? */
-		m_opinfo = same_client_has_lease(ci, sess->conn->ClientGUID,
+		m_opinfo = same_client_has_lease(ci, sess->ClientGUID,
 						 lctx);
 		if (m_opinfo) {
 			copy_lease(m_opinfo, opinfo);
@@ -1240,7 +1241,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 {
 	struct oplock_info *op, *brk_op;
 	struct ksmbd_inode *ci;
-	struct ksmbd_conn *conn = work->sess->conn;
+	struct ksmbd_conn *conn = work->conn;
 
 	if (!test_share_config_flag(work->tcon->share_conf,
 				    KSMBD_SHARE_FLAG_OPLOCKS))
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 8bfe2a6c05f92..61d6d4b6b56ac 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -610,12 +610,9 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 	if (!prev_user ||
 	    strcmp(user->name, prev_user->name) ||
 	    user->passkey_sz != prev_user->passkey_sz ||
-	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz)) {
-		put_session(prev_sess);
+	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz))
 		return;
-	}
 
-	put_session(prev_sess);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 	write_lock(&prev_sess->chann_lock);
 	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
@@ -1512,7 +1509,7 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 	if (smb3_encryption_negotiated(conn) &&
 			!(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
-		rc = conn->ops->generate_encryptionkey(sess);
+		rc = conn->ops->generate_encryptionkey(conn, sess);
 		if (rc) {
 			ksmbd_debug(SMB,
 					"SMB3 encryption key generation failed\n");
@@ -1604,7 +1601,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 		sess->sign = true;
 
 	if (smb3_encryption_negotiated(conn)) {
-		retval = conn->ops->generate_encryptionkey(sess);
+		retval = conn->ops->generate_encryptionkey(conn, sess);
 		if (retval) {
 			ksmbd_debug(SMB,
 				    "SMB3 encryption key generation failed\n");
@@ -1692,7 +1689,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
-		if (conn->dialect != sess->conn->dialect) {
+		if (conn->dialect != sess->dialect) {
 			rc = -EINVAL;
 			goto out_err;
 		}
@@ -1702,7 +1699,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
-		if (strncmp(conn->ClientGUID, sess->conn->ClientGUID,
+		if (strncmp(conn->ClientGUID, sess->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE)) {
 			rc = -ENOENT;
 			goto out_err;
@@ -1907,7 +1904,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "tree connect request for tree %s treename %s\n",
 		    name, treename);
 
-	status = ksmbd_tree_conn_connect(sess, name);
+	status = ksmbd_tree_conn_connect(conn, sess, name);
 	if (status.ret == KSMBD_TREE_CONN_STATUS_OK)
 		rsp->hdr.Id.SyncId.TreeId = cpu_to_le32(status.tree_conn->id);
 	else
@@ -4895,7 +4892,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 				    struct smb2_query_info_rsp *rsp, void *rsp_org)
 {
 	struct ksmbd_session *sess = work->sess;
-	struct ksmbd_conn *conn = sess->conn;
+	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_share_config *share = work->tcon->share_conf;
 	int fsinfoclass = 0;
 	struct kstatfs stfs;
@@ -5831,7 +5828,7 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 next:
 	return smb2_rename(work, fp, user_ns, rename_info,
-			   work->sess->conn->local_nls);
+			   work->conn->local_nls);
 }
 
 static int set_file_disposition_info(struct ksmbd_file *fp,
@@ -5965,7 +5962,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		return smb2_create_link(work, work->tcon->share_conf,
 					(struct smb2_file_link_info *)req->Buffer,
 					buf_len, fp->filp,
-					work->sess->conn->local_nls);
+					work->conn->local_nls);
 	}
 	case FILE_DISPOSITION_INFORMATION:
 	{
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index b9fe3fa149c2e..48cbaa0321400 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -454,7 +454,7 @@ struct smb_version_ops {
 	int (*check_sign_req)(struct ksmbd_work *work);
 	void (*set_sign_rsp)(struct ksmbd_work *work);
 	int (*generate_signingkey)(struct ksmbd_session *sess, struct ksmbd_conn *conn);
-	int (*generate_encryptionkey)(struct ksmbd_session *sess);
+	int (*generate_encryptionkey)(struct ksmbd_conn *conn, struct ksmbd_session *sess);
 	bool (*is_transform_hdr)(void *buf);
 	int (*decrypt_req)(struct ksmbd_work *work);
 	int (*encrypt_resp)(struct ksmbd_work *work);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 5d40a00fbce50..52cc6a9627ed7 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -483,12 +483,11 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written)
 {
-	struct ksmbd_session *sess = work->sess;
 	struct file *filp;
 	loff_t	offset = *pos;
 	int err = 0;
 
-	if (sess->conn->connection_type) {
+	if (work->conn->connection_type) {
 		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
 			pr_err("no right to write(%pd)\n",
 			       fp->filp->f_path.dentry);
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 8b873d92d7854..0df8467af39af 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -570,7 +570,7 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	atomic_set(&fp->refcount, 1);
 
 	fp->filp		= filp;
-	fp->conn		= work->sess->conn;
+	fp->conn		= work->conn;
 	fp->tcon		= work->tcon;
 	fp->volatile_id		= KSMBD_NO_FID;
 	fp->persistent_id	= KSMBD_NO_FID;
-- 
2.39.2



