Return-Path: <stable+bounces-88264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8A9B23EA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 05:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4522820A0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 04:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1DE189BAA;
	Mon, 28 Oct 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbY4JJPf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E5188012;
	Mon, 28 Oct 2024 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730090563; cv=none; b=cEld6hSl0PmCFcRcdVEvlFLiwkURiTfMfRVwBHwAdpCRsUslqNN5oy/xjvl1CMtdGIg7cd3LG9GwEZyu4q2ZtV11d5wR6iHA9aJL5y8xYuz+fCQFHIAd+rU6jp+looA/vw4Bxh7WzNme+0NxgldwYIF4N5qbD+gJESGAaqaQIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730090563; c=relaxed/simple;
	bh=pAbyscq/8o1RULEwswI7SeZXYGter4pYg9fdxDjM0I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bq4fSTCK7rxCffCF6FqYwXwoOG6NGptzQO6s4S/B3lbLCTcVF3/sfZ9/XmhdmrGqKYh+6TSGD9sB2eBvo9li3w8IJWuDzR6EPsden1j2HbIsZmN6+FmL/6ki8jYJiAgeSX6tJeUWWPeLJC05A7Yx50vsK8+QzTsFeea6M/Vn0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbY4JJPf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730090561; x=1761626561;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pAbyscq/8o1RULEwswI7SeZXYGter4pYg9fdxDjM0I4=;
  b=EbY4JJPf+dWs31IcpQpunuGgwoofAYPOjzgcopDT7QMsiVGMnX6Nv4Fb
   73vvrQsVMmxeQ9kyPiP+cT89GFVvwOzbu+cbgPlzOh6mdqhAGTjnezQk6
   veTa6QZAp5C+RwREm83wZc/URJsNJQPr4Ap9PRKxuNhEviZbo9pqyj36A
   2w1BFOBsHcpEJO3xNn2xjH6799C8NiCiwcJ1SKDkglLv+q0/jRyyJTVC4
   XHJiLtopJOOVh/D2KraR2b8/KfFM7QLwJcDfAJSQp5FS5G9dY3ZkjUYUl
   BDjDUfwM6p99NRafJYj8txos/hdAn32XP3T1KXgPv8Ky6e7fgKcbjnI/V
   w==;
X-CSE-ConnectionGUID: 6mc6sIWOT7+1reefvKb8nQ==
X-CSE-MsgGUID: IEYifgGTQR2wil7VUp/8rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="33583992"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="33583992"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 21:42:41 -0700
X-CSE-ConnectionGUID: 5L2RfXbES6WMB5cZrm5fzQ==
X-CSE-MsgGUID: U0FUjabDR+mSHTYumqPmSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81547893"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 21:42:38 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kernel-team@meta.com,  akpm@linux-foundation.org,  weixugc@google.com,
  dave.hansen@linux.intel.com,  osalvador@suse.de,  shy828301@gmail.com,
  stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
In-Reply-To: <20241025141724.17927-1-gourry@gourry.net> (Gregory Price's
	message of "Fri, 25 Oct 2024 10:17:24 -0400")
References: <20241025141724.17927-1-gourry@gourry.net>
Date: Mon, 28 Oct 2024 12:39:05 +0800
Message-ID: <878qu8yh7a.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> When numa balancing is enabled with demotion, vmscan will call
> migrate_pages when shrinking LRUs.  Successful demotions will
> cause node vmstat numbers to double-decrement, leading to an
> imbalanced page count.  The result is dmesg output like such:
>
> $ cat /proc/sys/vm/stat_refresh
>
> [77383.088417] vmstat_refresh: nr_isolated_anon -103212
> [77383.088417] vmstat_refresh: nr_isolated_file -899642
>
> This negative value may impact compaction and reclaim throttling.
>
> The double-decrement occurs in the migrate_pages path:
>
> caller to shrink_folio_list decrements the count
>   shrink_folio_list
>     demote_folio_list
>       migrate_pages
>         migrate_pages_batch
>           migrate_folio_move
>             migrate_folio_done
>               mod_node_page_state(-ve) <- second decrement
>
> This path happens for SUCCESSFUL migrations, not failures. Typically
> callers to migrate_pages are required to handle putback/accounting for
> failures, but this is already handled in the shrink code.
>
> When accounting for migrations, instead do not decrement the count
> when the migration reason is MR_DEMOTION. As of v6.11, this demotion
> logic is the only source of MR_DEMOTION.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
> Cc: stable@vger.kernel.org
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 923ea80ba744..e3aac274cf16 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
>  	 * not accounted to NR_ISOLATED_*. They can be recognized
>  	 * as __folio_test_movable
>  	 */
> -	if (likely(!__folio_test_movable(src)))
> +	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
>  		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
>  				    folio_is_file_lru(src), -folio_nr_pages(src));

Good catch!  Thanks for doing this!  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

