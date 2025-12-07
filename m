Return-Path: <stable+bounces-200299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA650CABAAE
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 00:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EB723012778
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 23:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803002DC33B;
	Sun,  7 Dec 2025 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqMKzTaZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2871A5B8A;
	Sun,  7 Dec 2025 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765149130; cv=none; b=mOOy15yGKRmdcR7VkniYswFuyvXDRCfgyJjEQ/3YC1pknCpqlvdMbjGnaVHsPa9QJ+W8O8wH/ZG3FVWmsf7M3npRcvSHIQxP6pj68jlnYD9W/2kiEODW7Pe1hJJegKZTCTtuyeuRxD8aBnTJuFBdy7n82K9yrhxUlTlI5N2MFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765149130; c=relaxed/simple;
	bh=UJ344PUJlDwEaGJeRp87ivM+RK/jeassOeNT36JYRKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z78ZFimHzgQpR+B47w9ggQel03Tth2R+aSWQuxkGxNKaw8D3x/Vlgth6sIATW5S9fq9QN2XvguyCg9IlE1Z9G5lU4ZIl+Xz/uu4krHs5TwDICmSzQX3TZKpB30VirV65F616mL0fNWQAKSQ8lV9T6Fgi/IpNdSK5NSeSNw8x91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqMKzTaZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765149129; x=1796685129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UJ344PUJlDwEaGJeRp87ivM+RK/jeassOeNT36JYRKs=;
  b=CqMKzTaZC1RPueumZjGGoYV7L+rxLLWh0bLfH+ioZkibdcBoHsPgwpGH
   0NWh7dYALbiJCtJvuaaxXRXRWvLFH/wM0LwhjqoU5klSLzbiTu3RN5Xty
   Xy2/dk9d5PkLtJ2nMWPbv7FDxzCZLvlp/ZYHY0LBQIVtzNGqnhXW8r0hv
   E7Ezh8xrbN/m8EBfjiSlCrRWo0Rj3inxPY9nSjm8mR3tTuSooRR/UDHeD
   qLKm4Ixf+iAHULuW/8WBLwNI+RNJ35H/IlboKVyGDKAoCdh5RmFoAuKyf
   Y5BgDZn9g2ttwueVlcWD8mJXSUmCpX0FpY6EWk7bl/707m3Q2FikHq2G8
   w==;
X-CSE-ConnectionGUID: JBEqDI2vSvyEYY4MZyQA/g==
X-CSE-MsgGUID: xNb32sasQbuUClw4UAeCYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="89749626"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="89749626"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 15:12:08 -0800
X-CSE-ConnectionGUID: IK23ZV93SGCti0ogWyxzOA==
X-CSE-MsgGUID: XRmEHXgeTA+lZF/ibvz0Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="195062174"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 15:12:06 -0800
Date: Mon, 8 Dec 2025 01:12:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
Message-ID: <aTYJw9lNfHxQI_Ag@smile.fi.intel.com>
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207215359.28895-1-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Dec 07, 2025 at 10:53:48PM +0100, Christian Marangi wrote:
> Commit 900730dc4705 ("wifi: ath: Use
> of_reserved_mem_region_to_resource() for "memory-region"") uncovered a
> massive problem with the usage of resource_size() helper.
> 
> The reported commit caused a regression with ath11k WiFi firmware
> loading and the change was just a simple replacement of duplicate code
> with a new helper of_reserved_mem_region_to_resource().
> 
> On reworking this, in the commit also a check for the presence of the
> node was replaced with resource_size(&res). This was done following the
> logic that if the node wasn't present then it's expected that also the
> resource_size is zero, mimicking the same if-else logic.
> 
> This was also the reason the regression was mostly hard to catch at
> first sight as the rework is correctly done given the assumption on the
> used helpers.
> 
> BUT this is actually not the case. On further inspection on
> resource_size() it was found that it NEVER actually returns 0.
> 
> Even if the resource value of start and end are 0, the return value of
> resource_size() will ALWAYS be 1, resulting in the broken if-else
> condition ALWAYS going in the first if condition.
> 
> This was simply confirmed by reading the resource_size() logic:
> 
> 	return res->end - res->start + 1;
> 
> Given the confusion, also other case of such usage were searched in the
> kernel and with great suprise it seems LOTS of place assume
> resource_size() should return zero in the context of the resource start
> and end set to 0.
> 
> Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:
> 
> 		/*
> 		 * The PCI core shouldn't set up a resource with a
> 		 * type but zero size. But there may be bugs that
> 		 * cause us to do that.
> 		 */
> 		if (!resource_size(res))
> 			goto no_mmap;
> 
> It really seems resource_size() was tought with the assumption that
> resource struct was always correctly initialized before calling it and
> never set to zero.
> 
> But across the year this got lost and now there are lots of driver that
> assume resource_size() returns 0 if start and end are also 0.
> 
> To better handle this and make resource_size() returns correct value in
> such case, add a simple check and return 0 if both resource start and
> resource end are zero.

Good catch!

Now, let's unveil which drivers rely on "broken" behaviour...

...

>  static inline resource_size_t resource_size(const struct resource *res)
>  {
> +	if (!res->start && !res->end)
> +		return 0;

I think this breaks or might brake some of the drivers that rely on the proper
calculation. If you supply the start and end for the same (if it's not 0), you
will get 1 and it's _correct_ result (surprise surprise). One of the thing that
may be directly affected (and regress) is the amount of IRQs calculation (which
on some platforms may start from 0). However, in practice I think it's none
nowadays in the upstream kernel.

>  	return res->end - res->start + 1;
>  }

That said, unfortunately, I think, you want to fix drivers one-by-one and this
patch is incorrect as it brings inconsistency to the logic (1 occupied address
whatever unit it has may still be valid resource).

Also a good start is to add test cases and add/update documentation.

-- 
With Best Regards,
Andy Shevchenko



