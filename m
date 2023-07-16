Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F58755205
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGPUCy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjGPUCx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AE7199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3305560EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45564C433C7;
        Sun, 16 Jul 2023 20:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537770;
        bh=D3qR7Rw7TW1U8YX1PfSVsazmVpoFDDLkdJUHAB+QyEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lE7uOgRCG/5lU8P995dAJAElhmbPSIeDECpl4BnzrfdGypjfm8w/4xoHeDlWpmnw7
         uLT79KyNgV+q5uzhj0QOTWxUb9iFH5EPkFeeKHgd0MmGFizZwLiX7kVVT4Gfx2fjXp
         JakvapqccyDlBCWep/AIHkSeoGnVj2omy/Lr41o8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 207/800] sch_netem: fix issues in netem_change() vs get_dist_table()
Date:   Sun, 16 Jul 2023 21:41:00 +0200
Message-ID: <20230716194953.905401084@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 11b73313c12403f617b47752db0ab3deef201af7 ]

In blamed commit, I missed that get_dist_table() was allocating
memory using GFP_KERNEL, and acquiring qdisc lock to perform
the swap of newly allocated table with current one.

In this patch, get_dist_table() is allocating memory and
copy user data before we acquire the qdisc lock.

Then we perform swap operations while being protected by the lock.

Note that after this patch netem_change() no longer can do partial changes.
If an error is returned, qdisc conf is left unchanged.

Fixes: 2174a08db80d ("sch_netem: acquire qdisc lock in netem_change()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230622181503.2327695-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_netem.c | 59 ++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e79be1b3e74da..b93ec2a3454eb 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -773,12 +773,10 @@ static void dist_free(struct disttable *d)
  * signed 16 bit values.
  */
 
-static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
-			  const struct nlattr *attr)
+static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 {
 	size_t n = nla_len(attr)/sizeof(__s16);
 	const __s16 *data = nla_data(attr);
-	spinlock_t *root_lock;
 	struct disttable *d;
 	int i;
 
@@ -793,13 +791,7 @@ static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
 	for (i = 0; i < n; i++)
 		d->table[i] = data[i];
 
-	root_lock = qdisc_root_sleeping_lock(sch);
-
-	spin_lock_bh(root_lock);
-	swap(*tbl, d);
-	spin_unlock_bh(root_lock);
-
-	dist_free(d);
+	*tbl = d;
 	return 0;
 }
 
@@ -956,6 +948,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
+	struct disttable *delay_dist = NULL;
+	struct disttable *slot_dist = NULL;
 	struct tc_netem_qopt *qopt;
 	struct clgstate old_clg;
 	int old_loss_model = CLG_RANDOM;
@@ -966,6 +960,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	if (ret < 0)
 		return ret;
 
+	if (tb[TCA_NETEM_DELAY_DIST]) {
+		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST]);
+		if (ret)
+			goto table_free;
+	}
+
+	if (tb[TCA_NETEM_SLOT_DIST]) {
+		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST]);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
@@ -975,26 +981,17 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
 		if (ret) {
 			q->loss_model = old_loss_model;
+			q->clg = old_clg;
 			goto unlock;
 		}
 	} else {
 		q->loss_model = CLG_RANDOM;
 	}
 
-	if (tb[TCA_NETEM_DELAY_DIST]) {
-		ret = get_dist_table(sch, &q->delay_dist,
-				     tb[TCA_NETEM_DELAY_DIST]);
-		if (ret)
-			goto get_table_failure;
-	}
-
-	if (tb[TCA_NETEM_SLOT_DIST]) {
-		ret = get_dist_table(sch, &q->slot_dist,
-				     tb[TCA_NETEM_SLOT_DIST]);
-		if (ret)
-			goto get_table_failure;
-	}
-
+	if (delay_dist)
+		swap(q->delay_dist, delay_dist);
+	if (slot_dist)
+		swap(q->slot_dist, slot_dist);
 	sch->limit = qopt->limit;
 
 	q->latency = PSCHED_TICKS2NS(qopt->latency);
@@ -1044,17 +1041,11 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 
 unlock:
 	sch_tree_unlock(sch);
-	return ret;
 
-get_table_failure:
-	/* recover clg and loss_model, in case of
-	 * q->clg and q->loss_model were modified
-	 * in get_loss_clg()
-	 */
-	q->clg = old_clg;
-	q->loss_model = old_loss_model;
-
-	goto unlock;
+table_free:
+	dist_free(delay_dist);
+	dist_free(slot_dist);
+	return ret;
 }
 
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
-- 
2.39.2



