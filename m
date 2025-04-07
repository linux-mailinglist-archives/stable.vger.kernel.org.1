Return-Path: <stable+bounces-128497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D079BA7D919
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 11:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552FF3AD604
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313A22F155;
	Mon,  7 Apr 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlaF36dY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF0212F94
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017151; cv=none; b=iDk8N3v2zzBd/n1+Yl1UcdO4eZMBXLTEJtdbENmy34r29Za3QUA4o7lwmqomnYJPxB4aBpPIV4obobGmfZznbt0NaXgC3AAe23f1nExAZ5+s+6a8geZUmYizy0S59GbsCv3VhD3G7JxnAOhlojnclJanK47GNkBkYP1fjL/Va+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017151; c=relaxed/simple;
	bh=QqcgnYbc64ABiFa7PpiP90t8g/PUReKKfwUWK5UDtO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7XLlGruwzW4rvDHWJyrqwHFxJ5Ggcrg2/ijPK3C62ounEx6vBlIeSvxfV1tPPLgrfVIJFkwahBzX8AfUmwBcimuZSlrwEqTtKMhZcM55uJwgAGmghdVfoFN5jv44t0MghXuWrZGiu6vOmaPSepfV56OLpV4Ak4f8skCl/f5M9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlaF36dY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744017149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b+QgqHBJKeKPJpZKiVrtUQ7XxmYxjnt7PV0YU2Xe9Ro=;
	b=MlaF36dYwKzWvP5OQaJxxGL1prrEJNgt8wp9+OZPd/3wOyPnZ4o4NmW2GdzE5MA3igVXCQ
	S91l29WB8V6JFxQW//KrkoVkFgx829RSoSHSGQoUqO8BEq1H57Xs1l5xY+Bz3Yt/UepR2i
	ne6AHBF23uSJhgyH8I/WKDxAZgQbas4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-Pxnxu563NtKIjlmI851SgA-1; Mon, 07 Apr 2025 05:12:27 -0400
X-MC-Unique: Pxnxu563NtKIjlmI851SgA-1
X-Mimecast-MFC-AGG-ID: Pxnxu563NtKIjlmI851SgA_1744017147
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac7791ecb7bso417145166b.0
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 02:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744017147; x=1744621947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+QgqHBJKeKPJpZKiVrtUQ7XxmYxjnt7PV0YU2Xe9Ro=;
        b=iFXMS4e2KBTMK4BJhD4Ipn357Izq6ScAXnW5TCmM5RAq/DTQ3JJUC15MeDeq+9oEgv
         GiP5rc7B/MuqqtP5P2lE0ha/3HMvVPdvRR1bXzhcTLFkDuRDhPaMrgku3kPMLqbP5EeB
         kBzukzRu8cAa1mKT33KhN3sj7F7mF8vhjubeVtkax0eSDPDbmcqu9a97kUO3vOrF7AvH
         7WlWUCV9UXVeWjKDhIfTwGkciv6ltX7tEUrnp9Q63+lBJ4ejbB+YO+OTJKg4uh5PW1gF
         lY6QyQGPLxwnlrEmGkQbNWosZuysfzLGDQzPBJzAHqgjGS/zb607a+nG/ic3SnLs4Brh
         bJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpY2cg8p34B+eeALSRGRbbdmW+A10/mfWCdln9Q+X+up+lwxHaT7kXLMyC+ZMvSkxV5LlG8uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCCCpWhUYtSNkbssWmlvSLsR3FB26vAzxGMAnpjDq0ccGAbTTM
	XEAT2QWOXMnUJ3dB5L9+2FwvtEcdjv5PfPw44YVFGlD8An1LspXQczIPfS78hHT/6AIlO9TVtGa
	byvq1xAt6rtq36HSXdcFJJRhqZ8Igvy8bIA3zp3uOy6+/JiM3QSNlPQ==
X-Gm-Gg: ASbGncuRl5b8PJhXEdvUNGKn3MNoGa89NoGCdnJq9ksS08qNpzSUOIIqdGmudPxDn9J
	sIHai/j7PoAy9rYuxYYMZNq/o1lHgspBCsS+9FyWlVd5NfhASumvy+XAAzs1BseiizQ9ioUokUd
	Cfc84Dj+iiPnIjizn9y378Mh8THXNdOiuOAD9hy5KA7AIIgF2v8CwlMug9q7rKKR0r569J3xhaw
	lFu/8SjEylw6OTLlrcrjgD4YGa6bYq1D1L3t95R6/ovtBO0RSRVbBOJK+cHGJfuicIhmFc5dDDO
	qXlYurGTcC4+3YeMJsV9gJi3JwQkhJFpwDckla1rG/q8JC4=
