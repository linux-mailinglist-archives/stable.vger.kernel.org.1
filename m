Return-Path: <stable+bounces-104431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55FE9F435F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAE916A536
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0DB158DD0;
	Tue, 17 Dec 2024 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQDCLhEO"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB11581E0;
	Tue, 17 Dec 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416081; cv=none; b=RQHA+Cbhpk7PQUlOYlpPA8gz7f3lmNF/qRwqS7HZITWmoYgs2kAeMW5s9a7MP7LREursytbwcFWyGJqiBV+OLRwYNN/u7THVYC6BoFXNq/2YxLAyu/Pkm8BghBJB5nMwdDYqzfmcu4F3gDGgMoBXNhW24RgKhQXn7yozY1NAIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416081; c=relaxed/simple;
	bh=3w11q9YH0Z+6oZTdjzVvRTtCBy+CqdUVYSCLlPgCEL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYnkhwfuVG2A+Ke873Htef1myYDHAHKpirHh3HKGSFf26naSNmgs1AzrKyMlEmbOwk4SVA/BpNCPaDgRkDzO6QeX//iAqjTIKGhOlIw/g1ppdc1K5VxailUFbCTLpv3pA7CLPLABjQ2UYrg++lW7Y8CQH4zgS1nVf5aja4LIrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQDCLhEO; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5188e0c2b52so1378927e0c.1;
        Mon, 16 Dec 2024 22:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734416078; x=1735020878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REsNz8UCtzPLHm1UnEoAtgjQKT/Mquy1DTTItgBHijU=;
        b=UQDCLhEOkbT4Q4lVgdGA+RfJKug2m/+itQOPmLFLgVSKuJtEZrRQFPJ1sdoLCwAbSk
         9km6yCVvj14ffu6jy1xosX9gv1BOGmqHsTwnht4ZYabDBL6SKqNt+TI9/ANg7noJgxt8
         pCyHxLMnC5hvlCbkAQBeNZlCpwvm7Ih+EbzbjXTymkCsbc67SGhUDcJUXnRejnsZ6tCp
         29hthGAe1jjiKA04V9Eq8d9F+tE90IETP7iFv0M5ZqFRYTFk0GrELq+9ofBkURrcGqoL
         uOq6UAO365CB13SBF9Z/pDvjTSV5mKryYXOjaFAKZ9q7JLQIpXJ2+tpicpCDiCOwzD7D
         SAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734416078; x=1735020878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REsNz8UCtzPLHm1UnEoAtgjQKT/Mquy1DTTItgBHijU=;
        b=h/lbKGMq2J9GRuJ9eucvdwKdIXneCSjxhK3xWdTxW5hK4E/XjG0rmyFd6WWTUTAkX/
         DcIdVp954Vd/nkMZLyblOdnSB4leXS2RzlQVgxgUZvrkK5sD7CAXY8Tq8Ktkaq5riFdz
         4MCvyOJ/LZEBvbIo/7fFpbEsaAZzvs+DvZKCxpQqzY1Z+QptkDJCbIRdoKjND9O6vJgV
         nCLQq6FUQs6jH/Wxa6znorYpKnlmkHWcRz407WypKk7YRUjxRihk4BtkUkumXcqx2TqO
         7vl+J0AJLQ3NY3GqWQk2/05gz3vt1r4Nmnbfd2zFJFcx9xEyTYx4XB2GKRll3WGAN3GO
         +quw==
X-Forwarded-Encrypted: i=1; AJvYcCVAMGEPZE0FIWirx//SBXJhhKAxWp5SZZveqGhegxnQjig+BVuwA6A9z412KKlyOi290L43GNpW@vger.kernel.org, AJvYcCWKjV9bAns9wGT3qSJ0CO23QRgM5AjzTveH9CU9EMIq9JYiI8rSfzEQPaIUy4JiLous9pzBIqw5XKFRILg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkIdsrTKf/R0aFNJy/4GyxbPGpH/0ClUapYw8c7BA24PXyG+1
	TjIkxpsGdYpMCy/eCI1+CGtucKd2bUFnz1AHRT34YTFtH05rKx8H0rl4huxlbLdZCt4OFXbqxJo
	3eJKVBGOQIFaE/grErJBfrxT1GwM=
X-Gm-Gg: ASbGncsswRz0EF4Ih/s5zzo5THSBL1ufiEykTm2BNVjePo85a64Rijc/gviXDh/AajQ
	88TV0KwK5I/DJSgFeWwMwv+cVOvRx3Pd9uz+zqtA5sXIq/lyEMcWHDNYCeTWrhnf7muwd3c9l
