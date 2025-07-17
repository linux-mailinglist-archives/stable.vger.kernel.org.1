Return-Path: <stable+bounces-163226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC6B0874D
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886711AA250E
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B72571B8;
	Thu, 17 Jul 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="few6KKyN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23525C81E
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738284; cv=none; b=qQM6qdV2zPbyZ6emoWkRoFkvwjyHYJsf4WL77vrsCHrQusuFwIGxO0kttgBcM/e1SCY/2DPfm1zHxuyYJxlvXMzSCDpINQjpp5mdGH2aV/2cpeSlJN5ejtZDbHu5+/6RfsntFhg9tK2ij6Pk4j+SJlBlibwyCNtc2mn5iiCdD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738284; c=relaxed/simple;
	bh=wgEaEOYrNfW6/ZI622k50gFLkRBA4GvQMzSqKH+iRtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T128pULer4ja8kp0/TS4+jg1Slt3Z1e85EMSadE8BHGojcPNyzNn5Xd6U4beP716jSZU5iKZuzNkTNrDpvOzfVfd3/Zz3xXWNWAXm7L1VUcQx5FPUAh7yO1Pff0FscYzrsFNa2I/5opeSL+XlI0baoqU4d+osn6VfgonvvFP2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=few6KKyN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752738280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BARdK3M75VCMxXhs5BHV5EfarnbaGb893QTcxlP2ZM4=;
	b=few6KKyNuzyQ5wv5A94n6zrz+hzX0tg1hhNoWTKfPUfshpKpu/oUEGnPhxeaFoX6IjWP4T
	WhrIlJJIvYoJ7tWJDp7vuso8XABYJuOS06ZFgAwHoUJCcUlNnICb0upYacURyUW+JbfquW
	Vyox6KWWY1unjv66aWmQ0bGyleeUKUc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-zCtiDZvoMWO3VgaIwPVr9Q-1; Thu,
 17 Jul 2025 03:44:36 -0400
X-MC-Unique: zCtiDZvoMWO3VgaIwPVr9Q-1
X-Mimecast-MFC-AGG-ID: zCtiDZvoMWO3VgaIwPVr9Q_1752738275
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A67119560B0;
	Thu, 17 Jul 2025 07:44:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2303318004AD;
	Thu, 17 Jul 2025 07:44:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 5/5] rxrpc: Fix to use conn aborts for conn-wide failures
Date: Thu, 17 Jul 2025 08:43:45 +0100
Message-ID: <20250717074350.3767366-6-dhowells@redhat.com>
In-Reply-To: <20250717074350.3767366-1-dhowells@redhat.com>
References: <20250717074350.3767366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix rxrpc to use connection-level aborts for things that affect the whole
connection, such as the service ID not matching a local service.

Fixes: 57af281e5389 ("rxrpc: Tidy up abort generation infrastructure")
Reported-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Moved trace note declaration out to earlier patch that uses it

 net/rxrpc/ar-internal.h |  3 +++
 net/rxrpc/call_accept.c | 12 ++++++------
 net/rxrpc/io_thread.c   | 14 ++++++++++++++
 net/rxrpc/output.c      | 19 ++++++++++---------
 net/rxrpc/security.c    |  8 ++++----
 5 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index df1a618dbf7d..5b7342d43486 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -44,6 +44,7 @@ enum rxrpc_skb_mark {
 	RXRPC_SKB_MARK_SERVICE_CONN_SECURED, /* Service connection response has been verified */
 	RXRPC_SKB_MARK_REJECT_BUSY,	/* Reject with BUSY */
 	RXRPC_SKB_MARK_REJECT_ABORT,	/* Reject with ABORT (code in skb->priority) */
+	RXRPC_SKB_MARK_REJECT_CONN_ABORT, /* Reject with connection ABORT (code in skb->priority) */
 };
 
 /*
@@ -1253,6 +1254,8 @@ int rxrpc_encap_rcv(struct sock *, struct sk_buff *);
 void rxrpc_error_report(struct sock *);
 bool rxrpc_direct_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
 			s32 abort_code, int err);
+bool rxrpc_direct_conn_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
+			     s32 abort_code, int err);
 int rxrpc_io_thread(void *data);
 void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index a4d76f2da684..00982a030744 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -374,8 +374,8 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	spin_lock(&rx->incoming_lock);
 	if (rx->sk.sk_state == RXRPC_SERVER_LISTEN_DISABLED ||
 	    rx->sk.sk_state == RXRPC_CLOSE) {
-		rxrpc_direct_abort(skb, rxrpc_abort_shut_down,
-				   RX_INVALID_OPERATION, -ESHUTDOWN);
+		rxrpc_direct_conn_abort(skb, rxrpc_abort_shut_down,
+					RX_INVALID_OPERATION, -ESHUTDOWN);
 		goto no_call;
 	}
 
@@ -422,12 +422,12 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 
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
index 27b650d30f4d..e939ecf417c4 100644
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
index 17c33b5cf7dd..8b5903b6e481 100644
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
index 078d91a6b77f..2bfbf2b2bb37 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -140,15 +140,15 @@ const struct rxrpc_security *rxrpc_get_incoming_security(struct rxrpc_sock *rx,
 
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
 


