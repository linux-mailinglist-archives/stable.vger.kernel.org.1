Return-Path: <stable+bounces-243697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NizOnOs+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:25:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 816154BF5F6
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E3EC30219A8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B83DE43C;
	Mon,  4 May 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2L1uNK2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4B315785;
	Mon,  4 May 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904545; cv=none; b=L2q2oXyU0B2lqygKxkXsqApAcHYWGcEkExxYCS0gK+3IBxS6iW6V2NBGJCiqmzBSN++tlAjE7DKPpPqg3k7fbQrnmp5vdf49yyHhwTXSq2iiltoM8+dC4cuJuaiiQ/aljVCyiNpx/vRHtHI88dlBwTkpeGJ4WoQL4qSkCVlaL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904545; c=relaxed/simple;
	bh=PDlc9E8GOggXPSw1dJqDIxSY174SsMnQAboSRtjT75E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbn+fQVpPJKJp4fISK7K/vFCIsPtbwBwSMirutUGwmlZfchxrdy7XJLuXm2G71rnPQcRyrAnW4lEaidfOM+AulWftnWXM082oxeo63HrIZMZ8aw1BJffwf/XbTiKrq7HijUObL99xkPWoI3jGMjoy5ejSqGYIRhxHQLFo4vV/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2L1uNK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FE3C2BCB8;
	Mon,  4 May 2026 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904545;
	bh=PDlc9E8GOggXPSw1dJqDIxSY174SsMnQAboSRtjT75E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2L1uNK2Y/MOre9lqqkdYBiryChmWf6GA0SQVfcI0fB5sWdfknFwS/VXRFqGbZscR
	 lFys5VZWnl2ZU73BCgGoQKZXWnGFIFAeRxY/uYLIwY0PLypq2PeMlL622pLfb/RNWa
	 tk+/jBeEYWmp+7XHbvtqLkZj5IFXaiVz6lkWGjZ8=
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
Subject: [PATCH 6.12 081/215] rxrpc: Fix memory leaks in rxkad_verify_response()
Date: Mon,  4 May 2026 15:51:40 +0200
Message-ID: <20260504135133.121324650@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 816154BF5F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243697-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,auristor.com:email,infradead.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sashiko.dev:url,msgid.link:url]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 34f61a07e0cdefaecd3ec03bb5fb22215643678f upstream.

Fix rxkad_verify_response() to free the ticket and the server key under all
circumstances by initialising the ticket pointer to NULL and then making
all paths through the function after the first allocation has been done go
through a single common epilogue that just releases everything - where all
the releases skip on a NULL pointer.

Fixes: 57af281e5389 ("rxrpc: Tidy up abort generation infrastructure")
Fixes: ec832bd06d6f ("rxrpc: Don't retain the server key in the connection")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260422161438.2593376-2-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxkad.c |  103 ++++++++++++++++++++++--------------------------------
 1 file changed, 42 insertions(+), 61 deletions(-)

--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1048,7 +1048,7 @@ static int rxkad_verify_response(struct
 	struct rxrpc_crypt session_key;
 	struct key *server_key;
 	time64_t expiry;
-	void *ticket;
+	void *ticket = NULL;
 	u32 version, kvno, ticket_len, level;
 	__be32 csum;
 	int ret, i;
@@ -1074,13 +1074,13 @@ static int rxkad_verify_response(struct
 	ret = -ENOMEM;
 	response = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
 	if (!response)
-		goto temporary_error;
+		goto error;
 
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
 			  response, sizeof(*response)) < 0) {
-		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
-				 rxkad_abort_resp_short);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
+				       rxkad_abort_resp_short);
+		goto error;
 	}
 
 	version = ntohl(response->version);
@@ -1090,62 +1090,62 @@ static int rxkad_verify_response(struct
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
 	if (version != RXKAD_VERSION) {
-		rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
-				 rxkad_abort_resp_version);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
+				       rxkad_abort_resp_version);
+		goto error;
 	}
 
 	if (ticket_len < 4 || ticket_len > MAXKRB5TICKETLEN) {
-		rxrpc_abort_conn(conn, skb, RXKADTICKETLEN, -EPROTO,
-				 rxkad_abort_resp_tkt_len);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADTICKETLEN, -EPROTO,
+				       rxkad_abort_resp_tkt_len);
+		goto error;
 	}
 
 	if (kvno >= RXKAD_TKT_TYPE_KERBEROS_V5) {
-		rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, -EPROTO,
-				 rxkad_abort_resp_unknown_tkt);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, -EPROTO,
+				       rxkad_abort_resp_unknown_tkt);
+		goto error;
 	}
 
 	/* extract the kerberos ticket and decrypt and decode it */
 	ret = -ENOMEM;
 	ticket = kmalloc(ticket_len, GFP_NOFS);
 	if (!ticket)
