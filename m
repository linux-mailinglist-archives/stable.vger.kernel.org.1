Return-Path: <stable+bounces-179283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBBB537FA
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3629B5A3F8B
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84634DCEB;
	Thu, 11 Sep 2025 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0AqTLHX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC933EB01;
	Thu, 11 Sep 2025 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605098; cv=none; b=hAoAylT7K0pPerVFPOGP5mHJZ8eRLKndyXQ32qVucVGItHE131aKF/glQBtbsxgNmJfIPqtg3RZFFCbloF9N0Q4pIprd2N8+n0aPIv5P7PlBwvZ8RXXHG1tt0NRrDiXhaP/SF/nTSs0eo/jo3HTaKIuXdEP8Zz19gISQH2/QXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605098; c=relaxed/simple;
	bh=FpJnBkUzJTOAJGIvp26GMaLN97hn2Z8laqX+1Rcj17g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc1SzGhKK78aqESprHjjEM8B5I4Xvb2w4g0J60X5o4IfyMqcM8GBC3pvN5e0O3VtbZc46WBeo/eBxMMz0yPaSepfkftsbvhiB94GJtqqPO6m0LTkUF8j5CpcDQSDBpE+jMvTU9hwJ24wr1lMVgpRlQouyqZmFVA213xqjrC9PHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0AqTLHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392F6C4CEF0;
	Thu, 11 Sep 2025 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757605095;
	bh=FpJnBkUzJTOAJGIvp26GMaLN97hn2Z8laqX+1Rcj17g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0AqTLHXG4LNCgjftmdQpFv0v3NIUFQ2UW9gyouN01K58cxSuPkX5jYZyoiM6uvZS
	 Kv6onEl3qwx8K5iKqoXxgM9ZfL6jTyy1amqwsIu49MrZ/sHbzsy0v7Joe+RAiaVYMv
	 dNrZ3uo+3Pm+BRdImTsqjfQi7EtZhzHNdCaQo33hYl/JTjMgEIUlznIYyYtAfJBtts
	 LMW6+4RnYCFwgqJf1zUxQUKtZxDn3R3XmdE3dGchrF1j0FTWhRPIowWQSID6G31pQC
	 9LoDebX5+W5lBkSJQwpM8P4fj3Ux22AdI67K0a3h8g1KZgPO3CXSzzfZOlRbqMv2GC
	 de0QmLI69hfaw==
Date: Thu, 11 Sep 2025 17:38:12 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Wang Tao <wangtao554@huawei.com>,
	stable@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com
Subject: Re: [PATCH] sched/core: Fix potential deadlock on rq lock
Message-ID: <aMLs5G3WvlXOAxuY@localhost.localdomain>
References: <20250911124249.1154043-1-wangtao554@huawei.com>
 <20250911135358.GY3245006@noisy.programming.kicks-ass.net>
 <aMLklWUzm1ZqZgZF@localhost.localdomain>
 <20250911151318.GC396619@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911151318.GC396619@pauld.westford.csb>

Le Thu, Sep 11, 2025 at 11:14:06AM -0400, Phil Auld a écrit :
> On Thu, Sep 11, 2025 at 05:02:45PM +0200 Frederic Weisbecker wrote:
> > Le Thu, Sep 11, 2025 at 03:53:58PM +0200, Peter Zijlstra a écrit :
> > > On Thu, Sep 11, 2025 at 12:42:49PM +0000, Wang Tao wrote:
> > > > When CPU 1 enters the nohz_full state, and the kworker on CPU 0 executes
> > > > the function sched_tick_remote, holding the lock on CPU1's rq
> > > > and triggering the warning WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3).
> > > > This leads to the process of printing the warning message, where the
> > > > console_sem semaphore is held. At this point, the print task on the
> > > > CPU1's rq cannot acquire the console_sem and joins the wait queue,
> > > > entering the UNINTERRUPTIBLE state. It waits for the console_sem to be
> > > > released and then wakes up. After the task on CPU 0 releases
> > > > the console_sem, it wakes up the waiting console_sem task.
> > > > In try_to_wake_up, it attempts to acquire the lock on CPU1's rq again,
> > > > resulting in a deadlock.
> > > > 
> > > > The triggering scenario is as follows:
> > > > 
> > > > CPU0								CPU1
> > > > sched_tick_remote
> > > > WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3)
> > > > 
> > > > report_bug							con_write
> > > > printk
> > > > 
> > > > console_unlock
> > > > 								do_con_write
> > > > 								console_lock
> > > > 								down(&console_sem)
> > > > 								list_add_tail(&waiter.list, &sem->wait_list);
> > > > up(&console_sem)
> > > > wake_up_q(&wake_q)
> > > > try_to_wake_up
> > > > __task_rq_lock
> > > > _raw_spin_lock
> > > > 
> > > > This patch fixes the issue by deffering all printk console printing
> > > > during the lock holding period.
> > > > 
> > > > Fixes: d84b31313ef8 ("sched/isolation: Offload residual 1Hz scheduler tick")
> > > > Signed-off-by: Wang Tao <wangtao554@huawei.com>
> > > 
> > > I fundamentally hate that deferred thing and consider it a printk bug.
> > > 
> > > But really, if you trip that WARN, fix it and the problem goes away.
> > 
> > And probably it triggers a lot of false positives. An overloaded housekeeping
> > CPU can easily be off for 2 seconds. We should make it 30 seconds.
> >
> 
> It does trigger pretty easily. We've done some work to try to make better
> (spreading HK work around for example) but you can still hit it. Especially,
> if there are virtualization layers involved...
> 
> Increasing that time a bit would be great :)

Interested in sending the patch? :-)

Thanks.

> 
> Cheers,
> Phil
> 
> 
> > Thanks.
> > 
> > -- 
> > Frederic Weisbecker
> > SUSE Labs
> > 
> 
> -- 
> 

-- 
Frederic Weisbecker
SUSE Labs

