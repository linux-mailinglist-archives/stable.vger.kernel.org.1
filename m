Return-Path: <stable+bounces-107920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B5A04D7C
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51953A381E
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5F1E570B;
	Tue,  7 Jan 2025 23:26:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69135192598;
	Tue,  7 Jan 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292393; cv=none; b=B3mjNJoS/C8SxtDbgMn/2136RKBvNfNzXlBTF6KU4eW35E0XqmFDkFFBTZh6d0EmEteDHw60qo4j+S94CVJdZ0vNXPXQfEJC6e7PsRQAgvCtQxVP8t/uE5GgsTy4D1CWtt3X8adiJ2WP7WmaSoNeVAzjj/DH1lM92tT5y4LtsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292393; c=relaxed/simple;
	bh=SMSR8myDSbTwG+Rg/LKuWmu+q9AVawS3rCMpJJPeMJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5bOrZZJLWrPrhXiIC+Q+IumIUUtA75Kw9BF3+IYykawBmIh78iqb+xNYR/SYirqf4CdA6yjnH+Bq5LBWsagcZNNCFQyhjGrNFSiOa4bdrPULu8vl+aJixibAhbhCSKVyUgf4pcDpMTqdUXi7C2aklqNuht9+KvxA/l7wq8oikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4aff04f17c7so206251137.0;
        Tue, 07 Jan 2025 15:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736292390; x=1736897190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTD+Bq3GZL1MxaBmfdHPIPo5L73mR014hM+07a3/nK0=;
        b=qpoc2NPnTky5+686zCMGwKgKO4TsOc85rRIxsPT8XIw5+VPuAfJJIgYpE7eviuxW/m
         etlnY00taAnzW5T4qprIYPpae8KJqLzYPuQmPAWr9tll602vWrGhd/vJ9D1YITe/MofE
         rI6JCT6xpLAwz/zISLtaM4QLS4nV6grQTUNiPYWFI3jcvErXDoDA57SzkKRK12R7yc9F
         IS3ly9x4uvwMfh3pDpJC8wm2K/4a/1tUHWrCyoOPZSUpYy07vRcc3mrUp2R1BBqN+fKC
         pWP2ZCAFTNdpSuzso2faMtY64hFG5UO9OwrRHn3R/e7fCx7lV87Z3ygGrvfNAPOnFYgp
         V2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6BOovKN1qLDDVPRcU0bID/XhDIHjSdR5mOJahF/LcEesBwS0D7zgvUKuu7IHupvfF6E15c6Lf/+fQ2I=@vger.kernel.org, AJvYcCXAKI9cSFcJzhdZkbreafHcuw60VS+FIrv5/3u55Z74caguQjrWw3EmoehrJXpKiGwatK1Bn7jy@vger.kernel.org
X-Gm-Message-State: AOJu0YySD+8vHZXJogMI04oEHe3OJf1pA7uCgvpgoBYUYFQUPEuZoXNN
	XDis50z9H8NS6XdPck8gBMbm8YH12mCJCCOaTckzK+tMEG3soygtsXtVAccztmY9B1p0c61nDKm
	WRCDTkZJAcCNbMKCw+QWw3V2bn/k=
X-Gm-Gg: ASbGncsHJSrIe+7eWyg5tXzpJOgUCyyajUI9xlQF07rp/7oShMAxs3qaHwnilQiI9oe
	hLTEK8w4AtQlFGutSkWXxKGNC2agF2BK2nJdOoZIoIxCkuyfpfBpt0sK+CWhX+lX/dsMjEM8=
X-Google-Smtp-Source: AGHT+IEaO4P+lfOXcwWKAGlMUPWE2nYgb7AHRUM5xHT6kKgWYGgYWQRC0h6RgnxpXsDDKr4gfX4uYJy0P+c1KyPDY0s=
X-Received: by 2002:a67:ce16:0:b0:4b1:f903:98d3 with SMTP id
 ada2fe7eead31-4b3c1e8395emr3138224137.7.1736292390220; Tue, 07 Jan 2025
 15:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <CAGsJ_4xN9=5cksaGPqh_6jyH-EJkw-DH1zwx81Kotqh85BJ+ZQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xN9=5cksaGPqh_6jyH-EJkw-DH1zwx81Kotqh85BJ+ZQ@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 8 Jan 2025 12:26:19 +1300
