Return-Path: <stable+bounces-148366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A1ACA113
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4D9171F26
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C002356BA;
	Sun,  1 Jun 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb6BGTCZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768EEEA8;
	Sun,  1 Jun 2025 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748818939; cv=none; b=VjLNWCRmtfKbq/M5xjWIurBAUipYj5dxssCoTvBe1OrXLALRv9JhbN8zxZO8R13b2siPcsFVyDJ7cL9IkZDgrZnsWI+UOf12lIcXUCAn91kStH5BgK8dPUyF7upHHnFgx8lp7/LdCWC5ai34Yp3kH0Pkfs6nZwm6sl+ly75xnJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748818939; c=relaxed/simple;
	bh=NB2nxi9zPXzNoy3Sh9heTDqXT+lYZ+ZewEszJArmlUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1P4mBweb4x0Ru8xopfdqna+ud+vliRVwp63w84OV07MLHtSuHkvr80GK9HSXG2tX3AbGRVcWPSeBrXITT1oD9NLUxhx8HNeagbfnCJDcr5Qs70mQExU17JfmFzfi8oIYcf2CVgUC3yPBmhE6A3YyKl5XcjtMiYUAdVwhvS2Ll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb6BGTCZ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e5adc977ecso1157055137.3;
        Sun, 01 Jun 2025 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748818937; x=1749423737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJJRvvhnj5WH18QGeEqnBpAPkYIwRDRaywa/X23CxYE=;
        b=Gb6BGTCZJ/HDZe7WF5uTpQov7sM+N9baE4rnpCsdUi4y4epaIjcvfjRJ3KSTDRcYrq
         JfSVPvFaoHSnr+7ITKhN128fhi5dwnaGR43KbVy9U7NPFFSv3OFwafXJc3GfnnYrnm8O
         BrV4ahlZjIKc3X0MCbmzH18RbqN+Q/hzfjM2QtNvqC7E7hoDqRspUD7EfPU6iLovKLzY
         ju84VgIpj/qZCcgXCWKmLWjiamMitXX74C7xHcnboDU3IMCtlQFiNOY5Q30WAHrmnZKg
         m5UeFyTB949RFP4P7TzI0zDVnrI9XGZFpEEeBwL4eLOMCM2gztlC38XibZloPGDWkM6h
         ivxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748818937; x=1749423737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJJRvvhnj5WH18QGeEqnBpAPkYIwRDRaywa/X23CxYE=;
        b=uYI2JvSxpezl/TtPGpqW+FPOa2NfJA9lrxkVOE9ZskFc/J4zd9HxzG/sa4i8GUsnUL
         TPk7CSCB0acJiJb3JVDuqukch+ozBn23jvMInmBjzMmLaz51MPW5Rup4EXXHVVd1+aQZ
         uR3Uj2t251UWQD7BAmkFTb291Fw/PgSFkhXBtahTw1fydzLFNZZNJareD4vy5K5JghmR
         XiC9sYTVUhixDu1V3esI6WecU8vEaHm+o2tVX/oR9BhwMLhRGJsTH3fZQPyT+N8Aof1+
         Cs5ww27qBDS14GTAelff7Jd50TRF3kfty+85oa+urhKfozzj11f/z3v+39gGtIdHVg2v
         dyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKRigs+Z94CXE1TeA8orjE1ZZ+6tnPnNb9CGH8Y9e5STjr/QZZVIBhVQvAf1YhLngPObvFnzhR@vger.kernel.org, AJvYcCUUVLx+HN04YZ8Opf+gNL7wUL88q9D7BHaMqCRA8iFG2cQjA8qfxak0fcm8y5uUqiJZ3b3d9YsoATTgEyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzVBfjdzwQk7WXu3FfrjUYycLqyy7BVtcz41Nvm0mLf0ez2yh
	lpfdgwgPXbwBEE7wC2VWhp18iU57kg86CKfL+xJ7zwt5dSFx6zIsd2mVdkAxkH1a5kCPzmbup4w
	eOTEZWY22U+gXbNg5kEgZXbl5yjvJzJw=
X-Gm-Gg: ASbGncutMMGPH2EVAsRS1NVoBeTK0M4jhnNsPPpXbeXU9FALUnPknGgnwknrmb9GrY9
	HEU1CR2K5f5nEqc8Q6NJypsqUNPIt1W2RpD+qF60Kfzy1WcZYseJyx+Fq+fmQXFMyM0Uy568SGW
	J07Tv5n3/izHteA4OkGyw8q18UCCoWvZ+YqrgQ9NQGWw4j
X-Google-Smtp-Source: AGHT+IELGfT1Ic//2UYT45sllDH/ci5tp1iJh4PCxvZHvbSMadfe5Y2bffIwmTzhw0I84/BPmw/h8vYYpohiynmWfmI=
X-Received: by 2002:a05:6102:290b:b0:4e5:9daf:a2a0 with SMTP id
 ada2fe7eead31-4e701ae3ademr3698108137.5.1748818936862; Sun, 01 Jun 2025
 16:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601200108.23186-1-ryncsn@gmail.com>
In-Reply-To: <20250601200108.23186-1-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 2 Jun 2025 07:02:05 +0800
X-Gm-Features: AX0GCFs6WlgA9NVsiZs38jh-3AdoM_5ASXeggaJLIZtFNyP9ttgK2VLnTvUN8tY
Message-ID: <CAGsJ_4weYBvht6+6ocSkJe0Orh-7rYu2VtYMT6FZCecU2fxeBg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 4:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
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

Reviewed-by: Barry Song <baohua@kernel.org>

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

Thanks
Barry

