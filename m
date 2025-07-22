Return-Path: <stable+bounces-164227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53809B0DE5A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96106AC7988
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E142EBBB0;
	Tue, 22 Jul 2025 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LZJhCCAn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E922EBB91;
	Tue, 22 Jul 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193664; cv=none; b=bGGYVzKMGyPDg2wMbvFf24YhKMKclx79XUfpobHQ4AcC8BybBrltmFN5ec96U3wi6TetLS21WGCBTx+Pn+olKZEJSSidLHigC5FtMPOR+y3fPzvWUg6lk28oBUk7puLcO5pIgalLw732UwGOeMN0m67MuG8E7D/YSmK06C2miSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193664; c=relaxed/simple;
	bh=LrUKkTTHBQznKyaxy4GkIO93qc+wvPvH1I9iEXfjjQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAT5KKENnK3Ey52nO6p3Ey4D017nNgl++le1BY46iEyM+eQq+HrrNmLg9hCHYybPDG6UBVihUH/VAanpxaJyFNTuP+/NqsKKczSTKxhJqoXGxuyyArTRhW61vAHBKtb1oeutciSYuaenXK9zbFg0WIIEx/P2Pv+jsB7sQk5VhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LZJhCCAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0F0C4CEEB;
	Tue, 22 Jul 2025 14:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193664;
	bh=LrUKkTTHBQznKyaxy4GkIO93qc+wvPvH1I9iEXfjjQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZJhCCAn45pEx6/z+VkeQbPIPZ1rEWJUwIHPMVh/dFpEbuICzM+ermAljOQm7uVFW
	 1ecdnnuM5lOhAGP6hA5iOa1xIqKnHKqKg7B0fUnPh1L89aGdWzgMJOoCFOLfPCdQ32
	 z9/WgrE70Lanwk1XxeyUQOaRaYyUZwX0hO0PTXbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeffrey Altman <jaltman@auristor.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 160/187] rxrpc: Fix to use conn aborts for conn-wide failures
Date: Tue, 22 Jul 2025 15:45:30 +0200
Message-ID: <20250722134351.743109652@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit f0295678ad304195927829b1dbf06553aa2187b0 ]

Fix rxrpc to use connection-level aborts for things that affect the whole
connection, such as the service ID not matching a local service.

Fixes: 57af281e5389 ("rxrpc: Tidy up abort generation infrastructure")
Reported-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/20250717074350.3767366-6-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h |  3 +++
 net/rxrpc/call_accept.c | 12 ++++++------
 net/rxrpc/io_thread.c   | 14 ++++++++++++++
 net/rxrpc/output.c      | 19 ++++++++++---------
 net/rxrpc/security.c    |  8 ++++----
 5 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index b2d64586958fb..c4891a538ded0 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -42,6 +42,7 @@ enum rxrpc_skb_mark {
 	RXRPC_SKB_MARK_SERVICE_CONN_SECURED, /* Service connection response has been verified */
 	RXRPC_SKB_MARK_REJECT_BUSY,	/* Reject with BUSY */
 	RXRPC_SKB_MARK_REJECT_ABORT,	/* Reject with ABORT (code in skb->priority) */
+	RXRPC_SKB_MARK_REJECT_CONN_ABORT, /* Reject with connection ABORT (code in skb->priority) */
 };
 
 /*
@@ -1197,6 +1198,8 @@ int rxrpc_encap_rcv(struct sock *, struct sk_buff *);
 void rxrpc_error_report(struct sock *);
 bool rxrpc_direct_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
 			s32 abort_code, int err);
+bool rxrpc_direct_conn_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
+			     s32 abort_code, int err);
 int rxrpc_io_thread(void *data);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
 {
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 978f0c6ee3c8a..3259916c926ae 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -373,8 +373,8 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	spin_lock(&rx->incoming_lock);
 	if (rx->sk.sk_state == RXRPC_SERVER_LISTEN_DISABLED ||
 	    rx->sk.sk_state == RXRPC_CLOSE) {
-		rxrpc_direct_abort(skb, rxrpc_abort_shut_down,
-				   RX_INVALID_OPERATION, -ESHUTDOWN);
+		rxrpc_direct_conn_abort(skb, rxrpc_abort_shut_down,
+					RX_INVALID_OPERATION, -ESHUTDOWN);
 		goto no_call;
 	}
 
@@ -420,12 +420,12 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 
 unsupported_service:
 	read_unlock_irq(&local->services_lock);
-	return rxrpc_direct_abort(skb, rxrpc_abort_service_not_offered,
-				  RX_INVALID_OPERATION, -EOPNOTSUPP);
+	return rxrpc_direct_conn_abort(skb, rxrpc_abort_service_not_offered,
+				       RX_INVALID_OPERATION, -EOPNOTSUPP);
 unsupported_security:
 	read_unlock_irq(&local->services_lock);
-	return rxrpc_direct_abort(skb, rxrpc_abort_service_not_offered,
-				  RX_INVALID_OPERATION, -EKEYREJECTED);
+	return rxrpc_direct_conn_abort(skb, rxrpc_abort_service_not_offered,
+				       RX_INVALID_OPERATION, -EKEYREJECTED);
 no_call:
 	spin_unlock(&rx->incoming_lock);
 	read_unlock_irq(&local->services_lock);
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 64f8d77b87312..23dbcc4819990 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -97,6 +97,20 @@ bool rxrpc_direct_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
 	return false;
 }
 
+/*
+ * Directly produce a connection abort from a packet.
+ */
+bool rxrpc_direct_conn_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
+			     s32 abort_code, int err)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+	trace_rxrpc_abort(0, why, sp->hdr.cid, 0, sp->hdr.seq, abort_code, err);
+	skb->mark = RXRPC_SKB_MARK_REJECT_CONN_ABORT;
+	skb->priority = abort_code;
+	return false;
+}
+
 static bool rxrpc_bad_message(struct sk_buff *skb, enum rxrpc_abort_reason why)
 {
 	return rxrpc_direct_abort(skb, why, RX_PROTOCOL_ERROR, -EBADMSG);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index d0d04ee9667ef..a480e7e2325eb 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -829,7 +829,13 @@ void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb)
 	msg.msg_controllen = 0;
 	msg.msg_flags = 0;
 
