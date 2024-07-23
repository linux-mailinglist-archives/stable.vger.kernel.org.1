Return-Path: <stable+bounces-60741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1A939E3A
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6B11C2096B
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9414D6FE;
	Tue, 23 Jul 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nligh5b3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D585014B94E;
	Tue, 23 Jul 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728188; cv=none; b=AZ3mV/I8mSTBJ9noTMFZ0svxeNfGAtWgR0gb4HfMYRWrIPIi1m4mZ9X2WgMYjw11zKUTF7vZIUeLMLap2mIX/lwPnBNiPcxBwGL79XOlhC8HqTgOCaMNra3EpFgIM9W5lmSOREEGD+eR8S0vJ/+cwmmhgNpl/su/cG8MWuRE1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728188; c=relaxed/simple;
	bh=J7B57AhsYu2mlW6Prap8g6w5QYT11RX/aKaEuAJH0jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VivEg27niFZtcC0iHeG/zQhLcOCAt1F8FQ+nWsHXvntr3mUm7FFhI66OXF0Qf+h9jk40sInvuRw9f62RvLf4Io8G8jzv6NPnqsxdtjZyo/Ty8UY3PKbwP73j+VZw+PMviX24a2I9KrACzISpfrF7LUinXG1qkDMZ4F8/P/QHqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nligh5b3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721728187; x=1753264187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J7B57AhsYu2mlW6Prap8g6w5QYT11RX/aKaEuAJH0jg=;
  b=nligh5b33MPcgfOHFGQ/5Rv86Esy+9PDgrc+d1Rhxfdr6lR4dnA1trDa
   yM5tKRJYoTj9wYMYSXVUt28g7oPjH5gTx5sbI9WQf0zkpoTGj215Gm69h
   nslIC686iDceb4f+yc+GDZrxc5ww1/UYiZZ6E4DcLVsWqA+2nKEG8B9i6
   /esxG5K74zzbhYB/6Ot1FwOL1gsWCuZkNkWzd+Lp2sgvnAoDMWD+tTr3O
   wz9bmaW2qVmxoqUMeuy5riB6vylevAswPZM/r2507GAgVPsn/fa+oqjnO
   LhT/rwzZyqhouraR6qHnRfIREKSsrWeJTj3GqCMkKlPf3ijc7sG2/Isrl
   w==;
X-CSE-ConnectionGUID: cOrCzIKqTbacxXJtJX65Rg==
X-CSE-MsgGUID: 6uWo/WKhRQ2nws774q7h9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="23144342"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="23144342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 02:49:46 -0700
X-CSE-ConnectionGUID: +hxMdSabT9iOXv0AKysMLw==
X-CSE-MsgGUID: 8UC81fLbQTCbkfSv8LEFig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56480785"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jul 2024 02:49:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6C554178; Tue, 23 Jul 2024 12:49:41 +0300 (EEST)
Date: Tue, 23 Jul 2024 12:49:41 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mel Gorman <mgorman@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jianxiong Gao <jxgao@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Message-ID: <dili5kn3xjjzamwmyxjgdkf5vvh6sqftm7qk4f2vbxuizfzlb2@xrtxlvlqaos5>
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
 <ZpdwcOv9WiILZNvz@tiehlicka>
 <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>
 <Zpez1rkIQzVWxi7q@tiehlicka>
 <brjw4kb3x4wohs4a6y5lqxr6a5zlz3m45hiyyyht5mgrqcryk7@m7mdyojo4h6a>
 <564ff8e4-42c9-4a00-8799-eaa1bef9c338@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564ff8e4-42c9-4a00-8799-eaa1bef9c338@suse.cz>

