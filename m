Return-Path: <stable+bounces-242351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IOgHgaW9GmrCgIAu9opvQ
	(envelope-from <stable+bounces-242351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:01:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA014AC2B3
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C9543008C85
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8A394790;
	Fri,  1 May 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qzn9vVrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07E394788
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777636865; cv=none; b=gJhPedR0ecWJskt2zEdfJAjN4uBTh6KqNLQG5XPS1F9UAQNqfelupGef5y9WKHRuyKlRva61EBasimiit2JvCljs/ypBWfynLyklv0/frnaVuZZ4mBETtUD71LojKPwT3ZoZjrhEnUBeW3m/ambbjbW40clZ7ueMbcpOa3/BVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777636865; c=relaxed/simple;
	bh=8SsAQBCyq6tfd/Vveq4qs4nq52jPuz7a5/Ssin74+BI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I+A82Kp6dmzw/u+Nsg8h/amD1nyo2UWUTzxKzuKulQ7d0FSnKrCS1RIi8fjTqW7+TiAZS9Rqeh/rO8fBhDP8L86AebKehxfXWqf8mkPJED9wHhCBLqOEwtu8tD65J1WoNlC0pOZtah+oegW1821Bpl1+Dfyx1zM/Eb+u/Xqm9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qzn9vVrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4480FC2BCB7;
	Fri,  1 May 2026 12:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777636864;
	bh=8SsAQBCyq6tfd/Vveq4qs4nq52jPuz7a5/Ssin74+BI=;
	h=Subject:To:Cc:From:Date:From;
	b=Qzn9vVrAVci2UwyhanzzcDTiDXCdnNFCLY5k15MUPJ/Nfy6lBO10CrkezWd2Fnekm
	 OMDtS9jsThvVDi+OQOAyZq5jGeeDolsYw4Fbb1C413XxCj5hLMwgFYoH2JQmhB2zv8
	 YkNfbtEy37rGhP0bEmqk433G5H+3fbu7TxEdicuM=
Subject: FAILED: patch "[PATCH] rxrpc: Fix potential UAF after skb_unshare() failure" failed to apply to 6.12-stable tree
To: dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:01:02 +0200
Message-ID: <2026050101-dizzy-vividly-dc7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AA014AC2B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242351-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1f2740150f904bfa60e4bad74d65add3ccb5e7f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050101-dizzy-vividly-dc7b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f2740150f904bfa60e4bad74d65add3ccb5e7f8 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 22 Apr 2026 17:14:32 +0100
Subject: [PATCH] rxrpc: Fix potential UAF after skb_unshare() failure

If skb_unshare() fails to unshare a packet due to allocation failure in
rxrpc_input_packet(), the skb pointer in the parent (rxrpc_io_thread())
will be NULL'd out.  This will likely cause the call to
trace_rxrpc_rx_done() to oops.

Fix this by moving the unsharing down to where rxrpc_input_call_event()
calls rxrpc_input_call_packet().  There are a number of places prior to
that where we ignore DATA packets for a variety of reasons (such as the
call already being complete) for which an unshare is then avoided.

And with that, rxrpc_input_packet() doesn't need to take a pointer to the
pointer to the packet, so change that to just a pointer.

Fixes: 2d1faf7a0ca3 ("rxrpc: Simplify skbuff accounting in receive path")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260422161438.2593376-4-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 5820d7e41ea0..13b9d017f8e1 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -162,8 +162,6 @@
 	E_(rxrpc_call_poke_timer_now,		"Timer-now")
 
 #define rxrpc_skb_traces \
-	EM(rxrpc_skb_eaten_by_unshare,		"ETN unshare  ") \
-	EM(rxrpc_skb_eaten_by_unshare_nomem,	"ETN unshar-nm") \
 	EM(rxrpc_skb_get_call_rx,		"GET call-rx  ") \
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
@@ -190,6 +188,7 @@
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
 	EM(rxrpc_skb_put_purge_oob,		"PUT purge-oob") \
 	EM(rxrpc_skb_put_response,		"PUT response ") \
+	EM(rxrpc_skb_put_response_copy,		"PUT resp-cpy ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
 	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
@@ -198,6 +197,7 @@
 	EM(rxrpc_skb_see_recvmsg_oob,		"SEE recvm-oob") \
 	EM(rxrpc_skb_see_reject,		"SEE reject   ") \
 	EM(rxrpc_skb_see_rotate,		"SEE rotate   ") \
+	EM(rxrpc_skb_see_unshare_nomem,		"SEE unshar-nm") \
 	E_(rxrpc_skb_see_version,		"SEE version  ")
 
 #define rxrpc_local_traces \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 96ecb83c9071..27c2aa2dd023 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1486,7 +1486,6 @@ int rxrpc_server_keyring(struct rxrpc_sock *, sockptr_t, int);
 void rxrpc_kernel_data_consumed(struct rxrpc_call *, struct sk_buff *);
 void rxrpc_new_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_see_skb(struct sk_buff *, enum rxrpc_skb_trace);
-void rxrpc_eaten_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_get_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_free_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_purge_queue(struct sk_buff_head *);
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fec59d9338b9..cc8f9dfa44e8 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -332,7 +332,24 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
 
-			rxrpc_input_call_packet(call, skb);
+			if (sp->hdr.securityIndex != 0 &&
+			    skb_cloned(skb)) {
+				/* Unshare the packet so that it can be
+				 * modified by in-place decryption.
+				 */
+				struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
+
+				if (nskb) {
+					rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
+					rxrpc_input_call_packet(call, nskb);
+					rxrpc_free_skb(nskb, rxrpc_skb_put_call_rx);
+				} else {
+					/* OOM - Drop the packet. */
+					rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
+				}
+			} else {
+				rxrpc_input_call_packet(call, skb);
+			}
 			rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
 			did_receive = true;
 		}
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 697956931925..dc5184a2fa9d 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -192,13 +192,12 @@ static bool rxrpc_extract_abort(struct sk_buff *skb)
 /*
  * Process packets received on the local endpoint
  */
-static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
+static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff *skb)
 {
 	struct rxrpc_connection *conn;
 	struct sockaddr_rxrpc peer_srx;
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_peer *peer = NULL;
-	struct sk_buff *skb = *_skb;
 	bool ret = false;
 
 	skb_pull(skb, sizeof(struct udphdr));
@@ -244,25 +243,6 @@ static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
 			return rxrpc_bad_message(skb, rxrpc_badmsg_zero_call);
 		if (sp->hdr.seq == 0)
 			return rxrpc_bad_message(skb, rxrpc_badmsg_zero_seq);
-
-		/* Unshare the packet so that it can be modified for in-place
-		 * decryption.
-		 */
-		if (sp->hdr.securityIndex != 0) {
-			skb = skb_unshare(skb, GFP_ATOMIC);
-			if (!skb) {
-				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare_nomem);
-				*_skb = NULL;
-				return just_discard;
-			}
-
-			if (skb != *_skb) {
-				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare);
-				*_skb = skb;
-				rxrpc_new_skb(skb, rxrpc_skb_new_unshared);
-				sp = rxrpc_skb(skb);
-			}
-		}
 		break;
 
 	case RXRPC_PACKET_TYPE_CHALLENGE:
@@ -494,7 +474,7 @@ int rxrpc_io_thread(void *data)
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
 				skb->priority = 0;
-				if (!rxrpc_input_packet(local, &skb))
+				if (!rxrpc_input_packet(local, skb))
 					rxrpc_reject_packet(local, skb);
 				trace_rxrpc_rx_done(skb->mark, skb->priority);
 				rxrpc_free_skb(skb, rxrpc_skb_put_input);
diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index 3bcd6ee80396..e2169d1a14b5 100644
--- a/net/rxrpc/skbuff.c
+++ b/net/rxrpc/skbuff.c
@@ -46,15 +46,6 @@ void rxrpc_get_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
 	skb_get(skb);
 }
 
-/*
- * Note the dropping of a ref on a socket buffer by the core.
- */
-void rxrpc_eaten_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
-{
-	int n = atomic_inc_return(&rxrpc_n_rx_skbs);
-	trace_rxrpc_skb(skb, 0, n, why);
-}
-
 /*
  * Note the destruction of a socket buffer.
  */


