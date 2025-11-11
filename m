Return-Path: <stable+bounces-194525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C0C4FA55
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 20:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E38314E7A3A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB7345745;
	Tue, 11 Nov 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqzhCNhs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D09333459
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890503; cv=none; b=URb//2FXnAFVmYGU0XgS4x1iJSLjICYuPQwAm1m+KMkUHMh8srzzy5LJQBOJnCmgAObmGenqJLGdRHz57A3wpRIhtPat34LHKa3OkQUbiQFQrbXJbPFow4yaCZ5rzS/6IaVJpLPA7x4Lj1VbOn9kGcO3Nt0srwzhokIldCFMDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890503; c=relaxed/simple;
	bh=Xh24Itbbl1KCQJ7CVFff70n5D94ZpTRVFhp/97mFiyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIzVuckY3udu/0Pt10JRxx8VrChTYWRC94G0s2FPATHdapDJg45X53ZecWj3fxLCxRrntxYS09uhlFpKGjRuPf9EjQa1iucc/EC8G8Az5TgqjZqgO1hPaROOTYOpX+IA01KAiFty4s+osENlZgaGtV4MXAFyxp8R+ULZm274zcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqzhCNhs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso140085e9.0
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890500; x=1763495300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbE0DBTQIFEdPxSSdzhQNw1lCZYmDmkNb+ii//A3mIs=;
        b=VqzhCNhsIzF2LZwbbb2IFGXUnnhPhLXSY2BpAFY9y8eUAWdizLEDFGrU/9RNRYBgo4
         jg6FsLLVGOU0C4C0LErqMeZ8/9ZGfpu5Y1eubAEdMJDciaLXN9cyJ7xA7GLMyYJvoLyo
         bojZT4pxLYpkeh75OJiiK5KvEUkkmIyKD7/9aVHa9jtTiJD4OhIT2bjrbbPx+AjWKVbk
         BS3qdcqyNYlWiCXoa3UD4wQnyEJtXmx2o4SIhnIUEYHCQzNdBgtAga8PmrcG/qe9WGvq
         HZogRPZDz/e3wLaIzEq4gxkKKehwUeJfrIO11PpxHHH/jwCGt/Hy3y+eLFkj5SGWScsR
         TF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890500; x=1763495300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbE0DBTQIFEdPxSSdzhQNw1lCZYmDmkNb+ii//A3mIs=;
        b=q02fkTdzLMT+D6f23nznPoFrZ8uIbB7NiL/HaRihNBIQkpVfX4iY5yIBG9Vrmy0lyB
         YdCgLgj+qTzz1PvSyBeen3TX065dui054v4k/z2mLCQdw85onIf9puyN/bsa53YS1q5D
         296+ymX4bo2Of191OyfY1SowwvOM4jkj/nm2ARhrLBp6S/03ETOkvPpBJDObMMygtLG5
         ee3M8CUv4ozI9pGtt+PLs8mgx9coqLT4Okoi+lkTS/p7cGKRJVTDm7ylw4UTfiDQ3EmP
         YlEzRH54pFJ0espp5IYCP2T6VULxokHnWrL6fQAKVUO7b8tAycff5Ld3Haw+COqjt2m4
         95Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWBS95gmPUhdSyh9KvDatbdcbGF+4z2fxZl4R3xV7uaLWmNzFhFIHC222If/R4LUcshGvfM0hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqbg5oYsgnPElMnpadxx43n8Bq2P1sgTtte/9zRP1yUdRnJDI
	PM+nLz5PC0pV//BJqTvNGv7nu4djnlGC18NuZpDCxsnduBxqzbgM5HiM01qPQP/qz/TOmMyDbM7
	b6ZgzBrnJ4cs5D+xGqapYbdLX9bVVoX4=
X-Gm-Gg: ASbGncu9YxTFU+0PEeFbSw0CJ5KkdAj7trglDLkhrfb5Bcl2d3BVmrCmAPFdo4n/yGy
	bWfnLjcgYgClg7o7RdJ36qIUxnSWeG98koF0/F6S4/WVc+RNV5+kEZyFnPJ1MJGYiM/QatZOQ/2
	VtZ7nq9amU4qO8eGclg2laN9It2NQgvOA9XsQKLiKYV72UZmMaZWp2Rc+j8GSiylhT0G9r3/h8z
	yWbMMD89UmexzersNlqUb7LCe/fTBzs/7vDw6V+XwTRF+900vx949lNdfvl
