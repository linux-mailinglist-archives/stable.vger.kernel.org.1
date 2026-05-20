Return-Path: <stable+bounces-252658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPxmGtInDmp56gUAu9opvQ
	(envelope-from <stable+bounces-252658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:29:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8FC59AEC9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00CC334810C9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E263D1CC6;
	Wed, 20 May 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nogXk03u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E63A6B99;
	Wed, 20 May 2026 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301253; cv=none; b=klZSIj9bmp32V7rZUZeNKNfOJjEjNg6uy0jG+7094ejFM2x0JgsKMdih1UqWufCp+CCcGlcV9a+mRiXsQH4dGXjkdEMiDtIF/5rMNvJJsQyUol/TV2/p4+iU8Us0WCRdvzgl7vcNH9q4odAzQ0ySNV8xu1EymyMP8QZ0+PbnBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301253; c=relaxed/simple;
	bh=+OuAHlWtg5ep00oOAHjLNVTPlE2yiOxMcO662BYZHgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlVF/BSm12cbbCwZUwfjeQek1qxtlQk28h9U6zTY2gRVOGaZPaW9BIz2kgMMOvDeipMl6XyYgmnXYeA+W/wu/nAx4xMgiZrB62qn72/ZzC+Sr5QH3PWArf+gli/Id2Qfqyl+pTXhDxdQ4e5gXpaNEMEyo+V3pKPgHJ0Yn52weeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nogXk03u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB651F000E9;
	Wed, 20 May 2026 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301251;
	bh=6Wo3zJr/ChgPSCntv5nbLSTBS8ByYUC341nvw2YG7j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nogXk03uuIbcQAMjUrfiqfk+bIzrmiFqICX+Uj8w3cohO8+XzSGNcEMdYvF6i0HkJ
	 V4Bz1p5+/udI/CHWUzIu2qLOS7DarvbfsD3i5COZOdfSlU+piwXFLYb+tE6i9Le2Rv
	 MCW5B6FhidlekCY+gFAXV/tb3sKn+0fUjhZ7lppY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 485/666] net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
Date: Wed, 20 May 2026 18:21:36 +0200
Message-ID: <20260520162121.777847775@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252658-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,mojatatu.com:email]
X-Rspamd-Queue-Id: BB8FC59AEC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 5aa434b467073..914e985427744 100644
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
@@ -685,10 +686,10 @@ static int hhf_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
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




