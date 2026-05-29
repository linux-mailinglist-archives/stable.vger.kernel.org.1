Return-Path: <stable+bounces-256708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO2vEG3cGWpGzggAu9opvQ
	(envelope-from <stable+bounces-256708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:35:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32F6074A8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 838C13020131
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D6A410D06;
	Fri, 29 May 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnyS2I7z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1F409DE0
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079718; cv=none; b=GBk0y4lvFWBW25PWhBpUIzDCKGbMs90yRIclDntFIpVUYV9XvDm8r5Sn+jutyGxmDrBgZs8T3yDw6PlronezzcLm8Hy6fHKSoSm/kzsB5xwnpQX4+cjjen/Vm49yWgy9WMVCOHHqkQr+ITkxoLQTRNdjV1TyRPQY6kV0LFhhygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079718; c=relaxed/simple;
	bh=fZz664kVd/aQwbvVM94fjoLRS05hQvNcFIWp9rcb0+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er8S8vzhhotDBDnnIAfIrMdg5nGVUvrw/PDUHbL9xEID2hoKfIgLbI9dTCFQ7dgQjpE02k6StMsS2zHsGGwGk57hGGtrQrGQbyK4ftKBLPxV9C6q5h+lTv4Hv8yzrmiAM/7+zFewoTZKpq22KtxQsAR9aKs0Cl7lOgPPNao4wmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnyS2I7z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A551F0089B;
	Fri, 29 May 2026 18:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780079714;
	bh=ezd0P1gcDAfQ29ti+x+72H2yDuC5+RtI093Dg5GgHNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HnyS2I7zh0hfLteJlIAZZyjMvMEHv0MLtIe7sUY9Tvmqn7MK8F9Gxey48dS6Ax0S1
	 ZkudII6506jVPSedVM7e5R3RvGJ4s20zl3pE95iGCc/M43LyZQVswcbJhoVRx/it7S
	 sV3fRrnqyoBnZ0rjUZdHC4u2VAtqHLGtulenrOl6b+MQNP2Meqt9IBX5i7SQJYWOhw
	 Nk9684U4PzxbZsyTegivTPM0Z8y56C834WZZfKON8sNdAGnNX7ZtDS72n18ZcHgX5Q
	 DzIqD4BX9e2zJCUO94RCP3euqfLLf5LEQnQM4W6cR1jQVlwfXUqxxXzl609tXKE0sB
	 HpcRWn3pE3w4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer
Date: Fri, 29 May 2026 14:35:08 -0400
Message-ID: <20260529183508.1594050-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529183508.1594050-1-sashal@kernel.org>
References: <2026052807-twenty-relish-478b@gregkh>
 <20260529183508.1594050-1-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,linux.dev,lists.infradead.org,auristor.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256708-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,auristor.com:email,msgid.link:url,infradead.org:email,ietf.org:url]
X-Rspamd-Queue-Id: EC32F6074A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Howells <dhowells@redhat.com>

[ Upstream commit 8bfab4b6ffc2fe92da86300728fc8c3c7ebffb56 ]

This improves the fix for CVE-2026-43500.

Fix the verification of RESPONSE packets to avoid the problem of
overwriting a RESPONSE packet sent via splice to a local address by
extracting the contents of the UDP packet into a kmalloc'd linear buffer
rather than decrypting the data in place in the sk_buff (which may corrupt
the original buffer).

Fixes: 24481a7f5733 ("rxrpc: Fix conn-level packet handling to unshare RESPONSE packets")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/r/afKV2zGR6rrelPC7@v4bel/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jiayuan Chen <jiayuan.chen@linux.dev>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Link: https://patch.msgid.link/20260515230516.2718212-4-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h |  7 +--
 net/rxrpc/conn_event.c  | 32 ++++++--------
 net/rxrpc/insecure.c    |  5 ++-
 net/rxrpc/rxgk.c        | 96 +++++++++++++----------------------------
 net/rxrpc/rxgk_app.c    | 46 ++++++++------------
 net/rxrpc/rxgk_common.h | 92 +--------------------------------------
 net/rxrpc/rxkad.c       | 29 +++++--------
 7 files changed, 82 insertions(+), 225 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 783367eea798b..98f2165159d72 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -307,15 +307,16 @@ struct rxrpc_security {
 				    struct sk_buff *challenge);
 
 	/* verify a response */
