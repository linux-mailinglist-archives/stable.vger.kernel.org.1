Return-Path: <stable+bounces-107953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E85A051E4
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 05:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058B3167590
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308D619EEBF;
	Wed,  8 Jan 2025 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qz7s69aT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474D19E96D
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736309683; cv=none; b=cKzE9KIoSaJ4xQBESxHyD7z7Hb8jWv2z5GHxS1ydSZEsl2LAc9+5IozxhGB31PX4YJOZOMe4YptB+byWu4u1UOskYNJDmCMW6A7xCSQ4kGXfm8JrY73dJiXPC5Vqb9MEdVi5VeV0KyxsZ5jBi36mx6NgNDIZEWChpWWUA8qYbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736309683; c=relaxed/simple;
	bh=KUSUx+rb+pkBASpM4cDYiI7xvE/3Xwoa330j0NtmUyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suVkd0jgcb82VrGHyYTYH/zQd2ptWWZ2i78Ai+v5B6kCqyOC/JfNZzelBm4giL68xeQgR6/Bm4OGqnLrY9HRccTr5qYxukn+17ZEiyZeY9LV6nP8s6EIgOVVWHgLvysEkPXqhycGie2n33AVeEQPXzNGXYo5OhD2kbzwgNL+PaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qz7s69aT; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e9586b82so1328587985a.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 20:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736309680; x=1736914480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R31pDW1Q9MlB4MqPshmRbuMgjuC8TTAY7ZPP2XACOUY=;
        b=Qz7s69aTKdKlXP66vwf2PtDw3vgZ0Aox1O9lNk62sOwjywq5Ch8wGJwcpK/Wc6dWT4
         Umv4ZbF/J7Q6Pq8ecDj9yxWQBoLrM767VxWrwMYVMyESmrf4/kCGTO2txt7NmoGIsLJc
         OskLYBNTdeb1RUQpLS1dUNcVw++FJv/5CnJ7ArUW2qM3rIEqjZV5Z9GsijfsR2QxojYX
         zWUIuGa9NJL2lj8ppgcfkqcpZufM8bc2m2N+ll8pMT5RMIJXw3X2h1VPiX94uLvJWQcA
         cCC2twI7KHYDg/Wk37OCwR3EMpnoly0hmKmd6XGSI9rEwD8vbf5DhJPdmtKQ/Rb0MIRU
         bR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736309680; x=1736914480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R31pDW1Q9MlB4MqPshmRbuMgjuC8TTAY7ZPP2XACOUY=;
        b=co++P4esFHx0VTtqzK/chl/PEhyUTIlS4lqTCgyF+468KT29SghRnYRGXV5jQx2VGi
         sCpUtbHUxpOvr0M2XEJsYhV7MD4Uq58uUmkFkSkZ8sHvSr0VYYAGLjip5CK7zw/yD9vB
         Psed5np7qMWU3rtvRwB0tCXF/K+jSjJFEaVYAyoCQBSMEN+IzOGb8LfE8tKtLeWD9V8U
         fZayuP9PdSEHidh5hGkf77fASdmokFkuSSSYG/jK4E1xEeigQ6UJVGGWQcyBJlyKHo+w
         oI3XYPcpTDW8t/x2GDbrhTSJVdeAHE6CB5dEVLrw4ktuoDjqgNOwhIrnVxh8x3nW6bO2
         ur+w==
X-Forwarded-Encrypted: i=1; AJvYcCWKAzAUPO0RlcOEeNFT0uyr2xS8RpJVzE+mZDZ+cvVTZhPkPSCMt3D989u+aR26ICztg6VjMSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFK4avz1b7pE5CgAKdJMEp6LzpaW+G+HT4wJxPsYEY3U5YsS5w
	zOQTm0/FzjKUebZHw+YMKhqUHlV8ku0K9DPjoJLluAMtuvt2An5iX47QxiBald9MZPhXRRWg5Bw
	aIhUw7aoIQk1OTuVo3LVZoaayJfijeDaf854KuZFlISwJgiq9rlnV
