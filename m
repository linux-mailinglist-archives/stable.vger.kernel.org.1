Return-Path: <stable+bounces-107886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF499A04905
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 19:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94527A258F
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F43197A7A;
	Tue,  7 Jan 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SA8P4zH/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0518D626
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273665; cv=none; b=YGl+1h51dNQ34hg/1jPU0Hz9xliie890OvP11clgPRd2a69ah+XsfVtUJ1pWXuWOvbCwwY97ditpA9zpI0K05NXhu4wMUyrNVAcCPs+p5i9etUYrNTImRy8ton2NDuTWw/71IQZVsyXmAfF5oNMb67BtG/jWnpfI00NlLaOc5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273665; c=relaxed/simple;
	bh=TZY0V5cBFipnp4J4gL6OBL46uim1mm12So+5jZb/py0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMmiACi5T6xgyCJJrlnfZIHjWEk2vcgD1d2iVkTjgxjapvR6JIVcJ+EoVwS6HjLGMq2IojoSm/GeeFPlflUaegRnRSEiBD2b3+ZfZ0COmjpUZf26gRkj88XcFeapKeVVSrnr/IRe/YDpH5mG4DuW4LySgiDCWgYsfJItlhK68Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SA8P4zH/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcc42b5e30so91866826d6.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736273661; x=1736878461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG61dw26vvXoPcjn2vS9jiBka5lWOF0xVLwsEZhkvY4=;
        b=SA8P4zH/pLaix3r6bl/yAEuyxpgjf0ESss1t9ii8NJHKlpw143m4qzk6GW6lYRWIvI
         L54oivTDZnSl2wg0P8cQlLwXdTd8IVTp1Ou72L/IEluatLiXnzmPAakfaptn0x+3pfup
         tZRJyv6X1YznXWir2SF5nrmTguSEntM9iBiabNAPVupNaOGtWT1Dsi51PUKglGE4EdiL
         BRR1CEThJpkcP25gnfETFkFh+Y5w0b2eFQkagw6orXla6ILpwXlgg9c3gzBz5hphaa5+
         8K4Q5c1onzE/wx1JOwoHS/mLKX1yCEcdIIgVQCuHFIsgM6zZKjx467HlKvMWvK3TBWcK
         CC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273661; x=1736878461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oG61dw26vvXoPcjn2vS9jiBka5lWOF0xVLwsEZhkvY4=;
        b=DBIz1Nyu3/8Dph+TqYnAqGmw4RifQgbTADZaQX2ODHdOXKOHiwC7DABl4BF+3CB7fe
         +Nw6WqQq/o/X8VpJJJdKIMycpCdAWg0z6MeH+EQ5HAT8kfQhpSaliv0oOxZfWl85dY9P
         Nknr0QhofHzAoa8VHJC5ql5+M8mct1MdnolEmTzbs982htdAwOhXjgz45gR7bZVSyTt3
         BS6CCqFXOk67bNi0JR5IuVqVQ3XrBk9KfJksRTAp7/aZshcHFzS/H1xTq2vfoCp7s45d
         4k2fkzUokTXYiZl2dqdW3lj0QOCn+E3hkl6DQQsDJ4Q0fbdOV/XFvBb/G3M5cfmxWxtr
         3MYg==
X-Forwarded-Encrypted: i=1; AJvYcCXuVEi1T29iWbUmPJ/7qh75SYzttOpCgvXUJUr72DT+bj3CWSJgyZ2X/O2khCVm/U9sfna5t0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+3+e1HeLFvPAUQhZzmROPZRoUKRVgsvbNlVDehHGRKams7UT
	yu1Ej7G7AH7bMWQwuRzWpME4u3ZEVOWnWO0vFoBT82KH5SKXz0BZX8DYzcPORIdW58x84JAiW3E
	AnIb/5qYVP/NAYqJjKU9IHysyBZkhsOSV9i18
X-Gm-Gg: ASbGncuyZNQjwFS9MC4ywORISm0xZDYfDzZnhwJ/pnImf8/IcCQ91a6DoVBbfN67VB0
	Fql2lewFpDxtwJB8yaIhesBEMbiJiwr4NSTYlgrIbO+CbuvfoHtgV0rXHISQ42BbJo0k=
