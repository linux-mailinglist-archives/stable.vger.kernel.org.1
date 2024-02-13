Return-Path: <stable+bounces-20052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0C85389C
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358001C264FC
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570A8604D6;
	Tue, 13 Feb 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EYT4kK12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100205FF0E;
	Tue, 13 Feb 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845905; cv=none; b=NaM/5yLXx6Fus9Hdmq7VmzCfuu3A8eFkl1mu0ujgZ27D20FD2RPhKwXyxCre0yk0L2uG4cnGO5REEt4aXjOwLanTWNGJD3PvKDu4LtWYGZQpDGxp0zPXJ+25W6GjnWK8oRrcYSnSbsEX++aiOe8r6AHDOCRLa/g23+THCXMdY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845905; c=relaxed/simple;
	bh=f7MeqJTwSDPg+3l+dyyJ2kYWZpEBkRBmrucRz0tmbAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUVS7HM1xTUKLVzjO0Zr5SmsMTLhdzMJlSyQsgxd0IxRaziBdFt8tdJiWQqlzC2F2K/2yyeNtfjBKJ8Z6GCtxiNr9U5/nsQT1s8MVmXsKxySH11ovDulkm19q6H8p4vtPnqKwPn5Zvwj5Oo/W6eFoGVTch0ezVQqVG1SdGr0nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EYT4kK12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66620C43394;
	Tue, 13 Feb 2024 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845904;
	bh=f7MeqJTwSDPg+3l+dyyJ2kYWZpEBkRBmrucRz0tmbAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYT4kK12/kJZJqN3i90bOf8Lt3V8R2U5n0m8B+30dc3KFAcTv0Mww6uG5ijIBKd/G
	 0jmAauB4h25Vd2NBUsEsdQET1RFh2VmO4jPrT4ZAe8KmFIq2WSjlpo3wnxOIFZSWlv
	 o2xVfiz6k++7vFbJDZdWkuTRGiki2PMMVp04TR7w=
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
Subject: [PATCH 6.7 052/124] rxrpc: Fix counting of new acks and nacks
Date: Tue, 13 Feb 2024 18:21:14 +0100
Message-ID: <20240213171855.259591828@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
References: <20240213171853.722912593@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 41b7fa157ea1c8c3a575ca7f5f32034de9bee3ae ]

Fix the counting of new acks and nacks when parsing a packet - something
that is used in congestion control.

As the code stands, it merely notes if there are any nacks whereas what we
really should do is compare the previous SACK table to the new one,
assuming we get two successive ACK packets with nacks in them.  However, we
really don't want to do that if we can avoid it as the tables might not
correspond directly as one may be shifted from the other - something that
will only get harder to deal with once extended ACK tables come into full
use (with a capacity of up to 8192).

Instead, count the number of nacks shifted out of the old SACK, the number
of nacks retained in the portion still active and the number of new acks
and nacks in the new table then calculate what we need.

Note this ends up a bit of an estimate as the Rx protocol allows acks to be
withdrawn by the receiver and packets requested to be retransmitted.

Fixes: d57a3a151660 ("rxrpc: Save last ACK's SACK table rather than marking txbufs")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h |   8 ++-
 net/rxrpc/ar-internal.h      |  20 ++++--
 net/rxrpc/call_event.c       |   6 +-
 net/rxrpc/call_object.c      |   1 +
 net/rxrpc/input.c            | 115 +++++++++++++++++++++++++++++------
 5 files changed, 122 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 4c1ef7b3705c..87b8de9b6c1c 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -128,6 +128,7 @@
 	EM(rxrpc_skb_eaten_by_unshare_nomem,	"ETN unshar-nm") \
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
+	EM(rxrpc_skb_get_last_nack,		"GET last-nack") \
 	EM(rxrpc_skb_get_local_work,		"GET locl-work") \
 	EM(rxrpc_skb_get_reject_work,		"GET rej-work ") \
 	EM(rxrpc_skb_get_to_recvmsg,		"GET to-recv  ") \
