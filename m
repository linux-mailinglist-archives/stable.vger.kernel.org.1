Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D598783233
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHUT5y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHUT5y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ADEFB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0F1E64681
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC95C433C8;
        Mon, 21 Aug 2023 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647870;
        bh=tbgZbI9zH8cUuSeJO2yqYCSSYZgfEY0o6z4CW+uSWQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIR3EE8FNLinY8GqkQ8LIc/8GTUovLtei/8cz1/aUyd/U4BPAG+u+vaC/q4vfBj5p
         nW46D2FG0GhObDoE874+SHpYc1X3MuRx4lilpCUcWaRdw+wFiA8sFCKObXm4IEZ6pz
         ImWF3GOvqh2IAgpjxm3wkSKIpsnrKEVUeZ15Twpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        "Qais Yousef (Google)" <qyousef@layalina.io>
Subject: [PATCH 6.1 168/194] sched/fair: unlink misfit task from cpu overutilized
Date:   Mon, 21 Aug 2023 21:42:27 +0200
Message-ID: <20230821194130.083799779@linuxfoundation.org>
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

commit e5ed0550c04c5469ecdc1634d8aa18c8609590f0 upstream.

By taking into account uclamp_min, the 1:1 relation between task misfit
and cpu overutilized is no more true as a task with a small util_avg may
not fit a high capacity cpu because of uclamp_min constraint.

Add a new state in util_fits_cpu() to reflect the case that task would fit
a CPU except for the uclamp_min hint which is a performance requirement.

Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
can use this new value to take additional action to select the best CPU
that doesn't match uclamp_min hint.

When util_fits_cpu() returns -1, we will continue to look for a possible
CPU with better performance, which replaces Capacity Inversion detection
with capacity_orig_of() - thermal_load_avg to detect a capacity inversion.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-and-tested-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
Link: https://lore.kernel.org/r/20230201143628.270912-2-vincent.guittot@linaro.org
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c |  105 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 23 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4549,8 +4549,8 @@ static inline int util_fits_cpu(unsigned
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
-		fits = fits && (uclamp_min <= capacity_orig_thermal);
+	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+		return -1;
 
 	return fits;
 }
