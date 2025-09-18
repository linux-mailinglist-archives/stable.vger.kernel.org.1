Return-Path: <stable+bounces-169378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC58B2496E
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1157AC4AD
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B505C184540;
	Wed, 13 Aug 2025 12:20:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5705D17D2
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087648; cv=none; b=FLv6Ikpv1XON2sbz6DKJCw1vlb8Wv9x6nvVhZd9ZIrhXDcYaQPygKbg4xPns2xxyw/4Krq02zQh7tUTUB55LrwstM/pIxWmgvmLsdJbHyK78znj3XHRyBIVNEzTZy065Yzg3KJPZT7VUqlV/+sllq/vdyDbWZ7oV70MRbxJudvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087648; c=relaxed/simple;
	bh=hOYg9mwOocb5T4tUs0hVrdbCJ85Z3FhLLaVPLozj7O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvDMn//jQEYuHIdsWAUHpMoO+2RtTDTLQziH7lGKQpvEGby6KYnoPMmNSIIqMrQDfmBl9cd68Jzl9GFvQfQlySDWFGJjXTT263yv6OiNArbL9Cu6qLj8kkfCKPA2Qtcc4GijluY4ke9KO67qUlIvmjbkar6foRDgftkI+MdrHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72FE12FC;
	Wed, 13 Aug 2025 05:20:36 -0700 (PDT)
Received: from [10.13.87.1] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC1B3F5A1;
	Wed, 13 Aug 2025 05:20:43 -0700 (PDT)
Message-ID: <83b69ebb-a052-482e-aa6d-34194ef18dc3@arm.com>
Date: Wed, 13 Aug 2025 13:20:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 096/369] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Sasha Levin <sashal@kernel.org>
References: <20250812173014.736537091@linuxfoundation.org>
 <20250812173018.391927854@linuxfoundation.org>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20250812173018.391927854@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

IIRC, there was a small bug with this which Peter already fixed

https://lkml.kernel.org/r/20250716104050.GR1613200@noisy.programming.kicks-ass.net

but I'm not sure whether this fix 'sched/psi: Fix psi_seq
initialization' is already available for pulling?

-- Dietmar

