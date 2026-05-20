Return-Path: <stable+bounces-252711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHeoMF4oDmqk6gUAu9opvQ
	(envelope-from <stable+bounces-252711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:32:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6C359AFD3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A583E3677056
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2983F88B8;
	Wed, 20 May 2026 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJ1yhvsv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706836BCDE;
	Wed, 20 May 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301390; cv=none; b=TyGHKZRFtpLw+Gvrno53rtLxhAizPNvFT/6LyyZktn+woIzP+Hkus08TaaMF/p9zcjQ/duD1dd77lsNTyXUbvlIADEwt67G9FP5wV6vLlvsPwrA/RuMBoNuooA7WyclOJxngvUJT4NvHtVzsIkewzOuLqJ3n1ZuFqrFApaUAIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301390; c=relaxed/simple;
	bh=V6Ou+uM56SKm+riMw4Yspd+BcoFHXwdOuaPkg0b7lPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qD7L+KFz/cdmXKXyA9DcD/5NjHbVT86F8/+Q2gZTeaociwDxDmCWcppO417FY3/1bFog90+GUUtwhJ/coZoS6murxM+uaW+e4Rdi6ygcNFa8yY24VO1TfAoV/7lZiJpzVQiQzhpDluMHSLLT4VG9LvmpRc/iLniej7pUoKjHU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJ1yhvsv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2371C1F000E9;
	Wed, 20 May 2026 18:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301388;
	bh=AYsF3Y2sw7ZeyESD+fd6JI/NLgqJLrDxqLs8kUM2nLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WJ1yhvsvkC+7R4M9uAel+RQeiHCBKRH22LndF/jOjlD2kvvf3v6Sd172zf/KvfiZq
	 H+qkaSUGiH/IAJPJHNiqVKvCpbuZ4/tdxEGHC9WgSgNxKFdhe4p2siRn1x8TpXeb4V
	 G6PAolCDQYXG82OUbEfvbk3Y9u5HwE37XzeIIcpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 537/666] net/sched: sch_choke: annotate data-races in choke_dump_stats()
Date: Wed, 20 May 2026 18:22:28 +0200
Message-ID: <20260520162122.910219764@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252711-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 3B6C359AFD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d3aeb889dcbd78e95f500d383799a23d949796e0 ]

choke_dump_stats() only runs with RTNL held.
It reads fields that can be changed in qdisc fast path.
Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260423062839.2524324-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_choke.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 757b89292e7e6..87d92b2a74441 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -229,7 +229,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		/* Draw a packet at random from queue and compare flow */
 		if (choke_match_random(q, skb, &idx)) {
-			q->stats.matched++;
+			WRITE_ONCE(q->stats.matched, q->stats.matched + 1);
 			choke_drop_by_idx(sch, idx, to_free);
 			goto congestion_drop;
 		}
@@ -241,11 +241,13 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qstats_overlimit(sch);
 			if (use_harddrop(q) || !use_ecn(q) ||
 			    !INET_ECN_set_ce(skb)) {
-				q->stats.forced_drop++;
+				WRITE_ONCE(q->stats.forced_drop,
+					   q->stats.forced_drop + 1);
 				goto congestion_drop;
 			}
 
-			q->stats.forced_mark++;
+			WRITE_ONCE(q->stats.forced_mark,
+				   q->stats.forced_mark + 1);
 		} else if (++q->vars.qcount) {
 			if (red_mark_probability(p, &q->vars, q->vars.qavg)) {
 				q->vars.qcount = 0;
@@ -253,11 +255,13 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 				qdisc_qstats_overlimit(sch);
 				if (!use_ecn(q) || !INET_ECN_set_ce(skb)) {
-					q->stats.prob_drop++;
+					WRITE_ONCE(q->stats.prob_drop,
+					           q->stats.prob_drop + 1);
 					goto congestion_drop;
 				}
 
-				q->stats.prob_mark++;
+				WRITE_ONCE(q->stats.prob_mark,
+					   q->stats.prob_mark + 1);
 			}
 		} else
 			q->vars.qR = red_random(p);
@@ -272,7 +276,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return NET_XMIT_SUCCESS;
 	}
 
-	q->stats.pdrop++;
+	WRITE_ONCE(q->stats.pdrop, q->stats.pdrop + 1);
 	return qdisc_drop(skb, sch, to_free);
 
 congestion_drop:
@@ -461,10 +465,12 @@ static int choke_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct choke_sched_data *q = qdisc_priv(sch);
 	struct tc_choke_xstats st = {
-		.early	= q->stats.prob_drop + q->stats.forced_drop,
-		.marked	= q->stats.prob_mark + q->stats.forced_mark,
-		.pdrop	= q->stats.pdrop,
-		.matched = q->stats.matched,
+		.early	= READ_ONCE(q->stats.prob_drop) +
+			  READ_ONCE(q->stats.forced_drop),
+		.marked	= READ_ONCE(q->stats.prob_mark) +
+			  READ_ONCE(q->stats.forced_mark),
+		.pdrop	= READ_ONCE(q->stats.pdrop),
+		.matched = READ_ONCE(q->stats.matched),
 	};
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
-- 
2.53.0




