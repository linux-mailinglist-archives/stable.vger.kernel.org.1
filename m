Return-Path: <stable+bounces-148334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29BAC983E
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76734505FBC
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A8828CF7B;
	Fri, 30 May 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VoAZlxDC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343B28B4FE
	for <stable@vger.kernel.org>; Fri, 30 May 2025 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648426; cv=none; b=O+YfDE/TtIb0VBkxu+JgLQRzTMFLSHXdDruA0uU6X5MBHGCLmp1usKvaP8XBurU6W/rLVwEHwjQhrHE3CZpyvNsClM6ALTmDZMVDfAbWh5c3s+iKM10kLAy2Pn6dHy/UHFENRpHXDoTKBteqLvpHi9Ww/+fBp5bXpmErHmDXTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648426; c=relaxed/simple;
	bh=qoy+cWKbl/+39sWgV2gORtyi2rbF0at+fNDDMG454g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQR/iP+Lt93C9L/OP7BMYHfPzBJF1HEdU4Yg++mneITi2olwiGzXIu0bisU6QuzN2/gf1oyrN4feHww/EuEJP/BWt8uN8asMJRJm5SvoNIg/xy4niJTFoG0G8WMm0BoCnjrh5V7pt0aGKrh2Nt8ZwlCufPyWv6A28H9XhIzYIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VoAZlxDC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso2352a12.0
        for <stable@vger.kernel.org>; Fri, 30 May 2025 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748648422; x=1749253222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJjuAkTXEQou27q/GI8BouUWZGCA56NQMXBn0TGJIBM=;
        b=VoAZlxDCo4Zla1LmwCAgT7XXPsCqAiQYfY9YNwMCh0Ulm7Ii1YtRQiXIfN/MQiBvEx
         WX+u+5GeC0CLGpjIgZ1xBfFj5lSIQt5J5Ohn+B47819oHg/0/mM5KRJwskSZxi4hiroL
         B6o/QFdQIG93GBDCZ+dWH3A0QPqE4Sfxq/4ZyonJej8ELd3DKnDEXyJjDILzx5JTQm1M
         QYXbd5VWIPcrIzIEzJjnAVV+0MOAOzNL439SiOVTmc+y4LBZtm8CCeUsweneTR8KImqz
         J+qC8gO/zKcNLBYZXfW9hXc/J9PCrJHZAs5eN2J1Ho6X3JjwDo579apl9WTyQ6311Cqh
         WAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748648422; x=1749253222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJjuAkTXEQou27q/GI8BouUWZGCA56NQMXBn0TGJIBM=;
        b=jRc8Bhbo9scomAgUjCQEk4i+qkMhe95PKcSZUjTuNKYaoIdTgePWaaXOMXE9IlmSIG
         2FxhIABKQrIX2vdbn1LLlrKqOLitjM5cFu02RLSxOxKCQx1WT4mZ/zF9i14inNIRn6db
         /jGVlluuR0JAVk/LsdY86h6Mq33E7X+Fjj3AsKnlN0mVrYfjD/YnI7kqUKdoe0iC/zTr
         jEz/CUddDLBjg6osFSLViZTF0REXmF+iLQ3Az4qBA4ZkB4yWV4YTZt7B0omu7UHU8Nb5
         Gfmyc4zvNxwWtQZE9sldEX2y3GNC1+ySaqT1qeF6vcbUzifNdh0u66eSh14xOz/wbTYw
         jyFw==
X-Forwarded-Encrypted: i=1; AJvYcCWSFIL+TkicQ5NrB4Epi2EOvw/3WP9hR7PAgaq26kwwdyO6qTAk6tU4gPRP+p+NRlNnQvfc+3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYTodiRpuvH31nqpyIqulPl3rnXbuzHL+y9H+LCMEt0swCdTP
	Kjc+Xy4E6Wm5Evl6ue5Npi5MCF3hnlEpcjYmTMoF0XPAYOgEG26go6FoGXGUBwtTydIb8WmoJz2
	EqD8SjknJpk/jUABupqF/vTcogYOvmwpvpMAO/Msj
X-Gm-Gg: ASbGnculCNgH09ILbkQzzu3QZvCXC+ezYaot1J4T83+SItrd4kaDQIMuooXubp6s5nk
	8BcoZoPn7UBacqY542LZlxH+ju5Hn/0CJmLm6KmSh+jupS4Yh6h5MizLDxE4n1eiHnkHdov8SgN
	3e5m67BDYrUarisvVn1pE4wAXRFcii/9QUcChATqWrQVE4eTOd4D46mw8fsD2G7nOwL8KQZlQ/F
	g==
X-Google-Smtp-Source: AGHT+IFYZ2wi/n3k5Mm5Xv/Aw6N2AACLV49l57jm0jIvWwkQlDhqBVGKwrBN6CXIKTTpiKFIsm7Hk5hypG0XE0qujZ0=
X-Received: by 2002:a50:baa3:0:b0:602:3bf:ce71 with SMTP id
 4fb4d7f45d1cf-605b3d6f8e3mr11239a12.3.1748648421564; Fri, 30 May 2025
 16:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com>
In-Reply-To: <20250530201710.81365-1-ryncsn@gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 30 May 2025 16:40:10 -0700
X-Gm-Features: AX0GCFtij8ZIUc4Py06G-QyGJk9y9sdcE5SJ7fAIvFEcuZp83ykEJOh9QRX6Z9A
Message-ID: <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <21cnbao@gmail.com>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 1:17=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
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

Thanks for catching and fixing this. Just to clarify a few things
about your reproducer:
1. Is it necessary for the 'race' mapping to be MAP_SHARED, or
MAP_PRIVATE will work as well?
2. You mentioned that the 'current dir is on a block device'. Are you
indicating that if we are using zram for swap then it doesn't
reproduce?

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
I guess you mistakenly left it from your reproducer code :)
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

Given the non-trivial overhead of filemap_get_folio(), do you think it
will work if filemap_get_filio() was only once after locking src_ptl?
Please correct me if my assumption about the overhead is wrong.

> +               if (!IS_ERR_OR_NULL(src_folio)) {
> +                       double_pt_unlock(dst_ptl, src_ptl);
> +                       folio_put(src_folio);
> +                       return -EAGAIN;
> +               }
>         }
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

To avoid further increasing move_pages_pte() size, I recommend moving
the entire 'pte not present' case into move_swap_pte(), and maybe
returning some positive integer (or something more appropriate) to
handle the retry case. And then in move_swap_pte(), as suggested
above, you can do filemap_get_folio only once after locking ptl.

I think this will fix the bug as well as improve the code's organization.

>                 }
>                 err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, ds=
t_pte, src_pte,
>                                 orig_dst_pte, orig_src_pte, dst_pmd, dst_=
pmdval,
> --
> 2.49.0
>

