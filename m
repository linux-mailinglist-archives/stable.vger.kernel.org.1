Return-Path: <stable+bounces-82630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC24994E11
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA95B2B0C8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE31DE8BE;
	Tue,  8 Oct 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN3u+Jlb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172261DF254;
	Tue,  8 Oct 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392899; cv=none; b=mr5VBP3gccTAZxyq/DnhaZ8948BHMRD3X9wAVChvzmKKPKRzeB5XmE6yUh23DoLt6mOcbYu8gRDOyo8Egx1FL8JDYCF/5AmGIYkr/LfTJ6ioDY4PmpKRfoGBkFzYZ/7RYwIawH80eoJyaxVa2vzvbW3/2PI7GgQYweaLK09HIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392899; c=relaxed/simple;
	bh=nQiLGUa/Ut46b4xboKoeP47tzhFUJ8ZsLoHEJpxChjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLkycA177HtYDkIPfqEYHfRwhARTJWltwen27kmP4EECSut/pzSrcga8aBshKGEaeY1raxv3dm6IQyoer1oHOXDYVrfJdETh74A6qKjxeiEkuOD0X0tPBn4JdTpvYMHnYpPKzzUNYU8fTUsjqcQGyEgiSrBFoDa+nWVEfZ0gKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN3u+Jlb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c544d34bcso6414045ad.1;
        Tue, 08 Oct 2024 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728392897; x=1728997697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgnuluNcKJJec3QJRntHlMu9+I2DTyJy+x38c7ZJyRo=;
        b=XN3u+JlbdD90zSM02oUN1wV8FB79NM0CxH4pTcV+xP1tLoELePDkwz9JyJTxNqRiWV
         5hPpTTBcdVDtI5/QohyXpDlDO0QLtf9IYXeNH9hQSZ9EiF5PmCy56lPcxuqjmPEN+Yey
         Jr7lhmZViiH6oJq38gUAN/qOyKxLjINVdKpZNyHF72ipJ8p5GV1goi/sGgxSB+QegAMU
         u8xFUMSXrH1X5tp8wi/CDniav+lEiYNuvS4U3T0+BMe4lqkzjnreAZw/156do/JIhzNd
         CmMKj/UDpSk5LYOrTNyaSOe8TUa+RbF2OKtYK+2dndNiH5M1NIH9Z7+xNDpdZvOtsdmx
         UZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728392897; x=1728997697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgnuluNcKJJec3QJRntHlMu9+I2DTyJy+x38c7ZJyRo=;
        b=j0gcdbcCEJBwb2q+iPF6r+czSYMdunK4qqSqRleg9R/oiQ9VZXoo0EiH3bLCm4VfZz
         u212dhn8q2WP1rN0cmv29Ho7qpSqe92OC1BoWb8v4+sTGBrKk67wmUcS7DiiQhtPCWiM
         Q8LbC6897Np1vRON+opoJaREOB8etg5gwiD6HEDcCnsnHyVjkFKwDug8QX1nRmaMF7mX
         Sx1+3l5pqtJo8T0b4aCc+tvLf8N17J7ZnwnxRUGa0gx2HNVZpWI+YsEPeK7qWcqQqOlH
         LYU3kcaq4/M9/XMcRSZ8DVWP/PkKEMieCu6eh1zz7V/v7r55MxYL5M7t3rQVEt1PPddV
         sYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzYJ1XtQR/Fo+Z/6QkVSsSDJApb4JuhARQKBcjW/4JnvTV2Wp+pN1Zd/vuX0MxOFRI68f21J6Y4PIdxFM=@vger.kernel.org, AJvYcCXxNPzRMzKltFX7tNn/71XmNezxaTdCqf0PrBI5sTgHT6p4sm72RGmLgNVzBjCuu2/OopF1hNK5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FAInNkJM4Q3f0BistO78id/YRJV08vZcZGv4KH6MSCwnl1WQ
	P7s7ll59FKt/7ul0EzWpI1IK3R/pFdnz4TsLSot543aVS+0npO9O