-	int (*verify_response)(struct rxrpc_connection *,
-			       struct sk_buff *);
+	int (*verify_response)(struct rxrpc_connection *conn,
+			       struct sk_buff *response_skb,
+			       void *response, unsigned int len);
 
 	/* clear connection security */
 	void (*clear)(struct rxrpc_connection *);
 
 	/* Default ticket -> key decoder */
 	int (*default_decode_ticket)(struct rxrpc_connection *conn, struct sk_buff *skb,
-				     unsigned int ticket_offset, unsigned int ticket_len,
+				     void *ticket, unsigned int ticket_len,
 				     struct key **_key);
 };
 
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 442414d90ba1c..c96ca615b787c 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -243,28 +243,22 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
 static int rxrpc_verify_response(struct rxrpc_connection *conn,
 				 struct sk_buff *skb)
 {
+	unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
+	void *buffer;
 	int ret;
 
-	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
-	    skb_has_shared_frag(skb)) {
-		/* Copy the packet if shared so that we can do in-place
-		 * decryption.
-		 */
-		struct sk_buff *nskb = skb_copy(skb, GFP_NOFS);
-
-		if (nskb) {
-			rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
-			ret = conn->security->verify_response(conn, nskb);
-			rxrpc_free_skb(nskb, rxrpc_skb_put_response_copy);
-		} else {
-			/* OOM - Drop the packet. */
-			rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
-			ret = -ENOMEM;
-		}
-	} else {
-		ret = conn->security->verify_response(conn, skb);
-	}
+	buffer = kmalloc(len, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	ret = skb_copy_bits(skb, sizeof(struct rxrpc_wire_header), buffer, len);
+	if (ret < 0)
+		goto out;
+
+	ret = conn->security->verify_response(conn, skb, buffer, len);
 
+out:
+	kfree(buffer);
 	return ret;
 }
 
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 7a26c6097d033..0b39046bdc616 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -54,9 +54,10 @@ static int none_sendmsg_respond_to_challenge(struct sk_buff *challenge,
 }
 
 static int none_verify_response(struct rxrpc_connection *conn,
-				struct sk_buff *skb)
+				struct sk_buff *response_skb,
+				void *response, unsigned int len)
 {
-	return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
+	return rxrpc_abort_conn(conn, response_skb, RX_PROTOCOL_ERROR, -EPROTO,
 				rxrpc_eproto_rxnull_response);
 }
 
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index b40fba607a6bd..1ad5f7ea32800 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1084,11 +1084,12 @@ static int rxgk_sendmsg_respond_to_challenge(struct sk_buff *challenge,
  *	unsigned int call_numbers<>;
  * };
  */
-static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
-					const struct krb5_enctype *krb5,
-					struct sk_buff *skb,
-					__be32 *p, __be32 *end)
+static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
+				     const struct krb5_enctype *krb5,
+				     struct sk_buff *skb,
+				     void *auth, unsigned int auth_len)
 {
+	__be32 *p = auth, *end = auth + auth_len;
 	u32 app_len, call_count, level, epoch, cid, i;
 
 	_enter("");
@@ -1151,37 +1152,6 @@ static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
 	return 0;
 }
 
