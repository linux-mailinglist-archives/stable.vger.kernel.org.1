Return-Path: <stable+bounces-212715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB/aM5Glemmw8wEAu9opvQ
	(envelope-from <stable+bounces-212715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:10:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03910AA20C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75CA93002D33
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8FBB67E;
	Thu, 29 Jan 2026 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahYpMWDy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FF12B93
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645453; cv=none; b=DRPUH9IyFSXvE8w5pzoC9IiKoogARAVuAS1+AgkSjWoblJPp4853upObfYYOkD01fiNTobS6FyF0JjrJJhg3C6qiwMFrZYrg0U7b01Sh6ybbebOzC9L7PM4CCgni6G+smHaM5RQmcNF6F9mTW4M85Z4GCn/3D6nj5BWF6/e6HXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645453; c=relaxed/simple;
	bh=BVgRqlDYh+3oOecYjAF8iQUKmATREbpksWqqReZk5Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzp0pfbbjpRCkXPa5tmBfJdhLZ2H/zF9cAZisWlbPCWbJVEs4tieE1LYPU6tisOCYH5CUgN4Q16DA7pN7i+Wupq0yj9Vd1SaDK4V2/JpqpeBZ2QWYE+3UEjlZl4quOuuNUYeWW2OS+RKKfq3Yve3/IGE+Iz49fF8+78EUEVa6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahYpMWDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C9C4CEF1;
	Thu, 29 Jan 2026 00:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769645452;
	bh=BVgRqlDYh+3oOecYjAF8iQUKmATREbpksWqqReZk5Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahYpMWDyhQwwKxAjWa/5Vvq4fX3eOWrM4coRpiQfh7OLcasHEpLfhSNBa+H3zJHfu
	 FYoqtO8vbynoEmVJkkC149zmaJ1sPeHzV+S7AdmQxWZOHoAZ/rziDDfiKfTu6IShea
	 Yle5Z/0HcXZVt/i9eb8FyZqUxLLsfpjxf7t35YSDBhzrJWH5TQ1QMpNUqO3vabPSne
	 xhoSDHw5Sb81zWlxjjokmSDmzu9otd5S3cfdmbCuqppG/tFJ9Xz/SokTgwoZBJDpyM
	 82LiLWkTZXGPG6Itb9ISAWWwwxTK++y2P+mJ8+5ZqFF6p8y4dwoO8BvMwr7XQCfGdR
	 /jIORKViT/YGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] rxrpc: Fix data-race warning and potential load/store tearing
Date: Wed, 28 Jan 2026 19:10:48 -0500
Message-ID: <20260129001048.2933922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012755-value-visa-db01@gregkh>
References: <2026012755-value-visa-db01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212715-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,6182afad5045e6703b3d];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 03910AA20C
X-Rspamd-Action: no action

From: David Howells <dhowells@redhat.com>

[ Upstream commit 5d5fe8bcd331f1e34e0943ec7c18432edfcf0e8b ]

Fix the following:

        BUG: KCSAN: data-race in rxrpc_peer_keepalive_worker / rxrpc_send_data_packet

which is reporting an issue with the reads and writes to ->last_tx_at in:

        conn->peer->last_tx_at = ktime_get_seconds();

and:

        keepalive_at = peer->last_tx_at + RXRPC_KEEPALIVE_TIME;

The lockless accesses to these to values aren't actually a problem as the
read only needs an approximate time of last transmission for the purposes
of deciding whether or not the transmission of a keepalive packet is
warranted yet.

Also, as ->last_tx_at is a 64-bit value, tearing can occur on a 32-bit
arch.

Fix both of these by switching to an unsigned int for ->last_tx_at and only
storing the LSW of the time64_t.  It can then be reconstructed at need
provided no more than 68 years has elapsed since the last transmission.

