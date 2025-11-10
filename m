Return-Path: <stable+bounces-192962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6EC47229
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 15:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7D9420021
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FAB30F945;
	Mon, 10 Nov 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ggxltxj8"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6C31283E;
	Mon, 10 Nov 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784444; cv=none; b=ZYooYwCunw7vOTGkRTvx3mpdAV6bJkpuIX5GFvGVX8DV77/y7iSCUxEXPLu2+ApV/uVpij93hnDwOS1qXyDRIgjeeQTk//QjYh1+ZmYE4//jHTRcPp3PQP3xCMMoD0+riPUJYbrz3jYARV3WK2eiA+rkqFORK4bDAwyon8hKFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784444; c=relaxed/simple;
	bh=EB8tNfx1Zy6ebc+gWo7NGOtYG2YjS0C+JVqQDn+bYKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rssrSgfuvcCDzxSmqlnhmxy5FAzgn2YEqYh/kIRjPuLjO9bdocrMoYCtmOjaw9ytVjxtUlrL+DyPqZmvxFYPwxIxMJblWJ64hhLzc6CE5uPfgrqR65soLrftxyMvx4reoNcRRDmmart7piENOwfa3FWzuy9Ms/2KGWSWjOfTaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ggxltxj8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d4sJj1P3Rz9t4r;
	Mon, 10 Nov 2025 15:20:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762784437; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzrI50NK7ysms3OHHNUxqFiKISgLVQgzqUyvZok5jTc=;
	b=ggxltxj8RaEwPkdMsCpM7r9GQHo0bLCcdvgnavazc7LoJnrAD1Y86IAWQiWZY7QY1p4+uX
	qhPRhXawF+2BSFIc8TUQnattwhjd9EkPdP9l6x3yWdJVGkBbfMygrRwFrP+EyA6RE1mZOH
	dQHAnp8Mw+cCi3vE035XxdbTCN7krd5jIToTjxfHmXqSwJ7szMMJviacYQNNKnpzR2L4eH
	7uhhKYOIZrI18/dRWaGiq+itC5k1ZWsM0kGGOfSAwJTeG9JKK6QAMumDUzO92vv1r63+pG
	YEl7L9ZLQ69MIoWtlEbfXIHWvnCbIvmaRR1kGpsKhdZkXLLTP9PV/Dd+h1YLug==
Message-ID: <987527ead1fe93877139a9ee8b6d2ee55eefa1ee.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Fix UB in spsc_queue
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>, dakr@kernel.org, Matthew Brost
 <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 10 Nov 2025 15:20:31 +0100
In-Reply-To: <2c72eb6e-7792-4212-b06f-5300bc9a42f9@amd.com>
References: <20251110081903.11539-2-phasta@kernel.org>
	 <ee63ca7d-77d2-44d8-973b-7276f8c4d4a5@amd.com>
	 <ee9fe54f3764bc0ee4ebafe5c10ad4afe748ef19.camel@mailbox.org>
	 <2c72eb6e-7792-4212-b06f-5300bc9a42f9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: c4b97c98a309fb5b850
X-MBO-RS-META: ie9mosrj6whswkzn56nap6dg9hm9bbte

On Mon, 2025-11-10 at 15:07 +0100, Christian K=C3=B6nig wrote:
> On 11/10/25 13:27, Philipp Stanner wrote:
> > Please don't top-post :(
> > FDFY:
> >=20
> >=20
> > > On 11/10/25 09:19, Philipp Stanner wrote:
> > > > The spsc_queue is an unlocked, highly asynchronous piece of
> > > > infrastructure. Its inline function spsc_queue_peek() obtains the h=
ead
> > > > entry of the queue.
> > > >=20
> > > > This access is performed without READ_ONCE() and is, therefore,
> > > > undefined behavior. In order to prevent the compiler from ever
> > > > reordering that access, or even optimizing it away, a READ_ONCE() i=
s
> > > > strictly necessary. This is easily proven by the fact that
> > > > spsc_queue_pop() uses this very pattern to access the head.
> > > >=20
> > > > Add READ_ONCE() to spsc_queue_peek().
> > > >=20
> > > > Cc: stable@vger.kernel.org=C2=A0# v4.16+
> > > > Fixes: 27105db6c63a ("drm/amdgpu: Add SPSC queue to scheduler.")
> > > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > >=20
> > >=20

[=E2=80=A6]

> > > Are illegal since you don't have the correct memory barriers any more=
.
> >=20
> > I can't follow. Are you saying that spsc_queue_peek() is correct
> > because you know for sure that when it's used no one else might be
> > changing that pointer?
>=20
> Correct, yes. That's the whole idea. I mean SPSC stands for single produc=
er single consumer.
>=20

I know that it means that (although it's not documented and, funnily
enough, I one day realized the meaning while standing under the shower
after work).