X-Received: by 2002:a17:907:2d94:b0:ac2:26a6:febf with SMTP id a640c23a62f3a-ac7b712907bmr1442455766b.20.1744017146641;
        Mon, 07 Apr 2025 02:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm1rZUXB12vt8Se6sBgBy4VPKdiBjpKzOKKDr0v9jlpJYU9ZFOVAiulvwKNd78yZa0v4y2yA==
X-Received: by 2002:a17:907:2d94:b0:ac2:26a6:febf with SMTP id a640c23a62f3a-ac7b712907bmr1442452766b.20.1744017146233;
        Mon, 07 Apr 2025 02:12:26 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.37.215.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087f0a0f3sm6700245a12.43.2025.04.07.02.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:12:25 -0700 (PDT)
Date: Mon, 7 Apr 2025 11:12:21 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Fix race in push_dl_task
Message-ID: <Z_OW9a_U4WQFWEBH@jlelli-thinkpadt14gen4.remote.csb>
References: <20250317022325.52791-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317022325.52791-1-harshit@nutanix.com>

Hi,

I think I like this version better, but others feel free to disagree. :)

A few comments inline below.

On 17/03/25 02:23, Harshit Agarwal wrote:
> This fix is the deadline version of the change made to the rt scheduler
> titled: "sched/rt: Fix race in push_rt_task".
> Here is the summary of the issue:

I would probably remove the paragraph above and simply describe what the
issues is like you do below.

> When a CPU chooses to call push_dl_task and picks a task to push to
> another CPU's runqueue then it will call find_lock_later_rq method
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
> Please go through the original change for more details on the issue.
> 
> In this fix, after the lock is obtained inside the find_lock_later_rq we

Please use imperative mode

https://elixir.bootlin.com/linux/v6.13.7/source/Documentation/process/submitting-patches.rst#L94

> ensure that the task is still at the head of pushable tasks list. Also
> removed some checks that are no longer needed with the addition this new
> check.
> However, the check of pushable tasks list only applies when
> find_lock_later_rq is called by push_dl_task. For the other caller i.e.
> dl_task_offline_migration, we use the existing checks.
> 
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - As per Juri's suggestion, moved the check inside find_lock_later_rq
>   similar to rt change. Here we distinguish among the push_dl_task
>   caller vs dl_task_offline_migration by checking if the task is
>   throttled or not.
> - Fixed the commit message to refer to the rt change by title.
> - Link to v1:
>   https://lore.kernel.org/lkml/20250307204255.60640-1-harshit@nutanix.com/
> ---
>  kernel/sched/deadline.c | 66 ++++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 38e4537790af..2366801b4557 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2621,6 +2621,25 @@ static int find_later_rq(struct task_struct *task)
>  	return -1;
>  }
>  
> +static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_dl_tasks(rq))
> +		return NULL;
> +
> +	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
> +
> +	WARN_ON_ONCE(rq->cpu != task_cpu(p));
> +	WARN_ON_ONCE(task_current(rq, p));
> +	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> +
> +	WARN_ON_ONCE(!task_on_rq_queued(p));
> +	WARN_ON_ONCE(!dl_task(p));
> +
> +	return p;
> +}
> +
>  /* Locks the rq it finds */
>  static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>  {
> @@ -2648,12 +2667,30 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>  
>  		/* Retry if something changed. */
>  		if (double_lock_balance(rq, later_rq)) {
> -			if (unlikely(task_rq(task) != rq ||
> +			/*
> +			 * We had to unlock the run queue. In the meantime,

Maybe rephrase as "doble_lock_balance might have released rq->lock ...".

> +			 * task could have migrated already or had its affinity
> +			 * changed.
> +			 * It is possible the task was scheduled, set
> +			 * "migrate_disabled" and then got preempted, so we must
> +			 * check the task migration disable flag here too.
> +			 * For throttled task (dl_task_offline_migration), we
> +			 * check if the task is migrated to a different rq or
> +			 * is not a dl task anymore.
> +			 * For the non-throttled task (push_dl_task), the check
> +			 * to ensure that this task is still at the head of the
> +			 * pushable tasks list is enough.

Maybe you can make a bullet point list out of this comment so that it's
even easier to associate it to the conditions below?

> +			 */
> +			if (unlikely(is_migration_disabled(task) ||
>  				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
> -				     task_on_cpu(rq, task) ||
> -				     !dl_task(task) ||
> -				     is_migration_disabled(task) ||
> -				     !task_on_rq_queued(task))) {
> +				     (task->dl.dl_throttled &&
> +				      (task_rq(task) != rq ||
> +				       task_on_cpu(rq, task) ||
> +				       !dl_task(task) ||
> +				       !task_on_rq_queued(task))) ||
> +				     (!task->dl.dl_throttled &&
> +				      task != pick_next_pushable_dl_task(rq)))) {
> +

Thanks!
Juri


