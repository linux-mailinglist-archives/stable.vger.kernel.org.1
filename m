Return-Path: <stable+bounces-89143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D289A9B3F40
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 01:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DA31F2322F
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B611712;
	Tue, 29 Oct 2024 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtMRgpFW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28261FC0A;
	Tue, 29 Oct 2024 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730162292; cv=none; b=rz6++b65ruRrEWE2VF3u5sYP5GLhuAks2QxT/YcbqrtBF6FyPvcxDTeUjiFG93FlvPSp+q0kxaCmTmh8h542u0Js/DeZ4meF+s2oCK4hNvtwrEPDG5KqnCf45gK2m734mVxT0dH+LD0DKj2Qtilkz92Ys200vOp8l7GSjNjj9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730162292; c=relaxed/simple;
	bh=3K2dglKZn7wUtYTDSsva58MuIimxAP4MGOPDH/JDycU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qgd1wfvKzLd0EMO/G6mAfQ6evE2dQ2l3BhUujG76/Idt1yTngOLv28hr99NPxVH20My3qNJQOWPVRAI06Q0/Ene1oml1+b6dv5p5B7TCoTvRiy0IjPCbrp4fc9UNM/4RiquLMnMh6D6RuHVNTu0vBSmTsDSEGgc+doeOwDDLTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtMRgpFW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730162290; x=1761698290;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=3K2dglKZn7wUtYTDSsva58MuIimxAP4MGOPDH/JDycU=;
  b=DtMRgpFWYP3yNxEnCfkIJzEGEYAvYhbgv9bMsCT8wgbUj1oJVesTuCGa
   GPw+vYGQfHuiC7qP+Fn+kmzX/9DKvVA0ctGMik1ZEt42hwErH59uciPEi
   J1cC8Odc4ru8VjXE0lnhu8l/yjFEi0+6sYdINuitovzVyy8smU0yW5TpV
   jMbXJj6xqAFBbrhEW4I0GJ8C/3z1zWojVVZIb031UhEZ1fG5kJOMr6SUh
   cjDTy+LeC5rLSO2wlUN9w7h+Ma6Ocw4yf8bZdm+Nmts4r9ya4F3HEZOs6
   WZPEHf2tiXSeAZT1T5n2U/ObZIOy6KlM40WxFOWhIW3osOP9nuhVhg+Hl
   A==;
X-CSE-ConnectionGUID: j/jWGMgxQ0mWTE5oZiurcw==
X-CSE-MsgGUID: 8kbRqs6yRqyPI19KDcRQ1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33574624"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="33574624"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 17:38:10 -0700
X-CSE-ConnectionGUID: k0aWpVU7SbWu9VZPyjYQEw==
X-CSE-MsgGUID: ZKMTSNDQRAmSlMypoWqD1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="82602018"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 17:38:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Yang Shi <shy828301@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  kernel-team@meta.com,  akpm@linux-foundation.org,
  weixugc@google.com,  dave.hansen@linux.intel.com,  osalvador@suse.de,
  stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
In-Reply-To: <ZyABO4wOoXs9vC3F@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Mon, 28 Oct 2024 17:25:15 -0400")
References: <20241025141724.17927-1-gourry@gourry.net>
	<CAHbLzkqYoHTQz6ifZHuVkWL449EVt9H1v2ukXhS+ExDC2JZMHA@mail.gmail.com>
	<ZyABO4wOoXs9vC3F@PC2K9PVX.TheFacebook.com>
Date: Tue, 29 Oct 2024 08:34:34 +0800
Message-ID: <87msinwxut.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gregory Price <gourry@gourry.net> writes:

