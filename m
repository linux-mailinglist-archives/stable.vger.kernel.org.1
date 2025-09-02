Return-Path: <stable+bounces-176972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE53B3FC4B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CA43B0547
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75302F39DA;
	Tue,  2 Sep 2025 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0CqW24/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17528136E;
	Tue,  2 Sep 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808610; cv=none; b=QjbuYCF5gLmkVV68bx1e2AiH+yvBbTm1w9JjDyiElyfN1A7FcbCt1MnHZdBS8vR75+XOSb9RkUhOT6l5PNct8nNo8boqTvHMdgsJDi7r9iRtrf470DdCUbuq8r12MoauxmQIOzKTqXlJstPVPhjCNVMqqn+l5rPCaGSK9pOJSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808610; c=relaxed/simple;
	bh=rR6Wp8GZtCXlW02r8wzOYU1nLDI4RbUlUd1eOGVJRvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLvULJPXrirreid+mhk+EZrSOtmzguOghQZLsDfvRbNYvs3Y5jydvnUi90LfNb99H5X5LgQaUlF8Vsfx9lzvLEKRApKL58LnFtt5rxuvW/prkwh4uV7GHkPK8Bv0c+iHQQpNpABoPDIUQ/gteDGaN636jRxl1GINVETbv9/wY+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0CqW24/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756808608; x=1788344608;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rR6Wp8GZtCXlW02r8wzOYU1nLDI4RbUlUd1eOGVJRvk=;
  b=e0CqW24/ZWISVoCm0ZbFSbfSN4Fk9UPZBONH4LTwOqqMGKJSJIkbWkfp
   Z+WNNRwNP6FU93RTuDv/VjpVUB1lQAJyg7OuZx9ntF1c2bjdmXgMXZaXz
   aA7ZHnkV9YfZwLpzaJMzSUq6sV6UbitgTud4WsIXNQlo+zWs8ZMsONOmS
   saoDjdW/wHa433Mi8+/zARrNxuduaereHasZmV9v+WQEmIV3bQryH6pgk
   UkzqQHuX+DxvuHWcdXUhIGo+RQ1EjsWpxxc0jpl9kZZH70xBHRW19hH1e
   DtvSKUAMn6ce8DYCcKmURvUFJWZJpBkKQ5cJGMLLZ9xU5c1QasyEH3bHf
   A==;
X-CSE-ConnectionGUID: CNbySz9MS4+anwDVtZ4Afg==
X-CSE-MsgGUID: 5R0x73TLSk63Ug8/gVaELA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58990909"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58990909"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:23:27 -0700
X-CSE-ConnectionGUID: wYlb5+c0QZOMWQXpcfYFtg==
X-CSE-MsgGUID: 0zTKK58kQziK686jbzw0vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176516743"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.193])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:23:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, matthew.auld@intel.com, peterz@infradead.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: alexander.deucher@amd.com, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: Re: [PATCH v5 1/2] drm/buddy: Optimize free block management with
 RB tree
In-Reply-To: <20250901185604.2222-1-Arunpravin.PaneerSelvam@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250901185604.2222-1-Arunpravin.PaneerSelvam@amd.com>
Date: Tue, 02 Sep 2025 13:23:20 +0300
Message-ID: <23142157adbc54a6e2f03a2ebaf209c9bd89439e@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 02 Sep 2025, Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com> wrote:
> Replace the freelist (O(n)) used for free block management with a
> red-black tree, providing more efficient O(log n) search, insert,
> and delete operations. This improves scalability and performance
> when managing large numbers of free blocks per order (e.g., hundreds
> or thousands).
>
> In the VK-CTS memory stress subtest, the buddy manager merges
> fragmented memory and inserts freed blocks into the freelist. Since
> freelist insertion is O(n), this becomes a bottleneck as fragmentation
> increases. Benchmarking shows list_insert_sorted() consumes ~52.69% CPU
> with the freelist, compared to just 0.03% with the RB tree
> (rbtree_insert.isra.0), despite performing the same sorted insert.
>
> This also improves performance in heavily fragmented workloads,
> such as games or graphics tests that stress memory.
>
> v3(Matthew):
>   - Remove RB_EMPTY_NODE check in force_merge function.
>   - Rename rb for loop macros to have less generic names and move to
>     .c file.
>   - Make the rb node rb and link field as union.
>
> v4(Jani Nikula):
>   - The kernel-doc comment should be "/**"
>   - Move all the rbtree macros to rbtree.h and add parens to ensure
>     correct precedence.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>  drivers/gpu/drm/drm_buddy.c | 142 ++++++++++++++++++++++--------------
>  include/drm/drm_buddy.h     |   9 ++-
>  include/linux/rbtree.h      |  56 ++++++++++++++
>  3 files changed, 152 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index a94061f373de..978cabfbcf0f 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c

...

> +static inline struct drm_buddy_block *
> +rbtree_last_entry(struct drm_buddy *mm, unsigned int order)

Drive-by reminder that "inline" in a .c file is, in absense of evidence
to the contrary, superfluous. Please just let the compiler do its job.

BR,
Jani.


-- 
Jani Nikula, Intel

