Return-Path: <stable+bounces-126790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D712BA71E75
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4053B50E8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882424E4A8;
	Wed, 26 Mar 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEn7x7Lr"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFE23FC54
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013900; cv=none; b=ETLZwY4Y5GWHO3vhZWlmUifMEJK3WTEFlz8dGQTD57GcUjZpbdEPE92cH8uRP4Gfntbv8tB6xA/55whBzbjZoHTCu9XTCQwoLI9W/xrWdyPZjCAJ26v3DlhYxWNSAqyXJq50za6qcThXzFZoXA6sXuiLNXU6jOd+Mh91+lEkj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013900; c=relaxed/simple;
	bh=VsK0ddeJ9pvWZ7KFeSEXzRUPGXIelDWOW6U/cYOQgtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPc8+w9Xq51dcelN+yoz8ietMynLe6MOIp7QfCXYDuTYlrZKGGnFUcXOoANf/IiSa9YtLFflUzUbBAlblF6/fcTE9jw5u6hehxZckP/GPzKqEO0zHe9vnAc+zDIAJGvXtQ3Fm4hfqw2PtHxAdBBApbqDB+fonaf9trCUq+DQU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEn7x7Lr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743013897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LowBcEFTOEEk/IhHxLnkbrOpsn7WWh7u6VMFdXO813Y=;
	b=IEn7x7Lr94gAXjN1cWMOyOm098oEqxUVAUJKMyB9lqK/0BwgUEDSEsW9h7cImwPgqk0eyJ
	v/pzmODl6C0FMQY7KXQ3R6dPJHobwzWFdDr0KRVWfZ0JD6oc/vPIdnBXuXySluCnQ49Zev
	BpQDqsJwQWxeiUhWgQ17lM2iPddS4Cg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-eUq-YYDUMceBXdQfFXJNzQ-1; Wed,
 26 Mar 2025 14:31:33 -0400
X-MC-Unique: eUq-YYDUMceBXdQfFXJNzQ-1
X-Mimecast-MFC-AGG-ID: eUq-YYDUMceBXdQfFXJNzQ_1743013891
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B99B2196D2DE;
	Wed, 26 Mar 2025 18:31:31 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.17.16.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54DEA1955D81;
	Wed, 26 Mar 2025 18:31:28 +0000 (UTC)