X-Google-Smtp-Source: AGHT+IHBfvmIO88nfTBhLNfkV5002Z/kpex9ViTJROxf9dsLZ78y2lNhxglLJQZme5kqCg20iL8pjA==
X-Received: by 2002:a17:902:f550:b0:202:371c:3312 with SMTP id d9443c01a7336-20bfe496685mr216706295ad.40.1728392897304;
        Tue, 08 Oct 2024 06:08:17 -0700 (PDT)
Received: from localhost.localdomain ([103.135.144.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cb457sm55160495ad.70.2024.10.08.06.08.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Oct 2024 06:08:16 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: ying.huang@intel.com,
	akpm@linux-foundation.org
Cc: 21cnbao@gmail.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liyangouwen1@oppo.com,
	mhocko@suse.com,
	minchan@kernel.org,
	sj@kernel.org,
	stable@vger.kernel.org,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when swapcache_prepare fails
Date: Tue,  8 Oct 2024 21:08:07 +0800
Message-Id: <20241008130807.40833-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 3, 2024 at 8:35 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Oct 2, 2024 at 8:43 AM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Tue, Oct 1, 2024 at 7:43 AM Huang, Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Sun, Sep 29, 2024 at 3:43 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >> >>
> >> >> >> Hi, Barry,
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >
> >> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> >> >> >> > introduced an unconditional one-tick sleep when `swapcache_prepare()`
> >> >> >> > fails, which has led to reports of UI stuttering on latency-sensitive
> >> >> >> > Android devices. To address this, we can use a waitqueue to wake up
> >> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of always
> >> >> >> > sleeping for a full tick. While tasks may occasionally be woken by an
> >> >> >> > unrelated `do_swap_page()`, this method is preferable to two scenarios:
> >> >> >> > rapid re-entry into page faults, which can cause livelocks, and
> >> >> >> > multiple millisecond sleeps, which visibly degrade user experience.
> >> >> >>
> >> >> >> In general, I think that this works.  Why not extend the solution to
> >> >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_async()
> >> >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avoid
> >> >> >
> >> >> > Hi Ying,
> >> >> > Thanks for your comments.
> >> >> > I feel extending the solution to __read_swap_cache_async() should be done
> >> >> > in a separate patch. On phones, I've never encountered any issues reported
> >> >> > on that path, so it might be better suited for an optimization rather than a
> >> >> > hotfix?
> >> >>
> >> >> Yes.  It's fine to do that in another patch as optimization.
> >> >
> >> > Ok. I'll prepare a separate patch for optimizing that path.
> >>
> >> Thanks!
> >>
> >> >>
> >> >> >> overhead to call wake_up() when there's no task waiting, we can use an
> >> >> >> atomic to count waiting tasks.
> >> >> >
> >> >> > I'm not sure it's worth adding the complexity, as wake_up() on an empty
> >> >> > waitqueue should have a very low cost on its own?
> >> >>
> >> >> wake_up() needs to call spin_lock_irqsave() unconditionally on a global
> >> >> shared lock.  On systems with many CPUs (such servers), this may cause
> >> >> severe lock contention.  Even the cache ping-pong may hurt performance
> >> >> much.
> >> >
> >> > I understand that cache synchronization was a significant issue before
> >> > qspinlock, but it seems to be less of a concern after its implementation.
> >>
> >> Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
> >> discussed in the following thread.
> >>
> >> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programming.kicks-ass.net/
> >>
> >> > However, using a global atomic variable would still trigger cache broadcasts,
> >> > correct?
> >>
> >> We can only change the atomic variable to non-zero when
> >> swapcache_prepare() returns non-zero, and call wake_up() when the atomic
> >> variable is non-zero.  Because swapcache_prepare() returns 0 most times,
> >> the atomic variable is 0 most times.  If we don't change the value of
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
> >> Do you have some test cases to test parallel zram swap-in?  If so, that
> >> can be used to verify whether cache ping-pong is an issue and whether it
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
> Yes.  waitqueue hash may help reduce lock contention.  And, we can have
> both waitqueue_active() and waitqueue hash if necessary.  As the first
> step, waitqueue_active() appears simpler.

Hi Andrew,
If there are no objections, can you please squash the below change? Oven
has already tested the change and the original issue was still fixed with
it. If you want me to send v2 instead, please let me know.

From a5ca401da89f3b628c3a0147e54541d0968654b2 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Tue, 8 Oct 2024 20:18:27 +0800
Subject: [PATCH] mm: wake_up only when swapcache_wq waitqueue is active

wake_up() will acquire spinlock even waitqueue is empty. This might
involve cache sync overhead. Let's only call wake_up() when waitqueue
is active.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fe21bd3beff5..4adb2d0bcc7a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4623,7 +4623,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
-		wake_up(&swapcache_wq);
+		if (waitqueue_active(&swapcache_wq))
+			wake_up(&swapcache_wq);
 	}
 	if (si)
 		put_swap_device(si);
@@ -4641,7 +4642,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
-		wake_up(&swapcache_wq);
+		if (waitqueue_active(&swapcache_wq))
+			wake_up(&swapcache_wq);
 	}
 	if (si)
 		put_swap_device(si);
