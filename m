Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A1F7038B7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbjEOReS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbjEOReE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA814932
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A189A62D4D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E931C4339C;
        Mon, 15 May 2023 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171913;
        bh=IuT6VT8cO0s+LNNGeM2dvXeCDMlYaLoGJ6DUaWOCU7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xhC3srkjiv3ThytyUIMo7yy33O0sLO9V/PQwCSZcRAsg8e4lNRRDT2BJjaqRQ63ps
         IfclUiCo8BS0iDu7J9URG85w0IWmfp0Fn7SNpfdksmVhlfzoqXAYiosLCQl1ka8Aud
         PX9q19kuEUO81nGkLBeNDe6q7QpBrSnygRB6GEWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ziwei Xie <zw.xie@high-flyer.cn>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 111/134] ksmbd: fix multi session connection failure
Date:   Mon, 15 May 2023 18:29:48 +0200
Message-Id: <20230515161706.828233414@linuxfoundation.org>
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

[ Upstream commit ce53d365378cde71bb6596d79c257e600d951d29 ]

When RSS mode is enable, windows client do simultaneously send several
session requests to server. There is racy issue using
sess->ntlmssp.cryptkey on N connection : 1 session. So authetication
failed using wrong cryptkey on some session. This patch move cryptkey
to ksmbd_conn structure to use each cryptkey on connection.

Tested-by: Ziwei Xie <zw.xie@high-flyer.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 7b4323373d84 ("ksmbd: fix deadlock in ksmbd_find_crypto_ctx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/auth.c              | 27 ++++++++++++++-------------
 fs/ksmbd/auth.h              | 10 +++++-----
 fs/ksmbd/connection.h        |  7 +------
 fs/ksmbd/mgmt/user_session.h |  1 -
 fs/ksmbd/smb2pdu.c           |  8 ++++----
 5 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index b962b16e5aeb7..4867da417c23a 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -215,7 +215,7 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
  * Return:	0 on success, error number on error
  */
 int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
-		      int blen, char *domain_name)
+		      int blen, char *domain_name, char *cryptkey)
 {
 	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
 	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
@@ -256,7 +256,7 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
 		goto out;
 	}
 
-	memcpy(construct, sess->ntlmssp.cryptkey, CIFS_CRYPTO_KEY_SIZE);
+	memcpy(construct, cryptkey, CIFS_CRYPTO_KEY_SIZE);
 	memcpy(construct + CIFS_CRYPTO_KEY_SIZE, &ntlmv2->blob_signature, blen);
 
 	rc = crypto_shash_update(CRYPTO_HMACMD5(ctx), construct, len);
@@ -295,7 +295,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
  * Return:	0 on success, error number on error
  */
 int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
-				   int blob_len, struct ksmbd_session *sess)
+				   int blob_len, struct ksmbd_conn *conn,
+				   struct ksmbd_session *sess)
 {
 	char *domain_name;
 	unsigned int nt_off, dn_off;
@@ -325,7 +326,7 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 
 	/* TODO : use domain name that imported from configuration file */
 	domain_name = smb_strndup_from_utf16((const char *)authblob + dn_off,
-					     dn_len, true, sess->conn->local_nls);
+					     dn_len, true, conn->local_nls);
 	if (IS_ERR(domain_name))
 		return PTR_ERR(domain_name);
 
@@ -334,7 +335,7 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 		    domain_name);
 	ret = ksmbd_auth_ntlmv2(sess, (struct ntlmv2_resp *)((char *)authblob + nt_off),
 				nt_len - CIFS_ENCPWD_SIZE,
-				domain_name);
+				domain_name, conn->ntlmssp.cryptkey);
 	kfree(domain_name);
 	return ret;
 }
@@ -348,7 +349,7 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
  *
  */
 int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
