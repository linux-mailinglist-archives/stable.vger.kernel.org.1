Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C579E1FB
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbjIMIZI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbjIMIZH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 04:25:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1995819B2
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 01:24:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-573e0d471ceso4572830a12.2
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694593479; x=1695198279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NerOxo/Xet1iSR6t25Iug1uoSd/sPOYc1SroBY+3+S8=;
        b=F2i3wsZY1m/JmVFTUeBxm5668+ZihPYEW4MqtMvx8sjtq+xXZBeS9knHd90k8q5QQe
         /5mVvL/8HJy1OBPblVv1DVXE4zDzV2AYAnnaBHgi6PhJbfD0ZljHVTSMRU9vaQKgg2lA
         NIqIcH/iVx5nh91Z7WDB2NzHMP7WkwIqjbvFWYG0VSOmgHPbMGnIAWFDGkFHe5FkNAIh
         4DU1ZHFUBGQ4B5Gsi5EiQdVv+82JuHaAZfOfOr6R/CzuEUzeWS0AVx4FqbYGAQrPIbJs
         F6+k/1rzvau6SKOdW3OSzPq+SZ182kTpf0ZhI0U1wPc9wmGgRK0FWZImMtqg6YY5dCgr
         BwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593479; x=1695198279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NerOxo/Xet1iSR6t25Iug1uoSd/sPOYc1SroBY+3+S8=;
        b=e+ca/8H5GT5tBekG5AzxoZqp8pAvgqKQYF29pNmvyTdhBr87LoF0YyEIujvMg+pnO+
         gP7TKywrMahBqlZHqMRlW6XoZfeMvURYPT16FX4HVoT+XrbyM1wsXhc0BaIItJx+8hjT
         NYDe0HEgPhMDFabQTN2X0uo/0N/xiV0qHq7q2TqL9DDGjA6q5clVRgvVMMC88UdzF5q4
         lPF1DttWlR9ocuD2aA/4aBDzZCCS/FW4/WKxby0lTBYmU78dkZYlCUi8m15sooIZ6yqM
         /9B1th3be5/3grVstjUfoqt4H6LeusDvY0mmxVG8jqYQLIiYfT78OhqkhZON67jKkmr3
         XQxg==
X-Gm-Message-State: AOJu0YwW80lHpFQF8e6aQBhUi/oSxvYfUa/CPPO/fiNmwyRvFwT61YAS
        UET+RtUzQdMa1SzDnrL+WmqV6w==
X-Google-Smtp-Source: AGHT+IG65wPuasuLxriLgRjy3n06qZHiH2RdjDj9cyh+QsrEvt28tN1EcUbBv9A5EfautCoYCYwcZw==
X-Received: by 2002:a05:6a20:3956:b0:14c:5dc3:f1c9 with SMTP id r22-20020a056a20395600b0014c5dc3f1c9mr1921501pzg.49.1694593479512;
        Wed, 13 Sep 2023 01:24:39 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id z91-20020a17090a6d6400b0025c1cfdb93esm991443pjj.13.2023.09.13.01.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:24:39 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>,
        stable@vger.kernel.org, Igor Raits <igor.raits@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] sched/core: Fix wrong warning check in rq_clock_start_loop_update()
Date:   Wed, 13 Sep 2023 16:24:24 +0800
Message-Id: <20230913082424.73252-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Igor Raits and Bagas Sanjaya report a RQCF_ACT_SKIP leak warning.
Link: https://lore.kernel.org/all/a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com

