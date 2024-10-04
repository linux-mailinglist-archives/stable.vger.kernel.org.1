Return-Path: <stable+bounces-80767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C869908B5
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0085FB2F60A
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE11C728D;
	Fri,  4 Oct 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arz3TUWM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB91C75ED;
	Fri,  4 Oct 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057353; cv=none; b=EqYRPy8NyA6YfCz+PScM3nbkCr1HPXfagvqMmqg5N9OVc8wMNYJcYNppYCuKWr485AoEefwzRX2KpLX5KhY+TMmrqOqa1Tvbraqtae0a76B9nahJbmmXK8Ld6jFW9rLPUcTtUSbkdgw7bQ57lqWgjr6buw406g+ouH/2JtnH7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057353; c=relaxed/simple;
	bh=hSMcRIMRt7R2gF4BI0KGMvNBBzG5kLRpwYaRrJQiC3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDGjWIwZArafXhzzeJgH9odSzGSCQ1dn4QfFvcFLaX4i1DrxDTF1ixACAEKLm3IcXS2UP4E19/t7OokBoyz9hdw0QINdLooE21hujitOERBYjoLKs2NTF6IxrVqm+r14RevCyno0mI6ABHwUaYVAwX6Fj9mvgWOhkfs1mvC8+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arz3TUWM; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50958a19485so628282e0c.2;
        Fri, 04 Oct 2024 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728057350; x=1728662150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsgdlqI1YjSaf2hjQX57eOCOui/ZtRhCSadX2PuXtI0=;
        b=arz3TUWMtvxmFxtwQMA7vUgUVl2WW4MlGBhewkipPOM0lo48IMdyX3GTTfRcJAEYBS
         hTl7x+0RT2LasJ7ZRK2OU3Sqh5S/SmQ847Q0uPTdCBqLHWm1y26+mQd2FRInFdWEENTS
         cXmMhm5fi2OZ9CF1eVcUKFOJvyiT9j1BHj+f9QIG+PEFMRhIU4EA+iTObJxgw+FaDV5u
         /M12Sc7jbtYltSgBq0BXWITfFTK4kHc5fHHt4fRiM5JQgSSudWrB6YmRnfeB3vXWDQbb
         wX+pcjRMg7QU+kIC8Y3aHEt4Ihrqj2rFo/cmc9jsWeoF7pva+qG5qrsoo34InmwDVT3D
         0hAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728057350; x=1728662150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsgdlqI1YjSaf2hjQX57eOCOui/ZtRhCSadX2PuXtI0=;
        b=pax/Hb+pkgHjuyhDL6hy45Ot3lUS1/0Ff5llJBx4FB2QwxNIfFLFj3bIGt5FRvG8ZB
         /jWlWH483YLzIzmxRuYGp2hSwxkfd5Qhk6n1o7vqVEoFymFUWIQEr4yULLQPm7HcMESZ
         SSVFYqddw1qU10PKjO8/Oe0W/jTZULfnrJE/c/iCleugn+fG05ybuGKXs2KB6BgcJl/y
         noDMXg2ILJ4TFEJLOrCB1gsMrgS4w7vr0xeKMldo/FLWt1Vqr9zuVk6R2pT3lM4Mz7e2
         03YIENKlG8yQO9oAb40T9C5LIwQMH1DcFgCzgqpoE+iidcwouFGn0dT/R11Dd78maqO+
         Ulgg==
X-Forwarded-Encrypted: i=1; AJvYcCUWc+UVYM3Nnuwkd97wRezkVXt7tzql7h0RzYhUy6qhtc5hfvHKuuUH/GH/eUtM4DAYuzp4Cx7ohxVZpqc=@vger.kernel.org, AJvYcCUnrTh3gmI8KGrOdxu/edZImnPoYKaMV+4uxUyLN3qyvNR5T8TLnS4/0N0j1dTY1uGQcuIm83xA@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIX43KGB0Jcsy0HIGexsTvUjIajJtvDSleg/352iZVDuTiGV2
	YZ9hswPL8er4aYcc6eFTnmAzWTXl2h9mgusmU+JCk8BDeAKSxY34iem6pkouNY8wHdBQLZ4jDQo
	Tp6gugbkZZUC/M4a6SLxagMffaKM=
X-Google-Smtp-Source: AGHT+IE1+ALhrfxE+7vJ3rstPkNZK5+mqKB3Ed/IXMiEy2VUyBOBJj9QvbRmwLnRt7fU0W2iXr5aihcesw1afW9Zs9U=
X-Received: by 2002:a05:6122:169c:b0:50a:bd10:e9a5 with SMTP id
 71dfb90a1353d-50c8547f0edmr2338209e0c.4.1728057350482; Fri, 04 Oct 2024
 08:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926211936.75373-1-21cnbao@gmail.com> <CANeU7QmSN_aVqgqNsCjqpGAZj5fAQJA90DVy1-duXxYicmPA+A@mail.gmail.com>
