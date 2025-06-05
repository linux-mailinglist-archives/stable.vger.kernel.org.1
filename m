Return-Path: <stable+bounces-151495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95206ACEB69
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 10:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167823A3E53
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693F1F30C3;
	Thu,  5 Jun 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGzKghz4"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2E1C32;
	Thu,  5 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110556; cv=none; b=NEm9f3ikDy8d3a0YXEihNJNSja4YxNBHXF3AkjYIfc2EG3lzuzsicnOXYmSC263mZZ36cAi8h+AyeoDmFZUpEqQLvRMx6FPPAsLLEGyDjrSglGlSsQ8bbWeTcfMJyhM/UKUMRS3txNvIV3WCsZHOk2wFpuIFmpBMAI/+U0VZP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110556; c=relaxed/simple;
	bh=aZnyP9tNxH8/0mmSeh6pdBDIshmVhU8/BotpqwhvYfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUIKqXXlqm69z+VyAA0iyfbAYFt+q7bZCGQQxP/EQbolCCTB2sWm3hbqdjxt7t7B/zZC8jyRymPKC8H3i6ntI2PYHIJk3Ss8n/+b27YRHFH2EeKaTq9XKbEEME0ol5iEliid7HVqzj+pPM2ElUy47D/sb9Yq5kBAMWWyOOX9zJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGzKghz4; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53082f1ac34so253791e0c.3;
        Thu, 05 Jun 2025 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749110553; x=1749715353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMcINj7Ifsivjw4DYRfFWHrcDAFZixnKbjiSAQ5jK08=;
        b=eGzKghz45k4VWXOgrcID/XUpbMRCOyRgGar2Ri/rLN7zPBnuZRIE59RqaUdj0/RERI
         yj44NPG/1VtRgRI7K16FBhCXrOTEbZluk0fyNV27XPYOzJ+mIJj7u7I7aGm90E3ImhPI
         6XQcvwq1HPwwBGHosEdui4/rvG4pUXvWe0YruwpjyK8k8mFOFEq9++wo9FUo4Z+Kw5Zw
         2XgAazEn82asgZaPsI0RKZ53xHsQb0B8jRbtWUafpvcwuIQ/xX7j60CPg18PUeskzUe5
         w8H/ewQiYC0KxCRgsds1iYIdeHARRYaNSQPlyZymCB+v/Zgo69iryIViSqeGm6CuX1HA
         miDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110553; x=1749715353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMcINj7Ifsivjw4DYRfFWHrcDAFZixnKbjiSAQ5jK08=;
        b=HZagQS3nOHeFEnKCjvJgO8XDwgd20OAeIBAn/SPRiJF1WGqNB2vkiLog6rXnILHpfl
         Yxd4OqsnQGabg+iFEFfriUHT0ZKg/sSPuxDPtiwXuIBn/fMAtdx3e5XCiInEDf9zo/3g
         yUFdDGrYusy41c/SfWaCoEAv3EGhHmbKrT26wjhEBxoxGu7SwUm3nTcVnZ7A50Y4rXvl
         zmct8+DcaYmVM2GPC/uxyLYMTEDXhpkM44b8dBzBg+BTLzJN/FENheG/5K5XpvMd9mnP
         rR7CuXppu3sG0IkEHoolgcfVi087IOvB8HgRAm4BxZN2kGpms7by4A7HHf6Pg4hp4sY9
         fHzw==
X-Forwarded-Encrypted: i=1; AJvYcCWGSO0d+pTk5DJP/H70DWwPAejSggqmQ4yF10/kHRJOTi9hj0uRydtM04XUVsjwY2MipNPVzOOc@vger.kernel.org, AJvYcCX+RyllAbmoPPvPAnUW95FxlhHuSPsUItVh6DA+mIO8qFGg5kGv0YIhzPal0N1IDKAdwBrVNh6gyUxsih4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWpC7P/F3vsHg8Co1vcLEbE2Pcm88YSL3qVt334Nkj9yyT6wV
	8E8AZoWbFbB9IYFA97sSgwbP2LSQIW5iBAmO0bPIyOfNGmcJyVrGdx2ht+K4hpCov/7N3rn2bPW
	rqtg3ENw/mjqIOnLC3lMjCoZEmddUxTQ=
X-Gm-Gg: ASbGncuLQk4ePRPvzC8FuiAA2LpYEDic2cw4FqOSOJxnvuBRry4+6YPEQZtIpWoyKAV
	42pa6sp2XznAdLDoyC22EHQZD098TiyOPh+C0f3qqk0z8WYO+f45Benw8iqOs/CHp8IBlSCPkao
	/GGlQgADtKL2g5/Fusuq9hjQ0QkDKpeJ0aKw==
X-Google-Smtp-Source: AGHT+IEX+HHyUIRP44E1txAP6qEbFK08W1HJ+COXPJhPWVLVrfGqK7Fe5xaZxSc/hgJSZd33iLpUWgJtiaVb5kZJMm4=
X-Received: by 2002:a05:6122:828d:b0:52f:4680:1c75 with SMTP id
 71dfb90a1353d-530c739f782mr5502331e0c.6.1749110553036; Thu, 05 Jun 2025
 01:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604151038.21968-1-ryncsn@gmail.com>
In-Reply-To: <20250604151038.21968-1-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Jun 2025 20:02:22 +1200
X-Gm-Features: AX0GCFvFCmpEOUvT9F2g6UK_BGIPE032pznjFE_9uuzAxLQJQJPYSC62dQa0oKY
Message-ID: <CAGsJ_4zG1k5=_Me=73jud21QViBqALtQUoyeuxi_JbZmxFSV6Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:10=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> On seeing a swap entry PTE, userfaultfd_move does a lockless swap
> cache lookup, and tries to move the found folio to the faulting vma.
> Currently, it relies on checking the PTE value to ensure that the moved
> folio still belongs to the src swap entry and that no new folio has
> been added to the swap cache, which turns out to be unreliable.
>
> While working and reviewing the swap table series with Barry, following
> existing races are observed and reproduced [1]:
>
> In the example below, move_pages_pte is moving src_pte to dst_pte,
> where src_pte is a swap entry PTE holding swap entry S1, and S1
> is not in the swap cache:
>
> CPU1                               CPU2
> userfaultfd_move
>   move_pages_pte()
>     entry =3D pte_to_swp_entry(orig_src_pte);
>     // Here it got entry =3D S1
>     ... < interrupted> ...
>                                    <swapin src_pte, alloc and use folio A=
>
>                                    // folio A is a new allocated folio
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
>                                    // S1 is freed, folio B can use it
>                                    // for swap out with no problem.
>                                    ...
>     folio =3D filemap_get_folio(S1)
>     // Got folio B here !!!
>     ... < interrupted again> ...
>                                    <swapin folio B and free S1>
>                                    // Now S1 is free to be used again.
>                                    <swapout src_pte & folio A using S1>
>                                    // Now src_pte is a swap entry PTE
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
> deliberately constructed reproducer and increased time window, it
> can be reproduced easily.
>
> This can be fixed by checking if the folio returned by filemap is the
> valid swap cache folio after acquiring the folio lock.
>
> Another similar race is possible: filemap_get_folio may return NULL, but
> folio (A) could be swapped in and then swapped out again using the same
> swap entry after the lookup. In such a case, folio (A) may remain in the
> swap cache, so it must be moved too:
>
> CPU1                               CPU2
> userfaultfd_move
>   move_pages_pte()
>     entry =3D pte_to_swp_entry(orig_src_pte);
>     // Here it got entry =3D S1, and S1 is not in swap cache
>     folio =3D filemap_get_folio(S1)
>     // Got NULL
>     ... < interrupted again> ...
>                                    <swapin folio A and free S1>
>                                    <swapout folio A re-using S1>
>     move_swap_pte
>       double_pt_lock
>       is_pte_pages_stable
>       // Check passed because src_pte =3D=3D S1
>       folio_move_anon_rmap(...)
>       // folio A is ignored !!!
>
> Fix this by checking the swap cache again after acquiring the src_pte
> lock. And to avoid the filemap overhead, we check swap_map directly [2].
>
> The SWP_SYNCHRONOUS_IO path does make the problem more complex, but so
> far we don't need to worry about that, since folios can only be exposed
> to the swap cache in the swap out path, and this is covered in this
> patch by checking the swap cache again after acquiring the src_pte lock.
>
> Testing with a simple C program that allocates and moves several GB of
> memory did not show any observable performance change.
>
> Cc: <stable@vger.kernel.org>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+EJ=
t+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/all/CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=
=3D8Y560K8eT=3DA@mail.gmail.com/ [2]
> Signed-off-by: Kairui Song <kasong@tencent.com>

Many thanks=EF=BC=81

Reviewed-by: Barry Song <baohua@kernel.org>

> Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
>
> ---
>
> V1: https://lore.kernel.org/linux-mm/20250530201710.81365-1-ryncsn@gmail.=
com/
> Changes:
> - Check swap_map instead of doing a filemap lookup after acquiring the
>   PTE lock to minimize critical section overhead [ Barry Song, Lokesh Gid=
ra ]
>
> V2: https://lore.kernel.org/linux-mm/20250601200108.23186-1-ryncsn@gmail.=
com/
> Changes:
> - Move the folio and swap check inside move_swap_pte to avoid skipping
>   the check and potential overhead [ Lokesh Gidra ]
> - Add a READ_ONCE for the swap_map read to ensure it reads a up to dated
>   value.
>
> V3: https://lore.kernel.org/all/20250602181419.20478-1-ryncsn@gmail.com/
> Changes:
> - Add more comments and more context in commit message.
>
>  mm/userfaultfd.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bc473ad21202..8253978ee0fb 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm, str=
uct vm_area_struct *dst_vma,
>                          pte_t orig_dst_pte, pte_t orig_src_pte,
>                          pmd_t *dst_pmd, pmd_t dst_pmdval,
>                          spinlock_t *dst_ptl, spinlock_t *src_ptl,
> -                        struct folio *src_folio)
> +                        struct folio *src_folio,
> +                        struct swap_info_struct *si, swp_entry_t entry)
>  {
> +       /*
> +        * Check if the folio still belongs to the target swap entry afte=
r
> +        * acquiring the lock. Folio can be freed in the swap cache while
> +        * not locked.
> +        */
> +       if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
> +                                 entry.val !=3D src_folio->swap.val))
> +               return -EAGAIN;
> +
>         double_pt_lock(dst_ptl, src_ptl);
>
>         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> @@ -1102,6 +1112,25 @@ static int move_swap_pte(struct mm_struct *mm, str=
uct vm_area_struct *dst_vma,
>         if (src_folio) {
>                 folio_move_anon_rmap(src_folio, dst_vma);
>                 src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> +       } else {
> +               /*
> +                * Check if the swap entry is cached after acquiring the =
src_pte
> +                * lock. Otherwise, we might miss a newly loaded swap cac=
he folio.
> +                *
> +                * Check swap_map directly to minimize overhead, READ_ONC=
E is sufficient.
> +                * We are trying to catch newly added swap cache, the onl=
y possible case is
> +                * when a folio is swapped in and out again staying in sw=
ap cache, using the
> +                * same entry before the PTE check above. The PTL is acqu=
ired and released
> +                * twice, each time after updating the swap_map's flag. S=
o holding
> +                * the PTL here ensures we see the updated value. False p=
ositive is possible,
> +                * e.g. SWP_SYNCHRONOUS_IO swapin may set the flag withou=
t touching the
> +                * cache, or during the tiny synchronization window betwe=
en swap cache and
> +                * swap_map, but it will be gone very quickly, worst resu=
lt is retry jitters.
> +                */
> +               if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS=
_CACHE) {
> +                       double_pt_unlock(dst_ptl, src_ptl);
> +                       return -EAGAIN;
> +               }
>         }
>
>         orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> @@ -1412,7 +1441,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd,
>                 }
>                 err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, ds=
t_pte, src_pte,
>                                 orig_dst_pte, orig_src_pte, dst_pmd, dst_=
pmdval,
> -                               dst_ptl, src_ptl, src_folio);
> +                               dst_ptl, src_ptl, src_folio, si, entry);
>         }
>
>  out:
> --
> 2.49.0
>

