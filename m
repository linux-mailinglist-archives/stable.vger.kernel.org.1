Return-Path: <stable+bounces-148084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF5AAC7BF5
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079F53AE036
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E89278744;
	Thu, 29 May 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lt6SHHEx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB0215F7D;
	Thu, 29 May 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515637; cv=none; b=ebgFpIBmyxz+V/PpZlxD206GPFwXaJKSv6dzPlQTyRQ4r96NRVEBLIrFVaL3onCk5ZJxXL9yYTDbFanm4RCP/5wku2DjrdcAH+6M11wt2q1PSgWCxJSmrMY9Z9YyB+UaNelKq/OmgyK1zG4RwJiRqf2KK0fVH5iMX3ZRLyP8yLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515637; c=relaxed/simple;
	bh=LVRwWoUatGOrd2tJr+IxXkFBmJAhyBpbsVHwVJNjD+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swmwoHuFJ4qFlNyS3D4B1L+G1WAvlAuzrIqWX4gliiuRKFv6d8sxtSS98URwXLfmiGtwQU5K6UehbK1q56ESO3iSwC5Ap6yx8DGHB9oLVxK6w+WNUGiU/n5ZToOMh6QRLtCkgHl/jUbzJQT+NdB3faPb9NBV1uLFNpGKFukiKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lt6SHHEx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748515636; x=1780051636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVRwWoUatGOrd2tJr+IxXkFBmJAhyBpbsVHwVJNjD+g=;
  b=Lt6SHHEx0D6cx49lGkrDSs4f47pduOO+1OJ4rBkA6taCR4WJ/N53QbrE
   DAnWv8F49kOIcAlscSqOM++W5ajRowJDGYgqf7xCWB1IMMS9+RAnqwW8m
   Uwi+K2+s7H3onT13G64Z6tDpiWsMxQw7uxONLVj8wVnLVn7/Q6iVz6Gpb
   POeY6zjskm2Nj7TZHCw1UscXU9XagqreDMT+vRZ4Mf6ZDd/vUD/RLGLqH
   h3ETrgrtVj4Dlt2xiQM4Izwj5RgLuP4Ky/jmYfiqJKkaH7JGs9XOchMK4
   JLTyIz46U6UtReeTuMX1s4bfu/9fb1XJqqwzU3rDqPXMhTpylTe7Cutxu
   A==;
X-CSE-ConnectionGUID: ZokMSbumRdKNk/f8jCNWUg==
X-CSE-MsgGUID: e0H/dMPMTDWzDvTGrAGrHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="53196010"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="53196010"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 03:47:14 -0700
X-CSE-ConnectionGUID: s4B4ZiAUSp6DyUTnffUjdQ==
X-CSE-MsgGUID: ESX2CJwEQYWD/+AmcTx2Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="174400473"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 29 May 2025 03:47:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F004114B; Thu, 29 May 2025 13:47:09 +0300 (EEST)
Date: Thu, 29 May 2025 13:47:09 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>, 
	stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
Message-ID: <ow3adiccumedegsm4agxlvaiaq3ypeto42hxr4ln6v3zzluhyu@2cdoez7of6ic>
References: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
 <7ae9e9f9-80e7-4285-83f0-a0946d238243@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae9e9f9-80e7-4285-83f0-a0946d238243@suse.cz>

On Thu, May 29, 2025 at 12:40:21PM +0200, Vlastimil Babka wrote:
> On 5/29/25 12:38, Kirill A. Shutemov wrote:
> > Hongyu noticed that the nr_unaccepted counter kept growing even in the
> > absence of unaccepted memory on the machine.
> > 
> > This happens due to a commit that removed NR_BOUNCE: it removed the
> > counter from the enum zone_stat_item, but left it in the vmstat_text
> > array.
> > 
> > As a result, all counters below nr_bounce in /proc/vmstat are
> > shifted by one line, causing the numa_hit counter to be labeled as
> > nr_unaccepted.
> > 
> > To fix this issue, remove nr_bounce from the vmstat_text array.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > Fixes: 194df9f66db8 ("mm: remove NR_BOUNCE zone stat")
> > Cc: stable@vger.kernel.org
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Hannes Reinecke <hare@suse.de>
> > Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> 
> Is there a way to add a BUILD_BUG_ON to catch a future case like this one?

There's

	BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS);

in vmstat_start().

Making it strict != seems to do the trick for my config. But it requires
wider testing.

I can prepare a patch for that.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