X-Google-Smtp-Source: AGHT+IH6AtN8EbPyj87cxsUXy2TTEqTpeX9y2XCKMaL8d9/UtSRz8XLjrizYhXdT1RFBVKRey6QhlDyGOHH2JD1C/b8=
X-Received: by 2002:a05:6102:3913:b0:4b1:111b:8c3b with SMTP id
 ada2fe7eead31-4b25dc63207mr15925896137.3.1734416077776; Mon, 16 Dec 2024
 22:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1734406405-25847-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1734406405-25847-1-git-send-email-yangge1116@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 17 Dec 2024 19:14:27 +1300
Message-ID: <CAGsJ_4xSbw7XDe1CWBAfYvMH35n0s1KaSze+wTUDOpwE-VrhfQ@mail.gmail.com>
Subject: Re: [PATCH V6] mm, compaction: don't use ALLOC_CMA in long term GUP flow
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, vbabka@suse.cz, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:33=E2=80=AFPM <yangge1116@126.com> wrote:
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
>
> During the start-up of the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> Long term GUP cannot allocate memory from CMA area, so a maximum
> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> machine memory. Since there is 16G of free CMA memory on the NUMA

Other unmovable allocations, like dma_buf, which can be large in a
Linux system, are
also unable to allocate memory from CMA. My question is whether the issue y=
ou
described applies to these allocations as well.

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

Do we face the same issue if we allocate dma-buf while CMA has plenty
of free memory, but non-CMA has none?

> In order to quickly fall back to remote node, we should remove
> ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
> in long term GUP flow. After this fix, starting a 32GB virtual machine
> with device passthrough takes only a few seconds.
>
> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compact=
ion_suitable()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>
> V6:
> -- update cc->alloc_flags to keep the original loginc
>
> V5:
> - add 'alloc_flags' parameter for __isolate_free_page()
> - remove 'usa_cma' variable
>
> V4:
> - rich the commit log description
>
> V3:
> - fix build errors
> - add ALLOC_CMA both in should_continue_reclaim() and compaction_ready()
>
> V2:
> - using the 'cc->alloc_flags' to determin if 'ALLOC_CMA' is needed
> - rich the commit log description
>
>  include/linux/compaction.h |  6 ++++--
>  mm/compaction.c            | 26 +++++++++++++++-----------
>  mm/internal.h              |  3 ++-
>  mm/page_alloc.c            |  7 +++++--
>  mm/page_isolation.c        |  3 ++-
>  mm/page_reporting.c        |  2 +-
>  mm/vmscan.c                |  4 ++--
>  7 files changed, 31 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index e947764..b4c3ac3 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -90,7 +90,8 @@ extern enum compact_result try_to_compact_pages(gfp_t g=
fp_mask,
>                 struct page **page);
>  extern void reset_isolation_suitable(pg_data_t *pgdat);
>  extern bool compaction_suitable(struct zone *zone, int order,
> -                                              int highest_zoneidx);
> +                                              int highest_zoneidx,
> +                                              unsigned int alloc_flags);
>
>  extern void compaction_defer_reset(struct zone *zone, int order,
>                                 bool alloc_success);
> @@ -108,7 +109,8 @@ static inline void reset_isolation_suitable(pg_data_t=
 *pgdat)
