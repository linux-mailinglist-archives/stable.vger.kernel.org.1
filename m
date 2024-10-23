Return-Path: <stable+bounces-87794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0312A9ABB98
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 04:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239D71C22BFA
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 02:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AEA132132;
	Wed, 23 Oct 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+3g25eg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AB1876;
	Wed, 23 Oct 2024 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650767; cv=none; b=tvTpnzacswUiyeS7I9JC6DrvSnE5kESACUbGmuyoJGRs0dJzDqluuqjQ+vS0tUn6eH4eQRtKWz5Bxbf1srfAs4ES0MnWzoq9pMUTsxAH/7sbs0cUURx2lU7/+vIDLhhxafbuHgGY/PQ+kMjC8lXenCGAdelP/kL9ISYguBvAVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650767; c=relaxed/simple;
	bh=bH/6YiPg6/ceQEEdl7DdP+zeOobOI6YvFq/DlvKMzk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4CfFQS8IhuCCS3Yvp3uh7KiuaPpZjNrUwNiU5qQDAMFx3G+3G7/dH5JCnQbyVXkgD6eWEV3oQAmn2Y3zEJmXE9ZoQ9U2NXSNU0jciYXUGyU//z0CJbFZ6bXqQlslbnZ9f4NsienyNapwTqjSP7LMMTVpFQMHQss7WRXjVX7cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+3g25eg; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fdf96b31aso1898985241.2;
        Tue, 22 Oct 2024 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650764; x=1730255564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znxApOC+uNv7EYMj9gabTY3S89oruXYjfhDj/QrnRGM=;
        b=d+3g25eg/G1luEHGAG0BX8JMWJA7DKCEwaP/iwK/9wHRtz/hQCmnZUHFjwA//SheQm
         wp517osiFjwqaeMvxezmQW3mQkhZZaoRtI3pYzeyI93nBB45mv2gODkrzpD6nXBPasDv
         J6qT+veB0wU5tyYbRmTxsYmvxXu/CB1gJ4Uhw2alr2UZmmNo0fWOaLW5AKWXRWZNT70r
         3+/PBkWFBfpRwXqqZZzjdToP1GNpaPBLby5uKJ5YBIHUAPXlk0JyuZGgxt9frCjnA9h/
         kWG3B1CMX6A7/6G4Ez9T+GnlJzVYxoRrUFTn9+ic/lvF2ixXejOsa3XYcVLt6Jg4L7VP
         OI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650764; x=1730255564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znxApOC+uNv7EYMj9gabTY3S89oruXYjfhDj/QrnRGM=;
        b=LucP/Xc8h4/TIelRnLzUi8qH/1/quQ8JmBmuP0gGBvhVlrQFj7eqYRyzCp/b0pAqPV
         OaOfc6tQnF0bBjPcc8/OEL/cae09DqxXzW8P6VLkDAopGmRPtnbE7VfUz01CJJZ9Zhht
         RGlf1hHq9Ih9uA8fDQjEvYp+ewdZcXoEwU+OoX+aEVZTbhDKLLxeUPL13lGUor726yGC
         JPQvYU10d8SB2+DunWLl/rCd2cMwrRe3aqzSDuCSiMXnAKbiJhP+HAgKHo1vBiCmL7Sy
         ii5nWAFfXk9xvKjTJL+IUorCbq7VEky4f1Y3zpPp2OevN7bh2N4Ih4DGtofeSQlfj9IC
         tlHw==
X-Forwarded-Encrypted: i=1; AJvYcCVXKIj6YdTx8kRf++OS9tq++wgccxJ/agdexasrSptQtO8D1G8LfXGrO12dLEBMwreddfjzFqyh@vger.kernel.org, AJvYcCXFLWf3PLiuZG/iF2mYC8mMTud0/NFGMWKYwHFuvFJLOviRd5+HtlVppa99aEL/zUtMde8yogZF5GZz6A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLh1QKZxoLLNB7Ia9MrrO4diEBtOcrKdhtk7aWkIqgFLqSzjU
	m0DQVvkNOBcxaOUR03dkD5cNRdttAH+rZG4BBxM5H/elpiSAPH6b8NWA0mL8ykQ+mZ/s/4uCCxJ
	bfTObwShL0pewqF0Tif44TmfBs3c=
X-Google-Smtp-Source: AGHT+IFeWPj+ZmewRQE8kwIwSh3ID+aLKdiBrIR2ByPOBmY9r1G4coEjq1Y0ZZKHFvz23lZO4QvWAP+46cFsqTRS83M=
X-Received: by 2002:a05:6102:3a0d:b0:4a5:b5db:ec5e with SMTP id
 ada2fe7eead31-4a751cb4ef0mr1363993137.27.1729650764351; Tue, 22 Oct 2024
 19:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20241008130807.40833-1-21cnbao@gmail.com> <87set6m73u.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMgjq7D6Ku4-0mfJUexB9ARxY5eHwJjMS_M9qqXrvR=ScW0jtA@mail.gmail.com> <87iktj4m3u.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87iktj4m3u.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 23 Oct 2024 15:32:33 +1300
