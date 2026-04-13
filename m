Return-Path: <stable+bounces-236449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA3JNxAZ3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB73EEE54
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA0233025719
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681FE28505E;
	Mon, 13 Apr 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/MSF8NO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A45C9E;
	Mon, 13 Apr 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096934; cv=none; b=aqj/gZ0RPpGW/c4RjvqB+UwSyo0hCpS/T0HBFvrObF6i3G/VZk+7jmrm3hTJ6OuxOSskThGzp19AjUYJIqb2GcjQp4DuZJLkQ9Jjfh/GfqBnEYMTQUVCzackdO8DvcZ592y1nnwJhLMT9exY4kYh29rzhWDBYgXybkXznKixbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096934; c=relaxed/simple;
	bh=dOmeW7j0tQqlTzwM6q58uGGhxpIQopwABi9nHlf/9Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXxrkHAz3NYn/jbbZkp2tZuYUIObctzBUdXe7GDwM/8dNs2l3C904DxyUOfi+U3FtO6fm35y2JMbJ8MG3YeqC2JWeZM2xH6DsfLIZpog06yP5NweUd/rN7m2cakxkWzJK4XxfKvE/Aad//SX2ofJEwYMMd4kio68I+wuQeYVn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a/MSF8NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56EAC2BCAF;
	Mon, 13 Apr 2026 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096934;
	bh=dOmeW7j0tQqlTzwM6q58uGGhxpIQopwABi9nHlf/9Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/MSF8NOhkNP5hhmLoh2InCKkCgb1tO0p/DMTr2jiS3c3JQQYpZs7NQqnB8I6YFPC
	 6GJujM/sQcaReqqgWAslbhuUK9U2fWWmuk5/ZMFmrYL2GQ5FAa1kVWA26QJIjMHtDu
	 k+xXqvqV0TWGpzKCbAnIfw5A4hS4ZGKtuhy7hCco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 49/50] rxrpc: Fix missing error checks for rxkad encryption/decryption failure
Date: Mon, 13 Apr 2026 18:01:16 +0200
Message-ID: <20260413155726.341033999@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236449-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,infradead.org:email]
X-Rspamd-Queue-Id: 71CB73EEE54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit f93af41b9f5f798823d0d0fb8765c2a936d76270 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxkad.c |   57 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 19 deletions(-)

--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -189,6 +189,7 @@ static int rxkad_prime_packet_security(s
 	struct rxrpc_crypt iv;
 	__be32 *tmpbuf;
 	size_t tmpsize = 4 * sizeof(__be32);
+	int ret;
 
 	_enter("");
 
@@ -217,13 +218,13 @@ static int rxkad_prime_packet_security(s
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
@@ -256,6 +257,7 @@ static int rxkad_secure_packet_auth(cons
 	struct scatterlist sg;
 	size_t pad;
 	u16 check;
+	int ret;
 
 	_enter("");
 
@@ -278,11 +280,11 @@ static int rxkad_secure_packet_auth(cons
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
@@ -340,7 +342,7 @@ static int rxkad_secure_packet(struct rx
 	union {
 		__be32 buf[2];
 	} crypto __aligned(8);
-	u32 x, y;
+	u32 x, y = 0;
 	int ret;
 
 	_enter("{%d{%x}},{#%u},%u,",
@@ -371,8 +373,10 @@ static int rxkad_secure_packet(struct rx
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
@@ -395,6 +399,7 @@ static int rxkad_secure_packet(struct rx
 		break;
 	}
 
+out:
 	skcipher_request_free(req);
 	_leave(" = %d [set %x]", ret, y);
 	return ret;
@@ -435,8 +440,10 @@ static int rxkad_verify_packet_1(struct
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
@@ -513,10 +520,14 @@ static int rxkad_verify_packet_2(struct
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
@@ -584,8 +595,10 @@ static int rxkad_verify_packet(struct rx
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
@@ -988,21 +1001,23 @@ static int rxkad_decrypt_ticket(struct r
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
 
@@ -1011,12 +1026,14 @@ static void rxkad_decrypt_response(struc
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
@@ -1109,7 +1126,9 @@ static int rxkad_verify_response(struct
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
-	rxkad_decrypt_response(conn, response, &session_key);
+	ret = rxkad_decrypt_response(conn, response, &session_key);
+	if (ret < 0)
+		goto temporary_error_free_ticket;
 
 	if (ntohl(response->encrypted.epoch) != conn->proto.epoch ||
 	    ntohl(response->encrypted.cid) != conn->proto.cid ||



