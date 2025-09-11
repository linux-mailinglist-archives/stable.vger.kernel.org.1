Return-Path: <stable+bounces-179269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B159B53497
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E888BB6315B
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4B54763;
	Thu, 11 Sep 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nhf6kjYt"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493D32A3D1;
	Thu, 11 Sep 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598856; cv=none; b=oM5By2mhz2JyE24qVGaK1esR7dBpxNrpCtpFdCpXBO5xpU3NBnCp2vZjgnjBbtZnHlNpgCU6gVjPNus2NnnA6SzkZd56JaulEmvTbakg+uUDESH8iUhBoNokBg2bcfiQtWH7oh8Qgn0/8mPqNZJOzYEYpQdj7hIFmzsROTW+t50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598856; c=relaxed/simple;
	bh=MkgK8zijQnIqEOvxVvaq/XaLhpCfm2O6xkeWtBMnz8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDZEVjubydHxN2ekI7EdM2qIfqNzbTUoBXY8ow644k+rE7iiUpd4vnP+SOnwtYNwJNKxp68+1iSbn2sZF0fOJ/WyiZDdBds7XOuuef4YtyPEzzGPtUit7B35WxHeIkMz1N6NMIWAb+lFXPJOXxLs8NCQDGeWsPO8GHYZlhV5cuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nhf6kjYt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SRJiyiI6ytrZMmaJR5EAXcNbx7SPoMoFmIxt/R7qzT8=; b=nhf6kjYtE1tj+zIMTqd/MiKFim
	M3qMVPLa1cluZBHk1UrAugKIzOpFuD/BpkVc4zpsvTJggQqvprNEM4uzYYeARbnnq2SUgyHnJ56WR
	CrULT+ydgTJrUWp7J9f/pM5mpQri5KyZ9a837+eye8Jo3czVHqmf6vnKUgycUN7/NIEcWnXcE9jIJ
	41TlslCSHmcxKZY77fDgqmep8X3XSLiJug/ULXlfcYMNWw6VzdH+Y8sCtOUVSNdJ1qq0KWZLIlGC9
	mee0fM/LtA+HdVs22/vkeVRj3+z1LGA113Ykiaxb4ySqfrl/M+5KmsdQgZ0/rPUHHA3OqBZqEkvTQ
	t9tpOHcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwhkO-000000065xd-1fb3;
	Thu, 11 Sep 2025 13:54:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DD709300579; Thu, 11 Sep 2025 15:53:58 +0200 (CEST)
Date: Thu, 11 Sep 2025 15:53:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Wang Tao <wangtao554@huawei.com>
Cc: stable@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, tglx@linutronix.de, frederic@kernel.org,
	linux-kernel@vger.kernel.org, tanghui20@huawei.com,
	zhangqiao22@huawei.com
Subject: Re: [PATCH] sched/core: Fix potential deadlock on rq lock
Message-ID: <20250911135358.GY3245006@noisy.programming.kicks-ass.net>
References: <20250911124249.1154043-1-wangtao554@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911124249.1154043-1-wangtao554@huawei.com>

On Thu, Sep 11, 2025 at 12:42:49PM +0000, Wang Tao wrote:
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
> CPU0								CPU1
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

I fundamentally hate that deferred thing and consider it a printk bug.

But really, if you trip that WARN, fix it and the problem goes away.

