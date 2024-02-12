Return-Path: <stable+bounces-19486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B745851EEE
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 21:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2167A283B05
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 20:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DA9487A7;
	Mon, 12 Feb 2024 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT6Tq+GH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A19481D7;
	Mon, 12 Feb 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771208; cv=none; b=Y+qG+0TGT/4bcP3lD3jztfwo618jtxL6vHlZAmccFiBn2u1mWjTq92yZkJM90MtWVCfSfdKGb37zi7xzW3dr/Aot1WcLHVJSrPnsLgTs014821ktrCfUBKB5npSu8YmWiIKsRNwK7wfwwD8FbgNewjUa7yogyUF/P4FlMs1T+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771208; c=relaxed/simple;
	bh=BPg19Mwdf8b2z2juUF//qE5eiYikuu1R6wMSYPuE/zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEb4d3rjCC/a4i7NqSUSedXEMvb18w+LqrzNRgp8tSEL684kwtPTXeTfL6bqu5IoDO6Fy4VL5OaYIU5GeN39sJj8bWzFnZCpXDnNV4p34gV2AVcYHBKb2BGPI5nawd52ZFyhAuuDsPESTwCH9wBIpN36NtA5lCs//l88PmODGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT6Tq+GH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDFDC433F1;
	Mon, 12 Feb 2024 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707771208;
	bh=BPg19Mwdf8b2z2juUF//qE5eiYikuu1R6wMSYPuE/zw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GT6Tq+GHvj6TBbeHjtkWzhAfu4YcU94yNqhZIz2zwCJ6YQKWL4cL/WoKPzbvGg42/
	 XYqir6GFyfxeq+nHJPJF5bsld3JsDfu1S+JRwEjprvGPBwgnHoV6qfjtVjoMJSaARG
	 YP1mgNKPYG7u/dnqC67oUZO8ABn2u9rP7eCmKh5asa7E467hwi8DAh+9Qu2ybc7BxA
	 IusG8nPcMeImb16ws4YxT039FNWWsUJHiETw01IJIVVJx+Rh8DIlSzcZyoT98dynv5
	 ZqOeR9g2xD88j6FjZ3GFi6i0AwhAiljr29kFcKGXT+LdMrLpEQgZdfLl3L7xx/wf/U
	 Wz2ZvH+5q3nNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D58E7CE0DEC; Mon, 12 Feb 2024 12:53:27 -0800 (PST)
Date: Mon, 12 Feb 2024 12:53:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: joel@joelfernandes.org, gregkh@linuxfoundation.org,
	chenzhongjin@huawei.com, rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] linux-4.19/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
Message-ID: <292d4bdd-2af5-4e9d-884b-3e07725669f9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240207110846.25168-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207110846.25168-1-qiang.zhang1211@gmail.com>

On Wed, Feb 07, 2024 at 07:08:46PM +0800, Zqiang wrote:
> From: Paul E. McKenney <paulmck@kernel.org>
> 
> commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.
> 
> Holding a mutex across synchronize_rcu_tasks() and acquiring
> that same mutex in code called from do_exit() after its call to
> exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> results in deadlock.  This is by design, because tasks that are far
> enough into do_exit() are no longer present on the tasks list, making
> it a bit difficult for RCU Tasks to find them, let alone wait on them
> to do a voluntary context switch.  However, such deadlocks are becoming
> more frequent.  In addition, lockdep currently does not detect such
> deadlocks and they can be difficult to reproduce.
> 
> In addition, if a task voluntarily context switches during that time
> (for example, if it blocks acquiring a mutex), then this task is in an
> RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> just as well take advantage of that fact.
> 
> This commit therefore eliminates these deadlock by replacing the
> SRCU-based wait for do_exit() completion with per-CPU lists of tasks
> currently exiting.  A given task will be on one of these per-CPU lists for
> the same period of time that this task would previously have been in the
> previous SRCU read-side critical section.  These lists enable RCU Tasks
> to find the tasks that have already been removed from the tasks list,
> but that must nevertheless be waited upon.
> 
> The RCU Tasks grace period gathers any of these do_exit() tasks that it
> must wait on, and adds them to the list of holdouts.  Per-CPU locking
> and get_task_struct() are used to synchronize addition to and removal
> from these lists.
> 
> Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> 
> Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

This looks good to me, though it would be good to get other eyes on it.

Thank you for putting this together!!!

							Thanx, Paul