X-Google-Smtp-Source: AGHT+IFXK4RlJhG5N0ePOzGo2aczS5G6iw+lxf53O9oDZtZdPYxRASWBOWz3i7tmyMb7gaU0omWaNjuw8uXf/sXa9jw=
X-Received: by 2002:a05:600c:2942:b0:475:de06:dbaf with SMTP id
 5b1f17b1804b1-4778144eaf9mr29391645e9.17.1762890499699; Tue, 11 Nov 2025
 11:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
In-Reply-To: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Nov 2025 11:48:08 -0800
X-Gm-Features: AWmQ_bkqvQTvzr2wIJqIY0mYNqX5zE1OAJvC7EppmNrvuhY6ZoKspaTSdmcDjb4
Message-ID: <CAKEwX=OuhWBZWAKs0JYG6mLqe=NvyiD9L0dOEb=5ZJB-jfFi1Q@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: fix potential UAF issue for VMA readahead
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Huang Ying <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 5:36=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Since commit 78524b05f1a3 ("mm, swap: avoid redundant swap device
> pinning"), the common helper for allocating and preparing a folio in the
> swap cache layer no longer tries to get a swap device reference
> internally, because all callers of __read_swap_cache_async are already
> holding a swap entry reference. The repeated swap device pinning isn't
> needed on the same swap device.
>
> Caller of VMA readahead is also holding a reference to the target
> entry's swap device, but VMA readahead walks the page table, so it might
> encounter swap entries from other devices, and call
> __read_swap_cache_async on another device without holding a reference to
> it.
>
> So it is possible to cause a UAF when swapoff of device A raced with
> swapin on device B, and VMA readahead tries to read swap entries from
> device A. It's not easy to trigger, but in theory, it could cause real
> issues.
>
> Make VMA readahead try to get the device reference first if the swap
> device is a different one from the target entry.
>
> Cc: stable@vger.kernel.org
> Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
> Sending as a new patch instead of V2 because the approach is very
> different.
>
> Previous patch:
> https://lore.kernel.org/linux-mm/20251110-revert-78524b05f1a3-v1-1-88313f=
2b9b20@tencent.com/
> ---
>  mm/swap_state.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0cf9853a9232..da0481e163a4 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -745,6 +745,7 @@ static struct folio *swap_vma_readahead(swp_entry_t t=
arg_entry, gfp_t gfp_mask,
>
>         blk_start_plug(&plug);
>         for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> +               struct swap_info_struct *si =3D NULL;
>                 softleaf_t entry;
>
>                 if (!pte++) {
> @@ -759,8 +760,19 @@ static struct folio *swap_vma_readahead(swp_entry_t =
targ_entry, gfp_t gfp_mask,
>                         continue;
>                 pte_unmap(pte);
>                 pte =3D NULL;
> +               /*
> +                * Readahead entry may come from a device that we are not
> +                * holding a reference to, try to grab a reference, or sk=
ip.
> +                */
> +               if (swp_type(entry) !=3D swp_type(targ_entry)) {
> +                       si =3D get_swap_device(entry);
> +                       if (!si)
> +                               continue;
> +               }
>                 folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, =
ilx,
>                                                 &page_allocated, false);
> +               if (si)
> +                       put_swap_device(si);

Shouldn't we reset si to NULL here?

Otherwise, suppose we're swapping in a readahead window. One of the
swap entries in the window is on a different swapfile from the target
entry. We look up and get a reference to that different swapfile,
setting it to si.

We do the swapping in work, then we release the recently acquired reference=
.

In the next iteration in the for loop, we will still see si !=3D NULL,
and we put_swap_device() it again, i.e double releasing reference to
that swap device.

Or am I missing something?

>                 if (!folio)
>                         continue;
>                 if (page_allocated) {
>

