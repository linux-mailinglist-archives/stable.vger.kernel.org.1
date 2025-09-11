Return-Path: <stable+bounces-179281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CDEB53743
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99611889861
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8145A35085C;
	Thu, 11 Sep 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9h/zeXg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6EC34AAF4
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603661; cv=none; b=NZJpNaXEZAKqEIimQ1Ikd+NIL5ugpFs7DIgHOl++/jg2J2N7t2+UIC1AMzxYSMMTBKqngmb5KcxzESwefN3gV26o53sX4hXDK/Zpy+3gLoDCU54/claRG1TTZHwVTARJJ39H6h9TgHTMnUYb81YVvDjjy4umoj3TQnwC4KwN4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603661; c=relaxed/simple;
	bh=0JU93CxYWpf8MsUp2/Gmssw3P3OVuGPIO2YefZ1Rl74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkCY26tIME8lZ7y/SjRusHmtgHXXV1kY9ehAUb0uhm2l1uesOka7Dne4Pz6uWASJ/sYaDT/PS35KaLY6IO0sVeleBnp96bn7a3YrsL9Zu7IZK/0DjzJfyIWfoZHBitDWJagw5l5CJMHsa7T1454E0jdYwu9LV2RELUiQv3ub1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9h/zeXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757603658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhkjH+hTcVoB2yqMPEhvNQAw1eYZHiJV4Zt4Zroar9Y=;
	b=H9h/zeXgk4i3G/bz9AyB6SlCmHItaeCcBFSKng4KR/eTg1+FRKGuF7oB9McXiWPKwRnIy2
	dOiL21Zst2Z9K2XLwXjO4QX2QlwtYGZVeJrgqUWXa5b8wkfb3wsu/dZ9QJS5VqLgYY5Guf
	tOHekw72NCVI9HD6ZDbHZVMQDVnOCXo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-1MBZyD3sO--rBsXZgZZTeA-1; Thu,
 11 Sep 2025 11:14:15 -0400
X-MC-Unique: 1MBZyD3sO--rBsXZgZZTeA-1
X-Mimecast-MFC-AGG-ID: 1MBZyD3sO--rBsXZgZZTeA_1757603652
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A4F2180029A;
	Thu, 11 Sep 2025 15:14:11 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.69])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB60C1944CEB;
	Thu, 11 Sep 2025 15:14:08 +0000 (UTC)
Date: Thu, 11 Sep 2025 11:14:06 -0400
From: Phil Auld <pauld@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Wang Tao <wangtao554@huawei.com>,
	stable@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com
Subject: Re: [PATCH] sched/core: Fix potential deadlock on rq lock
Message-ID: <20250911151318.GC396619@pauld.westford.csb>
References: <20250911124249.1154043-1-wangtao554@huawei.com>
 <20250911135358.GY3245006@noisy.programming.kicks-ass.net>
 <aMLklWUzm1ZqZgZF@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMLklWUzm1ZqZgZF@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Sep 11, 2025 at 05:02:45PM +0200 Frederic Weisbecker wrote:
> Le Thu, Sep 11, 2025 at 03:53:58PM +0200, Peter Zijlstra a écrit :
> > On Thu, Sep 11, 2025 at 12:42:49PM +0000, Wang Tao wrote:
> > > When CPU 1 enters the nohz_full state, and the kworker on CPU 0 executes
> > > the function sched_tick_remote, holding the lock on CPU1's rq
> > > and triggering the warning WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3).
> > > This leads to the process of printing the warning message, where the
> > > console_sem semaphore is held. At this point, the print task on the
> > > CPU1's rq cannot acquire the console_sem and joins the wait queue,
> > > entering the UNINTERRUPTIBLE state. It waits for the console_sem to be
> > > released and then wakes up. After the task on CPU 0 releases
> > > the console_sem, it wakes up the waiting console_sem task.
> > > In try_to_wake_up, it attempts to acquire the lock on CPU1's rq again,
> > > resulting in a deadlock.
> > > 
> > > The triggering scenario is as follows:
> > > 
> > > CPU0								CPU1
> > > sched_tick_remote
> > > WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3)
> > > 
> > > report_bug							con_write
> > > printk
> > > 
> > > console_unlock
> > > 								do_con_write
> > > 								console_lock
> > > 								down(&console_sem)
> > > 								list_add_tail(&waiter.list, &sem->wait_list);
> > > up(&console_sem)
> > > wake_up_q(&wake_q)
> > > try_to_wake_up
> > > __task_rq_lock
> > > _raw_spin_lock
> > > 
> > > This patch fixes the issue by deffering all printk console printing
> > > during the lock holding period.
> > > 
> > > Fixes: d84b31313ef8 ("sched/isolation: Offload residual 1Hz scheduler tick")
> > > Signed-off-by: Wang Tao <wangtao554@huawei.com>
> > 
> > I fundamentally hate that deferred thing and consider it a printk bug.
> > 
> > But really, if you trip that WARN, fix it and the problem goes away.
> 
> And probably it triggers a lot of false positives. An overloaded housekeeping
> CPU can easily be off for 2 seconds. We should make it 30 seconds.
>

It does trigger pretty easily. We've done some work to try to make better
(spreading HK work around for example) but you can still hit it. Especially,
if there are virtualization layers involved...

Increasing that time a bit would be great :)

Cheers,
Phil


> Thanks.
> 
> -- 
> Frederic Weisbecker
> SUSE Labs
> 

-- 