-/*
- * Extract the authenticator and verify it.
- */
-static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
-				     const struct krb5_enctype *krb5,
-				     struct sk_buff *skb,
-				     unsigned int auth_offset, unsigned int auth_len)
-{
-	void *auth;
-	__be32 *p;
-	int ret;
-
-	auth = kmalloc(auth_len, GFP_NOFS);
-	if (!auth)
-		return -ENOMEM;
-
-	ret = skb_copy_bits(skb, auth_offset, auth, auth_len);
-	if (ret < 0) {
-		ret = rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
-				       rxgk_abort_resp_short_auth);
-		goto error;
-	}
-
-	p = auth;
-	ret = rxgk_do_verify_authenticator(conn, krb5, skb, p,
-					   p + auth_len / sizeof(*p));
-error:
-	kfree(auth);
-	return ret;
-}
-
 /*
  * Verify a response.
  *
@@ -1192,49 +1162,45 @@ static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
  * };
  */
 static int rxgk_verify_response(struct rxrpc_connection *conn,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				void *buffer, unsigned int len)
 {
 	const struct krb5_enctype *krb5;
 	struct rxrpc_key_token *token;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxgk_response rhdr;
+	struct rxgk_response *rhdr;
 	struct rxgk_context *gk;
 	struct key *key = NULL;
-	unsigned int offset = sizeof(struct rxrpc_wire_header);
-	unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
-	unsigned int token_offset, token_len;
-	unsigned int auth_offset, auth_len;
+	unsigned int resp_token_len, auth_len;
+	void *resp_token, *auth;
 	__be32 xauth_len;
 	int ret, ec;
 
 	_enter("{%d}", conn->debug_id);
 
 	/* Parse the RXGK_Response object */
-	if (sizeof(rhdr) + sizeof(__be32) > len)
-		goto short_packet;
-
-	if (skb_copy_bits(skb, offset, &rhdr, sizeof(rhdr)) < 0)
+	if (len < sizeof(*rhdr) + sizeof(__be32))
 		goto short_packet;
-	offset	+= sizeof(rhdr);
-	len	-= sizeof(rhdr);
-
-	token_offset	= offset;
-	token_len	= ntohl(rhdr.token_len);
-	if (token_len > len ||
-	    xdr_round_up(token_len) + sizeof(__be32) > len)
+	rhdr = buffer;
+	buffer	+= sizeof(*rhdr);
+	len	-= sizeof(*rhdr);
+
+	resp_token	= buffer;
+	resp_token_len	= ntohl(rhdr->token_len);
+	if (resp_token_len > len ||
+	    xdr_round_up(resp_token_len) + sizeof(__be32) > len)
 		goto short_packet;
 
-	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, token_len);
+	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, resp_token_len);
 
-	offset	+= xdr_round_up(token_len);
-	len	-= xdr_round_up(token_len);
+	buffer	+= xdr_round_up(resp_token_len);
+	len	-= xdr_round_up(resp_token_len);
 
-	if (skb_copy_bits(skb, offset, &xauth_len, sizeof(xauth_len)) < 0)
-		goto short_packet;
-	offset	+= sizeof(xauth_len);
+	xauth_len = *(__be32 *)buffer;
+	buffer	+= sizeof(xauth_len);
 	len	-= sizeof(xauth_len);
 
-	auth_offset	= offset;
+	auth		= buffer;
 	auth_len	= ntohl(xauth_len);
 	if (auth_len > len)
 		goto short_packet;
@@ -1249,7 +1215,7 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 	 * to the app to deal with - which might mean a round trip to
 	 * userspace.
 	 */
-	ret = rxgk_extract_token(conn, skb, token_offset, token_len, &key);
+	ret = rxgk_extract_token(conn, skb, resp_token, resp_token_len, &key);
 	if (ret < 0)
 		goto out;
 
@@ -1263,7 +1229,7 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 	 */
 	token = key->payload.data[0];
 	conn->security_level = token->rxgk->level;
-	conn->rxgk.start_time = __be64_to_cpu(rhdr.start_time);
+	conn->rxgk.start_time = __be64_to_cpu(rhdr->start_time);
 
 	gk = rxgk_generate_transport_key(conn, token->rxgk, sp->hdr.cksum, GFP_NOFS);
 	if (IS_ERR(gk)) {
@@ -1273,18 +1239,18 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 
 	krb5 = gk->krb5;
 
-	trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, sp->hdr.cksum, token_len);
+	trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, sp->hdr.cksum,
+				resp_token_len);
 
 	/* Decrypt, parse and verify the authenticator. */
-	ret = rxgk_decrypt_skb(krb5, gk->resp_enc, skb,
-			       &auth_offset, &auth_len, &ec);
+	ret = rxgk_decrypt(krb5, gk->resp_enc, &auth, &auth_len, &ec);
 	if (ret < 0) {
 		rxrpc_abort_conn(conn, skb, RXGK_SEALEDINCON, ret,
 				 rxgk_abort_resp_auth_dec);
 		goto out_gk;
 	}
 
-	ret = rxgk_verify_authenticator(conn, krb5, skb, auth_offset, auth_len);
+	ret = rxgk_verify_authenticator(conn, krb5, skb, auth, auth_len);
 	if (ret < 0)
 		goto out_gk;
 
diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index 0ef2a29eb6958..200a30064fae1 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -40,7 +40,7 @@
  * };
  */
 int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
-			   unsigned int ticket_offset, unsigned int ticket_len,
+			   void *buffer, unsigned int ticket_len,
 			   struct key **_key)
 {
 	struct rxrpc_key_token *token;
@@ -49,7 +49,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 	size_t pre_ticket_len, payload_len;
 	unsigned int klen, enctype;
 	void *payload, *ticket;
-	__be32 *t, *p, *q, tmp[2];
+	__be32 *t, *p, *q, *tmp;
 	int ret;
 
 	_enter("");
@@ -59,10 +59,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 					rxgk_abort_resp_short_yfs_tkt);
 
 	/* Get the session key length */
-	ret = skb_copy_bits(skb, ticket_offset, tmp, sizeof(tmp));
-	if (ret < 0)
-		return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
-					rxgk_abort_resp_short_yfs_klen);
+	tmp = buffer;
 	enctype = ntohl(tmp[0]);
 	klen = ntohl(tmp[1]);
 
@@ -84,12 +81,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 	 * it.
 	 */
 	ticket = payload + pre_ticket_len;
-	ret = skb_copy_bits(skb, ticket_offset, ticket, ticket_len);
-	if (ret < 0) {
-		ret = rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
-				       rxgk_abort_resp_short_yfs_tkt);
-		goto error;
-	}
+	memcpy(ticket, buffer, ticket_len);
 
 	/* Fill out the form header. */
 	p = payload;
@@ -131,7 +123,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 		goto error;
 	}
 
-	/* Ticket read in with skb_copy_bits above */
+	/* Ticket appended above. */
 	q += xdr_round_up(ticket_len) / 4;
 	if (WARN_ON((unsigned long)q - (unsigned long)payload != payload_len)) {
 		ret = -EIO;
@@ -182,14 +174,15 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
  * [tools.ietf.org/html/draft-wilkinson-afs3-rxgk-afs-08 sec 6.1]
  */
 int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
-		       unsigned int token_offset, unsigned int token_len,
+		       void *token, unsigned int token_len,
 		       struct key **_key)
 {
 	const struct krb5_enctype *krb5;
 	const struct krb5_buffer *server_secret;
 	struct crypto_aead *token_enc = NULL;
 	struct key *server_key;
-	unsigned int ticket_offset, ticket_len;
+	unsigned int ticket_len;
+	void *ticket;
 	u32 kvno, enctype;
 	int ret, ec = 0;
 
@@ -197,24 +190,23 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 		__be32 kvno;
 		__be32 enctype;
 		__be32 token_len;
-	} container;
+	} *container;
 