Message-ID: <CAGsJ_4ymiC_Y_mpfz2Xek6JjdoCyR_jyuVkC+FsVrBPv92TiKw@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, akpm@linux-foundation.org, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liyangouwen1@oppo.com, mhocko@suse.com, minchan@kernel.org, sj@kernel.org, 
	stable@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 3:01=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > On Wed, Oct 9, 2024 at 8:55=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Thu, Oct 3, 2024 at 8:35=E2=80=AFAM Huang, Ying <ying.huang@intel=
.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@in=
tel.com> wrote:
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang=
@intel.com> wrote:
> >> >> >> >>
> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >> >>
> >> >> >> >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.h=
uang@intel.com> wrote:
> >> >> >> >> >>
> >> >> >> >> >> Hi, Barry,
> >> >> >> >> >>
> >> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >> >> >>
> >> >> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> >> >
> >> >> >> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping sw=
apcache")
> >> >> >> >> >> > introduced an unconditional one-tick sleep when `swapcac=
he_prepare()`
> >> >> >> >> >> > fails, which has led to reports of UI stuttering on late=
ncy-sensitive
> >> >> >> >> >> > Android devices. To address this, we can use a waitqueue=
 to wake up
> >> >> >> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of=
 always
> >> >> >> >> >> > sleeping for a full tick. While tasks may occasionally b=
e woken by an
> >> >> >> >> >> > unrelated `do_swap_page()`, this method is preferable to=
 two scenarios:
> >> >> >> >> >> > rapid re-entry into page faults, which can cause liveloc=
ks, and
> >> >> >> >> >> > multiple millisecond sleeps, which visibly degrade user =
experience.
> >> >> >> >> >>
> >> >> >> >> >> In general, I think that this works.  Why not extend the s=
olution to
> >> >> >> >> >> cover schedule_timeout_uninterruptible() in __read_swap_ca=
che_async()
> >> >> >> >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE. =
 To avoid
> >> >> >> >> >
> >> >> >> >> > Hi Ying,
> >> >> >> >> > Thanks for your comments.
> >> >> >> >> > I feel extending the solution to __read_swap_cache_async() =
should be done
> >> >> >> >> > in a separate patch. On phones, I've never encountered any =
issues reported
> >> >> >> >> > on that path, so it might be better suited for an optimizat=
ion rather than a
> >> >> >> >> > hotfix?
> >> >> >> >>
> >> >> >> >> Yes.  It's fine to do that in another patch as optimization.
> >> >> >> >
> >> >> >> > Ok. I'll prepare a separate patch for optimizing that path.
> >> >> >>
> >> >> >> Thanks!
> >> >> >>
> >> >> >> >>
> >> >> >> >> >> overhead to call wake_up() when there's no task waiting, w=
e can use an
> >> >> >> >> >> atomic to count waiting tasks.
> >> >> >> >> >
> >> >> >> >> > I'm not sure it's worth adding the complexity, as wake_up()=
 on an empty
> >> >> >> >> > waitqueue should have a very low cost on its own?
> >> >> >> >>
> >> >> >> >> wake_up() needs to call spin_lock_irqsave() unconditionally o=
n a global
> >> >> >> >> shared lock.  On systems with many CPUs (such servers), this =
may cause
> >> >> >> >> severe lock contention.  Even the cache ping-pong may hurt pe=
rformance
> >> >> >> >> much.
> >> >> >> >
> >> >> >> > I understand that cache synchronization was a significant issu=
e before
> >> >> >> > qspinlock, but it seems to be less of a concern after its impl=
ementation.
> >> >> >>
> >> >> >> Unfortunately, qspinlock cannot eliminate cache ping-pong issue,=
 as
> >> >> >> discussed in the following thread.
> >> >> >>
> >> >> >> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.prog=
ramming.kicks-ass.net/
> >> >> >>
> >> >> >> > However, using a global atomic variable would still trigger ca=
che broadcasts,
> >> >> >> > correct?
> >> >> >>
> >> >> >> We can only change the atomic variable to non-zero when
> >> >> >> swapcache_prepare() returns non-zero, and call wake_up() when th=
e atomic
> >> >> >> variable is non-zero.  Because swapcache_prepare() returns 0 mos=
t times,
> >> >> >> the atomic variable is 0 most times.  If we don't change the val=
ue of
> >> >> >> atomic variable, cache ping-pong will not be triggered.
> >> >> >
> >> >> > yes. this can be implemented by adding another atomic variable.
> >> >>
> >> >> Just realized that we don't need another atomic variable for this, =
just
> >> >> use waitqueue_active() before wake_up() should be enough.
> >> >>
> >> >> >>
> >> >> >> Hi, Kairui,
> >> >> >>
> >> >> >> Do you have some test cases to test parallel zram swap-in?  If s=
o, that
> >> >> >> can be used to verify whether cache ping-pong is an issue and wh=
ether it
> >> >> >> can be fixed via a global atomic variable.
> >> >> >>
> >> >> >
> >> >> > Yes, Kairui please run a test on your machine with lots of cores =
before
> >> >> > and after adding a global atomic variable as suggested by Ying. I=
 am
