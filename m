Return-Path: <stable+bounces-236059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CETiNaHn3GmUYAkAu9opvQ
	(envelope-from <stable+bounces-236059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB1E3EC40A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9943070364
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDAC3C8726;
	Mon, 13 Apr 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lb2b5baA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7F3C7E0C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084662; cv=none; b=CRXPg3OueqoEbra6mUG+2Poy6RZ+2ufcMOV+WVqGMz3MXhsKAcCV7m3A/+28/yJaIQzos2mcDzhlkpddwJ2bzCdTAp0JdmbZN71UuZrF6ThIJs2PqTYMgBBqnF4jc7yaLeSLbH6l4+i1xiEMDj3yRpuI9gtKO9oZr1sj98/Q7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084662; c=relaxed/simple;
	bh=sGvvtPS384fhWiJeLqPElTuFqDyw6axjZdwXkfZus5Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q+p0gUbFdwSYZ86Ftocn0xG1RUyDp23DQ0jdEh7ZYaUy2jDwv2od2hl/kRxd41lklgH/HbIY5XmrwgRmU6jMK6h8sC23H+Fb2Y635qbet9C7QSrt6HWQf6jCEKd+w3haa/aRwe0u2qK9TPhxAvBW384YRbe1Q/hD/g9Gu4hpSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lb2b5baA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A67AC2BCAF;
	Mon, 13 Apr 2026 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776084661;
	bh=sGvvtPS384fhWiJeLqPElTuFqDyw6axjZdwXkfZus5Y=;
	h=Subject:To:Cc:From:Date:From;
	b=Lb2b5baALFlh2I58SdKvljx/djv/AmyXJ+EnMmLnQqPRjniARtSVstGfPL8D+mPAj
	 3NTx38C8VigNGhq8GoMgL6LMzfFsAXZfnrB8QFxqChsj4ehKBBA1C8C8RA6we0xF2a
	 4jAjmpMKLvnOvdGH/WvTkIElX+RCJu1FC3xVVDrQ=
Subject: FAILED: patch "[PATCH] rxrpc: Fix missing error checks for rxkad" failed to apply to 5.15-stable tree
To: dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:35:40 +0200
Message-ID: <2026041340-passivism-gutter-ee2d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236059-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,sashiko.dev:url,msgid.link:url,auristor.com:email]
X-Rspamd-Queue-Id: 3AB1E3EC40A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f93af41b9f5f798823d0d0fb8765c2a936d76270
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041340-passivism-gutter-ee2d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f93af41b9f5f798823d0d0fb8765c2a936d76270 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 8 Apr 2026 13:12:44 +0100
Subject: [PATCH] rxrpc: Fix missing error checks for rxkad
 encryption/decryption failure

Add error checking for failure of crypto_skcipher_en/decrypt() to various
rxkad function as the crypto functions can fail with ENOMEM at least.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Closes: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-17-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 0f79d694cb08..eb7f2769d2b1 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -197,6 +197,7 @@ static int rxkad_prime_packet_security(struct rxrpc_connection *conn,
 	struct rxrpc_crypt iv;
 	__be32 *tmpbuf;
 	size_t tmpsize = 4 * sizeof(__be32);
+	int ret;
 
 	_enter("");
 
@@ -225,13 +226,13 @@ static int rxkad_prime_packet_security(struct rxrpc_connection *conn,
 	skcipher_request_set_sync_tfm(req, ci);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, tmpsize, iv.x);
-	crypto_skcipher_encrypt(req);
+	ret = crypto_skcipher_encrypt(req);
 	skcipher_request_free(req);
 
 	memcpy(&conn->rxkad.csum_iv, tmpbuf + 2, sizeof(conn->rxkad.csum_iv));
 	kfree(tmpbuf);
-	_leave(" = 0");
-	return 0;
+	_leave(" = %d", ret);
+	return ret;
 }
 
 /*
@@ -264,6 +265,7 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 	struct scatterlist sg;
 	size_t pad;
 	u16 check;
+	int ret;
 
 	_enter("");
 
@@ -286,11 +288,11 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 	skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, 8, iv.x);
-	crypto_skcipher_encrypt(req);
+	ret = crypto_skcipher_encrypt(req);
 	skcipher_request_zero(req);
 
-	_leave(" = 0");
-	return 0;
+	_leave(" = %d", ret);
+	return ret;
 }
 
 /*
@@ -345,7 +347,7 @@ static int rxkad_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	union {
 		__be32 buf[2];
 	} crypto __aligned(8);
-	u32 x, y;
+	u32 x, y = 0;
 	int ret;
 
 	_enter("{%d{%x}},{#%u},%u,",
@@ -376,8 +378,10 @@ static int rxkad_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, 8, iv.x);
-	crypto_skcipher_encrypt(req);
+	ret = crypto_skcipher_encrypt(req);
 	skcipher_request_zero(req);
+	if (ret < 0)
+		goto out;
 
 	y = ntohl(crypto.buf[1]);
 	y = (y >> 16) & 0xffff;
@@ -413,6 +417,7 @@ static int rxkad_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		memset(p + txb->pkt_len, 0, gap);
 	}
 
+out:
 	skcipher_request_free(req);
 	_leave(" = %d [set %x]", ret, y);
 	return ret;
@@ -453,8 +458,10 @@ static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
 	skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, 8, iv.x);
-	crypto_skcipher_decrypt(req);
+	ret = crypto_skcipher_decrypt(req);
 	skcipher_request_zero(req);
+	if (ret < 0)
+		return ret;
 
 	/* Extract the decrypted packet length */
 	if (skb_copy_bits(skb, sp->offset, &sechdr, sizeof(sechdr)) < 0)
