Return-Path: <stable+bounces-54673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C6A90F8EF
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 00:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803341F224C8
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BDC15A87D;
	Wed, 19 Jun 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEoZ04Sr"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15567C6EB;
	Wed, 19 Jun 2024 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718836122; cv=none; b=XlOy7vryqw7EI+7LGpz7AeGeKiwcjg7rji+hfeOE2ZUZC4KWpVd7unQ17HTd5xdoSBxPd7vl4Wo0dQOO24h8j1aeYSSnc4ApBS2OhCGs8IhM5+rtpr2h5jVvAgSjndrdwVR3p5cIIZAoZ5gh6hjZXemq4P8VG0RSxhyJsNDqsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718836122; c=relaxed/simple;
	bh=ONIjy8wj4Z10aPTD8Jo3QW1Nj58Tk7IHJCGrP6xKS9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFM1QylaROQ8K3C2KQ1Kyk1Fd8KIpPdSpdkSud+hCnuHhUW+yqVE/+vq7fMNMPfwa645ZIggmsh4Jbxu1s71JYlE4V+JTJeQPBnh0KTUhhVe6ramVyseiaHzJdq3rUk1VUn59VDcIlSACpRBbO9qqZTf9LMuC9DVoL25i9L6Qtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEoZ04Sr; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-48f159d3275so123468137.0;
        Wed, 19 Jun 2024 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718836119; x=1719440919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76WkMXBhwe6N2xp4fu56Z3Ov7klwTm7A/zZs08taFkE=;
        b=AEoZ04SrriZAeV2OcW8ANqsxkjNfI9jlf7poMvY3kzZodHWKCJmpvZXwmcZUuDx4QF
         MBvc/ScEDlnRNJyISqPW4fpvrbKkVW5zKtaU3RcQi9tkNTDlNNXYWKen4u32lcD+x4RA
         HPcxjqrfrxJf6wDG/9cy3RK3WP6voGopwq9vvO2ss0DTXlmYNh1UtsCIBn+jutTaxS7+
         htaCdEYGIGVV4GpNUUu+wxswbYciJsHlBzNAF2BPebesUutQqpkLWnwYh6O+kbM7hULV
         JI8dpFkLPmwI6KTcvFE2R1tOiTfnZFiVL3HquVn0/XflLp5boLUeAIa6i76ESBEuhbso
         RUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718836119; x=1719440919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76WkMXBhwe6N2xp4fu56Z3Ov7klwTm7A/zZs08taFkE=;
        b=oBwJMzvaMLgATyY0SU19dHk1TStqK+AtfmmzmQSEQ4qWkvnoONzc/7I8JcP6Xtttnk
         0dQY+ZagSnlvHNqCqcis8yuJ3NOivEb8JBg0bEe6xYoJVWghZzZsZtGerT4d8WIHZmYU
         dMK7nmPuhXi5n8PbQjqQ0xwyTRMVJmJKDfQQ9jo9RssthMG3glTWKBX+LoFvhMbb/sdJ
         Z6c6Un2ZsRIjeHaUaGiou0t7QgFzus+f5HzETWtVKceCrK64MzJwj0+lEVGoP1rOa9D2
         kJyMsecGfthwOfIqvDpml/mfAnt59jtu1D4WVt7bTtCoLLtY6LdepCDG24AjpFRtN0Zr
         +wfA==
X-Forwarded-Encrypted: i=1; AJvYcCXd5okrN2xNyicfqnYfx5MnP+10ESmI1FJG4o/KKe8HlRIZswv86Fdh1xMYDPaTO13P7QWxzj6JfjtyFRpweDG3zT715u3ey6X+U1gR0qLNM9ZGXFYljMg+Asa2FGjvNiMzH4qL
X-Gm-Message-State: AOJu0YxxZ8s2CEG1posG006Kof2qVcJ7AU03yULMJUq5S0ZY5KYbHpmA
	yFddPpFayBUyZ07JFwH82999lJbJ6oE60X2K6LwVK28k5VjXFjNZItlpiW9BVuSUyM3mB2qV6L9
	xr99QVLpYDXkU4uBb1aIRDyP/CiOArzSM
X-Google-Smtp-Source: AGHT+IEW+MCDnUcbcFZwTPreXhMCxw59gEDO699eNxeIUjf41ZTjNA6c/ZiCBjYOCYLHiSPAkqOSrYGAC4fvXLI5CIQ=
X-Received: by 2002:a05:6102:5898:b0:48d:c5ea:d350 with SMTP id
 ada2fe7eead31-48f12fd9001mr4027631137.1.1718836119412; Wed, 19 Jun 2024
 15:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718801672-30152-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1718801672-30152-1-git-send-email-yangge1116@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 10:28:28 +1200