X-Gm-Gg: ASbGncs2kILMJ3Yw4UTP7y4FfFhy25wl8Gu/j2bSlSI8o36t/6j+efEkfLitBjthrNx
	Aq9EWyPXxeMYNUjMOS2tk/QfrkZzD9l8YZws=
X-Google-Smtp-Source: AGHT+IECFnRdIGy87ZmbOwzV6GoyM9JLzwrOwaRgGda8wpIbwy6GFgWZMIpgxue6wE6cCYG4ero7lP0npeYs1nqaxbQ=
X-Received: by 2002:ad4:5f0d:0:b0:6dd:d317:e0aa with SMTP id
 6a1803df08f44-6df9b1f6c82mr23929456d6.8.1736309679862; Tue, 07 Jan 2025
 20:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107074724.1756696-1-yosryahmed@google.com>
 <20250107074724.1756696-2-yosryahmed@google.com> <20250107180345.GD37530@cmpxchg.org>
 <CAJD7tkYNvyVh2ETdbHrmtJRzKwVX3pPvite+cy0aS6cwJe5ePw@mail.gmail.com>
 <CAJD7tkYhO7DAQTrmb1A2H_FsaExoa1fp+C8vQw0MmzkmM+KyUA@mail.gmail.com> <CAKEwX=M_wTnd9yWf4yzjjgPEsjMFW-TAr_m_29YK4-tDE0UMpA@mail.gmail.com>
In-Reply-To: <CAKEwX=M_wTnd9yWf4yzjjgPEsjMFW-TAr_m_29YK4-tDE0UMpA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 20:14:03 -0800
X-Gm-Features: AbW1kvYo53HhZssyW2ItGi-bQfGp9y6AHV5XnIZy1rVs6GqiqRe1qKuCcv9a9HI
Message-ID: <CAJD7tkZffK+05e8fLnUWFA0+2AsJKf9xjEKFoX4mgyFxqd5rSQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU hotunplug
To: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, 
	Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 7:56=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Wed, Jan 8, 2025 at 3:17=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Tue, Jan 7, 2025 at 10:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Tue, Jan 7, 2025 at 10:03=E2=80=AFAM Johannes Weiner <hannes@cmpxc=
hg.org> wrote:
> > > >
> > > > On Tue, Jan 07, 2025 at 07:47:24AM +0000, Yosry Ahmed wrote:
> > > > > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx=
 of the
> > > > > current CPU at the beginning of the operation is retrieved and us=
ed
> > > > > throughout.  However, since neither preemption nor migration are =
disabled,
> > > > > it is possible that the operation continues on a different CPU.
> > > > >
> > > > > If the original CPU is hotunplugged while the acomp_ctx is still =
in use,
> > > > > we run into a UAF bug as the resources attached to the acomp_ctx =
are freed
> > > > > during hotunplug in zswap_cpu_comp_dead().
> > > > >
> > > > > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: mov=
e to use
> > > > > crypto_acomp API for hardware acceleration") when the switch to t=
he
> > > > > crypto_acomp API was made.  Prior to that, the per-CPU crypto_com=
p was
> > > > > retrieved using get_cpu_ptr() which disables preemption and makes=
 sure the
