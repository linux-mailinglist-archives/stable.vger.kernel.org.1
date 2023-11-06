Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48907E2442
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjKFNUD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjKFNUB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:20:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6B100
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:19:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026A3C433C9;
        Mon,  6 Nov 2023 13:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276798;
        bh=Z+eGB9/yoFPjnLMoWmh0C0ut8q7lN3a9fIx/HghCnRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4Vf+64LMdKPqe7RgXRH8o38jFmPaP7Yjucn/qE3bKonN1sqPRZ4lzAoXSIoG0cPk
         hQibRnVsRiRdWxmCFE6QM/2TRrRcvR+u/4IChg6yYNSYdxh6pJrnhD0sv2FvpBtTrV
         XxFmBEide2Dhkn7EabKGLXzL1privyIamojXC2eE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 11/74] neighbour: fix various data-races
Date:   Mon,  6 Nov 2023 14:03:31 +0100
Message-ID: <20231106130302.101364856@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a9beb7e81bcb876615e1fbb3c07f3f9dba69831f ]

1) tbl->gc_thresh1, tbl->gc_thresh2, tbl->gc_thresh3 and tbl->gc_interval
   can be written from sysfs.

2) tbl->last_flush is read locklessly from neigh_alloc()

3) tbl->proxy_queue.qlen is read locklessly from neightbl_fill_info()

4) neightbl_fill_info() reads cpu stats that can be changed concurrently.

Fixes: c7fb64db001f ("[NETLINK]: Neighbour table configuration and statistics via rtnetlink")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20231019122104.1448310-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 67 +++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c0489d8812c0e..9d631b7adb7bf 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -224,7 +224,8 @@ bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
-	int max_clean = atomic_read(&tbl->gc_entries) - tbl->gc_thresh2;
+	int max_clean = atomic_read(&tbl->gc_entries) -
+			READ_ONCE(tbl->gc_thresh2);
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
@@ -253,7 +254,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 		}
 	}
 
-	tbl->last_flush = jiffies;
+	WRITE_ONCE(tbl->last_flush, jiffies);
 
 	write_unlock_bh(&tbl->lock);
 
