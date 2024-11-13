Return-Path: <stable+bounces-92888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CACCB9C690C
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 07:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2AEB257D0
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 06:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51501714BC;
	Wed, 13 Nov 2024 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UZDHGFXk"
X-Original-To: stable@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CABBA34;
	Wed, 13 Nov 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477911; cv=none; b=WSHghx9GHSI9V1GzemNnv/ESihEuBulzZz3tgTtk9huAnAcnhIWsbCh23BE0xiiCiM/L63/QbNKvntJdJXO7vrt1v4MnuZJubV4CgxaMsG1h57VsWkcbPkKY8Dt3miKs9gzTQZecHDMEgjHcUpd3VW7dhHB4TX8Zygloo1XrGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477911; c=relaxed/simple;
	bh=7mtgD3s0tW82nIHegBBOzw/xdRJucEFDdtfIp/VUw2E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkgJEOmQhW8wtgcvHDzJw+SbJIGwrEQNC2RM8q9K/B5Q4dkWqVHIuUMOZWFMJ7hjV5eYO3IPaWNSlqpSv+Y/Ys+n0dBLQnN8PsxspjdcCJAmGzpGcG0kK3KP+hqA2JTrySFiy23ZXnqPUVZqgvccdWWQHlAibgKEJJCg9ihe6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=UZDHGFXk; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1731477901; x=1731737101;
	bh=7mtgD3s0tW82nIHegBBOzw/xdRJucEFDdtfIp/VUw2E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UZDHGFXkDiFjjt9DIkTZLvptxE8k7aduHVfvUu63ThssQc6cXmrccJztvZkX3TOBI
	 wvpUWDbBnAsGmu4bqvQb4tdYe3QgcgD9fGCZhwvTpP5159/vlNAL2o1bu3ds6SEtFM
	 sLyc/S/NLg6WCSuwvFJUhAN8GBgPZnVub1WqP+kEz0n9KVmBgODf35n/h7HpweqWC9
	 Cl3tLcBXIPlC/cpCrXvnz3BDjINPZtI44fW1h+cWWMsAO3GT7XBeUTFTPtns86stVs
	 iRlXiORtJ+CHK1gLz3zN54T3Rsr+AuproRYYZGmE/ElRQMKd8frc22QCnJTYhiQ/C7
	 iMFImL08nRnfw==
Date: Wed, 13 Nov 2024 06:04:59 +0000
To: Steven Rostedt <rostedt@goodmis.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2 1/1] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <82xsONg6yQRk_uyZ0-JkTqF2OjxuM4J8IgoNm45Xc6IXAvtX2lPKYxffzZ9GrhIA1TPhpvFoHx9wqWaH3nQyKWRcBggGIsc_61rMDyfMrOE=@pm.me>
In-Reply-To: <20241112193617.169fefbc@gandalf.local.home>
References: <20241111070152.9781-1-mcpratt@pm.me> <20241111070152.9781-2-mcpratt@pm.me> <20241112103438.57ab1727@gandalf.local.home> <e3Nl9UdWoWuPJauA6X3vNj71jDUwHZYS5b5WSmKCHrU7AyivFG5oLkrL-ewb3IjoQyUouDgZO2T-3WEzBIJ9Uru1AcEDTaVsRzHrukUfto8=@pm.me> <20241112193617.169fefbc@gandalf.local.home>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: d077ebd46d303e7b250a212c42ee69ffd723dd5d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Hi again Steven,


On Tuesday, November 12th, 2024 at 19:36, Steven Rostedt <rostedt@goodmis.o=
rg> wrote:

>=20
>=20
> On Wed, 13 Nov 2024 00:13:13 +0000
> Michael Pratt mcpratt@pm.me wrote:
>=20
> > > Why is stable Cc'd?
> >=20
> > I believe this should be backported, if accepted,
> > so that the behavior between kernel versions is matching.
>=20
>=20
> That's not the purpose of stable. In fact, I would argue that it's the
> opposite of what stable is for. A stable kernel should not change
> behavior as that can cause regressions. If you want the newest behavior,
> then you should use the newest kernels.


Ok that's fair. I assumed that the backport policy would be similar in this=
 case
