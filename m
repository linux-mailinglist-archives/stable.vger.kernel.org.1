Return-Path: <stable+bounces-80768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB599086A
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01442884CD
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F81C727A;
	Fri,  4 Oct 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq/IQNd+"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF21C7273;
	Fri,  4 Oct 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057814; cv=none; b=Zut6yIeEDGtOijeTRSKAVY5K1qygDrOUzsE4zR2TZ3ueh2IioG6uOMFPgE4qwF1Iq4b/wM5yW3dQUuQubanB3BVMBnh+utF6vflWxNZGLz+b+T9rnWadBnCqMkM2j8FpK9boA2YjjsU+gO484vBSYTETZpU+YjP3VhjFfQeaXx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057814; c=relaxed/simple;
	bh=VttJyk7OKdJrFXqMZJgo01OKXgvxq+5OApCXwUhMwXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AomayDbYP02dUH/QmwpA0NxQ87jMjrqfhSYhYm+UHMrZ/0E/bw+ivxZR/agTM+z+z3ckFVYlrqcrxXa5LMew9xGrkFsS9HrKa+vOqUh2bgLgPlnw+ILc+mZ7rgkT4/M46RtLqy+k8oD0+eGJ6Y4vdXO/cyxK+qjSzTk0X0onw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq/IQNd+; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a3b67e719aso901796137.0;
        Fri, 04 Oct 2024 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728057810; x=1728662610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIgiVdq7cFc+ljJH5YQyVg/lbKqFOvpmQ2EmQXCShK0=;
        b=Mq/IQNd+iT1VcarWq82GHp/6aYmhrzSUaTp/EjLBnzOB8+f8iw3MVBQp3vZkcFOfD2
         hI09gnJY7/dYJiN/BWxN0Lw02Z01sCLZp8C1iVE0dwNjFgZQvTSzMXx4zkVUcwbsizqj
         gBzKsSSh/3kCOCPAZHtQjtpgLTw4FjBo1S8Ktqcd1NWhdCKuSCDUkGiRF0K19gIpiaIe
         vB4RNyuem5LmNnsvZ2SHap140Uy0+2DyY79ViUisb1cLsHWv7jBBBX3MK3ZzxuAQH3o3
         vrm15jFnGU3TGfd207Witwmh/ij40pN4RFkFcNMzpoFbt5OCkPUazj5BiYnEOnYPep6g
         7eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728057810; x=1728662610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIgiVdq7cFc+ljJH5YQyVg/lbKqFOvpmQ2EmQXCShK0=;
        b=H8L/P1uN+v/ypnHofpfNXfl9qUQVQ+NXf7fHD6st6f7bje21yXvljqh/b5I3Ox3yWH
         6P91ZKRQRoCUvP+sGiKf7b+8U88qUgztuGxoEFtQ7zQHQLHHDqc5+EzPwGdsoWUYKuGB
         MzR9n8JFcaMLKclAMu1eojlV+5wPn71tX7x+cIEZEqcTf3S4udUEctTEyaAdjIHjS6Ij
         mjWUpiQyrexnSo0qVrS8nJqcBduCtrT3ZmYxuHLQhKFpmWT7nXWqyuhZH27LkYipo6MJ
         Yrnp3nMqgSpQF+GktfILvVOR9Mz3wiYRrzahgJoxtELcyRDU3ahH5Owoc2uq7sP3dfjd
         L23A==
X-Forwarded-Encrypted: i=1; AJvYcCVJtYrPgCfFwzxxEosFvFcttNZu5e11IKO/jy3hFJX63Et9eLyk5IWuAQjEPNmWatRBC6KntZcF2QJg2iA=@vger.kernel.org, AJvYcCWeFcj7J9Hmx0Pw5wcLNsgANO/LhA1pjaVhQgjoa68YoebMYGbni8du9VijBp62bUuT/PRXq66G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0scPRBaWuTZMC72vPecBNOsJYQ3vaJ8FrS/rb7aQgvoDNohUY
	uQsXanUOEY1+wKq/iTCrQ484xKAYh/sjY8b7sv/nhOqRBXvIuFtcQEhgJSYKwPIV60x4bukmVZZ
	nB5C111gI32XCHwVZl+YMOqRamug=
X-Google-Smtp-Source: AGHT+IEljj8mGywrE15eU1pVonuWf9T9gUqMpdm4BprMd36TM8glAoaRJODh9Mpb0Q3n6IKnfjrvAtOFHgRSoMH4zG8=
X-Received: by 2002:a05:6122:4687:b0:50c:4bcf:2727 with SMTP id
 71dfb90a1353d-50c852ff1bamr3866868e0c.0.1728057810171; Fri, 04 Oct 2024
 09:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20241002015754.969-1-21cnbao@gmail.com> <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CANeU7Qn3f=HYiuuU5AL_WDYUy6fLJcqgj6+fPO=xVSxbB_DBQg@mail.gmail.com>
