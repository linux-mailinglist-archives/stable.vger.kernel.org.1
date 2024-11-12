Return-Path: <stable+bounces-92804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7129C5BF4
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38B7281DBE
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8A20102F;
	Tue, 12 Nov 2024 15:34:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD0201024;
	Tue, 12 Nov 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425663; cv=none; b=aCP5Ls11f1wTGISp5pzGOrlsIc5Whhy82cmNT46pAQTumv7/ZY9aGpN09cGbnWVZDOO7jWAu5hkAWCNXaFRQ1hueDIg4M8L4yY2ldLgBPwlvOuygNsj0ed0mmIdAWEa0mPdm+5xAQHBV4HuaUIioYBCMvUNx8fxrOKHDcVHJEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425663; c=relaxed/simple;
	bh=0NGIVkcyQz/aQ+hIPBIw/XshyCLcHpHPKFfkVYTrPiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+/nBA6cyJOLHPRrrUsjyFY7ex6c7/mneli2DN+CQWszVAd1QXpnwFPWs+45gtUWTM3DHiuFwLXdz6upx21GVL4e+8I3FpWqOl9MWTxaim4dhz1lRmizOGCjoW8F0co41AL/sOBi9YuRABKjykAkiNIZ7d+9ju0KdXOZ1NIb3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD33C4CECD;
	Tue, 12 Nov 2024 15:34:21 +0000 (UTC)
Date: Tue, 12 Nov 2024 10:34:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Michael C. Pratt" <mcpratt@pm.me>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2 1/1] sched/syscalls: Allow setting niceness
 using sched_param struct
Message-ID: <20241112103438.57ab1727@gandalf.local.home>
In-Reply-To: <20241111070152.9781-2-mcpratt@pm.me>
References: <20241111070152.9781-1-mcpratt@pm.me>
	<20241111070152.9781-2-mcpratt@pm.me>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 07:03:51 +0000
"Michael C. Pratt" <mcpratt@pm.me> wrote:

> >From userspace, spawning a new process with, for example,  
> posix_spawn(), only allows the user to work with
> the scheduling priority value defined by POSIX
> in the sched_param struct.
> 
> However, sched_setparam() and similar syscalls lead to
> __sched_setscheduler() which rejects any new value
> for the priority other than 0 for non-RT schedule classes,
> a behavior that existed since Linux 2.6 or earlier.
> 
> Linux translates the usage of the sched_param struct
> into it's own internal sched_attr struct during the syscall,
> but the user currently has no way to manage the other values
> within the sched_attr struct using only POSIX functions.
> 
> The only other way to adjust niceness when using posix_spawn()
> would be to set the value after the process has started,
> but this introduces the risk of the process being dead
> before the syscall can set the priority afterward.
> 
> To resolve this, allow the use of the priority value
> originally from the POSIX sched_param struct in order to
> set the niceness value instead of rejecting the priority value.
> 
> Edit the sched_get_priority_*() POSIX syscalls
> in order to reflect the range of values accepted.
> 
> Cc: stable@vger.kernel.org # Apply to kernel/sched/core.c

Why is stable Cc'd?

> Signed-off-by: Michael C. Pratt <mcpratt@pm.me>
> ---
>  kernel/sched/syscalls.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 24f9f90b6574..43eb283e6281 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -785,6 +785,19 @@ static int _sched_setscheduler(struct task_struct *p, int policy,
>  		attr.sched_policy = policy;
>  	}
>  
> +	if (attr.sched_priority > MAX_PRIO-1)
> +		return -EINVAL;
> +
> +	/*
> +	 * If priority is set for SCHED_NORMAL or SCHED_BATCH,
> +	 * set the niceness instead, but only for user calls.
> +	 */
> +	if (check && attr.sched_priority > MAX_RT_PRIO-1 &&
> +	   ((policy != SETPARAM_POLICY && fair_policy(policy)) || fair_policy(p->policy))) {
> +		attr.sched_nice = PRIO_TO_NICE(attr.sched_priority);
> +		attr.sched_priority = 0;
> +	}

This really looks like a hack. Specifically that we are exposing how the
kernel records priority to user space. That is the greater than
MAX_RT_PRIO-1. 120 may be the priority the kernel sees on nice values, but
it is not something that we should every expose to user space system calls.

That said, you are worried about the race of spawning a new task and
setting its nice value because the new task may have exited. What about
using pidfd? Create a task returning the pidfd and use that to set its nice
value.

-- Steve


> +
>  	return __sched_setscheduler(p, &attr, check, true);
>  }
>  /**
> @@ -1532,9 +1545,11 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
>  	case SCHED_RR:
>  		ret = MAX_RT_PRIO-1;
>  		break;
> -	case SCHED_DEADLINE:
>  	case SCHED_NORMAL:
>  	case SCHED_BATCH:
> +		ret = MAX_PRIO-1;
> +		break;
> +	case SCHED_DEADLINE:
>  	case SCHED_IDLE:
>  	case SCHED_EXT:
>  		ret = 0;
> @@ -1560,9 +1575,11 @@ SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
>  	case SCHED_RR:
>  		ret = 1;
>  		break;
> -	case SCHED_DEADLINE:
>  	case SCHED_NORMAL:
>  	case SCHED_BATCH:
> +		ret = MAX_RT_PRIO;
> +		break;
> +	case SCHED_DEADLINE:
>  	case SCHED_IDLE:
>  	case SCHED_EXT:
>  		ret = 0;
> 
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623


