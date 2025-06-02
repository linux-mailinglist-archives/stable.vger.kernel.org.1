Return-Path: <stable+bounces-148896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4750ACA818
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 03:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8E67A04C6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45464C7C;
	Mon,  2 Jun 2025 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xNchlMuY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAE184E
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748828620; cv=none; b=NPQGkSp+S8QuVWQY/v/3agtX2tEGPkINKYIA9YAyu0/Ap7tJJnFeEh266S8YNxglND/Ax/rQjN2jhrq+28o3zChw4kCLx+RFaGfh6NwfGhx2IPcHksUDAWWQcgaJg+jQ50A8853+SkhZ7bN40igz6MiD6XmEhUmW8ANr+MpKk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748828620; c=relaxed/simple;
	bh=3D5N5qY69CbwZgHWptHWeTHskJpWRrvqNIYWE4h9DbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9+RZl5SYQgexZBjagbOIS7mgBO0uoyE0VDAWNThZMYc+NmtgNLyyaze/7uzn34hnAjNsyoZBJAqMh/ee5XB3Gbu3JMSZbVwdpya9LHgtpSBVWhrcbDL9GpxD9bl2PmJlnX1tLSY/HXNSpizMl68rrZdqM2I4txowqenrX1ahtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xNchlMuY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso8546a12.0
        for <stable@vger.kernel.org>; Sun, 01 Jun 2025 18:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748828617; x=1749433417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYvGcWQJ9d1k2IJ1WZ8pmBWN9v/WGRaKrwMXLLXLqzw=;
        b=xNchlMuYtftLvVQqSzNfvE2gnP+s/RrAFC6uHlIs/phC+IO8IHR0G8PTP5Kh1iUO4o
         mcnaQ4CKWzfAEUCVsHPNyh3BR8gt/IAlYzWqMRLvFDii6rfgKyPZwxeXVrN5LNX5CoCD
         qj/CTIwnI75pRnsfDYqmbEbTod67nBehIP+9Wfrq6SALyVK9vFZp9OWCs0MxQ5yjssws
         5CzhXl8X3avlTsquuOx74+CCeiftNJC4vx7LDhbyjD1DxNdHFzguGb75xlqOA0MdoyAA
         GhmUBYGs0ji3dobUsMlipZhPBZtyFxtN32HXv1mPfOvFLrcq8hRa9RxI7NS91Ptuex/C
         23rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748828617; x=1749433417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYvGcWQJ9d1k2IJ1WZ8pmBWN9v/WGRaKrwMXLLXLqzw=;
        b=ZdTsYJGtG6rW8V2u9mpr363zI449RFmMMg1USOGBLb9RCUs+lp2vn14Wt/Fgx3GjB3
         ERSF8ddLdC8+sl3q3TMc7iPKY9ex2lZdlRxKFaR0gKZKo8EqbFo71nw3KVB6jnIRxVbY
         e/DrvpbsMwGlIA5vkiBztgoUuj06krsTmEFMrsNDERE4U+G8uR76m97knLSLBZesl+pQ
         Hy9JXTkDjPhiBH6Wdyy3x3o/QzGn8mP/h48Q84llFq7Px1Ak7qPpjWJ4dyxx6smncjna
         694crE+gW/v7NNvuwTNV4GFybc1sILcf+8xAa/0fKrQEc8LnGHpILlkAAO8+83ZcjuLv
         iygg==
X-Forwarded-Encrypted: i=1; AJvYcCVKDFBAzB8i6qzq93A60PDcV8/9We9cr8D3xTCAIeYCnLMsGacRbSQIoN9jIiVDBNXb4UDHCVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/24VyEzPhbYLmJwwIjMoVXpX0LAPPbByaKUk8I9wrzHEPXDj
	Is4OWWAEHW4ySQZok89CUUhoxva2wUM9H9sXtnMy81bnX6CVWtJnLt4RCD30GVJ7aZ+AxNQ2wls
	o/F17yLgFG3aahB4taJnCc90ztfVQ4hyRkTb+B8m5MACq/PdbW0yL1RGP
