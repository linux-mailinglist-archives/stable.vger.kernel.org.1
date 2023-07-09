Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B2174C260
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjGILT4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjGILT4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11147130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC8D60BD8
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6834C433C8;
        Sun,  9 Jul 2023 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901594;
        bh=B7Yi6X3NpnwVMVONPwLd4CLgowPgEwOsWYm1FXPeHEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOCJPk4tFR6LNPG/wBAv5nEmd4W7jjg0rZJEiimM6/4Q6Chl8aM/wjVYQDBtJICH/
         s1MoVmevKiNmBjPvZ8/lgANf+l2WC6utLgtRYmU/9MFKQlxryS/X5/vfmx7kV0o7ug
         di75d7JpNWFHul0cVTCfWW0yxeqpK2SjSn8eRC6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Hao Jia <jiahao.os@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 076/431] sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()
Date:   Sun,  9 Jul 2023 13:10:24 +0200
Message-ID: <20230709111452.937283728@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hao Jia <jiahao.os@bytedance.com>

[ Upstream commit ebb83d84e49b54369b0db67136a5fe1087124dcc ]

After commit 8ad075c2eb1f ("sched: Async unthrottling for cfs
bandwidth"), we may update the rq clock multiple times in the loop of
__cfsb_csd_unthrottle().

A prior (although less common) instance of this problem exists in
unthrottle_offline_cfs_rqs().

Cure both by ensuring update_rq_clock() is called before the loop and
setting RQCF_ACT_SKIP during the loop, to supress further updates.
The alternative would be pulling update_rq_clock() out of
unthrottle_cfs_rq(), but that gives an even bigger mess.

Fixes: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")
Reviewed-By: Ben Segall <bsegall@google.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20230613082012.49615-4-jiahao.os@bytedance.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c  | 18 ++++++++++++++++++
 kernel/sched/sched.h | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed89be0aa6503..853b7ef9dcafc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5519,6 +5519,14 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rq_lock(rq, &rf);
 
+	/*
+	 * Iterating over the list can trigger several call to
+	 * update_rq_clock() in unthrottle_cfs_rq().
+	 * Do it once and skip the potential next ones.
+	 */
+	update_rq_clock(rq);
+	rq_clock_start_loop_update(rq);
+
 	/*
 	 * Since we hold rq lock we're safe from concurrent manipulation of
 	 * the CSD list. However, this RCU critical section annotates the
@@ -5538,6 +5546,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rcu_read_unlock();
 
+	rq_clock_stop_loop_update(rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -6054,6 +6063,13 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * The rq clock has already been updated in the
+	 * set_rq_offline(), so we should skip updating
+	 * the rq clock again in unthrottle_cfs_rq().
+	 */
+	rq_clock_start_loop_update(rq);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
@@ -6076,6 +6092,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 			unthrottle_cfs_rq(cfs_rq);
 	}
 	rcu_read_unlock();
+
+	rq_clock_stop_loop_update(rq);
 }
 
 #else /* CONFIG_CFS_BANDWIDTH */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e3..3adac73b17ca5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1546,6 +1546,28 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
+/*
+ * During cpu offlining and rq wide unthrottling, we can trigger
+ * an update_rq_clock() for several cfs and rt runqueues (Typically
+ * when using list_for_each_entry_*)
+ * rq_clock_start_loop_update() can be called after updating the clock
+ * once and before iterating over the list to prevent multiple update.
+ * After the iterative traversal, we need to call rq_clock_stop_loop_update()
+ * to clear RQCF_ACT_SKIP of rq->clock_update_flags.
+ */
+static inline void rq_clock_start_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	SCHED_WARN_ON(rq->clock_update_flags & RQCF_ACT_SKIP);
+	rq->clock_update_flags |= RQCF_ACT_SKIP;
+}
+
+static inline void rq_clock_stop_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	rq->clock_update_flags &= ~RQCF_ACT_SKIP;
+}
+
 struct rq_flags {
 	unsigned long flags;
 	struct pin_cookie cookie;
-- 
2.39.2



