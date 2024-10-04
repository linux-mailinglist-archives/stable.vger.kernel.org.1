Return-Path: <stable+bounces-80763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CCF9907DD
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCE288291
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF0A1C3037;
	Fri,  4 Oct 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkjMnPlE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC21AA7A0;
	Fri,  4 Oct 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056152; cv=none; b=rs1hPVoJb68dgxZ3QoT3DTO0Ox9nWc6+gpXhBFk5jmquNj5GVixO9lS4ebQLAYgwPNl9n0vw77EkiwGB9vrK0Mg/9fB8l2dgH0jmpIm9sS5WQ61zzEZEa2QpSUC3U2uFJ+JYH+aEVQ7+gzm5mQhzVES6gj7wwQgyxO5235vhv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056152; c=relaxed/simple;
	bh=T+7P9RluBldf2chvXJKQ50NJ2y6fL/86RjwvDcsjh/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GO6Kr+jXmbgCzhlmw/7vsREX79aV8eQTzw8eDJxVwYPkqiOdZAak//TqAnKE186UZNLed6VKrd3ER/WrwdVZaKiuQqUVv9y0KK0/ncpmV4/OT8ihjb9aVV6VRtxY2KvTT/ewNpjOTIMpfgBKyD0MhBpiQYTRt1PiAyidg1EhJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkjMnPlE; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84e9893c457so768062241.2;
        Fri, 04 Oct 2024 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728056150; x=1728660950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw2sq7oLbYRyM54E/JZVt3qqEmIecjILj6ka5iJnvA8=;
        b=AkjMnPlEnSLq0uJMA9vlj1BzvZjxVsYlC3Qrbsvz6qWPSr8de3oSVytgKScxTvL6sL
         uL8p/dq9KuqfJO5rwr3VeuMdKjVVNRneIBV4d4x/iSTisxA0dBcU6MX4nQY6TDekraDl
         QA8MHmBqGMBPOx+OLVkEMA1YCMlDuBWw/KSBaEXxsKjBxBdTivXUeAuqSKOH/iZmY+GV
         ZriaNJzwrpMUE9Id5D6TOhGnL55Al/nN6LUjQmH0R2K0PHj9TTNMPNvVvzWlXPYTP/fP
         6QuMjvQWPM3uTnhMhjg8cgv90pwQVRh//Pft9+pQxiBBMh5cI6h1IYG12rl3oUdlX36B
         gdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728056150; x=1728660950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw2sq7oLbYRyM54E/JZVt3qqEmIecjILj6ka5iJnvA8=;
        b=fVHJUZ2JXsuj0ooLBzWg4oafCMxHe46Tzs/a9/U3DGfmRWgg6f8ZkPcjiPQe0KG2bA
         AumV2O0XHI+XmtAko50n9OAbtz+L5cK4ph8qy0y3bvposRR2q9QUo6j6F6HOHrzgS3Nx
         Vntg3e9MkHtqav8CrjYYXx1xt7FmEnr9QSNOeEuX6G2thccs1xzc0LeDQ4bkeevaCeYp
         LYT29VNh8Pz4qf4EllmeVo9m1vtSYsXK42WYd7m/ElAk0jVfwfHTOOEo2YRMkz/0jd3I
         O4qgm4n3IN2s/PA8AD5Jh3VsTvjcaJKY6LFHSseeQ9mJPwc4qn77q+W80rSl1EbcTDgG
         6E1A==
X-Forwarded-Encrypted: i=1; AJvYcCUOI1nysw5H9Cer9nwCp1YAuaeKx02o4LHA/ETkZZZyuISuQPSlZHZGGHPNI7stNxVNYO+kzmVh@vger.kernel.org, AJvYcCWkM9BGv6ARCwqJlynMAZOROtnfHmO86Aa/vQZtrl6Cuax5Z1RzXI7ejtFLfXX9wb3whoYZzb46XDdfSyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVBO/XPfSX0wcXv2RKYy2yJVl4NTyacz2ioiRFHMRG3xV1wyu
	KcKqRWYLy2lrYovlMROyyxudOKS8RsvFwYGrmHaYW9GLLC62A6chhHRtgQn+SzjKqgUIqf5AWjr
	ws/TM+aY3eOBCXSbmWXa5D8wST3s=
