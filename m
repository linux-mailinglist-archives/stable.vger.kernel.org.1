Return-Path: <stable+bounces-104460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B250D9F467D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E91F188A486
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5991DDA16;
	Tue, 17 Dec 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdChN7OQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C61714BE;
	Tue, 17 Dec 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425395; cv=none; b=VO/5izCZS7C9kWsGUdxEzRFjBm2XN0jj5LALdgjrvj6UnrjjbwAeAamR6eQ8NmyMbHWv2lX4pSXwPt8z6rA6EHYR88B/+pVqs93PWF2o9WlBastJoyC1mt+51cWPU/ZzsE5w883n7JJ9P77wNtkqt2M1VaUfnFJ25wiJo+MYOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425395; c=relaxed/simple;
	bh=1AitqP+yMQ1JFL+JwoglKZp9fm6kfLmyYv0F0vhFRhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW/jOrwqy011F0zZfioIgn9jCfqyeAli41Xacb5I7t0CKhXG0SRSodvZZ+0XXdr8uCFRjf6bToWMBjY1PQFTDV1yYU74DtOSrLobzyVVNgfDdK3vp1kn8plmyKkyzjCTxv17CWlS3zqm5oFTpWRX9ZT9NlQ5RSjwogOGrURI+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdChN7OQ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-518ae5060d4so1411661e0c.0;
        Tue, 17 Dec 2024 00:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734425393; x=1735030193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDh+AuPWF1SU5dHFbExARYLYQDKduF5FdUoJg6qcAUg=;
        b=hdChN7OQmB2O/x9gipYTTTKl1weP9m/SJwfQQHp3fWUrle7kl1kdW6crjiZhkQNTgR
         lKBPUPgYnRaiWx1BIHwgivqidvXpoHW2eaRgbvCZsTM0wUp4qHjDB/40B7Ir+nDzD/kT
         UnK/xyopYf7QG/25aLMybRv2NN0ok51SoKpDm1pGLDYjh1DNsTqH5bu8pfQzTb29gswn
         E2JuIg2+rPnphXOMKQfw6oiQZh2L3OjOduf3U5UH9zIVMwaa3gF46lUNYZhBjaIbTwvu
         R12nyMj7KbQN7SuFhPoXYuOSilkqAmaqa6bdf3DzFFIQJm3PsvqmRQNwXSVCVSp1XxGG
         duJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425393; x=1735030193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDh+AuPWF1SU5dHFbExARYLYQDKduF5FdUoJg6qcAUg=;
        b=Wknvo2pyvZRzeQLpoojtiqUE6xajOPsDG+QaOQAkg3XSM9tqBQTgu8BY7p9Ck6n9ip
         gXlGYsRLnwgQWC1jFUjXNxUvTDdlbiAB+aNtG+WY8Mwh0WygZDwYPbCaQ17NnYTl6W+b
         G+DHkUo0Rp4AbcFhuIi7FyEoZzQ245+M3ANM8YyMJD64pnMRP8SdDXDPFjw9uoYUY2u0
         7Og0KVRftsGsCP+X7tk3z0MCdzI15FxjmPCwBSYMqLr0b6l+/gkM7Q0B/XS00oSk6JNZ
         MLqh6V0zRYA+C5utPmoTXP3PN2moJK0Wq3YkGDx7IHkwM322ZtOurpb1IOqK2AUCRfKK
         p8zw==
X-Forwarded-Encrypted: i=1; AJvYcCUCz+ygMZ0ilpwy30lXTeEADDv7lLNXiom2j5LBz4DOsiP8wN466SVFrH5gnf6TkAx1rqKZmHH+OFbjnVM=@vger.kernel.org, AJvYcCWpQIIEqwjecQeml7RpyeTGzlpn15Ht3sHxwhzIYfzBjA4x9ixL3+xeZ+Zz0UGDMSfw3WJovtKa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7C+l8Gp2xPo5pk5+Pql6pQ+0MdM9AE3BXg1Sb5Y7YSlwTfa7H
	KT5gTSWQhSNvz5EVoMwoTD6thpXhQsXxy2dFSF0g0d0spba5ffLCuv/kPaJiPwpm0YRywUIIbhl
	O+zpgCa1x4V0CpOXyiqpLXYo/NYM=
X-Gm-Gg: ASbGncuW2YOIEQIdoiCxtkupJdc2xsk8kM9o+CQlOlcxliEKjZlKBQHSlaY5CsGkXVr
	b2wQvSa0NMM/QfCWjbatZDH7SPahuj2fXsdKpqS3yRuVCtOm8aoOByqLaFeo3JwGyJYKCj+Uc