-	if (token_len < sizeof(container))
+	if (token_len < sizeof(*container))
 		goto short_packet;
 
 	/* Decode the RXGK_TokenContainer object.  This tells us which server
 	 * key we should be using.  We can then fetch the key, get the secret
 	 * and set up the crypto to extract the token.
 	 */
-	if (skb_copy_bits(skb, token_offset, &container, sizeof(container)) < 0)
-		goto short_packet;
+	container = token;
+	token += sizeof(*container);
 
-	kvno		= ntohl(container.kvno);
-	enctype		= ntohl(container.enctype);
-	ticket_len	= ntohl(container.token_len);
-	ticket_offset	= token_offset + sizeof(container);
+	kvno		= ntohl(container->kvno);
+	enctype		= ntohl(container->enctype);
+	ticket_len	= ntohl(container->token_len);
 
-	if (ticket_len > xdr_round_down(token_len - sizeof(container)))
+	if (ticket_len > xdr_round_down(token_len - sizeof(*container)))
 		goto short_packet;
 
 	_debug("KVNO %u", kvno);
@@ -237,8 +229,8 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 	 * gain access to K0, from which we can derive the transport key and
 	 * thence decode the authenticator.
 	 */
-	ret = rxgk_decrypt_skb(krb5, token_enc, skb,
-			       &ticket_offset, &ticket_len, &ec);
+	ticket = token;
+	ret = rxgk_decrypt(krb5, token_enc, &ticket, &ticket_len, &ec);
 	crypto_free_aead(token_enc);
 	token_enc = NULL;
 	if (ret < 0) {
@@ -248,7 +240,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 		return ret;
 	}
 
