Return-Path: <stable+bounces-103974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27689F05D7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBEC188A455
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A70119CD08;
	Fri, 13 Dec 2024 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhnqBAQ+"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103819CC2D;
	Fri, 13 Dec 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734076592; cv=none; b=qdou898vYnq/KM3zj76ed6HswdDXRjTjr0ybcRn2UfETe00GYyjkx8NIC08bH14ET4E4s4OvmTPufYqAflGq36jH6JGjGdCVIjWRPeQOzsyEnZJHQjNRHCnoY3c2tbciMco3Mfm/H+LndkE+Rz+hU0Lqyo2Wv5sONApmwXGPzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734076592; c=relaxed/simple;
	bh=XJayrBBrGiA7eSPtS1cMs980+tUcwNZFD32RdLke+2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8Sbc1hg0FvEU5duh/dlkyDdGXonlU9v5E2hDARKjrR3HEd9Syfw/+9g7SMtZyzhtY7MkRNMeZayqM+VGLeE5H5/gb7ysN3KR1it07iTuacsQxhTnri6V9hQpAvXlePRuMp8JOEuHoXXsyo56YN2xoFlvQHz5ttA/OnMfxqErPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhnqBAQ+; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5174f298e18so339215e0c.2;
        Thu, 12 Dec 2024 23:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734076589; x=1734681389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAZFmiTyYiF000hk68Buo6otiAg019Vj2ktyMah92L0=;
        b=JhnqBAQ+frrxQUUVA0sSsftuFojQDBCGGyuSZ8pqqLDTG3DJ7itmisFfXS9B0DV5dp
         I1oRAQL1RWrrZ6rOo1QuoRO9DDl+1pMWQs2WQQisejd77t++5+75D1DNb8azDVahP8Ws
         ekVtO1sdJG5eEP2xB99yEuMWgy/VQGYOvGJHGo96NsxZ/Euwqnl9+n52wSDSyx2Gxk2r
         1n1ToH7S2h2VY0MmN138MuiwUDOBGX9S7U1Cv+rkK728PnBbd9J5TILSIf7fKIdJHjLk
         dCIOI3zbsWQHw2rkgpxnpygxHDao920sBdDFgOYSycLEafritVM5juMEo8lJA6zYeC+O
         g1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734076589; x=1734681389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAZFmiTyYiF000hk68Buo6otiAg019Vj2ktyMah92L0=;
        b=Xr4m3V/wfh22gHz+3CQfJ9wkoyz6UimiruGQ83uHZjzBRvs8kk0OiygTP0gu5pBNLM
         7qNex+bk5vk13eeFKp+qYGnYhS4Tls5XhUFZHzmqODSAyEPpY51/udjOcqP0JE8bDLA/
         GZnVNW2g3sPwMK07x2XydYlIlLhp24EdMDQwn5Bf9IKMXl8jccb4YINsh+R8ZPk+3070
         UJsv3eEj9YIs+rU8S5sNF1j+NYy2DrHldCZogvLAydFfoSP9cyjkBqCJwbwQInMhYMeA
         +Mpp9IL4F9ILNZ0ISGwDmA1himSmyCbbAS2z0iiQr8PnXS4zA5Ai25rPizBOYH/UWgxG
         mWNw==
X-Forwarded-Encrypted: i=1; AJvYcCVJsXmM0ciKVEI0SxkVH7XdcNQVP0gpKp/zCINeiqZFZmeN6+0ULh/NSTWVbBuwOHH+accAx0bq@vger.kernel.org, AJvYcCVaHR/QZcFcgakvwMkrcUBqXHsp6HWlDTZy0onWBLMvpRNpx/wQQKxqEObQf3JHa2VlT7y+no8cpdD0iLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaXUJIE3gj1jpl5KP5Yn1nSXuuGvwNVaaGjUsZPYKt+/xstTd
	VYAzoeQ3fkfU6XMyHHwrofLNz/moBUdj4l1Z3INtJGRHZaB4hGdICt9SBPB6QcM4fG6mA0RWg2H
	n6o8uB6GbIBsBNMCkrr/+Ltfu758=
X-Gm-Gg: ASbGncuHhNgTqm6ZTnrMtUastGyk7r8BowBajwmAOQ80nxpW7+3AGq+I0R7GAzPlLdQ
	LtH1Be7SXu4d+E6DgfeV5DmSs0zYq82+9w41nA7/pVPwYeIaluCzmXx+7P0GN5MDO2dCH1UKg
X-Google-Smtp-Source: AGHT+IHzjoKLoHgKyyvyCHSY+nRVoq4LKRH2Nv9Zon5WLa5154FhDvAMikc4GqMQWi9syUuz9ZHOhdn71sB9i/U31TU=
X-Received: by 2002:a05:6122:2a09:b0:518:791a:3462 with SMTP id
 71dfb90a1353d-518ca45a40amr1354897e0c.9.1734076589259; Thu, 12 Dec 2024
 23:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1734075432-14131-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1734075432-14131-1-git-send-email-yangge1116@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 13 Dec 2024 15:56:17 +0800