On Tue, Jul 23, 2024 at 09:30:27AM +0200, Vlastimil Babka wrote:
> On 7/22/24 4:07 PM, Kirill A. Shutemov wrote:
> > On Wed, Jul 17, 2024 at 02:06:46PM +0200, Michal Hocko wrote:
> >> Please try to investigate this further. The patch as is looks rather
> >> questionable to me TBH. Spilling unaccepted memory into the reclaim
> >> seems like something we should avoid if possible as this is something
> > 
> > Okay, I believe I have a better understanding of the situation:
> > 
> > - __alloc_pages_bulk() takes pages from the free list without accepting
> >   more memory. This can cause number of free pages to fall below the
> >   watermark.
> > 
> >   This issue can be resolved by accepting more memory in
> >   __alloc_pages_bulk() if the watermark check fails.
> > 
> >   The problem is not only related to unallocated memory. I think the
> >   deferred page initialization mechanism could result in premature OOM if
> >   __alloc_pages_bulk() allocates pages faster than deferred page
> >   initialization can add them to the free lists. However, this scenario is
> >   unlikely.
> > 
> > - There is nothing that compels the kernel to accept more memory after the
> >   watermarks have been calculated in __setup_per_zone_wmarks(). This can
> >   put us under the watermark.
> > 
> >   This issue can be resolved by accepting memory up to the watermark after
> >   the watermarks have been initialized.
> > 
> > - Once kswapd is started, it will begin spinning if we are below the
> >   watermark and there is no memory that can be reclaimed. Once the above
> >   problems are fixed, the issue will be resolved.
> > 
> > - The kernel needs to accept memory up to the PROMO watermark. This will
> >   prevent unaccepted memory from interfering with NUMA balancing.
> 
> So do we still assume all memory is eventually accepted and it's just a
> initialization phase thing? And the only reason we don't do everything in a
> kthread like the deferred struct page init, is to spread out some potential
> contention on the host side?
> 
> If yes, do we need NUMA balancing even to be already active during that phase?

No, there is nothing that requires guests to accept all of the memory. If
the working set of a workload within the guest only requires a portion of
the memory, the rest will remain unallocated and available to the host for
other tasks.

I think accepting memory up to the PROMO watermark would not hurt
anybody.

> > The patch below addresses the issues I listed earlier. It is not yet ready
> > for application. Please see the issues listed below.
> > 
> > Andrew, please drop the current patch.
> > 
> > There are a few more things I am worried about:
> > 
> > - The current get_page_from_freelist() and patched __alloc_pages_bulk()
> >   only try to accept memory if the requested (alloc_flags & ALLOC_WMARK_MASK)
> >   watermark check fails. For example, if a requested allocation with
> >   ALLOC_WMARK_MIN is called, we will not try to accept more memory, which
> >   could potentially put us under the high/promo watermark and cause the
> >   following kswapd start to get us into an endless loop.
> > 
> >   Do we want to make memory acceptance in these paths independent of
> >   alloc_flags?
> 
> Hm ALLOC_WMARK_MIN will proceed, but with a watermark below the low
> watermark will still wake up kswapd, right? Isn't that another scenario
> where kswapd can start spinning?

Yes, that is the concern.

> > - __isolate_free_page() removes a page from the free list without
> >   accepting new memory. The function is called with the zone lock taken.
> >   It is bad idea to accept memory while holding the zone lock, but
> >   the alternative of pushing the accept to the caller is not much better.
> > 
> >   I have not observed any issues caused by __isolate_free_page() in
> >   practice, but there is no reason why it couldn't potentially cause
> >   problems.
> >  
> > - The function take_pages_off_buddy() also removes pages from the free
> >   list without accepting new memory. Unlike the function
> >   __isolate_free_page(), it is called without the zone lock being held, so
> >   we can accept memory there. I believe we should do so.
> > 
> > I understand why adding unaccepted memory handling into the reclaim path
> > is questionable. However, it may be the best way to handle cases like
> > __isolate_free_page() and possibly others in the future that directly take
> > memory from free lists.
> 
> Yes seems it might be not that bad solution, otherwise it could be hopeless
> whack-a-mole to prevent all corner cases where reclaim can be triggered
> without accepting memory first.
> 
> Although just removing the lazy accept mode would be much more appealing
> solution than this :)

:P

Not really an option for big VMs. It might add many minutes to boot time.

> > Any thoughts?
> 
> Wonder if deferred struct page init has many of the same problems, i.e. with
> __isolate_free_page() and take_pages_off_buddy(), and if not, why?

Even if deferred struct page init would trigger reclaim, kswapd will not
spin forever. The background thread will add more free memory, so forward
progress is guaranteed. And deferred struct page init is done before init
starts.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

