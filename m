Return-Path: <stable+bounces-19487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D59851EEF
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 21:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CCAB20B73
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF5481B4;
	Mon, 12 Feb 2024 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my3XTC7j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA647773;
	Mon, 12 Feb 2024 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771257; cv=none; b=lA0nmDDLk83NTTS18cWA7AqcHyuqJB89KZnAN6RrUjhXh1k/OAodhua9l8rSjZVLUmSGTEXZ3b+b5ZaqlpL34rFGTQcT0ZT7GWhVGpT9zb6+2Vpu6GncmiQZIOmLIvXZDEJPlcqm+F1e6vNC37AKF9//MLgP58RY6Co90p4Hk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771257; c=relaxed/simple;
	bh=e0Y2K+OeOPboQwWu5APzMxeIa3Yk8X5guW2Gc3Ynh/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY0qoucegSc5SGD+dgFjROMSX8IuVPNo71F0xQGKVAIjcreRjpJmN4rMovhzAGU8jmGlJqQ8pbiMYZ50RTDzRYhs2EeoG/CVLTNbTYMj+JS8YXCnMaK+sEPNLdT9ofg2qRSCxQSF/n11srv4DNuIXGajPsxL01womw7eSAPTk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my3XTC7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A51C433F1;
	Mon, 12 Feb 2024 20:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707771256;
	bh=e0Y2K+OeOPboQwWu5APzMxeIa3Yk8X5guW2Gc3Ynh/o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=my3XTC7jclLSgldFl4v19FtloHXvkGzrgehyjlVP9k4ycoxijfIUqZKq5ByQVTYnx
	 lxobzJeaOdGshLjbUnjKD58OLIqK3WXjRGJUCDO2HBrasP1BViaXOGWkJFKMLMQznd
	 5D+gk3MR6o+XILyA4mEdudLt20+fX/WKBvmW45KyaWiZa0manokfgQ97+uOFXo8zvQ
	 v/e3Sp3az5I3ksdQY8hZhwuak0KenVjkc1WOuHNuSXuMV7vERo+rcLLzo9Bjc+lOmu
	 NkLsU3k9UMwIphZfAMg/sBhckPsNU/8Id4ShUYUgdZ2a/56B8j4+o0OajB65Ub94Cr
	 CScNzqs5NyA1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9761FCE0DEC; Mon, 12 Feb 2024 12:54:16 -0800 (PST)
Date: Mon, 12 Feb 2024 12:54:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: joel@joelfernandes.org, gregkh@linuxfoundation.org,
	chenzhongjin@huawei.com, rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] linux-5.10/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
Message-ID: <998c99e5-555d-47ec-876d-f6fe52aa4eaf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240207110951.27831-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207110951.27831-1-qiang.zhang1211@gmail.com>

On Wed, Feb 07, 2024 at 07:09:51PM +0800, Zqiang wrote:
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

And this one also looks good, though it would also be good to get other
eyes on it.

And again, thank you for putting this together!

							Thanx, Paul