>  }
>
>  static inline bool compaction_suitable(struct zone *zone, int order,
> -                                                     int highest_zoneidx=
)
> +                                                     int highest_zoneidx=
,
> +                                                     unsigned int alloc_=
flags)
>  {
>         return false;
>  }
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 07bd227..d92ba6c 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -655,7 +655,7 @@ static unsigned long isolate_freepages_block(struct c=
ompact_control *cc,
>
>                 /* Found a free page, will break it into order-0 pages */
>                 order =3D buddy_order(page);
> -               isolated =3D __isolate_free_page(page, order);
> +               isolated =3D __isolate_free_page(page, order, cc->alloc_f=
lags);
>                 if (!isolated)
>                         break;
>                 set_page_private(page, order);
> @@ -1634,7 +1634,7 @@ static void fast_isolate_freepages(struct compact_c=
ontrol *cc)
>
>                 /* Isolate the page if available */
>                 if (page) {
> -                       if (__isolate_free_page(page, order)) {
> +                       if (__isolate_free_page(page, order, cc->alloc_fl=
ags)) {
>                                 set_page_private(page, order);
>                                 nr_isolated =3D 1 << order;
>                                 nr_scanned +=3D nr_isolated - 1;
> @@ -2381,6 +2381,7 @@ static enum compact_result compact_finished(struct =
compact_control *cc)
>
>  static bool __compaction_suitable(struct zone *zone, int order,
>                                   int highest_zoneidx,
> +                                 unsigned int alloc_flags,
>                                   unsigned long wmark_target)
>  {
>         unsigned long watermark;
> @@ -2395,25 +2396,26 @@ static bool __compaction_suitable(struct zone *zo=
ne, int order,
>          * even if compaction succeeds.
>          * For costly orders, we require low watermark instead of min for
>          * compaction to proceed to increase its chances.
> -        * ALLOC_CMA is used, as pages in CMA pageblocks are considered
> -        * suitable migration targets
> +        * In addition to long term GUP flow, ALLOC_CMA is used, as pages=
 in
> +        * CMA pageblocks are considered suitable migration targets

I'm not sure if this document is correct for cases other than GUP.

>          */
>         watermark =3D (order > PAGE_ALLOC_COSTLY_ORDER) ?
>                                 low_wmark_pages(zone) : min_wmark_pages(z=
one);
>         watermark +=3D compact_gap(order);
>         return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
> -                                  ALLOC_CMA, wmark_target);
> +                                  alloc_flags & ALLOC_CMA, wmark_target)=
;
>  }
>
>  /*
>   * compaction_suitable: Is this suitable to run compaction on this zone =
now?
>   */
> -bool compaction_suitable(struct zone *zone, int order, int highest_zonei=
dx)
> +bool compaction_suitable(struct zone *zone, int order, int highest_zonei=
dx,
> +                                  unsigned int alloc_flags)
>  {
>         enum compact_result compact_result;
>         bool suitable;
>
> -       suitable =3D __compaction_suitable(zone, order, highest_zoneidx,
> +       suitable =3D __compaction_suitable(zone, order, highest_zoneidx, =
alloc_flags,
>                                          zone_page_state(zone, NR_FREE_PA=
GES));
>         /*
>          * fragmentation index determines if allocation failures are due =
to
> @@ -2474,7 +2476,7 @@ bool compaction_zonelist_suitable(struct alloc_cont=
ext *ac, int order,
>                 available =3D zone_reclaimable_pages(zone) / order;
>                 available +=3D zone_page_state_snapshot(zone, NR_FREE_PAG=
ES);
>                 if (__compaction_suitable(zone, order, ac->highest_zoneid=
x,
> -                                         available))
> +                                         alloc_flags, available))
>                         return true;
>         }
>
> @@ -2499,7 +2501,7 @@ compaction_suit_allocation_order(struct zone *zone,=
 unsigned int order,
>                               alloc_flags))
>                 return COMPACT_SUCCESS;
>
> -       if (!compaction_suitable(zone, order, highest_zoneidx))
> +       if (!compaction_suitable(zone, order, highest_zoneidx, alloc_flag=
s))
>                 return COMPACT_SKIPPED;
>
>         return COMPACT_CONTINUE;
> @@ -2893,6 +2895,7 @@ static int compact_node(pg_data_t *pgdat, bool proa=
ctive)
>         struct compact_control cc =3D {
>                 .order =3D -1,
>                 .mode =3D proactive ? MIGRATE_SYNC_LIGHT : MIGRATE_SYNC,
> +               .alloc_flags =3D ALLOC_CMA,
>                 .ignore_skip_hint =3D true,
>                 .whole_zone =3D true,
>                 .gfp_mask =3D GFP_KERNEL,
> @@ -3037,7 +3040,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgda=
t)
>
>                 ret =3D compaction_suit_allocation_order(zone,
>                                 pgdat->kcompactd_max_order,
> -                               highest_zoneidx, ALLOC_WMARK_MIN);
> +                               highest_zoneidx, ALLOC_CMA | ALLOC_WMARK_=
MIN);
>                 if (ret =3D=3D COMPACT_CONTINUE)
>                         return true;
>         }
> @@ -3058,6 +3061,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
>                 .search_order =3D pgdat->kcompactd_max_order,
>                 .highest_zoneidx =3D pgdat->kcompactd_highest_zoneidx,
>                 .mode =3D MIGRATE_SYNC_LIGHT,
> +               .alloc_flags =3D ALLOC_CMA | ALLOC_WMARK_MIN,
>                 .ignore_skip_hint =3D false,
>                 .gfp_mask =3D GFP_KERNEL,
>         };
> @@ -3078,7 +3082,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
>                         continue;
>
>                 ret =3D compaction_suit_allocation_order(zone,
> -                               cc.order, zoneid, ALLOC_WMARK_MIN);
> +                               cc.order, zoneid, cc.alloc_flags);
>                 if (ret !=3D COMPACT_CONTINUE)
>                         continue;
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 3922788..6d257c8 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -662,7 +662,8 @@ static inline void clear_zone_contiguous(struct zone =
*zone)
>         zone->contiguous =3D false;
>  }
>
> -extern int __isolate_free_page(struct page *page, unsigned int order);
> +extern int __isolate_free_page(struct page *page, unsigned int order,
> +                                   unsigned int alloc_flags);
>  extern void __putback_isolated_page(struct page *page, unsigned int orde=
r,
>                                     int mt);
>  extern void memblock_free_pages(struct page *page, unsigned long pfn,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dde19db..1bfdca3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2809,7 +2809,8 @@ void split_page(struct page *page, unsigned int ord=
er)
>  }
>  EXPORT_SYMBOL_GPL(split_page);
>
> -int __isolate_free_page(struct page *page, unsigned int order)
> +int __isolate_free_page(struct page *page, unsigned int order,
> +                                  unsigned int alloc_flags)
>  {
>         struct zone *zone =3D page_zone(page);
>         int mt =3D get_pageblock_migratetype(page);
> @@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsigned=
 int order)
>                  * exists.
>                  */
>                 watermark =3D zone->_watermark[WMARK_MIN] + (1UL << order=
);
> -               if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
> +               if (!zone_watermark_ok(zone, 0, watermark, 0,
> +                           alloc_flags & ALLOC_CMA))
>                         return 0;
>         }
>
> @@ -6454,6 +6456,7 @@ int alloc_contig_range_noprof(unsigned long start, =
unsigned long end,
>                 .order =3D -1,
>                 .zone =3D page_zone(pfn_to_page(start)),
>                 .mode =3D MIGRATE_SYNC,
> +               .alloc_flags =3D ALLOC_CMA,
>                 .ignore_skip_hint =3D true,
>                 .no_set_skip_hint =3D true,
>                 .alloc_contig =3D true,
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index c608e9d..a1f2c79 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -229,7 +229,8 @@ static void unset_migratetype_isolate(struct page *pa=
ge, int migratetype)
>                         buddy =3D find_buddy_page_pfn(page, page_to_pfn(p=
age),
>                                                     order, NULL);
>                         if (buddy && !is_migrate_isolate_page(buddy)) {
> -                               isolated_page =3D !!__isolate_free_page(p=
age, order);
> +                               isolated_page =3D !!__isolate_free_page(p=
age, order,
> +                                                   ALLOC_CMA);
>                                 /*
>                                  * Isolating a free page in an isolated p=
ageblock
>                                  * is expected to always work as watermar=
ks don't
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index e4c428e..fd3813b 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -198,7 +198,7 @@ page_reporting_cycle(struct page_reporting_dev_info *=
prdev, struct zone *zone,
>
>                 /* Attempt to pull page from list and place in scatterlis=
t */
>                 if (*offset) {
> -                       if (!__isolate_free_page(page, order)) {
> +                       if (!__isolate_free_page(page, order, ALLOC_CMA))=
 {
>                                 next =3D page;
>                                 break;
>                         }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5e03a61..33f5b46 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5815,7 +5815,7 @@ static inline bool should_continue_reclaim(struct p=
glist_data *pgdat,
>                                       sc->reclaim_idx, 0))
>                         return false;
>
> -               if (compaction_suitable(zone, sc->order, sc->reclaim_idx)=
)
> +               if (compaction_suitable(zone, sc->order, sc->reclaim_idx,=
 ALLOC_CMA))
>                         return false;
>         }
>
> @@ -6043,7 +6043,7 @@ static inline bool compaction_ready(struct zone *zo=
ne, struct scan_control *sc)
>                 return true;
>
>         /* Compaction cannot yet proceed. Do reclaim. */
> -       if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
> +       if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, ALLOC_=
CMA))
>                 return false;
>
>         /*
> --
> 2.7.4
>
>

Thanks
Barry

