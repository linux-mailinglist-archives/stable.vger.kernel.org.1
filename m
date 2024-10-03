Return-Path: <stable+bounces-80699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAC498FA2D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 01:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9270E1C22FE0
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5C1CC16F;
	Thu,  3 Oct 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LStVOEnr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867A1AB52D;
	Thu,  3 Oct 2024 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996611; cv=none; b=VtE9UKjPjafdspGxvwXjn8Lak+tP8GSCStlMniBQCZHxSVad4xC+d/g9FRIx8BdIZlUILF/J8g73faZ60GKrbnUMDC7C8DHwbQVlZ331qXxg7EoJtxjuMNtNGPa8kyh6hShHScjrRjz+sleRNxMc3e2BbBmFCAJwu+xvsRcuehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996611; c=relaxed/simple;
	bh=KFzex9+R/I8Pzhswj0CneoSGb7/RTwQAinaseCqg4Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNb4UU+l3aCdJsRYl1kZnzLmWI2/40AWVbUuQZS/p7io6cMPF1883AKX1BT8TY8SCLqB5FG6ZIJm7+IdRjFeg7xPq3RifPXfMEx68N3V3dfHJO8EoDZkIgBY/2vl339/joW68oWemXg9J0sP51CD1uts4JNBD8jsUR8VaeaVIaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LStVOEnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF55C4CED7;
	Thu,  3 Oct 2024 23:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727996611;
	bh=KFzex9+R/I8Pzhswj0CneoSGb7/RTwQAinaseCqg4Ug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LStVOEnr5rPNMp/dKqmhhEFGl7VZ+PDRbowLZ367vOsblwr1DhigBbWDpGlhP8e1q
	 yh4K2gjnk5rGVIBASkrz4rRZslWx8Qi3u+cMUEwl/x3AFEor+SbRVGq+CKA9ZOZ9yH
	 YmBzPRlSJWaTBYHSTJw+P+oua8FwRYNrbwmO0CuwhYzEp+VqzKQnYpCsiOWlPBAUNR
	 9RwelW/L1sMWNqDqW6ML/jvvrYXFTnrGLRneJ+RoaXBQSYzS5cBi6YhMhKMJstfh8F
	 uFWZmdFinnWRayy8akk4G59iE8UghGpWQQqSstlmLtFFx3pFDH1TGgwWOiF4+CrVqv
	 3/BM7s2PlCl6Q==
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71ddb6199c4so833907b3a.0;
        Thu, 03 Oct 2024 16:03:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqc0t/yEMYO5rD4HhQQH6RezFyE2BAxcwcvfa8YPlE5XrIEKo4DytwaDrWi8wjsAGDNYdYxitN2ZB96MU=@vger.kernel.org, AJvYcCXLM+D3j2fKtw18jnBpTCf4ulo+pGdUqjgVPvqzQYhhtp4W9pHiEUJ53HFBBBoikybwf4/ynqjv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ZsrAXddIyB2tMCNuzZsKXr3j9VVNXyA3CCAu7cLAj3Zt6kdI
	a+VDtc3I8RlPBFJElz9dCBEbc83WT6PfuIs69h2KgXHHvgK8weSbb7V2ehZ+Ey11RCN1Onc5VvY
	xAwK9NFkSwHPaabIyMiy/eJ9GcQ==
X-Google-Smtp-Source: AGHT+IGYuAhj5sasoOt3KrZSfKkfm4oAKmJAO76UhBhXcWgfhKLC5p0Kj0HY6Bl/qVbeSvOqy5Wgxgwk8awTddS5dyM=
X-Received: by 2002:a05:6a00:2ea2:b0:714:3831:ec91 with SMTP id
 d2e1a72fcca58-71de2463512mr942880b3a.25.1727996610760; Thu, 03 Oct 2024
 16:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20241002015754.969-1-21cnbao@gmail.com> <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 3 Oct 2024 16:03:17 -0700
X-Gmail-Original-Message-ID: <CANeU7Qn3f=HYiuuU5AL_WDYUy6fLJcqgj6+fPO=xVSxbB_DBQg@mail.gmail.com>
Message-ID: <CANeU7Qn3f=HYiuuU5AL_WDYUy6fLJcqgj6+fPO=xVSxbB_DBQg@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liyangouwen1@oppo.com, mhocko@suse.com, minchan@kernel.org, sj@kernel.org, 
	stable@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:35=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@intel=
.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Hi, Barry,
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >
> >> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcach=
e")
> >> >> >> > introduced an unconditional one-tick sleep when `swapcache_pre=
pare()`
> >> >> >> > fails, which has led to reports of UI stuttering on latency-se=
nsitive
> >> >> >> > Android devices. To address this, we can use a waitqueue to wa=
ke up
> >> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of alway=
s
> >> >> >> > sleeping for a full tick. While tasks may occasionally be woke=
n by an
> >> >> >> > unrelated `do_swap_page()`, this method is preferable to two s=
cenarios:
> >> >> >> > rapid re-entry into page faults, which can cause livelocks, an=
d
> >> >> >> > multiple millisecond sleeps, which visibly degrade user experi=
ence.
> >> >> >>
> >> >> >> In general, I think that this works.  Why not extend the solutio=
n to
> >> >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_as=
ync()
> >> >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To av=
oid
> >> >> >
> >> >> > Hi Ying,
> >> >> > Thanks for your comments.
> >> >> > I feel extending the solution to __read_swap_cache_async() should=
 be done