Message-ID: <CAGsJ_4yQ5f1Nqu+aw2WRWivcK=PNdghdkYG3OneTJvL9mjdiiQ@mail.gmail.com>
Subject: Re: [PATCH] mm, compaction: don't use ALLOC_CMA in long term GUP flow
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, vbabka@suse.cz, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 3:37=E2=80=AFPM <yangge1116@126.com> wrote:
>
> From: yangge <yangge1116@126.com>
>
> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
> in __compaction_suitable()") allow compaction to proceed when free
> pages required for compaction reside in the CMA pageblocks, it's
> possible that __compaction_suitable() always returns true, and in
> some cases, it's not acceptable.
>
> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
> of memory. I have configured 16GB of CMA memory on each NUMA node,
> and starting a 32GB virtual machine with device passthrough is
> extremely slow, taking almost an hour.

I don't fully understand why each node has a 16GB CMA. As I recall, I desig=
ned
the per-NUMA CMA to support devices that are not behind the IOMMU, such as
the IOMMU itself or certain device drivers which are not having IOMMU and
need contiguous memory for DMA. These devices don't seem to require that
much memory.

>
> During the start-up of the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> Long term GUP cannot allocate memory from CMA area, so a maximum
> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> machine memory. Since there is 16G of free CMA memory on the NUMA
> node, watermark for order-0 always be met for compaction, so
> __compaction_suitable() always returns true, even if the node is
> unable to allocate non-CMA memory for the virtual machine.
>
> For costly allocations, because __compaction_suitable() always
> returns true, __alloc_pages_slowpath() can't exit at the appropriate
> place, resulting in excessively long virtual machine startup times.
> Call trace:
> __alloc_pages_slowpath
>     if (compact_result =3D=3D COMPACT_SKIPPED ||
>         compact_result =3D=3D COMPACT_DEFERRED)
>         goto nopage; // should exit __alloc_pages_slowpath() from here
>
> To sum up, during long term GUP flow, we should remove ALLOC_CMA
> both in __compaction_suitable() and __isolate_free_page().

What=E2=80=99s the outcome after your fix? Will it quickly fall back to rem=
ote
NUMA nodes
for the pin?

>
> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compact=
ion_suitable()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>  mm/compaction.c | 8 +++++---
>  mm/page_alloc.c | 4 +++-
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 07bd227..044c2247 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2384,6 +2384,7 @@ static bool __compaction_suitable(struct zone *zone=
, int order,
>                                   unsigned long wmark_target)
>  {
>         unsigned long watermark;
> +       bool pin;
>         /*
>          * Watermarks for order-0 must be met for compaction to be able t=
o
>          * isolate free pages for migration targets. This means that the
> @@ -2395,14 +2396,15 @@ static bool __compaction_suitable(struct zone *zo=
ne, int order,
>          * even if compaction succeeds.
>          * For costly orders, we require low watermark instead of min for
>          * compaction to proceed to increase its chances.
> -        * ALLOC_CMA is used, as pages in CMA pageblocks are considered
> -        * suitable migration targets
> +        * In addition to long term GUP flow, ALLOC_CMA is used, as pages=
 in
> +        * CMA pageblocks are considered suitable migration targets
>          */
>         watermark =3D (order > PAGE_ALLOC_COSTLY_ORDER) ?
>                                 low_wmark_pages(zone) : min_wmark_pages(z=
one);
>         watermark +=3D compact_gap(order);
> +       pin =3D !!(current->flags & PF_MEMALLOC_PIN);
>         return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
> -                                  ALLOC_CMA, wmark_target);
> +                                  pin ? 0 : ALLOC_CMA, wmark_target);
>  }
>
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dde19db..9a5dfda 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2813,6 +2813,7 @@ int __isolate_free_page(struct page *page, unsigned=
 int order)
>  {
>         struct zone *zone =3D page_zone(page);
>         int mt =3D get_pageblock_migratetype(page);
> +       bool pin;
>
>         if (!is_migrate_isolate(mt)) {
>                 unsigned long watermark;
> @@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsigned=
 int order)
>                  * exists.
>                  */
>                 watermark =3D zone->_watermark[WMARK_MIN] + (1UL << order=
);
> -               if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
> +               pin =3D !!(current->flags & PF_MEMALLOC_PIN);
> +               if (!zone_watermark_ok(zone, 0, watermark, 0, pin ? 0 : A=
LLOC_CMA))
>                         return 0;
>         }
>
> --
> 2.7.4
>
Thanks
Barry

