Return-Path: <stable+bounces-179256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DEBB531F4
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 14:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A0854E15BD
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96784320A1B;
	Thu, 11 Sep 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zcxTyi3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A0223337;
	Thu, 11 Sep 2025 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593239; cv=none; b=E14uVAU6b0QZfqWaSWLm0UXJ6NUvEurD2NOoFg8lyDLkCGIuX5rrPGOtqHNj/M/ICgoQCA15SahSNyepoJajfw76JgU7af2tSFcfwyO99+brfd0euT7RbUCrMzpA3LgIEkaPDoH1V72BVBYSykJNqsCSZlSvghCgu75Ne3cyV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593239; c=relaxed/simple;
	bh=iBaL+C3Xp28K8mC4PWIBs4g6UwkJb0HqUb+c5stSKow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECcGL3UJg5fDEWCUkhmjjqF5uBKjrsOpSX9xotSp9kBZfDIItNbhQQpV6Y4nNCmORz2ELIduZaXKttdpIdeVbZSmYqtsOj1hmNJkY40aFVbuAjPCbJJvVXYAROHZ0o+AS3NM6vALU/NTxI+aTMYgnNS4TkwxBWtrgtCFSmO6wOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zcxTyi3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440A7C4CEF0;
	Thu, 11 Sep 2025 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757593238;
	bh=iBaL+C3Xp28K8mC4PWIBs4g6UwkJb0HqUb+c5stSKow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zcxTyi3mj3xPJKqrnKnIGGAmRJ52Fl13dyR5f7thpAWPqIPXBapi1Nyp4APBTNsup
	 9w2x2A+6FtYmlSrEyLnn6cVLOBQL/uy0/j4V9syEnv8JxK/l90vTF7LJ6tjKW9zN3C
	 Y3ofwsFf3by7aHhbxogqXAHQ5W7yE88g5R4mPYMs=
Date: Thu, 11 Sep 2025 14:20:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Tao <wangtao554@huawei.com>
Cc: stable@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, tglx@linutronix.de,
	frederic@kernel.org, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com
Subject: Re: [PATCH stable/linux-5.10.y] sched/core: Fix potential deadlock
 on rq lock
Message-ID: <2025091123-unsterile-why-ca1e@gregkh>
References: <20250908084230.848195-1-wangtao554@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908084230.848195-1-wangtao554@huawei.com>

On Mon, Sep 08, 2025 at 08:42:30AM +0000, Wang Tao wrote:
> When CPU 1 enters the nohz_full state, and the kworker on CPU 0 executes
> the function sched_tick_remote, holding the lock on CPU1's rq
> and triggering the warning WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3).
> This leads to the process of printing the warning message, where the
> console_sem semaphore is held. At this point, the print task on the
> CPU1's rq cannot acquire the console_sem and joins the wait queue,
> entering the UNINTERRUPTIBLE state. It waits for the console_sem to be
> released and then wakes up. After the task on CPU 0 releases
> the console_sem, it wakes up the waiting console_sem task.
> In try_to_wake_up, it attempts to acquire the lock on CPU1's rq again,
> resulting in a deadlock.
> 
> The triggering scenario is as follows:
> 
> CPU 0								CPU1
> sched_tick_remote
> WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3)
> 
> report_bug							con_write
> printk
> 
> console_unlock
> 								do_con_write
> 								console_lock
> 								down(&console_sem)
> 								list_add_tail(&waiter.list, &sem->wait_list);
> up(&console_sem)
> wake_up_q(&wake_q)
> try_to_wake_up
> __task_rq_lock
> _raw_spin_lock
> 
> This patch fixes the issue by deffering all printk console printing
> during the lock holding period.
> 
> Fixes: d84b31313ef8 ("sched/isolation: Offload residual 1Hz scheduler tick")
> Signed-off-by: Wang Tao <wangtao554@huawei.com>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 40f40f359c5d..fd2c83058ec2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4091,6 +4091,7 @@ static void sched_tick_remote(struct work_struct *work)
>  		goto out_requeue;
>  
>  	rq_lock_irq(rq, &rf);
> +	printk_deferred_enter();
>  	curr = rq->curr;
>  	if (cpu_is_offline(cpu))
>  		goto out_unlock;
> @@ -4109,6 +4110,7 @@ static void sched_tick_remote(struct work_struct *work)
>  
>  	calc_load_nohz_remote(rq);
>  out_unlock:
> +	printk_deferred_exit();
>  	rq_unlock_irq(rq, &rf);
>  out_requeue:
>  
> -- 
> 2.34.1
> 
> 

What is the git commit id of this in Linus's tree?

thanks,

greg k-h

