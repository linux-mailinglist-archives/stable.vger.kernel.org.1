Return-Path: <stable+bounces-80698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56098FA1F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326D11F241A8
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAC1CEEB8;
	Thu,  3 Oct 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZHduKmD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CB1BF7E8;
	Thu,  3 Oct 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996002; cv=none; b=PWPc9afN3tXr63nGBmkh68A5X+dlzEFZS/9WuIDT9AamyMCfk6mSi8Qg67CO7Ew4FCWkMqsNct4BC9jFErfdXm7z570E1ao6OFMcq6/cbKLU3HfutM6ltT+wY4V1mlAvYpWPvlZBOXiYJh2KfJ6dUWat2M8pUHP6coB3Y1D/j+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996002; c=relaxed/simple;
	bh=4bJMo3nY1xRUsay/YRYhzZ06Bs7qNKhJKTAP88z7bJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK9i0l5PfaB9eXljND64q6RtwLY3zvluJ0+XlL2Wf+pd+OZ/CKLi6GgbMki1d68EA2jj+npuGYnKRu4PJg0LW4fu/LpsrT1g5lpXR5KgriXSr0FBfV+yIXGPg4ytN15U98LumGpOpdchZf59pzz+sf+5IpdOnN8lKM7d6WO9ARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZHduKmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A61C4CED4;
	Thu,  3 Oct 2024 22:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727996002;
	bh=4bJMo3nY1xRUsay/YRYhzZ06Bs7qNKhJKTAP88z7bJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CZHduKmDCTyR7JvENGL1Uwi56iVsTmKUAdMtOKYnIGOtFoGWBJUKHt5lqut8xUSAS
	 TusLJQjoxJFyldndr2sH0VrFC3iij6Qr/3I2eIp5V/owh3kzqbpDroMovd45GCzdMo
	 kJtiBApYIPeyI8DcZyyzycoSSfARM9Kfr2iK6I5rdBs3GBwGPtxb7TLb+W0qYVJhUH
	 zn+Q1bEswsViM+CFwFIskBYCws4qJZFFkbwJJLk44T5fgPFCSFqi5VQCWXJsduxPJA
	 COV2q/UL6/BrQtZWbh9pc7ya3dUJaf0dK952+aHzMzd2tOVVUmSxdje1SZWV2DZfde
	 TfLNcqcuqoaSg==
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6b738acd5so482105a12.0;
        Thu, 03 Oct 2024 15:53:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHueVXDZn9vbnk7I40TWp9Mg0G6p8442sFHyi9R/hK8eBxRKR9Qs7twpJDJyQjqRJuqdB0b9Pk@vger.kernel.org, AJvYcCVzLnaipfjOF1ZXsDVWLPAdhCYpWAh7AaZCkJSSFm//f0tGHb2lsGGpWpUcNWjbD+q3Vpffo1kUI830/VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Sbs5nNgMzPUW24YUIMUIvYrFt1rN0dwg2Aucvc3aLevIVY2L
	f79YPb6P4Q8JSA3/MR8kmmdk5frzoeDkacBUw97A8RK97jHXzG/x3QoBkteWpWk6mDwaYKPpvQO
	/6QE5fcTrJAGplT+pQ2wRvYyGBw==
X-Google-Smtp-Source: AGHT+IHwBHVQvp8FWHCls9Tq0SBa/jR7+ZyLMQ4+TxpzM+WzigjxlqXGYgIyiUXyXyVVY+pUYTbFZqkqhH3Hsq6W+pA=
X-Received: by 2002:a05:6a21:680d:b0:1d2:e84a:2cb0 with SMTP id
 adf61e73a8af0-1d6dfa20986mr1168955637.10.1727996001662; Thu, 03 Oct 2024
 15:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com> <20241002015754.969-1-21cnbao@gmail.com>
In-Reply-To: <20241002015754.969-1-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 3 Oct 2024 15:53:08 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=FkkMByY2DgtcZfn=UOAygzK7xLJKR4GUx+sdo-bxq9w@mail.gmail.com>
Message-ID: <CANeU7Q=FkkMByY2DgtcZfn=UOAygzK7xLJKR4GUx+sdo-bxq9w@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: Barry Song <21cnbao@gmail.com>
Cc: ying.huang@intel.com, akpm@linux-foundation.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liyangouwen1@oppo.com, mhocko@suse.com, minchan@kernel.org, sj@kernel.org, 
	stable@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:58=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
> > >>
> > >> Barry Song <21cnbao@gmail.com> writes:
> > >>
> > >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@in=
tel.com> wrote:
> > >> >>
> > >> >> Hi, Barry,
> > >> >>
> > >> >> Barry Song <21cnbao@gmail.com> writes:
> > >> >>
> > >> >> > From: Barry Song <v-songbaohua@oppo.com>
> > >> >> >
> > >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache=
")
> > >> >> > introduced an unconditional one-tick sleep when `swapcache_prep=
are()`
> > >> >> > fails, which has led to reports of UI stuttering on latency-sen=
sitive
> > >> >> > Android devices. To address this, we can use a waitqueue to wak=
e up
> > >> >> > tasks that fail `swapcache_prepare()` sooner, instead of always
> > >> >> > sleeping for a full tick. While tasks may occasionally be woken=
 by an
> > >> >> > unrelated `do_swap_page()`, this method is preferable to two sc=
enarios:
> > >> >> > rapid re-entry into page faults, which can cause livelocks, and
> > >> >> > multiple millisecond sleeps, which visibly degrade user experie=
nce.
> > >> >>
> > >> >> In general, I think that this works.  Why not extend the solution=
 to
