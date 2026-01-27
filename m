Return-Path: <stable+bounces-211800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNjpKEm8eGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:23:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222694DA6
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB2E53056141
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8640356A06;
	Tue, 27 Jan 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNPeFsfI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAE3469F6
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520135; cv=none; b=LKrLnsFlWhWzxM0AbdKwva5CJb3KN1Lfn357nDtm2tVVT3sBs+aRXX+Bwk4eHINLLE7D66P34OcXMHKWkyC4VIeqA5M4MJM6IWrEpe+ITzdZWHqrr0u9ojA/TmQTH+q1Jbp+McmIPBj3rjGgXPcopQzfwC5Ek7rFDuj/XdcirWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520135; c=relaxed/simple;
	bh=9YoUL43g42+OLRjmOm607XhK7Tl2YncC45KFgCfh0H0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jz9OOR1URQVe53bmYrU5Kmq5AIOcELol0vy8ZoP86ll7FWunNwFWrNlFxfJystZEiPc79vEHYmPwQ7ZaZDNjWsLpPXV3LivKZHPYU5USrPs9v+QxVGRuPTPxAGg5NIJ7Cq5DnXZWIz1yNh0Ia5lC1Y/jHCS8HHFmPEyTPMhzNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNPeFsfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CC4C116D0;
	Tue, 27 Jan 2026 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769520134;
	bh=9YoUL43g42+OLRjmOm607XhK7Tl2YncC45KFgCfh0H0=;
	h=Subject:To:Cc:From:Date:From;
	b=xNPeFsfIJmJ/15vRsuxmmsT+Vzic8JSo8NcrS8Hqk5d+5KGz+ybQFsyVJnC7FwI2i
	 23w7x+0XDu4gVjvgKpF/tHML0kze3GWBhu5Uqo4H06pumFy8uxbU82N4ECxIPf94YJ
	 kBrodKqVvIii31N7ut9NUEHBI2M36k/J9NiIUxOk=
Subject: FAILED: patch "[PATCH] rxrpc: Fix data-race warning and potential load/store tearing" failed to apply to 6.1-stable tree
To: dhowells@redhat.com,horms@kernel.org,kuba@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:21:57 +0100
Message-ID: <2026012757-xerox-grooving-43d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211800-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,gregkh:email,auristor.com:email,msgid.link:url,infradead.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1222694DA6
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5d5fe8bcd331f1e34e0943ec7c18432edfcf0e8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012757-xerox-grooving-43d4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d5fe8bcd331f1e34e0943ec7c18432edfcf0e8b Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 20 Jan 2026 10:13:05 +0000
Subject: [PATCH] rxrpc: Fix data-race warning and potential load/store tearing

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

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 5b7342d43486..36d6ca0d1089 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -387,7 +387,7 @@ struct rxrpc_peer {
 	struct rb_root		service_conns;	/* Service connections */
 	struct list_head	keepalive_link;	/* Link in net->peer_keepalive[] */
 	unsigned long		app_data;	/* Application data (e.g. afs_server) */
-	time64_t		last_tx_at;	/* Last time packet sent here */
+	unsigned int		last_tx_at;	/* Last time packet sent here (time64_t LSW) */
 	seqlock_t		service_conn_lock;
 	spinlock_t		lock;		/* access lock */
 	int			debug_id;	/* debug ID for printks */
@@ -1379,6 +1379,13 @@ void rxrpc_peer_keepalive_worker(struct work_struct *);
 void rxrpc_input_probe_for_pmtud(struct rxrpc_connection *conn, rxrpc_serial_t acked_serial,
 				 bool sendmsg_fail);
 
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
index 232b6986da83..98ad9b51ca2c 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -194,7 +194,7 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	}
 
 	ret = kernel_sendmsg(conn->local->socket, &msg, iov, ioc, len);
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(chan->call_debug_id, serial, ret,
 				    rxrpc_tx_point_call_final_resend);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 8b5903b6e481..d70db367e358 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -275,7 +275,7 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, int nr_kv, size_t len
 	rxrpc_local_dont_fragment(conn->local, why == rxrpc_propose_ack_ping_for_mtu_probe);
 
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
-	call->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(call->peer);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
 				    rxrpc_tx_point_call_ack);
@@ -411,7 +411,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, sizeof(pkt));
 	ret = do_udp_sendmsg(conn->local->socket, &msg, sizeof(pkt));
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
 				    rxrpc_tx_point_call_abort);
@@ -698,7 +698,7 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req
 			ret = 0;
 			trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags,
 					    rxrpc_txdata_inject_loss);
-			conn->peer->last_tx_at = ktime_get_seconds();
+			rxrpc_peer_mark_tx(conn->peer);
 			goto done;
 		}
 	}
@@ -711,7 +711,7 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req
 	 */
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_send);
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 
 	if (ret == -EMSGSIZE) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_msgsize);
@@ -797,7 +797,7 @@ void rxrpc_send_conn_abort(struct rxrpc_connection *conn)
 
 	trace_rxrpc_tx_packet(conn->debug_id, &whdr, rxrpc_tx_point_conn_abort);
 
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 }
 
 /*
@@ -917,7 +917,7 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 		trace_rxrpc_tx_packet(peer->debug_id, &whdr,
 				      rxrpc_tx_point_version_keepalive);
 
-	peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(peer);
 	_leave("");
 }
 
@@ -973,7 +973,7 @@ void rxrpc_send_response(struct rxrpc_connection *conn, struct sk_buff *response
 	if (ret < 0)
 		goto fail;
 
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	return;
 
 fail:
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 7f4729234957..9d02448ac062 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -237,6 +237,21 @@ static void rxrpc_distribute_error(struct rxrpc_peer *peer, struct sk_buff *skb,
 	spin_unlock_irq(&peer->lock);
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
@@ -265,7 +280,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 		spin_unlock_bh(&rxnet->peer_hash_lock);
 
 		if (use) {
-			keepalive_at = peer->last_tx_at + RXRPC_KEEPALIVE_TIME;
+			keepalive_at = rxrpc_peer_get_tx_mark(peer, base) + RXRPC_KEEPALIVE_TIME;
 			slot = keepalive_at - base;
 			_debug("%02x peer %u t=%d {%pISp}",
 			       cursor, peer->debug_id, slot, &peer->srx.transport);
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index d803562ca0ac..59292f7f9205 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -296,13 +296,13 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 
 	now = ktime_get_seconds();
 	seq_printf(seq,
-		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8d %8d\n",
+		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6ds %8d %8d\n",
 		   lbuff,
 		   rbuff,
 		   refcount_read(&peer->ref),
 		   peer->cong_ssthresh,
 		   peer->max_data,
-		   now - peer->last_tx_at,
+		   (s32)now - (s32)READ_ONCE(peer->last_tx_at),
 		   READ_ONCE(peer->recent_srtt_us),
 		   READ_ONCE(peer->recent_rto_us));
 
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index dce5a3d8a964..43cbf9efd89f 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -678,7 +678,7 @@ static int rxgk_issue_challenge(struct rxrpc_connection *conn)
 
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 	if (ret > 0)
-		conn->peer->last_tx_at = ktime_get_seconds();
+		rxrpc_peer_mark_tx(conn->peer);
 	__free_page(page);
 
 	if (ret < 0) {
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 3657c0661cdc..a756855a0a62 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -694,7 +694,7 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 		return -EAGAIN;
 	}
 
-	conn->peer->last_tx_at = ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	trace_rxrpc_tx_packet(conn->debug_id, &whdr,
 			      rxrpc_tx_point_rxkad_challenge);
 	_leave(" = 0");


