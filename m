Return-Path: <stable+bounces-183638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A6BC69D4
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 080E64E1435
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81DF261586;
	Wed,  8 Oct 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNpYkMKZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675412AF1B
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956860; cv=none; b=sKEprX93IrnAANuvxfI5b/4pDO6v2WsbOb94hvwCYhGqvBrhkeRIhqV/Ihwpicyp0eipy+jkd9rUyyb7DkKHxfZJZC1LPmLLFY7Ic/bbaipIDK5FaAdO17DXn7UhyW2ERVL5ms9lEIEp9gv1OfkY9b8LeQguPXuB046LT+cTW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956860; c=relaxed/simple;
	bh=agL9NQjRm83/yHaWQQb9LP2YNW141HDrTz3t3n7+nWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=codbqsfH8V8Ri+jkn2r2fdjR/azgCJIKHPvhTCHg9XiQI/VMPtQTNWpBL5OoCZdzI//C4Em/rWf/l7lPF+CDL8vpDzEY0aSp4rki5DLOjArErOU2RPukFOUoDoNPh5E2tI6TehQCnnPR569OceCsbZ5tLAk9RwjQtOOJsaLIW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNpYkMKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1B1C116B1
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759956860;
	bh=agL9NQjRm83/yHaWQQb9LP2YNW141HDrTz3t3n7+nWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aNpYkMKZfCFMWJKhtFzH9ssZDk+h5QDwRDs6/raKHPcAjEdn5aAlINFU1ys/sGiE3
	 v0oOf3aZOVksaFkJyHY1P2B56MsfVxccy5i25BCfvczrn7YXWpCJKvQesr35u69+Sk
	 mbh7+wFiNRR6n4lZ3TETnyHaLccM8C43xfjOz5Datmuaqwvqh7kn+7j4OXcnYvoM5j
	 R+noBr0BQQK+dHuhCP6V0ldfVYyUkS5pXM5nJ4RxksOe0hbz8Uwc0hU1DwAwQbntoT
	 2sbikPEgHZCvPhlZK8ArXxkuNFD6+WFWLMn753uGqV1mLzXcMsmIENMnJ4uCDPnoiN
	 ppLiDdXRuMtew==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6354af028c6so359973d50.3
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 13:54:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyhdsX7/vHluXuRyTTvHw0STtVo656DalG//PrkmBdsspQ+Pgrxc3HM5j9JTZOUtM6u8TdgOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1o+qiCwZfNMJ/GwvqWllkwh9ymurveUUzU+1CmbOcrlomRsm
	OswPhznmYPth3gkJaa6OVQiI4SmlHSzKYpPMXduQftBClJovjlAuR6P+HGnflBG7kv5c4MSL3rJ
	lyThz6q8zHOf7KPUj31EJeWgmRDMlpVFrx64EjS52uw==
X-Google-Smtp-Source: AGHT+IGXcPsre3jPnzCXfW/NrHxTfes0Zrdq4yHGtjhgwz7kNPMXwSCxT4ITZ6YQG7WRPEjbYGDlrMXAh/E7qHIvmVo=
X-Received: by 2002:a05:690e:2486:b0:628:2e16:6566 with SMTP id
 956f58d0204a3-63ccb6763d1mr4749241d50.0.1759956859230; Wed, 08 Oct 2025
 13:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 8 Oct 2025 13:54:06 -0700
X-Gmail-Original-Message-ID: <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com>
X-Gm-Features: AS18NWDV4-kH86tXLtXJeQUM8aNsKlZYE7T0tTk3LlA5GEJjYTJActBrpZqaAP8
Message-ID: <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

First of all, your title is a bit misleading:
"do not perform synchronous discard during allocation"

You still do the synchronous discard, just limited to order 0 failing.

Also your commit did not describe the behavior change of this patch.
The behavior change is that, it now prefers to allocate from the
fragment list before waiting for the discard. Which I feel is not
justified.

After reading your patch, I feel that you still do the synchronous
discard, just now you do it with less lock held.
I suggest you just fix the lock held issue without changing the
discard ordering behavior.

On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
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

If lock is the issue, let's fix the lock issue.

> It's arguable whether this synchronous discard is helpful at all. In
> most cases, the async discard is good enough. And the swap allocator is
> doing very differently at organizing the clusters since the recent
> change, so it is very rare to see discard clusters piling up.

Very rare does not mean this never happens. If you have a cluster on
the discarding queue, I think it is better to wait for the discard to
complete before using the fragmented list, to reduce the
fragmentation. So it seems the real issue is holding a lock while
doing the block discard?

> So far, no issues have been observed or reported with typical SSD setups
> under months of high pressure. This issue was found during my code
> review. But by hacking the kernel a bit: adding a mdelay(100) in the
> async discard path, this issue will be observable with WARNING triggered
> by the wrong GFP and cond_resched in the bio layer.

I think that makes an assumption on how slow the SSD discard is. Some
SSD can be really slow. We want our kernel to work for those slow
discard SSD cases as well.

> So let's fix this issue in a safe way: remove the synchronous discard in
> the swap allocation path. And when order 0 is failing with all cluster
> list drained on all swap devices, try to do a discard following the swap

I don't feel that changing the discard behavior is justified here, the
real fix is discarding with less lock held. Am I missing something?
If I understand correctly, we should be able to keep the current
discard ordering behavior, discard before the fragment list. But with
less lock held as your current patch does.

I suggest the allocation here detects there is a discard pending and
running out of free blocks. Return there and indicate the need to
discard. The caller performs the discard without holding the lock,
similar to what you do with the order =3D=3D 0 case.

> device priority list. If any discards released some cluster, try the
> allocation again. This way, we can still avoid OOM due to swap failure
> if the hardware is very slow and memory pressure is extremely high.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation fast pa=
th")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cb2392ed8e0e..0d1924f6f495 100644
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

Assume you follow my suggestion.
Change this to some function to detect if there is a pending discard
on this device. Return to the caller indicating that you need a
discard for this device that has a pending discard.
Add an output argument to indicate the discard device "discard" if needed.

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

This function discards all swap devices. I am wondering if we should
just discard the current working device instead.
Another device supposedly discarded is already on going with the work
queue. We don't have to wait for that.

To unblock the current swap allocation.  We only need to wait for the
discard on the current swap device to indicate it needs to wait for
discard. Assume you take my above suggestion.

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
> +                       break;
> +               spin_lock(&swap_avail_lock);
> +       }
> +       spin_unlock(&swap_avail_lock);
> +
> +       return ret;
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

Here we can have a "discard" output function argument to indicate
which swap device needs to be discarded.

>         local_unlock(&percpu_swap_cluster.lock);
>
> +       if (unlikely(!order && !entry.val)) {

If you take the above suggestion, here will be just check if the
"discard" device is not NULL, perform discard on that device and done.

> +               if (swap_sync_discard())
> +                       goto again;
> +       }
> +
>         /* Need to call this even if allocation failed, for MEMCG_SWAP_FA=
IL. */
>         if (mem_cgroup_try_charge_swap(folio, entry))
>                 goto out_free;

Chris