as it would be for downstream distributions. Maybe that's a bad assumption =
from me.


> > I can do:
> >=20
> > $ cat /proc/$$/sched
> >=20
> > and see the 120 without needing interpretation
> > due to it being represented in a different way.
>=20
>=20
> True it is exposed via files, but wouldn't this be the first change to ma=
ke
> it visible via a system call?

If the "it" means "the accepted range" then no, but if "it" means "the (pri=
ority + niceness) range"
then yes. I still don't see the impact of whatever number happens to get re=
turned.
You would have to explain to me whatever magical security implication you h=
ave in mind.

> > > That said, you are worried about the race of spawning a new task and
> > > setting its nice value because the new task may have exited. What abo=
ut
> > > using pidfd? Create a task returning the pidfd and use that to set it=
s nice
> > > value.
> >=20
> > I read a little about pidfd, but I'm not seeing the exact connection he=
re,
> > perhaps it will reduce the race condition but it cannot eliminate it as=
 far as I see.
> > For example, I am not finding a function that uses it to adjust nicenes=
s.
>=20
>=20
> We can always add a system call do to that ;-) In fact, there's a lot of
> system calls that need to be converted to use pidfd over pid.

We can also convert system calls to be fully functional instead of mostly f=
unctional.
I consider this a functionality gap, not just something annoying.

> > It's not that the "exit before modify" race condition is the only conce=
rn,
> > it's just one of the less obvious factors making up my rationale for th=
is change.
> > I'm also concerned with efficiency. Why do we need to call another sysc=
all
> > if the syscall we are already in can handle it?
> >=20
> > Personally, I find it strange that in sched_setscheduler()
> > the policy can be changed but not the priority,
> > when there is a standardized function dedicated to just that.
>=20
>=20
> My concern is the man page that has (in Debian):
>=20
> $ man sched_setscheduler
> [..]
> SCHED_OTHER the standard round-robin time-sharing policy;
>=20
> SCHED_BATCH for "batch" style execution of processes; and
>=20
> SCHED_IDLE for running very low priority background jobs.
>=20
> For each of the above policies, param->sched_priority must be 0.
>=20
>=20
> Where we already document that the sched_priority "must be 0".

I think we should all agree that documentation is a summary of development,
not the other way around. Not only that, but this is poor documentation.
The kernel is subject to change, imagine using the word "always"
for design decisions that are not standardized.
A more appropriate description would be
"for each policy, sched_priority must be within the range
provided by the return of [the query system calls]"
just as POSIX describes the relationship.

As far as I can see, the "must be 0" requirement is completely arbitrary,
or, if there is a reason, it must be a fairly poor one.
However, I do recognize that the actual static priority cannot change,
hence the adjustment to niceness instead is the obvious intention
to any attempt to adjust the priority on the kernel-side from userspace.

I consider this patch to be a fix for a design decision
that makes no sense when reading about the intended purpose
of these values, not that it's the only way to achieve the priority adjustm=
ent.
If anyone considers that something this simple should have been done alread=
y,
the fact that documentation would have to be adjusted should not block it.
Besides, a well-written program would already have been using
the functions that return the accepted range before executing
the sched_setscheduler() system call with a value that would be rejected.

Am I really the only one to read that you can't set the priority
with this system call when I can do it on the command line with the "nice" =
program
which uses a different system call, and ask "what's the point of this restr=
iction?"

> > The difference between RT and normal processes
> > is simply that for normal processes, we use "niceness" instead,
> > so this patch simply translates the priority to "niceness",
> > which cannot be expressed separately with the relevant POSIX functions.
>=20
>=20
> I agree that POSIX has never been that great, but instead of modifying an
> existing documented system call to do something that is documented not to
> do, I believe we should either use other existing system calls or make a
> new one.

Is a POSIX function going to allow me a way to decide which set of system c=
alls
will get used to process it? Again, a functionality gap exists
in functions that already exist and that gap would continue to exist...

This system call is not exactly allowing the user to do what POSIX says
its purpose is for when it's clearly capable of doing so.
I got it to work in about 8 LOC. Which set of documentations matters more?
To me, anything else is a workaround that leaves this system call
in an inconsistent state, instead, this is a solution.

--
MCP

