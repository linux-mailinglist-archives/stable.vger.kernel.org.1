Return-Path: <stable+bounces-45437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B0B8C9B8F
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 12:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0CB1C21A24
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391B451C2A;
	Mon, 20 May 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLnA7NIZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26304F5E6;
	Mon, 20 May 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201829; cv=none; b=hk528zaj7ExfI+0F1TSD3ftxWJR5tVUi8pXrBTv+dnMcx4hDhlccDpaJz6ByXtA3VwhdfZzlJxtHFfytdeE3AFdJCIyEnKgaAWCDQkzhDb2Zim4U/yTo65veKffoP6vOg/JJ17i/LiZsTEXE3UxzF088ZG/aYv/nNeaczapHfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201829; c=relaxed/simple;
	bh=5+bbb1UczVvw6K+0nS9bOImpVZ8qu3hNkapBpWA73wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dte93O2wKpxdLuY380TmnsNivGvjEPe+7VDu786WdwaNIEktqjBELEIw7MfpgB09rTAwWTx/8bYJHsgv/P3uppUMBTWHCuGMci4GgHucmp41AfAb2c1jxL/ItSQuyTghzhU+a7UJg9txSmL5XWfHBdh67OO3pi8Pq/8923AAN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLnA7NIZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716201828; x=1747737828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5+bbb1UczVvw6K+0nS9bOImpVZ8qu3hNkapBpWA73wo=;
  b=QLnA7NIZVeLc3tsj8RqFsSbFjDiCY+KZP/ZQAlvdI6iHhmKzh7juV/vT
   1QOMaudCJ9qUKotHOIfztgNw9VnyjOd1Ged+HoMbWeAMW6hV98D6GHhpR
   B9yiVsCAHVTZw2wismrmyYN6HjmGFra/OVB6uLRJgJ5lOZtUMTtRcClqK
   6dy/6DeMbABAND2Y2xX+IpLRZwn0NFiAEy8NsXhtxEhLMtaVlOgbvW6Gf
   JEyr3CJxeAviYHINo7YJJwU/fpFeVe77XW1dgKSheTCTc3UW4GgQoi/N/
   PkymeghMQs++bl+z5/6IKRAH+fz781JIMhG3crfSyZkAeKh73+KcI/ozX
   g==;
X-CSE-ConnectionGUID: 4S4EUtkSQCymJH0r3Lr3gA==
X-CSE-MsgGUID: CYaY8Ha7RyeyJi+jFRNPnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12163853"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12163853"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:43:47 -0700
X-CSE-ConnectionGUID: iZNt5L4bSBCMya55eNWjmQ==
X-CSE-MsgGUID: uqFEuioCQ02AyNpzDiKeLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="37435554"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:43:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s90UY-00000009Htu-1RTD;
	Mon, 20 May 2024 13:43:42 +0300
Date: Mon, 20 May 2024 13:43:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	bp@alien8.de, stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Provide default cache line size if not
 enumerated
Message-ID: <ZkspXhQFcWvBkL2q@smile.fi.intel.com>
References: <20240517200534.8EC5F33E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517200534.8EC5F33E@davehans-spike.ostc.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 17, 2024 at 01:05:34PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> tl;dr: CPUs with CPUID.80000008H but without CPUID.01H:EDX[CLFSH]
> will end up reporting cache_line_size()==0 and bad things happen.
> Fill in a default on those to avoid the problem.
> 
> Long Story:
> 
> The kernel dies a horrible death if c->x86_cache_alignment (aka.
> cache_line_size() is 0.  Normally, this value is populated from

Missing ) ?

> c->x86_clflush_size.
> 
> Right now the code is set up to get c->x86_clflush_size from two
> places.  First, modern CPUs get it from CPUID.  Old CPUs that don't
> have leaf 0x80000008 (or CPUID at all) just get some sane defaults
> from the kernel in get_cpu_address_sizes().
> 
> The vast majority of CPUs that have leaf 0x80000008 also get
> ->x86_clflush_size from CPUID.  But there are oddballs.
> 
> Intel Quark CPUs[1] and others[2] have leaf 0x80000008 but don't set
> CPUID.01H:EDX[CLFSH], so they skip over filling in ->x86_clflush_size:
> 
> 	cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
> 	if (cap0 & (1<<19))
> 		c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
> 
> So they: land in get_cpu_address_sizes(), set vp_bits_from_cpuid=0 and
> never fill in c->x86_clflush_size, assign c->x86_cache_alignment, and
> hilarity ensues in code like:
> 
>         buffer = kzalloc(ALIGN(sizeof(*buffer), cache_line_size()),
>                          GFP_KERNEL);
> 
> To fix this, always provide a sane value for ->x86_clflush_size.
> 
> Big thanks to Andy Shevchenko for finding and reporting this and also
> providing a first pass at a fix. But his fix was only partial and only
> worked on the Quark CPUs.  It would not, for instance, have worked on
> the QEMU config.
> 
> 1. https://raw.githubusercontent.com/InstLatx64/InstLatx64/master/GenuineIntel/GenuineIntel0000590_Clanton_03_CPUID.txt
> 2. You can also get this behavior if you use "-cpu 486,+clzero"
>    in QEMU.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(as this obviously fixes the issue as it makes a partial revert of the culprit
 change).

-- 
With Best Regards,
Andy Shevchenko