X-Google-Smtp-Source: AGHT+IFV+lxuKL2KP92p5pI89yhB4KNGKqG5ib6N9eKaNVmY+2f0dzgmRVshSSL1WDV/rFTjSFFI7ui/PF6lHR2evOQ=
X-Received: by 2002:ad4:5bc3:0:b0:6d8:e5f4:b969 with SMTP id
 6a1803df08f44-6df9b1f4300mr607216d6.10.1736273661036; Tue, 07 Jan 2025
 10:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107074724.1756696-1-yosryahmed@google.com>
 <20250107074724.1756696-2-yosryahmed@google.com> <20250107180345.GD37530@cmpxchg.org>
In-Reply-To: <20250107180345.GD37530@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 10:13:44 -0800
X-Gm-Features: AbW1kvbDEG3OoD4yS1bJmqQIUzrjE3LTEH-Qw1MG0uO_F4UgZIN2Nh1JLId1D4I
Message-ID: <CAJD7tkYNvyVh2ETdbHrmtJRzKwVX3pPvite+cy0aS6cwJe5ePw@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU hotunplug
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 10:03=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jan 07, 2025 at 07:47:24AM +0000, Yosry Ahmed wrote:
> > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of th=
e
> > current CPU at the beginning of the operation is retrieved and used
> > throughout.  However, since neither preemption nor migration are disabl=
ed,
> > it is possible that the operation continues on a different CPU.
> >
> > If the original CPU is hotunplugged while the acomp_ctx is still in use=
,
> > we run into a UAF bug as the resources attached to the acomp_ctx are fr=
eed
> > during hotunplug in zswap_cpu_comp_dead().
> >
> > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to u=
se
> > crypto_acomp API for hardware acceleration") when the switch to the
> > crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
> > retrieved using get_cpu_ptr() which disables preemption and makes sure =
the
> > CPU cannot go away from under us.  Preemption cannot be disabled with t=
he
> > crypto_acomp API as a sleepable context is needed.
> >
> > Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> > per-acomp_ctx") increased the UAF surface area by making the per-CPU
> > buffers dynamic, adding yet another resource that can be freed from und=
er
> > zswap compression/decompression by CPU hotunplug.
> >
> > There are a few ways to fix this:
> > (a) Add a refcount for acomp_ctx.
> > (b) Disable migration while using the per-CPU acomp_ctx.
> > (c) Use SRCU to wait for other CPUs using the acomp_ctx of the CPU bein=
g
> > hotunplugged. Normal RCU cannot be used as a sleepable context is
> > required.
> >
> > Implement (c) since it's simpler than (a), and (b) involves using
> > migrate_disable() which is apparently undesired (see huge comment in
> > include/linux/preempt.h).
> >
> > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardwa=
re acceleration")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.o=
rg/
> > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7=
Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> > ---
> >  mm/zswap.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb236..add1406d693b8 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -864,12 +864,22 @@ static int zswap_cpu_comp_prepare(unsigned int cp=
u, struct hlist_node *node)
> >       return ret;
> >  }
> >
> > +DEFINE_STATIC_SRCU(acomp_srcu);
> > +
> >  static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *no=
de)
> >  {
> >       struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, =
node);
> >       struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ct=
x, cpu);
> >
> >       if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > +             /*
> > +              * Even though the acomp_ctx should not be currently in u=
se on
> > +              * @cpu, it may still be used by compress/decompress oper=
ations
> > +              * that started on @cpu and migrated to a different CPU. =
Wait
> > +              * for such usages to complete, any news usages would be =
a bug.
> > +              */
> > +             synchronize_srcu(&acomp_srcu);
>
> The docs suggest you can't solve it like that :(
>
> Documentation/RCU/Design/Requirements/Requirements.rst:
>
>   Also unlike other RCU flavors, synchronize_srcu() may **not** be
>   invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
>   periods make use of timers and the possibility of timers being
>   temporarily =E2=80=9Cstranded=E2=80=9D on the outgoing CPU. This strand=
ing of timers
>   means that timers posted to the outgoing CPU will not fire until
>   late in the CPU-hotplug process. The problem is that if a notifier
>   is waiting on an SRCU grace period, that grace period is waiting on
>   a timer, and that timer is stranded on the outgoing CPU, then the
>   notifier will never be awakened, in other words, deadlock has
>   occurred. This same situation of course also prohibits
>   srcu_barrier() from being invoked from CPU-hotplug notifiers.

Thanks for checking, I completely missed this. I guess it only works
with SRCU if we use call_srcu(), but then we need to copy the pointers
to a new struct to avoid racing with the CPU getting onlined again.
Otherwise we can just bite the bullet and add a refcount, or use
migrate_disable() despite that being undesirable.

Do you have a favorite? :)