@@ -4560,7 +4560,11 @@ static inline int task_fits_cpu(struct t
 	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
 	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
 	unsigned long util = task_util_est(p);
-	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
+	/*
+	 * Return true only if the cpu fully fits the task requirements, which
+	 * include the utilization but also the performance hints.
+	 */
+	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -6043,6 +6047,7 @@ static inline bool cpu_overutilized(int
 	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
+	/* Return true only if the utilization doesn't fit CPU's capacity */
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
@@ -6836,6 +6841,7 @@ static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	unsigned long task_util, util_min, util_max, best_cap = 0;
+	int fits, best_fits = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
@@ -6851,12 +6857,28 @@ select_idle_capacity(struct task_struct
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
-		if (util_fits_cpu(task_util, util_min, util_max, cpu))
+
+		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
+
+		/* This CPU fits with all requirements */
+		if (fits > 0)
 			return cpu;
+		/*
+		 * Only the min performance hint (i.e. uclamp_min) doesn't fit.
+		 * Look for the CPU with best capacity.
+		 */
+		else if (fits < 0)
+			cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
 
-		if (cpu_cap > best_cap) {
+		/*
+		 * First, select CPU which fits better (-1 being better than 0).
+		 * Then, select the one with best capacity at same level.
+		 */
+		if ((fits < best_fits) ||
+		    ((fits == best_fits) && (cpu_cap > best_cap))) {
 			best_cap = cpu_cap;
 			best_cpu = cpu;
+			best_fits = fits;
 		}
 	}
 
@@ -6869,7 +6891,11 @@ static inline bool asym_fits_cpu(unsigne
 				 int cpu)
 {
 	if (sched_asym_cpucap_active())
-		return util_fits_cpu(util, util_min, util_max, cpu);
+		/*
+		 * Return true only if the cpu fully fits the task requirements
+		 * which include the utilization and the performance hints.
+		 */
+		return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
 
 	return true;
 }
@@ -7236,6 +7262,9 @@ static int find_energy_efficient_cpu(str
 	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
+	int prev_fits = -1, best_fits = -1;
+	unsigned long best_thermal_cap = 0;
+	unsigned long prev_thermal_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -7271,6 +7300,7 @@ static int find_energy_efficient_cpu(str
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
+		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -7320,7 +7350,9 @@ static int find_energy_efficient_cpu(str
 				util_min = max(rq_util_min, p_util_min);
 				util_max = max(rq_util_max, p_util_max);
 			}
-			if (!util_fits_cpu(util, util_min, util_max, cpu))
+
+			fits = util_fits_cpu(util, util_min, util_max, cpu);
+			if (!fits)
 				continue;
 
 			lsub_positive(&cpu_cap, util);
@@ -7328,7 +7360,9 @@ static int find_energy_efficient_cpu(str
 			if (cpu == prev_cpu) {
 				/* Always use prev_cpu as a candidate. */
 				prev_spare_cap = cpu_cap;
-			} else if (cpu_cap > max_spare_cap) {
+				prev_fits = fits;
+			} else if ((fits > max_fits) ||
+				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -7336,6 +7370,7 @@ static int find_energy_efficient_cpu(str
 				 */
 				max_spare_cap = cpu_cap;
 				max_spare_cap_cpu = cpu;
+				max_fits = fits;
 			}
 		}
 
@@ -7354,26 +7389,50 @@ static int find_energy_efficient_cpu(str
 			if (prev_delta < base_energy)
 				goto unlock;
 			prev_delta -= base_energy;
+			prev_thermal_cap = cpu_thermal_cap;
 			best_delta = min(best_delta, prev_delta);
 		}
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
+			/* Current best energy cpu fits better */
+			if (max_fits < best_fits)
+				continue;
+
+			/*
+			 * Both don't fit performance hint (i.e. uclamp_min)
+			 * but best energy cpu has better capacity.
+			 */
+			if ((max_fits < 0) &&
+			    (cpu_thermal_cap <= best_thermal_cap))
+				continue;
+
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
 			/* CPU utilization has changed */
 			if (cur_delta < base_energy)
 				goto unlock;
 			cur_delta -= base_energy;
-			if (cur_delta < best_delta) {
-				best_delta = cur_delta;
-				best_energy_cpu = max_spare_cap_cpu;
-			}
+
+			/*
+			 * Both fit for the task but best energy cpu has lower
+			 * energy impact.
+			 */
+			if ((max_fits > 0) && (best_fits > 0) &&
+			    (cur_delta >= best_delta))
+				continue;
+
+			best_delta = cur_delta;
+			best_energy_cpu = max_spare_cap_cpu;
+			best_fits = max_fits;
+			best_thermal_cap = cpu_thermal_cap;
 		}
 	}
 	rcu_read_unlock();
 
-	if (best_delta < prev_delta)
+	if ((best_fits > prev_fits) ||
+	    ((best_fits > 0) && (best_delta < prev_delta)) ||
+	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
 		target = best_energy_cpu;
 
 	return target;
@@ -10183,24 +10242,23 @@ static struct sched_group *find_busiest_
 	 */
 	update_sd_lb_stats(env, &sds);
 
-	if (sched_energy_enabled()) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
-			goto out_balanced;
-	}
-
-	local = &sds.local_stat;
-	busiest = &sds.busiest_stat;
-
 	/* There is no busy sibling group to pull tasks from */
 	if (!sds.busiest)
 		goto out_balanced;
 
+	busiest = &sds.busiest_stat;
+
 	/* Misfit tasks should be dealt with regardless of the avg load */
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;
 
+	if (sched_energy_enabled()) {
+		struct root_domain *rd = env->dst_rq->rd;
+
+		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+			goto out_balanced;
+	}
+
 	/* ASYM feature bypasses nice load balance check */
 	if (busiest->group_type == group_asym_packing)
 		goto force_balance;
@@ -10213,6 +10271,7 @@ static struct sched_group *find_busiest_
 	if (busiest->group_type == group_imbalanced)
 		goto force_balance;
 
+	local = &sds.local_stat;
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.