X-Gm-Features: AbW1kvajFZJVoNT-AJnBwcg3e84jtNCCXGQtsdHJS74CdUWcsjCqGgheefRSmAA
Message-ID: <CAGsJ_4yb03yo6So-8wZwcy2fa-tURRrgJ+P-XhDL-RHgg1DvVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:47=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, Jan 8, 2025 at 11:22=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
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
> > This cannot be fixed by holding cpus_read_lock(), as it is possible for
> > code already holding the lock to fall into reclaim and enter zswap
> > (causing a deadlock). It also cannot be fixed by wrapping the usage of
> > acomp_ctx in an SRCU critical section and using synchronize_srcu() in
> > zswap_cpu_comp_dead(), because synchronize_srcu() is not allowed in
> > CPU-hotplug notifiers (see
> > Documentation/RCU/Design/Requirements/Requirements.rst).
> >
> > This can be fixed by refcounting the acomp_ctx, but it involves
> > complexity in handling the race between the refcount dropping to zero i=
n
> > zswap_[de]compress() and the refcount being re-initialized when the CPU
> > is onlined.
> >
> > Keep things simple for now and just disable migration while using the
> > per-CPU acomp_ctx to block CPU hotunplug until the usage is over.
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
> >  mm/zswap.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb236..ecd86153e8a32 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, s=
truct hlist_node *node)
> >         return 0;
> >  }
> >
> > +/* Remain on the CPU while using its acomp_ctx to stop it from going o=
ffline */
> > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_=
ctx __percpu *acomp_ctx)
> > +{
> > +       migrate_disable();
>
> I'm not entirely sure, but I feel it is quite unsafe. Allowing sleep
> during migrate_disable() and
> migrate_enable() would require the entire scheduler, runqueue,
> waitqueue, and CPU
> hotplug mechanisms to be aware that a task is pinned to a specific CPU.
>
> If there is no sleep during this period, it seems to be only a
> runqueue issue=E2=80=94CPU hotplug can
> wait for the task to be unpinned while it is always in runqueue.
> However, if sleep is involved,
> the situation becomes significantly more complex.

After double-checking the scheduler's code, it seems fine. When a task is
scheduled out, __schedule() will set its allowable cpu by:

migrate_disable_switch(rq, prev);

static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
{
        struct affinity_context ac =3D {
                .new_mask  =3D cpumask_of(rq->cpu),
                .flags     =3D SCA_MIGRATE_DISABLE,
        };

        if (likely(!p->migration_disabled))
                return;

        if (p->cpus_ptr !=3D &p->cpus_mask)
                return;

        /*
         * Violates locking rules! see comment in __do_set_cpus_allowed().
         */
        __do_set_cpus_allowed(p, &ac);
}

while woken-up, the previous cpu will be selected:

/*
 * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
 */
static inline
int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
{

        lockdep_assert_held(&p->pi_lock);

        if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
                cpu =3D p->sched_class->select_task_rq(p, cpu, wake_flags);
        else
                cpu =3D cpumask_any(p->cpus_ptr);
         ...
}

Anyway, not an expert :-)  Hopefully, other experts can provide their
input to confirm whether sleeping during migrate_disable() is all good.

>
> If static data doesn't consume much memory, it could be the simplest solu=
tion.
>
> > +       return raw_cpu_ptr(acomp_ctx);
> > +}
> > +
> > +static void acomp_ctx_put_cpu(void)
> > +{
> > +       migrate_enable();
> > +}
> > +
> >  static bool zswap_compress(struct page *page, struct zswap_entry *entr=
y,
> >                            struct zswap_pool *pool)
> >  {
> > @@ -893,8 +905,7 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
> >         gfp_t gfp;
> >         u8 *dst;
> >
> > -       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> > -
> > +       acomp_ctx =3D acomp_ctx_get_cpu(pool->acomp_ctx);
> >         mutex_lock(&acomp_ctx->mutex);
> >
> >         dst =3D acomp_ctx->buffer;
> > @@ -950,6 +961,7 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
> >                 zswap_reject_alloc_fail++;
> >
> >         mutex_unlock(&acomp_ctx->mutex);
> > +       acomp_ctx_put_cpu();
> >         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
> >  }
> >
> > @@ -960,7 +972,7 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
> >         struct crypto_acomp_ctx *acomp_ctx;
> >         u8 *src;
> >
> > -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > +       acomp_ctx =3D acomp_ctx_get_cpu(entry->pool->acomp_ctx);
> >         mutex_lock(&acomp_ctx->mutex);
> >
> >         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > @@ -990,6 +1002,7 @@ static void zswap_decompress(struct zswap_entry *e=
ntry, struct folio *folio)
> >
> >         if (src !=3D acomp_ctx->buffer)
> >                 zpool_unmap_handle(zpool, entry->handle);
> > +       acomp_ctx_put_cpu();
> >  }
> >
> >  /*********************************
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >
>

Thanks
Barry