> >> >> > in a separate patch. On phones, I've never encountered any issues=
 reported
> >> >> > on that path, so it might be better suited for an optimization ra=
ther than a
> >> >> > hotfix?
> >> >>
> >> >> Yes.  It's fine to do that in another patch as optimization.
> >> >
> >> > Ok. I'll prepare a separate patch for optimizing that path.
> >>
> >> Thanks!
> >>
> >> >>
> >> >> >> overhead to call wake_up() when there's no task waiting, we can =
use an
> >> >> >> atomic to count waiting tasks.
> >> >> >
> >> >> > I'm not sure it's worth adding the complexity, as wake_up() on an=
 empty
> >> >> > waitqueue should have a very low cost on its own?
> >> >>
> >> >> wake_up() needs to call spin_lock_irqsave() unconditionally on a gl=
obal
> >> >> shared lock.  On systems with many CPUs (such servers), this may ca=
use
> >> >> severe lock contention.  Even the cache ping-pong may hurt performa=
nce
> >> >> much.
> >> >
> >> > I understand that cache synchronization was a significant issue befo=
re
> >> > qspinlock, but it seems to be less of a concern after its implementa=
tion.
> >>
> >> Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
> >> discussed in the following thread.
> >>
> >> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programmin=
g.kicks-ass.net/
> >>
> >> > However, using a global atomic variable would still trigger cache br=
oadcasts,
> >> > correct?
> >>
> >> We can only change the atomic variable to non-zero when
> >> swapcache_prepare() returns non-zero, and call wake_up() when the atom=
ic
> >> variable is non-zero.  Because swapcache_prepare() returns 0 most time=
s,
> >> the atomic variable is 0 most times.  If we don't change the value of
> >> atomic variable, cache ping-pong will not be triggered.
> >
> > yes. this can be implemented by adding another atomic variable.
>
> Just realized that we don't need another atomic variable for this, just
> use waitqueue_active() before wake_up() should be enough.
>
> >>
> >> Hi, Kairui,
> >>
> >> Do you have some test cases to test parallel zram swap-in?  If so, tha=
t
> >> can be used to verify whether cache ping-pong is an issue and whether =
it
> >> can be fixed via a global atomic variable.
> >>
> >
> > Yes, Kairui please run a test on your machine with lots of cores before
> > and after adding a global atomic variable as suggested by Ying. I am
> > sorry I don't have a server machine.
> >
> > if it turns out you find cache ping-pong can be an issue, another
> > approach would be a waitqueue hash:
>
> Yes.  waitqueue hash may help reduce lock contention.  And, we can have
> both waitqueue_active() and waitqueue hash if necessary.  As the first
> step, waitqueue_active() appears simpler.

Interesting. Just take a look at the waitqueue_active(), it requires
smp_mb() if using without holding the lock.
Quote from the comment of waitqueue_active():
* Also note that this 'optimization' trades a spin_lock() for an smp_mb(),
 * which (when the lock is uncontended) are of roughly equal cost.

Chris

>
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
> > +     for (int i =3D 0; i < SWAPCACHE_WAIT_TABLE_SIZE; i++)
> > +             init_waitqueue_head(&swapcache_wqs[i]);
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
> >       struct vm_area_struct *vma =3D vmf->vma;
> >       struct folio *swapcache, *folio =3D NULL;
> > +     DECLARE_WAITQUEUE(wait, current);
> > +     wait_queue_head_t *swapcache_wq;
> >       struct page *page;
> >       struct swap_info_struct *si =3D NULL;
> >       rmap_t rmap_flags =3D RMAP_NONE;
> > @@ -4297,12 +4316,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                                * undetectable as pte_same() returns tru=
e due
> >                                * to entry reuse.
> >                                */
> > +                             swapcache_wq =3D &swapcache_wqs[hash_long=
(vmf->address & PMD_MASK,
> > +                                                     SWAPCACHE_WAIT_TA=
BLE_BITS)];
> >                               if (swapcache_prepare(entry, nr_pages)) {
> >                                       /*
> >                                        * Relax a bit to prevent rapid
> >                                        * repeated page faults.
> >                                        */
> > +                                     add_wait_queue(swapcache_wq, &wai=
t);
> >                                       schedule_timeout_uninterruptible(=
1);
> > +                                     remove_wait_queue(swapcache_wq, &=
wait);
> >                                       goto out_page;
> >                               }
> >                               need_clear_cache =3D true;
> > @@ -4609,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  out:
> >       /* Clear the swap cache pin for direct swapin after PTL unlock */
> > -     if (need_clear_cache)
> > +     if (need_clear_cache) {
> >               swapcache_clear(si, entry, nr_pages);
> > +             wake_up(swapcache_wq);
> > +     }
> >       if (si)
> >               put_swap_device(si);
> >       return ret;
> > @@ -4625,8 +4650,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               folio_unlock(swapcache);
> >               folio_put(swapcache);
> >       }
> > -     if (need_clear_cache)
> > +     if (need_clear_cache) {
> >               swapcache_clear(si, entry, nr_pages);
> > +             wake_up(swapcache_wq);
> > +     }
> >       if (si)
> >               put_swap_device(si);
> >       return ret;
>
> --
> Best Regards,
> Huang, Ying

