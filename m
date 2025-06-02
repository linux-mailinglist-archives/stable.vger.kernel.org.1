Return-Path: <stable+bounces-150628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E12ACBC38
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C41189219E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B9D84FAD;
	Mon,  2 Jun 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1tlD65s"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB523CE
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748895460; cv=none; b=UvEUEiMPjnObONnSu0/nYamhdiAGW5Zmvwfa+5qmEl+07e8JnUc+k/efst33NVAMrOqcsCIHOMblq28DN+g46X7r9V7xZva3jWwaDfVrH7m/wOVFYpPo+O2yVZwOexxoTi9yvjzDKENHdNscDhse4lBEmg1HWuX4Mx9U4mhoPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748895460; c=relaxed/simple;
	bh=QSr0xXyBM7n9aZtKELufkHHpmZ5V76wGESZdwED8iww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXT0hjQ4q+oY3P6nvu345je0RS76hL8Sp5wYd9d7HtyP9AzGt8X1qpWuKCTIWQfQ5inOY8xNZAhIp8WEiMa3VOJk3kbKq6KjXV1tL5DgkVAk/vkSQZnfQdwqnpB9SJkyCKoB9AhETV5uwcFGfwhBGey/K67s6uEEhvjG54wwd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1tlD65s; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso3055a12.0
        for <stable@vger.kernel.org>; Mon, 02 Jun 2025 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748895456; x=1749500256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctvG6SHuadE+00J22czmVdW+HH0EiiwR1m/kajjnHXU=;
        b=u1tlD65smWXTNXbtD7h2KOpE4W7k+DtkVpQE8IUlvGE0+qUoZtAJ50LJS9ITuO/yvn
         ot9ihAMII1h6WVBk9mCX2bL8Dablj37Ec9Y8ydtZv9BZh7SeRY+zrjcLmVZBCQQQ5sTK
         GHP2eZL0MYjQOu3iEu2uOxhhIr5aHCEqj/oLkEXP/0XAfWUhtSoLMWFadb5umSlmd8Du
         512ktH1cEKB/YWZUvhBEV7HVmCqwRNTwh1Kdb/H/f2xQbT5tHLXkJTbnbdToXweC9uKv
         9qEuinfSn6pRPVnocHTMoQmAjgZIdl+BrW0SsmJUZh17brGbU3Sh+IRhSRj8b2egHSsh
         93KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748895456; x=1749500256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctvG6SHuadE+00J22czmVdW+HH0EiiwR1m/kajjnHXU=;
        b=omukx2LgbsLuVdujyVlekaCn6UYic/WliUX2bJsbUvlP1hMHOWAGUPUkXc7Pm74XT5
         zlJmKO62ccPPV5qryMtQVDJblscX6O9n1vvYnbrCkPuEAMrx4sgRvagCgY2QMhPsobWm
         SmWUVhBfwLVVp26PjS5NNvJwz8QpOhbyd9ymfsEeOhkFwI69NEIxXkQcSCW32XrnlSmj
         MCwjUHmc6unONHfyFIiteNjWJSC43DlQNn+uJE23JaPQgWKdRRI+H9qVs5c+cGpdAv+o
         mH0RN7imP8SoXUCbP/U9lOYhQbMNkb6v5N34jL8zGvwtpPivz56G+xhF2LqirXn67+J9
         is8A==
X-Forwarded-Encrypted: i=1; AJvYcCWwY+oMVadVFraP805PTDUlyaqvqtQMvJ34QaTq54GXLZEXHsQoQntal/sGlka7XVOaLRnBhpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUnzVZZFfk0VnyfzpJ2DWM843DlVTIOgbjdAcs098/w/tz3Kd
	TRWnY5//KfSbPgs7DNrGtJU9ENsCQNvv9BtHYYMNBEReG9cDcbz37aePQW0NKJk0Uwd0EfHfBBh
	Qn/bHJgkPGema16jEGwoTMH4V9j8hDXzZ4VXVr5kk
X-Gm-Gg: ASbGncuNx3iI0hHQlQZ+0T+u21jpTvD6uNR/5BqR10qxcXMofBFAkDmm6v84JQcs7a6
	Jpmg4ElwlmYgwwPj71p1asQVzHttiLVeN4uSg88iNc1BPhWfn4WUvWPbFsIOx/e6tgv69aeGhOj
	OOH6yW/q+g9pPX0G0dLd0YOAC3yvzETwSr1S90+G+FIixDQyr4Q9VAweYXAHV46zctRJJSgGZyb
	EzEI6n3EY7y
X-Google-Smtp-Source: AGHT+IHDP71eglG2ZH1BI9bzUwIhIE/LQzMgV+zrpKTlFxjAWKpFl8zYhudXVmN6IZ3JLyYefNOPtKc2ICJJbYqQkDA=
X-Received: by 2002:a05:6402:14d7:b0:600:9008:4a40 with SMTP id
 4fb4d7f45d1cf-606a954f462mr18926a12.4.1748895456264; Mon, 02 Jun 2025
 13:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602181419.20478-1-ryncsn@gmail.com>
In-Reply-To: <20250602181419.20478-1-ryncsn@gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 2 Jun 2025 13:17:24 -0700
X-Gm-Features: AX0GCFvzvU7biHtOhcabLwf8yQqS0sIUyLFczcy7v8fA9mViVFYOO4pu24h5TJA
Message-ID: <CA+EESO4rSJP8V0-p_o9ascV-Lp1PwABNAZWnfF6_5x+VPS42pw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <21cnbao@gmail.com>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 11:14=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
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
> Testing with a simple C program to allocate and move several GB of memory
> did not show any observable performance change.
>
> Cc: <stable@vger.kernel.org>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+EJ=
t+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
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
>  mm/userfaultfd.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bc473ad21202..5dc05346e360 100644
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
> @@ -1102,6 +1112,15 @@ static int move_swap_pte(struct mm_struct *mm, str=
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
> +               if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS=
_CACHE) {
> +                       double_pt_unlock(dst_ptl, src_ptl);
> +                       return -EAGAIN;
> +               }
>         }
>
>         orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> @@ -1412,7 +1431,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
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

