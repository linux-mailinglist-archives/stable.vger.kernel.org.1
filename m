Return-Path: <stable+bounces-120218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09547A4D7BA
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06B61886FEC
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948781FC7C9;
	Tue,  4 Mar 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyiYDxGY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F341FBCAD
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079771; cv=none; b=Qa/T/6W21NTfFSYyANbfO91nubOjPlJiyjaUy6QSI7LWu6LqDa2Ee61B1oZFqDyl25M54cQ/7q3xxoAfr07YkmG5hesAqMewV3SOGrcCBwaV0aHIaU31dhDHALI+GfO9iLMhfBpM7EkT9K+jYwI350iJppRBeMlFkBELil3JLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079771; c=relaxed/simple;
	bh=fzMnd7M6rwCyOtB8q34CUuM6FNDauTxpaDL9Z6xCCYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYmQoxm93XlDPDc5ht8Wh7SFls04vy0w/pPPrkdXTx7MsVgwqUHxQZCFJpjz3BSHWKzle8OBqYNRfgkX4shVaJsqr2jQYFoNk7Bs1LPvsd4d9byQHNUuTnIqHcwQrw6Usl9fiCLTlGf4RlVpZsXDEDFfFR9VFmNEBqjOq6vo5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyiYDxGY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741079768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twbfMmYGP3kHV1qPJcf6r3dyxEQU/j00LNN32qJ4mH4=;
	b=WyiYDxGYMKf8W2pPJ8vU9eAa2iv7SqgG7UAUwTt44kiAIGIvW2YKIjQGtFCdrZ9X7roFba
	OsxEXcsRB43xV4nVt/5Slzn9hr5wnyQrqp8xIvAre44BfCcH+wOKYZfq8fbtjGU+AIw+BW
	suXPNLvnfpnMdE3LXtMgyz5Mggf6TJg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-DWlQ_zrsNC-gBq1AHOAesg-1; Tue, 04 Mar 2025 04:16:02 -0500
X-MC-Unique: DWlQ_zrsNC-gBq1AHOAesg-1
X-Mimecast-MFC-AGG-ID: DWlQ_zrsNC-gBq1AHOAesg_1741079761
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0a3ff7e81so1171706185a.3
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 01:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741079761; x=1741684561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twbfMmYGP3kHV1qPJcf6r3dyxEQU/j00LNN32qJ4mH4=;
        b=NTET4CM5xmyZW5vfDwDBhHmL6qaJWkkm0QqBwgtnX5ICc5ciZL+jV9Kw7ZxnZHT0x+
         +r0F8TkdS7GEUuUquc4TlOam6Uc7OfllGcWxj4EYRfVDV6dwDRnPH/SA6C0wavwERxue
         9w77RmXyZgtBFlFZrAl0RV5kALBsIT1oLIOgqxcpTHxh4itFguq4qHYbxNfNuHDPOwgk
         Cpmr+y7MJOalK8MuAUh4NKfHMA+C32JxEJVT3qEUeciFQkSowBw/KksqVOmaOWzj/Y5a
         j5Gdmwr4kf11w77xFvK4x7XoYMCOdndDGdMZoNXfjeKlUR0C2JhkL3ENpfjv/BUlBjlT
         Tf7w==
X-Forwarded-Encrypted: i=1; AJvYcCWSUt3a2A/3AKBFZ8AE2+FKkU7NCqkFntZi5dX7d1icKsAB1p+rBr26cukRngy86dKAc5batD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERF4e1o7iv16TZ50kYR4vk/Amzra3HtZzw2hIPpbaHn8zq0Ny
	mU+t/i4ld2GsGNEkFnlUAvV43ZakLAw3/SkAEQ9/b+0RKhTMJEfFt2gDQmVxXpepGqOKe5t/4be
	QoEh1Wm+gvhIgwV3fXZj5taAaz7SMlaMTNjoqRRRmwxT0m1iU+/qP4A==
X-Gm-Gg: ASbGncv9Z60JrJuKj2y3nWsAoKJJvd3AmhU7V+lwJgLE3Pgza2ZgGJyhDgroTm5CJyz
	FZ2veEa180HKbL5bAfep9CBDKAkoXlKWZXTbMpSTUm+a7RU04mJuRYmh54lynnKS7Ei1RB+Nh8T
	+Qgq5hGY3rH3KQkYb0ZoH8uvfADmniecd8rZ867mblttwf29xFlRP4lX4Goht3kjsZqg5oZ/Duh
	fXEatLn2jIJi5mdDJRvI2+2SAvFniSLzP09PkC3aITZ+1wBmZ19P9YaMNb6C8S3FA2Gq20sJona
	gLhNxOFJtQfBYM19OmwEzb47cNUv/LKER2Il+iMm2CiGAYjMYQblhnUdxKdnDBgLsg5TXhshnnK
	7/zpk
X-Received: by 2002:a05:620a:3902:b0:7c0:6419:8bd3 with SMTP id af79cd13be357-7c39c4b678bmr2271035385a.22.1741079761459;
        Tue, 04 Mar 2025 01:16:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHENlR8nCjhV94d1R8ys7ThN2NQzinSvDAG1fi5LyI/AFJRlI8nAiJwrzKnAO3Hrp6y5e7WgQ==
X-Received: by 2002:a05:620a:3902:b0:7c0:6419:8bd3 with SMTP id af79cd13be357-7c39c4b678bmr2271031685a.22.1741079761188;
        Tue, 04 Mar 2025 01:16:01 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3d30cc5fdsm18304985a.72.2025.03.04.01.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:16:00 -0800 (PST)
Date: Tue, 4 Mar 2025 09:15:55 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
References: <20250225180553.167995-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225180553.167995-1-harshit@nutanix.com>

Hi Harshit,

On 25/02/25 18:05, Harshit Agarwal wrote:
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

...

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

As usual, we have essentially the same in deadline.c, do you think we
should/could implement the same fix proactively in there as well? Steve?

Thanks,
Juri