In-Reply-To: <CANeU7Qn3f=HYiuuU5AL_WDYUy6fLJcqgj6+fPO=xVSxbB_DBQg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 5 Oct 2024 00:03:17 +0800
Message-ID: <CAGsJ_4ysvUj1OWobTpWhgJ1TAwRvVU+X0S8qgeBPE8=z2SbumQ@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liyangouwen1@oppo.com, mhocko@suse.com, minchan@kernel.org, sj@kernel.org, 
	stable@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:03=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Oct 2, 2024 at 5:35=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
> > >>
> > >> Barry Song <21cnbao@gmail.com> writes:
> > >>
> > >> > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@int=
el.com> wrote:
> > >> >>
> > >> >> Barry Song <21cnbao@gmail.com> writes:
> > >> >>
> > >> >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang=
@intel.com> wrote:
> > >> >> >>
> > >> >> >> Hi, Barry,
> > >> >> >>
> > >> >> >> Barry Song <21cnbao@gmail.com> writes:
> > >> >> >>
> > >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> > >> >> >> >
> > >> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapca=
che")
> > >> >> >> > introduced an unconditional one-tick sleep when `swapcache_p=
repare()`
> > >> >> >> > fails, which has led to reports of UI stuttering on latency-=
sensitive
> > >> >> >> > Android devices. To address this, we can use a waitqueue to =
wake up
> > >> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of alw=
ays
> > >> >> >> > sleeping for a full tick. While tasks may occasionally be wo=
ken by an
> > >> >> >> > unrelated `do_swap_page()`, this method is preferable to two=
 scenarios:
> > >> >> >> > rapid re-entry into page faults, which can cause livelocks, =
and
> > >> >> >> > multiple millisecond sleeps, which visibly degrade user expe=
rience.
> > >> >> >>
> > >> >> >> In general, I think that this works.  Why not extend the solut=
ion to
> > >> >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_=
async()
> > >> >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To =
avoid
> > >> >> >
> > >> >> > Hi Ying,
> > >> >> > Thanks for your comments.
> > >> >> > I feel extending the solution to __read_swap_cache_async() shou=
ld be done
> > >> >> > in a separate patch. On phones, I've never encountered any issu=
es reported
> > >> >> > on that path, so it might be better suited for an optimization =
rather than a
> > >> >> > hotfix?
> > >> >>
> > >> >> Yes.  It's fine to do that in another patch as optimization.
> > >> >
> > >> > Ok. I'll prepare a separate patch for optimizing that path.
> > >>
> > >> Thanks!
> > >>
> > >> >>
> > >> >> >> overhead to call wake_up() when there's no task waiting, we ca=
n use an
> > >> >> >> atomic to count waiting tasks.
> > >> >> >
> > >> >> > I'm not sure it's worth adding the complexity, as wake_up() on =
an empty
> > >> >> > waitqueue should have a very low cost on its own?
> > >> >>
> > >> >> wake_up() needs to call spin_lock_irqsave() unconditionally on a =
global
> > >> >> shared lock.  On systems with many CPUs (such servers), this may =
cause
> > >> >> severe lock contention.  Even the cache ping-pong may hurt perfor=
mance
> > >> >> much.
> > >> >
> > >> > I understand that cache synchronization was a significant issue be=
fore
> > >> > qspinlock, but it seems to be less of a concern after its implemen=
tation.
> > >>
> > >> Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
> > >> discussed in the following thread.
> > >>
> > >> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programm=
ing.kicks-ass.net/
> > >>
> > >> > However, using a global atomic variable would still trigger cache =
broadcasts,
> > >> > correct?
> > >>
> > >> We can only change the atomic variable to non-zero when
> > >> swapcache_prepare() returns non-zero, and call wake_up() when the at=
omic
> > >> variable is non-zero.  Because swapcache_prepare() returns 0 most ti=
mes,
> > >> the atomic variable is 0 most times.  If we don't change the value o=
f
> > >> atomic variable, cache ping-pong will not be triggered.
> > >
> > > yes. this can be implemented by adding another atomic variable.
> >
> > Just realized that we don't need another atomic variable for this, just
> > use waitqueue_active() before wake_up() should be enough.
> >
> > >>
> > >> Hi, Kairui,
> > >>
> > >> Do you have some test cases to test parallel zram swap-in?  If so, t=
hat
> > >> can be used to verify whether cache ping-pong is an issue and whethe=
r it
> > >> can be fixed via a global atomic variable.
> > >>
> > >
> > > Yes, Kairui please run a test on your machine with lots of cores befo=
re
> > > and after adding a global atomic variable as suggested by Ying. I am
> > > sorry I don't have a server machine.
> > >
> > > if it turns out you find cache ping-pong can be an issue, another
> > > approach would be a waitqueue hash:
> >
> > Yes.  waitqueue hash may help reduce lock contention.  And, we can have
> > both waitqueue_active() and waitqueue hash if necessary.  As the first
> > step, waitqueue_active() appears simpler.
>
> Interesting. Just take a look at the waitqueue_active(), it requires
> smp_mb() if using without holding the lock.
> Quote from the comment of waitqueue_active():
> * Also note that this 'optimization' trades a spin_lock() for an smp_mb()=
,
>  * which (when the lock is uncontended) are of roughly equal cost.
>

