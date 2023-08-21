Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A71783360
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHUT54 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjHUT54 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CB4128
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E45E6468D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8890CC433C7;
        Mon, 21 Aug 2023 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647872;
        bh=QuVwe4HWWFYbRCmGpAVCPER6VuIYSk0TTi2aujkJaoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mInGgvXsuYAPJ59rigOAeFg4yHc8ks6ZNviQ8cUan37t/hSK1Y4pvyqbBuOpf2Svy
         15FqfsT+Yxbwom5Am7mp9Hi9MRbfZcaKsZxDhUqvFEeo+LFPvLg1Fh6YAlBRAXar9L
         xmGoBwjHWYKT57pw8NJyNEneS2D6dvVGofjPtH5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Qais Yousef (Google)" <qyousef@layalina.io>
Subject: [PATCH 6.1 169/194] sched/fair: Remove capacity inversion detection
Date:   Mon, 21 Aug 2023 21:42:28 +0200
Message-ID: <20230821194130.123737849@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

commit a2e90611b9f425adbbfcdaa5b5e49958ddf6f61b upstream.

Remove the capacity inversion detection which is now handled by
util_fits_cpu() returning -1 when we need to continue to look for a
potential CPU with better performance.

This ends up almost reverting patches below except for some comments:
commit da07d2f9c153 ("sched/fair: Fixes for capacity inversion detection")
commit aa69c36f31aa ("sched/fair: Consider capacity inversion in util_fits_cpu()")
commit 44c7b80bffc3 ("sched/fair: Detect capacity inversion")

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230201143628.270912-3-vincent.guittot@linaro.org
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c  |   84 +++------------------------------------------------
 kernel/sched/sched.h |   19 -----------
 2 files changed, 5 insertions(+), 98 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4464,17 +4464,9 @@ static inline int util_fits_cpu(unsigned
 	 *
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
-	 *
-	 * In case of capacity inversion we should honour the inverted capacity
-	 * for both uclamp_min and uclamp_max all the time.
 	 */
-	capacity_orig = cpu_in_capacity_inversion(cpu);
-	if (capacity_orig) {
-		capacity_orig_thermal = capacity_orig;
-	} else {
-		capacity_orig = capacity_orig_of(cpu);
-		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
-	}
+	capacity_orig = capacity_orig_of(cpu);
+	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -8929,82 +8921,16 @@ static unsigned long scale_rt_capacity(i
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
-	struct rq *rq = cpu_rq(cpu);
 
-	rq->cpu_capacity_orig = capacity_orig;
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
 
 	if (!capacity)
 		capacity = 1;
 
-	rq->cpu_capacity = capacity;
-
-	/*
-	 * Detect if the performance domain is in capacity inversion state.
-	 *
-	 * Capacity inversion happens when another perf domain with equal or
-	 * lower capacity_orig_of() ends up having higher capacity than this
-	 * domain after subtracting thermal pressure.
-	 *
-	 * We only take into account thermal pressure in this detection as it's
-	 * the only metric that actually results in *real* reduction of
-	 * capacity due to performance points (OPPs) being dropped/become
-	 * unreachable due to thermal throttling.
-	 *
-	 * We assume:
-	 *   * That all cpus in a perf domain have the same capacity_orig
-	 *     (same uArch).
-	 *   * Thermal pressure will impact all cpus in this perf domain
-	 *     equally.
-	 */
-	if (sched_energy_enabled()) {
-		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
-		struct perf_domain *pd;
-
-		rcu_read_lock();
-
-		pd = rcu_dereference(rq->rd->pd);
-		rq->cpu_capacity_inverted = 0;
-
-		for (; pd; pd = pd->next) {
-			struct cpumask *pd_span = perf_domain_span(pd);
-			unsigned long pd_cap_orig, pd_cap;
-
-			/* We can't be inverted against our own pd */
-			if (cpumask_test_cpu(cpu_of(rq), pd_span))
-				continue;
-
-			cpu = cpumask_any(pd_span);
-			pd_cap_orig = arch_scale_cpu_capacity(cpu);
-
-			if (capacity_orig < pd_cap_orig)
-				continue;
-
-			/*
-			 * handle the case of multiple perf domains have the
-			 * same capacity_orig but one of them is under higher
-			 * thermal pressure. We record it as capacity
-			 * inversion.
-			 */
-			if (capacity_orig == pd_cap_orig) {
-				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
-
-				if (pd_cap > inv_cap) {
-					rq->cpu_capacity_inverted = inv_cap;
-					break;
-				}
-			} else if (pd_cap_orig > inv_cap) {
-				rq->cpu_capacity_inverted = inv_cap;
-				break;
-			}
-		}
-
-		rcu_read_unlock();
-	}
-
-	trace_sched_cpu_capacity_tp(rq);
+	cpu_rq(cpu)->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1041,7 +1041,6 @@ struct rq {
 
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
-	unsigned long		cpu_capacity_inverted;
 
 	struct balance_callback *balance_callback;
 
@@ -2879,24 +2878,6 @@ static inline unsigned long capacity_ori
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
 
-/*
- * Returns inverted capacity if the CPU is in capacity inversion state.
- * 0 otherwise.
- *
- * Capacity inversion detection only considers thermal impact where actual
- * performance points (OPPs) gets dropped.
- *
- * Capacity inversion state happens when another performance domain that has
- * equal or lower capacity_orig_of() becomes effectively larger than the perf
- * domain this CPU belongs to due to thermal pressure throttling it hard.
- *
- * See comment in update_cpu_capacity().
- */
-static inline unsigned long cpu_in_capacity_inversion(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_inverted;
-}
-
 /**
  * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency


