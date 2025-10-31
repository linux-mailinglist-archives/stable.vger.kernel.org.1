Return-Path: <stable+bounces-191952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82528C2675E
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 18:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622671883B35
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C13306B0D;
	Fri, 31 Oct 2025 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm/enWZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E632ED52
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932754; cv=none; b=hN2y2iphekME6WaGwJgQK8YJ2EBfxGO7GgctAlHKO0qpe0Pc0cUFHy5eEfmIgJTGfDr/kWwByyrliNTslD1+qNwcAMo9JaMmtSdCttbSRCdrRuLUqR8Jr3pZ4WtjFhNTMcK/eiRkrKf8lDDtaMpElzrUvFO+ix9dFymuhuT1vmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932754; c=relaxed/simple;
	bh=8Z5thQC+rZDV7YQzns00IgbOSJUd9ppvWPw+j4n6pWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR66jY2PJnBqxmix+RikdyCW5Zqz5nljms8kmPh2jP07L2HVGsTa+HmtOFjk56OhPn1DH2vRARC1Twi7rU0dXTfIjJi5FiUNQDmdJXK4YsuuwFHgcmvwqq2augKh6/3rKxl2ThfgzG1GBA6/E4lGwI1Cel0qvTF0565TNoJH2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm/enWZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373D3C4CEF1
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761932753;
	bh=8Z5thQC+rZDV7YQzns00IgbOSJUd9ppvWPw+j4n6pWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mm/enWZAWMDexVX/fM2kYROrmhHpBdzm8nbycEeWDHnO8PA6XXIyNOcJjSWX8bZqn
	 2OdmViUgwKEHTRFYwD5BgZE10XvwxitQi0+ZD61Nzq8aRrVN2lMfT03tG+dKxr1NYQ
	 K92snLHJa+AlDf0mSJvP6DfsWKAU1JkCDOWJF4f6IdAMKIjiKHTH1OLq/3cbELc3DJ
	 wvZCVb1xLk7serWJIZ67u1/RPAd2BS9tZe3GOIFRxb/9dGq4FBY/c/d2Sdm4UkrBLG
	 jF4OR3sbBwvEi1O9WI/OFg/DyDSuQWE5/dryDqJh6Zs3mEygo8hMwQ1rtwsGhBg/iR
	 /i9CZ8dqZ4bkg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786572c14e3so5321687b3.2
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 10:45:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXrWnWJc4iNJT3ZKdZv04XQLDEA0T/hr2T6LVUsh7Y1glUzoEcYUA4UPZSdVMojO2c/mHV5VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1cjB9VR1ab+XBe5PkhFFK1S02tnCnU/VUQiBPHeVUZm1q6xP8
	bUuVEpJB/gVYYQlJjOcAJJpmyUmEvZmMT0CbQLvUcNJ4wKvb+BGq9KXcYA7oGs1O+MuWm5Peujb
	HyEpC8SoODXeX3VGDX4cKhHPy9/WlrR32PlDtWaS+qw==
X-Google-Smtp-Source: AGHT+IFqrgTBfMBmVRiXWO3Rn5PwN2T0UvwtVFKxReo6CBC7EejYTOkW7+aB0EyRLa858pu/9lZjhalDMoVSb2xP8ow=
X-Received: by 2002:a05:690c:dd5:b0:785:bfd8:c4c6 with SMTP id
 00721157ae682-78648526568mr44021407b3.49.1761932752205; Fri, 31 Oct 2025
 10:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-swap-clean-after-swap-table-p1-v2-0-c5b0e1092927@tencent.com>
 <20251024-swap-clean-after-swap-table-p1-v2-1-c5b0e1092927@tencent.com>
In-Reply-To: <20251024-swap-clean-after-swap-table-p1-v2-1-c5b0e1092927@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 31 Oct 2025 10:45:40 -0700
X-Gmail-Original-Message-ID: <CACePvbVEaRzFet1_PcRP32MUcDs9M+5-Ssw04dYbLUCgMygBZw@mail.gmail.com>
X-Gm-Features: AWmQ_bkBLbpzK-7LQwl8d_11rWtB-YUCktamd5vXceO5ofoa6GX9KxB-9BfXeC4
Message-ID: <CACePvbVEaRzFet1_PcRP32MUcDs9M+5-Ssw04dYbLUCgMygBZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm, swap: do not perform synchronous discard
 during allocation
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	YoungJun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Since commit 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation
> fast path"), swap allocation is protected by a local lock, which means
> we can't do any sleeping calls during allocation.
>
> However, the discard routine is not taken well care of. When the swap
> allocator failed to find any usable cluster, it would look at the
> pending discard cluster and try to issue some blocking discards. It may
> not necessarily sleep, but the cond_resched at the bio layer indicates
> this is wrong when combined with a local lock. And the bio GFP flag used
> for discard bio is also wrong (not atomic).
>
> It's arguable whether this synchronous discard is helpful at all. In
> most cases, the async discard is good enough. And the swap allocator is
> doing very differently at organizing the clusters since the recent
> change, so it is very rare to see discard clusters piling up.
>
> So far, no issues have been observed or reported with typical SSD setups
> under months of high pressure. This issue was found during my code
> review. But by hacking the kernel a bit: adding a mdelay(500) in the
> async discard path, this issue will be observable with WARNING triggered
> by the wrong GFP and cond_resched in the bio layer for debug builds.
>
> So now let's apply a hotfix for this issue: remove the synchronous
> discard in the swap allocation path. And when order 0 is failing with
> all cluster list drained on all swap devices, try to do a discard
> following the swap device priority list. If any discards released some
> cluster, try the allocation again. This way, we can still avoid OOM due
> to swap failure if the hardware is very slow and memory pressure is
> extremely high.
>
> This may cause more fragmentation issues if the discarding hardware is
> really slow. Ideally, we want to discard pending clusters before
> continuing to iterate the fragment cluster lists. This can be
> implemented in a cleaner way if we clean up the device list iteration
> part first.
>
> Cc: stable@vger.kernel.org
> Fixes: 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation fast pa=
th")
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris


> ---
>  mm/swapfile.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cb2392ed8e0e..33e0bd905c55 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_swap_entry(stru=
ct swap_info_struct *si, int o
>                         goto done;
>         }
>
> -       /*
> -        * We don't have free cluster but have some clusters in discardin=
g,
> -        * do discard now and reclaim them.
> -        */
> -       if ((si->flags & SWP_PAGE_DISCARD) && swap_do_scheduled_discard(s=
i))
> -               goto new_cluster;
> -
>         if (order)
>                 goto done;
>
> @@ -1394,6 +1387,33 @@ static bool swap_alloc_slow(swp_entry_t *entry,
>         return false;
>  }
>
> +/*
> + * Discard pending clusters in a synchronized way when under high pressu=
re.
> + * Return: true if any cluster is discarded.
> + */
> +static bool swap_sync_discard(void)
> +{
> +       bool ret =3D false;
> +       int nid =3D numa_node_id();
> +       struct swap_info_struct *si, *next;
> +
> +       spin_lock(&swap_avail_lock);
> +       plist_for_each_entry_safe(si, next, &swap_avail_heads[nid], avail=
_lists[nid]) {
> +               spin_unlock(&swap_avail_lock);
> +               if (get_swap_device_info(si)) {
> +                       if (si->flags & SWP_PAGE_DISCARD)
> +                               ret =3D swap_do_scheduled_discard(si);
> +                       put_swap_device(si);
> +               }
> +               if (ret)
> +                       return true;
> +               spin_lock(&swap_avail_lock);
> +       }
> +       spin_unlock(&swap_avail_lock);
> +
> +       return false;
> +}
> +
>  /**
>   * folio_alloc_swap - allocate swap space for a folio
>   * @folio: folio we want to move to swap
> @@ -1432,11 +1452,17 @@ int folio_alloc_swap(struct folio *folio, gfp_t g=
fp)
>                 }
>         }
>
> +again:
>         local_lock(&percpu_swap_cluster.lock);
>         if (!swap_alloc_fast(&entry, order))
>                 swap_alloc_slow(&entry, order);
>         local_unlock(&percpu_swap_cluster.lock);
>
> +       if (unlikely(!order && !entry.val)) {
> +               if (swap_sync_discard())
> +                       goto again;
> +       }
> +
>         /* Need to call this even if allocation failed, for MEMCG_SWAP_FA=
IL. */
>         if (mem_cgroup_try_charge_swap(folio, entry))
>                 goto out_free;
>
> --
> 2.51.0
>