@@ -141,6 +142,7 @@
 	EM(rxrpc_skb_put_error_report,		"PUT error-rep") \
 	EM(rxrpc_skb_put_input,			"PUT input    ") \
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
+	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
@@ -1552,7 +1554,7 @@ TRACE_EVENT(rxrpc_congest,
 		    memcpy(&__entry->sum, summary, sizeof(__entry->sum));
 			   ),
 
-	    TP_printk("c=%08x r=%08x %s q=%08x %s cw=%u ss=%u nA=%u,%u+%u r=%u b=%u u=%u d=%u l=%x%s%s%s",
+	    TP_printk("c=%08x r=%08x %s q=%08x %s cw=%u ss=%u nA=%u,%u+%u,%u b=%u u=%u d=%u l=%x%s%s%s",
 		      __entry->call,
 		      __entry->ack_serial,
 		      __print_symbolic(__entry->sum.ack_reason, rxrpc_ack_names),
@@ -1560,9 +1562,9 @@ TRACE_EVENT(rxrpc_congest,
 		      __print_symbolic(__entry->sum.mode, rxrpc_congest_modes),
 		      __entry->sum.cwnd,
 		      __entry->sum.ssthresh,
-		      __entry->sum.nr_acks, __entry->sum.saw_nacks,
+		      __entry->sum.nr_acks, __entry->sum.nr_retained_nacks,
 		      __entry->sum.nr_new_acks,
-		      __entry->sum.nr_rot_new_acks,
+		      __entry->sum.nr_new_nacks,
 		      __entry->top - __entry->hard_ack,
 		      __entry->sum.cumulative_acks,
 		      __entry->sum.dup_acks,
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 041add7654b2..027414dafe7f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -198,11 +198,19 @@ struct rxrpc_host_header {
  */
 struct rxrpc_skb_priv {
 	struct rxrpc_connection *conn;	/* Connection referred to (poke packet) */
-	u16		offset;		/* Offset of data */
-	u16		len;		/* Length of data */
-	u8		flags;
+	union {
+		struct {
+			u16		offset;		/* Offset of data */
+			u16		len;		/* Length of data */
+			u8		flags;
 #define RXRPC_RX_VERIFIED	0x01
-
+		};
+		struct {
+			rxrpc_seq_t	first_ack;	/* First packet in acks table */
+			u8		nr_acks;	/* Number of acks+nacks */
+			u8		nr_nacks;	/* Number of nacks */
+		};
+	};
 	struct rxrpc_host_header hdr;	/* RxRPC packet header from this packet */
 };
 
@@ -689,6 +697,7 @@ struct rxrpc_call {
 	u8			cong_dup_acks;	/* Count of ACKs showing missing packets */
 	u8			cong_cumul_acks; /* Cumulative ACK count */
 	ktime_t			cong_tstamp;	/* Last time cwnd was changed */
+	struct sk_buff		*cong_last_nack; /* Last ACK with nacks received */
 
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
@@ -726,7 +735,8 @@ struct rxrpc_call {
 struct rxrpc_ack_summary {
 	u16			nr_acks;		/* Number of ACKs in packet */
 	u16			nr_new_acks;		/* Number of new ACKs in packet */
-	u16			nr_rot_new_acks;	/* Number of rotated new ACKs */
+	u16			nr_new_nacks;		/* Number of new nacks in packet */
+	u16			nr_retained_nacks;	/* Number of nacks retained between ACKs */
 	u8			ack_reason;
 	bool			saw_nacks;		/* Saw NACKs in packet */
 	bool			new_low_nack;		/* T if new low NACK found */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index c61efe08695d..0f78544d043b 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -112,6 +112,7 @@ static void rxrpc_congestion_timeout(struct rxrpc_call *call)
 void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 {
 	struct rxrpc_ackpacket *ack = NULL;
+	struct rxrpc_skb_priv *sp;
 	struct rxrpc_txbuf *txb;
 	unsigned long resend_at;
 	rxrpc_seq_t transmitted = READ_ONCE(call->tx_transmitted);
@@ -139,14 +140,15 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	 * explicitly NAK'd packets.
 	 */
 	if (ack_skb) {
+		sp = rxrpc_skb(ack_skb);
 		ack = (void *)ack_skb->data + sizeof(struct rxrpc_wire_header);
 
-		for (i = 0; i < ack->nAcks; i++) {
+		for (i = 0; i < sp->nr_acks; i++) {
 			rxrpc_seq_t seq;
 
 			if (ack->acks[i] & 1)
 				continue;
-			seq = ntohl(ack->firstPacket) + i;
+			seq = sp->first_ack + i;
 			if (after(txb->seq, transmitted))
 				break;
 			if (after(txb->seq, seq))
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 0943e54370ba..9fc9a6c3f685 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -686,6 +686,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 
 	del_timer_sync(&call->timer);
 
+	rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
 	rxrpc_cleanup_ring(call);
 	while ((txb = list_first_entry_or_null(&call->tx_sendmsg,
 					       struct rxrpc_txbuf, call_link))) {
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 92495e73b869..9691de00ade7 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -45,11 +45,9 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	}
 
 	cumulative_acks += summary->nr_new_acks;
-	cumulative_acks += summary->nr_rot_new_acks;
 	if (cumulative_acks > 255)
 		cumulative_acks = 255;
 
-	summary->mode = call->cong_mode;
 	summary->cwnd = call->cong_cwnd;
 	summary->ssthresh = call->cong_ssthresh;
 	summary->cumulative_acks = cumulative_acks;
@@ -151,6 +149,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		cwnd = RXRPC_TX_MAX_WINDOW;
 	call->cong_cwnd = cwnd;
 	call->cong_cumul_acks = cumulative_acks;
+	summary->mode = call->cong_mode;
 	trace_rxrpc_congest(call, summary, acked_serial, change);
 	if (resend)
 		rxrpc_resend(call, skb);
@@ -213,7 +212,6 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 	list_for_each_entry_rcu(txb, &call->tx_buffer, call_link, false) {
 		if (before_eq(txb->seq, call->acks_hard_ack))
 			continue;
-		summary->nr_rot_new_acks++;
 		if (test_bit(RXRPC_TXBUF_LAST, &txb->flags)) {
 			set_bit(RXRPC_CALL_TX_LAST, &call->flags);
 			rot_last = true;
@@ -254,6 +252,11 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 {
 	ASSERT(test_bit(RXRPC_CALL_TX_LAST, &call->flags));
 
+	if (unlikely(call->cong_last_nack)) {
+		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
+		call->cong_last_nack = NULL;
+	}
+
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
 	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
@@ -702,6 +705,43 @@ static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
 		wake_up(&call->waitq);
 }
 
+/*
+ * Determine how many nacks from the previous ACK have now been satisfied.
+ */
+static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
+					      struct rxrpc_ack_summary *summary,
+					      rxrpc_seq_t seq)
+{
+	struct sk_buff *skb = call->cong_last_nack;
+	struct rxrpc_ackpacket ack;
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	unsigned int i, new_acks = 0, retained_nacks = 0;
+	rxrpc_seq_t old_seq = sp->first_ack;
+	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(ack);
+
+	if (after_eq(seq, old_seq + sp->nr_acks)) {
+		summary->nr_new_acks += sp->nr_nacks;
+		summary->nr_new_acks += seq - (old_seq + sp->nr_acks);
+		summary->nr_retained_nacks = 0;
+	} else if (seq == old_seq) {
+		summary->nr_retained_nacks = sp->nr_nacks;
+	} else {
+		for (i = 0; i < sp->nr_acks; i++) {
+			if (acks[i] == RXRPC_ACK_TYPE_NACK) {
+				if (before(old_seq + i, seq))
+					new_acks++;
+				else
+					retained_nacks++;
+			}
+		}
+
+		summary->nr_new_acks += new_acks;
+		summary->nr_retained_nacks = retained_nacks;
+	}
+
+	return old_seq + sp->nr_acks;
+}
+
 /*
  * Process individual soft ACKs.
  *
@@ -711,25 +751,51 @@ static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
  * the timer on the basis that the peer might just not have processed them at
  * the time the ACK was sent.
  */
-static void rxrpc_input_soft_acks(struct rxrpc_call *call, u8 *acks,
-				  rxrpc_seq_t seq, int nr_acks,
-				  struct rxrpc_ack_summary *summary)
+static void rxrpc_input_soft_acks(struct rxrpc_call *call,
+				  struct rxrpc_ack_summary *summary,
+				  struct sk_buff *skb,
+				  rxrpc_seq_t seq,
+				  rxrpc_seq_t since)
 {
-	unsigned int i;
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	unsigned int i, old_nacks = 0;
+	rxrpc_seq_t lowest_nak = seq + sp->nr_acks;
+	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
-	for (i = 0; i < nr_acks; i++) {
+	for (i = 0; i < sp->nr_acks; i++) {
 		if (acks[i] == RXRPC_ACK_TYPE_ACK) {
 			summary->nr_acks++;
-			summary->nr_new_acks++;
+			if (after_eq(seq, since))
+				summary->nr_new_acks++;
 		} else {
-			if (!summary->saw_nacks &&
-			    call->acks_lowest_nak != seq + i) {
-				call->acks_lowest_nak = seq + i;
-				summary->new_low_nack = true;
-			}
 			summary->saw_nacks = true;
+			if (before(seq, since)) {
+				/* Overlap with previous ACK */
+				old_nacks++;
+			} else {
+				summary->nr_new_nacks++;
+				sp->nr_nacks++;
+			}
+
+			if (before(seq, lowest_nak))
+				lowest_nak = seq;
 		}
+		seq++;
+	}
+
+	if (lowest_nak != call->acks_lowest_nak) {
+		call->acks_lowest_nak = lowest_nak;
+		summary->new_low_nack = true;
 	}
+
+	/* We *can* have more nacks than we did - the peer is permitted to drop
+	 * packets it has soft-acked and re-request them.  Further, it is
+	 * possible for the nack distribution to change whilst the number of
+	 * nacks stays the same or goes down.
+	 */
+	if (old_nacks < summary->nr_retained_nacks)
+		summary->nr_new_acks += summary->nr_retained_nacks - old_nacks;
+	summary->nr_retained_nacks = old_nacks;
 }
 
 /*
@@ -773,7 +839,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_ackinfo info;
 	rxrpc_serial_t ack_serial, acked_serial;
-	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt;
+	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt, since;
 	int nr_acks, offset, ioffset;
 
 	_enter("");
@@ -789,6 +855,8 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	prev_pkt = ntohl(ack.previousPacket);
 	hard_ack = first_soft_ack - 1;
 	nr_acks = ack.nAcks;
+	sp->first_ack = first_soft_ack;
+	sp->nr_acks = nr_acks;
 	summary.ack_reason = (ack.reason < RXRPC_ACK__INVALID ?
 			      ack.reason : RXRPC_ACK__INVALID);
 
@@ -858,6 +926,16 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0)
 		skb_condense(skb);
 
+	if (call->cong_last_nack) {
+		since = rxrpc_input_check_prev_ack(call, &summary, first_soft_ack);
+		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
+		call->cong_last_nack = NULL;
+	} else {
+		summary.nr_new_acks = first_soft_ack - call->acks_first_seq;
+		call->acks_lowest_nak = first_soft_ack + nr_acks;
+		since = first_soft_ack;
+	}
+
 	call->acks_latest_ts = skb->tstamp;
 	call->acks_first_seq = first_soft_ack;
 	call->acks_prev_seq = prev_pkt;
@@ -866,7 +944,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	case RXRPC_ACK_PING:
 		break;
 	default:
-		if (after(acked_serial, call->acks_highest_serial))
+		if (acked_serial && after(acked_serial, call->acks_highest_serial))
 			call->acks_highest_serial = acked_serial;
 		break;
 	}
@@ -905,8 +983,9 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0) {
 		if (offset > (int)skb->len - nr_acks)
 			return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_short_sack);
-		rxrpc_input_soft_acks(call, skb->data + offset, first_soft_ack,
-				      nr_acks, &summary);
+		rxrpc_input_soft_acks(call, &summary, skb, first_soft_ack, since);
+		rxrpc_get_skb(skb, rxrpc_skb_get_last_nack);
+		call->cong_last_nack = skb;
 	}
 
 	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags) &&
-- 
2.43.0




