Return-Path: <stable+bounces-251041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD7yOabsDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-251041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:17:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489D593408
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07D9330ACAC7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA03F20F9;
	Wed, 20 May 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mDRFj/4P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5D364EB0;
	Wed, 20 May 2026 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296947; cv=none; b=dj+VtHgnG30ze/ahi4atKtl8nBdxPRU2VA2YQ7fHn7Lqm1n/rQ1pFZA3UiYAHC0sni1NQwXVWfG3p6LgXZ3CcyAbuLD0uwv65L78iVD4HVPbQFQ17ywDIbNNhLpn1uCRuiDmb/1pZzEVAm8e8rdc0Uzs2GOJKnp23PC7qdA4/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296947; c=relaxed/simple;
	bh=3dk/ywVwtE9Srq0IIhoipHQ40czT/ZM9gkUKWrZYLbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpW2hKWl9LRoOBaz8tnfSrrtgUIKRFsTXliKAf8ii0RJbZ78vqfdQvvRjexx9/mLm8HbbrH61YfwfbV52eYppQE55MF3S4KkAtRcEpR6zcc2BbRNk3YAjaLhbCcpgxUTOTT8TmoUi/w34PruwuoRzr6t95jT+GxERaFGlLv37zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mDRFj/4P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDABB1F000E9;
	Wed, 20 May 2026 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296946;
	bh=wNP7DBcvxvqMm101F/dYd1yOZmGa49/aEy34GypMM7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mDRFj/4PuP6TAzKT1r+xI/XyjLB7okpa/Ht5KXudtVPAj2ZpGHL02sBLWEZoDodPI
	 rgaGTQuSBUWK2tHIsK19/gOmGEwEq3A6uNetjn87dZcvzsICksfzwC3FST8PDG/b2W
	 5/mcACxsZiVh53LQm4ZHIysAuaVPHEfpbmCTyMbg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0991/1146] net/sched: sch_cake: annotate data-races in cake_dump_stats() (III)
Date: Wed, 20 May 2026 18:20:41 +0200
Message-ID: <20260520162210.659281507@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251041-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,toke.dk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 9489D593408
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 276a98a434964088fccd4745db5b34d6e831e358 ]

cake_dump_stats() runs without qdisc spinlock being held.

In this third patch, I add READ_ONCE()/WRITE_ONCE() annotations
for the following fields:

- packets
- tin_dropped
- tin_ecn_mark
- ack_drops
- peak_delay
- avge_delay
- base_delay

Other annotations are added in following patches, to ease code review.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: "Toke Høiland-Jørgensen" <toke@toke.dk>
Link: https://patch.msgid.link/20260427083606.459355-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cake.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a164464f63d18..3605f32ebf813 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1600,7 +1600,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	sch->qstats.backlog -= len;
 
 	flow->dropped++;
-	b->tin_dropped++;
+	WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
 
 	if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 		cake_advance_shaper(q, b, skb, now, true);
@@ -1820,7 +1820,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			numsegs++;
 			slen += segs->len;
 			q->buffer_used += segs->truesize;
-			b->packets++;
+			WRITE_ONCE(b->packets, b->packets + 1);
 		}
 
 		/* stats */
@@ -1844,7 +1844,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			ack = cake_ack_filter(q, flow);
 
 		if (ack) {
-			b->ack_drops++;
+			WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
 			sch->qstats.drops++;
 			ack_pkt_len = qdisc_pkt_len(ack);
 			b->bytes += ack_pkt_len;
@@ -1860,7 +1860,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		}
 
 		/* stats */
-		b->packets++;
+		WRITE_ONCE(b->packets, b->packets + 1);
 		b->bytes	    += len - ack_pkt_len;
 		b->backlogs[idx]    += len - ack_pkt_len;
 		b->tin_backlog      += len - ack_pkt_len;
@@ -2236,7 +2236,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			b->tin_deficit -= len;
 		}
 		flow->dropped++;
-		b->tin_dropped++;
+		WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
 		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 		qdisc_qstats_drop(sch);
 		qdisc_dequeue_drop(sch, skb, reason);
@@ -2244,17 +2244,19 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			goto retry;
 	}
 
-	b->tin_ecn_mark += !!flow->cvars.ecn_marked;
+	WRITE_ONCE(b->tin_ecn_mark, b->tin_ecn_mark + !!flow->cvars.ecn_marked);
 	qdisc_bstats_update(sch, skb);
 	WRITE_ONCE(q->last_active, now);
 
 	/* collect delay stats */
 	delay = ktime_to_ns(ktime_sub(now, cobalt_get_enqueue_time(skb)));
-	b->avge_delay = cake_ewma(b->avge_delay, delay, 8);
-	b->peak_delay = cake_ewma(b->peak_delay, delay,
-				  delay > b->peak_delay ? 2 : 8);
-	b->base_delay = cake_ewma(b->base_delay, delay,
-				  delay < b->base_delay ? 2 : 8);
+	WRITE_ONCE(b->avge_delay, cake_ewma(b->avge_delay, delay, 8));
+	WRITE_ONCE(b->peak_delay,
+		   cake_ewma(b->peak_delay, delay,
+			     delay > b->peak_delay ? 2 : 8));
+	WRITE_ONCE(b->base_delay,
+		   cake_ewma(b->base_delay, delay,
+			     delay < b->base_delay ? 2 : 8));
 
 	len = cake_advance_shaper(q, b, skb, now, false);
 	flow->deficit -= len;
@@ -3042,17 +3044,17 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 		PUT_TSTAT_U32(INTERVAL_US,
 			      ktime_to_us(ns_to_ktime(b->cparams.interval)));
 
-		PUT_TSTAT_U32(SENT_PACKETS, b->packets);
-		PUT_TSTAT_U32(DROPPED_PACKETS, b->tin_dropped);
-		PUT_TSTAT_U32(ECN_MARKED_PACKETS, b->tin_ecn_mark);
-		PUT_TSTAT_U32(ACKS_DROPPED_PACKETS, b->ack_drops);
+		PUT_TSTAT_U32(SENT_PACKETS, READ_ONCE(b->packets));
+		PUT_TSTAT_U32(DROPPED_PACKETS, READ_ONCE(b->tin_dropped));
+		PUT_TSTAT_U32(ECN_MARKED_PACKETS, READ_ONCE(b->tin_ecn_mark));
+		PUT_TSTAT_U32(ACKS_DROPPED_PACKETS, READ_ONCE(b->ack_drops));
 
 		PUT_TSTAT_U32(PEAK_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->peak_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->peak_delay))));
 		PUT_TSTAT_U32(AVG_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->avge_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->avge_delay))));
 		PUT_TSTAT_U32(BASE_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->base_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->base_delay))));
 
 		PUT_TSTAT_U32(WAY_INDIRECT_HITS, READ_ONCE(b->way_hits));
 		PUT_TSTAT_U32(WAY_MISSES, READ_ONCE(b->way_misses));
-- 
2.53.0




