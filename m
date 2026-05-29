Return-Path: <stable+bounces-256706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM/GH2rcGWpGzggAu9opvQ
	(envelope-from <stable+bounces-256706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3C760749A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 536B83019C8D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B03C277E;
	Fri, 29 May 2026 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P96gk8RK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25430F815
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079716; cv=none; b=lBsp69FtMhQ9hXIVO9fb1sIxOr8B5hTvIZrH5SEK337OGMu+HumjtbVHNqovFrOaWkUcm/GYZ9aD50KtYc6BN4W+jVtXVuGYoJ7djjWaQkZM/GVVGTK0AV3/r7gRkfPsX1fr+bzG5X88KqIDHBfZigipypv3Xy4t0HhPy2lt6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079716; c=relaxed/simple;
	bh=eVoAMIF20NgICz59PPwI8AMnS2JRWReqO1T0BLm63Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXhvtAN26AFjjfdWPgmlO2vlTyU8IusXg6CXZPbzw6iiKuJJoCIWhDFGTC/reEtbKuA5ZO0rJaOJcBWxBckcyXUfUVDLy4zLph3gHXIUoBhRUrxwIvNgMQbEXLKf7aei34ggBoFV9ucZiwT/rcmY6t2YV2aRbruqr4UtfDTU5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P96gk8RK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296F41F00893;
	Fri, 29 May 2026 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780079712;
	bh=/P82pAqsqOvpIS8G2DMDRhlKO3GjVn21auIVS5vXJeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P96gk8RKySqHSagL6IBkgwZKg6wuDVF5RCmpCFQZq1ItzkRhmoUNogiSdBDodYztL
	 AwK77E8EJDbhMSJNwEeoKZf0DfsDmvdYBmTHORjkV7Mj73oldIZwo4wQ9f1o6fFdQq
	 Y/7puLs4iuc432g+fuLCYuuS1ZVIN2asnwpEm5csISEJso2dp7lxSyrtyN94A8F5w1
	 mxp3fkpXHuQaOeIRFq2MkN2cWbaBHtpmdbFKQbxLjXdXKpf7LlckMTPafEDZW2IZLv
	 jl40qgu6Hv+5FPS4JG8VLyFqWyON5PliBvkDHvFBz09M4so8hqACu2z0/JdYCyZlgJ
	 QL6qziEhZ2jlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
Date: Fri, 29 May 2026 14:35:06 -0400
Message-ID: <20260529183508.1594050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052807-twenty-relish-478b@gregkh>
References: <2026052807-twenty-relish-478b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256706-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,auristor.com:email,sashiko.dev:url,msgid.link:url,infradead.org:email,oracle.com:email]
X-Rspamd-Queue-Id: EE3C760749A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2b50aceafe6606ea52ed42aadd1b4d44a188aade ]

Change the krb5 crypto library to provide facilities to precheck the length
of the message about to be decrypted or verified.

Fix AF_RXRPC to make use of this to validate DATA packets secured with
RxGK.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Closes: https://sashiko.dev/#/patchset/20260511160753.607296-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: Simon Horman <horms@kernel.org>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: linux-afs@lists.infradead.org
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Link: https://patch.msgid.link/20260515230516.2718212-2-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8bfab4b6ffc2 ("rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/crypto/krb5.rst | 17 ++++++++---
 crypto/krb5/krb5_api.c        | 54 +++++++++++++++++++++++++++++++----
 include/crypto/krb5.h         |  9 ++++--
 include/trace/events/rxrpc.h  |  1 +
 net/rxrpc/rxgk.c              | 15 ++++++++--
 5 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/Documentation/crypto/krb5.rst b/Documentation/crypto/krb5.rst
index beffa0133446d..f62e07ac68114 100644
--- a/Documentation/crypto/krb5.rst
+++ b/Documentation/crypto/krb5.rst
@@ -158,13 +158,22 @@ returned.
 When a message has been received, the location and size of the data with the
 message can be determined by calling::
 
-	void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
-					   enum krb5_crypto_mode mode,
-					   size_t *_offset, size_t *_len);
+	int crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
+					  enum krb5_crypto_mode mode,
+					  size_t *_offset, size_t *_len);
 
 The caller provides the offset and length of the message to the function, which
 then alters those values to indicate the region containing the data (plus any
-padding).  It is up to the caller to determine how much padding there is.
+padding).  It is up to the caller to determine how much padding there is.  The
+function returns an error if the length is too small or if the mode is
+unsupported.  An additional function::
+
+	int crypto_krb5_check_data_len(const struct krb5_enctype *krb5,
+				       enum krb5_crypto_mode mode,
+				       size_t len, size_t min_content);
+
+is provided to just do a basic check that the decrypted/verified message would
+have a sufficient minimum payload.
 
 Preparation Functions
 ---------------------
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 23026d4206c82..c7ea40f900a77 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -134,27 +134,69 @@ EXPORT_SYMBOL(crypto_krb5_how_much_data);
  * Find the offset and size of the data in a secure message so that this
  * information can be used in the metadata buffer which will get added to the
  * digest by crypto_krb5_verify_mic().
+ *
+ * Return: 0 if successful, -EBADMSG if the message is too short or -EINVAL if
+ * the mode is unsupported.
  */
