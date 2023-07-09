Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4092874C250
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGILTQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjGILTL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:19:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F893194
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2DA960BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69CEC433C7;
        Sun,  9 Jul 2023 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901549;
        bh=O1ACnV1X/r0Nxp0Orfuu5zeLmaoej/ouymZxHTGecjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgUhtI9KC/rMJD+EM2n35KPSVyZGYnOcJW8fehLOs7x8hx75aM/YMhCWHzZ9Mzql7
         kegxtnzJqpczAiTCfVK8HZ8MO3s+hXs54xcGg4IW/HSZyIY8mhSNzeXAsD/2wi+9Uk
         f59xnLrv6KELfCItK8NU3ffG9XtDu8l9hL22CTS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 059/431] rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs
Date:   Sun,  9 Jul 2023 13:10:07 +0200
Message-ID: <20230709111452.518174066@linuxfoundation.org>
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

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit 401b0de3ae4fa49d1014c8941e26d9a25f37e7cf ]

The rcu_tasks_invoke_cbs() function relies on queue_work_on() to silently
fall back to WORK_CPU_UNBOUND when the specified CPU is offline.  However,
the queue_work_on() function's silent fallback mechanism relies on that
CPU having been online at some time in the past.  When queue_work_on()
is passed a CPU that has never been online, workqueue lockups ensue,
which can be bad for your kernel's general health and well-being.

This commit therefore checks whether a given CPU has ever been online,
and, if not substitutes WORK_CPU_UNBOUND in the subsequent call to
queue_work_on().  Why not simply omit the queue_work_on() call entirely?
Because this function is flooding callback-invocation notifications
to all CPUs, and must deal with possibilities that include a sparse
cpu_possible_mask.

This commit also moves the setting of the rcu_data structure's
->beenonline field to rcu_cpu_starting(), which executes on the
incoming CPU before that CPU has ever enabled interrupts.  This ensures
that the required workqueues are present.  In addition, because the
incoming CPU has not yet enabled its interrupts, there cannot yet have
been any softirq handlers running on this CPU, which means that the
WARN_ON_ONCE(!rdp->beenonline) within the RCU_SOFTIRQ handler cannot
have triggered yet.

Fixes: d363f833c6d88 ("rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations")
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcu.h   |  6 ++++++
 kernel/rcu/tasks.h |  7 +++++--
 kernel/rcu/tree.c  | 12 +++++++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 115616ac3bfa6..2d7e85dbf6734 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -603,4 +603,10 @@ void show_rcu_tasks_trace_gp_kthread(void);
 static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif
 
+#ifdef CONFIG_TINY_RCU
+static inline bool rcu_cpu_beenfullyonline(int cpu) { return true; }
+#else
+bool rcu_cpu_beenfullyonline(int cpu);
+#endif
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bfb5e1549f2b2..dfa6ff2eb32f2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -455,6 +455,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 {
 	int cpu;
 	int cpunext;
+	int cpuwq;
 	unsigned long flags;
 	int len;
 	struct rcu_head *rhp;
@@ -465,11 +466,13 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	cpunext = cpu * 2 + 1;
 	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-		queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
+		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
 		cpunext++;
 		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-			queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
+			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
 		}
 	}
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 954a91fec912c..be490f55cb834 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4279,7 +4279,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	 */
 	rnp = rdp->mynode;
 	raw_spin_lock_rcu_node(rnp);		/* irqs already disabled. */
-	rdp->beenonline = true;	 /* We have now been online. */
 	rdp->gp_seq = READ_ONCE(rnp->gp_seq);
 	rdp->gp_seq_needed = rdp->gp_seq;
 	rdp->cpu_no_qs.b.norm = true;
@@ -4306,6 +4305,16 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
 	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
 }
 
+/*
+ * Has the specified (known valid) CPU ever been fully online?
+ */
+bool rcu_cpu_beenfullyonline(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return smp_load_acquire(&rdp->beenonline);
+}
+
 /*
  * Near the end of the CPU-online process.  Pretty much all services
  * enabled, and the CPU is now very much alive.
@@ -4409,6 +4418,7 @@ void rcu_cpu_starting(unsigned int cpu)
 		raw_spin_unlock_rcu_node(rnp);
 	}
 	arch_spin_unlock(&rcu_state.ofl_lock);
+	smp_store_release(&rdp->beenonline, true);
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
 
-- 
2.39.2