-- 
2.39.3 (Apple Git-146)

>
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2366578015ad..aae0e532d8b6 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4192,6 +4192,23 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> >  }
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
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
> > +     for (int i = 0; i < SWAPCACHE_WAIT_TABLE_SIZE; i++)
> > +             init_waitqueue_head(&swapcache_wqs[i]);
> > +
> > +        return 0;
> > +}
> > +late_initcall(swapcache_wqs_init);
> > +
> >  /*
> >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >   * but allow concurrent faults), and pte mapped but not yet locked.
> > @@ -4204,6 +4221,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  {
> >       struct vm_area_struct *vma = vmf->vma;
> >       struct folio *swapcache, *folio = NULL;
> > +     DECLARE_WAITQUEUE(wait, current);
> > +     wait_queue_head_t *swapcache_wq;
> >       struct page *page;
> >       struct swap_info_struct *si = NULL;
> >       rmap_t rmap_flags = RMAP_NONE;
> > @@ -4297,12 +4316,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                                * undetectable as pte_same() returns true due
> >                                * to entry reuse.
> >                                */
> > +                             swapcache_wq = &swapcache_wqs[hash_long(vmf->address & PMD_MASK,
> > +                                                     SWAPCACHE_WAIT_TABLE_BITS)];
> >                               if (swapcache_prepare(entry, nr_pages)) {
> >                                       /*
> >                                        * Relax a bit to prevent rapid
> >                                        * repeated page faults.
> >                                        */
> > +                                     add_wait_queue(swapcache_wq, &wait);
> >                                       schedule_timeout_uninterruptible(1);
> > +                                     remove_wait_queue(swapcache_wq, &wait);
> >                                       goto out_page;
> >                               }
> >                               need_clear_cache = true;
> > @@ -4609,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  out:
> >       /* Clear the swap cache pin for direct swapin after PTL unlock */
> > -     if (need_clear_cache)
> > +     if (need_clear_cache) {
> >               swapcache_clear(si, entry, nr_pages);
> > +             wake_up(swapcache_wq);
> > +     }
> >       if (si)
> >               put_swap_device(si);
> >       return ret;
> > @@ -4625,8 +4650,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               folio_unlock(swapcache);
> >               folio_put(swapcache);
> >       }
> > -     if (need_clear_cache)
> > +     if (need_clear_cache) {
> >               swapcache_clear(si, entry, nr_pages);
> > +             wake_up(swapcache_wq);
> > +     }
> >       if (si)
> >               put_swap_device(si);
> >       return ret;
>
> --
> Best Regards,
> Huang, Ying