Anyways, it's not documented that a user must not call
drm_sched_entity_push_job() in parallel. It currently basically just
works by the coincidence of no one doing that or rather no one running
into the race.

> >=20
> > Even if that were true this design is highly fragile.
> >=20
> > >=20
> > > Took me an eternity to understand that as well, so bear with me that =
I didn't previously explained that.
> >=20
> > s/explain/document :)
> >=20
> > As discussed few weeks ago with Sima and Tvrtko, what we really need to
> > move to in all of DRM is this development pattern:
> >=20
> > =C2=A0=C2=A0 1. For parallel code, at first by default use a boring, ho=
rribly
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 slow (sarcasm) spinlock. BTW I'm not eve=
n convinced that a
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock is slower than lockless tricks.=
 Paul's book states that
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a CAS atomic instruction takes about 60 =
cycles, and taking a lock
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 takes 100.
>=20
> The problem isn't the burned CPU cycles, but rather the cache lines moved=
 between CPUs.

Which cache lines? The spinlock's?

The queue data needs to move from one CPU to the other in either case.
It's the same data that is being moved with spinlock protection.

A spinlock doesn't lead to more cache line moves as long as there's
still just a single consumer / producer.

>=20
> Keep in mind that you can rather do a fused multiple add for a full 4x4 m=
atrix before you take a single cache line miss.
>=20
> > =C2=A0=C2=A0 2. If you want to do parallelism without locks, you need t=
o justify
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it really well. "rmb() so list_empty() w=
orks without a lock"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doesn't qualify, but real use case speed=
ups.
> > =C2=A0=C2=A0 3. If you write lockless infrastructure, you need to docum=
ent it
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 really well. In particular you need to s=
tate:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. How it works
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. What the rules are
> >=20
> > See llist.h as an example. It clearly states when you need a lock and
> > when you don't.
>=20
> The llist.h is actually pretty similar to the SPSC. I'm wondering why the=
y don't have the same issues? E.g. is xchg() providing the memory barriers?

I think that some atomic instructions contain barriers. But I'd have to
check.

>=20
>=20
> > Or RCU. No one could use it without such good
> > documentation.
> >=20
> > I have no idea whether spsc_queue is correctly implemented (I doubt
> > it), and if even a highly experienced dev like you takes "an eternity"
> > (quote) to understand it, one is really tempted to dream of spinlock_t,
> > which has very clear semantics and is easily understood even by
> > beginners.
> >=20
> > >=20
> > > Question is what should we do?
> >=20
> > Easy!
> >=20
> > Mid-term, we should replace spsc_queue with a boring, locked, super-
> > slow linked list ^_^
>=20
> That's what the scheduler started with and the reason why that linked lis=
t was replaced with first a KFIFO and than the SPSC was because of lacking =
performance.

Such performance measurements must be included in the commit message,
since they justify the entire commit.

Yet this is the entire justification given:

commit 27105db6c63a571b91d01e749d026105a1e63bcf
Author: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Date:   Thu Oct 12 16:41:39 2017 -0400

    drm/amdgpu: Add SPSC queue to scheduler.
   =20
    It is intended to sabstitute the bounded fifo we are currently
    using.
   =20
    Signed-off-by: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
    Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


>=20
> We could go back to the KFIFO design again, but a (double?) linked list i=
s clearly going to show the same performance problems which originally trig=
gered moving away from it.
>=20
> >=20
> > The spsc_queue was designed and =E2=80=93 perhaps =E2=80=93 perf-measur=
ed when RR was
> > the only scheduling policy.
> >=20
> > Since the FIFO rework, where FIFO became the default policy, we now
> > access our super efficient super fast lockless queue most of the time
> > with the spinlock being taken immediately afterwards anyways. So we
> > almost have a locked lockless queue now.
> >=20
> > https://elixir.bootlin.com/linux/v6.18-rc4/source/drivers/gpu/drm/sched=
uler/sched_entity.c#L502
>=20
> That is not that relevant.

If the lock being there is not relevant, then why can't we just take it
and get rid off all those barriers and READ_ONCE's once and for all?

>=20
> > Only push_job() often (?) still runs locklessly, but I'm not at all
> > convinced that this is worth it. Not even performance-wise.
>=20
> That is what is relevant. And yes the difference was totally measurable, =
that's why this was originally implemented.
>=20
> >=20
> > If you look at spsc_queue_push() you see that it
> > =C2=A0=C2=A0 1. disables preemption,
> > =C2=A0=C2=A0 2. uses atomic instructions and
> > =C2=A0=C2=A0 3. has a ton of memory barries
> >=20
> > =E2=80=93 in other words, this is almost literally a manual re-implemen=
tation
> > of a spinlock, just without mutual exclusion=E2=80=A6
>=20
> The problem is really to separate the push from the pop side so that as f=
ew cache lines as possible are transferred from one CPU to another.=20

With a doubly linked list you can attach at the front and pull from the
tail. How is that transferring many cache lines?


P.