> > >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_asy=
nc()
> > >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avo=
id
> > >> >
> > >> > Hi Ying,
> > >> > Thanks for your comments.
> > >> > I feel extending the solution to __read_swap_cache_async() should =
be done
> > >> > in a separate patch. On phones, I've never encountered any issues =
reported
> > >> > on that path, so it might be better suited for an optimization rat=
her than a
> > >> > hotfix?
> > >>
> > >> Yes.  It's fine to do that in another patch as optimization.
> > >
> > > Ok. I'll prepare a separate patch for optimizing that path.
> >
> > Thanks!
> >
> > >>
> > >> >> overhead to call wake_up() when there's no task waiting, we can u=
se an
> > >> >> atomic to count waiting tasks.
> > >> >
> > >> > I'm not sure it's worth adding the complexity, as wake_up() on an =
empty
> > >> > waitqueue should have a very low cost on its own?
> > >>
> > >> wake_up() needs to call spin_lock_irqsave() unconditionally on a glo=
bal
> > >> shared lock.  On systems with many CPUs (such servers), this may cau=
se
> > >> severe lock contention.  Even the cache ping-pong may hurt performan=
ce
> > >> much.
> > >
> > > I understand that cache synchronization was a significant issue befor=
e
> > > qspinlock, but it seems to be less of a concern after its implementat=
ion.
> >
> > Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
> > discussed in the following thread.
> >
> > https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programming=
.kicks-ass.net/
> >
> > > However, using a global atomic variable would still trigger cache bro=
adcasts,
> > > correct?
> >
> > We can only change the atomic variable to non-zero when
> > swapcache_prepare() returns non-zero, and call wake_up() when the atomi=
c
> > variable is non-zero.  Because swapcache_prepare() returns 0 most times=
,
> > the atomic variable is 0 most times.  If we don't change the value of
> > atomic variable, cache ping-pong will not be triggered.
>
> yes. this can be implemented by adding another atomic variable.
>
> >
> > Hi, Kairui,
> >
> > Do you have some test cases to test parallel zram swap-in?  If so, that
> > can be used to verify whether cache ping-pong is an issue and whether i=
t
> > can be fixed via a global atomic variable.
> >
>
> Yes, Kairui please run a test on your machine with lots of cores before
> and after adding a global atomic variable as suggested by Ying. I am
> sorry I don't have a server machine.
>
> if it turns out you find cache ping-pong can be an issue, another
> approach would be a waitqueue hash:
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 2366578015ad..aae0e532d8b6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4192,6 +4192,23 @@ static struct folio *alloc_swap_folio(struct vm_fa=
ult *vmf)
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> +/*
> + * Alleviating the 'thundering herd' phenomenon using a waitqueue hash
> + * when multiple do_swap_page() operations occur simultaneously.
> + */
> +#define SWAPCACHE_WAIT_TABLE_BITS 5
> +#define SWAPCACHE_WAIT_TABLE_SIZE (1 << SWAPCACHE_WAIT_TABLE_BITS)
> +static wait_queue_head_t swapcache_wqs[SWAPCACHE_WAIT_TABLE_SIZE];
> +
> +static int __init swapcache_wqs_init(void)
> +{
> +       for (int i =3D 0; i < SWAPCACHE_WAIT_TABLE_SIZE; i++)
> +               init_waitqueue_head(&swapcache_wqs[i]);
> +
> +        return 0;
> +}
> +late_initcall(swapcache_wqs_init);
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4204,6 +4221,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>         struct folio *swapcache, *folio =3D NULL;
> +       DECLARE_WAITQUEUE(wait, current);
> +       wait_queue_head_t *swapcache_wq;
>         struct page *page;
>         struct swap_info_struct *si =3D NULL;
>         rmap_t rmap_flags =3D RMAP_NONE;
> @@ -4297,12 +4316,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                                  * undetectable as pte_same() returns tru=
e due
>                                  * to entry reuse.
>                                  */
> +                               swapcache_wq =3D &swapcache_wqs[hash_long=
(vmf->address & PMD_MASK,
> +                                                       SWAPCACHE_WAIT_TA=
BLE_BITS)];

It is better to hash against the swap entry value rather than the
fault address. Same swap entries can map to different parts of the
page table. I am not sure this is triggerable in the SYNC_IO page
fault path, hash against the swap entries is more obviously correct.

Chris

>                                 if (swapcache_prepare(entry, nr_pages)) {
>                                         /*
>                                          * Relax a bit to prevent rapid
>                                          * repeated page faults.
>                                          */
> +                                       add_wait_queue(swapcache_wq, &wai=
t);
>                                         schedule_timeout_uninterruptible(=
1);
> +                                       remove_wait_queue(swapcache_wq, &=
wait);
>                                         goto out_page;
>                                 }
>                                 need_clear_cache =3D true;
> @@ -4609,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
>         /* Clear the swap cache pin for direct swapin after PTL unlock */
> -       if (need_clear_cache)
> +       if (need_clear_cache) {
>                 swapcache_clear(si, entry, nr_pages);
> +               wake_up(swapcache_wq);
> +       }
>         if (si)
>                 put_swap_device(si);
>         return ret;
> @@ -4625,8 +4650,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_unlock(swapcache);
>                 folio_put(swapcache);
>         }
> -       if (need_clear_cache)
> +       if (need_clear_cache) {
>                 swapcache_clear(si, entry, nr_pages);
> +               wake_up(swapcache_wq);
> +       }
>         if (si)
>                 put_swap_device(si);
>         return ret;
> --
> 2.34.1
>
> > --
> > Best Regards,
> > Huang, Ying
>
> Thanks
> Barry