-	ret = conn->security->default_decode_ticket(conn, skb, ticket_offset,
+	ret = conn->security->default_decode_ticket(conn, skb, ticket,
 						    ticket_len, _key);
 	if (ret < 0)
 		goto cant_get_token;
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
index 112b5366ce119..3deed5863f5aa 100644
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -41,10 +41,10 @@ struct rxgk_context {
  * rxgk_app.c
  */
 int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
-			   unsigned int ticket_offset, unsigned int ticket_len,
+			   void *ticket, unsigned int ticket_len,
 			   struct key **_key);
 int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
-		       unsigned int token_offset, unsigned int token_len,
+		       void *token, unsigned int token_len,
 		       struct key **_key);
 
 /*
@@ -61,50 +61,6 @@ int rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
 			     const struct krb5_enctype **_krb5,
 			     gfp_t gfp);
 
-/*
- * Apply decryption and checksumming functions to part of an skbuff.  The
- * offset and length are updated to reflect the actual content of the encrypted
- * region.
- */
-static inline
-int rxgk_decrypt_skb(const struct krb5_enctype *krb5,
-		     struct crypto_aead *aead,
-		     struct sk_buff *skb,
-		     unsigned int *_offset, unsigned int *_len,
-		     int *_error_code)
-{
-	struct scatterlist sg[16];
-	size_t offset = 0, len = *_len;
-	int nr_sg, ret;
-
-	sg_init_table(sg, ARRAY_SIZE(sg));
-	nr_sg = skb_to_sgvec(skb, sg, *_offset, len);
-	if (unlikely(nr_sg < 0))
-		return nr_sg;
-
-	ret = crypto_krb5_decrypt(krb5, aead, sg, nr_sg,
-				  &offset, &len);
-	switch (ret) {
-	case 0:
-		*_offset += offset;
-		*_len = len;
-		break;
-	case -EBADMSG: /* Checksum mismatch. */
-	case -EPROTO:
-		*_error_code = RXGK_SEALEDINCON;
-		break;
-	case -EMSGSIZE:
-		*_error_code = RXGK_PACKETSHORT;
-		break;
-	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. */
-	default:
-		*_error_code = RXGK_INCONSISTENCY;
-		break;
-	}
-
-	return ret;
-}
-
 /*
  * Apply decryption and checksumming functions a flat data buffer.  The data
  * point and length are updated to reflect the actual content of the encrypted
@@ -148,50 +104,6 @@ static inline int rxgk_decrypt(const struct krb5_enctype *krb5,
 	return ret;
 }
 
-/*
- * Check the MIC on a region of an skbuff.  The offset and length are updated
- * to reflect the actual content of the secure region.
- */
-static inline
-int rxgk_verify_mic_skb(const struct krb5_enctype *krb5,
-			struct crypto_shash *shash,
-			const struct krb5_buffer *metadata,
-			struct sk_buff *skb,
-			unsigned int *_offset, unsigned int *_len,
-			u32 *_error_code)
-{
-	struct scatterlist sg[16];
-	size_t offset = 0, len = *_len;
-	int nr_sg, ret;
-
-	sg_init_table(sg, ARRAY_SIZE(sg));
-	nr_sg = skb_to_sgvec(skb, sg, *_offset, len);
-	if (unlikely(nr_sg < 0))
-		return nr_sg;
-
-	ret = crypto_krb5_verify_mic(krb5, shash, metadata, sg, nr_sg,
-				     &offset, &len);
-	switch (ret) {
-	case 0:
-		*_offset += offset;
-		*_len = len;
-		break;
-	case -EBADMSG: /* Checksum mismatch */
-	case -EPROTO:
-		*_error_code = RXGK_SEALEDINCON;
-		break;
-	case -EMSGSIZE:
-		*_error_code = RXGK_PACKETSHORT;
-		break;
-	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. */
-	default:
-		*_error_code = RXGK_INCONSISTENCY;
-		break;
-	}
-
-	return ret;
-}
-
 /*
  * Check the MIC on a flat buffer.  The data pointer and length are updated to
  * reflect the actual content of the secure region.
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 951a8913ee3f0..6fbd883401acd 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -963,7 +963,6 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	*_expiry = 0;
 
 	ASSERT(server_key->payload.data[0] != NULL);
-	ASSERTCMP((unsigned long) ticket & 7UL, ==, 0);
 
 	memcpy(&iv, &server_key->payload.data[2], sizeof(iv));
 
@@ -1112,14 +1111,15 @@ static int rxkad_decrypt_response(struct rxrpc_connection *conn,
  * verify a response
  */
 static int rxkad_verify_response(struct rxrpc_connection *conn,
-				 struct sk_buff *skb)
+				 struct sk_buff *skb,
+				 void *buffer, unsigned int len)
 {
 	struct rxkad_response *response;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_crypt session_key;
 	struct key *server_key;
 	time64_t expiry;
-	void *ticket = NULL;
+	void *ticket;
 	u32 version, kvno, ticket_len, level;
 	__be32 csum;
 	int ret, i;
@@ -1142,13 +1142,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 		}
 	}
 
-	ret = -ENOMEM;
-	response = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
-	if (!response)
-		goto error;
-
-	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  response, sizeof(*response)) < 0) {
+	response = buffer;
+	if (len < sizeof(*response)) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				       rxkad_abort_resp_short);
 		goto error;
@@ -1160,6 +1155,9 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
+	buffer	+= sizeof(*response);
+	len	-= sizeof(*response);
+
 	if (version != RXKAD_VERSION) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
 				       rxkad_abort_resp_version);
@@ -1179,13 +1177,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	}
 
 	/* extract the kerberos ticket and decrypt and decode it */
-	ret = -ENOMEM;
-	ticket = kmalloc(ticket_len, GFP_NOFS);
-	if (!ticket)
-		goto error;
-
-	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header) + sizeof(*response),
-			  ticket, ticket_len) < 0) {
+	ticket = buffer;
+	if (ticket_len > len) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				       rxkad_abort_resp_short_tkt);
 		goto error;
@@ -1265,8 +1258,6 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 
 error:
-	kfree(ticket);
-	kfree(response);
 	key_put(server_key);
 	_leave(" = %d", ret);
 	return ret;
-- 
2.53.0