probably not a problem in our case. two reasons:
1. we don't have a condition here
2. false postive/negative wake_up() won't cause a problem here.

We used to always sleep at least 4ms for an embedded system, if we can
kill 99% of the possibilities, it is all good.

Ideally, we could combine wait queue hash and wakeup_active(), but
Kairui's test shows even if we did neither of the above, it is still accept=
able
in performance. so probably we can make things simple by just
adding a if(waitqueue_active()) before wake_up().

> Chris
>
> >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 2366578015ad..aae0e532d8b6 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4192,6 +4192,23 @@ static struct folio *alloc_swap_folio(struct v=
m_fault *vmf)
> > >  }
> > >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > >
> > > +/*
> > > + * Alleviating the 'thundering herd' phenomenon using a waitqueue ha=
sh
> > > + * when multiple do_swap_page() operations occur simultaneously.
> > > + */
> > > +#define SWAPCACHE_WAIT_TABLE_BITS 5
> > > +#define SWAPCACHE_WAIT_TABLE_SIZE (1 << SWAPCACHE_WAIT_TABLE_BITS)
> > > +static wait_queue_head_t swapcache_wqs[SWAPCACHE_WAIT_TABLE_SIZE];
> > > +
> > > +static int __init swapcache_wqs_init(void)
> > > +{
> > > +     for (int i =3D 0; i < SWAPCACHE_WAIT_TABLE_SIZE; i++)
> > > +             init_waitqueue_head(&swapcache_wqs[i]);
> > > +
> > > +        return 0;
> > > +}
> > > +late_initcall(swapcache_wqs_init);
> > > +
> > >  /*
> > >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> > >   * but allow concurrent faults), and pte mapped but not yet locked.
> > > @@ -4204,6 +4221,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >  {
> > >       struct vm_area_struct *vma =3D vmf->vma;
> > >       struct folio *swapcache, *folio =3D NULL;
> > > +     DECLARE_WAITQUEUE(wait, current);
> > > +     wait_queue_head_t *swapcache_wq;
> > >       struct page *page;
> > >       struct swap_info_struct *si =3D NULL;
> > >       rmap_t rmap_flags =3D RMAP_NONE;
> > > @@ -4297,12 +4316,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >                                * undetectable as pte_same() returns t=
rue due
> > >                                * to entry reuse.
> > >                                */
> > > +                             swapcache_wq =3D &swapcache_wqs[hash_lo=
ng(vmf->address & PMD_MASK,
> > > +                                                     SWAPCACHE_WAIT_=
TABLE_BITS)];
> > >                               if (swapcache_prepare(entry, nr_pages))=
 {
> > >                                       /*
> > >                                        * Relax a bit to prevent rapid
> > >                                        * repeated page faults.
> > >                                        */
> > > +                                     add_wait_queue(swapcache_wq, &w=
ait);
> > >                                       schedule_timeout_uninterruptibl=
e(1);
> > > +                                     remove_wait_queue(swapcache_wq,=
 &wait);
> > >                                       goto out_page;
> > >                               }
> > >                               need_clear_cache =3D true;
> > > @@ -4609,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> > >  out:
> > >       /* Clear the swap cache pin for direct swapin after PTL unlock =
*/
> > > -     if (need_clear_cache)
> > > +     if (need_clear_cache) {
> > >               swapcache_clear(si, entry, nr_pages);
> > > +             wake_up(swapcache_wq);
> > > +     }
> > >       if (si)
> > >               put_swap_device(si);
> > >       return ret;
> > > @@ -4625,8 +4650,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >               folio_unlock(swapcache);
> > >               folio_put(swapcache);
> > >       }
> > > -     if (need_clear_cache)
> > > +     if (need_clear_cache) {
> > >               swapcache_clear(si, entry, nr_pages);
> > > +             wake_up(swapcache_wq);
> > > +     }
> > >       if (si)
> > >               put_swap_device(si);
> > >       return ret;
> >
> > --
> > Best Regards,
> > Huang, Ying

Thanks
Barry

