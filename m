Return-Path: <stable+bounces-107898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532F3A04ACC
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE7E166036
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8861F3D29;
	Tue,  7 Jan 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDZfF3hV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55212B93
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281049; cv=none; b=DUtV/cO7PTKwfOY1ITDH/LU21/TEvZhF3yqUI6b+lpURqRd2KgtL9qLnB8kDKo5iQHgZ+mXO/vR99WqwarYG6qy4QiB7uqoG2ysUAj/5xVnHrJvHRYWu7bJF1t/P3QTlCWdg8t+U1RMaMEu70BP+0F3nP0ornSztUm2eZA8fZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281049; c=relaxed/simple;
	bh=PAjg8nqUq6WqAipmolWwo+9f3Jfz/tXenqm25O1YPZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhcfTokT9SKHR6yJKk0UlUEbkzU1HuPnkioj19PD9Ea9waYDp3AJRN2mmigvOnASrsLppranGx+cywYhvVEmdB1UjZzSPiAvOL7dAVoxR7UReY995ImBT+qJpNv1gthypbjUGG5M6yONKy/OPEnejmzJ1P+v9tQ7sN3OLuDXVXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDZfF3hV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467a3f1e667so94352641cf.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 12:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736281045; x=1736885845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvqe1PC/G3IaqYSQdQJ+R7eS0VozXBmHvJNCzQEjWOc=;
        b=fDZfF3hVQtPp1Myz8+YbT9E58H/8hndQoWotGy+drL9yA8X4Y6IPODICv0YBhO+4Se
         /93vVTRPenknfpMeWLIGSQq98h2qJFgFiIgHvtdrMOqWqi8YxfJuEc4ZEiuABh0XuOTT
         YiXYrR2mitTXozAyXyhil/ZsGRmZdpb5hzPnDITJahhTPv96UTanw8tMOgtCQPgl3emB
         AAsJz+FMEPadvDoUVBfxwnv6NkYMg/tMrlrOcY3jyeUjpEISc252g7gJZa0sJqWB0lYX
         enSZG0UEzyg8vFDEMWRz1yXz93k/YWyvZ8OFqUOA4op2INOhDyBXANqZb/MjLMtsdenE
         rBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736281045; x=1736885845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvqe1PC/G3IaqYSQdQJ+R7eS0VozXBmHvJNCzQEjWOc=;
        b=SlYKiAFcJ3vbOuE28vy9EY8eB4hNhKo1VbHW4i/VYX5hIceVsbBPqk/wvgVnU4h79b
         sORxu6z0iXzGDx1c4bbJ3LLV1vZIxMIS6PZKSnC+gUuBPCfKT8/gz35OzSwjv0aPPOSX
         mAs8GZXfYoMm1Kb5MeqtQZMbqrfn3mL+dMOApVhxIJMIlL+JNPlxNbSdspmOXZw9ekYA
         G8rlRU3K3jxlJhGIUMLAz3iw7Cdyf6lkcwH4zvPwuvthms90rbTGAgYbQ80gvL5+EVOg
         y9JUUGX/CPWkUjGMo847+aj7+AZm4rQk7LZijG22easAxhx3PgsbEP7vvyqt3anyGIXE
         kFbA==
X-Forwarded-Encrypted: i=1; AJvYcCUX7g3iMYXWLvM5iF3FCjLXbwJXpg7MMWoMXIz/Bies/o0X7xnA1EmII1jPyo1BjtBiRhkb1U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlz0P3MzBlON7AjRGe859SUmWpPQJ+DtXap2eTs4CMsYp8QnKJ
	GRWV9GSTBFmboM3VlnQ7b++itsHrK0dU1tqYYF7fMOAX448IWc6kI/jDtbA5oRPjQ6RY0OZ/oYh
	WKcZ04Dlo8LAPV/nuKKzN94I/pGWE1yHH2UHO
X-Gm-Gg: ASbGncsJKOQEGay18cv63jgsnpkINBPgQ15I36CxGxUyG1f3vxRrrVM6nQYH8wBZ4Et
	wZM6x7NcKBC5etn8khclsF+jWNsTqNlPE7o7Yis+OcZ80A5appmKw40S8CYeBenk8sAg=
X-Google-Smtp-Source: AGHT+IHOlbU5xytV1QZ1QdFWKgLei0GKmFJDuvjy5ycmQswyGFlT/hcDvf1+Km1IHbTITrw5X34E/o64bLQMikjR+jE=
X-Received: by 2002:a05:6214:1313:b0:6d8:a7f7:c3a1 with SMTP id
 6a1803df08f44-6df9b2e71afmr6705226d6.40.1736281044696; Tue, 07 Jan 2025
 12:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107074724.1756696-1-yosryahmed@google.com>
 <20250107074724.1756696-2-yosryahmed@google.com> <20250107180345.GD37530@cmpxchg.org>
 <CAJD7tkYNvyVh2ETdbHrmtJRzKwVX3pPvite+cy0aS6cwJe5ePw@mail.gmail.com>
