Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479257ED33D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjKOUq6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjKOUq5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6DAA1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C210EC433C8;
        Wed, 15 Nov 2023 20:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081214;
        bh=uf8SziXiuhva0M0xN4hqs6FO/FaZ3MBrI8q0G6EfsVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5FP8ICXprUVf5bW7Ebhp6KiiDutdM4/iXa1wt846wDrTn9ZdLBdaZ8b8Vojse7xk
         rx8BIqgZbB8Uj/p+DETV9w19raKFaKZUztUQSmut146qElVsNMMg1aDESKN6zXPEVx
         BJR/F+62h6N9uY/JwKH+720x82hmKkKfVUOoFSYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Qais Yousef (Google)" <qyousef@layalina.io>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 002/244] sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0
Date:   Wed, 15 Nov 2023 15:33:14 -0500
Message-ID: <20231115203548.528515532@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qais Yousef <qyousef@layalina.io>

[ Upstream commit 23c9519def98ee0fa97ea5871535e9b136f522fc ]

find_energy_efficient_cpu() bails out early if effective util of the
task is 0 as the delta at this point will be zero and there's nothing
for EAS to do. When uclamp is being used, this could lead to wrong
decisions when uclamp_max is set to 0. In this case the task is capped
to performance point 0, but it is actually running and consuming energy
and we can benefit from EAS energy calculations.

Rework the condition so that it bails out when both util and uclamp_min
are 0.

We can do that without needing to use uclamp_task_util(); remove it.

Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230916232955.2099394-3-qyousef@layalina.io
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 646a6ae4b2509..e9ea3244fa4d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3987,22 +3987,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
 	return max(task_util(p), _task_util_est(p));
 }
 
-#ifdef CONFIG_UCLAMP_TASK
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return clamp(task_util_est(p), uclamp_min, uclamp_max);
-}
-#else
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return task_util_est(p);
-}
-#endif
-
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -7037,7 +7021,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!task_util_est(p) && p_util_min == 0)
 		goto unlock;
 
 	for (; pd; pd = pd->next) {
-- 
2.42.0



