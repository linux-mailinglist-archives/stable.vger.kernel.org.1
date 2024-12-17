Return-Path: <stable+bounces-104434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 468419F43B7
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC887A3676
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3814A095;
	Tue, 17 Dec 2024 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcy5FjdP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5514C5AF;
	Tue, 17 Dec 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417085; cv=none; b=G4NbGXxmMtbiT/brsw3LCtWDdOegUauydhuRBygJO1JzNk4G+wI+dnpoOeioeS5hp8YequuLQtqDlY59Lyvqs+UsFVUcmh5teiVqH7eG/QkzEQxDjydDiMa9LkK3uZbIIogtZTNbavt/ZdwIxXfU9x3F5SQBX5kjSHYXUrvqHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417085; c=relaxed/simple;
	bh=QIDdj1nT9kqB545uGMG+wjDSxqWfhaRe6OwGDdLXgq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIDccFqXnAC1gDdia0DTRtUbCMfWAUtdVgf5xuPRBYZAyridNQEPI9wZdZlro2jX3bPYXNrVIgez3VRQvHGfCLnk+kPL0jf6nDHwX1HtPiQgA7N6/3vNkNH74KGNaZlQrnlwHzS9douGz6dI4JJa4xIH3BmS3PCQbVHYs22Lr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcy5FjdP; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85bc5d0509bso941715241.1;
        Mon, 16 Dec 2024 22:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734417082; x=1735021882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoCTw3yoTAAXZkQxzJABZOy7K2Bqpin/AmsPBfgbh/o=;
        b=Zcy5FjdPMYiT/uD4b7BRxOa8BOW+BuLU+Ju66h2YDdxAw2hP9c4BulR5WbgWGipZsw
         NXySftEdcWzr6gGZaOWUIsKkl+gmWAOU7gO0v2wGABdp1CZzfrDD9Ggue5U7uvk2k9hh
         WQDHiX8wG8d/lwEiuSY6/3HW7EIJcDMeIK2LcZ2dmZvIy9Ps/Xdairg8Ip1J88UWPrrW
         f57eHEY/GpZSn88En/AOIKNmj98WLW/xVI+kKYcBTdzfsCSjEqb57Gp4UKO9Xz1PygYb
         u2ruA3Mg1DT+FVkko/x3KnVovcmz2uIUlLB6BS+fUgU7arDiCe9X2E9jiDEnKOVV8tT6
         cy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417082; x=1735021882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoCTw3yoTAAXZkQxzJABZOy7K2Bqpin/AmsPBfgbh/o=;
        b=rZzGHLf6mQ7c6dXdrw5TWaOlE/DzQx4PkqPrC/1YDiA38xGEzvt7ydwGhjpbSE+0l/
         n716tkonScN1FgmtB1yyRA/JXK4L+rrREGgaHmaWWrwgo0ntt7KQCfpmzI5aZvB/KZcg
         02YDBkqBhItay4qfrp3tEAcQosIa5ANerW93aIB8UmzQHet80YUJbk1B2L1pksJzumtA
         sptxtmizRKoN+T0Vnynf0IquJs4gSxlFeSAKC7HNVXbL3Ew+bxt9oXsWDZCPuagqzFQr
         W6BoytrfwXHuuqQdMjXhDMItos2yxMS59AS8eK0kFwcQl16S+lE6DHi1pSZg4KbdwjFj
         Kg7w==
X-Forwarded-Encrypted: i=1; AJvYcCUi2UWiKWnWEk/QiZbK+e+6cZu4YDE+97NJshGR/TIKV+DZ1ylx3VpF5uJUzlCnIUw34gPWwfk5@vger.kernel.org, AJvYcCXeNmJywg+Qe5YZTmW1MAGbG7gOwdjEjJpGvuOo02NPzZk/MwsSjGoI0AD8G6flepE9R7Z/NXn2tzmyMCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3O5m0r94sxtYr+WG81gb1Y9FQvusBg/0Idn13o4APd1JZVVJC
	fsnk/75YlXM5ZWseNWlxapfrZj7By6F6HSFTrMqJOkRpHMDFgAM1p7veBAi6/rl/JFnc/fagx6e
	JagzF7JSK6JCYQ8T6D0MbFiK75Ck=