X-Google-Smtp-Source: AGHT+IEX6UhKKZvWjPQzKs3x120qKfcrb4jvMUBiNStNVz5nW9YCWNdPLZvRmnNxntvKi09plSGnjExnW8RMzBcETcs=
X-Received: by 2002:a05:6122:1829:b0:50a:b8c6:b689 with SMTP id
 71dfb90a1353d-50c854487abmr2562637e0c.3.1728056149818; Fri, 04 Oct 2024
 08:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20241002015754.969-1-21cnbao@gmail.com> <CANeU7Q=FkkMByY2DgtcZfn=UOAygzK7xLJKR4GUx+sdo-bxq9w@mail.gmail.com>
In-Reply-To: <CANeU7Q=FkkMByY2DgtcZfn=UOAygzK7xLJKR4GUx+sdo-bxq9w@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 4 Oct 2024 23:35:06 +0800
Message-ID: <CAGsJ_4wYcaYJS3f2FXi1L6wg4zznvgicGK5Gw+ZpcW4pwCQx5g@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: Chris Li <chrisl@kernel.org>
Cc: ying.huang@intel.com, akpm@linux-foundation.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liyangouwen1@oppo.com, mhocko@suse.com, minchan@kernel.org, sj@kernel.org, 
	stable@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 6:53=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Oct 1, 2024 at 6:58=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> > >
> > > Barry Song <21cnbao@gmail.com> writes:
> > >
> > > > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@inte=
l.com> wrote:
> > > >>
> > > >> Barry Song <21cnbao@gmail.com> writes:
> > > >>
> > > >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@=
intel.com> wrote:
> > > >> >>
> > > >> >> Hi, Barry,
> > > >> >>
> > > >> >> Barry Song <21cnbao@gmail.com> writes:
> > > >> >>
> > > >> >> > From: Barry Song <v-songbaohua@oppo.com>
> > > >> >> >
> > > >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcac=
he")
> > > >> >> > introduced an unconditional one-tick sleep when `swapcache_pr=
epare()`
> > > >> >> > fails, which has led to reports of UI stuttering on latency-s=
ensitive
> > > >> >> > Android devices. To address this, we can use a waitqueue to w=
ake up
> > > >> >> > tasks that fail `swapcache_prepare()` sooner, instead of alwa=
ys
> > > >> >> > sleeping for a full tick. While tasks may occasionally be wok=
en by an
> > > >> >> > unrelated `do_swap_page()`, this method is preferable to two =
scenarios:
> > > >> >> > rapid re-entry into page faults, which can cause livelocks, a=
nd
> > > >> >> > multiple millisecond sleeps, which visibly degrade user exper=
ience.
> > > >> >>
> > > >> >> In general, I think that this works.  Why not extend the soluti=
on to
> > > >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_a=
sync()
> > > >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To a=
void
> > > >> >
> > > >> > Hi Ying,
> > > >> > Thanks for your comments.
> > > >> > I feel extending the solution to __read_swap_cache_async() shoul=
d be done
> > > >> > in a separate patch. On phones, I've never encountered any issue=
s reported
> > > >> > on that path, so it might be better suited for an optimization r=
ather than a
> > > >> > hotfix?
> > > >>
> > > >> Yes.  It's fine to do that in another patch as optimization.
> > > >
> > > > Ok. I'll prepare a separate patch for optimizing that path.
> > >
> > > Thanks!
> > >
> > > >>
> > > >> >> overhead to call wake_up() when there's no task waiting, we can=
 use an
> > > >> >> atomic to count waiting tasks.
> > > >> >
> > > >> > I'm not sure it's worth adding the complexity, as wake_up() on a=
n empty
> > > >> > waitqueue should have a very low cost on its own?
> > > >>
> > > >> wake_up() needs to call spin_lock_irqsave() unconditionally on a g=
lobal
> > > >> shared lock.  On systems with many CPUs (such servers), this may c=
ause
> > > >> severe lock contention.  Even the cache ping-pong may hurt perform=
ance
> > > >> much.
> > > >
> > > > I understand that cache synchronization was a significant issue bef=
ore
> > > > qspinlock, but it seems to be less of a concern after its implement=
ation.
> > >
> > > Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
> > > discussed in the following thread.
> > >
> > > https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programmi=
ng.kicks-ass.net/
> > >
> > > > However, using a global atomic variable would still trigger cache b=
roadcasts,
> > > > correct?
> > >
> > > We can only change the atomic variable to non-zero when
> > > swapcache_prepare() returns non-zero, and call wake_up() when the ato=
mic
> > > variable is non-zero.  Because swapcache_prepare() returns 0 most tim=
es,
> > > the atomic variable is 0 most times.  If we don't change the value of
> > > atomic variable, cache ping-pong will not be triggered.
> >
> > yes. this can be implemented by adding another atomic variable.
> >
> > >
> > > Hi, Kairui,
> > >
> > > Do you have some test cases to test parallel zram swap-in?  If so, th=
at
> > > can be used to verify whether cache ping-pong is an issue and whether=
 it