Date: Wed, 26 Mar 2025 14:31:26 -0400
From: Phil Auld <pauld@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Message-ID: <20250326183126.GA16697@lorien.usersys.redhat.com>
References: <20250225180553.167995-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225180553.167995-1-harshit@nutanix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Feb 25, 2025 at 06:05:53PM +0000 Harshit Agarwal wrote:
> Overview
> ========
> When a CPU chooses to call push_rt_task and picks a task to push to
> another CPU's runqueue then it will call find_lock_lowest_rq method
> which would take a double lock on both CPUs' runqueues. If one of the
> locks aren't readily available, it may lead to dropping the current
> runqueue lock and reacquiring both the locks at once. During this window
> it is possible that the task is already migrated and is running on some
> other CPU. These cases are already handled. However, if the task is
> migrated and has already been executed and another CPU is now trying to
> wake it up (ttwu) such that it is queued again on the runqeue
> (on_rq is 1) and also if the task was run by the same CPU, then the
> current checks will pass even though the task was migrated out and is no
> longer in the pushable tasks list.
> 
> Crashes
> =======
> This bug resulted in quite a few flavors of crashes triggering kernel
> panics with various crash signatures such as assert failures, page
> faults, null pointer dereferences, and queue corruption errors all
> coming from scheduler itself.
> 
> Some of the crashes:
> -> kernel BUG at kernel/sched/rt.c:1616! BUG_ON(idx >= MAX_RT_PRIO)
>    Call Trace:
>    ? __die_body+0x1a/0x60
>    ? die+0x2a/0x50
>    ? do_trap+0x85/0x100
>    ? pick_next_task_rt+0x6e/0x1d0
>    ? do_error_trap+0x64/0xa0
>    ? pick_next_task_rt+0x6e/0x1d0
>    ? exc_invalid_op+0x4c/0x60
>    ? pick_next_task_rt+0x6e/0x1d0
>    ? asm_exc_invalid_op+0x12/0x20
>    ? pick_next_task_rt+0x6e/0x1d0
>    __schedule+0x5cb/0x790
>    ? update_ts_time_stats+0x55/0x70
>    schedule_idle+0x1e/0x40
>    do_idle+0x15e/0x200
>    cpu_startup_entry+0x19/0x20
>    start_secondary+0x117/0x160
>    secondary_startup_64_no_verify+0xb0/0xbb
> 
> -> BUG: kernel NULL pointer dereference, address: 00000000000000c0
>    Call Trace:
>    ? __die_body+0x1a/0x60
>    ? no_context+0x183/0x350
>    ? __warn+0x8a/0xe0
>    ? exc_page_fault+0x3d6/0x520
>    ? asm_exc_page_fault+0x1e/0x30
>    ? pick_next_task_rt+0xb5/0x1d0
>    ? pick_next_task_rt+0x8c/0x1d0
>    __schedule+0x583/0x7e0
>    ? update_ts_time_stats+0x55/0x70
>    schedule_idle+0x1e/0x40
>    do_idle+0x15e/0x200
>    cpu_startup_entry+0x19/0x20
>    start_secondary+0x117/0x160
>    secondary_startup_64_no_verify+0xb0/0xbb
> 
> -> BUG: unable to handle page fault for address: ffff9464daea5900
>    kernel BUG at kernel/sched/rt.c:1861! BUG_ON(rq->cpu != task_cpu(p))
> 
> -> kernel BUG at kernel/sched/rt.c:1055! BUG_ON(!rq->nr_running)
>    Call Trace:
>    ? __die_body+0x1a/0x60
>    ? die+0x2a/0x50
>    ? do_trap+0x85/0x100
>    ? dequeue_top_rt_rq+0xa2/0xb0
>    ? do_error_trap+0x64/0xa0
>    ? dequeue_top_rt_rq+0xa2/0xb0
>    ? exc_invalid_op+0x4c/0x60
>    ? dequeue_top_rt_rq+0xa2/0xb0
>    ? asm_exc_invalid_op+0x12/0x20
>    ? dequeue_top_rt_rq+0xa2/0xb0
>    dequeue_rt_entity+0x1f/0x70
>    dequeue_task_rt+0x2d/0x70
>    __schedule+0x1a8/0x7e0
>    ? blk_finish_plug+0x25/0x40
>    schedule+0x3c/0xb0
>    futex_wait_queue_me+0xb6/0x120
>    futex_wait+0xd9/0x240
>    do_futex+0x344/0xa90
>    ? get_mm_exe_file+0x30/0x60
>    ? audit_exe_compare+0x58/0x70
>    ? audit_filter_rules.constprop.26+0x65e/0x1220
>    __x64_sys_futex+0x148/0x1f0
>    do_syscall_64+0x30/0x80
>    entry_SYSCALL_64_after_hwframe+0x62/0xc7
> 
> -> BUG: unable to handle page fault for address: ffff8cf3608bc2c0
>    Call Trace:
>    ? __die_body+0x1a/0x60
>    ? no_context+0x183/0x350
>    ? spurious_kernel_fault+0x171/0x1c0
>    ? exc_page_fault+0x3b6/0x520
>    ? plist_check_list+0x15/0x40
>    ? plist_check_list+0x2e/0x40
>    ? asm_exc_page_fault+0x1e/0x30
>    ? _cond_resched+0x15/0x30
>    ? futex_wait_queue_me+0xc8/0x120
>    ? futex_wait+0xd9/0x240
>    ? try_to_wake_up+0x1b8/0x490
>    ? futex_wake+0x78/0x160
>    ? do_futex+0xcd/0xa90
>    ? plist_check_list+0x15/0x40
>    ? plist_check_list+0x2e/0x40
>    ? plist_del+0x6a/0xd0
>    ? plist_check_list+0x15/0x40
>    ? plist_check_list+0x2e/0x40
>    ? dequeue_pushable_task+0x20/0x70
>    ? __schedule+0x382/0x7e0
>    ? asm_sysvec_reschedule_ipi+0xa/0x20
>    ? schedule+0x3c/0xb0
>    ? exit_to_user_mode_prepare+0x9e/0x150
>    ? irqentry_exit_to_user_mode+0x5/0x30
>    ? asm_sysvec_reschedule_ipi+0x12/0x20
> 
> Above are some of the common examples of the crashes that were observed
> due to this issue.
> 
> Details
> =======
> Let's look at the following scenario to understand this race.
> 
> 1) CPU A enters push_rt_task
>   a) CPU A has chosen next_task = task p.
>   b) CPU A calls find_lock_lowest_rq(Task p, CPU Z’s rq).
>   c) CPU A identifies CPU X as a destination CPU (X < Z).
>   d) CPU A enters double_lock_balance(CPU Z’s rq, CPU X’s rq).
>   e) Since X is lower than Z, CPU A unlocks CPU Z’s rq. Someone else has
>      locked CPU X’s rq, and thus, CPU A must wait.
> 
> 2) At CPU Z
>   a) Previous task has completed execution and thus, CPU Z enters
>      schedule, locks its own rq after CPU A releases it.
>   b) CPU Z dequeues previous task and begins executing task p.
>   c) CPU Z unlocks its rq.
>   d) Task p yields the CPU (ex. by doing IO or waiting to acquire a
>      lock) which triggers the schedule function on CPU Z.
>   e) CPU Z enters schedule again, locks its own rq, and dequeues task p.
>   f) As part of dequeue, it sets p.on_rq = 0 and unlocks its rq.
> 
> 3) At CPU B
>   a) CPU B enters try_to_wake_up with input task p.
>   b) Since CPU Z dequeued task p, p.on_rq = 0, and CPU B updates
>      B.state = WAKING.
>   c) CPU B via select_task_rq determines CPU Y as the target CPU.
> 
> 4) The race
>   a) CPU A acquires CPU X’s lock and relocks CPU Z.
>   b) CPU A reads task p.cpu = Z and incorrectly concludes task p is
>      still on CPU Z.
>   c) CPU A failed to notice task p had been dequeued from CPU Z while
>      CPU A was waiting for locks in double_lock_balance. If CPU A knew
>      that task p had been dequeued, it would return NULL forcing
>      push_rt_task to give up the task p's migration.
>   d) CPU B updates task p.cpu = Y and calls ttwu_queue.
>   e) CPU B locks Ys rq. CPU B enqueues task p onto Y and sets task
>      p.on_rq = 1.
>   f) CPU B unlocks CPU Y, triggering memory synchronization.
>   g) CPU A reads task p.on_rq = 1, cementing its assumption that task p
>      has not migrated.
>   h) CPU A decides to migrate p to CPU X.
> 
> This leads to A dequeuing p from Y's queue and various crashes down the
> line.
> 
> Solution
> ========
> The solution here is fairly simple. After obtaining the lock (at 4a),
> the check is enhanced to make sure that the task is still at the head of
> the pushable tasks list. If not, then it is anyway not suitable for
> being pushed out.
> 
> Testing
> =======
> The fix is tested on a cluster of 3 nodes, where the panics due to this
> are hit every couple of days. A fix similar to this was deployed on such
> cluster and was stable for more than 30 days.
> 
> Co-developed-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Tested-by: Will Ton <william.ton@nutanix.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: stable@vger.kernel.org
> ---