On 12.08.25 18:26, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Peter Zijlstra <peterz@infradead.org>
> 
> [ Upstream commit 570c8efd5eb79c3725ba439ce105ed1bedc5acd9 ]
> 
> Dietmar reported that commit 3840cbe24cf0 ("sched: psi: fix bogus
> pressure spikes from aggregation race") caused a regression for him on
> a high context switch rate benchmark (schbench) due to the now
> repeating cpu_clock() calls.
> 
> In particular the problem is that get_recent_times() will extrapolate
> the current state to 'now'. But if an update uses a timestamp from
> before the start of the update, it is possible to get two reads
> with inconsistent results. It is effectively back-dating an update.
> 
> (note that this all hard-relies on the clock being synchronized across
> CPUs -- if this is not the case, all bets are off).
> 
> Combine this problem with the fact that there are per-group-per-cpu
> seqcounts, the commit in question pushed the clock read into the group
> iteration, causing tree-depth cpu_clock() calls. On architectures
> where cpu_clock() has appreciable overhead, this hurts.
> 
> Instead move to a per-cpu seqcount, which allows us to have a single
> clock read for all group updates, increasing internal consistency and
> lowering update overhead. This comes at the cost of a longer update
> side (proportional to the tree depth) which can cause the read side to
> retry more often.
> 
> Fixes: 3840cbe24cf0 ("sched: psi: fix bogus pressure spikes from aggregation race")
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>,
> Link: https://lkml.kernel.org/20250522084844.GC31726@noisy.programming.kicks-ass.net
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/psi_types.h |   6 +-
>  kernel/sched/psi.c        | 121 +++++++++++++++++++++-----------------
>  2 files changed, 68 insertions(+), 59 deletions(-)
> 
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index f1fd3a8044e0..dd10c22299ab 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -84,11 +84,9 @@ enum psi_aggregators {
>  struct psi_group_cpu {
>  	/* 1st cacheline updated by the scheduler */
>  
> -	/* Aggregator needs to know of concurrent changes */
> -	seqcount_t seq ____cacheline_aligned_in_smp;
> -
>  	/* States of the tasks belonging to this group */
> -	unsigned int tasks[NR_PSI_TASK_COUNTS];
> +	unsigned int tasks[NR_PSI_TASK_COUNTS]
> +			____cacheline_aligned_in_smp;
>  
>  	/* Aggregate pressure state derived from the tasks */
>  	u32 state_mask;
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 84dad1511d1e..81cfefc4d892 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -172,6 +172,28 @@ struct psi_group psi_system = {
>  	.pcpu = &system_group_pcpu,
>  };
>  
> +static DEFINE_PER_CPU(seqcount_t, psi_seq);
> +
> +static inline void psi_write_begin(int cpu)
> +{
> +	write_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));
> +}
> +
> +static inline void psi_write_end(int cpu)
> +{
> +	write_seqcount_end(per_cpu_ptr(&psi_seq, cpu));
> +}
> +
> +static inline u32 psi_read_begin(int cpu)
> +{
> +	return read_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));
> +}
> +
> +static inline bool psi_read_retry(int cpu, u32 seq)
> +{
> +	return read_seqcount_retry(per_cpu_ptr(&psi_seq, cpu), seq);
> +}
> +
>  static void psi_avgs_work(struct work_struct *work);
>  
>  static void poll_timer_fn(struct timer_list *t);
> @@ -182,7 +204,7 @@ static void group_init(struct psi_group *group)
>  
>  	group->enabled = true;
>  	for_each_possible_cpu(cpu)
> -		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
> +		seqcount_init(per_cpu_ptr(&psi_seq, cpu));
>  	group->avg_last_update = sched_clock();
>  	group->avg_next_update = group->avg_last_update + psi_period;
>  	mutex_init(&group->avgs_lock);
> @@ -262,14 +284,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
>  
>  	/* Snapshot a coherent view of the CPU state */
>  	do {
> -		seq = read_seqcount_begin(&groupc->seq);
> +		seq = psi_read_begin(cpu);
>  		now = cpu_clock(cpu);
>  		memcpy(times, groupc->times, sizeof(groupc->times));
>  		state_mask = groupc->state_mask;
>  		state_start = groupc->state_start;
>  		if (cpu == current_cpu)
>  			memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
> -	} while (read_seqcount_retry(&groupc->seq, seq));
> +	} while (psi_read_retry(cpu, seq));
>  
>  	/* Calculate state time deltas against the previous snapshot */
>  	for (s = 0; s < NR_PSI_STATES; s++) {
> @@ -768,30 +790,20 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
>  		groupc->times[PSI_NONIDLE] += delta;
>  }
>  
> +#define for_each_group(iter, group) \
> +	for (typeof(group) iter = group; iter; iter = iter->parent)
> +
>  static void psi_group_change(struct psi_group *group, int cpu,
>  			     unsigned int clear, unsigned int set,
> -			     bool wake_clock)
> +			     u64 now, bool wake_clock)
>  {
>  	struct psi_group_cpu *groupc;
>  	unsigned int t, m;
>  	u32 state_mask;
> -	u64 now;
>  
>  	lockdep_assert_rq_held(cpu_rq(cpu));
>  	groupc = per_cpu_ptr(group->pcpu, cpu);
>  
> -	/*
> -	 * First we update the task counts according to the state
> -	 * change requested through the @clear and @set bits.
> -	 *
> -	 * Then if the cgroup PSI stats accounting enabled, we
> -	 * assess the aggregate resource states this CPU's tasks
> -	 * have been in since the last change, and account any
> -	 * SOME and FULL time these may have resulted in.
> -	 */
> -	write_seqcount_begin(&groupc->seq);
> -	now = cpu_clock(cpu);
> -
>  	/*
>  	 * Start with TSK_ONCPU, which doesn't have a corresponding
>  	 * task count - it's just a boolean flag directly encoded in
> @@ -843,7 +855,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  
>  		groupc->state_mask = state_mask;
>  
> -		write_seqcount_end(&groupc->seq);
>  		return;
>  	}
>  
> @@ -864,8 +875,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  
>  	groupc->state_mask = state_mask;
>  
> -	write_seqcount_end(&groupc->seq);
> -
>  	if (state_mask & group->rtpoll_states)
>  		psi_schedule_rtpoll_work(group, 1, false);
>  
> @@ -900,24 +909,29 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
>  void psi_task_change(struct task_struct *task, int clear, int set)
>  {
>  	int cpu = task_cpu(task);
> -	struct psi_group *group;
> +	u64 now;
>  
>  	if (!task->pid)
>  		return;
>  
>  	psi_flags_change(task, clear, set);
>  
> -	group = task_psi_group(task);
> -	do {
> -		psi_group_change(group, cpu, clear, set, true);
> -	} while ((group = group->parent));
> +	psi_write_begin(cpu);
> +	now = cpu_clock(cpu);
> +	for_each_group(group, task_psi_group(task))
> +		psi_group_change(group, cpu, clear, set, now, true);
> +	psi_write_end(cpu);
>  }
>  
>  void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		     bool sleep)
>  {
> -	struct psi_group *group, *common = NULL;
> +	struct psi_group *common = NULL;
>  	int cpu = task_cpu(prev);
> +	u64 now;
> +
> +	psi_write_begin(cpu);
> +	now = cpu_clock(cpu);
>  
>  	if (next->pid) {
>  		psi_flags_change(next, 0, TSK_ONCPU);
> @@ -926,16 +940,15 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 * ancestors with @prev, those will already have @prev's
>  		 * TSK_ONCPU bit set, and we can stop the iteration there.
>  		 */
> -		group = task_psi_group(next);
> -		do {
> -			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
> -			    PSI_ONCPU) {
> +		for_each_group(group, task_psi_group(next)) {
> +			struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> +
> +			if (groupc->state_mask & PSI_ONCPU) {
>  				common = group;
>  				break;
>  			}
> -
> -			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
> -		} while ((group = group->parent));
> +			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
> +		}
>  	}
>  
>  	if (prev->pid) {
> @@ -968,12 +981,11 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  
>  		psi_flags_change(prev, clear, set);
>  
> -		group = task_psi_group(prev);
> -		do {
> +		for_each_group(group, task_psi_group(prev)) {
>  			if (group == common)
>  				break;
> -			psi_group_change(group, cpu, clear, set, wake_clock);
> -		} while ((group = group->parent));
> +			psi_group_change(group, cpu, clear, set, now, wake_clock);
> +		}
>  
>  		/*
>  		 * TSK_ONCPU is handled up to the common ancestor. If there are
> @@ -983,20 +995,21 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 */
>  		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
>  			clear &= ~TSK_ONCPU;
> -			for (; group; group = group->parent)
> -				psi_group_change(group, cpu, clear, set, wake_clock);
> +			for_each_group(group, common)
> +				psi_group_change(group, cpu, clear, set, now, wake_clock);
>  		}
>  	}
> +	psi_write_end(cpu);
>  }
>  
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>  void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
>  {
>  	int cpu = task_cpu(curr);
> -	struct psi_group *group;
>  	struct psi_group_cpu *groupc;
>  	s64 delta;
>  	u64 irq;
> +	u64 now;
>  
>  	if (static_branch_likely(&psi_disabled))
>  		return;
> @@ -1005,8 +1018,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
>  		return;
>  
>  	lockdep_assert_rq_held(rq);
> -	group = task_psi_group(curr);
> -	if (prev && task_psi_group(prev) == group)
> +	if (prev && task_psi_group(prev) == task_psi_group(curr))
>  		return;
>  
>  	irq = irq_time_read(cpu);
> @@ -1015,25 +1027,22 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
>  		return;
>  	rq->psi_irq_time = irq;
>  
> -	do {
> -		u64 now;
> +	psi_write_begin(cpu);
> +	now = cpu_clock(cpu);
>  
> +	for_each_group(group, task_psi_group(curr)) {
>  		if (!group->enabled)
>  			continue;
>  
>  		groupc = per_cpu_ptr(group->pcpu, cpu);
>  
> -		write_seqcount_begin(&groupc->seq);
> -		now = cpu_clock(cpu);
> -
>  		record_times(groupc, now);
>  		groupc->times[PSI_IRQ_FULL] += delta;
>  
> -		write_seqcount_end(&groupc->seq);
> -
>  		if (group->rtpoll_states & (1 << PSI_IRQ_FULL))
>  			psi_schedule_rtpoll_work(group, 1, false);
> -	} while ((group = group->parent));
> +	}
> +	psi_write_end(cpu);
>  }
>  #endif
>  
> @@ -1221,12 +1230,14 @@ void psi_cgroup_restart(struct psi_group *group)
>  		return;
>  
>  	for_each_possible_cpu(cpu) {
> -		struct rq *rq = cpu_rq(cpu);
> -		struct rq_flags rf;
> +		u64 now;
>  
> -		rq_lock_irq(rq, &rf);
> -		psi_group_change(group, cpu, 0, 0, true);
> -		rq_unlock_irq(rq, &rf);
> +		guard(rq_lock_irq)(cpu_rq(cpu));
> +
> +		psi_write_begin(cpu);
> +		now = cpu_clock(cpu);
> +		psi_group_change(group, cpu, 0, 0, now, true);
> +		psi_write_end(cpu);
>  	}
>  }
>  #endif /* CONFIG_CGROUPS */


