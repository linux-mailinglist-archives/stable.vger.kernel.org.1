Return-Path: <stable+bounces-89142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A69B3F04
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 01:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5564B21FCD
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 00:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29FCC8C7;
	Tue, 29 Oct 2024 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGF/pSt5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE82567D;
	Tue, 29 Oct 2024 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161247; cv=none; b=MqWfvmlF8CXS1fYtMLMm0xYpf7uYYNOzMKhi/O48IdPESiiU+qeBbTx4KqcCGp/RSfGQi3BeVcZp0a3hxzUSatrL9f0DBmUKRs22QmGmyW80poGXckJr7l4Rj7xa1j03IrpVAcWSgvSXyGpuRCrETDp7D+Qay6VCUwXY9JI8eDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161247; c=relaxed/simple;
	bh=eDYQTz0cUxiILv3RQ0GED/Yvh8CRPXEqZcmH1uCJ/p0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gdCkjqkcr5fPIlmHzqB9RGd/5bPHw/uFaRYVTCdYJmpWJ2gFStCeuCjTDtAZj9uGh3DvyLYjCIxp2Uw9Cy17f1WzlP0pVr5mZiD42Mr9kUYWGnOANCSAEO1F8piTnyZM9BrNEQrscC7vxeVDvzv8KOA1A285vwEwk+NCAn3gaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGF/pSt5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730161246; x=1761697246;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eDYQTz0cUxiILv3RQ0GED/Yvh8CRPXEqZcmH1uCJ/p0=;
  b=JGF/pSt5F+ukAtiWxfz9Z93D7EzHvm6jLrPcG1k6N2cI93btjXcLAM6T
   MfSkhSaRCAQtAKQFQQ/bb5Ri9Lt4GM43H9o+6FABOTonmcXmIpxKbug7X
   0tIugiVRiwKwfWLS1+aZG+cDDR5CkG1/a+PK1CB+CqWfBGDDSpU63gDra
   eFJaTvpiPXBM23vpOX2w5cFaimoCiUL/29V/wmE+U8KRgenTHk9w/Zleq
   BGaOnpd64VduAHKyEksb2d/EBwSM8w7KVauoZ8v2nnL5kljtWwNv/Nif/
   zq3LszJ9crROhvbzSr31F/zWpQrPULhKn7bf7RGi2cW+x3Kepu81i4mnD
   g==;
X-CSE-ConnectionGUID: 9B2Pgf0bS7yoYjZ+cD7cow==
X-CSE-MsgGUID: MzD2H2SzSf6NcVoMoPPSMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52336903"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52336903"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 17:20:18 -0700
X-CSE-ConnectionGUID: FJcDQSIrTDCWYFnwoHfEow==
X-CSE-MsgGUID: pbsMikqGQr6/BMZFA+A5Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="81932934"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 17:20:15 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  kernel-team@meta.com,  akpm@linux-foundation.org,
  weixugc@google.com,  dave.hansen@linux.intel.com,  osalvador@suse.de,
  shy828301@gmail.com,  stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
In-Reply-To: <Zx-iI33-I4YYOEbB@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Mon, 28 Oct 2024 10:39:31 -0400")
References: <20241025141724.17927-1-gourry@gourry.net>
	<mjfsmy5naqj2oimgelvual6zpfinbugmbqy7kmbs2c2f7ll5jr@z4rl5zzdvrat>
	<Zx-iI33-I4YYOEbB@PC2K9PVX.TheFacebook.com>
Date: Tue, 29 Oct 2024 08:16:41 +0800
Message-ID: <87r07zwyom.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Sun, Oct 27, 2024 at 10:24:10PM -0700, Shakeel Butt wrote:
>> On Fri, Oct 25, 2024 at 10:17:24AM GMT, Gregory Price wrote:
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
>> > 
>> > When accounting for migrations, instead do not decrement the count
>> > when the migration reason is MR_DEMOTION. As of v6.11, this demotion
>> > logic is the only source of MR_DEMOTION.
>> > 
>> > Signed-off-by: Gregory Price <gourry@gourry.net>
>> > Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
>> > Cc: stable@vger.kernel.org
>> 
>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>> 
>> This patch looks good for stable backports. For future I wonder if
>> instead of migrate_pages(), the caller providing the isolated folios,
>> manages the isolated stats (increments and decrements) similar to how
>> reclaim does it.
>>
>
> Note that even if you provided the folios, you'd likely still end up in
> migrate_pages_batch/migrate_folio_move and subsequently the same accounting
> path.  Probably there's some refactoring we can do to make the accounting
> more obvious - it is very subtle here.

I agree with Shakeel here.  It's better for the caller who isolates the
folios to increase and decrease the isolation counter.  And yes, some
refactoring is required.

--
Best Regards,
Huang, Ying

>> > ---
>> >  mm/migrate.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/mm/migrate.c b/mm/migrate.c
>> > index 923ea80ba744..e3aac274cf16 100644
>> > --- a/mm/migrate.c
>> > +++ b/mm/migrate.c
>> > @@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
>> >  	 * not accounted to NR_ISOLATED_*. They can be recognized
>> >  	 * as __folio_test_movable
>> >  	 */
>> > -	if (likely(!__folio_test_movable(src)))
>> > +	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
>> >  		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
>> >  				    folio_is_file_lru(src), -folio_nr_pages(src));
>> >  
>> > -- 
>> > 2.43.0
>> > 