In-Reply-To: <CAJD7tkYNvyVh2ETdbHrmtJRzKwVX3pPvite+cy0aS6cwJe5ePw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 12:16:48 -0800
X-Gm-Features: AbW1kvbV4tcEHZ7JvQg_yo9txrH78u1aichCSuxgH_Q_va6juVYqGkoVkLNf3KY
Message-ID: <CAJD7tkYhO7DAQTrmb1A2H_FsaExoa1fp+C8vQw0MmzkmM+KyUA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU hotunplug
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 10:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jan 7, 2025 at 10:03=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Tue, Jan 07, 2025 at 07:47:24AM +0000, Yosry Ahmed wrote:
> > > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of =
the
> > > current CPU at the beginning of the operation is retrieved and used
> > > throughout.  However, since neither preemption nor migration are disa=
bled,
> > > it is possible that the operation continues on a different CPU.
> > >
> > > If the original CPU is hotunplugged while the acomp_ctx is still in u=
se,
> > > we run into a UAF bug as the resources attached to the acomp_ctx are =
freed
> > > during hotunplug in zswap_cpu_comp_dead().
> > >
> > > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to=
 use
> > > crypto_acomp API for hardware acceleration") when the switch to the
> > > crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp wa=
s
> > > retrieved using get_cpu_ptr() which disables preemption and makes sur=
e the
> > > CPU cannot go away from under us.  Preemption cannot be disabled with=
 the
> > > crypto_acomp API as a sleepable context is needed.
> > >
> > > Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> > > per-acomp_ctx") increased the UAF surface area by making the per-CPU
> > > buffers dynamic, adding yet another resource that can be freed from u=
nder
> > > zswap compression/decompression by CPU hotunplug.
> > >
> > > There are a few ways to fix this:
> > > (a) Add a refcount for acomp_ctx.
> > > (b) Disable migration while using the per-CPU acomp_ctx.
> > > (c) Use SRCU to wait for other CPUs using the acomp_ctx of the CPU be=
ing
> > > hotunplugged. Normal RCU cannot be used as a sleepable context is
> > > required.
> > >
> > > Implement (c) since it's simpler than (a), and (b) involves using
> > > migrate_disable() which is apparently undesired (see huge comment in
> > > include/linux/preempt.h).
> > >
> > > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hard=
ware acceleration")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg=
.org/
> > > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > > Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2=
e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> > > ---
> > >  mm/zswap.c | 31 ++++++++++++++++++++++++++++---
> > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index f6316b66fb236..add1406d693b8 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -864,12 +864,22 @@ static int zswap_cpu_comp_prepare(unsigned int =
cpu, struct hlist_node *node)
> > >       return ret;
> > >  }
> > >
> > > +DEFINE_STATIC_SRCU(acomp_srcu);
> > > +
> > >  static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *=
node)
> > >  {
> > >       struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool=
, node);
> > >       struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_=
ctx, cpu);
> > >
> > >       if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > > +             /*
> > > +              * Even though the acomp_ctx should not be currently in=
 use on
> > > +              * @cpu, it may still be used by compress/decompress op=
erations
> > > +              * that started on @cpu and migrated to a different CPU=
. Wait
> > > +              * for such usages to complete, any news usages would b=
e a bug.
> > > +              */
> > > +             synchronize_srcu(&acomp_srcu);
> >
> > The docs suggest you can't solve it like that :(
> >
> > Documentation/RCU/Design/Requirements/Requirements.rst:
> >
> >   Also unlike other RCU flavors, synchronize_srcu() may **not** be
> >   invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
> >   periods make use of timers and the possibility of timers being
> >   temporarily =E2=80=9Cstranded=E2=80=9D on the outgoing CPU. This stra=
nding of timers
> >   means that timers posted to the outgoing CPU will not fire until
> >   late in the CPU-hotplug process. The problem is that if a notifier
> >   is waiting on an SRCU grace period, that grace period is waiting on
> >   a timer, and that timer is stranded on the outgoing CPU, then the
> >   notifier will never be awakened, in other words, deadlock has
> >   occurred. This same situation of course also prohibits
> >   srcu_barrier() from being invoked from CPU-hotplug notifiers.
>
> Thanks for checking, I completely missed this. I guess it only works
> with SRCU if we use call_srcu(), but then we need to copy the pointers
> to a new struct to avoid racing with the CPU getting onlined again.
> Otherwise we can just bite the bullet and add a refcount, or use
> migrate_disable() despite that being undesirable.
>
> Do you have a favorite? :)

I briefly looked into refcounting. The annoying thing is that we need
to handle the race between putting the last refcount in
zswap_compress()/zswap_decompress(), and the CPU getting onlined again
and re-initializing the refcount. One way to do it would be to put all
dynamically allocated resources in a struct with the same struct with
the new refcount, and use RCU + refcounts to allocate and free the
struct as a whole.

I am leaning toward just disabling migration for now tbh unless there
are objections to that, especially this close to the v6.13 release.

