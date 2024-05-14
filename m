Return-Path: <stable+bounces-44329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC108C5245
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C28D282B9C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00D12D201;
	Tue, 14 May 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jT+AYiKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5BC2943F;
	Tue, 14 May 2024 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685728; cv=none; b=XhLoWB+nr/PZl9YDSpve3mzryKW05Yw22L1S+lyOBOx6J6ud0JqrxqIabDsx4XuqoDcMFA1Q5ehB9+au5XhCD8OHgeTJv+gLNnIeZ/n6YmdoWwlcZ5kumfbcpJsdly/p9QfAQagez1hM/w1/Qqm17mFotT5+3bBMUuNQvvRAv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685728; c=relaxed/simple;
	bh=u1mMabVPkrc75OaiuXFkqQrw6vT4UfJK03FHmGK2U9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3N101MmLPgV00UFVPaym+oaOIFCpA9VJYVq+Fqde0EUylw2/K9MmveogIb5TZd0/mtNoJC8lvniw4t1fM5xCuyq2Q3289fo9fr04K/Ti1TuCASV8bLgSKJGRvOzgk45ua9uV2DAsPzB0aczeywmS0KC8lj4IYnh0cIkwL3a+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jT+AYiKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29927C2BD10;
	Tue, 14 May 2024 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685727;
	bh=u1mMabVPkrc75OaiuXFkqQrw6vT4UfJK03FHmGK2U9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jT+AYiKjguKu3ujSq80FHXV3A8u+K8iASYNuptxH2Xe2pfRDgHf5/MS7z4qYBV964
	 TC73BHBms0CMHDuXwift6ysH7uqpdu/4hT+amLSLfi6aN3cKf/f5cYkoM2zI4ySbjk
	 XqIS2Tjh3uc1btKiTRuv8YsHGqNJO9MWMTQjlUFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 194/301] rxrpc: Fix the names of the fields in the ACK trailer struct
Date: Tue, 14 May 2024 12:17:45 +0200
Message-ID: <20240514101039.578920932@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

[ Upstream commit 17469ae0582aaacad36e8e858f58b86c369f21ef ]

>From AFS-3.3 a trailer containing extra info was added to the ACK packet
format - but AF_RXRPC has the names of some of the fields mixed up compared
to other AFS implementations.

Rename the struct and the fields to make them match.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
Stable-dep-of: ba4e103848d3 ("rxrpc: Fix congestion control algorithm")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/conn_event.c       | 16 ++++++++--------
 net/rxrpc/input.c            | 22 +++++++++++-----------
 net/rxrpc/output.c           | 14 +++++++-------
 net/rxrpc/protocol.h         |  6 +++---
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 0dd4a21d172da..3322fb93a260b 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -83,7 +83,7 @@
 	EM(rxrpc_badmsg_bad_abort,		"bad-abort")		\
 	EM(rxrpc_badmsg_bad_jumbo,		"bad-jumbo")		\
 	EM(rxrpc_badmsg_short_ack,		"short-ack")		\
-	EM(rxrpc_badmsg_short_ack_info,		"short-ack-info")	\
+	EM(rxrpc_badmsg_short_ack_trailer,	"short-ack-trailer")	\
 	EM(rxrpc_badmsg_short_hdr,		"short-hdr")		\
 	EM(rxrpc_badmsg_unsupported_packet,	"unsup-pkt")		\
 	EM(rxrpc_badmsg_zero_call,		"zero-call")		\
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 1f251d758cb9d..598b4ee389fc1 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -88,7 +88,7 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 			struct rxrpc_ackpacket ack;
 		};
 	} __attribute__((packed)) pkt;
-	struct rxrpc_ackinfo ack_info;
+	struct rxrpc_acktrailer trailer;
 	size_t len;
 	int ret, ioc;
 	u32 serial, mtu, call_id, padding;
@@ -122,8 +122,8 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	iov[0].iov_len	= sizeof(pkt.whdr);
 	iov[1].iov_base	= &padding;
 	iov[1].iov_len	= 3;
-	iov[2].iov_base	= &ack_info;
-	iov[2].iov_len	= sizeof(ack_info);
+	iov[2].iov_base	= &trailer;
+	iov[2].iov_len	= sizeof(trailer);
 
 	serial = rxrpc_get_next_serial(conn);
 
@@ -158,14 +158,14 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 		pkt.ack.serial		= htonl(skb ? sp->hdr.serial : 0);
 		pkt.ack.reason		= skb ? RXRPC_ACK_DUPLICATE : RXRPC_ACK_IDLE;
 		pkt.ack.nAcks		= 0;
-		ack_info.rxMTU		= htonl(rxrpc_rx_mtu);
-		ack_info.maxMTU		= htonl(mtu);
-		ack_info.rwind		= htonl(rxrpc_rx_window_size);
-		ack_info.jumbo_max	= htonl(rxrpc_rx_jumbo_max);
+		trailer.maxMTU		= htonl(rxrpc_rx_mtu);
+		trailer.ifMTU		= htonl(mtu);
+		trailer.rwind		= htonl(rxrpc_rx_window_size);
+		trailer.jumbo_max	= htonl(rxrpc_rx_jumbo_max);
 		pkt.whdr.flags		|= RXRPC_SLOW_START_OK;
 		padding			= 0;
 		iov[0].iov_len += sizeof(pkt.ack);