> ---
>  include/linux/sched.h |  1 +
>  init/init_task.c      |  1 +
>  kernel/fork.c         |  1 +
>  kernel/rcu/update.c   | 65 ++++++++++++++++++++++++++++++-------------
>  4 files changed, 49 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index fd4899236037..0b555d8e9d5e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -679,6 +679,7 @@ struct task_struct {
>  	u8				rcu_tasks_idx;
>  	int				rcu_tasks_idle_cpu;
>  	struct list_head		rcu_tasks_holdout_list;
> +	struct list_head                rcu_tasks_exit_list;
>  #endif /* #ifdef CONFIG_TASKS_RCU */
>  
>  	struct sched_info		sched_info;
> diff --git a/init/init_task.c b/init/init_task.c
> index 994ffe018120..f741cbfd891c 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -139,6 +139,7 @@ struct task_struct init_task
>  	.rcu_tasks_holdout = false,
>  	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
>  	.rcu_tasks_idle_cpu = -1,
> +	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
>  #endif
>  #ifdef CONFIG_CPUSETS
>  	.mems_allowed_seq = SEQCNT_ZERO(init_task.mems_allowed_seq),
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b65871600507..d416d16df62f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1626,6 +1626,7 @@ static inline void rcu_copy_process(struct task_struct *p)
>  	p->rcu_tasks_holdout = false;
>  	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
>  	p->rcu_tasks_idle_cpu = -1;
> +	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
>  #endif /* #ifdef CONFIG_TASKS_RCU */
>  }
>  
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 81688a133552..5227cb5c1bea 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -527,7 +527,8 @@ static DECLARE_WAIT_QUEUE_HEAD(rcu_tasks_cbs_wq);
>  static DEFINE_RAW_SPINLOCK(rcu_tasks_cbs_lock);
>  
>  /* Track exiting tasks in order to allow them to be waited for. */
> -DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
> +static LIST_HEAD(rtp_exit_list);
> +static DEFINE_RAW_SPINLOCK(rtp_exit_list_lock);
>  
>  /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
>  #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
> @@ -661,6 +662,17 @@ static void check_holdout_task(struct task_struct *t,
>  	sched_show_task(t);
>  }
>  
> +static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
> +{
> +	if (t != current && READ_ONCE(t->on_rq) &&
> +			!is_idle_task(t)) {
> +		get_task_struct(t);
> +		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
> +		WRITE_ONCE(t->rcu_tasks_holdout, true);
> +		list_add(&t->rcu_tasks_holdout_list, hop);
> +	}
> +}
> +
>  /* RCU-tasks kthread that detects grace periods and invokes callbacks. */
>  static int __noreturn rcu_tasks_kthread(void *arg)
>  {
> @@ -726,14 +738,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  		 */
>  		rcu_read_lock();
>  		for_each_process_thread(g, t) {
> -			if (t != current && READ_ONCE(t->on_rq) &&
> -			    !is_idle_task(t)) {
> -				get_task_struct(t);
> -				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
> -				WRITE_ONCE(t->rcu_tasks_holdout, true);
> -				list_add(&t->rcu_tasks_holdout_list,
> -					 &rcu_tasks_holdouts);
> -			}
> +			rcu_tasks_pertask(t, &rcu_tasks_holdouts);
>  		}
>  		rcu_read_unlock();
>  
> @@ -744,8 +749,12 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  		 * where they have disabled preemption, allowing the
>  		 * later synchronize_sched() to finish the job.
>  		 */
> -		synchronize_srcu(&tasks_rcu_exit_srcu);
> -
> +		raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
> +		list_for_each_entry(t, &rtp_exit_list, rcu_tasks_exit_list) {
> +			if (list_empty(&t->rcu_tasks_holdout_list))
> +				rcu_tasks_pertask(t, &rcu_tasks_holdouts);
> +		}
> +		raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
>  		/*
>  		 * Each pass through the following loop scans the list
>  		 * of holdout tasks, removing any that are no longer
> @@ -802,8 +811,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  		 *
>  		 * In addition, this synchronize_sched() waits for exiting
>  		 * tasks to complete their final preempt_disable() region
> -		 * of execution, cleaning up after the synchronize_srcu()
> -		 * above.
> +		 * of execution.
>  		 */
>  		synchronize_sched();
>  
> @@ -834,20 +842,39 @@ static int __init rcu_spawn_tasks_kthread(void)
>  }
>  core_initcall(rcu_spawn_tasks_kthread);
>  
> -/* Do the srcu_read_lock() for the above synchronize_srcu().  */
> +/*
> + * Protect against tasklist scan blind spot while the task is exiting and
> + * may be removed from the tasklist.  Do this by adding the task to yet
> + * another list.
> + */
>  void exit_tasks_rcu_start(void)
>  {
> +	unsigned long flags;
> +	struct task_struct *t = current;
> +
> +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> +	get_task_struct(t);
>  	preempt_disable();
> -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> +	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
> +	list_add(&t->rcu_tasks_exit_list, &rtp_exit_list);
> +	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
>  	preempt_enable();
>  }
>  
> -/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
> +/*
> + * Remove the task from the "yet another list" because do_exit() is now
> + * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
> + */
>  void exit_tasks_rcu_finish(void)
>  {
> -	preempt_disable();
> -	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
> -	preempt_enable();
> +	unsigned long flags;
> +	struct task_struct *t = current;
> +
> +	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
> +	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
> +	list_del_init(&t->rcu_tasks_exit_list);
> +	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
> +	put_task_struct(t);
>  }
>  
>  #endif /* #ifdef CONFIG_TASKS_RCU */
> -- 
> 2.17.1
> 

