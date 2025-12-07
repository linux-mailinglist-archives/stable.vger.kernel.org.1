Return-Path: <stable+bounces-200301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B75CABADE
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 00:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEF813003531
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230212D877E;
	Sun,  7 Dec 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Anct7lth"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567A1E834E;
	Sun,  7 Dec 2025 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765149823; cv=none; b=RCgZkhkCsVBwMgvFUtIDm4U6f6u7KTIWec422vPgR7lUxQNN66dOBeyrum+20Ks8HVGJ6KbeT9LGfir5NkcMgXDR0T+wQYNx9NlVHxCKubFArArsYmnF94EB4iQLFBKkp8v+2SfUhAtbHAuhN81E/av3Al+a+dWrzZ1eR7f2bK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765149823; c=relaxed/simple;
	bh=srB4iPLR8Swk0rQfFDIvdFNncTDG6I2jY9ADM89qvA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb+a4JdAxZP3FfbumqxV2XT3O/QV5S6ohM7asNJ6eYk5R4CDr+K+hpzBm8/Qqbv2TdOA5zNsuP6kuyYLHCTjP4JHc7mXFK1Jl8/zxvS/BYKZLlXpFm2cZp+fKpRsl73lgv4VaxA5ock2qVEdqsOqMmcy5XSE+DV4f1EvdBqVlQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Anct7lth; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765149822; x=1796685822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=srB4iPLR8Swk0rQfFDIvdFNncTDG6I2jY9ADM89qvA8=;
  b=Anct7lthv6lR2Y2WHINN8sGDAvHzxCS6R5QlUPpIfThIh1npLqsQX9Z7
   BJE7Cf7TjJiHqrQbG0Z4IJhn9CLtm4ZIk0JW4whgyTIjJH97FKnr4q8Bs
   1C0uEngCL2tiTlCco9ApPrCeu15Vjj8lSWuuuY0VfllzXcUSCGwRmS7X4
   7uqpg2F0sbr3qKXbfSiBkcjVLtlk080rv/EMH08Z5CmmDYgSpwmgXzB9c
   +2omaU7xtQvgoAwj8CqULkJzshk5sjbozh3zSdwv4mbHkaI2WmMg2Rct+
   T3m3byVlF/Bpg1sKiuPRCmCAb0RriFq/fXFKUNSgNud8l+aTi4C4V4iXr
   g==;
X-CSE-ConnectionGUID: HpF80cK5SRq6qsWhTGJshA==
X-CSE-MsgGUID: f2PA0HeQTTG8hF3SN9i8gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="66097618"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="66097618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 15:23:41 -0800
X-CSE-ConnectionGUID: 8a+TGpGOSFGmheo+tzKTyQ==
X-CSE-MsgGUID: 4UJr3q/JSL67PZ3h4kHBMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="226795565"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 15:23:39 -0800
Date: Mon, 8 Dec 2025 01:23:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
Message-ID: <aTYMeY1AsprPwC_9@smile.fi.intel.com>
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
 <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 01:12:08AM +0200, Andy Shevchenko wrote:
> On Sun, Dec 07, 2025 at 10:53:48PM +0100, Christian Marangi wrote:
> > Commit 900730dc4705 ("wifi: ath: Use
> > of_reserved_mem_region_to_resource() for "memory-region"") uncovered a
> > massive problem with the usage of resource_size() helper.
> > 
> > The reported commit caused a regression with ath11k WiFi firmware
> > loading and the change was just a simple replacement of duplicate code
> > with a new helper of_reserved_mem_region_to_resource().
> > 
> > On reworking this, in the commit also a check for the presence of the
> > node was replaced with resource_size(&res). This was done following the
> > logic that if the node wasn't present then it's expected that also the
> > resource_size is zero, mimicking the same if-else logic.
> > 
> > This was also the reason the regression was mostly hard to catch at
> > first sight as the rework is correctly done given the assumption on the
> > used helpers.
> > 
> > BUT this is actually not the case. On further inspection on
> > resource_size() it was found that it NEVER actually returns 0.

Actually this not true. Obviously if the end == start - 1, it will return 0.
So, you really need _carefully_ check users one-by-one and see how resource
is filled, before judging the test. It might or might not be broken. Each
case is individual, but the observation you made is quite valuable, thanks!

> > Even if the resource value of start and end are 0, the return value of
> > resource_size() will ALWAYS be 1, resulting in the broken if-else
> > condition ALWAYS going in the first if condition.
> > 
> > This was simply confirmed by reading the resource_size() logic:
> > 
> > 	return res->end - res->start + 1;
> > 
> > Given the confusion, also other case of such usage were searched in the
> > kernel and with great suprise it seems LOTS of place assume
> > resource_size() should return zero in the context of the resource start
> > and end set to 0.
> > 
> > Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:
> > 
> > 		/*
> > 		 * The PCI core shouldn't set up a resource with a
> > 		 * type but zero size. But there may be bugs that
> > 		 * cause us to do that.
> > 		 */
> > 		if (!resource_size(res))
> > 			goto no_mmap;
> > 
> > It really seems resource_size() was tought with the assumption that
> > resource struct was always correctly initialized before calling it and
> > never set to zero.
> > 
> > But across the year this got lost and now there are lots of driver that
> > assume resource_size() returns 0 if start and end are also 0.
> > 
> > To better handle this and make resource_size() returns correct value in
> > such case, add a simple check and return 0 if both resource start and
> > resource end are zero.
> 
> Good catch!
> 
> Now, let's unveil which drivers rely on "broken" behaviour...
> 
> ...
> 
> >  static inline resource_size_t resource_size(const struct resource *res)
> >  {
> > +	if (!res->start && !res->end)
> > +		return 0;
> 
> I think this breaks or might brake some of the drivers that rely on the proper
> calculation. If you supply the start and end for the same (if it's not 0), you
> will get 1 and it's _correct_ result (surprise surprise). One of the thing that
> may be directly affected (and regress) is the amount of IRQs calculation (which
> on some platforms may start from 0). However, in practice I think it's none
> nowadays in the upstream kernel.
> 
> >  	return res->end - res->start + 1;
> >  }
> 
> That said, unfortunately, I think, you want to fix drivers one-by-one and this
> patch is incorrect as it brings inconsistency to the logic (1 occupied address
> whatever unit it has may still be valid resource).
> 
> Also a good start is to add test cases and add/update documentation.

-- 
With Best Regards,
Andy Shevchenko



