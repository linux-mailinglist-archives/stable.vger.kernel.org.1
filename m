Return-Path: <stable+bounces-194598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17FC51BC5
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 601894FBFBA
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765AA30216D;
	Wed, 12 Nov 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsNJu+cD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348292C0296
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943625; cv=none; b=RrrH2+mddMRN/WsIDPjco5CS0b6W2b/QIzmOEydfWjhiq434ecQOgJTzWqw1rc7kDkVB9aaSwj07F3yMjA6kofFdb/3fUZNIajYmfWYWB0AxKY5dNO7zi5bv5DHeLvllnL+gEfQ21AWZfle7r+eDAw5dxOVYEGb9oQ8mhounTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943625; c=relaxed/simple;
	bh=6os1QpRBV8+5AwChEFKqOE4/pzICEt5Fpg+noRChogc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL/04dpujx3V53ytvUucKTrliB/feksI4qcBGwhpEyeJ+iIU6xcudk69EpYZK/aic/ntrR2YRCJ8dF9JfUaeSwxGkg9B8SboNnOo0DmyPmwrAlA6mbBy9N0KbYsGcmdfvRLCEb6fT6hSshTk+hwNkvvnWEr7WY0C3LFtWXzUb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsNJu+cD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E40C19421
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762943624;
	bh=6os1QpRBV8+5AwChEFKqOE4/pzICEt5Fpg+noRChogc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tsNJu+cDjDDdXEh0EDyKh8TkaQax/UchDUORnmyqw9mB8HktY2ClNm1dsIdwuEylf
	 Pjn5Jq/v/J2vcEaH5jhtcNmxAwRPf+2uVUmkNVrLYQCTBqccHnA9cSztP3zOWIyiMf
	 6ECj18Tu7my+VxZfkdEYrI1pjL73Cr9jbUYKWqIY3+hThxqh9ZBPC0MWXuVUV7r6Sx
	 wQEwH7hAa6qMm5A3apYjwIFY6HnIb6SfEWCOKfuZqLSwoBKIl5VCYWyMkATLSbyZrR
	 f1tw1FD1O+M3+YABAO1VRWwwrJvUvT8vM1PqUCSlFQrSrSR+H6aL+pcMxYVLR6L9a3
	 U8QTHJMfsTRdQ==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7866aca9ff4so7258307b3.3
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 02:33:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9caD26tPO8D4LKn+0+TBdxYSCX40vs/DReZ6u5Yt/11flHrltx4Jzv22IGqJf9k1TwK1pbs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNKQbBD8lAX7TmO7NR8HP6U//dm56RlJmJ9518JlaLcyaYSad
	84WQzDQNeZhx/VBnwNmfNy2Um5tANSFnVLevtCSTdb0WK5WnlMMWbgnMp3UVx/DrNhg6FDEWadN
	lSws+uKZoiNBKYXGsXLt7RvtEfru7nyflSYGJECDSvw==
X-Google-Smtp-Source: AGHT+IFJEmuYIDi01UFhuE/DkbKBDGrDMbCjJHTiVTHDatPgNcmeGNmC1jG+SeG3tSCjLst7swV3IZ0wX4R/TkQOu3U=
X-Received: by 2002:a05:690c:4183:b0:787:f5c5:c631 with SMTP id
 00721157ae682-788136f5527mr16083137b3.65.1762943624138; Wed, 12 Nov 2025
 02:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
In-Reply-To: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 12 Nov 2025 02:33:33 -0800
X-Gmail-Original-Message-ID: <CACePvbVu52yrPd+4EPqfSpC5fCmS6mYOqKDNGyzcpSvAQgh0pg@mail.gmail.com>
X-Gm-Features: AWmQ_bn7QCBcJADZbM2huFUVMcx-IOnydFhAnFGmEpZSzaNGRhEh8MWWHlrht-E
Message-ID: <CACePvbVu52yrPd+4EPqfSpC5fCmS6mYOqKDNGyzcpSvAQgh0pg@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: fix potential UAF issue for VMA readahead
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Huang Ying <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

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
>                 if (!folio)
>                         continue;
>                 if (page_allocated) {
>
> ---
> base-commit: 565d240810a6c9689817a9f3d08f80adf488ca59
> change-id: 20251111-swap-fix-vma-uaf-bec70969250f
>
> Best regards,
> --
> Kairui Song <kasong@tencent.com>
>