X-Gm-Gg: ASbGncvkpeIbvJSWIl3UGvuI2gYTJxNFBhQmwjwlx23myS6nTxfd5ZqJ47EAjTRzBAe
	scIu7TMXm68I2ftxzYUd6R0aRIaXcWVImjBiJoioLa5AsbccEPTsZxX6ajGkWavmZkBfaGnITAO
	efy632znZVP/wlL2Qx7lhmn/xa+O3orPnjMAUvcg80J8HVPApaqm+0UuL0iBwojuPybklT0ur8f
	VYK
X-Google-Smtp-Source: AGHT+IFMz4mfq5Y8/o5Yf0vlPV+OHhh4I+9hHTwnCw8e89qHhyt4L6kmwID2mb8bj9joV5ZdYADHSGEV4nVYb0ujbYU=
X-Received: by 2002:a05:6402:1852:b0:5fd:2041:88f7 with SMTP id
 4fb4d7f45d1cf-605ad29d9d5mr95107a12.2.1748828616702; Sun, 01 Jun 2025
 18:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601200108.23186-1-ryncsn@gmail.com>
In-Reply-To: <20250601200108.23186-1-ryncsn@gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Sun, 1 Jun 2025 18:43:25 -0700
X-Gm-Features: AX0GCFsO6EmUtlJ041E_1X1dTrIiqSlIvY3mMfgpc6Yn0ldxuA-DlfU3YYsdO14
Message-ID: <CA+EESO5DWB1C3ggH53n=DQL6xNz1bU+NWh7C7_ao=o9NGLvQ4w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <21cnbao@gmail.com>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 1:01=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
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
> Testing with a simple C program to allocate and move several GB of memory
> did not show any observable performance change.
>
> Cc: <stable@vger.kernel.org>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+EJ=
t+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
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
>  mm/userfaultfd.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bc473ad21202..a74ede04996c 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1084,8 +1084,11 @@ static int move_swap_pte(struct mm_struct *mm, str=
uct vm_area_struct *dst_vma,
>                          pte_t orig_dst_pte, pte_t orig_src_pte,
>                          pmd_t *dst_pmd, pmd_t dst_pmdval,
>                          spinlock_t *dst_ptl, spinlock_t *src_ptl,
> -                        struct folio *src_folio)
> +                        struct folio *src_folio,
> +                        struct swap_info_struct *si)
>  {
> +       swp_entry_t entry;
> +
>         double_pt_lock(dst_ptl, src_ptl);
>
>         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> @@ -1102,6 +1105,16 @@ static int move_swap_pte(struct mm_struct *mm, str=
uct vm_area_struct *dst_vma,
>         if (src_folio) {
>                 folio_move_anon_rmap(src_folio, dst_vma);
>                 src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> +       } else {
> +               /*
> +                * Check if the swap entry is cached after acquiring the =
src_pte
> +                * lock. Or we might miss a new loaded swap cache folio.
> +                */
> +               entry =3D pte_to_swp_entry(orig_src_pte);

Can we pass this also from move_pages_pte()? It would be great to
minimize PTL critical section.

> +               if (si->swap_map[swp_offset(entry)] & SWAP_HAS_CACHE) {
> +                       double_pt_unlock(dst_ptl, src_ptl);
> +                       return -EAGAIN;
> +               }
>         }
>
>         orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> @@ -1409,10 +1422,20 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
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

This check will get skipped if the folio was locked by folio_lock()
rather than folio_trylock(). It seems to me that the correct way to do
this is to check outside this if block (right before calling
move_swap_pte()) and with 'src_folio' instead of 'folio'. Even better,
if you pass 'entry' as well to move_swap_pte() as per my previous
comment, then you can move this check also in move_swap_pte().

>                 }
>                 err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, ds=
t_pte, src_pte,
>                                 orig_dst_pte, orig_src_pte, dst_pmd, dst_=
pmdval,
> -                               dst_ptl, src_ptl, src_folio);
> +                               dst_ptl, src_ptl, src_folio, si);
>         }
>
>  out:
> --
> 2.49.0
>