> On Mon, Oct 28, 2024 at 01:45:48PM -0700, Yang Shi wrote:
>> On Fri, Oct 25, 2024 at 7:17=E2=80=AFAM Gregory Price <gourry@gourry.net=
> wrote:
>> >
>> > When numa balancing is enabled with demotion, vmscan will call
>> > migrate_pages when shrinking LRUs.  Successful demotions will
>> > cause node vmstat numbers to double-decrement, leading to an
>> > imbalanced page count.  The result is dmesg output like such:
>> >
>> > $ cat /proc/sys/vm/stat_refresh
>> >
>> > [77383.088417] vmstat_refresh: nr_isolated_anon -103212
>> > [77383.088417] vmstat_refresh: nr_isolated_file -899642
>> >
>> > This negative value may impact compaction and reclaim throttling.
>> >
>> > The double-decrement occurs in the migrate_pages path:
>> >
>> > caller to shrink_folio_list decrements the count
>> >   shrink_folio_list
>> >     demote_folio_list
>> >       migrate_pages
>> >         migrate_pages_batch
>> >           migrate_folio_move
>> >             migrate_folio_done
>> >               mod_node_page_state(-ve) <- second decrement
>> >
>> > This path happens for SUCCESSFUL migrations, not failures. Typically
>> > callers to migrate_pages are required to handle putback/accounting for
>> > failures, but this is already handled in the shrink code.
>>=20
>> AFAIK, MGLRU doesn't dec/inc this counter, so it is not
>> double-decrement for MGLRU. Maybe "imbalance update" is better?
>> Anyway, it is just a nit. I'd suggest capturing the MGLRU case in the
>> commit log too.
>>
>
> Gotcha, so yeah saying it's an imbalance fix is more accurate.
>
> So more accurate changelog is:
>
>
> [PATCH] vmscan,migrate: fix page count imbalance on node stats when demot=
ing pages
>
> When numa balancing is enabled with demotion, vmscan will call
> migrate_pages when shrinking LRUs.  migrate_pages will decrement the
> the node's isolated page count, leading to an imbalanced count when
> invoked from (MG)LRU code.
>
> The result is dmesg output like such:
>
> $ cat /proc/sys/vm/stat_refresh
>
> [77383.088417] vmstat_refresh: nr_isolated_anon -103212
> [77383.088417] vmstat_refresh: nr_isolated_file -899642

> This negative value may impact compaction and reclaim throttling.
>
> The following path produces the decrement:
>
> shrink_folio_list
>   demote_folio_list
>     migrate_pages
>       migrate_pages_batch
>         migrate_folio_move
>           migrate_folio_done
>             mod_node_page_state(-ve) <- decrement

I think that it may be better to mention the different behavior of LRU
and MGLRU.  But that's not a big deal, change it again only if you think
it's necessary.

--
Best Regards,
Huang, Ying

> This path happens for SUCCESSFUL migrations, not failures. Typically
> callers to migrate_pages are required to handle putback/accounting for
> failures, but this is already handled in the shrink code.
>
> When accounting for migrations, instead do not decrement the count
> when the migration reason is MR_DEMOTION. As of v6.11, this demotion
> logic is the only source of MR_DEMOTION.
>
>
>> >
>> > Signed-off-by: Gregory Price <gourry@gourry.net>
>> > Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
>> > Cc: stable@vger.kernel.org
>>=20
>> Thanks for catching this. Reviewed-by: Yang Shi <shy828301@gmail.com>
>>=20
>> > ---
>> >  mm/migrate.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/mm/migrate.c b/mm/migrate.c
>> > index 923ea80ba744..e3aac274cf16 100644
>> > --- a/mm/migrate.c
>> > +++ b/mm/migrate.c
>> > @@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
>> >          * not accounted to NR_ISOLATED_*. They can be recognized
>> >          * as __folio_test_movable
>> >          */
>> > -       if (likely(!__folio_test_movable(src)))
>> > +       if (likely(!__folio_test_movable(src)) && reason !=3D MR_DEMOT=
ION)
>> >                 mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON=
 +
>> >                                     folio_is_file_lru(src), -folio_nr_=
pages(src));
>> >
>> > --
>> > 2.43.0
>> >