> > > > > CPU cannot go away from under us.  Preemption cannot be disabled =
with the
> > > > > crypto_acomp API as a sleepable context is needed.
> > > > >
> > > > > Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer t=
o
> > > > > per-acomp_ctx") increased the UAF surface area by making the per-=
CPU
> > > > > buffers dynamic, adding yet another resource that can be freed fr=
om under
> > > > > zswap compression/decompression by CPU hotunplug.
> > > > >
> > > > > There are a few ways to fix this:
> > > > > (a) Add a refcount for acomp_ctx.
> > > > > (b) Disable migration while using the per-CPU acomp_ctx.
> > > > > (c) Use SRCU to wait for other CPUs using the acomp_ctx of the CP=
U being
> > > > > hotunplugged. Normal RCU cannot be used as a sleepable context is
> > > > > required.
> > > > >
> > > > > Implement (c) since it's simpler than (a), and (b) involves using
> > > > > migrate_disable() which is apparently undesired (see huge comment=
 in
> > > > > include/linux/preempt.h).
> > > > >
> > > > > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for =
hardware acceleration")
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmp=
xchg.org/
> > > > > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > > > > Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD=
5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> > > > > ---
> > > > >  mm/zswap.c | 31 ++++++++++++++++++++++++++++---
> > > > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index f6316b66fb236..add1406d693b8 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -864,12 +864,22 @@ static int zswap_cpu_comp_prepare(unsigned =
int cpu, struct hlist_node *node)
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > +DEFINE_STATIC_SRCU(acomp_srcu);
> > > > > +
> > > > >  static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_no=
de *node)
> > > > >  {
> > > > >       struct zswap_pool *pool =3D hlist_entry(node, struct zswap_=
pool, node);
> > > > >       struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->ac=
omp_ctx, cpu);
> > > > >
> > > > >       if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > > > > +             /*
> > > > > +              * Even though the acomp_ctx should not be currentl=
y in use on
> > > > > +              * @cpu, it may still be used by compress/decompres=
s operations
> > > > > +              * that started on @cpu and migrated to a different=
 CPU. Wait
> > > > > +              * for such usages to complete, any news usages wou=
ld be a bug.
> > > > > +              */
> > > > > +             synchronize_srcu(&acomp_srcu);
> > > >
> > > > The docs suggest you can't solve it like that :(
> > > >
> > > > Documentation/RCU/Design/Requirements/Requirements.rst:
> > > >
> > > >   Also unlike other RCU flavors, synchronize_srcu() may **not** be
> > > >   invoked from CPU-hotplug notifiers, due to the fact that SRCU gra=
ce
> > > >   periods make use of timers and the possibility of timers being
> > > >   temporarily =E2=80=9Cstranded=E2=80=9D on the outgoing CPU. This =
stranding of timers
> > > >   means that timers posted to the outgoing CPU will not fire until
> > > >   late in the CPU-hotplug process. The problem is that if a notifie=
r
> > > >   is waiting on an SRCU grace period, that grace period is waiting =
on
> > > >   a timer, and that timer is stranded on the outgoing CPU, then the
> > > >   notifier will never be awakened, in other words, deadlock has
> > > >   occurred. This same situation of course also prohibits
> > > >   srcu_barrier() from being invoked from CPU-hotplug notifiers.
> > >
> > > Thanks for checking, I completely missed this. I guess it only works
> > > with SRCU if we use call_srcu(), but then we need to copy the pointer=
s
> > > to a new struct to avoid racing with the CPU getting onlined again.
> > > Otherwise we can just bite the bullet and add a refcount, or use
> > > migrate_disable() despite that being undesirable.
> > >
> > > Do you have a favorite? :)
> >
> > I briefly looked into refcounting. The annoying thing is that we need
> > to handle the race between putting the last refcount in
> > zswap_compress()/zswap_decompress(), and the CPU getting onlined again
> > and re-initializing the refcount. One way to do it would be to put all
> > dynamically allocated resources in a struct with the same struct with
> > the new refcount, and use RCU + refcounts to allocate and free the
> > struct as a whole.
> >
> > I am leaning toward just disabling migration for now tbh unless there
> > are objections to that, especially this close to the v6.13 release.
>
> I much prefer the refcounting solution. IMO it's the "proper" fix -
> disabling migration is such a heavy-handed resolution. A massive
> hammer for a tiny nail, so to speak.

I may have found a simpler "proper" fix than disabling migration,
please see my suggestion in:
https://lore.kernel.org/lkml/CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMW=
WQRzQ@mail.gmail.com/

>
> Is this a frequently occured problem in the wild? If so, we can
> disable migration to firefight, and then do the proper thing down the
> line.

I don't believe so. Actually, I think the deadlock introduced by the
previous fix is more problematic than the UAF it fixes.

Andrew, could you please pick up patch 1 (the revert) while we figure
out the alternative fix? It's important that it lands in v6.13 to
avoid the possibility of deadlock. Figuring out an alternative fix is
less important.

