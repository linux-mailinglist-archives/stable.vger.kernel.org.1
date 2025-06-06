Return-Path: <stable+bounces-151564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A4ACFA5B
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 02:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC853189B0FA
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 00:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D66171C9;
	Fri,  6 Jun 2025 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqrfNvKp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630CB17C77
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749168912; cv=none; b=NM5pMlEeuuymsO0GqYvFHJ/Z2I3QAzez8T/ifBmdUSS4bmD6GsNrtuD6dhjqp+dYiDMgvrEqCYXz6sDDgC5n5uIsUE6p74gpPqBtxvL4heRgcbmSO8PEmExD2GM+O3LJU0HAm6iJU3uHE0QfPxH4Y+NRqU+k4yvWTd7n7ka0ZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749168912; c=relaxed/simple;
	bh=V+Qlec6SXG5Mz7B+D4sbtYjym82uWnzpo1+wOeci9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1sKxYpMjLiIOWH3hZmkjtcXy0FrnjPJdmCpO/+bDhhZKy9NLQTG8Jla3dgmdhSjlBPyK+i/vwoGHBywATQw3oUXzOVqWAonvO/7of5EmhR/T7FhNmm7t1RqdlP8D6y/VeJOJ3T9fxyRqLRT/E5O3KufWes19kqlkkOPnzzmEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqrfNvKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2EDC4AF09
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 00:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749168911;
	bh=V+Qlec6SXG5Mz7B+D4sbtYjym82uWnzpo1+wOeci9OY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uqrfNvKpzh/WL+mkq2StHQ2JU6Q9KSchU6/7PMU8i7VmNSGwvvZ1m3Iy2zVPIQCIv
	 xrcGJbb+ubvSsMeLC/R6l1+h8YrTbKRyEehi4fyLFnb92nP3nc2HYzrEHCxqZBpaBw
	 Aflx6PLY5cMRXWDj1TKQQX2CpH9sy/8YyAKLAhVs4FI1p+t4OxJ11wxCQyysstSDWr
	 mbwGSlOcr436I0JK7eShTBEr03JeseA05UHe52qhzkTid38eWpopkbmLChN1C7VmPn
	 LDgJc/gQDz+TvSkVAYlKACeiYIv1EgAzqyg64GXzpIcxTrRm9bNzE8Dpp4/MNQaQkQ
	 Hmvjuo5Fz4yYg==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450dab50afeso27045e9.0
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 17:15:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoCiqwUe9TFMDIsojBJsGLtEHteKQUW2zKjwrW6nlKZ5f0nc96qsn9tDygQLElnmNwL3xagTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+G9+s/mO5RPfBlrPLJk2Q2AQ9ROSu1DdSMTuvMk5FEDhCF7N/
	VCO1Ha/VA7nffhFoy35ZjA5gSrEeEx3k8ENHkscOxYs9GofmKqlGp5JOL1hyXD90j76xbzas8jR
	So3F9QhKqfe1CMThBUSK7OKGuSePMFCExZwAy8Mfa
X-Google-Smtp-Source: AGHT+IGLbUuIjAfVPsirnUgTYnXMIcDKIEE/hWRHptE8PR6snMnIlRCkrJyI4OLFwaKdxDWggO5BwLYZFbBJ8mcmIO8=
X-Received: by 2002:a05:600c:3543:b0:442:feea:622d with SMTP id
 5b1f17b1804b1-4527a28f0ddmr303065e9.1.1749168910422; Thu, 05 Jun 2025
 17:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604151038.21968-1-ryncsn@gmail.com>
In-Reply-To: <20250604151038.21968-1-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 5 Jun 2025 17:14:59 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPoJrYu30YPqze7oSPBm0qJ1Qutpw3=cQMQeSmboGnQKg@mail.gmail.com>
X-Gm-Features: AX0GCFvVDeJjp0rqUIAm0FMQrOXJdPhT8-6JSI_7eeM2z9k4rHA4l2shVraeDC0
Message-ID: <CAF8kJuPoJrYu30YPqze7oSPBm0qJ1Qutpw3=cQMQeSmboGnQKg@mail.gmail.com>
Subject: Re: [PATCH v4] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <21cnbao@gmail.com>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 8:10=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
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

Thanks for the fix.

Please spell out clearly what is the consequence of the race if
triggered. I assume possible data lost? That should be mentioned in
the first few sentences of the commit message as the user's visible
impact.

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

Nit: You can use "} else if {" to save one level of indentation.

Reviewed-by: Chris Li <chrisl@kernel.org>

Chris