> > > can be fixed via a global atomic variable.
> > >
> >
> > Yes, Kairui please run a test on your machine with lots of cores before
> > and after adding a global atomic variable as suggested by Ying. I am
> > sorry I don't have a server machine.
> >
> > if it turns out you find cache ping-pong can be an issue, another
> > approach would be a waitqueue hash:
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2366578015ad..aae0e532d8b6 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4192,6 +4192,23 @@ static struct folio *alloc_swap_folio(struct vm_=
fault *vmf)
> >  }
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > +/*
> > + * Alleviating the 'thundering herd' phenomenon using a waitqueue hash
> > + * when multiple do_swap_page() operations occur simultaneously.
> > + */
> > +#define SWAPCACHE_WAIT_TABLE_BITS 5
> > +#define SWAPCACHE_WAIT_TABLE_SIZE (1 << SWAPCACHE_WAIT_TABLE_BITS)
> > +static wait_queue_head_t swapcache_wqs[SWAPCACHE_WAIT_TABLE_SIZE];
> > +
> > +static int __init swapcache_wqs_init(void)
> > +{
> > +       for (int i =3D 0; i < SWAPCACHE_WAIT_TABLE_SIZE; i++)
> > +               init_waitqueue_head(&swapcache_wqs[i]);
> > +
> > +        return 0;
> > +}
> > +late_initcall(swapcache_wqs_init);
> > +
> >  /*
> >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >   * but allow concurrent faults), and pte mapped but not yet locked.
> > @@ -4204,6 +4221,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  {
> >         struct vm_area_struct *vma =3D vmf->vma;
> >         struct folio *swapcache, *folio =3D NULL;
> > +       DECLARE_WAITQUEUE(wait, current);
> > +       wait_queue_head_t *swapcache_wq;
> >         struct page *page;
> >         struct swap_info_struct *si =3D NULL;
> >         rmap_t rmap_flags =3D RMAP_NONE;
> > @@ -4297,12 +4316,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                                  * undetectable as pte_same() returns t=
rue due
> >                                  * to entry reuse.
> >                                  */
> > +                               swapcache_wq =3D &swapcache_wqs[hash_lo=
ng(vmf->address & PMD_MASK,
> > +                                                       SWAPCACHE_WAIT_=
TABLE_BITS)];
>
> It is better to hash against the swap entry value rather than the
> fault address. Same swap entries can map to different parts of the
> page table. I am not sure this is triggerable in the SYNC_IO page
> fault path, hash against the swap entries is more obviously correct.
>

i am not convinced swap entry offset is a correct key here.

1. do_swap_page() is always for anon pages, there is no possibility
for anon pages to have different mapped virtual address; shmem will
never execute a different code path.

2. considering a mTHP swap-in case, the aligned virtual address
is the only reliable value for hash. if we only consider small folios
swap-in, it is fine to use swap entry value.

> Chris
>
> >                                 if (swapcache_prepare(entry, nr_pages))=
 {
> >                                         /*
> >                                          * Relax a bit to prevent rapid
> >                                          * repeated page faults.
> >                                          */
> > +                                       add_wait_queue(swapcache_wq, &w=
ait);
> >                                         schedule_timeout_uninterruptibl=
e(1);
> > +                                       remove_wait_queue(swapcache_wq,=
 &wait);
> >                                         goto out_page;
> >                                 }
> >                                 need_clear_cache =3D true;
> > @@ -4609,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  out:
> >         /* Clear the swap cache pin for direct swapin after PTL unlock =
*/
> > -       if (need_clear_cache)
> > +       if (need_clear_cache) {
> >                 swapcache_clear(si, entry, nr_pages);
> > +               wake_up(swapcache_wq);
> > +       }
> >         if (si)
> >                 put_swap_device(si);
> >         return ret;
> > @@ -4625,8 +4650,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 folio_unlock(swapcache);
> >                 folio_put(swapcache);
> >         }
> > -       if (need_clear_cache)
> > +       if (need_clear_cache) {
> >                 swapcache_clear(si, entry, nr_pages);
> > +               wake_up(swapcache_wq);
> > +       }
> >         if (si)
> >                 put_swap_device(si);
> >         return ret;
> > --
> > 2.34.1
> >
> > > --
> > > Best Regards,
> > > Huang, Ying
> >

Thanks
Barry