> ---
>  include/linux/sched.h |  1 +
>  init/init_task.c      |  1 +
>  kernel/fork.c         |  1 +
>  kernel/rcu/tasks.h    | 54 ++++++++++++++++++++++++++++---------------
>  4 files changed, 39 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index aa015416c569..80499f7ab39a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -740,6 +740,7 @@ struct task_struct {
>  	u8				rcu_tasks_idx;
>  	int				rcu_tasks_idle_cpu;
>  	struct list_head		rcu_tasks_holdout_list;
> +	struct list_head                rcu_tasks_exit_list;
>  #endif /* #ifdef CONFIG_TASKS_RCU */
>  
>  #ifdef CONFIG_TASKS_TRACE_RCU
> diff --git a/init/init_task.c b/init/init_task.c
> index 5fa18ed59d33..59454d6e2c2a 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -151,6 +151,7 @@ struct task_struct init_task
>  	.rcu_tasks_holdout = false,
>  	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
>  	.rcu_tasks_idle_cpu = -1,
> +	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
>  #endif
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	.trc_reader_nesting = 0,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 633b0af1d1a7..86803165aa00 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1699,6 +1699,7 @@ static inline void rcu_copy_process(struct task_struct *p)
>  	p->rcu_tasks_holdout = false;
>  	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
>  	p->rcu_tasks_idle_cpu = -1;
> +	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
>  #endif /* #ifdef CONFIG_TASKS_RCU */
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	p->trc_reader_nesting = 0;
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index c5624ab0580c..901cd7bc78ed 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -81,9 +81,6 @@ static struct rcu_tasks rt_name =					\
>  	.kname = #rt_name,						\
>  }
>  
> -/* Track exiting tasks in order to allow them to be waited for. */
> -DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
> -
>  /* Avoid IPIing CPUs early in the grace period. */
>  #define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
>  static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
> @@ -383,6 +380,9 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>  // rates from multiple CPUs.  If this is required, per-CPU callback lists
>  // will be needed.
>  
> +static LIST_HEAD(rtp_exit_list);
> +static DEFINE_RAW_SPINLOCK(rtp_exit_list_lock);
> +
>  /* Pre-grace-period preparation. */
>  static void rcu_tasks_pregp_step(void)
>  {
> @@ -416,15 +416,18 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
>  /* Processing between scanning taskslist and draining the holdout list. */
>  static void rcu_tasks_postscan(struct list_head *hop)
>  {
> +	unsigned long flags;
> +	struct task_struct *t;
> +
>  	/*
>  	 * Exiting tasks may escape the tasklist scan. Those are vulnerable
>  	 * until their final schedule() with TASK_DEAD state. To cope with
>  	 * this, divide the fragile exit path part in two intersecting
>  	 * read side critical sections:
>  	 *
> -	 * 1) An _SRCU_ read side starting before calling exit_notify(),
> -	 *    which may remove the task from the tasklist, and ending after
> -	 *    the final preempt_disable() call in do_exit().
> +	 * 1) A task_struct list addition before calling exit_notify(),
> +	 *    which may remove the task from the tasklist, with the
> +	 *    removal after the final preempt_disable() call in do_exit().
>  	 *
>  	 * 2) An _RCU_ read side starting with the final preempt_disable()
>  	 *    call in do_exit() and ending with the final call to schedule()
> @@ -433,7 +436,12 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  	 * This handles the part 1). And postgp will handle part 2) with a
>  	 * call to synchronize_rcu().
>  	 */
> -	synchronize_srcu(&tasks_rcu_exit_srcu);
> +	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
> +	list_for_each_entry(t, &rtp_exit_list, rcu_tasks_exit_list) {
> +		if (list_empty(&t->rcu_tasks_holdout_list))
> +			rcu_tasks_pertask(t, hop);
> +	}
> +	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
>  }
>  
>  /* See if tasks are still holding out, complain if so. */
> @@ -498,7 +506,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
>  	 *
>  	 * In addition, this synchronize_rcu() waits for exiting tasks
>  	 * to complete their final preempt_disable() region of execution,
> -	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
>  	 * enforcing the whole region before tasklist removal until
>  	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
>  	 * read side critical section.
> @@ -591,25 +598,36 @@ static void show_rcu_tasks_classic_gp_kthread(void)
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
>  /*
> - * Contribute to protect against tasklist scan blind spot while the
> - * task is exiting and may be removed from the tasklist. See
> - * corresponding synchronize_srcu() for further details.
> + * Protect against tasklist scan blind spot while the task is exiting and
> + * may be removed from the tasklist.  Do this by adding the task to yet
> + * another list.
>   */
> -void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> +void exit_tasks_rcu_start(void)
>  {
> -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> +	unsigned long flags;
> +	struct task_struct *t = current;
> +
> +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> +	get_task_struct(t);
> +	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
> +	list_add(&t->rcu_tasks_exit_list, &rtp_exit_list);
> +	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
>  }
>  
>  /*
> - * Contribute to protect against tasklist scan blind spot while the
> - * task is exiting and may be removed from the tasklist. See
> - * corresponding synchronize_srcu() for further details.
> + * Remove the task from the "yet another list" because do_exit() is now
> + * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
>   */
> -void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
> +void exit_tasks_rcu_stop(void)
>  {
> +	unsigned long flags;
>  	struct task_struct *t = current;
>  
> -	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
> +	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
> +	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
> +	list_del_init(&t->rcu_tasks_exit_list);
> +	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
> +	put_task_struct(t);
>  }
>  
>  /*
> -- 
> 2.17.1
> 