@@ -531,10 +538,14 @@ static int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
 	skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, sp->len, iv.x);
-	crypto_skcipher_decrypt(req);
+	ret = crypto_skcipher_decrypt(req);
 	skcipher_request_zero(req);
 	if (sg != _sg)
 		kfree(sg);
+	if (ret < 0) {
+		WARN_ON_ONCE(ret != -ENOMEM);
+		return ret;
+	}
 
 	/* Extract the decrypted packet length */
 	if (skb_copy_bits(skb, sp->offset, &sechdr, sizeof(sechdr)) < 0)
@@ -602,8 +613,10 @@ static int rxkad_verify_packet(struct rxrpc_call *call, struct sk_buff *skb)
 	skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, 8, iv.x);
-	crypto_skcipher_encrypt(req);
+	ret = crypto_skcipher_encrypt(req);
 	skcipher_request_zero(req);
+	if (ret < 0)
+		goto out;
 
 	y = ntohl(crypto.buf[1]);
 	cksum = (y >> 16) & 0xffff;
@@ -1077,21 +1090,23 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 /*
  * decrypt the response packet
  */
-static void rxkad_decrypt_response(struct rxrpc_connection *conn,
-				   struct rxkad_response *resp,
-				   const struct rxrpc_crypt *session_key)
+static int rxkad_decrypt_response(struct rxrpc_connection *conn,
+				  struct rxkad_response *resp,
+				  const struct rxrpc_crypt *session_key)
 {
 	struct skcipher_request *req = rxkad_ci_req;
 	struct scatterlist sg[1];
 	struct rxrpc_crypt iv;
+	int ret;
 
 	_enter(",,%08x%08x",
 	       ntohl(session_key->n[0]), ntohl(session_key->n[1]));
 
 	mutex_lock(&rxkad_ci_mutex);
-	if (crypto_sync_skcipher_setkey(rxkad_ci, session_key->x,
-					sizeof(*session_key)) < 0)
-		BUG();
+	ret = crypto_sync_skcipher_setkey(rxkad_ci, session_key->x,
+					  sizeof(*session_key));
+	if (ret < 0)
+		goto unlock;
 
 	memcpy(&iv, session_key, sizeof(iv));
 
@@ -1100,12 +1115,14 @@ static void rxkad_decrypt_response(struct rxrpc_connection *conn,
 	skcipher_request_set_sync_tfm(req, rxkad_ci);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, sizeof(resp->encrypted), iv.x);
-	crypto_skcipher_decrypt(req);
+	ret = crypto_skcipher_decrypt(req);
 	skcipher_request_zero(req);
 
+unlock:
 	mutex_unlock(&rxkad_ci_mutex);
 
 	_leave("");
+	return ret;
 }
 
 /*
@@ -1198,7 +1215,9 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
-	rxkad_decrypt_response(conn, response, &session_key);
+	ret = rxkad_decrypt_response(conn, response, &session_key);
+	if (ret < 0)
+		goto temporary_error_free_ticket;
 
 	if (ntohl(response->encrypted.epoch) != conn->proto.epoch ||
 	    ntohl(response->encrypted.cid) != conn->proto.cid ||


