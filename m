Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4B7612BE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjGYLFY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjGYLFM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98087268E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E16B615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D541C433C8;
        Tue, 25 Jul 2023 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282957;
        bh=IppoW13h+PODzWeML1ta+MgYDFItWuRzkgauNSOOwbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xj0uvzWnbB2WhbkJ13nqZXw6odgt7ZFvD9QalBzjbYcWFUPJNuTfB7EgjUS+1iUbR
         3xQm6Eo5c1JbgU0iOn84mhqG2UJCK6UV7cTcE0yzVndkqQVIekLRNcRQ/uXFpY8pD4
         A0ddzfHMCKfFxm0Vhi/0urzPaGUee7hFzS2eXpK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 087/183] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Date:   Tue, 25 Jul 2023 12:45:15 +0200
Message-ID: <20230725104511.103175853@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit 2fcd7bbae90a6d844da8660a9d27079281dfbba2 ]

Pavan reported a problem that PSI avgs_work idle shutoff is not
working at all. Because PSI_NONIDLE condition would be observed in
psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
only the kworker running avgs_work on the CPU.

Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
still will always re-arm the avgs_work, so shutoff is not working.

This patch changes to use PSI_STATE_RESCHEDULE to flag whether to
re-arm avgs_work in get_recent_times(). For the current CPU, we re-arm
avgs_work only when (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0),
for other CPUs we can just check PSI_NONIDLE delta. The new flag
is only used in psi_avgs_work(), so we check in get_recent_times()
that current_work() is avgs_work.

One potential problem is that the brief period of non-idle time
incurred between the aggregation run and the kworker's dequeue will
be stranded in the per-cpu buckets until avgs_work run next time.
The buckets can hold 4s worth of time, and future activity will wake
the avgs_work with a 2s delay, giving us 2s worth of data we can leave
behind when shut off the avgs_work. If the kworker run other works after
avgs_work shut off and doesn't have any scheduler activities for 2s,
this maybe a problem.

Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Link: https://lore.kernel.org/r/20221014110551.22695-1-zhouchengming@bytedance.com
Stable-dep-of: aff037078eca ("sched/psi: use kernfs polling functions for PSI trigger polling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/psi_types.h |  3 +++
 kernel/sched/psi.c        | 30 +++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 14a1ebb74e11f..1e0a0d7ace3af 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -72,6 +72,9 @@ enum psi_states {
 /* Use one bit in the state mask to track TSK_ONCPU */
 #define PSI_ONCPU	(1 << NR_PSI_STATES)
 
+/* Flag whether to re-arm avgs_work, see details in get_recent_times() */
+#define PSI_STATE_RESCHEDULE	(1 << (NR_PSI_STATES + 1))
+
 enum psi_aggregators {
 	PSI_AVGS = 0,
 	PSI_POLL,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e83c321461cf4..02e011cabe917 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -243,6 +243,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 			     u32 *pchanged_states)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+	int current_cpu = raw_smp_processor_id();
+	unsigned int tasks[NR_PSI_TASK_COUNTS];
 	u64 now, state_start;
 	enum psi_states s;
 	unsigned int seq;
@@ -257,6 +259,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
+		if (cpu == current_cpu)
+			memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
 	} while (read_seqcount_retry(&groupc->seq, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
@@ -281,6 +285,28 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		if (delta)
 			*pchanged_states |= (1 << s);
 	}
+
+	/*
+	 * When collect_percpu_times() from the avgs_work, we don't want to
+	 * re-arm avgs_work when all CPUs are IDLE. But the current CPU running
+	 * this avgs_work is never IDLE, cause avgs_work can't be shut off.
+	 * So for the current CPU, we need to re-arm avgs_work only when
+	 * (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0), for other CPUs
+	 * we can just check PSI_NONIDLE delta.
+	 */
+	if (current_work() == &group->avgs_work.work) {
+		bool reschedule;
+
+		if (cpu == current_cpu)
+			reschedule = tasks[NR_RUNNING] +
+				     tasks[NR_IOWAIT] +
+				     tasks[NR_MEMSTALL] > 1;
+		else
+			reschedule = *pchanged_states & (1 << PSI_NONIDLE);
+
+		if (reschedule)
+			*pchanged_states |= PSI_STATE_RESCHEDULE;
+	}
 }
 
 static void calc_avgs(unsigned long avg[3], int missed_periods,
@@ -416,7 +442,6 @@ static void psi_avgs_work(struct work_struct *work)
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	u32 changed_states;
-	bool nonidle;
 	u64 now;
 
 	dwork = to_delayed_work(work);
@@ -427,7 +452,6 @@ static void psi_avgs_work(struct work_struct *work)
 	now = sched_clock();
 
 	collect_percpu_times(group, PSI_AVGS, &changed_states);
-	nonidle = changed_states & (1 << PSI_NONIDLE);
 	/*
 	 * If there is task activity, periodically fold the per-cpu
 	 * times and feed samples into the running averages. If things
@@ -438,7 +462,7 @@ static void psi_avgs_work(struct work_struct *work)
 	if (now >= group->avg_next_update)
 		group->avg_next_update = update_averages(group, now);
 
-	if (nonidle) {
+	if (changed_states & PSI_STATE_RESCHEDULE) {
 		schedule_delayed_work(dwork, nsecs_to_jiffies(
 				group->avg_next_update - now) + 1);
 	}
-- 
2.39.2



