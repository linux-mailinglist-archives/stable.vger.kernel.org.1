Return-Path: <stable+bounces-219886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COg6B9rroGkpoAQAu9opvQ
	(envelope-from <stable+bounces-219886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:56:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF01B15B2
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63ECF303C4E3
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44842877DE;
	Fri, 27 Feb 2026 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AhmhFqEO"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F9261B8D;
	Fri, 27 Feb 2026 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153811; cv=none; b=DAcMJikKbbTaTeJG1etxG5uP6geQFpHST1xBTmUVX2AByDeB5DMRUb2610++CjnjW+/Px2mqKAu4gBgGZhCPYoWqdFtBPHiVwKmRPpnEFGJ57kr6tXtLqroMIJ8AcTAMgYuF0TTsA5HzWDXtGSWgKW5Rci0i7zkJBxHzvz7Euto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153811; c=relaxed/simple;
	bh=DQQbDPc2oN1YrvJql9VmDAYviiT9ajcPWd/ptfbzn/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bM3GxBSiirFNjZ6zWWO7Aw98lrGrO/TpD50vaXbcLS96WQJ3AxX+nLUTbLRNz0+aC+UgQZJNy0DYXIUe3Ng1gn13j47p/KCyxwkDpcGOrdXi0BgVs4GsPRn97KE3u1CJwoYVpLkCxEoJmBXJepiNCYobIw71r71R9cHOjf+R6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AhmhFqEO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=T1
	S84BQzjHyE2f/VMqqizvcvOCsP9EFAfwDD9uJEDuA=; b=AhmhFqEOtY80YF3W9b
	6/5rVH9WzVXPDe2gu6VQOaeHUe7/j6bvTdBfnTb/bv0g8sOZ/OAM/5pVFjJHRN/I
	pFcPEuRk9smADXIfb5JoJNZSbgbXXS2KKtLTXc4EtYgreFWFdFx+JeAvNOuWsLyd
	I+zhk24gnRB7Ho2O0GNSrnuoU=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXf_GI66BpqkJQNg--.25260S2;
	Fri, 27 Feb 2026 08:55:36 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.6.y] rxrpc: Fix data-race warning and potential load/store tearing
Date: Fri, 27 Feb 2026 08:54:46 +0800
Message-Id: <20260227005446.552393-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf_GI66BpqkJQNg--.25260S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrW5CFyxWrW5ZFWxWF1rWFg_yoWfJr4rpF
	W5CrZIyrWkGr4S9r48Ar4kZas8Ww1kJr15Kry7uw4Fy393JFy3XF18Kr4jqF15Ww48GFy3
	ZF4Dt3WDAFsrCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE9YwUUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3QqfOWmg64po8AAA3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,syzkaller.appspotmail.com,auristor.com,kernel.org,lists.infradead.org,163.com];
	TAGGED_FROM(0.00)[bounces-219886-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable,6182afad5045e6703b3d];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 41BF01B15B2
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
[ The context change is due to the commit f3a123b25429
("rxrpc: Allow the app to store private data on peer structs"),
the commit 372d12d191cb
("rxrpc: Add a reason indicator to the tx_data tracepoint"),
the commit 153f90a066dd
("rxrpc: Use ktimes for call timeout tracking and set the timer lazily")
and the commit 9d1d2b59341f
("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI))
which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 net/rxrpc/ar-internal.h |  9 ++++++++-
 net/rxrpc/conn_event.c  |  2 +-
 net/rxrpc/output.c      | 11 ++++++-----
 net/rxrpc/peer_event.c  | 17 ++++++++++++++++-
 net/rxrpc/proc.c        |  4 ++--
 net/rxrpc/rxkad.c       |  2 +-
 6 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 86438c86eb2f..f4512761f572 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -331,7 +331,7 @@ struct rxrpc_peer {
 	struct hlist_head	error_targets;	/* targets for net error distribution */
 	struct rb_root		service_conns;	/* Service connections */
 	struct list_head	keepalive_link;	/* Link in net->peer_keepalive[] */
-	time64_t		last_tx_at;	/* Last time packet sent here */
+	unsigned int		last_tx_at;	/* Last time packet sent here (time64_t LSW) */
 	seqlock_t		service_conn_lock;
 	spinlock_t		lock;		/* access lock */
 	unsigned int		if_mtu;		/* interface MTU for this peer */
@@ -1171,6 +1171,13 @@ void rxrpc_transmit_one(struct rxrpc_call *call, struct rxrpc_txbuf *txb);
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
index c4eb7986efdd..c8df12d80c7c 100644
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
index 4bbb27a48bd8..02f2de578f30 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -233,7 +233,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
-	call->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(call->peer);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
 				    rxrpc_tx_point_call_ack);
@@ -307,7 +307,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, sizeof(pkt));
 	ret = do_udp_sendmsg(conn->local->socket, &msg, sizeof(pkt));
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
 				    rxrpc_tx_point_call_abort);
@@ -392,6 +392,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 					    txb->wire.flags,
 					    test_bit(RXRPC_TXBUF_RESENT, &txb->flags),
 					    true);
+			rxrpc_peer_mark_tx(conn->peer);
 			goto done;
 		}
 	}
@@ -425,7 +426,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	 */
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_send);
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 
 	if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
@@ -572,7 +573,7 @@ void rxrpc_send_conn_abort(struct rxrpc_connection *conn)
 
 	trace_rxrpc_tx_packet(conn->debug_id, &whdr, rxrpc_tx_point_conn_abort);
 
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 }
 
 /*
@@ -691,7 +692,7 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 		trace_rxrpc_tx_packet(peer->debug_id, &whdr,
 				      rxrpc_tx_point_version_keepalive);
 
-	peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(peer);
 	_leave("");
 }
 
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 552ba84a255c..8c7fad55da74 100644
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
 		spin_unlock(&rxnet->peer_hash_lock);
 
 		if (use) {
-			keepalive_at = peer->last_tx_at + RXRPC_KEEPALIVE_TIME;
+			keepalive_at = rxrpc_peer_get_tx_mark(peer, base) + RXRPC_KEEPALIVE_TIME;
 			slot = keepalive_at - base;
 			_debug("%02x peer %u t=%d {%pISp}",
 			       cursor, peer->debug_id, slot, &peer->srx.transport);
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 208312c244f6..55a95f064df0 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -225,13 +225,13 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
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
 		   jiffies_to_usecs(peer->rto_j));
 
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index ad6c57a9f27c..e3c99a016f8c 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -674,7 +674,7 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 		return -EAGAIN;
 	}
 
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	trace_rxrpc_tx_packet(conn->debug_id, &whdr,
 			      rxrpc_tx_point_rxkad_challenge);
 	_leave(" = 0");
-- 
2.34.1