X-Google-Smtp-Source: AGHT+IHOXnihCapee+0OlQQt3O2x48A/4B8dvgMZGsYwAEBPAAqcc3Z5WuWDq9xQcD7jFMz8Q4rpjdqTywRBONAgAnc=
X-Received: by 2002:a05:6122:d05:b0:518:791a:3462 with SMTP id
 71dfb90a1353d-51a243614c6mr3411119e0c.9.1734425392654; Tue, 17 Dec 2024
 00:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1734406405-25847-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4xSbw7XDe1CWBAfYvMH35n0s1KaSze+wTUDOpwE-VrhfQ@mail.gmail.com> <e6d3ef92-762a-414b-89ce-6f53f01f8df3@126.com>
In-Reply-To: <e6d3ef92-762a-414b-89ce-6f53f01f8df3@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 17 Dec 2024 21:49:40 +1300
Message-ID: <CAGsJ_4ymXJOxTv8JKFVbzNMyfD52UdR6gwSWTdwUWV6ARGWfwQ@mail.gmail.com>
Subject: Re: [PATCH V6] mm, compaction: don't use ALLOC_CMA in long term GUP flow
To: Ge Yang <yangge1116@126.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, vbabka@suse.cz, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:12=E2=80=AFPM Ge Yang <yangge1116@126.com> wrote:
>
>
>
> =E5=9C=A8 2024/12/17 14:14, Barry Song =E5=86=99=E9=81=93:
> > On Tue, Dec 17, 2024 at 4:33=E2=80=AFPM <yangge1116@126.com> wrote:
> >>
> >> From: yangge <yangge1116@126.com>
> >>
> >> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
> >> in __compaction_suitable()") allow compaction to proceed when free
> >> pages required for compaction reside in the CMA pageblocks, it's
> >> possible that __compaction_suitable() always returns true, and in
> >> some cases, it's not acceptable.
> >>
> >> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
> >> of memory. I have configured 16GB of CMA memory on each NUMA node,
> >> and starting a 32GB virtual machine with device passthrough is
> >> extremely slow, taking almost an hour.
> >>
> >> During the start-up of the virtual machine, it will call
> >> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> >> Long term GUP cannot allocate memory from CMA area, so a maximum
> >> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> >> machine memory. Since there is 16G of free CMA memory on the NUMA
> >
> > Other unmovable allocations, like dma_buf, which can be large in a
> > Linux system, are
> > also unable to allocate memory from CMA. My question is whether the iss=
ue you
> > described applies to these allocations as well.
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) first attemps to allocate
> THP only on local node, and then fall back to remote NUMA nodes if the
> local allocation fail. For detail, see alloc_pages_mpol().
>
> static struct page *alloc_pages_mpol()
> {
>      page =3D __alloc_frozen_pages_noprof(__GFP_THISNODE,...); // 1, try
> to allocate THP only on local node
>
>      if (page || !(gpf & __GFP_DIRECT_RECLAIM))
>          return page;
>
>      page =3D __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);//2,
> fall back to remote NUMA nodes
> }
>
> If dma_buf also uses the same way to allocate memory=EF=BC=8Cdma_buf will=
 also
> have this problem.

Imagine we have only one NUMA node and no remote nodes to 'borrow'
memory from. What would happen as a result of this bug?

