Return-Path: <stable+bounces-80694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2BD98F9CB
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A3F1C21F66
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F61CC143;
	Thu,  3 Oct 2024 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqPSvSiC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32E824BD;
	Thu,  3 Oct 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994171; cv=none; b=XMxJXruKxm+GuFiwyOXZ4JF2wyEE8+4sXjborEIA+7Huvm6PnupACt1Uznona8/NnDYygBjwajBpeCzAoYeHzogL8tA6zR60KYryflgJlyGQAul5xb7rZM8v9tDhdJM6fAH0XNU0pHIW9G+r+rev2on7acQL2DJE26xqpEbO4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994171; c=relaxed/simple;
	bh=DnmNpmJQQm4NYVqRCGy9i/+/Ig4LR3+hm92QTLY1nbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpCN0+memb5hU1lUdns4dqqA5AUPeytyR5fXjVQkLTBMVdfhwTuwT4w0aWOFujeUQRdEoiDfDejFnU09iE5h9zp3IO/Jg+9SuTUplpA3Ce4i20Gf/6Q9dNL7Pb3lErfEPGW5IWVADxRzAcVxuqwaGXMMsDPvKrtljPsOgLCAXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqPSvSiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B28C4CED2;
	Thu,  3 Oct 2024 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727994170;
	bh=DnmNpmJQQm4NYVqRCGy9i/+/Ig4LR3+hm92QTLY1nbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GqPSvSiCq2147idnMn/x14O0AwRI3NfzoPIRTQierj7doff6M7aeiGRWFiirfIgdc
	 99PyQ51AbiikWvguscediIN2n90aes+j9Eq34uGln8WDAw1bfzvxRHYCrG+vbXSUdu
	 XpWfms4Y7NbnT8xoykZYRZfSVcSBHaX6WVq8lMt1pyXmdxYMVfH8cAjCouJ5pFgGt8
	 ++0N1NV3jo2EDn/8RACAH9MHUYSVL7Mp9k6fBEIPysFYNFktRl/tXE+g2vDsE5K257
	 pMkT+C5M1Wbxmu42Rwc/8h4KuCECHsrqsQGqBXEIuHLotRQ+5/VS56wTBe/XqJCnPI
	 mZiXypv771ZWA==
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71ddfc61c78so525495b3a.2;
        Thu, 03 Oct 2024 15:22:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlIMW6vVVIMzxgmhdLqtz1yjcsKdDyan4ircGJ+pVf4ZFeLU+o7DOq04C7Tr4BOlyjFzwYwoRPR098Ih8=@vger.kernel.org, AJvYcCWl3L0Aftt1iFg2hvG07LuX+gXw63IfQWv+T1WZjnLa/txpbzmc0BDL5btNlaPHrTi3hctaOd/w@vger.kernel.org
X-Gm-Message-State: AOJu0YzgkR1ePtf4ElUf2KTIBPwDYS0erFMsKS7VFW7TTbdCKGKy16Iq
	k7ecLAdxWd3h6n3Vz+fTMo0rCOOOKYT8AuoDz0K9Azie25iOhNie1+vX2yVcawqF5eBfJgcZYcx
	LUhLL/U7vCq0tzAL9Ag08x8er2w==
X-Google-Smtp-Source: AGHT+IGXo32/Wh1/RnyGtZO6Dr70hFaqnlQ4oOJucQ6j4BO6HwCW3L6ykIiixFLWJmfsoSmkM6UJ8UOdzPUIKxY03BA=
X-Received: by 2002:a05:6a00:4b0a:b0:71d:d1b7:8dba with SMTP id
 d2e1a72fcca58-71de24454cfmr729394b3a.18.1727994169992; Thu, 03 Oct 2024
 15:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926211936.75373-1-21cnbao@gmail.com>
In-Reply-To: <20240926211936.75373-1-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 3 Oct 2024 15:22:36 -0700
X-Gmail-Original-Message-ID: <CANeU7QmSN_aVqgqNsCjqpGAZj5fAQJA90DVy1-duXxYicmPA+A@mail.gmail.com>
Message-ID: <CANeU7QmSN_aVqgqNsCjqpGAZj5fAQJA90DVy1-duXxYicmPA+A@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: Barry Song <21cnbao@gmail.com>
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

On Thu, Sep 26, 2024 at 2:20=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> introduced an unconditional one-tick sleep when `swapcache_prepare()`
> fails, which has led to reports of UI stuttering on latency-sensitive
> Android devices. To address this, we can use a waitqueue to wake up
> tasks that fail `swapcache_prepare()` sooner, instead of always
> sleeping for a full tick. While tasks may occasionally be woken by an
> unrelated `do_swap_page()`, this method is preferable to two scenarios:
> rapid re-entry into page faults, which can cause livelocks, and
> multiple millisecond sleeps, which visibly degrade user experience.
>
> Oven's testing shows that a single waitqueue resolves the UI
> stuttering issue. If a 'thundering herd' problem becomes apparent
> later, a waitqueue hash similar to `folio_wait_table[PAGE_WAIT_TABLE_SIZE=
]`
> for page bit locks can be introduced.
>
> Fixes: 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> Cc: Kairui Song <kasong@tencent.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: <stable@vger.kernel.org>
> Reported-by: Oven Liyang <liyangouwen1@oppo.com>
> Tested-by: Oven Liyang <liyangouwen1@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 2366578015ad..6913174f7f41 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4192,6 +4192,8 @@ static struct folio *alloc_swap_folio(struct vm_fau=
lt *vmf)
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> +static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4204,6 +4206,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>         struct folio *swapcache, *folio =3D NULL;
> +       DECLARE_WAITQUEUE(wait, current);
>         struct page *page;
>         struct swap_info_struct *si =3D NULL;
>         rmap_t rmap_flags =3D RMAP_NONE;
> @@ -4302,7 +4305,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                                          * Relax a bit to prevent rapid
>                                          * repeated page faults.
>                                          */
> +                                       add_wait_queue(&swapcache_wq, &wa=
it);
>                                         schedule_timeout_uninterruptible(=
1);
> +                                       remove_wait_queue(&swapcache_wq, =
&wait);

There is only one "swapcache_wq", if we don't care about the memory
overhead, ideally should be per swap entry that fails to grab the
HAS_CACHE bit and has one wait queue. Currently all swap entries using
one wait queue will likely cause other swap entries (if any) get wait
up then find out the swap entry it cares hasn't been served yet.

Another thing to consider is that, if we are using a wait queue, the
1ms is not relevant any more. It can be longer than 1ms and it is
getting waited up by the wait queue anyway. Here you might use
indefinitely sleep to reduce the unnecessary wait up and the
complexity of the timer.

>                                         goto out_page;
>                                 }
>                                 need_clear_cache =3D true;
> @@ -4609,8 +4614,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
>         /* Clear the swap cache pin for direct swapin after PTL unlock */
> -       if (need_clear_cache)
> +       if (need_clear_cache) {
>                 swapcache_clear(si, entry, nr_pages);
> +               wake_up(&swapcache_wq);

Agree with Ying that here the common path will need to take a lock to
wait up the wait queue.

Chris


> +       }
>         if (si)
>                 put_swap_device(si);
>         return ret;
> @@ -4625,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_unlock(swapcache);
>                 folio_put(swapcache);
>         }
> -       if (need_clear_cache)
> +       if (need_clear_cache) {
>                 swapcache_clear(si, entry, nr_pages);
> +               wake_up(&swapcache_wq);
> +       }
>         if (si)
>                 put_swap_device(si);
>         return ret;
> --
> 2.34.1
>