Commit ebb83d84e49b54 ("sched/core: Avoid multiple
calling update_rq_clock() in __cfsb_csd_unthrottle()")
add RQCF_ACT_SKIP leak warning in rq_clock_start_loop_update().
But this warning is inaccurate and may be triggered
incorrectly in the following situations:

    CPU0                                      CPU1

__schedule()
  *rq->clock_update_flags <<= 1;*   unregister_fair_sched_group()
  pick_next_task_fair+0x4a/0x410      destroy_cfs_bandwidth()
    newidle_balance+0x115/0x3e0       for_each_possible_cpu(i) *i=0*
      rq_unpin_lock(this_rq, rf)      __cfsb_csd_unthrottle()
      raw_spin_rq_unlock(this_rq)
                                      rq_lock(*CPU0_rq*, &rf)
                                      rq_clock_start_loop_update()
                                      rq->clock_update_flags & RQCF_ACT_SKIP <--

      raw_spin_rq_lock(this_rq)

So we remove this wrong check. Add assert_clock_updated() to
check that rq clock has been updated before calling
rq_clock_start_loop_update(). And we cannot unconditionally set
rq->clock_update_flags to RQCF_ACT_SKIP in rq_clock_start_loop_update().
So we use the variable rq_clock_flags in rq_clock_start_loop_update()
to record the previous state of rq->clock_update_flags.
Correspondingly, restore rq->clock_update_flags through
rq_clock_flags in rq_clock_stop_loop_update() to prevent
losing its previous information.

Fixes: ebb83d84e49b ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")
Cc: stable@vger.kernel.org
Reported-by: Igor Raits <igor.raits@gmail.com>
Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/fair.c  | 10 ++++++----
 kernel/sched/sched.h | 12 +++++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dbff6e7ad4f..a64a002573d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5679,6 +5679,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 static void __cfsb_csd_unthrottle(void *arg)
 {
+	unsigned int rq_clock_flags;
 	struct cfs_rq *cursor, *tmp;
 	struct rq *rq = arg;
 	struct rq_flags rf;
@@ -5691,7 +5692,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 	 * Do it once and skip the potential next ones.
 	 */
 	update_rq_clock(rq);
-	rq_clock_start_loop_update(rq);
+	rq_clock_start_loop_update(rq, &rq_clock_flags);
 
 	/*
 	 * Since we hold rq lock we're safe from concurrent manipulation of
@@ -5712,7 +5713,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rcu_read_unlock();
 
-	rq_clock_stop_loop_update(rq);
+	rq_clock_stop_loop_update(rq, &rq_clock_flags);
 	rq_unlock(rq, &rf);
 }
 
@@ -6230,6 +6231,7 @@ static void __maybe_unused update_runtime_enabled(struct rq *rq)
 /* cpu offline callback */
 static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 {
+	unsigned int rq_clock_flags;
 	struct task_group *tg;
 
 	lockdep_assert_rq_held(rq);
@@ -6239,7 +6241,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	 * set_rq_offline(), so we should skip updating
 	 * the rq clock again in unthrottle_cfs_rq().
 	 */
-	rq_clock_start_loop_update(rq);
+	rq_clock_start_loop_update(rq, &rq_clock_flags);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -6264,7 +6266,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	}
 	rcu_read_unlock();
 
-	rq_clock_stop_loop_update(rq);
+	rq_clock_stop_loop_update(rq, &rq_clock_flags);
 }
 
 bool cfs_task_bw_constrained(struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04846272409c..ff2864f202f5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1558,20 +1558,22 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
  * when using list_for_each_entry_*)
  * rq_clock_start_loop_update() can be called after updating the clock
  * once and before iterating over the list to prevent multiple update.
+ * And use @rq_clock_flags to record the previous state of rq->clock_update_flags.
  * After the iterative traversal, we need to call rq_clock_stop_loop_update()
- * to clear RQCF_ACT_SKIP of rq->clock_update_flags.
+ * to restore rq->clock_update_flags through @rq_clock_flags.
  */
-static inline void rq_clock_start_loop_update(struct rq *rq)
+static inline void rq_clock_start_loop_update(struct rq *rq, unsigned int *rq_clock_flags)
 {
 	lockdep_assert_rq_held(rq);
-	SCHED_WARN_ON(rq->clock_update_flags & RQCF_ACT_SKIP);
+	assert_clock_updated(rq);
+	*rq_clock_flags = rq->clock_update_flags;
 	rq->clock_update_flags |= RQCF_ACT_SKIP;
 }
 
-static inline void rq_clock_stop_loop_update(struct rq *rq)
+static inline void rq_clock_stop_loop_update(struct rq *rq, unsigned int *rq_clock_flags)
 {
 	lockdep_assert_rq_held(rq);
-	rq->clock_update_flags &= ~RQCF_ACT_SKIP;
+	rq->clock_update_flags = *rq_clock_flags;
 }
 
 struct rq_flags {
-- 
2.39.2

