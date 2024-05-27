Return-Path: <stable+bounces-47222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3D78D0D1C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C99A282F86
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8516078C;
	Mon, 27 May 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rvvcrmE4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C8168C4;
	Mon, 27 May 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837983; cv=none; b=Hzj4c3GIE5oSuYV1HUYMnvS628A7JT9iDi/TBfnghEQnr1vWV3NyREHVopvxdg7nmVhqbBqt93Qe4zNafzPAX2I+clvx2bkRIUqTTj7II52kCeRwa6oh7qqgHOOZKWA43Sc+RFdk/35RKct1bdrVl6vcxGUgPnZ55dSS7Q9hpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837983; c=relaxed/simple;
	bh=N6w5JmmR3HBAIDM00GUaUR0VzF8gXHtOODQPB86+Soc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJh9bLq/uTUpqhzQFCvX47thyBFEJKuFFAxIVt3HumSickTpMpf9cjf+pMzFMOnI44WqNtfNN/lw8PAU763FP191n7oOTWjBO/cPBU5ys3PN+iD3ljFmXhZ22tsQ/t2rVMPh2Pa283OVNWmQH+aL8y3rzp0zh0IMruXXSvgDtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rvvcrmE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AD0C2BBFC;
	Mon, 27 May 2024 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837983;
	bh=N6w5JmmR3HBAIDM00GUaUR0VzF8gXHtOODQPB86+Soc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvvcrmE4FLoFVb3Cr/ApGTcmq9AkdxpoQE5Czdvg02c7IkGRKtUaZ+XxKQ7/M1qq8
	 HoxeRRI82N3MSUAkYCauL7/2RIZb9S9CM9aPnH4aIXZI8+oplfCiFu1eNN796aA526
	 pu/nyDDZZrip7rAliAcftLMcWcZe395F5xmGUcbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 178/493] sched/fair: Add EAS checks before updating root_domain::overutilized
Date: Mon, 27 May 2024 20:53:00 +0200
Message-ID: <20240527185636.172837905@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shrikanth Hegde <sshegde@linux.ibm.com>

[ Upstream commit be3a51e68f2f1b17250ce40d8872c7645b7a2991 ]

root_domain::overutilized is only used for EAS(energy aware scheduler)
to decide whether to do load balance or not. It is not used if EAS
not possible.

Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
this field. In update_sd_lb_stats it is updated often. This causes cache
contention due to true sharing and burns a lot of cycles. ::overload and
::overutilized are part of the same cacheline. Updating it often invalidates
the cacheline. That causes access to ::overload to slow down due to
false sharing. Hence add EAS check before accessing/updating this field.
EAS check is optimized at compile time or it is a static branch.
Hence it shouldn't cost much.

With the patch, both enqueue_task_fair and newidle_balance don't show
up as hot routines in perf profile.

  6.8-rc4:
  7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
  6.78%  s                [kernel.vmlinux]              [k] newidle_balance

  +patch:
  0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
  0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance

While at it: trace_sched_overutilized_tp expect that second argument to
be bool. So do a int to bool conversion for that.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240307085725.444486-2-sshegde@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 53 +++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aee5e7a70170c..a01269ed968a7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6669,22 +6669,42 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+	unsigned long  rq_util_min, rq_util_max;
+
+	if (!sched_energy_enabled())
+		return false;
+
+	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
+	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
 	/* Return true only if the utilization doesn't fit CPU's capacity */
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
-static inline void update_overutilized_status(struct rq *rq)
+static inline void set_rd_overutilized_status(struct root_domain *rd,
+					      unsigned int status)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
-		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
-	}
+	if (!sched_energy_enabled())
+		return;
+
+	WRITE_ONCE(rd->overutilized, status);
+	trace_sched_overutilized_tp(rd, !!status);
+}
+
+static inline void check_update_overutilized_status(struct rq *rq)
+{
+	/*
+	 * overutilized field is used for load balancing decisions only
+	 * if energy aware scheduler is being used
+	 */
+	if (!sched_energy_enabled())
+		return;
+
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 }
 #else
-static inline void update_overutilized_status(struct rq *rq) { }
+static inline void check_update_overutilized_status(struct rq *rq) { }
 #endif
 
 /* Runqueue only has SCHED_IDLE tasks enqueued */
@@ -6785,7 +6805,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * and the following generally works well enough in practice.
 	 */
 	if (!task_new)
-		update_overutilized_status(rq);
+		check_update_overutilized_status(rq);
 
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -10621,19 +10641,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
 	if (!env->sd->parent) {
-		struct root_domain *rd = env->dst_rq->rd;
-
 		/* update overload indicator if we are at root domain */
-		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
+		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
+		set_rd_overutilized_status(env->dst_rq->rd,
+					   sg_status & SG_OVERUTILIZED);
 	} else if (sg_status & SG_OVERUTILIZED) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
+		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
 	}
 
 	update_idle_cpu_scan(env, sum_util);
@@ -12639,7 +12654,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
-	update_overutilized_status(task_rq(curr));
+	check_update_overutilized_status(task_rq(curr));
 
 	task_tick_core(rq, curr);
 }
-- 
2.43.0