@@ -409,17 +410,17 @@ static struct neighbour *neigh_alloc(struct neigh_table *tbl,
 {
 	struct neighbour *n = NULL;
 	unsigned long now = jiffies;
-	int entries;
+	int entries, gc_thresh3;
 
 	if (exempt_from_gc)
 		goto do_alloc;
 
 	entries = atomic_inc_return(&tbl->gc_entries) - 1;
-	if (entries >= tbl->gc_thresh3 ||
-	    (entries >= tbl->gc_thresh2 &&
-	     time_after(now, tbl->last_flush + 5 * HZ))) {
-		if (!neigh_forced_gc(tbl) &&
-		    entries >= tbl->gc_thresh3) {
+	gc_thresh3 = READ_ONCE(tbl->gc_thresh3);
+	if (entries >= gc_thresh3 ||
+	    (entries >= READ_ONCE(tbl->gc_thresh2) &&
+	     time_after(now, READ_ONCE(tbl->last_flush) + 5 * HZ))) {
+		if (!neigh_forced_gc(tbl) && entries >= gc_thresh3) {
 			net_info_ratelimited("%s: neighbor table overflow!\n",
 					     tbl->id);
 			NEIGH_CACHE_STAT_INC(tbl, table_fulls);
@@ -902,13 +903,14 @@ static void neigh_periodic_work(struct work_struct *work)
 
 	if (time_after(jiffies, tbl->last_rand + 300 * HZ)) {
 		struct neigh_parms *p;
-		tbl->last_rand = jiffies;
+
+		WRITE_ONCE(tbl->last_rand, jiffies);
 		list_for_each_entry(p, &tbl->parms_list, list)
 			p->reachable_time =
 				neigh_rand_reach_time(NEIGH_VAR(p, BASE_REACHABLE_TIME));
 	}
 
-	if (atomic_read(&tbl->entries) < tbl->gc_thresh1)
+	if (atomic_read(&tbl->entries) < READ_ONCE(tbl->gc_thresh1))
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
@@ -2050,15 +2052,16 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 	ndtmsg->ndtm_pad2   = 0;
 
 	if (nla_put_string(skb, NDTA_NAME, tbl->id) ||
-	    nla_put_msecs(skb, NDTA_GC_INTERVAL, tbl->gc_interval, NDTA_PAD) ||
-	    nla_put_u32(skb, NDTA_THRESH1, tbl->gc_thresh1) ||
-	    nla_put_u32(skb, NDTA_THRESH2, tbl->gc_thresh2) ||
-	    nla_put_u32(skb, NDTA_THRESH3, tbl->gc_thresh3))
+	    nla_put_msecs(skb, NDTA_GC_INTERVAL, READ_ONCE(tbl->gc_interval),
+			  NDTA_PAD) ||
+	    nla_put_u32(skb, NDTA_THRESH1, READ_ONCE(tbl->gc_thresh1)) ||
+	    nla_put_u32(skb, NDTA_THRESH2, READ_ONCE(tbl->gc_thresh2)) ||
+	    nla_put_u32(skb, NDTA_THRESH3, READ_ONCE(tbl->gc_thresh3)))
 		goto nla_put_failure;
 	{
 		unsigned long now = jiffies;
-		long flush_delta = now - tbl->last_flush;
-		long rand_delta = now - tbl->last_rand;
+		long flush_delta = now - READ_ONCE(tbl->last_flush);
+		long rand_delta = now - READ_ONCE(tbl->last_rand);
 		struct neigh_hash_table *nht;
 		struct ndt_config ndc = {
 			.ndtc_key_len		= tbl->key_len,
@@ -2066,7 +2069,7 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			.ndtc_entries		= atomic_read(&tbl->entries),
 			.ndtc_last_flush	= jiffies_to_msecs(flush_delta),
 			.ndtc_last_rand		= jiffies_to_msecs(rand_delta),
-			.ndtc_proxy_qlen	= tbl->proxy_queue.qlen,
+			.ndtc_proxy_qlen	= READ_ONCE(tbl->proxy_queue.qlen),
 		};
 
 		rcu_read_lock_bh();
@@ -2089,17 +2092,17 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			struct neigh_statistics	*st;
 
 			st = per_cpu_ptr(tbl->stats, cpu);
-			ndst.ndts_allocs		+= st->allocs;
-			ndst.ndts_destroys		+= st->destroys;
-			ndst.ndts_hash_grows		+= st->hash_grows;
-			ndst.ndts_res_failed		+= st->res_failed;
-			ndst.ndts_lookups		+= st->lookups;
-			ndst.ndts_hits			+= st->hits;
-			ndst.ndts_rcv_probes_mcast	+= st->rcv_probes_mcast;
-			ndst.ndts_rcv_probes_ucast	+= st->rcv_probes_ucast;
-			ndst.ndts_periodic_gc_runs	+= st->periodic_gc_runs;
-			ndst.ndts_forced_gc_runs	+= st->forced_gc_runs;
-			ndst.ndts_table_fulls		+= st->table_fulls;
+			ndst.ndts_allocs		+= READ_ONCE(st->allocs);
+			ndst.ndts_destroys		+= READ_ONCE(st->destroys);
+			ndst.ndts_hash_grows		+= READ_ONCE(st->hash_grows);
+			ndst.ndts_res_failed		+= READ_ONCE(st->res_failed);
+			ndst.ndts_lookups		+= READ_ONCE(st->lookups);
+			ndst.ndts_hits			+= READ_ONCE(st->hits);
+			ndst.ndts_rcv_probes_mcast	+= READ_ONCE(st->rcv_probes_mcast);
+			ndst.ndts_rcv_probes_ucast	+= READ_ONCE(st->rcv_probes_ucast);
+			ndst.ndts_periodic_gc_runs	+= READ_ONCE(st->periodic_gc_runs);
+			ndst.ndts_forced_gc_runs	+= READ_ONCE(st->forced_gc_runs);
+			ndst.ndts_table_fulls		+= READ_ONCE(st->table_fulls);
 		}
 
 		if (nla_put_64bit(skb, NDTA_STATS, sizeof(ndst), &ndst,
@@ -2323,16 +2326,16 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout_tbl_lock;
 
 	if (tb[NDTA_THRESH1])
-		tbl->gc_thresh1 = nla_get_u32(tb[NDTA_THRESH1]);
+		WRITE_ONCE(tbl->gc_thresh1, nla_get_u32(tb[NDTA_THRESH1]));
 
 	if (tb[NDTA_THRESH2])
-		tbl->gc_thresh2 = nla_get_u32(tb[NDTA_THRESH2]);
+		WRITE_ONCE(tbl->gc_thresh2, nla_get_u32(tb[NDTA_THRESH2]));
 
 	if (tb[NDTA_THRESH3])
-		tbl->gc_thresh3 = nla_get_u32(tb[NDTA_THRESH3]);
+		WRITE_ONCE(tbl->gc_thresh3, nla_get_u32(tb[NDTA_THRESH3]));
 
 	if (tb[NDTA_GC_INTERVAL])
-		tbl->gc_interval = nla_get_msecs(tb[NDTA_GC_INTERVAL]);
+		WRITE_ONCE(tbl->gc_interval, nla_get_msecs(tb[NDTA_GC_INTERVAL]));
 
 	err = 0;
 
-- 
2.42.0