We've got some crashes that seem to be from the same race so this
will be a nice fix to have. Thanks!

Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil

> Changes in v2:
> - As per Steve's suggestion, removed some checks that are done after
>   obtaining the lock that are no longer needed with the addition of new
>   check.
> - Moved up is_migration_disabled check.
> - Link to v1:
>   https://lore.kernel.org/lkml/20250211054646.23987-1-harshit@nutanix.com/
> 
> Changes in v3:
> - Updated commit message to add stable maintainers and reviewed-by tag.
> - Link to v2:
>   https://lore.kernel.org/lkml/20250214170844.201692-1-harshit@nutanix.com/
> ---
>  kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b1..4762dd3f50c5 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1885,6 +1885,27 @@ static int find_lowest_rq(struct task_struct *task)
>  	return -1;
>  }
>  
> +static struct task_struct *pick_next_pushable_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	p = plist_first_entry(&rq->rt.pushable_tasks,
> +			      struct task_struct, pushable_tasks);
> +
> +	BUG_ON(rq->cpu != task_cpu(p));
> +	BUG_ON(task_current(rq, p));
> +	BUG_ON(task_current_donor(rq, p));
> +	BUG_ON(p->nr_cpus_allowed <= 1);
> +
> +	BUG_ON(!task_on_rq_queued(p));
> +	BUG_ON(!rt_task(p));
> +
> +	return p;
> +}
> +
>  /* Will lock the rq it finds */
>  static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  {
> @@ -1915,18 +1936,16 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  			/*
>  			 * We had to unlock the run queue. In
>  			 * the mean time, task could have
> -			 * migrated already or had its affinity changed.
> -			 * Also make sure that it wasn't scheduled on its rq.
> +			 * migrated already or had its affinity changed,
> +			 * therefore check if the task is still at the
> +			 * head of the pushable tasks list.
>  			 * It is possible the task was scheduled, set
>  			 * "migrate_disabled" and then got preempted, so we must
>  			 * check the task migration disable flag here too.
>  			 */
> -			if (unlikely(task_rq(task) != rq ||
> +			if (unlikely(is_migration_disabled(task) ||
>  				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
> -				     task_on_cpu(rq, task) ||
> -				     !rt_task(task) ||
> -				     is_migration_disabled(task) ||
> -				     !task_on_rq_queued(task))) {
> +				     task != pick_next_pushable_task(rq))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
>  				lowest_rq = NULL;
> @@ -1946,27 +1965,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  	return lowest_rq;
>  }
>  
> -static struct task_struct *pick_next_pushable_task(struct rq *rq)
> -{
> -	struct task_struct *p;
> -
> -	if (!has_pushable_tasks(rq))
> -		return NULL;
> -
> -	p = plist_first_entry(&rq->rt.pushable_tasks,
> -			      struct task_struct, pushable_tasks);
> -
> -	BUG_ON(rq->cpu != task_cpu(p));
> -	BUG_ON(task_current(rq, p));
> -	BUG_ON(task_current_donor(rq, p));
> -	BUG_ON(p->nr_cpus_allowed <= 1);
> -
> -	BUG_ON(!task_on_rq_queued(p));
> -	BUG_ON(!rt_task(p));
> -
> -	return p;
> -}
> -
>  /*
>   * If the current CPU has more than one RT task, see if the non
>   * running task can migrate over to a CPU that is running a task
> -- 
> 2.22.3
> 

-- 


