Return-Path: <stable+bounces-192949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42BC46955
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88BA7346B00
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE33093C0;
	Mon, 10 Nov 2025 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q7U64OrC"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F823074A4;
	Mon, 10 Nov 2025 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777652; cv=none; b=HsvO3hnO4gqPgudsJTpulGEj2JmuCiYbwBvrm64bSN4jR4JQXultj+tXLO0S2/VzfUu4vGhBZ/cfSZhF5kj5tc++wTMivbtyHtdagqvF6Fi4//LSzlPEavPfXYipfQl5VzLxW4NTnQifCREQx5CBXOCFLUFI4O/oHJrLuax2XWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777652; c=relaxed/simple;
	bh=OluR4qlAsJGnyBbr5nbLn6bJaho1dPs8DYPCyR2BOZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwKJ9sOnRWxKNNrpqVXobyAdZdKdrIHWoRu+s6RafradjpbN18IgGlNYycpEIFkfMw2t3W1OqixcI9GrsegWf46adMcVqHdpkITMFc7hcWKOzgmQqt8ueGxFNq4dHkkpSZiEz7kczKgcy4KGNa5CUEhl69n/+/fDtSLz+yFrMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=q7U64OrC; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d4pp62ZP6z9sZK;
	Mon, 10 Nov 2025 13:27:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762777646; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkOaaHIMGk9UXd9PysO+xnD+1NY6zxXdnR5dibctYK4=;
	b=q7U64OrCQ6SP5GwztZr7As/sutzLMcncZTj2+p8GQzPUZ0fz0rfKeofItHDiGWI10b2GK9
	eet+WPxxdKVvRKy6d5MxnZSIfOg7blYv4dAyaDJloQ5kc3S7omboj/qHCyi2sNkKdj9s5h
	vpi5HdW7mwTWGy0JoP8eJRQZaJfjhqQ+Q5quF3GXoXXvYuHEIWxlyAu6iboLTRKtn3Mxwk
	KWHC8ye9DO2WSDDAL5NsOF8mIzbxaDOk+I2fhqp4gYE90sM10ZnlHK7kRKXoMmL/f5Hohj
	3SjjRGD2zZCfsxLtPoZ2KIYrTWnUslxdc/W2I8j05jBAKE6XMIvCgTdmnmP68w==
Message-ID: <ee9fe54f3764bc0ee4ebafe5c10ad4afe748ef19.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Fix UB in spsc_queue
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>,  Alex Deucher <alexander.deucher@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>, dakr@kernel.org,  Matthew Brost
 <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 10 Nov 2025 13:27:22 +0100
In-Reply-To: <ee63ca7d-77d2-44d8-973b-7276f8c4d4a5@amd.com>
References: <20251110081903.11539-2-phasta@kernel.org>
	 <ee63ca7d-77d2-44d8-973b-7276f8c4d4a5@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: yym999e4w6zw6ids5baho78ff6dxdnyi
X-MBO-RS-ID: 6901f3429aa461d8c9a

Please don't top-post :(
FDFY:


> On 11/10/25 09:19, Philipp Stanner wrote:
> > The spsc_queue is an unlocked, highly asynchronous piece of
> > infrastructure. Its inline function spsc_queue_peek() obtains the head
> > entry of the queue.
> >=20
> > This access is performed without READ_ONCE() and is, therefore,
> > undefined behavior. In order to prevent the compiler from ever
> > reordering that access, or even optimizing it away, a READ_ONCE() is
> > strictly necessary. This is easily proven by the fact that
> > spsc_queue_pop() uses this very pattern to access the head.
> >=20
> > Add READ_ONCE() to spsc_queue_peek().
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v4.16+
> > Fixes: 27105db6c63a ("drm/amdgpu: Add SPSC queue to scheduler.")
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > I think this makes it less broken, but I'm not even sure if it's enough
> > or more memory barriers or an rcu_dereference() would be correct. The
> > spsc_queue is, of course, not documented and the existing barrier
> > comments are either false or not telling.
> >=20
> > If someone has an idea, shoot us the info. Otherwise I think this is th=
e
> > right thing to do for now.
> >=20
> > P.
> > ---
> > =C2=A0include/drm/spsc_queue.h | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/drm/spsc_queue.h b/include/drm/spsc_queue.h
> > index ee9df8cc67b7..39bada748ffc 100644
> > --- a/include/drm/spsc_queue.h
> > +++ b/include/drm/spsc_queue.h
> > @@ -54,7 +54,7 @@ static inline void spsc_queue_init(struct spsc_queue =
*queue)
> > =C2=A0
> > =C2=A0static inline struct spsc_node *spsc_queue_peek(struct spsc_queue=
 *queue)
