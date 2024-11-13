Return-Path: <stable+bounces-92869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EEF9C6616
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 01:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3841F24EAB
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DC7A936;
	Wed, 13 Nov 2024 00:36:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949132594;
	Wed, 13 Nov 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458161; cv=none; b=ng5cuovy/DjwBrZqfUHzE32DDkGBqkC9cZJ7RUBCHIkIRtIsHD8hUWZBTZjFaTO0VeajeQMXTy71pUfV576MrC5UgUJ+CpLyQJ8GGMB3TaR+rehIHYCKiOy+VANVD7dxH7mqry4jylZgpB0oHouH6D0GK/1SNSAQmKonPWwcd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458161; c=relaxed/simple;
	bh=mFjxgSAPg7df7lpMOSnVaqdB933f+6mi2DjPmU5QjfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvEx9Ypw4iNp/T9O61fMcwqSV8t6GpUpJ9Td5nARnwBeZI98F3NKwBIhKFViWg48y3OicETJw5FJnAA/zV9QHVlCd5OAjJnxNf5VVKYDyf3oMzRqwyYCumzxUD2DWPZPCKxdBZ8wcSEsP1ySn2FDB55yNcoDAbLEO60lU1vkEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C497C4CECD;
	Wed, 13 Nov 2024 00:35:59 +0000 (UTC)
Date: Tue, 12 Nov 2024 19:36:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Pratt <mcpratt@pm.me>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2 1/1] sched/syscalls: Allow setting niceness
 using sched_param struct
Message-ID: <20241112193617.169fefbc@gandalf.local.home>
In-Reply-To: <e3Nl9UdWoWuPJauA6X3vNj71jDUwHZYS5b5WSmKCHrU7AyivFG5oLkrL-ewb3IjoQyUouDgZO2T-3WEzBIJ9Uru1AcEDTaVsRzHrukUfto8=@pm.me>
References: <20241111070152.9781-1-mcpratt@pm.me>
	<20241111070152.9781-2-mcpratt@pm.me>
	<20241112103438.57ab1727@gandalf.local.home>
	<e3Nl9UdWoWuPJauA6X3vNj71jDUwHZYS5b5WSmKCHrU7AyivFG5oLkrL-ewb3IjoQyUouDgZO2T-3WEzBIJ9Uru1AcEDTaVsRzHrukUfto8=@pm.me>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 00:13:13 +0000
Michael Pratt <mcpratt@pm.me> wrote:

> >
> > Why is stable Cc'd?
> >  
> 
> I believe this should be backported, if accepted,
> so that the behavior between kernel versions is matching.

That's not the purpose of stable. In fact, I would argue that it's the
opposite of what stable is for. A stable kernel should *not* change
behavior as that can cause regressions. If you want the newest behavior,
then you should use the newest kernels.


> I can do:
> 
>   $ cat /proc/$$/sched
> 
> and see the 120 without needing interpretation
> due to it being represented in a different way.

True it is exposed via files, but wouldn't this be the first change to make
it visible via a system call?

> 
> 
> > That said, you are worried about the race of spawning a new task and
> > setting its nice value because the new task may have exited. What about
> > using pidfd? Create a task returning the pidfd and use that to set its nice
> > value.  
> 
> I read a little about pidfd, but I'm not seeing the exact connection here,
> perhaps it will reduce the race condition but it cannot eliminate it as far as I see.
> For example, I am not finding a function that uses it to adjust niceness.

We can always add a system call do to that ;-)  In fact, there's a lot of
system calls that need to be converted to use pidfd over pid.

> 
> It's not that the "exit before modify" race condition is the only concern,
> it's just one of the less obvious factors making up my rationale for this change.
> I'm also concerned with efficiency. Why do we need to call another syscall
> if the syscall we are already in can handle it?
> 
> Personally, I find it strange that in sched_setscheduler()
> the policy can be changed but not the priority,
> when there is a standardized function dedicated to just that.

My concern is the man page that has (in Debian):

 $ man sched_setscheduler
[..]
       Currently, Linux supports the following "normal" (i.e., non-real-time) scheduling policies as values that may be specified in policy:

       SCHED_OTHER   the standard round-robin time-sharing policy;

       SCHED_BATCH   for "batch" style execution of processes; and

       SCHED_IDLE    for running very low priority background jobs.

       For each of the above policies, param->sched_priority must be 0.

Where we already document that the sched_priority "must be 0".

> 
> The difference between RT and normal processes
> is simply that for normal processes, we use "niceness" instead,
> so this patch simply translates the priority to "niceness",
> which cannot be expressed separately with the relevant POSIX functions.

I agree that POSIX has never been that great, but instead of modifying an
existing documented system call to do something that is documented not to
do, I believe we should either use other existing system calls or make a
new one.

-- Steve

