Return-Path: <stable+bounces-15429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F1838533
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB011C2A4CC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA17E587;
	Tue, 23 Jan 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eutXctpL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A11878;
	Tue, 23 Jan 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975765; cv=none; b=mSe61NVJKlzO58g0s0L9PNhg5fUBpr0lz3f75BFv6iwSYG6A/qvaz+uHVXWMqVYes6z463B/D9vjbFqADPv0L2kclKY+SgHTU9UuI+46yQsNR5Q/LXRIAEH1WFpo01VLP3RWLJrk9O/7cqhBmtUCVUWxYOkARiEduKHtSeJ2ZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975765; c=relaxed/simple;
	bh=HCwm59w6GstglVo2gQYn7EMKn4BEepyjNP1BRvcIoEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQLTMdq0ZPWXy1E6wDp+AccYo8J/xv6Pu8MNEy9jBoCVig3wr/t0FLGdOlNUUjzaAAZtQ2tSG/npfdcwy33MScMe3mStW+iHpjRItWbq0LXs9VqMyTrhbapStapaRokCY2hzBoK7SPB/w5cxTkDuGueJOwQK+Hbily5/rgvdQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eutXctpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF00DC433C7;
	Tue, 23 Jan 2024 02:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975765;
	bh=HCwm59w6GstglVo2gQYn7EMKn4BEepyjNP1BRvcIoEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eutXctpL/dnrg8pw5it1NiCQl3QXUCmOUjnJQKiOtzH3lF3C8vMtcxFMeThUHAsh7
	 OZnFtxrvGemeCj4dGWyH2LEZYaNsLsZ9Yh/7ob6g8tp42l8cH6l/NxoOHxRaIgyfvq
	 mHnfHAovb29Ur7oAsV2t8Ee4kpKHpOfLoRzfDOCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 525/583] rxrpc: Fix use of Dont Fragment flag
Date: Mon, 22 Jan 2024 15:59:36 -0800
Message-ID: <20240122235828.159236241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 8722014311e613244f33952354956a82fa4b0472 ]

rxrpc normally has the Don't Fragment flag set on the UDP packets it
transmits, except when it has decided that DATA packets aren't getting
through - in which case it turns it off just for the DATA transmissions.
This can be a problem, however, for RESPONSE packets that convey
authentication and crypto data from the client to the server as ticket may
be larger than can fit in the MTU.

In such a case, rxrpc gets itself into an infinite loop as the sendmsg
returns an error (EMSGSIZE), which causes rxkad_send_response() to return
-EAGAIN - and the CHALLENGE packet is put back on the Rx queue to retry,
leading to the I/O thread endlessly attempting to perform the transmission.

Fix this by disabling DF on RESPONSE packets for now.  The use of DF and
best data MTU determination needs reconsidering at some point in the
future.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/1581852.1704813048@warthog.procyon.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h  |  1 +
 net/rxrpc/local_object.c | 13 ++++++++++++-
 net/rxrpc/output.c       |  6 ++----
 net/rxrpc/rxkad.c        |  2 ++
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e8e14c6f904d..e8b43408136a 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1076,6 +1076,7 @@ void rxrpc_send_version_request(struct rxrpc_local *local,
 /*
  * local_object.c
  */
+void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set);
 struct rxrpc_local *rxrpc_lookup_local(struct net *, const struct sockaddr_rxrpc *);
 struct rxrpc_local *rxrpc_get_local(struct rxrpc_local *, enum rxrpc_local_trace);
 struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *, enum rxrpc_local_trace);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index c553a30e9c83..34d307368135 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -36,6 +36,17 @@ static void rxrpc_encap_err_rcv(struct sock *sk, struct sk_buff *skb, int err,
 		return ipv6_icmp_error(sk, skb, err, port, info, payload);
 }
 
+/*
+ * Set or clear the Don't Fragment flag on a socket.
+ */
+void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set)
+{
+	if (set)
+		ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_DO);
+	else
+		ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_DONT);
+}
+
 /*
  * Compare a local to an address.  Return -ve, 0 or +ve to indicate less than,
  * same or greater than.
@@ -203,7 +214,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		ip_sock_set_recverr(usk);
 
 		/* we want to set the don't fragment bit */
-		ip_sock_set_mtu_discover(usk, IP_PMTUDISC_DO);
+		rxrpc_local_dont_fragment(local, true);
 
 		/* We want receive timestamps. */
 		sock_enable_timestamps(usk);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5e53429c6922..a0906145e829 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -494,14 +494,12 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	switch (conn->local->srx.transport.family) {
 	case AF_INET6:
 	case AF_INET:
-		ip_sock_set_mtu_discover(conn->local->socket->sk,
-					 IP_PMTUDISC_DONT);
+		rxrpc_local_dont_fragment(conn->local, false);
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_frag);
 		ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 		conn->peer->last_tx_at = ktime_get_seconds();
 
-		ip_sock_set_mtu_discover(conn->local->socket->sk,
-					 IP_PMTUDISC_DO);
+		rxrpc_local_dont_fragment(conn->local, true);
 		break;
 
 	default:
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 1bf571a66e02..b52dedcebce0 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -724,7 +724,9 @@ static int rxkad_send_response(struct rxrpc_connection *conn,
 	serial = atomic_inc_return(&conn->serial);
 	whdr.serial = htonl(serial);
 
+	rxrpc_local_dont_fragment(conn->local, false);
 	ret = kernel_sendmsg(conn->local->socket, &msg, iov, 3, len);
+	rxrpc_local_dont_fragment(conn->local, true);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
 				    rxrpc_tx_point_rxkad_response);
-- 
2.43.0




