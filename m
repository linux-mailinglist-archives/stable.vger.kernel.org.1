Return-Path: <stable+bounces-92866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF69C6636
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 01:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3AA1B2AEE8
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DDA259C;
	Wed, 13 Nov 2024 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="gj0UekEJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1C2594
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.41.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457454; cv=none; b=Loi5JNVUHN/AhtZkHmndB9cpQayd3dPrHscJzxWB5iIgI/S1HcwTgTIebtgUnYE0BkNIJCvcht88TwZD7O92ilteIFu70x4ajB2JvdqMRTELC3X6qqU1/SVkwV49V5ygjXm0Xj7ppjnzskr6DZmsvlRh0bY33VCchV6HLEpwXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457454; c=relaxed/simple;
	bh=MJDf47TOYW1YN6F7TBIiBc75Bt2nOolRvavNCVdiJtk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGhY+fMBvX9BgybtsvXUuh/4P2zkFzNVm4BvshOTNC5p627FmieHSDWJ3giV9aVZF6O5wr1MnHZJP2dyZdEwMW16mAnzmrc8/YcznJfj848SZQczyCVxn/AS8eEJA3xE2z25651WNtJ3lRqXnam/TYWnoquLyq1l5zc9R47Pstc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=gj0UekEJ; arc=none smtp.client-ip=185.70.41.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1731456795; x=1731715995;
	bh=fSbs8l2zowDsl/8YJuBkgzb9UR0oNstgIihS1xriTus=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gj0UekEJagRT9IvfTy0QsGZkaTeo5FZ/gTsvVvqmu9KUs0S/U5SEKKzb/cYqDCceU
	 DvyYrjbGKriWaojo/vPph6MzaA8ypdfV/Rh4T5IWIB3yXreDkvzVKIpP4nAyLctTNG
	 bPcxwojnuH+K5gTaFcb98sAQNnuMlh5hpo4ejs8rYxWr/NtVnlaDkoXDYMNIicDiUw
	 v1imJlQ6+1BmdB+Q33EN1VA5zCbjKv/YIH5rwxHn5SMMduj4DUevyuFB7iX1u3m/Bu
	 TZaht5RXUL+wE/YLroXxikdzFpAkk5dHVE6WurFATCM5o/fWky7UO39DUaBSuZ0z1r
	 ZLlFRqlDGY/ZQ==
Date: Wed, 13 Nov 2024 00:13:13 +0000
To: Steven Rostedt <rostedt@goodmis.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2 1/1] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <e3Nl9UdWoWuPJauA6X3vNj71jDUwHZYS5b5WSmKCHrU7AyivFG5oLkrL-ewb3IjoQyUouDgZO2T-3WEzBIJ9Uru1AcEDTaVsRzHrukUfto8=@pm.me>
In-Reply-To: <20241112103438.57ab1727@gandalf.local.home>
References: <20241111070152.9781-1-mcpratt@pm.me> <20241111070152.9781-2-mcpratt@pm.me> <20241112103438.57ab1727@gandalf.local.home>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: a390714c42701537ec0b49afd91c23783d982d9a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Hi Steven, thanks for the reply,


On Tuesday, November 12th, 2024 at 10:34, Steven Rostedt <rostedt@goodmis.o=
rg> wrote:

> >
> > Cc: stable@vger.kernel.org # Apply to kernel/sched/core.c
>
>
> Why is stable Cc'd?
>

I believe this should be backported, if accepted,
so that the behavior between kernel versions is matching.


> > Signed-off-by: Michael C. Pratt mcpratt@pm.me
> > ---
> > kernel/sched/syscalls.c | 21 +++++++++++++++++++--
> > 1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> > index 24f9f90b6574..43eb283e6281 100644
> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -785,6 +785,19 @@ static int _sched_setscheduler(struct task_struct =
*p, int policy,
> > attr.sched_policy =3D policy;
> > }
> >
> > + if (attr.sched_priority > MAX_PRIO-1)
> > + return -EINVAL;
> > +
> > + /*
> > + * If priority is set for SCHED_NORMAL or SCHED_BATCH,
> > + * set the niceness instead, but only for user calls.
> > + */
> > + if (check && attr.sched_priority > MAX_RT_PRIO-1 &&
> > + ((policy !=3D SETPARAM_POLICY && fair_policy(policy)) || fair_policy(=
p->policy))) {
> > + attr.sched_nice =3D PRIO_TO_NICE(attr.sched_priority);
> > + attr.sched_priority =3D 0;
> > + }
>
>
> This really looks like a hack.

If you have what you would consider to be a "non-hack" fix
in order for standard function posix_spawnattr_setschedparam()
to be usable instead of always fail for non-RT processes, let me know...

Looking at the larger picture, because Linux translates the sched_param str=
uct
into the local sched_attr struct, and because of changes in history, there =
are several
caveats to be handled. This internal preparation function _sched_setschedul=
er()
is essentially only consisting of "hacks", except for the member copying be=
tween structs.

> Specifically that we are exposing how the
> kernel records priority to user space. That is the greater than
> MAX_RT_PRIO-1. 120 may be the priority the kernel sees on nice values, bu=
t
> it is not something that we should expose to user space system calls.

Is the default static priority value not already exposed, perhaps everywher=
e???
It's not a secret, but rather common knowledge that when observing a "nicen=
ess" of 0
or a "priority" of 20 as seen through common programs like "top", that
these values actually represent 120 as the real priority value, and that
the niceness value is a simple addition to the default for the final effect=
ive value.

Also, we have in newer kernel versions, maybe or maybe not dependent on con=
figuration,
the procfs object called "sched" which already shows the actual value.

I can do:

  $ cat /proc/$$/sched

and see the 120 without needing interpretation
due to it being represented in a different way.


> That said, you are worried about the race of spawning a new task and
> setting its nice value because the new task may have exited. What about
> using pidfd? Create a task returning the pidfd and use that to set its ni=
ce
> value.

I read a little about pidfd, but I'm not seeing the exact connection here,
perhaps it will reduce the race condition but it cannot eliminate it as far=
 as I see.
For example, I am not finding a function that uses it to adjust niceness.

It's not that the "exit before modify" race condition is the only concern,
it's just one of the less obvious factors making up my rationale for this c=
hange.
I'm also concerned with efficiency. Why do we need to call another syscall
if the syscall we are already in can handle it?

Personally, I find it strange that in sched_setscheduler()
the policy can be changed but not the priority,
when there is a standardized function dedicated to just that.

The difference between RT and normal processes
is simply that for normal processes, we use "niceness" instead,
so this patch simply translates the priority to "niceness",
which cannot be expressed separately with the relevant POSIX functions.


--
MCP

