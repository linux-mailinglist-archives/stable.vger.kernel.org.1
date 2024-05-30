Return-Path: <stable+bounces-47716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46AE8D4DA3
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD42839D0
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0E186E5F;
	Thu, 30 May 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjU/3dBI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830CC186E26;
	Thu, 30 May 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078415; cv=none; b=dSLmEiMmzBx+Ffi22BU7Nh1qoF2nSF02X7F91Rn4n/xW9funnAsDcZRYe8WIYZKrfJIByrvHKemRmxHWLG9sya87zBGUSN2tBBgT7SoJ8iQrGd/MhA5/LI1CW6soe8pzkg/PalvQ2h3Js+ZBRx4ZAA7A1mUbgFvicJ4pjbtuRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078415; c=relaxed/simple;
	bh=z9Oe7jqbSwx2iocRxL1M7VOvOhXgSU85JZly6jmOudU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3ssY8LXldW9MHyDO18YiHEwgFKiu6Nl+xnpbrjvolJlHCg8sLyxr3Wd8LbCjNHMGTiwqS+cqpfloZKx3Hwo/kX7naQKIVB/421ia2qThyVmSAiSfND0mmkNXLmi8+vaKdMck0cI9eeGQQlM2JWqAAo6aqRx3vxIPfikasu4qOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjU/3dBI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717078413; x=1748614413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9Oe7jqbSwx2iocRxL1M7VOvOhXgSU85JZly6jmOudU=;
  b=YjU/3dBIUV7Gw3ownTyEYnMoF9SygYlEiV1D00II2U2R3M+fwUKluuxY
   LB9sDBpteLYEkdPedi3Sl6e3nS4MLBqR6gfYtbb9kipM5zTdYAncgsqsD
   iCi8aYKZSC52TzXkv5RfA0binK+cgdtqnuh849JeCG9UETa4tRKOvc6uK
   OBP2OWr7tpsLhECukbiNK0rNWa4ZXKQKwKc5CYj1Zpy3M6+xwJ7/otAWd
   QlLdn6bZjt2QqUJmfVgRihWhu0GTn6K3yZFL7JQMJIKRzBikZfOj0Z1zE
   EmWz4BCkpaPRAc/axWJA8H5Fbc8cf5NdSZMfLMcK8L1kY1GVeWqGgZUBe
   w==;
X-CSE-ConnectionGUID: lFxtRL+GQyyMUb8vjHpn5Q==
X-CSE-MsgGUID: BVmvn9rUSQGpOiU4IEhJhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13327826"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="13327826"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 07:13:32 -0700
X-CSE-ConnectionGUID: 4/dRRaIzRKStKyFjZWQwQg==
X-CSE-MsgGUID: JxYpurK5SliCnGzo8pGCGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="35767692"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 07:13:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sCgX2-0000000C6Jn-0zHu;
	Thu, 30 May 2024 17:13:28 +0300
Date: Thu, 30 May 2024 17:13:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	bp@alien8.de, stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Provide default cache line size if not
 enumerated
Message-ID: <ZliJiM8g5p-uJSPd@smile.fi.intel.com>
References: <20240517200534.8EC5F33E@davehans-spike.ostc.intel.com>
 <ZkspXhQFcWvBkL2q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkspXhQFcWvBkL2q@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 20, 2024 at 01:43:42PM +0300, Andy Shevchenko wrote:
> On Fri, May 17, 2024 at 01:05:34PM -0700, Dave Hansen wrote:
> > 
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > tl;dr: CPUs with CPUID.80000008H but without CPUID.01H:EDX[CLFSH]
> > will end up reporting cache_line_size()==0 and bad things happen.
> > Fill in a default on those to avoid the problem.
> > 
> > Long Story:
> > 
> > The kernel dies a horrible death if c->x86_cache_alignment (aka.
> > cache_line_size() is 0.  Normally, this value is populated from
> 
> Missing ) ?
> 
> > c->x86_clflush_size.
> > 
> > Right now the code is set up to get c->x86_clflush_size from two
> > places.  First, modern CPUs get it from CPUID.  Old CPUs that don't
> > have leaf 0x80000008 (or CPUID at all) just get some sane defaults
> > from the kernel in get_cpu_address_sizes().
> > 
> > The vast majority of CPUs that have leaf 0x80000008 also get
> > ->x86_clflush_size from CPUID.  But there are oddballs.
> > 
> > Intel Quark CPUs[1] and others[2] have leaf 0x80000008 but don't set
> > CPUID.01H:EDX[CLFSH], so they skip over filling in ->x86_clflush_size:
> > 
> > 	cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
> > 	if (cap0 & (1<<19))
> > 		c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
> > 
> > So they: land in get_cpu_address_sizes(), set vp_bits_from_cpuid=0 and
> > never fill in c->x86_clflush_size, assign c->x86_cache_alignment, and
> > hilarity ensues in code like:
> > 
> >         buffer = kzalloc(ALIGN(sizeof(*buffer), cache_line_size()),
> >                          GFP_KERNEL);
> > 
> > To fix this, always provide a sane value for ->x86_clflush_size.
> > 
> > Big thanks to Andy Shevchenko for finding and reporting this and also
> > providing a first pass at a fix. But his fix was only partial and only
> > worked on the Quark CPUs.  It would not, for instance, have worked on
> > the QEMU config.
> > 
> > 1. https://raw.githubusercontent.com/InstLatx64/InstLatx64/master/GenuineIntel/GenuineIntel0000590_Clanton_03_CPUID.txt
> > 2. You can also get this behavior if you use "-cpu 486,+clzero"
> >    in QEMU.
> 
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> (as this obviously fixes the issue as it makes a partial revert of the culprit
>  change).

What's the status of this? (It seems you have to rebase it on top of the
existing patches in the same area).

-- 
With Best Regards,
Andy Shevchenko