-		goto temporary_error_free_resp;
+		goto error;
 
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header) + sizeof(*response),
 			  ticket, ticket_len) < 0) {
-		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
-				 rxkad_abort_resp_short_tkt);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
+				       rxkad_abort_resp_short_tkt);
+		goto error;
 	}
 
 	ret = rxkad_decrypt_ticket(conn, server_key, skb, ticket, ticket_len,
 				   &session_key, &expiry);
 	if (ret < 0)
-		goto temporary_error_free_ticket;
+		goto error;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
 	ret = rxkad_decrypt_response(conn, response, &session_key);
 	if (ret < 0)
-		goto temporary_error_free_ticket;
+		goto error;
 
 	if (ntohl(response->encrypted.epoch) != conn->proto.epoch ||
 	    ntohl(response->encrypted.cid) != conn->proto.cid ||
 	    ntohl(response->encrypted.securityIndex) != conn->security_ix) {
-		rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-				 rxkad_abort_resp_bad_param);
-		goto protocol_error_free;
+		ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+				       rxkad_abort_resp_bad_param);
+		goto error;
 	}
 
 	csum = response->encrypted.checksum;
 	response->encrypted.checksum = 0;
 	rxkad_calc_response_checksum(response);
 	if (response->encrypted.checksum != csum) {
-		rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-				 rxkad_abort_resp_bad_checksum);
-		goto protocol_error_free;
+		ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+				       rxkad_abort_resp_bad_checksum);
+		goto error;
 	}
 
 	for (i = 0; i < RXRPC_MAXCALLS; i++) {
@@ -1153,38 +1153,38 @@ static int rxkad_verify_response(struct
 		u32 counter = READ_ONCE(conn->channels[i].call_counter);
 
 		if (call_id > INT_MAX) {
-			rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-					 rxkad_abort_resp_bad_callid);
-			goto protocol_error_free;
+			ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+					       rxkad_abort_resp_bad_callid);
+			goto error;
 		}
 
 		if (call_id < counter) {
-			rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-					 rxkad_abort_resp_call_ctr);
-			goto protocol_error_free;
+			ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+					       rxkad_abort_resp_call_ctr);
+			goto error;
 		}
 
 		if (call_id > counter) {
 			if (conn->channels[i].call) {
-				rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+				ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
 						 rxkad_abort_resp_call_state);
-				goto protocol_error_free;
+				goto error;
 			}
 			conn->channels[i].call_counter = call_id;
 		}
 	}
 
 	if (ntohl(response->encrypted.inc_nonce) != conn->rxkad.nonce + 1) {
-		rxrpc_abort_conn(conn, skb, RXKADOUTOFSEQUENCE, -EPROTO,
-				 rxkad_abort_resp_ooseq);
-		goto protocol_error_free;
+		ret = rxrpc_abort_conn(conn, skb, RXKADOUTOFSEQUENCE, -EPROTO,
+				       rxkad_abort_resp_ooseq);
+		goto error;
 	}
 
 	level = ntohl(response->encrypted.level);
 	if (level > RXRPC_SECURITY_ENCRYPT) {
-		rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EPROTO,
-				 rxkad_abort_resp_level);
-		goto protocol_error_free;
+		ret = rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EPROTO,
+				       rxkad_abort_resp_level);
+		goto error;
 	}
 	conn->security_level = level;
 
@@ -1192,31 +1192,12 @@ static int rxkad_verify_response(struct
 	 * this the connection security can be handled in exactly the same way
 	 * as for a client connection */
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
-	if (ret < 0)
-		goto temporary_error_free_ticket;
-
-	kfree(ticket);
-	kfree(response);
-	_leave(" = 0");
-	return 0;
-
-protocol_error_free:
-	kfree(ticket);
-protocol_error:
-	kfree(response);
-	key_put(server_key);
-	return -EPROTO;
 
-temporary_error_free_ticket:
+error:
 	kfree(ticket);
-temporary_error_free_resp:
 	kfree(response);
-temporary_error:
-	/* Ignore the response packet if we got a temporary error such as
-	 * ENOMEM.  We just want to send the challenge again.  Note that we
-	 * also come out this way if the ticket decryption fails.
-	 */
 	key_put(server_key);
+	_leave(" = %d", ret);
 	return ret;
 }
 



