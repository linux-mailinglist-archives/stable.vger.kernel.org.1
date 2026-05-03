Return-Path: <stable+bounces-242653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EsXgDaAq92lndAIAu9opvQ
	(envelope-from <stable+bounces-242653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 12:59:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7F14B530C
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 12:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0192730073FF
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F72EBDFA;
	Sun,  3 May 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwg2POE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360E296BA9
	for <stable@vger.kernel.org>; Sun,  3 May 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777805980; cv=none; b=owXHLIQ1z1UcfxUGSexqAOPxljH6M+a22SUgO6x6axIYXcnowsld+3POACsnf3u1demVuI+Wg1+jh0s31iU7Kw3tG0iAmLk0w2ZTNu9SZ7rt+cjR9BgK7FKOf+cmYuTzbtRfFWYZReo0932puMcYKPZyvkXzLBshaFFTPhoejeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777805980; c=relaxed/simple;
	bh=aUzG075nRQIBmRCW6kdva+KOrHQSVo2HT0jDGxchvhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4d0eHKiitQG3eyBqdSjt8ZdfHs+S0GOlq9EhGe1a0SELbuSraLutq6dj+qqdCm2iQrqg1c7z2+nnrjSzwiyr9+7C7YspzTwXeByKuYS1eitlhRmy+i2f5Q6HJfw6Kifi2C3sijYYDn3rQXl/s1xhk+x8zv3OAlY3xGofPOqjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwg2POE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFC0C2BCB4;
	Sun,  3 May 2026 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777805980;
	bh=aUzG075nRQIBmRCW6kdva+KOrHQSVo2HT0jDGxchvhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iwg2POE0mC+4eKaq0vfOqG2N/UjdOYOe2IbCFq1y9mEwBJgvRGc/NOH6do+b8VfRb
	 BBQj1g4oyg+GrxKrcqjjwnu3Wfe622hPJESvZf4Fxq+Tmq5nBxSNWvdBdo7MdKACAi
	 BTzacHyqlmBC+1t9n3AxvE6kic+OnwcLd1thgm6xULpZ4rP6LKEZNnZwYF1zMYuqZl
	 XlwZMGlzEmyy9HAxqV0JQaFHRWPWbs295umNYUP1nCen9sLk03KABW3wvaKuqvh9va
	 1t5amed1mPQ19N4ulRv1PWfY05A9zWmv9K7USAj93UtgSA6Q2fYsWCna10DlGAQo8H
	 KhE2DJi7YSEpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] rxrpc: Fix potential UAF after skb_unshare() failure
Date: Sun,  3 May 2026 06:59:34 -0400
Message-ID: <20260503105934.1030665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050101-dizzy-vividly-dc7b@gregkh>
References: <2026050101-dizzy-vividly-dc7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B7F14B530C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242653-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,auristor.com:email]

From: David Howells <dhowells@redhat.com>

[ Upstream commit 1f2740150f904bfa60e4bad74d65add3ccb5e7f8 ]

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
[ adapted to per-skb rxrpc_input_call_event() signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h |  4 ++--
 net/rxrpc/ar-internal.h      |  1 -
 net/rxrpc/call_event.c       | 24 ++++++++++++++++++++++--
 net/rxrpc/io_thread.c        | 24 ++----------------------
 net/rxrpc/skbuff.c           |  9 ---------
 5 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 3eb806f7bc6a5..b6669a576fd58 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -126,8 +126,7 @@
 	E_(rxrpc_call_poke_timer_now,		"Timer-now")
 
 #define rxrpc_skb_traces \
-	EM(rxrpc_skb_eaten_by_unshare,		"ETN unshare  ") \
-	EM(rxrpc_skb_eaten_by_unshare_nomem,	"ETN unshar-nm") \
+	EM(rxrpc_skb_get_call_rx,		"GET call-rx  ") \
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
 	EM(rxrpc_skb_get_last_nack,		"GET last-nack") \
@@ -152,6 +151,7 @@
 	EM(rxrpc_skb_see_recvmsg,		"SEE recvmsg  ") \
 	EM(rxrpc_skb_see_reject,		"SEE reject   ") \
 	EM(rxrpc_skb_see_rotate,		"SEE rotate   ") \
+	EM(rxrpc_skb_see_unshare_nomem,		"SEE unshar-nm") \
 	E_(rxrpc_skb_see_version,		"SEE version  ")
 
 #define rxrpc_local_traces \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 1494d162444dd..63cd5217b4ee3 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1260,7 +1260,6 @@ int rxrpc_server_keyring(struct rxrpc_sock *, sockptr_t, int);
 void rxrpc_kernel_data_consumed(struct rxrpc_call *, struct sk_buff *);
 void rxrpc_new_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_see_skb(struct sk_buff *, enum rxrpc_skb_trace);
-void rxrpc_eaten_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_get_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_free_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_purge_queue(struct sk_buff_head *);
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 7bbb685047667..81d77b7449f7e 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -342,8 +342,28 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 	if (skb && skb->mark == RXRPC_SKB_MARK_ERROR)
 		goto out;
 
-	if (skb)
-		rxrpc_input_call_packet(call, skb);
+	if (skb) {
+		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+		if (sp->hdr.securityIndex != 0 &&
+		    skb_cloned(skb)) {
+			/* Unshare the packet so that it can be modified for
+			 * in-place decryption.
+			 */
+			struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
+
+			if (nskb) {
+				rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
+				rxrpc_input_call_packet(call, nskb);
+				rxrpc_free_skb(nskb, rxrpc_skb_put_input);
+			} else {
+				/* OOM - Drop the packet. */
+				rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
+			}
+		} else {
+			rxrpc_input_call_packet(call, skb);
+		}
+	}
 
 	/* If we see our async-event poke, check for timeout trippage. */
 	now = ktime_get_real();
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 83c5f715c6b73..8270cac0488d9 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -178,13 +178,12 @@ static bool rxrpc_extract_abort(struct sk_buff *skb)
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
@@ -230,25 +229,6 @@ static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
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
@@ -490,7 +470,7 @@ int rxrpc_io_thread(void *data)
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
 				skb->priority = 0;
-				if (!rxrpc_input_packet(local, &skb))
+				if (!rxrpc_input_packet(local, skb))
 					rxrpc_reject_packet(local, skb);
 				trace_rxrpc_rx_done(skb->mark, skb->priority);
 				rxrpc_free_skb(skb, rxrpc_skb_put_input);
diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index 3bcd6ee803960..e2169d1a14b5f 100644
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
-- 
2.53.0


