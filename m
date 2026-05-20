Return-Path: <stable+bounces-253222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOsYN9IFDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:04:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 765CA597B29
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50D81302084D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB3C4219FD;
	Wed, 20 May 2026 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sTsw9i/H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D3347515;
	Wed, 20 May 2026 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302718; cv=none; b=C8+2kJ/MsU6qLbNySHZ+HmWhtXC7VReBxowY5U/QLvZ40jIzenGgFIdh7KvXzCsizm4juryZNczEldF6BoGL70I3aruOf3AYdObMpIc3gwiaqM4KkjRgrXWxistFraL48rddAIlEnlKHVEBvGBb7Nz/d0Ijij/yyVuS+Tv0nRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302718; c=relaxed/simple;
	bh=rBGJn58X1C7AKg+gSM7PnZeerAqEmnO1slxHxjx38JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KllEAlBSstFt+ypm7C4Z5Zdx9TKz6t5L1UkK9PEkZuWwHyDA2dNT6bnmIgyiJ1+dloRRgmVMQKY9OuWZfEV+xJ6E7GnjUD2NXZO7rEt3gDXkkQVocpWYumAaLSClr+4a4UvLUOBRN0Ft60kItGP7GTqu/ciedjv05oZl8ota/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sTsw9i/H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED91F000E9;
	Wed, 20 May 2026 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302717;
	bh=Pb86yNHb1gK+dTqd5JRXcX96jkWffEZGaw/yQcLfNP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sTsw9i/H/ijUI3bnqsFB6PpjXFTRd+TjnaI+hydF5x4I76FGQoRm9FMqn91xgxeP/
	 H8CbQlBGXqqcEArgKzP66FBPFpgWqajBhmovLkvzOZed0ylDZbh6AyUm6QchBCb/Zo
	 B5a4RUnh4J3zDzAYt8OtSpi74r4mZebv6E3JTTWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 346/508] net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
Date: Wed, 20 May 2026 18:22:49 +0200
Message-ID: <20260520162106.130586161@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253222-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 765CA597B29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a6edf2cd4156b71e07258876b7626692e158f7e8 ]

hhf_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260421143349.4052215-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_hhf.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 83fc44f20e31c..67b555c02f2c0 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -198,7 +198,8 @@ static struct hh_flow_state *seek_list(const u32 hash,
 				return NULL;
 			list_del(&flow->flowchain);
 			kfree(flow);
-			q->hh_flows_current_cnt--;
+			WRITE_ONCE(q->hh_flows_current_cnt,
+				   q->hh_flows_current_cnt - 1);
 		} else if (flow->hash_id == hash) {
 			return flow;
 		}
@@ -226,7 +227,7 @@ static struct hh_flow_state *alloc_new_hh(struct list_head *head,
 	}
 
 	if (q->hh_flows_current_cnt >= q->hh_flows_limit) {
-		q->hh_flows_overlimit++;
+		WRITE_ONCE(q->hh_flows_overlimit, q->hh_flows_overlimit + 1);
 		return NULL;
 	}
 	/* Create new entry. */
@@ -234,7 +235,7 @@ static struct hh_flow_state *alloc_new_hh(struct list_head *head,
 	if (!flow)
 		return NULL;
 
-	q->hh_flows_current_cnt++;
+	WRITE_ONCE(q->hh_flows_current_cnt, q->hh_flows_current_cnt + 1);
 	INIT_LIST_HEAD(&flow->flowchain);
 	list_add_tail(&flow->flowchain, head);
 
@@ -309,7 +310,7 @@ static enum wdrr_bucket_idx hhf_classify(struct sk_buff *skb, struct Qdisc *sch)
 			return WDRR_BUCKET_FOR_NON_HH;
 		flow->hash_id = hash;
 		flow->hit_timestamp = now;
-		q->hh_flows_total_cnt++;
+		WRITE_ONCE(q->hh_flows_total_cnt, q->hh_flows_total_cnt + 1);
 
 		/* By returning without updating counters in q->hhf_arrays,
 		 * we implicitly implement "shielding" (see Optimization O1).
@@ -403,7 +404,7 @@ static int hhf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return NET_XMIT_SUCCESS;
 
 	prev_backlog = sch->qstats.backlog;
-	q->drop_overlimit++;
+	WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
 	/* Return Congestion Notification only if we dropped a packet from this
 	 * bucket.
 	 */
@@ -678,10 +679,10 @@ static int hhf_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct hhf_sched_data *q = qdisc_priv(sch);
 	struct tc_hhf_xstats st = {
-		.drop_overlimit = q->drop_overlimit,
-		.hh_overlimit	= q->hh_flows_overlimit,
-		.hh_tot_count	= q->hh_flows_total_cnt,
-		.hh_cur_count	= q->hh_flows_current_cnt,
+		.drop_overlimit = READ_ONCE(q->drop_overlimit),
+		.hh_overlimit	= READ_ONCE(q->hh_flows_overlimit),
+		.hh_tot_count	= READ_ONCE(q->hh_flows_total_cnt),
+		.hh_cur_count	= READ_ONCE(q->hh_flows_current_cnt),
 	};
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
-- 
2.53.0