Message-ID: <CAGsJ_4xDY8TrjGOX_xSpM0+wj=CxXy-0R6Wo=Vn3dHOBNtYHng@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: add one PCP list for THP
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	baolin.wang@linux.alibaba.com, mgorman@techsingularity.net, 
	liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:55=E2=80=AFAM <yangge1116@126.com> wrote:
>
> From: yangge <yangge1116@126.com>
>
> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> THP-sized allocations") no longer differentiates the migration type
> of pages in THP-sized PCP list, it's possible that non-movable
> allocation requests may get a CMA page from the list, in some cases,
> it's not acceptable.
>
> If a large number of CMA memory are configured in system (for
> example, the CMA memory accounts for 50% of the system memory),
> starting a virtual machine with device passthrough will get stuck.
> During starting the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory. Normally
> if a page is present and in CMA area, pin_user_pages_remote() will
> migrate the page from CMA area to non-CMA area because of
> FOLL_LONGTERM flag. But if non-movable allocation requests return
> CMA memory, migrate_longterm_unpinnable_pages() will migrate a CMA
> page to another CMA page, which will fail to pass the check in
> check_and_migrate_movable_pages() and cause migration endless.
> Call trace:
> pin_user_pages_remote
> --__gup_longterm_locked // endless loops in this function
> ----_get_user_pages_locked
> ----check_and_migrate_movable_pages
> ------migrate_longterm_unpinnable_pages
> --------alloc_migration_target
>
> This problem will also have a negative impact on CMA itself. For
> example, when CMA is borrowed by THP, and we need to reclaim it
> through cma_alloc() or dma_alloc_coherent(), we must move those
> pages out to ensure CMA's users can retrieve that contigous memory.
> Currently, CMA's memory is occupied by non-movable pages, meaning
> we can't relocate them. As a result, cma_alloc() is more likely to
> fail.
>
> To fix the problem above, we add one PCP list for THP, which will
> not introduce a new cacheline for struct per_cpu_pages. THP will
> have 2 PCP lists, one PCP list is used by MOVABLE allocation, and
> the other PCP list is used by UNMOVABLE allocation. MOVABLE
> allocation contains GPF_MOVABLE, and UNMOVABLE allocation contains
> GFP_UNMOVABLE and GFP_RECLAIMABLE.
>
> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized =
allocations")

Please add the below tag

Cc: <stable@vger.kernel.org>

And I don't think 'mm/page_alloc: add one PCP list for THP' is a good
title. Maybe:

'mm/page_alloc: Separate THP PCP into movable and non-movable categories'

Whenever you send a new version, please add things like 'PATCH V2', 'PATCH =
V3'.
You have already missed several version numbers, so we may have to start fr=
om V2
though V2 is wrong.

> Signed-off-by: yangge <yangge1116@126.com>
> ---
>  include/linux/mmzone.h | 9 ++++-----
>  mm/page_alloc.c        | 9 +++++++--
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b7546dd..cb7f265 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -656,13 +656,12 @@ enum zone_watermarks {
>  };
>
>  /*
> - * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional =
list
> - * for THP which will usually be GFP_MOVABLE. Even if it is another type=
,
> - * it should not contribute to serious fragmentation causing THP allocat=
ion
> - * failures.
> + * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional =
lists
> + * are added for THP. One PCP list is used by GPF_MOVABLE, and the other=
 PCP list
> + * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
>   */
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define NR_PCP_THP 1
> +#define NR_PCP_THP 2
>  #else
>  #define NR_PCP_THP 0
>  #endif
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8f416a0..0a837e6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -504,10 +504,15 @@ static void bad_page(struct page *page, const char =
*reason)
>
>  static inline unsigned int order_to_pindex(int migratetype, int order)
>  {
> +       bool __maybe_unused movable;
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (order > PAGE_ALLOC_COSTLY_ORDER) {
>                 VM_BUG_ON(order !=3D HPAGE_PMD_ORDER);
> -               return NR_LOWORDER_PCP_LISTS;
> +
> +               movable =3D migratetype =3D=3D MIGRATE_MOVABLE;
> +
> +               return NR_LOWORDER_PCP_LISTS + movable;
>         }
>  #else
>         VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> @@ -521,7 +526,7 @@ static inline int pindex_to_order(unsigned int pindex=
)
>         int order =3D pindex / MIGRATE_PCPTYPES;
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -       if (pindex =3D=3D NR_LOWORDER_PCP_LISTS)
> +       if (pindex >=3D NR_LOWORDER_PCP_LISTS)
>                 order =3D HPAGE_PMD_ORDER;
>  #else
>         VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> --
> 2.7.4
>

