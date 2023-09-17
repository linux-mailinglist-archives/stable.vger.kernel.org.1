Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC4D7A396D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjIQTtW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjIQTtK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:49:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17C18D
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:49:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8D0C433C8;
        Sun, 17 Sep 2023 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980142;
        bh=2KcAl3wUkDIBt3gjy4sv6hzT4ZUc1b5Zb/6xBAWibZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6J9yZSVTihBQc6vbwOQrXL1q3BnEaxheh42JmxQnhFe7wL+4krjxvHXs5CSxXdYo
         X6NqRMW89p6OslhV859tZ6yX7FKBH+6Rd/a60mzfOMIGF99zvZ1nnO/gOMfAa/RiDx
         jhBgpoUR7KQBKw/s7knlOMCogkB8nMcPXlJEk4Ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com,
        Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 107/285] net/sched: fq_pie: avoid stalls in fq_pie_timer()
Date:   Sun, 17 Sep 2023 21:11:47 +0200
Message-ID: <20230917191055.367576546@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8c21ab1bae945686c602c5bfa4e3f3352c2452c5 ]

When setting a high number of flows (limit being 65536),
fq_pie_timer() is currently using too much time as syzbot reported.

Add logic to yield the cpu every 2048 flows (less than 150 usec
on debug kernels).
It should also help by not blocking qdisc fast paths for too long.
Worst case (65536 flows) would need 31 jiffies for a complete scan.

Relevant extract from syzbot report:

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 2663 jiffies s: 873 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 00 01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893b0
RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d178
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
 fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Link: https://lore.kernel.org/lkml/00000000000017ad3f06040bf394@google.com/
Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20230829123541.3745013-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_fq_pie.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 591d87d5e5c0f..68e6acd0f130d 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -61,6 +61,7 @@ struct fq_pie_sched_data {
 	struct pie_params p_params;
 	u32 ecn_prob;
 	u32 flows_cnt;
+	u32 flows_cursor;
 	u32 quantum;
 	u32 memory_limit;
 	u32 new_flow_count;
@@ -375,22 +376,32 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 static void fq_pie_timer(struct timer_list *t)
 {
 	struct fq_pie_sched_data *q = from_timer(q, t, adapt_timer);
+	unsigned long next, tupdate;
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock; /* to lock qdisc for probability calculations */
-	u32 idx;
+	int max_cnt, i;
 
 	rcu_read_lock();
 	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 
-	for (idx = 0; idx < q->flows_cnt; idx++)
-		pie_calculate_probability(&q->p_params, &q->flows[idx].vars,
-					  q->flows[idx].backlog);
-
-	/* reset the timer to fire after 'tupdate' jiffies. */
-	if (q->p_params.tupdate)
-		mod_timer(&q->adapt_timer, jiffies + q->p_params.tupdate);
+	/* Limit this expensive loop to 2048 flows per round. */
+	max_cnt = min_t(int, q->flows_cnt - q->flows_cursor, 2048);
+	for (i = 0; i < max_cnt; i++) {
+		pie_calculate_probability(&q->p_params,
+					  &q->flows[q->flows_cursor].vars,
+					  q->flows[q->flows_cursor].backlog);
+		q->flows_cursor++;
+	}
 
+	tupdate = q->p_params.tupdate;
+	next = 0;
+	if (q->flows_cursor >= q->flows_cnt) {
+		q->flows_cursor = 0;
+		next = tupdate;
+	}
+	if (tupdate)
+		mod_timer(&q->adapt_timer, jiffies + next);
 	spin_unlock(root_lock);
 	rcu_read_unlock();
 }
-- 
2.40.1



