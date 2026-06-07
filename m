Return-Path: <stable+bounces-261820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jNTnNg1PJWraGgIAu9opvQ
	(envelope-from <stable+bounces-261820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:59:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86433650317
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pxXtpsEp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261820-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-261820-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 013B43004F20
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F198330330;
	Sun,  7 Jun 2026 10:59:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AC12CDA5;
	Sun,  7 Jun 2026 10:59:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829963; cv=none; b=D5G7m/X5Oy8k4WhI997Iz4lJWoc4QXBFstb635xqCZsIrplfPc5PluMIIovuS+MiyJD7UFXKGJzrC8xVwqROqIofXDWUE79n+8vCyP+jGmtKm8UAmVeqZ4R2iMM6YE69Y4zdbZlFRiqvVElrWJuleukf2HfzBEfXd8JiwPmwg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829963; c=relaxed/simple;
	bh=d+5D2QJwuagXENZOGdMO3KuUmK/I4rri9bNiBsvErm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNbA1gn/Xv622iJqmtMuWSI+0Q/3dM4/dNsHbdAiQpSW2vtCKDqZfEvdYefp16w3KGmu4JoBr9ILJoD12uRWDv15nINAma5AyrRE2ccabdcvF2/2CN3Ldadj5E0Ge1FK03+GgpiiprmGnRTKX059xXWFPJV8lVAMXhAMVYitXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pxXtpsEp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3537D1F00893;
	Sun,  7 Jun 2026 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829961;
	bh=MgH+8Ye7Ad6jQtq1kR42dWN4QeRJRR4CFVEo1hhAejI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pxXtpsEpUbbEGh9fueV87Q48IWIzrtMpP337V63Mp/vke2qUBcYdL8yjU8G+XtozR
	 jAYm7vN3VdqiNbDrbdSo7Aib137aTtrcmgl4G8GILw2fprkMf35Me9Wn1jvCowgYQS
	 pRqiHZ+A9tmUcy2laiQ0juUMuZgwalzuk6zEebpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 269/307] rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer
Date: Sun,  7 Jun 2026 12:01:06 +0200
Message-ID: <20260607095737.588024424@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-261820-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:imv4bel@gmail.com,m:dhowells@redhat.com,m:horms@kernel.org,m:jiayuan.chen@linux.dev,m:linux-afs@lists.infradead.org,m:stable@kernel.org,m:jaltman@auristor.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.org,linux.dev,lists.infradead.org,auristor.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,auristor.com:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86433650317

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/ar-internal.h |    5 +++--
 net/rxrpc/conn_event.c  |   30 ++++++++++++------------------
 net/rxrpc/insecure.c    |    5 +++--
 net/rxrpc/rxkad.c       |   29 ++++++++++-------------------
 4 files changed, 28 insertions(+), 41 deletions(-)

--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -270,8 +270,9 @@ struct rxrpc_security {
 				    struct sk_buff *);
 
 	/* verify a response */
-	int (*verify_response)(struct rxrpc_connection *,
-			       struct sk_buff *);
+	int (*verify_response)(struct rxrpc_connection *conn,
+			       struct sk_buff *response_skb,
+			       void *response, unsigned int len);
 
 	/* clear connection security */
 	void (*clear)(struct rxrpc_connection *);
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -229,28 +229,22 @@ static void rxrpc_call_is_secure(struct
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
+	buffer = kmalloc(len, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
 
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
+	ret = skb_copy_bits(skb, sizeof(struct rxrpc_wire_header), buffer, len);
+	if (ret < 0)
+		goto out;
 
+	ret = conn->security->verify_response(conn, skb, buffer, len);
+
+out:
+	kfree(buffer);
 	return ret;
 }
 
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -44,9 +44,10 @@ static int none_respond_to_challenge(str
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
 
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -875,7 +875,6 @@ static int rxkad_decrypt_ticket(struct r
 	*_expiry = 0;
 
 	ASSERT(server_key->payload.data[0] != NULL);
-	ASSERTCMP((unsigned long) ticket & 7UL, ==, 0);
 
 	memcpy(&iv, &server_key->payload.data[2], sizeof(iv));
 
@@ -1024,14 +1023,15 @@ unlock:
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
@@ -1054,13 +1054,8 @@ static int rxkad_verify_response(struct
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
@@ -1072,6 +1067,9 @@ static int rxkad_verify_response(struct
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
+	buffer	+= sizeof(*response);
+	len	-= sizeof(*response);
+
 	if (version != RXKAD_VERSION) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
 				       rxkad_abort_resp_version);
@@ -1091,13 +1089,8 @@ static int rxkad_verify_response(struct
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
@@ -1177,8 +1170,6 @@ static int rxkad_verify_response(struct
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 
 error:
-	kfree(ticket);
-	kfree(response);
 	key_put(server_key);
 	_leave(" = %d", ret);
 	return ret;