X-Gm-Gg: ASbGnctMFLDTak8Mw/SyjKdA4AqKKq4CVFDLwpJRZzq0wgmKk0MOnitoFfqkDTYBFty
	AjF2x2B6q7iE3CkMs8bnkQEGf0wabMgS+oN9pXd42tmYGeRfa62pF2gozAxmTV4ST9hphQpR6
X-Google-Smtp-Source: AGHT+IGAl8tplULeypePPjHpmYvjC519UM2O8ZbyPQCSK24sAFmGyUqANglZYGkF2rx/sAhGaOa+sl/d7GyQLL5aOD0=
X-Received: by 2002:a05:6102:4425:b0:4b2:48cc:74f3 with SMTP id
 ada2fe7eead31-4b25d9b2410mr14965754137.12.1734417082206; Mon, 16 Dec 2024
 22:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1734406405-25847-1-git-send-email-yangge1116@126.com> <CAGsJ_4xSbw7XDe1CWBAfYvMH35n0s1KaSze+wTUDOpwE-VrhfQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xSbw7XDe1CWBAfYvMH35n0s1KaSze+wTUDOpwE-VrhfQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 17 Dec 2024 19:31:11 +1300
Message-ID: <CAGsJ_4zW9wmtGtTNZ4HowvL=suZAf-yAeqLBuKW_soOAEjmo3Q@mail.gmail.com>
Subject: Re: [PATCH V6] mm, compaction: don't use ALLOC_CMA in long term GUP flow
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, vbabka@suse.cz, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 7:14=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Dec 17, 2024 at 4:33=E2=80=AFPM <yangge1116@126.com> wrote:
> >
> > From: yangge <yangge1116@126.com>
> >
> > Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
> > in __compaction_suitable()") allow compaction to proceed when free
> > pages required for compaction reside in the CMA pageblocks, it's
> > possible that __compaction_suitable() always returns true, and in
> > some cases, it's not acceptable.
> >
> > There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
> > of memory. I have configured 16GB of CMA memory on each NUMA node,
> > and starting a 32GB virtual machine with device passthrough is
> > extremely slow, taking almost an hour.
> >
> > During the start-up of the virtual machine, it will call
> > pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> > Long term GUP cannot allocate memory from CMA area, so a maximum
> > of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> > machine memory. Since there is 16G of free CMA memory on the NUMA
>
> Other unmovable allocations, like dma_buf, which can be large in a
> Linux system, are
> also unable to allocate memory from CMA. My question is whether the issue=
 you
