Return-Path: <stable+bounces-163133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB6B0751C
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63EC7B088D
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1B2F5469;
	Wed, 16 Jul 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPnV4TPO"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0642F49F6
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666829; cv=none; b=Rh+it41VcDbpFxfXyTuXmCU8lTMPkr21gQ88AyzzF1vRTVOOH6uGY2tVBLRBaP3aEEqjEXWAz/zp0izRNALt2tfz+tJa3ASGtLrn9be+srtf8wGflvuSOs8oSnLzrlxJsuFOFeyhUj5b9iudwlKOiQjETMYXkS6poISEccQH738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666829; c=relaxed/simple;
	bh=2KW2U/A4gk5SgRyGyeIXAj3+QH8TPX34JpTVHS++XsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQCrAV6IVoxZ+qj95Taj3bP/4Mfk4s+QlYh057X7DNHeosfiOFGp1D5o9Hz5BHB3q7mj5VulGDQEgASX6ic1gbGge/2fMmDVXxPiGbTOPu2a7KNbebGqp7bRsuuVIlmYADsIjz/WViB1Rz1glScWI9od65jVyzPVKJYegtZ3mOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPnV4TPO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752666826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTjUnh8vzEtgGLxjFhakJRJqQjzQoh5z0pfGHbTFfL8=;
	b=BPnV4TPOfPPrUVN21yQcCFEgZMLursy8/xL8zcmR9BCLjdGiYBVxVc+PWaIVnEBFjHHAu/
	ufIw6hbKWeYTfb3BlBmgdrIvaIazF7g/6Y/hDASc7iTNqCoCV2Bw3PICTdjfLdsU/LTD2c
	WPAeC4pHGDssgtnVu12bL+AKPWn67ck=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-Av5-SLWRMbG6gvHGAc7-Ig-1; Wed,
 16 Jul 2025 07:53:42 -0400
X-MC-Unique: Av5-SLWRMbG6gvHGAc7-Ig-1
X-Mimecast-MFC-AGG-ID: Av5-SLWRMbG6gvHGAc7-Ig_1752666821
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B32419560AA;
	Wed, 16 Jul 2025 11:53:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E5DD195E772;
	Wed, 16 Jul 2025 11:53:37 +0000 (UTC)
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
Subject: [PATCH net 5/5] rxrpc: Fix to use conn aborts for conn-wide failures
Date: Wed, 16 Jul 2025 12:53:04 +0100
Message-ID: <20250716115307.3572606-6-dhowells@redhat.com>
In-Reply-To: <20250716115307.3572606-1-dhowells@redhat.com>
References: <20250716115307.3572606-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 include/trace/events/rxrpc.h |  1 +
 net/rxrpc/ar-internal.h      |  3 +++
 net/rxrpc/call_accept.c      | 12 ++++++------
 net/rxrpc/io_thread.c        | 14 ++++++++++++++
 net/rxrpc/output.c           | 19 ++++++++++---------
 net/rxrpc/security.c         |  8 ++++----
 6 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 8e5a73eb5268..de6f6d25767c 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -322,6 +322,7 @@
 	EM(rxrpc_call_put_kernel,		"PUT kernel  ") \
 	EM(rxrpc_call_put_poke,			"PUT poke    ") \
 	EM(rxrpc_call_put_recvmsg,		"PUT recvmsg ") \
+	EM(rxrpc_call_put_release_recvmsg_q,	"PUT rls-rcmq") \
 	EM(rxrpc_call_put_release_sock,		"PUT rls-sock") \
 	EM(rxrpc_call_put_release_sock_tba,	"PUT rls-sk-a") \
 	EM(rxrpc_call_put_sendmsg,		"PUT sendmsg ") \
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
 


