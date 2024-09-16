Return-Path: <stable+bounces-76529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30597A7C4
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197542837E9
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4015855C;
	Mon, 16 Sep 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Q88ZGTyO"
X-Original-To: stable@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31939175AD;
	Mon, 16 Sep 2024 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514609; cv=none; b=hcBiptYHMyFKh1dUqFUeCp5sVzQDm6vP9C+b1ANoUpTzuY7T81mGbu+bBu3FZKVlXeCmlUkX8H+BGZSeNIB2cC0kv5mRLngFxHSnqW/soWfRqjFIlmmwvqRw0cEFK8Ng+I9tu8RZOiyZhqTLneWhrT4gA7cCRilMAjNmXEvp42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514609; c=relaxed/simple;
	bh=Y9BOtJsZrUeI/T4AT5kJOL8XvzIzRW7qwuR4PC7DwVk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEDfwufP5Rl7NkkZ2a4fCcYhrp58/n9QyVUx3TgwOD4Yf4W6sN5S9EmC6FjKkcUKoKScCR5G/BtAY2Df8Gw2xG1BAiv64UefEE9dYkKu8eHuY9xnRZvRaUMLe952otto7pvipMhyQtnVNNvmTHwAB77mnpLHYWpNzy7ml63kZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Q88ZGTyO; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726514604; x=1726773804;
	bh=EDMp3dBEF1fsOY4Eb5Xm0ct3qsgK0RLGRh03NwDR2vM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q88ZGTyOptWULxET/5DFyEx6n0krlC7ffgtql0DkqjMMEBK8mQAyldbQqbCUBSsoB
	 pTGc5FILZNEKuSmnJz/JmtstQMmvdBlaokkRQYd5bb3jKp4XwXytasW+7kx2ta+hJ2
	 1aJYhznrEEbtuEQ6zhRvdzG5UxKqj5+g+RTKci3ksKjIwFNqU9KKUQ3tJv0FKEo7nW
	 qoxFObG1YegUDN5j7yyH6s6NHS1pzQQt9dzM3VplE+AtJ790h/ZVH7725yaXMe7vIG
	 pZTUgrgr9Ei2kZajnu+YT5EXn1jPIVsc99Tx4j1KvvvfOFKK/437lkunHJqPXBhnl9
	 r/wsitoox+Gmg==
Date: Mon, 16 Sep 2024 19:23:19 +0000
To: Peter Zijlstra <peterz@infradead.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <e6KW_ypfbIVbenvwbBwGgnxX700e-A68oVmCn1pdJ0834U4wtIWXhh5zfHrQF2dvSL_Vc_heC4KZ0XRzNZ-w7QfF70W0epxCzpph55reOls=@pm.me>
In-Reply-To: <20240916111323.GX4723@noisy.programming.kicks-ass.net>
References: <20240916050741.24206-1-mcpratt@pm.me> <20240916111323.GX4723@noisy.programming.kicks-ass.net>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: c1a624c5731e80bb9e31a8274bfbd698f437c055
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Monday, September 16th, 2024 at 07:13, Peter Zijlstra <peterz@infradead.=
org> wrote:
>=20
> On Mon, Sep 16, 2024 at 05:08:49AM +0000, Michael Pratt wrote:
>=20
> > From userspace, spawning a new process with, for example,
> > posix_spawn(), only allows the user to work with
> > the scheduling priority value defined by POSIX
> > in the sched_param struct.
> >=20
> > However, sched_setparam() and similar syscalls lead to
> > __sched_setscheduler() which rejects any new value
> > for the priority other than 0 for non-RT schedule classes,
> > a behavior kept since Linux 2.6 or earlier.
>=20
>=20
> Right, and the current behaviour is entirely in-line with the POSIX
> specs.

I'm just mentioning this for context.
In this case, "in-line with POSIX specs" has nothing to do with
whether or not the feature works. POSIX says nothing about which policies
should be accepting which values or not and how they are processed.
Like many things, it is simply implementation-specific.

The current behavior is that it doesn't work, and I would like it to work.

> I realize this might be a pain, but why should we change this spec
> conforming and very long standing behavior?

The fact that the overall behavior is "very long standing" is a coincidence=
.
The code here conforms to the specs both before and after the patch,
and the difference is functionality.

In fact, I am not aiming to change
the exact behavior of "reject every priority value other than 0"
but rather work around that by translating it to niceness
so long as it is a valid range passed as the priority by the user.
This method is not just to maintain that priority must be 0, but I found it=
 necessary,
because if the syscall were allowed to change the static priority,
then a future change in the "niceness" value would theoretically allow the =
priority
to pass into the RT range for non-RT policies.

> Worse, you're proposing a nice ABI that is entirely different from the
> normal [-20,19] range.

Please take a closer look... The resulting niceness value is exactly that r=
ange.
  PRIO_TO_NICE([MAX_RT_PRIO,MAX_PRIO-1]) =3D [-20,19]

I am not writing this so that the value passed as a "priority" value should=
 be assumed
to be the "niceness" value instead by the user, but rather that the user sh=
ould
pass a value for "priority" that will actually result in that value,
but with the "niceness" adjusted instead,
as that is the user-specific method to effectively do the same thing.

The "niceness" value has no meaning in the world of POSIX, it only means so=
mething
in the world of Linux, and just like the translation from sched_param to sc=
hed_attr structs,
this is the place where we would translate priority to niceness.
Everything outside the internals of the kernel should be understood as the =
"actual" priority,
because POSIX is a userspace that doesn't acknowledge or understand the ker=
nel's ABIs,
not the other way around.

Otherwise, we have a confusing conflation between the meaning of the two va=
lues,
where a value of 19 makes sense for niceness, but is obviously invalid for =
priority
for SCHED_NORMAL, and a negative value makes sense for niceness, but is obv=
iously invalid
for priority in any policy.

Implementations of posix_spawn functions ask for the "priority",
and POSIX states that the value passed in with the sched_param struct shoul=
d be the "priority"
and that the usage is implementation-specific, not the other way around, wh=
ere
the meaning of the value would be implementation-specific, but the usage of=
 the value
would be clearly defined instead. I'm trying to stay in-line with the seman=
tics as well.

> Why do you feel this is the best way forward? Would not adding
> POSIX_SPAWN_SETSCHEDATTR be a more future proof mechanism?

New flags don't change the fact that the value will be rejected in the kern=
el,
unless I am misunderstanding what you mean...

I believe this is the simplest and the smallest possible change
that is conforming both to POSIX and the kernel's styling
in order to make posix_spawnattr_setschedparam()
work instead of _just_ being "conforming and compliant",
which like I said is a low requirement of "just reject all values".

Flags like POSIX_SPAWN_SETSCHEDATTR would be used at the library level
and we have no problems at the library level, except for Linux-only librari=
es
that have not implemented posix_spawnattr_setschedparam() because it curren=
tly fails.
Notably, the musl C library is an example of this, but that might change
if we finally add support for this.

It would be nice if POSIX would add a flag to specifically cater to linux,
however, that would likely require them to add the sched_attr struct defini=
tion
or replace the sched_param struct, and as we know things usually work the o=
ther way around.

Thanks for your time.

--
MCP