-				  int blob_len, struct ksmbd_session *sess)
+				  int blob_len, struct ksmbd_conn *conn)
 {
 	if (blob_len < sizeof(struct negotiate_message)) {
 		ksmbd_debug(AUTH, "negotiate blob len %d too small\n",
@@ -362,7 +363,7 @@ int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
 		return -EINVAL;
 	}
 
-	sess->ntlmssp.client_flags = le32_to_cpu(negblob->NegotiateFlags);
+	conn->ntlmssp.client_flags = le32_to_cpu(negblob->NegotiateFlags);
 	return 0;
 }
 
@@ -376,14 +377,14 @@ int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
  */
 unsigned int
 ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
-				   struct ksmbd_session *sess)
+				   struct ksmbd_conn *conn)
 {
 	struct target_info *tinfo;
 	wchar_t *name;
 	__u8 *target_name;
 	unsigned int flags, blob_off, blob_len, type, target_info_len = 0;
 	int len, uni_len, conv_len;
-	int cflags = sess->ntlmssp.client_flags;
+	int cflags = conn->ntlmssp.client_flags;
 
 	memcpy(chgblob->Signature, NTLMSSP_SIGNATURE, 8);
 	chgblob->MessageType = NtLmChallenge;
@@ -404,7 +405,7 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 	if (cflags & NTLMSSP_REQUEST_TARGET)
 		flags |= NTLMSSP_REQUEST_TARGET;
 
-	if (sess->conn->use_spnego &&
+	if (conn->use_spnego &&
 	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
 		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
 
@@ -415,7 +416,7 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 		return -ENOMEM;
 
 	conv_len = smb_strtoUTF16((__le16 *)name, ksmbd_netbios_name(), len,
-				  sess->conn->local_nls);
+				  conn->local_nls);
 	if (conv_len < 0 || conv_len > len) {
 		kfree(name);
 		return -EINVAL;
@@ -431,8 +432,8 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 	chgblob->TargetName.BufferOffset = cpu_to_le32(blob_off);
 
 	/* Initialize random conn challenge */
-	get_random_bytes(sess->ntlmssp.cryptkey, sizeof(__u64));
-	memcpy(chgblob->Challenge, sess->ntlmssp.cryptkey,
+	get_random_bytes(conn->ntlmssp.cryptkey, sizeof(__u64));
+	memcpy(chgblob->Challenge, conn->ntlmssp.cryptkey,
 	       CIFS_CRYPTO_KEY_SIZE);
 
 	/* Add Target Information to security buffer */
diff --git a/fs/ksmbd/auth.h b/fs/ksmbd/auth.h
index 9c2d4badd05d1..95629651cf266 100644
--- a/fs/ksmbd/auth.h
+++ b/fs/ksmbd/auth.h
@@ -38,16 +38,16 @@ struct kvec;
 int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
 			unsigned int nvec, int enc);
 void ksmbd_copy_gss_neg_header(void *buf);
-int ksmbd_auth_ntlm(struct ksmbd_session *sess, char *pw_buf);
 int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
-		      int blen, char *domain_name);
+		      int blen, char *domain_name, char *cryptkey);
 int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
-				   int blob_len, struct ksmbd_session *sess);
+				   int blob_len, struct ksmbd_conn *conn,
+				   struct ksmbd_session *sess);
 int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
-				  int blob_len, struct ksmbd_session *sess);
+				  int blob_len, struct ksmbd_conn *conn);
 unsigned int
 ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
-				   struct ksmbd_session *sess);
+				   struct ksmbd_conn *conn);
 int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
 			    int in_len,	char *out_blob, int *out_len);
 int ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 4b15c5e673d92..f3367d7760d7e 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -72,12 +72,7 @@ struct ksmbd_conn {
 	int				connection_type;
 	struct ksmbd_stats		stats;
 	char				ClientGUID[SMB2_CLIENT_GUID_SIZE];
-	union {
-		/* pending trans request table */
-		struct trans_state	*recent_trans;
-		/* Used by ntlmssp */
-		char			*ntlmssp_cryptkey;
-	};
+	struct ntlmssp_auth		ntlmssp;
 
 	spinlock_t			llist_lock;
 	struct list_head		lock_list;
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 82289c3cbd2bc..e241f16a38512 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -45,7 +45,6 @@ struct ksmbd_session {
 	int				state;
 	__u8				*Preauth_HashValue;
 
-	struct ntlmssp_auth		ntlmssp;
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index c8c2b326ee042..bb8126deeaf29 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1316,7 +1316,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 	int sz, rc;
 
 	ksmbd_debug(SMB, "negotiate phase\n");
-	rc = ksmbd_decode_ntlmssp_neg_blob(negblob, negblob_len, work->sess);
+	rc = ksmbd_decode_ntlmssp_neg_blob(negblob, negblob_len, work->conn);
 	if (rc)
 		return rc;
 
@@ -1326,7 +1326,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 	memset(chgblob, 0, sizeof(struct challenge_message));
 
 	if (!work->conn->use_spnego) {
-		sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->sess);
+		sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->conn);
 		if (sz < 0)
 			return -ENOMEM;
 
@@ -1342,7 +1342,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 		return -ENOMEM;
 
 	chgblob = (struct challenge_message *)neg_blob;
-	sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->sess);
+	sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->conn);
 	if (sz < 0) {
 		rc = -ENOMEM;
 		goto out;
@@ -1480,7 +1480,7 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 		authblob = user_authblob(conn, req);
 		sz = le16_to_cpu(req->SecurityBufferLength);
-		rc = ksmbd_decode_ntlmssp_auth_blob(authblob, sz, sess);
+		rc = ksmbd_decode_ntlmssp_auth_blob(authblob, sz, conn, sess);
 		if (rc) {
 			set_user_flag(sess->user, KSMBD_USER_FLAG_BAD_PASSWORD);
 			ksmbd_debug(SMB, "authentication failed\n");
-- 
2.39.2



