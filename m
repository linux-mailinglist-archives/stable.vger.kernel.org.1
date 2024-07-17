Return-Path: <stable+bounces-60434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F9D933CA3
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 13:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE174281E86
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5514517F389;
	Wed, 17 Jul 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vz8wPp57"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C145009;
	Wed, 17 Jul 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721217315; cv=none; b=tvuEJhXfqVwLjPxY/jG8kV3gngeM2YI25RN65kKIXxWX2SaUVTCc1ATryY99gE0T37D1xEjt46Uef1hHP8eeLhCl9MVFco6amt5/svTLjw9cz6Niwi/qzwRqmVjvmgANFYUH2PAVhYeCXE3S9DkFCsIZc2xjlGoVX1Gr8InoAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721217315; c=relaxed/simple;
	bh=ryFplDwaF9LrfXi9LMq+5WiAnqCBtaCywkMwnwyBkjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkHYNU/ZKMWxtIMsC//VgeChLqgWIyKhbx5iMrY0pLEZGDOXMbrVMI7+JBMLVRIwzJAhYeu9nB/BgTsPVTeWy/KKWarx8LHN+ttKSUBWvtg6RJJY7OGJGBhXoDAZQHRrMzjx3Zovw2E7g+EY6CGG5hpcz/mlsc5w7h1bHq8nVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vz8wPp57; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721217313; x=1752753313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ryFplDwaF9LrfXi9LMq+5WiAnqCBtaCywkMwnwyBkjs=;
  b=Vz8wPp57WM/z7pMtJ8rUPkKyjivl09rR/RqQ2MNxtB7daqMSbQHmR/AS
   Ucfn7dk9V43MYEU6nw/vAlfb+dvgc0838IGQ1COE96a6c1JNCveYOCHx+
   04Ux2cwXInrDj8DZtofZsvpdI7dxL+jFlQSlLLRpbLs8ybhhRe+1TKtSx
   0IYeCOAppQPuSqlQ73vzU1TqcvL1Vnuuc7ObMWb0k2iNfJjacBdd+WnB0
   oXVgzw+vgG0yjjP3VfIuEseGuc/+67XJVDNReIXdvM9s9pwgSFVNL16WN
   kuoWgESo7uK/BU//mrAy01J95+hvAOvb/GuKPSnmdd+5NWxHmq00+QtyJ
   A==;
X-CSE-ConnectionGUID: s1b6s4MyTe6TRpWMYtBBQg==
X-CSE-MsgGUID: zRK0r//DRQGOQRWNCSg6TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="21618510"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="21618510"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 04:55:12 -0700
X-CSE-ConnectionGUID: WW7YfiZtSPuV/FAYAVfibQ==
X-CSE-MsgGUID: 50N4wCG+QvCBSVg7wTTQVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="81407900"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jul 2024 04:55:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EB424161; Wed, 17 Jul 2024 14:55:08 +0300 (EEST)
Date: Wed, 17 Jul 2024 14:55:08 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jianxiong Gao <jxgao@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Message-ID: <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
 <ZpdwcOv9WiILZNvz@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpdwcOv9WiILZNvz@tiehlicka>

On Wed, Jul 17, 2024 at 09:19:12AM +0200, Michal Hocko wrote:
> On Tue 16-07-24 16:00:13, Kirill A. Shutemov wrote:
> > Unaccepted memory is considered unusable free memory, which is not
> > counted as free on the zone watermark check. This causes
> > get_page_from_freelist() to accept more memory to hit the high
> > watermark, but it creates problems in the reclaim path.
> > 
> > The reclaim path encounters a failed zone watermark check and attempts
> > to reclaim memory. This is usually successful, but if there is little or
> > no reclaimable memory, it can result in endless reclaim with little to
> > no progress. This can occur early in the boot process, just after start
> > of the init process when the only reclaimable memory is the page cache
> > of the init executable and its libraries.
> 
> How does this happen when try_to_accept_memory is the first thing to do
> when wmark check fails in the allocation path?

Good question.

I've lost access to the test setup and cannot check it directly right now.

Reading the code Looks like __alloc_pages_bulk() bypasses
get_page_from_freelist() where we usually accept more pages and goes
directly to __rmqueue_pcplist() -> rmqueue_bulk() -> __rmqueue().

Will look more into it when I have access to the test setup.

> Could you describe what was the initial configuration of the system? How
> much of the unaccepted memory was there to trigger this?

This is large TDX guest VM: 176 vCPUs and ~800GiB of memory.

One thing that I noticed that the problem is only triggered when LRU_GEN
enabled. But I failed to identify why.

The system hang (or have very little progress) shortly after systemd
starts.

> > To address this issue, teach shrink_node() and shrink_zones() to accept
> > memory before attempting to reclaim.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-by: Jianxiong Gao <jxgao@google.com>
> > Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> > Cc: stable@vger.kernel.org # v6.5+
> [...]
> >  static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  {
> >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
> >  	struct lruvec *target_lruvec;
> >  	bool reclaimable = false;
> >  
> > +	/* Try to accept memory before going for reclaim */
> > +	if (node_try_to_accept_memory(pgdat, sc)) {
> > +		if (!should_continue_reclaim(pgdat, 0, sc))
> > +			return;
> > +	}
> > +
> 
> This would need an exemption from the memcg reclaim.

Hm. Could you elaborate why?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

