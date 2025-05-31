Return-Path: <stable+bounces-148337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E256CAC992F
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1305C9E6C93
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 04:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AB28C00C;
	Sat, 31 May 2025 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1hwh6BZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028D28BAA1;
	Sat, 31 May 2025 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748664278; cv=none; b=EAVXQ/WQqgLNCc0Hg2gl5BTO6PZDRpsMlbxPxZ9f9AzkmwkoJRK+tgb2/pANbwsrXfe8oB87yQ2Bs1uCHjq0vXAWZyXXtusmxXiO2KBrz11XUNUm1KOUWRZWBquxR0u3JqCEZqohW+YLnQD+cjRWuCbCef8outDdem5ccwLrFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748664278; c=relaxed/simple;
	bh=YCeO0F+RUKzNa0Jf9Wd6Z3HXEOdDeIYhoeloLH7bkRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFbWWEJkTMDYtlEMP22FLOaPDTc4Xv0TDNeOL20ouaGv4YHU+/z7ilR6GQq1QXWUtNf4sr5W+4NUFddepiaDr3rsA2A2FkmXNEiAm4uCWzoReXkzgCHVKddUl2e5aZ2gBUzQhRj9xhEIW4xifD0HlT44jFKosyZkqda3XZQpm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1hwh6BZ; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e58d270436so852501137.3;
        Fri, 30 May 2025 21:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748664275; x=1749269075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS5pE0o8S+sA9vSGdXa1WZSHPdE9yG19o8VINjXy5hc=;
        b=J1hwh6BZdrQPcjHRyWwkUWCQ1JtUUcrPvuqaH/qZJ8aCO8fXK6KteOLUwAzSmH1NwI
         HNGuWua5CQC6IcoifoQG5tcixuGy2NWZOiJZp6Qlv0X+UtJL8rKyJGwIlQFpfZXt5W2S
         oZb/aVoixH/q7MWDSzZ/nHz9daOIdGluMDTkP5v4gyfZVfj8/MSvB6xtzb0NtwT5ZJNi
         60oZcL/E7JrizTaNm6fhK+WX1rBoJbW7H6IqHbKCsbHMWouPr5GPocLiMRCDTTA7YMnB
         UbN68cf8e42aH85ouFCC1OZ/Y1sEgRJfasM/ZBR1pw0TDsJy2TdgEQLxrBIMT0rxNsAI
         g3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748664275; x=1749269075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS5pE0o8S+sA9vSGdXa1WZSHPdE9yG19o8VINjXy5hc=;
        b=osW0VvAaMWvf3csLBDLV+HaRh7sVjmQfBNDT/1Dxf6sx3XohpP3nb5GgdDphMVspn7
         +W6BzkMdMGmLdaF/74xzSHytgqFD+LZwpBZ1GmHj/VMsQ0aCQ6mELbtsPzgvmEYVNN0K
         DgjGCcARRdP5eABQ0NELY+tkdzT0C8nlE2tX/NxEgzjoj4CUCDlq/1gUaFjXizfRYH3U
         8osvivkzsOFJM42EM554u0MsnGYd6tgypa4Lh1jK2aZryAZQgs1YqSXKdnKJDXNIGvDG
         Y0+VoUwGdhVK2fPKY9cwYybQOLBLtjdcRDWyhAK+rLI4ZQ4+FhWyw/QcM++/CrFH3lta
         F4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrYMyVFQ8UzIztdDDNMz6WI91ZeQqIUIyN61xfIj3gksHl38Rl91lpwa9owdJFQ7+gzjUBhYx1@vger.kernel.org, AJvYcCWmyKFFBftivJ6+1KndiCZZWbcH9SvSTPsxo1JWQY30Dp7G35lxWDZjvpfk722i91cvsDV8yezVOCcr1j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qh/sXVVSNxm9dFsWkHAK/4d8vSGQ9E7VrxuF6iWLS0P3iwR7
	5OfE3lQ9e00KZDLfP3iL3we6lVHs0BbGGQhjzbnrlx/B8L1E3HGXaU8J7ovJgffqzO/mE5Zc6LT
	uh7OQ12Vpi3qsXSKqt7wk1Aaodc2cL/o=
X-Gm-Gg: ASbGncsyjrAtY6YetbQaalb69ZdcYjDEKiSmbSg47a1yBgUFAngbCveOfrqA+xa+eHc
	l8hUvL+HfcgG7TSAymkoF6dp0pMtxHlz3Ees1egauSm/ThvN9Etfo3yPh0Xs+SLlL3coLPGOZwA
	YxH6VZhnoZ/nUZ1+gBRr9I1OJZEpLXBXWSjw==
X-Google-Smtp-Source: AGHT+IHIKNydtAt4W0TBhkJoaIkTJR5s9EqiEIjLFeZby8tWyvq4kiBnHdPvnCyp44lvW7H/Gde1X8aDqKUixQwPWJQ=
X-Received: by 2002:a05:6102:3a0f:b0:4e5:babd:310b with SMTP id
 ada2fe7eead31-4e6e40f5bd4mr6051531137.10.1748664274957; Fri, 30 May 2025
 21:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com>
In-Reply-To: <20250530201710.81365-1-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 May 2025 16:04:24 +1200
X-Gm-Features: AX0GCFskxNAvcUu96I0HwtH4Vknv2CO5MuXPf8gnIuGqNINOVuNLXEaUl6id648
Message-ID: <CAGsJ_4wBMxQSeoTwpKoWwEGRAr=iohbYf64aYyJ55t0Z11FkwA@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 8:17=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> On seeing a swap entry PTE, userfaultfd_move does a lockless swap cache
> lookup, and try to move the found folio to the faulting vma when.
> Currently, it relies on the PTE value check to ensure the moved folio
> still belongs to the src swap entry, which turns out is not reliable.
>
> While working and reviewing the swap table series with Barry, following
> existing race is observed and reproduced [1]:
>
> ( move_pages_pte is moving src_pte to dst_pte, where src_pte is a
>  swap entry PTE holding swap entry S1, and S1 isn't in the swap cache.)
>
> CPU1                               CPU2
> userfaultfd_move
>   move_pages_pte()
>     entry =3D pte_to_swp_entry(orig_src_pte);
>     // Here it got entry =3D S1
>     ... < Somehow interrupted> ...
>                                    <swapin src_pte, alloc and use folio A=
>
>                                    // folio A is just a new allocated fol=
io
>                                    // and get installed into src_pte
>                                    <frees swap entry S1>
>                                    // src_pte now points to folio A, S1
>                                    // has swap count =3D=3D 0, it can be =
freed
>                                    // by folio_swap_swap or swap
>                                    // allocator's reclaim.
>                                    <try to swap out another folio B>
>                                    // folio B is a folio in another VMA.
>                                    <put folio B to swap cache using S1 >
>                                    // S1 is freed, folio B could use it
>                                    // for swap out with no problem.
>                                    ...
>     folio =3D filemap_get_folio(S1)
>     // Got folio B here !!!
>     ... < Somehow interrupted again> ...
>                                    <swapin folio B and free S1>
>                                    // Now S1 is free to be used again.
>                                    <swapout src_pte & folio A using S1>
>                                    // Now src_pte is a swap entry pte
>                                    // holding S1 again.
>     folio_trylock(folio)
>     move_swap_pte
>       double_pt_lock
>       is_pte_pages_stable
>       // Check passed because src_pte =3D=3D S1
>       folio_move_anon_rmap(...)
>       // Moved invalid folio B here !!!
>
> The race window is very short and requires multiple collisions of
> multiple rare events, so it's very unlikely to happen, but with a
> deliberately constructed reproducer and increased time window, it can be
> reproduced [1].
>
> It's also possible that folio (A) is swapped in, and swapped out again
> after the filemap_get_folio lookup, in such case folio (A) may stay in
> swap cache so it needs to be moved too. In this case we should also try
> again so kernel won't miss a folio move.
>
> Fix this by checking if the folio is the valid swap cache folio after
> acquiring the folio lock, and checking the swap cache again after
> acquiring the src_pte lock.
>
> SWP_SYNCRHONIZE_IO path does make the problem more complex, but so far
> we don't need to worry about that since folios only might get exposed to
> swap cache in the swap out path, and it's covered in this patch too by
> checking the swap cache again after acquiring src_pte lock.
>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+EJ=
t+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bc473ad21202..a1564d205dfb 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -15,6 +15,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/hugetlb.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/delay.h>
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_struct *mm, stru=
ct vm_area_struct *dst_vma,
>                          spinlock_t *dst_ptl, spinlock_t *src_ptl,
>                          struct folio *src_folio)
>  {
> +       swp_entry_t entry;
> +
>         double_pt_lock(dst_ptl, src_ptl);
>
>         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> @@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_struct *mm, str=
uct vm_area_struct *dst_vma,
>         if (src_folio) {
>                 folio_move_anon_rmap(src_folio, dst_vma);
>                 src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> +       } else {
> +               /*
> +                * Check again after acquiring the src_pte lock. Or we mi=
ght
> +                * miss a new loaded swap cache folio.
> +                */
> +               entry =3D pte_to_swp_entry(orig_src_pte);
> +               src_folio =3D filemap_get_folio(swap_address_space(entry)=
,
> +                                             swap_cache_index(entry));
> +               if (!IS_ERR_OR_NULL(src_folio)) {
> +                       double_pt_unlock(dst_ptl, src_ptl);
> +                       folio_put(src_folio);
> +                       return -EAGAIN;
> +               }
>         }

step 1: src pte points to a swap entry without swapcache
step 2: we call move_swap_pte()
step 3: someone swap-in src_pte by swap_readhead() and make src_pte's swap =
entry
have swapcache again - for non-sync/non-zRAM swap device;
step 4: move_swap_pte() gets ptl, move src_pte to dst_pte and *clear* src_p=
te;
step 5: do_swap_page() for src_pte holds the ptl and found pte has
been cleared in
            step 4; pte_same() returns false;
step 6: do_swap_page() won't map src_pte to the new swapcache got from step=
 3;
            if the swapcache folio is dropped, it seems everything is fine.

So the real issue is that do_swap_page() doesn=E2=80=99t drop the new swapc=
ache
even when pte_same() returns false? That means the dst_pte swap-in
can still hit the swap cache entry brought in by the src_pte's swap-in?

>
>         orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> @@ -1409,6 +1425,16 @@ static int move_pages_pte(struct mm_struct *mm, pm=
d_t *dst_pmd, pmd_t *src_pmd,
>                                 folio_lock(src_folio);
>                                 goto retry;
>                         }
> +                       /*
> +                        * Check if the folio still belongs to the target=
 swap entry after
> +                        * acquiring the lock. Folio can be freed in the =
swap cache while
> +                        * not locked.
> +                        */
> +                       if (unlikely(!folio_test_swapcache(folio) ||
> +                                    entry.val !=3D folio->swap.val)) {
> +                               err =3D -EAGAIN;
> +                               goto out;
> +                       }
>                 }
>                 err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, ds=
t_pte, src_pte,
>                                 orig_dst_pte, orig_src_pte, dst_pmd, dst_=
pmdval,
> --
> 2.49.0
>

Thanks
Barry