> described applies to these allocations as well.
>
> > node, watermark for order-0 always be met for compaction, so
> > __compaction_suitable() always returns true, even if the node is
> > unable to allocate non-CMA memory for the virtual machine.
> >
> > For costly allocations, because __compaction_suitable() always
> > returns true, __alloc_pages_slowpath() can't exit at the appropriate
> > place, resulting in excessively long virtual machine startup times.
> > Call trace:
> > __alloc_pages_slowpath
> >     if (compact_result =3D=3D COMPACT_SKIPPED ||
> >         compact_result =3D=3D COMPACT_DEFERRED)
> >         goto nopage; // should exit __alloc_pages_slowpath() from here
> >
>
> Do we face the same issue if we allocate dma-buf while CMA has plenty
> of free memory, but non-CMA has none?
>
> > In order to quickly fall back to remote node, we should remove
> > ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
> > in long term GUP flow. After this fix, starting a 32GB virtual machine
> > with device passthrough takes only a few seconds.
> >
> > Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compa=
ction_suitable()")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: yangge <yangge1116@126.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> >
> > V6:
> > -- update cc->alloc_flags to keep the original loginc
> >
> > V5:
> > - add 'alloc_flags' parameter for __isolate_free_page()
> > - remove 'usa_cma' variable
> >
> > V4:
> > - rich the commit log description
> >
> > V3:
> > - fix build errors
> > - add ALLOC_CMA both in should_continue_reclaim() and compaction_ready(=
)
> >
> > V2:
> > - using the 'cc->alloc_flags' to determin if 'ALLOC_CMA' is needed
> > - rich the commit log description
> >
> >  include/linux/compaction.h |  6 ++++--
> >  mm/compaction.c            | 26 +++++++++++++++-----------
> >  mm/internal.h              |  3 ++-
> >  mm/page_alloc.c            |  7 +++++--
> >  mm/page_isolation.c        |  3 ++-
> >  mm/page_reporting.c        |  2 +-
> >  mm/vmscan.c                |  4 ++--
> >  7 files changed, 31 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> > index e947764..b4c3ac3 100644
> > --- a/include/linux/compaction.h
> > +++ b/include/linux/compaction.h
> > @@ -90,7 +90,8 @@ extern enum compact_result try_to_compact_pages(gfp_t=
 gfp_mask,
> >                 struct page **page);
> >  extern void reset_isolation_suitable(pg_data_t *pgdat);
> >  extern bool compaction_suitable(struct zone *zone, int order,
> > -                                              int highest_zoneidx);
> > +                                              int highest_zoneidx,
> > +                                              unsigned int alloc_flags=
);
> >
> >  extern void compaction_defer_reset(struct zone *zone, int order,
> >                                 bool alloc_success);
> > @@ -108,7 +109,8 @@ static inline void reset_isolation_suitable(pg_data=
_t *pgdat)
> >  }
> >
> >  static inline bool compaction_suitable(struct zone *zone, int order,
> > -                                                     int highest_zonei=
dx)
> > +                                                     int highest_zonei=
dx,
> > +                                                     unsigned int allo=
c_flags)
> >  {
> >         return false;
> >  }
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 07bd227..d92ba6c 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -655,7 +655,7 @@ static unsigned long isolate_freepages_block(struct=
 compact_control *cc,
> >
> >                 /* Found a free page, will break it into order-0 pages =
*/
> >                 order =3D buddy_order(page);
> > -               isolated =3D __isolate_free_page(page, order);
> > +               isolated =3D __isolate_free_page(page, order, cc->alloc=
_flags);
> >                 if (!isolated)
> >                         break;
> >                 set_page_private(page, order);
> > @@ -1634,7 +1634,7 @@ static void fast_isolate_freepages(struct compact=
_control *cc)
> >
> >                 /* Isolate the page if available */
> >                 if (page) {
> > -                       if (__isolate_free_page(page, order)) {
> > +                       if (__isolate_free_page(page, order, cc->alloc_=
flags)) {
> >                                 set_page_private(page, order);
> >                                 nr_isolated =3D 1 << order;
> >                                 nr_scanned +=3D nr_isolated - 1;
> > @@ -2381,6 +2381,7 @@ static enum compact_result compact_finished(struc=
t compact_control *cc)
> >
> >  static bool __compaction_suitable(struct zone *zone, int order,
> >                                   int highest_zoneidx,
> > +                                 unsigned int alloc_flags,
> >                                   unsigned long wmark_target)
> >  {
> >         unsigned long watermark;
> > @@ -2395,25 +2396,26 @@ static bool __compaction_suitable(struct zone *=
zone, int order,
> >          * even if compaction succeeds.
> >          * For costly orders, we require low watermark instead of min f=
or
> >          * compaction to proceed to increase its chances.
> > -        * ALLOC_CMA is used, as pages in CMA pageblocks are considered
> > -        * suitable migration targets
> > +        * In addition to long term GUP flow, ALLOC_CMA is used, as pag=
es in
> > +        * CMA pageblocks are considered suitable migration targets
>
> I'm not sure if this document is correct for cases other than GUP.

Hi yangge,

Could we please run the same test using dma-buf? The simplest approach is
to use system_heap from drivers/dma-buf/heaps/system_heap.c.

Userspace programming it is quite straightforward:
https://static.linaro.org/connect/lvc21/presentations/lvc21-120.pdf

struct dma_heap_allocation_data heap_data =3D { .len =3D 1048576,  // 1meg
    .fd_flags =3D O_RDWR | O_CLOEXEC, };

fd =3D open(=E2=80=9C/dev/dma_heap/system=E2=80=9D, O_RDONLY | O_CLOEXEC);
if (fd < 0)
      return fd;
ret =3D ioctl(fd, DMA_HEAP_IOCTL_ALLOC, &heap_data);

There are two objectives:
1. Whether we should fix the changelog and code documentation, then send
another version.
2. If there are issues elsewhere, we need to port the patch into the Androi=
d
common kernel, which heavily uses dma-buf.

>
> >          */
> >         watermark =3D (order > PAGE_ALLOC_COSTLY_ORDER) ?
> >                                 low_wmark_pages(zone) : min_wmark_pages=
(zone);
> >         watermark +=3D compact_gap(order);
> >         return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
> > -                                  ALLOC_CMA, wmark_target);
> > +                                  alloc_flags & ALLOC_CMA, wmark_targe=
t);
> >  }
> >
> >  /*
> >   * compaction_suitable: Is this suitable to run compaction on this zon=
e now?
> >   */
> > -bool compaction_suitable(struct zone *zone, int order, int highest_zon=
eidx)
> > +bool compaction_suitable(struct zone *zone, int order, int highest_zon=
eidx,
> > +                                  unsigned int alloc_flags)
> >  {
> >         enum compact_result compact_result;
> >         bool suitable;
> >
> > -       suitable =3D __compaction_suitable(zone, order, highest_zoneidx=
,
> > +       suitable =3D __compaction_suitable(zone, order, highest_zoneidx=
, alloc_flags,
> >                                          zone_page_state(zone, NR_FREE_=
PAGES));
> >         /*
> >          * fragmentation index determines if allocation failures are du=
e to
> > @@ -2474,7 +2476,7 @@ bool compaction_zonelist_suitable(struct alloc_co=
ntext *ac, int order,
> >                 available =3D zone_reclaimable_pages(zone) / order;
> >                 available +=3D zone_page_state_snapshot(zone, NR_FREE_P=
AGES);
> >                 if (__compaction_suitable(zone, order, ac->highest_zone=
idx,
> > -                                         available))
> > +                                         alloc_flags, available))
> >                         return true;
> >         }
> >
> > @@ -2499,7 +2501,7 @@ compaction_suit_allocation_order(struct zone *zon=
e, unsigned int order,
> >                               alloc_flags))
> >                 return COMPACT_SUCCESS;
> >
> > -       if (!compaction_suitable(zone, order, highest_zoneidx))
> > +       if (!compaction_suitable(zone, order, highest_zoneidx, alloc_fl=
ags))
> >                 return COMPACT_SKIPPED;
> >
> >         return COMPACT_CONTINUE;
> > @@ -2893,6 +2895,7 @@ static int compact_node(pg_data_t *pgdat, bool pr=
oactive)
> >         struct compact_control cc =3D {
> >                 .order =3D -1,
> >                 .mode =3D proactive ? MIGRATE_SYNC_LIGHT : MIGRATE_SYNC=
,
> > +               .alloc_flags =3D ALLOC_CMA,
> >                 .ignore_skip_hint =3D true,
> >                 .whole_zone =3D true,
> >                 .gfp_mask =3D GFP_KERNEL,
> > @@ -3037,7 +3040,7 @@ static bool kcompactd_node_suitable(pg_data_t *pg=
dat)
> >
> >                 ret =3D compaction_suit_allocation_order(zone,
> >                                 pgdat->kcompactd_max_order,
> > -                               highest_zoneidx, ALLOC_WMARK_MIN);
> > +                               highest_zoneidx, ALLOC_CMA | ALLOC_WMAR=
K_MIN);
> >                 if (ret =3D=3D COMPACT_CONTINUE)
> >                         return true;
> >         }
> > @@ -3058,6 +3061,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
> >                 .search_order =3D pgdat->kcompactd_max_order,
> >                 .highest_zoneidx =3D pgdat->kcompactd_highest_zoneidx,
> >                 .mode =3D MIGRATE_SYNC_LIGHT,
> > +               .alloc_flags =3D ALLOC_CMA | ALLOC_WMARK_MIN,
> >                 .ignore_skip_hint =3D false,
> >                 .gfp_mask =3D GFP_KERNEL,
> >         };
> > @@ -3078,7 +3082,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
> >                         continue;
> >
> >                 ret =3D compaction_suit_allocation_order(zone,
> > -                               cc.order, zoneid, ALLOC_WMARK_MIN);
> > +                               cc.order, zoneid, cc.alloc_flags);
> >                 if (ret !=3D COMPACT_CONTINUE)
> >                         continue;
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 3922788..6d257c8 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -662,7 +662,8 @@ static inline void clear_zone_contiguous(struct zon=
e *zone)
> >         zone->contiguous =3D false;
> >  }
> >
> > -extern int __isolate_free_page(struct page *page, unsigned int order);
> > +extern int __isolate_free_page(struct page *page, unsigned int order,
> > +                                   unsigned int alloc_flags);
> >  extern void __putback_isolated_page(struct page *page, unsigned int or=
der,
> >                                     int mt);
> >  extern void memblock_free_pages(struct page *page, unsigned long pfn,
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index dde19db..1bfdca3 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2809,7 +2809,8 @@ void split_page(struct page *page, unsigned int o=
rder)
> >  }
> >  EXPORT_SYMBOL_GPL(split_page);
> >
> > -int __isolate_free_page(struct page *page, unsigned int order)
> > +int __isolate_free_page(struct page *page, unsigned int order,
> > +                                  unsigned int alloc_flags)
> >  {
> >         struct zone *zone =3D page_zone(page);
> >         int mt =3D get_pageblock_migratetype(page);
> > @@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsign=
ed int order)
> >                  * exists.
> >                  */
> >                 watermark =3D zone->_watermark[WMARK_MIN] + (1UL << ord=
er);
> > -               if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA=
))
> > +               if (!zone_watermark_ok(zone, 0, watermark, 0,
> > +                           alloc_flags & ALLOC_CMA))
> >                         return 0;
> >         }
> >
> > @@ -6454,6 +6456,7 @@ int alloc_contig_range_noprof(unsigned long start=
, unsigned long end,
> >                 .order =3D -1,
> >                 .zone =3D page_zone(pfn_to_page(start)),
> >                 .mode =3D MIGRATE_SYNC,
> > +               .alloc_flags =3D ALLOC_CMA,
> >                 .ignore_skip_hint =3D true,
> >                 .no_set_skip_hint =3D true,
> >                 .alloc_contig =3D true,
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index c608e9d..a1f2c79 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -229,7 +229,8 @@ static void unset_migratetype_isolate(struct page *=
page, int migratetype)
> >                         buddy =3D find_buddy_page_pfn(page, page_to_pfn=
(page),
> >                                                     order, NULL);
> >                         if (buddy && !is_migrate_isolate_page(buddy)) {
> > -                               isolated_page =3D !!__isolate_free_page=
(page, order);
> > +                               isolated_page =3D !!__isolate_free_page=
(page, order,
> > +                                                   ALLOC_CMA);
> >                                 /*
> >                                  * Isolating a free page in an isolated=
 pageblock
> >                                  * is expected to always work as waterm=
arks don't
> > diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> > index e4c428e..fd3813b 100644
> > --- a/mm/page_reporting.c
> > +++ b/mm/page_reporting.c
> > @@ -198,7 +198,7 @@ page_reporting_cycle(struct page_reporting_dev_info=
 *prdev, struct zone *zone,
> >
> >                 /* Attempt to pull page from list and place in scatterl=
ist */
> >                 if (*offset) {
> > -                       if (!__isolate_free_page(page, order)) {
> > +                       if (!__isolate_free_page(page, order, ALLOC_CMA=
)) {
> >                                 next =3D page;
> >                                 break;
> >                         }
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 5e03a61..33f5b46 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -5815,7 +5815,7 @@ static inline bool should_continue_reclaim(struct=
 pglist_data *pgdat,
> >                                       sc->reclaim_idx, 0))
> >                         return false;
> >
> > -               if (compaction_suitable(zone, sc->order, sc->reclaim_id=
x))
> > +               if (compaction_suitable(zone, sc->order, sc->reclaim_id=
x, ALLOC_CMA))
> >                         return false;
> >         }
> >
> > @@ -6043,7 +6043,7 @@ static inline bool compaction_ready(struct zone *=
zone, struct scan_control *sc)
> >                 return true;
> >
> >         /* Compaction cannot yet proceed. Do reclaim. */
> > -       if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
> > +       if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, ALLO=
C_CMA))
> >                 return false;
> >
> >         /*
> > --
> > 2.7.4
> >
> >
>
Thanks
Barry