-		len += sizeof(pkt.ack) + 3 + sizeof(ack_info);
+		len += sizeof(pkt.ack) + 3 + sizeof(trailer);
 		ioc = 3;
 
 		trace_rxrpc_tx_ack(chan->call_debug_id, serial,
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 9691de00ade75..718ffd184ddb6 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -670,14 +670,14 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 /*
  * Process the extra information that may be appended to an ACK packet
  */
-static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
-				struct rxrpc_ackinfo *ackinfo)
+static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb,
+				    struct rxrpc_acktrailer *trailer)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_peer *peer;
 	unsigned int mtu;
 	bool wake = false;
-	u32 rwind = ntohl(ackinfo->rwind);
+	u32 rwind = ntohl(trailer->rwind);
 
 	if (rwind > RXRPC_TX_MAX_WINDOW)
 		rwind = RXRPC_TX_MAX_WINDOW;
@@ -691,7 +691,7 @@ static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
 	if (call->cong_ssthresh > rwind)
 		call->cong_ssthresh = rwind;
 
-	mtu = min(ntohl(ackinfo->rxMTU), ntohl(ackinfo->maxMTU));
+	mtu = min(ntohl(trailer->maxMTU), ntohl(trailer->ifMTU));
 
 	peer = call->peer;
 	if (mtu < peer->maxdata) {
@@ -837,7 +837,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	struct rxrpc_ack_summary summary = { 0 };
 	struct rxrpc_ackpacket ack;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxrpc_ackinfo info;
+	struct rxrpc_acktrailer trailer;
 	rxrpc_serial_t ack_serial, acked_serial;
 	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt, since;
 	int nr_acks, offset, ioffset;
@@ -917,11 +917,11 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		goto send_response;
 	}
 
-	info.rxMTU = 0;
+	trailer.maxMTU = 0;
 	ioffset = offset + nr_acks + 3;
-	if (skb->len >= ioffset + sizeof(info) &&
-	    skb_copy_bits(skb, ioffset, &info, sizeof(info)) < 0)
-		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack_info);
+	if (skb->len >= ioffset + sizeof(trailer) &&
+	    skb_copy_bits(skb, ioffset, &trailer, sizeof(trailer)) < 0)
+		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack_trailer);
 
 	if (nr_acks > 0)
 		skb_condense(skb);
@@ -950,8 +950,8 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	}
 
 	/* Parse rwind and mtu sizes if provided. */
-	if (info.rxMTU)
-		rxrpc_input_ackinfo(call, skb, &info);
+	if (trailer.maxMTU)
+		rxrpc_input_ack_trailer(call, skb, &trailer);
 
 	if (first_soft_ack == 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_zero);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 4a292f860ae37..cad6a7d18e040 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -83,7 +83,7 @@ static size_t rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 				 struct rxrpc_txbuf *txb,
 				 u16 *_rwind)
 {
-	struct rxrpc_ackinfo ackinfo;
+	struct rxrpc_acktrailer trailer;
 	unsigned int qsize, sack, wrap, to;
 	rxrpc_seq_t window, wtop;
 	int rsize;
@@ -126,16 +126,16 @@ static size_t rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 	qsize = (window - 1) - call->rx_consumed;
 	rsize = max_t(int, call->rx_winsize - qsize, 0);
 	*_rwind = rsize;
-	ackinfo.rxMTU		= htonl(rxrpc_rx_mtu);
-	ackinfo.maxMTU		= htonl(mtu);
-	ackinfo.rwind		= htonl(rsize);
-	ackinfo.jumbo_max	= htonl(jmax);
+	trailer.maxMTU		= htonl(rxrpc_rx_mtu);
+	trailer.ifMTU		= htonl(mtu);
+	trailer.rwind		= htonl(rsize);
+	trailer.jumbo_max	= htonl(jmax);
 
 	*ackp++ = 0;
 	*ackp++ = 0;
 	*ackp++ = 0;
-	memcpy(ackp, &ackinfo, sizeof(ackinfo));
-	return txb->ack.nAcks + 3 + sizeof(ackinfo);
+	memcpy(ackp, &trailer, sizeof(trailer));
+	return txb->ack.nAcks + 3 + sizeof(trailer);
 }
 
 /*
diff --git a/net/rxrpc/protocol.h b/net/rxrpc/protocol.h
index e8ee4af43ca89..4fe6b4d20ada9 100644
--- a/net/rxrpc/protocol.h
+++ b/net/rxrpc/protocol.h
@@ -135,9 +135,9 @@ struct rxrpc_ackpacket {
 /*
  * ACK packets can have a further piece of information tagged on the end
  */
-struct rxrpc_ackinfo {
-	__be32		rxMTU;		/* maximum Rx MTU size (bytes) [AFS 3.3] */
-	__be32		maxMTU;		/* maximum interface MTU size (bytes) [AFS 3.3] */
+struct rxrpc_acktrailer {
+	__be32		maxMTU;		/* maximum Rx MTU size (bytes) [AFS 3.3] */
+	__be32		ifMTU;		/* maximum interface MTU size (bytes) [AFS 3.3] */
 	__be32		rwind;		/* Rx window size (packets) [AFS 3.4] */
 	__be32		jumbo_max;	/* max packets to stick into a jumbo packet [AFS 3.5] */
 };
-- 
2.43.0




