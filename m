Return-Path: <stable+bounces-179280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4FB536DB
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 17:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770FA1CC2FBC
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8B2D130A;
	Thu, 11 Sep 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKWgMVv3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC047494;
	Thu, 11 Sep 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602969; cv=none; b=e10LrXUC53ezt+7B9wgYf2tbTM3vv6uX1L4yD+Zh9aaoHsfSK37mwmKXO2mOgObj/IR7Hnq8BkHdW2j3f9DKFBD2SKKFe9bl7JFcX86ihXnclu3giojy3tMXVevrtp9qAwId7RXqcLTs90KdOBBbqg6jXDDtmJa2lc2VFrtyhug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602969; c=relaxed/simple;
	bh=9DC4d7vV6cYhq0ZyvpEHw08Vw4rYqL4VbG++aVU52RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlDd9ZwWwHjZ1qRWlv/WMYeGwM6Rr/beaaalUgkmNIeZK5Obl8hELhuA0JqljaAjRk7aQGn39mDDjQsxVrhe29eFn8T2FaiUtUDJVCWxqPWsum06Vrj/qaUs5gi7FkhCw4qLAc7hCAYaV1ut6bDx1G17mc/BUnXATxZ5YFDvdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKWgMVv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E2AC4CEF0;
	Thu, 11 Sep 2025 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602968;
	bh=9DC4d7vV6cYhq0ZyvpEHw08Vw4rYqL4VbG++aVU52RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKWgMVv3kHuTcUIMwmvk/Pubg5hCx21AlP1rHLBejCBQxnAqutdsVd5wn6dULjE+Y
	 H5rMWAGyFehttVeqZQoWvRYQT2/9pZRMAitKB4t10YST3XcYVotN2KlU6unUceN76H
	 87lPBMwXi6GsCpQEs/pIXbkblJwuthWF6/T1pN+U9GVqGgiPLzVk02p87NuBfpBfIz
	 hNWSX4Oafspr/Bx1xGWeD5KABmmTgfmsM5NFumW7rVMci0SxdtsNp7R61roghzYuch
	 u3NTGQkl5SFgMQKFX6ngjDjeeQkr2INt0Ze3vgwx1XDXd0GJ2uEf8zNr/2446/9K/V
	 5GQzsbGIfJNZQ==
Date: Thu, 11 Sep 2025 17:02:45 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Tao <wangtao554@huawei.com>, stable@vger.kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, tanghui20@huawei.com,
	zhangqiao22@huawei.com
Subject: Re: [PATCH] sched/core: Fix potential deadlock on rq lock
Message-ID: <aMLklWUzm1ZqZgZF@localhost.localdomain>
References: <20250911124249.1154043-1-wangtao554@huawei.com>
 <20250911135358.GY3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911135358.GY3245006@noisy.programming.kicks-ass.net>

Le Thu, Sep 11, 2025 at 03:53:58PM +0200, Peter Zijlstra a écrit :
> On Thu, Sep 11, 2025 at 12:42:49PM +0000, Wang Tao wrote:
> > When CPU 1 enters the nohz_full state, and the kworker on CPU 0 executes
> > the function sched_tick_remote, holding the lock on CPU1's rq
> > and triggering the warning WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3).
> > This leads to the process of printing the warning message, where the
> > console_sem semaphore is held. At this point, the print task on the
> > CPU1's rq cannot acquire the console_sem and joins the wait queue,
> > entering the UNINTERRUPTIBLE state. It waits for the console_sem to be
> > released and then wakes up. After the task on CPU 0 releases
> > the console_sem, it wakes up the waiting console_sem task.
> > In try_to_wake_up, it attempts to acquire the lock on CPU1's rq again,
> > resulting in a deadlock.
> > 
> > The triggering scenario is as follows:
> > 
> > CPU0								CPU1
> > sched_tick_remote
> > WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3)
> > 
> > report_bug							con_write
> > printk
> > 
> > console_unlock
> > 								do_con_write
> > 								console_lock
> > 								down(&console_sem)
> > 								list_add_tail(&waiter.list, &sem->wait_list);
> > up(&console_sem)
> > wake_up_q(&wake_q)
> > try_to_wake_up
> > __task_rq_lock
> > _raw_spin_lock
> > 
> > This patch fixes the issue by deffering all printk console printing
> > during the lock holding period.
> > 
> > Fixes: d84b31313ef8 ("sched/isolation: Offload residual 1Hz scheduler tick")
> > Signed-off-by: Wang Tao <wangtao554@huawei.com>
> 
> I fundamentally hate that deferred thing and consider it a printk bug.
> 
> But really, if you trip that WARN, fix it and the problem goes away.

And probably it triggers a lot of false positives. An overloaded housekeeping
CPU can easily be off for 2 seconds. We should make it 30 seconds.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