> > =C2=A0{
> > - return queue->head;
> > + return READ_ONCE(queue->head);
> > =C2=A0}

On Mon, 2025-11-10 at 12:24 +0100, Christian K=C3=B6nig wrote:
> As far as I can see that is not correct or rather not complete.

It cannot be incorrect by definition, because it simply ensures that
the load will actually take place there.

Incomplete it can be.

>=20
> The peek function should only be used to opportunistically look at the to=
p of the queue. It would only be problematic if it returns a non NULL value=
 once and then a NULL value later.
>=20
> The whole idea of the SPSC is that it is barrier-free and the signaling o=
f new entries to the consumer side is providing the barrier.
>=20
> So basically on the provider side you have
> spsc_push(entry)
> wake_up(consumer)
>=20
> And on the consumer side you have:
>=20
> woken_up_by_provider() {
>  entry =3D spsc_peek();
>  ...
>  spsc_pop();
> }

Well no, the scheduler can pick up the next job whenever it feels like
it. Restarting it for example will have it peek into your queue,
regardless of wake events.

In any case this is a highly fragile design. See below, too.


>=20
> The problem we are facing here is that the spsc only provides the guarant=
ee that you see the entry pointer, but not the content of entry itself.
>=20
> So use cases like:
>=20
> woken_up_by_provider() {
>  while (entry =3D spsc_peek()) {
>  ...
>  spsc_pop();
>  }
> }
>=20
> Are illegal since you don't have the correct memory barriers any more.

I can't follow. Are you saying that spsc_queue_peek() is correct
because you know for sure that when it's used no one else might be
changing that pointer?

Even if that were true this design is highly fragile.

>=20
> Took me an eternity to understand that as well, so bear with me that I di=
dn't previously explained that.

s/explain/document :)

As discussed few weeks ago with Sima and Tvrtko, what we really need to
move to in all of DRM is this development pattern:

   1. For parallel code, at first by default use a boring, horribly
      slow (sarcasm) spinlock. BTW I'm not even convinced that a
      spinlock is slower than lockless tricks. Paul's book states that
      a CAS atomic instruction takes about 60 cycles, and taking a lock
      takes 100.
   2. If you want to do parallelism without locks, you need to justify
      it really well. "rmb() so list_empty() works without a lock"
      doesn't qualify, but real use case speedups.
   3. If you write lockless infrastructure, you need to document it
      really well. In particular you need to state:
         1. How it works
         2. What the rules are

See llist.h as an example. It clearly states when you need a lock and
when you don't. Or RCU. No one could use it without such good
documentation.

I have no idea whether spsc_queue is correctly implemented (I doubt
it), and if even a highly experienced dev like you takes "an eternity"
(quote) to understand it, one is really tempted to dream of spinlock_t,
which has very clear semantics and is easily understood even by
beginners.

>=20
> Question is what should we do?

Easy!

Mid-term, we should replace spsc_queue with a boring, locked, super-
slow linked list ^_^

The spsc_queue was designed and =E2=80=93 perhaps =E2=80=93 perf-measured w=
hen RR was
the only scheduling policy.

Since the FIFO rework, where FIFO became the default policy, we now
access our super efficient super fast lockless queue most of the time
with the spinlock being taken immediately afterwards anyways. So we
almost have a locked lockless queue now.

https://elixir.bootlin.com/linux/v6.18-rc4/source/drivers/gpu/drm/scheduler=
/sched_entity.c#L502


Only push_job() often (?) still runs locklessly, but I'm not at all
convinced that this is worth it. Not even performance-wise.

If you look at spsc_queue_push() you see that it
   1. disables preemption,
   2. uses atomic instructions and
   3. has a ton of memory barries

=E2=80=93 in other words, this is almost literally a manual re-implementati=
on
of a spinlock, just without mutual exclusion=E2=80=A6


And even if something like spsc_queue would make sense and be actually
worth it, then it should be provided to the entire kernel as common
infrastructure, like llist.h, not hidden somewhere in DRM.

P.