>
> >
> >> node, watermark for order-0 always be met for compaction, so
> >> __compaction_suitable() always returns true, even if the node is
> >> unable to allocate non-CMA memory for the virtual machine.
> >>
> >> For costly allocations, because __compaction_suitable() always
> >> returns true, __alloc_pages_slowpath() can't exit at the appropriate
> >> place, resulting in excessively long virtual machine startup times.
> >> Call trace:
> >> __alloc_pages_slowpath
> >>      if (compact_result =3D=3D COMPACT_SKIPPED ||
> >>          compact_result =3D=3D COMPACT_DEFERRED)
> >>          goto nopage; // should exit __alloc_pages_slowpath() from her=
e
> >>
> >
> > Do we face the same issue if we allocate dma-buf while CMA has plenty
> > of free memory, but non-CMA has none?
> >
> >> In order to quickly fall back to remote node, we should remove
> >> ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
> >> in long term GUP flow. After this fix, starting a 32GB virtual machine
> >> with device passthrough takes only a few seconds.
> >>
> >> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __comp=
action_suitable()")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: yangge <yangge1116@126.com>
> >> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>
> >> V6:
> >> -- update cc->alloc_flags to keep the original loginc
> >>
> >> V5:
> >> - add 'alloc_flags' parameter for __isolate_free_page()
> >> - remove 'usa_cma' variable
> >>
> >> V4:
> >> - rich the commit log description
> >>
> >> V3:
> >> - fix build errors
> >> - add ALLOC_CMA both in should_continue_reclaim() and compaction_ready=
()
> >>
> >> V2:
> >> - using the 'cc->alloc_flags' to determin if 'ALLOC_CMA' is needed
> >> - rich the commit log description
> >>
> >>   include/linux/compaction.h |  6 ++++--
> >>   mm/compaction.c            | 26 +++++++++++++++-----------
> >>   mm/internal.h              |  3 ++-
> >>   mm/page_alloc.c            |  7 +++++--
> >>   mm/page_isolation.c        |  3 ++-
> >>   mm/page_reporting.c        |  2 +-
> >>   mm/vmscan.c                |  4 ++--
> >>   7 files changed, 31 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> >> index e947764..b4c3ac3 100644
> >> --- a/include/linux/compaction.h
> >> +++ b/include/linux/compaction.h
> >> @@ -90,7 +90,8 @@ extern enum compact_result try_to_compact_pages(gfp_=
t gfp_mask,
> >>                  struct page **page);
> >>   extern void reset_isolation_suitable(pg_data_t *pgdat);
> >>   extern bool compaction_suitable(struct zone *zone, int order,
> >> -                                              int highest_zoneidx);
> >> +                                              int highest_zoneidx,
> >> +                                              unsigned int alloc_flag=
s);
> >>
> >>   extern void compaction_defer_reset(struct zone *zone, int order,
> >>                                  bool alloc_success);
> >> @@ -108,7 +109,8 @@ static inline void reset_isolation_suitable(pg_dat=
a_t *pgdat)
> >>   }
> >>
> >>   static inline bool compaction_suitable(struct zone *zone, int order,
> >> -                                                     int highest_zone=
idx)
> >> +                                                     int highest_zone=
idx,
> >> +                                                     unsigned int all=
oc_flags)
> >>   {
> >>          return false;
> >>   }
> >> diff --git a/mm/compaction.c b/mm/compaction.c
> >> index 07bd227..d92ba6c 100644
> >> --- a/mm/compaction.c
> >> +++ b/mm/compaction.c
> >> @@ -655,7 +655,7 @@ static unsigned long isolate_freepages_block(struc=
t compact_control *cc,
> >>
> >>                  /* Found a free page, will break it into order-0 page=
s */
> >>                  order =3D buddy_order(page);
> >> -               isolated =3D __isolate_free_page(page, order);
> >> +               isolated =3D __isolate_free_page(page, order, cc->allo=
c_flags);
> >>                  if (!isolated)
> >>                          break;
> >>                  set_page_private(page, order);
> >> @@ -1634,7 +1634,7 @@ static void fast_isolate_freepages(struct compac=
t_control *cc)
> >>
> >>                  /* Isolate the page if available */
> >>                  if (page) {
> >> -                       if (__isolate_free_page(page, order)) {
> >> +                       if (__isolate_free_page(page, order, cc->alloc=
_flags)) {
> >>                                  set_page_private(page, order);
> >>                                  nr_isolated =3D 1 << order;
> >>                                  nr_scanned +=3D nr_isolated - 1;
> >> @@ -2381,6 +2381,7 @@ static enum compact_result compact_finished(stru=
ct compact_control *cc)
> >>
> >>   static bool __compaction_suitable(struct zone *zone, int order,
> >>                                    int highest_zoneidx,
> >> +                                 unsigned int alloc_flags,
> >>                                    unsigned long wmark_target)
> >>   {
> >>          unsigned long watermark;
> >> @@ -2395,25 +2396,26 @@ static bool __compaction_suitable(struct zone =
*zone, int order,
> >>           * even if compaction succeeds.
> >>           * For costly orders, we require low watermark instead of min=
 for
> >>           * compaction to proceed to increase its chances.
> >> -        * ALLOC_CMA is used, as pages in CMA pageblocks are considere=
d
> >> -        * suitable migration targets
> >> +        * In addition to long term GUP flow, ALLOC_CMA is used, as pa=
ges in
> >> +        * CMA pageblocks are considered suitable migration targets
> >
> > I'm not sure if this document is correct for cases other than GUP.
> >
> >>           */
> >>          watermark =3D (order > PAGE_ALLOC_COSTLY_ORDER) ?
> >>                                  low_wmark_pages(zone) : min_wmark_pag=
es(zone);
> >>          watermark +=3D compact_gap(order);
> >>          return __zone_watermark_ok(zone, 0, watermark, highest_zoneid=
x,
> >> -                                  ALLOC_CMA, wmark_target);
> >> +                                  alloc_flags & ALLOC_CMA, wmark_targ=
et);
> >>   }
> >>
> >>   /*
> >>    * compaction_suitable: Is this suitable to run compaction on this z=
one now?
> >>    */
> >> -bool compaction_suitable(struct zone *zone, int order, int highest_zo=
neidx)
> >> +bool compaction_suitable(struct zone *zone, int order, int highest_zo=
neidx,
> >> +                                  unsigned int alloc_flags)
> >>   {
> >>          enum compact_result compact_result;
> >>          bool suitable;
> >>
> >> -       suitable =3D __compaction_suitable(zone, order, highest_zoneid=
x,
> >> +       suitable =3D __compaction_suitable(zone, order, highest_zoneid=
x, alloc_flags,
> >>                                           zone_page_state(zone, NR_FRE=
E_PAGES));
> >>          /*
> >>           * fragmentation index determines if allocation failures are =
due to
> >> @@ -2474,7 +2476,7 @@ bool compaction_zonelist_suitable(struct alloc_c=
ontext *ac, int order,
> >>                  available =3D zone_reclaimable_pages(zone) / order;
> >>                  available +=3D zone_page_state_snapshot(zone, NR_FREE=
_PAGES);
> >>                  if (__compaction_suitable(zone, order, ac->highest_zo=
neidx,
> >> -                                         available))
> >> +                                         alloc_flags, available))
> >>                          return true;
> >>          }
> >>
> >> @@ -2499,7 +2501,7 @@ compaction_suit_allocation_order(struct zone *zo=
ne, unsigned int order,
> >>                                alloc_flags))
> >>                  return COMPACT_SUCCESS;
> >>
> >> -       if (!compaction_suitable(zone, order, highest_zoneidx))
> >> +       if (!compaction_suitable(zone, order, highest_zoneidx, alloc_f=
lags))
> >>                  return COMPACT_SKIPPED;
> >>
> >>          return COMPACT_CONTINUE;
> >> @@ -2893,6 +2895,7 @@ static int compact_node(pg_data_t *pgdat, bool p=
roactive)
> >>          struct compact_control cc =3D {
> >>                  .order =3D -1,
> >>                  .mode =3D proactive ? MIGRATE_SYNC_LIGHT : MIGRATE_SY=
NC,
> >> +               .alloc_flags =3D ALLOC_CMA,
> >>                  .ignore_skip_hint =3D true,
> >>                  .whole_zone =3D true,
> >>                  .gfp_mask =3D GFP_KERNEL,
> >> @@ -3037,7 +3040,7 @@ static bool kcompactd_node_suitable(pg_data_t *p=
gdat)
> >>
> >>                  ret =3D compaction_suit_allocation_order(zone,
> >>                                  pgdat->kcompactd_max_order,
> >> -                               highest_zoneidx, ALLOC_WMARK_MIN);
> >> +                               highest_zoneidx, ALLOC_CMA | ALLOC_WMA=
RK_MIN);
> >>                  if (ret =3D=3D COMPACT_CONTINUE)
> >>                          return true;
> >>          }
> >> @@ -3058,6 +3061,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
> >>                  .search_order =3D pgdat->kcompactd_max_order,
> >>                  .highest_zoneidx =3D pgdat->kcompactd_highest_zoneidx=
,
> >>                  .mode =3D MIGRATE_SYNC_LIGHT,
> >> +               .alloc_flags =3D ALLOC_CMA | ALLOC_WMARK_MIN,
> >>                  .ignore_skip_hint =3D false,
> >>                  .gfp_mask =3D GFP_KERNEL,
> >>          };
> >> @@ -3078,7 +3082,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
> >>                          continue;
> >>
> >>                  ret =3D compaction_suit_allocation_order(zone,
> >> -                               cc.order, zoneid, ALLOC_WMARK_MIN);
> >> +                               cc.order, zoneid, cc.alloc_flags);
> >>                  if (ret !=3D COMPACT_CONTINUE)
> >>                          continue;
> >>
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index 3922788..6d257c8 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -662,7 +662,8 @@ static inline void clear_zone_contiguous(struct zo=
ne *zone)
> >>          zone->contiguous =3D false;
> >>   }
> >>
> >> -extern int __isolate_free_page(struct page *page, unsigned int order)=
;
> >> +extern int __isolate_free_page(struct page *page, unsigned int order,
> >> +                                   unsigned int alloc_flags);
> >>   extern void __putback_isolated_page(struct page *page, unsigned int =
order,
> >>                                      int mt);
> >>   extern void memblock_free_pages(struct page *page, unsigned long pfn=
,
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index dde19db..1bfdca3 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -2809,7 +2809,8 @@ void split_page(struct page *page, unsigned int =
order)
> >>   }
> >>   EXPORT_SYMBOL_GPL(split_page);
> >>
> >> -int __isolate_free_page(struct page *page, unsigned int order)
> >> +int __isolate_free_page(struct page *page, unsigned int order,
> >> +                                  unsigned int alloc_flags)
> >>   {
> >>          struct zone *zone =3D page_zone(page);
> >>          int mt =3D get_pageblock_migratetype(page);
> >> @@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsig=
ned int order)
> >>                   * exists.
> >>                   */
> >>                  watermark =3D zone->_watermark[WMARK_MIN] + (1UL << o=
rder);
> >> -               if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CM=
A))
> >> +               if (!zone_watermark_ok(zone, 0, watermark, 0,
> >> +                           alloc_flags & ALLOC_CMA))
> >>                          return 0;
> >>          }
> >>
> >> @@ -6454,6 +6456,7 @@ int alloc_contig_range_noprof(unsigned long star=
t, unsigned long end,
> >>                  .order =3D -1,
> >>                  .zone =3D page_zone(pfn_to_page(start)),
> >>                  .mode =3D MIGRATE_SYNC,
> >> +               .alloc_flags =3D ALLOC_CMA,
> >>                  .ignore_skip_hint =3D true,
> >>                  .no_set_skip_hint =3D true,
> >>                  .alloc_contig =3D true,
> >> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> >> index c608e9d..a1f2c79 100644
> >> --- a/mm/page_isolation.c
> >> +++ b/mm/page_isolation.c
> >> @@ -229,7 +229,8 @@ static void unset_migratetype_isolate(struct page =
*page, int migratetype)
> >>                          buddy =3D find_buddy_page_pfn(page, page_to_p=
fn(page),
> >>                                                      order, NULL);
> >>                          if (buddy && !is_migrate_isolate_page(buddy))=
 {
> >> -                               isolated_page =3D !!__isolate_free_pag=
e(page, order);
> >> +                               isolated_page =3D !!__isolate_free_pag=
e(page, order,
> >> +                                                   ALLOC_CMA);
> >>                                  /*
> >>                                   * Isolating a free page in an isolat=
ed pageblock
> >>                                   * is expected to always work as wate=
rmarks don't
> >> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> >> index e4c428e..fd3813b 100644
> >> --- a/mm/page_reporting.c
> >> +++ b/mm/page_reporting.c
> >> @@ -198,7 +198,7 @@ page_reporting_cycle(struct page_reporting_dev_inf=
o *prdev, struct zone *zone,
> >>
> >>                  /* Attempt to pull page from list and place in scatte=
rlist */
> >>                  if (*offset) {
> >> -                       if (!__isolate_free_page(page, order)) {
> >> +                       if (!__isolate_free_page(page, order, ALLOC_CM=
A)) {
> >>                                  next =3D page;
> >>                                  break;
> >>                          }
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 5e03a61..33f5b46 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -5815,7 +5815,7 @@ static inline bool should_continue_reclaim(struc=
t pglist_data *pgdat,
> >>                                        sc->reclaim_idx, 0))
> >>                          return false;
> >>
> >> -               if (compaction_suitable(zone, sc->order, sc->reclaim_i=
dx))
> >> +               if (compaction_suitable(zone, sc->order, sc->reclaim_i=
dx, ALLOC_CMA))
> >>                          return false;
> >>          }
> >>
> >> @@ -6043,7 +6043,7 @@ static inline bool compaction_ready(struct zone =
*zone, struct scan_control *sc)
> >>                  return true;
> >>
> >>          /* Compaction cannot yet proceed. Do reclaim. */
> >> -       if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
> >> +       if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, ALL=
OC_CMA))
> >>                  return false;
> >>
> >>          /*
> >> --
> >> 2.7.4
> >>
> >>
> >
> > Thanks
> > Barry
>
>