In-Reply-To: <CANeU7QmSN_aVqgqNsCjqpGAZj5fAQJA90DVy1-duXxYicmPA+A@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 4 Oct 2024 23:55:28 +0800
Message-ID: <CAGsJ_4xb+h7EVG8WQxt9BpAz6EYC4V+M9+ijw47Pt0-6iOZtog@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: Chris Li <chrisl@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	SeongJae Park <sj@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Oven Liyang <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 6:22=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Sep 26, 2024 at 2:20=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> > introduced an unconditional one-tick sleep when `swapcache_prepare()`
> > fails, which has led to reports of UI stuttering on latency-sensitive
> > Android devices. To address this, we can use a waitqueue to wake up
> > tasks that fail `swapcache_prepare()` sooner, instead of always
> > sleeping for a full tick. While tasks may occasionally be woken by an
> > unrelated `do_swap_page()`, this method is preferable to two scenarios:
> > rapid re-entry into page faults, which can cause livelocks, and
> > multiple millisecond sleeps, which visibly degrade user experience.
> >
> > Oven's testing shows that a single waitqueue resolves the UI
> > stuttering issue. If a 'thundering herd' problem becomes apparent
> > later, a waitqueue hash similar to `folio_wait_table[PAGE_WAIT_TABLE_SI=
ZE]`
> > for page bit locks can be introduced.
> >
> > Fixes: 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Oven Liyang <liyangouwen1@oppo.com>
> > Tested-by: Oven Liyang <liyangouwen1@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/memory.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2366578015ad..6913174f7f41 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4192,6 +4192,8 @@ static struct folio *alloc_swap_folio(struct vm_f=
ault *vmf)
> >  }
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > +static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
> > +
> >  /*
> >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >   * but allow concurrent faults), and pte mapped but not yet locked.
> > @@ -4204,6 +4206,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  {
> >         struct vm_area_struct *vma =3D vmf->vma;
> >         struct folio *swapcache, *folio =3D NULL;
> > +       DECLARE_WAITQUEUE(wait, current);
> >         struct page *page;
> >         struct swap_info_struct *si =3D NULL;
> >         rmap_t rmap_flags =3D RMAP_NONE;
> > @@ -4302,7 +4305,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                                          * Relax a bit to prevent rapid
> >                                          * repeated page faults.
> >                                          */
> > +                                       add_wait_queue(&swapcache_wq, &=
wait);
> >                                         schedule_timeout_uninterruptibl=
e(1);
> > +                                       remove_wait_queue(&swapcache_wq=
, &wait);
>
> There is only one "swapcache_wq", if we don't care about the memory
> overhead, ideally should be per swap entry that fails to grab the
> HAS_CACHE bit and has one wait queue. Currently all swap entries using
> one wait queue will likely cause other swap entries (if any) get wait
> up then find out the swap entry it cares hasn't been served yet.
>

even page bit locks do have a waitqueue for one page, i believe that
case has much serious contention then swap-in. page bit lock depends
on a waitqueue hash to decrease unrelated wake-up.

if one process is woken-up by unrelated do_swap_page() and its swapcache
is not released, it will sleep again after re-checking swapcache_prepare().

Too many unrelated wake-ups would be just a 'thundering herd' but not
a livelock.

> Another thing to consider is that, if we are using a wait queue, the
> 1ms is not relevant any more. It can be longer than 1ms and it is
> getting waited up by the wait queue anyway. Here you might use
> indefinitely sleep to reduce the unnecessary wait up and the
> complexity of the timer.

not quite sure what you mean for 1ms, in an embedded system, we never
use 1000HZ, the typical/maximum HZ is 250.  not quite sure what
you mean by "indefinitely sleep", my understanding is that we can't
poll the result of swapcache_prepare() as the winner process
which does swapcache_prepare() successfully will drop the
swap slots.

>
> >                                         goto out_page;
> >                                 }
> >                                 need_clear_cache =3D true;
> > @@ -4609,8 +4614,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  out:
> >         /* Clear the swap cache pin for direct swapin after PTL unlock =
*/
> > -       if (need_clear_cache)
> > +       if (need_clear_cache) {
> >                 swapcache_clear(si, entry, nr_pages);
> > +               wake_up(&swapcache_wq);
>
> Agree with Ying that here the common path will need to take a lock to
> wait up the wait queue.

waitqueue_active() might be a good candidate.

>
> Chris
>
>
> > +       }
> >         if (si)
> >                 put_swap_device(si);
> >         return ret;
> > @@ -4625,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 folio_unlock(swapcache);
> >                 folio_put(swapcache);
> >         }
> > -       if (need_clear_cache)
> > +       if (need_clear_cache) {
> >                 swapcache_clear(si, entry, nr_pages);
> > +               wake_up(&swapcache_wq);
> > +       }
> >         if (si)
> >                 put_swap_device(si);
> >         return ret;
> > --
> > 2.34.1
> >

Thanks
Barry