Fixes: ace45bec6d77 ("rxrpc: Fix firewall route keepalive")
Reported-by: syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/695e7cfb.050a0220.1c677c.036b.GAE@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/1107124.1768903985@warthog.procyon.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ different struct fields (peer->mtu, peer->srtt_us, peer->rto_us) and different output.c code structure ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h |  9 ++++++++-
 net/rxrpc/conn_event.c  |  2 +-
 net/rxrpc/output.c      | 10 +++++-----
 net/rxrpc/peer_event.c  | 17 ++++++++++++++++-
 net/rxrpc/proc.c        |  4 ++--
 net/rxrpc/rxkad.c       |  4 ++--
 6 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 6b036c0564c7a..1494d162444dd 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -335,7 +335,7 @@ struct rxrpc_peer {
 	struct hlist_head	error_targets;	/* targets for net error distribution */
 	struct rb_root		service_conns;	/* Service connections */
 	struct list_head	keepalive_link;	/* Link in net->peer_keepalive[] */
-	time64_t		last_tx_at;	/* Last time packet sent here */
+	unsigned int		last_tx_at;	/* Last time packet sent here (time64_t LSW) */
 	seqlock_t		service_conn_lock;
 	spinlock_t		lock;		/* access lock */
 	unsigned int		if_mtu;		/* interface MTU for this peer */
@@ -1161,6 +1161,13 @@ void rxrpc_transmit_one(struct rxrpc_call *call, struct rxrpc_txbuf *txb);
 void rxrpc_input_error(struct rxrpc_local *, struct sk_buff *);
 void rxrpc_peer_keepalive_worker(struct work_struct *);
 
+/* Update the last transmission time on a peer for keepalive purposes. */
+static inline void rxrpc_peer_mark_tx(struct rxrpc_peer *peer)
+{
+	/* To avoid tearing on 32-bit systems, we only keep the LSW. */
+	WRITE_ONCE(peer->last_tx_at, ktime_get_seconds());
+}
+
 /*
  * peer_object.c
  */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index c4eb7986efddf..c8df12d80c7ce 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -180,7 +180,7 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	}
 
 	ret = kernel_sendmsg(conn->local->socket, &msg, iov, ioc, len);
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(chan->call_debug_id, serial, ret,
 				    rxrpc_tx_point_call_final_resend);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ccfae607c9bb7..ad7e61066d2b5 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -209,7 +209,7 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, txb->len);
 	rxrpc_local_dont_fragment(conn->local, false);
 	ret = do_udp_sendmsg(conn->local->socket, &msg, txb->len);
-	call->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(call->peer);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
 				    rxrpc_tx_point_call_ack);
@@ -310,7 +310,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, sizeof(pkt));
 	ret = do_udp_sendmsg(conn->local->socket, &msg, sizeof(pkt));
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
 				    rxrpc_tx_point_call_abort);
@@ -486,7 +486,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	 */
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_send);
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 
 	if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
@@ -573,7 +573,7 @@ void rxrpc_send_conn_abort(struct rxrpc_connection *conn)
 
 	trace_rxrpc_tx_packet(conn->debug_id, &whdr, rxrpc_tx_point_conn_abort);
 
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 }
 
 /*
@@ -692,7 +692,7 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 		trace_rxrpc_tx_packet(peer->debug_id, &whdr,
 				      rxrpc_tx_point_version_keepalive);
 
-	peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(peer);
 	_leave("");
 }
 
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 5d0842efde69f..adcfb3eb9f511 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -224,6 +224,21 @@ static void rxrpc_distribute_error(struct rxrpc_peer *peer, struct sk_buff *skb,
 	spin_unlock(&peer->lock);
 }
 
+/*
+ * Reconstruct the last transmission time.  The difference calculated should be
+ * valid provided no more than ~68 years elapsed since the last transmission.
+ */
+static time64_t rxrpc_peer_get_tx_mark(const struct rxrpc_peer *peer, time64_t base)
+{
+	s32 last_tx_at = READ_ONCE(peer->last_tx_at);
+	s32 base_lsw = base;
+	s32 diff = last_tx_at - base_lsw;
+
+	diff = clamp(diff, -RXRPC_KEEPALIVE_TIME, RXRPC_KEEPALIVE_TIME);
+
+	return diff + base;
+}
+
 /*
  * Perform keep-alive pings.
  */
@@ -252,7 +267,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 		spin_unlock_bh(&rxnet->peer_hash_lock);
 
 		if (use) {
-			keepalive_at = peer->last_tx_at + RXRPC_KEEPALIVE_TIME;
+			keepalive_at = rxrpc_peer_get_tx_mark(peer, base) + RXRPC_KEEPALIVE_TIME;
 			slot = keepalive_at - base;
 			_debug("%02x peer %u t=%d {%pISp}",
 			       cursor, peer->debug_id, slot, &peer->srx.transport);
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 263a2251e3d24..ca85ac764f82b 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -299,13 +299,13 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 	now = ktime_get_seconds();
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %3u"
-		   " %3u %5u %6llus %8u %8u\n",
+		   " %3u %5u %6ds %8u %8u\n",
 		   lbuff,
 		   rbuff,
 		   refcount_read(&peer->ref),
 		   peer->cong_ssthresh,
 		   peer->mtu,
-		   now - peer->last_tx_at,
+		   (s32)now - (s32)READ_ONCE(peer->last_tx_at),
 		   peer->srtt_us >> 3,
 		   peer->rto_us);
 
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 48a1475e6b063..a8426335e401a 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -676,7 +676,7 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 		return -EAGAIN;
 	}
 
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	trace_rxrpc_tx_packet(conn->debug_id, &whdr,
 			      rxrpc_tx_point_rxkad_challenge);
 	_leave(" = 0");
@@ -734,7 +734,7 @@ static int rxkad_send_response(struct rxrpc_connection *conn,
 		return -EAGAIN;
 	}
 
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	_leave(" = 0");
 	return 0;
 }
-- 
2.51.0