> >> >> > sorry I don't have a server machine.
> >> >> >
> >> >> > if it turns out you find cache ping-pong can be an issue, another
> >> >> > approach would be a waitqueue hash:
> >> >>
> >> >> Yes.  waitqueue hash may help reduce lock contention.  And, we can =
have
> >> >> both waitqueue_active() and waitqueue hash if necessary.  As the fi=
rst
> >> >> step, waitqueue_active() appears simpler.
> >> >
> >> > Hi Andrew,
> >> > If there are no objections, can you please squash the below change? =
Oven
> >> > has already tested the change and the original issue was still fixed=
 with
> >> > it. If you want me to send v2 instead, please let me know.
> >> >
> >> > From a5ca401da89f3b628c3a0147e54541d0968654b2 Mon Sep 17 00:00:00 20=
01
> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> > Date: Tue, 8 Oct 2024 20:18:27 +0800
> >> > Subject: [PATCH] mm: wake_up only when swapcache_wq waitqueue is act=
ive
> >> >
> >> > wake_up() will acquire spinlock even waitqueue is empty. This might
> >> > involve cache sync overhead. Let's only call wake_up() when waitqueu=
e
> >> > is active.
> >> >
> >> > Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> > ---
> >> >  mm/memory.c | 6 ++++--
> >> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/mm/memory.c b/mm/memory.c
> >> > index fe21bd3beff5..4adb2d0bcc7a 100644
> >> > --- a/mm/memory.c
> >> > +++ b/mm/memory.c
> >> > @@ -4623,7 +4623,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >       /* Clear the swap cache pin for direct swapin after PTL unlock=
 */
> >> >       if (need_clear_cache) {
> >> >               swapcache_clear(si, entry, nr_pages);
> >> > -             wake_up(&swapcache_wq);
> >> > +             if (waitqueue_active(&swapcache_wq))
> >> > +                     wake_up(&swapcache_wq);
> >> >       }
> >> >       if (si)
> >> >               put_swap_device(si);
> >> > @@ -4641,7 +4642,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >       }
> >> >       if (need_clear_cache) {
> >> >               swapcache_clear(si, entry, nr_pages);
> >> > -             wake_up(&swapcache_wq);
> >> > +             if (waitqueue_active(&swapcache_wq))
> >> > +                     wake_up(&swapcache_wq);
> >> >       }
> >> >       if (si)
> >> >               put_swap_device(si);
> >>
> >> Hi, Kairui,
> >>
> >> Do you have time to give this patch (combined with the previous patch
> >> from Barry) a test to check whether the overhead introduced in the
> >> previous patch has been eliminated?
> >
> > Hi Ying, Barry
> >
> > I did a rebase on mm tree and run more tests with the latest patch:
> >
> > Before the two patches:
> > make -j96 (64k): 33814.45 35061.25 35667.54 36618.30 37381.60 37678.75
> > make -j96: 20456.03 20460.36 20511.55 20584.76 20751.07 20780.79
> > make -j64:7490.83 7515.55 7535.30 7544.81 7564.77 7583.41
> >
> > After adding workqueue:
> > make -j96 (64k): 33190.60 35049.57 35732.01 36263.81 37154.05 37815.50
> > make -j96: 20373.27 20382.96 20428.78 20459.73 20534.59 20548.48
> > make -j64: 7469.18 7522.57 7527.38 7532.69 7543.36 7546.28
> >
> > After adding workqueue with workqueue_active() check:
> > make -j96 (64k): 33321.03 35039.68 35552.86 36474.95 37502.76 37549.04
> > make -j96: 20601.39 20639.08 20692.81 20693.91 20701.35 20740.71
> > make -j64: 7538.63 7542.27 7564.86 7567.36 7594.14 7600.96
> >
> > So I think it's just noise level performance change, it should be OK
> > in either way.

Thanks for Kairui's testing.

>
> Thanks for your test results.  There should be bottlenecks in other
> places.

Exactly. I=E2=80=99d expect cache ping-pong to become noticeable only when
the spinlock is highly contended=E2=80=94such as when many threads
simultaneously follow the pattern below:

spin_lock
short-time operations
spin_unlock

But we=E2=80=99re likely dealing with a different pattern, as shown below:

long-time operations

spin_lock
short-time operations
spin_unlock

>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