-void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
-				   enum krb5_crypto_mode mode,
-				   size_t *_offset, size_t *_len)
+int crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
+				  enum krb5_crypto_mode mode,
+				  size_t *_offset, size_t *_len)
 {
 	switch (mode) {
 	case KRB5_CHECKSUM_MODE:
+		if (*_len < krb5->cksum_len)
+			return -EBADMSG;
 		*_offset += krb5->cksum_len;
 		*_len -= krb5->cksum_len;
-		return;
+		return 0;
 	case KRB5_ENCRYPT_MODE:
+		if (*_len < krb5->conf_len + krb5->cksum_len)
+			return -EBADMSG;
 		*_offset += krb5->conf_len;
 		*_len -= krb5->conf_len + krb5->cksum_len;
-		return;
+		return 0;
 	default:
 		WARN_ON_ONCE(1);
-		return;
+		return -EINVAL;
 	}
 }
 EXPORT_SYMBOL(crypto_krb5_where_is_the_data);
 
+/**
+ * crypto_krb5_check_data_len - Check a message is big enough
+ * @krb5: The encoding to use.
+ * @mode: Mode of operation.
+ * @len: The length of the secure blob.
+ * @min_content: Minimum length of the content inside the blob.
+ *
+ * Check that a message is large enough to hold whatever bits the encryption
+ * type wants to glue on (nonce, checksum) plus a minimum amount of content.
+ *
+ * Return: 0 if successful, -EBADMSG if the message is too short or -EINVAL if
+ * the mode is unsupported.
+ */
+int crypto_krb5_check_data_len(const struct krb5_enctype *krb5,
+			       enum krb5_crypto_mode mode,
+			       size_t len, size_t min_content)
+{
+	switch (mode) {
+	case KRB5_CHECKSUM_MODE:
+		if (len < krb5->cksum_len ||
+		    len - krb5->cksum_len < min_content)
+			return -EBADMSG;
+		return 0;
+	case KRB5_ENCRYPT_MODE:
+		if (len < krb5->conf_len + krb5->cksum_len ||
+		    len - (krb5->conf_len + krb5->cksum_len) < min_content)
+			return -EBADMSG;
+		return 0;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL(crypto_krb5_check_data_len);
+
 /*
  * Prepare the encryption with derived key data.
  */
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 71dd38f59be1d..aac3ecf88467c 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -121,9 +121,12 @@ size_t crypto_krb5_how_much_buffer(const struct krb5_enctype *krb5,
 size_t crypto_krb5_how_much_data(const struct krb5_enctype *krb5,
 				 enum krb5_crypto_mode mode,
 				 size_t *_buffer_size, size_t *_offset);
-void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
-				   enum krb5_crypto_mode mode,
-				   size_t *_offset, size_t *_len);
+int crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
+				  enum krb5_crypto_mode mode,
+				  size_t *_offset, size_t *_len);
+int crypto_krb5_check_data_len(const struct krb5_enctype *krb5,
+			       enum krb5_crypto_mode mode,
+			       size_t len, size_t min_content);
 struct crypto_aead *crypto_krb5_prepare_encryption(const struct krb5_enctype *krb5,
 						   const struct krb5_buffer *TK,
 						   u32 usage, gfp_t gfp);
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 573f2df3a2c99..704a10de66700 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -71,6 +71,7 @@
 	EM(rxkad_abort_resp_unknown_tkt,	"rxkad-resp-unknown-tkt") \
 	EM(rxkad_abort_resp_version,		"rxkad-resp-version")	\
 	/* RxGK security errors */					\
+	EM(rxgk_abort_1_short_header,		"rxgk1-short-hdr")	\
 	EM(rxgk_abort_1_verify_mic_eproto,	"rxgk1-vfy-mic-eproto")	\
 	EM(rxgk_abort_2_decrypt_eproto,		"rxgk2-dec-eproto")	\
 	EM(rxgk_abort_2_short_data,		"rxgk2-short-data")	\
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index c39f5066d8e86..04a761c79548a 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -480,8 +480,12 @@ static int rxgk_verify_packet_integrity(struct rxrpc_call *call,
 
 	_enter("");
 
-	crypto_krb5_where_is_the_data(gk->krb5, KRB5_CHECKSUM_MODE,
-				      &data_offset, &data_len);
+	if (crypto_krb5_where_is_the_data(gk->krb5, KRB5_CHECKSUM_MODE,
+					  &data_offset, &data_len) < 0) {
+		ret = rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
+					 rxgk_abort_1_short_header);
+		goto put_gk;
+	}
 
 	hdr = kzalloc(sizeof(*hdr), GFP_NOFS);
 	if (!hdr)
@@ -529,6 +533,13 @@ static int rxgk_verify_packet_encrypted(struct rxrpc_call *call,
 
 	_enter("");
 
+	if (crypto_krb5_check_data_len(gk->krb5, KRB5_ENCRYPT_MODE,
+				       len, sizeof(hdr)) < 0) {
+		ret = rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
+					 rxgk_abort_2_short_header);
+		goto error;
+	}
+
 	ret = rxgk_decrypt_skb(gk->krb5, gk->rx_enc, skb, &offset, &len, &ac);
 	if (ret < 0) {
 		if (ret != -ENOMEM)
-- 
2.53.0


