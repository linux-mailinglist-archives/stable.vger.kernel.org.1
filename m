Return-Path: <stable+bounces-200304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7FACABB06
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 00:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 449553012BE2
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 23:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E742D97A5;
	Sun,  7 Dec 2025 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeyMbESh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201851E3DF2;
	Sun,  7 Dec 2025 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765151860; cv=none; b=SStypR4WxBRqMUNml0mi4u+twi6Z9Kog6PznD+nKJ8QfFpW120/uVntaWZs5dPhKoXKoo+/BJJHsVFNnU7Y65lfFxerS0JvrrGgPOA+Deeq4yGkkNRBRZHZS1cWGujtsTyYXvKJSIj7ZOsEdmmJ5rMsMFm+rYgqWv6SYZDtJDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765151860; c=relaxed/simple;
	bh=tOokoTWX59gcFfZvdlO329elafLOEEFnojjQytI/fmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRHWVWk03yVB4T5oWMDmD7h1v6GqQbxG3ZW8tQNY3I2QbMWza1zBMMeuxidMkK9gSFz4R9En+WoDHIWHd2/q246wY39NTayAjvf43E1714f6TYdi7NepZY7QTEvN8oQYD/SU4V2nIsFh8vmYMzIZkkvDYajGz58rEmjIpznrI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeyMbESh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765151858; x=1796687858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tOokoTWX59gcFfZvdlO329elafLOEEFnojjQytI/fmo=;
  b=LeyMbEShrxa7LeYzY2xlytG2Ah1/IDSY4xk8JhaofVTgc0IZKNvCjOLt
   Fj9sC4DTJfJnbqee5ZJh21RguOFA49T7k/Bq4Mwfl3roaR3OXgUf0wZYg
   d1UEGMUvyBAYgUjpCHbomU7OMoF6xEQV3OOH2ygJ/Uj2ovfnmeceMjSbG
   4VcYfBnOKFk5eaeghqrhOpEPst54YAUaHLS6+VKBoLQAT8wY86z685Gwz
   OaC10YPyLzlyJBbNUA2oCOkl0PZAOBvNobZ4ASfXD1vtdC1+lQzSLxsvv
   YM4XZxYY0aMM/NXJxqlNLx2+ceY8vWc9KkE1N6kj4hMYejfxSBdpwlKvY
   Q==;
X-CSE-ConnectionGUID: F9sqLOeSRye4bEvKaLkn9A==
X-CSE-MsgGUID: EQZfOU8pTNyY81io/QTphA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="92574615"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="92574615"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 15:57:37 -0800
X-CSE-ConnectionGUID: 0S1VYkYDTeuwydAKQtlGIA==
X-CSE-MsgGUID: yuX3rLcfTk22gnxaq8tpMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="226459498"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 15:57:35 -0800
Date: Mon, 8 Dec 2025 01:57:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
Message-ID: <aTYUbPcpl9aVijpS@smile.fi.intel.com>
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
 <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>
 <aTYMeY1AsprPwC_9@smile.fi.intel.com>
 <69360eb2.050a0220.2b0cf3.b5a8@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69360eb2.050a0220.2b0cf3.b5a8@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 12:33:03AM +0100, Christian Marangi wrote:
> On Mon, Dec 08, 2025 at 01:23:37AM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 08, 2025 at 01:12:08AM +0200, Andy Shevchenko wrote:
> > > On Sun, Dec 07, 2025 at 10:53:48PM +0100, Christian Marangi wrote:
> > > > Commit 900730dc4705 ("wifi: ath: Use
> > > > of_reserved_mem_region_to_resource() for "memory-region"") uncovered a
> > > > massive problem with the usage of resource_size() helper.
> > > > 
> > > > The reported commit caused a regression with ath11k WiFi firmware
> > > > loading and the change was just a simple replacement of duplicate code
> > > > with a new helper of_reserved_mem_region_to_resource().
> > > > 
> > > > On reworking this, in the commit also a check for the presence of the
> > > > node was replaced with resource_size(&res). This was done following the
> > > > logic that if the node wasn't present then it's expected that also the
> > > > resource_size is zero, mimicking the same if-else logic.
> > > > 
> > > > This was also the reason the regression was mostly hard to catch at
> > > > first sight as the rework is correctly done given the assumption on the
> > > > used helpers.
> > > > 
> > > > BUT this is actually not the case. On further inspection on
> > > > resource_size() it was found that it NEVER actually returns 0.
> > 
> > Actually this not true. Obviously if the end == start - 1, it will return 0.
> > So, you really need _carefully_ check users one-by-one and see how resource
> > is filled, before judging the test. It might or might not be broken. Each
> > case is individual, but the observation you made is quite valuable, thanks!
> 
> Yes sure there are case where it can return zero but are there real
> world scenario like that in the context of resource_size for PCI or
> resouce for MMIO?

I believe PCI by design won't enumerate the device that has 0 size.
Either it will be cut at the level of some checks before even considering
filing the resources, or if resource_size() returns 1, it won't find proper
window or window will be taken at bare minimum of a size of the page
(usually 4k). I'm not sure that PCI code is affected by this, but it worth
to check.

> Again the idea of this patch was to start searching for error instead of
> simply fixing ath11k, I'm pretty sure there are other case that are
> currently working by luck.

True.

> Another idea might be to introduce a new helper and add all kind of
> checks to understand if the resource we are testing is all zero.

I think the better choice is to check all places where resource is assigned
and convert that to a helper when the size can be or is 0. Definitely it's
a lot of code to be audited.

But having something like

	resource_set_size(res, 0) // note, this API is already in upstream
or
	resource_set_range(res, start, 0)

instead of direct assignment of start and end is much simpler approach.

> Something like resource_is_zero() that checks if start end and flags are
> all zero? (and fix all the case where the helper might be used in a
> wrong way?)
> 
> Or maybe we can change the condition of this to:
> 
> if (!res.flags && !res.start && !res.end)
> 	return 0;
> 
> Just putting some ideas on what would be the proper solution to the
> problem without having to analyze all the 990 case where the helper is
> used ehehehhe

Like I said, the best and really helpful start is
- test cases for these corner cases
- documentation audit and update

When we have documentation in place and test cases to show how it all works,
we may point out to the bugs or incorrect assumptions made in the code.

> > > > Even if the resource value of start and end are 0, the return value of
> > > > resource_size() will ALWAYS be 1, resulting in the broken if-else
> > > > condition ALWAYS going in the first if condition.
> > > > 
> > > > This was simply confirmed by reading the resource_size() logic:
> > > > 
> > > > 	return res->end - res->start + 1;
> > > > 
> > > > Given the confusion, also other case of such usage were searched in the
> > > > kernel and with great suprise it seems LOTS of place assume
> > > > resource_size() should return zero in the context of the resource start
> > > > and end set to 0.
> > > > 
> > > > Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:
> > > > 
> > > > 		/*
> > > > 		 * The PCI core shouldn't set up a resource with a
> > > > 		 * type but zero size. But there may be bugs that
> > > > 		 * cause us to do that.
> > > > 		 */
> > > > 		if (!resource_size(res))
> > > > 			goto no_mmap;
> > > > 
> > > > It really seems resource_size() was tought with the assumption that
> > > > resource struct was always correctly initialized before calling it and
> > > > never set to zero.
> > > > 
> > > > But across the year this got lost and now there are lots of driver that
> > > > assume resource_size() returns 0 if start and end are also 0.
> > > > 
> > > > To better handle this and make resource_size() returns correct value in
> > > > such case, add a simple check and return 0 if both resource start and
> > > > resource end are zero.
> > > 
> > > Good catch!
> > > 
> > > Now, let's unveil which drivers rely on "broken" behaviour...
> > > 
> > > ...
> > > 
> > > >  static inline resource_size_t resource_size(const struct resource *res)
> > > >  {
> > > > +	if (!res->start && !res->end)
> > > > +		return 0;
> > > 
> > > I think this breaks or might brake some of the drivers that rely on the proper
> > > calculation. If you supply the start and end for the same (if it's not 0), you
> > > will get 1 and it's _correct_ result (surprise surprise). One of the thing that
> > > may be directly affected (and regress) is the amount of IRQs calculation (which
> > > on some platforms may start from 0). However, in practice I think it's none
> > > nowadays in the upstream kernel.
> > > 
> > > >  	return res->end - res->start + 1;
> > > >  }
> > > 
> > > That said, unfortunately, I think, you want to fix drivers one-by-one and this
> > > patch is incorrect as it brings inconsistency to the logic (1 occupied address
> > > whatever unit it has may still be valid resource).
> > > 
> > > Also a good start is to add test cases and add/update documentation.

-- 
With Best Regards,
Andy Shevchenko