-	memset(&whdr, 0, sizeof(whdr));
+	whdr = (struct rxrpc_wire_header) {
+		.epoch		= htonl(sp->hdr.epoch),
+		.cid		= htonl(sp->hdr.cid),
+		.callNumber	= htonl(sp->hdr.callNumber),
+		.serviceId	= htons(sp->hdr.serviceId),
+		.flags		= ~sp->hdr.flags & RXRPC_CLIENT_INITIATED,
+	};
 
 	switch (skb->mark) {
 	case RXRPC_SKB_MARK_REJECT_BUSY:
@@ -837,6 +843,9 @@ void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb)
 		size = sizeof(whdr);
 		ioc = 1;
 		break;
+	case RXRPC_SKB_MARK_REJECT_CONN_ABORT:
+		whdr.callNumber	= 0;
+		fallthrough;
 	case RXRPC_SKB_MARK_REJECT_ABORT:
 		whdr.type = RXRPC_PACKET_TYPE_ABORT;
 		code = htonl(skb->priority);
@@ -850,14 +859,6 @@ void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb)
 	if (rxrpc_extract_addr_from_skb(&srx, skb) == 0) {
 		msg.msg_namelen = srx.transport_len;
 
-		whdr.epoch	= htonl(sp->hdr.epoch);
-		whdr.cid	= htonl(sp->hdr.cid);
-		whdr.callNumber	= htonl(sp->hdr.callNumber);
-		whdr.serviceId	= htons(sp->hdr.serviceId);
-		whdr.flags	= sp->hdr.flags;
-		whdr.flags	^= RXRPC_CLIENT_INITIATED;
-		whdr.flags	&= RXRPC_CLIENT_INITIATED;
-
 		iov_iter_kvec(&msg.msg_iter, WRITE, iov, ioc, size);
 		ret = do_udp_sendmsg(local->socket, &msg, size);
 		if (ret < 0)
diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index 9784adc8f2759..7a48fee3a6b1a 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -137,15 +137,15 @@ const struct rxrpc_security *rxrpc_get_incoming_security(struct rxrpc_sock *rx,
 
 	sec = rxrpc_security_lookup(sp->hdr.securityIndex);
 	if (!sec) {
-		rxrpc_direct_abort(skb, rxrpc_abort_unsupported_security,
-				   RX_INVALID_OPERATION, -EKEYREJECTED);
+		rxrpc_direct_conn_abort(skb, rxrpc_abort_unsupported_security,
+					RX_INVALID_OPERATION, -EKEYREJECTED);
 		return NULL;
 	}
 
 	if (sp->hdr.securityIndex != RXRPC_SECURITY_NONE &&
 	    !rx->securities) {
-		rxrpc_direct_abort(skb, rxrpc_abort_no_service_key,
-				   sec->no_key_abort, -EKEYREJECTED);
+		rxrpc_direct_conn_abort(skb, rxrpc_abort_no_service_key,
+					sec->no_key_abort, -EKEYREJECTED);
 		return NULL;
 	}
 
-- 
2.39.5




