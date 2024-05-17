Return-Path: <stable+bounces-45398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA38C876E
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 15:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E1282406
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8054BFD;
	Fri, 17 May 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ia/4QcC2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D975491A;
	Fri, 17 May 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953716; cv=none; b=H3LURNWfBbouSZxnyrBezg5yRpx4BkXTWgA9/6HJ0sWXP8TfvPo2zRC1/BDvO0nbylWfhsLHQbIMekmObla5EtkrHFik8rha7rxWA3x0NS/XHLEfcly38QckSU/i1UtIWrUbJibJnlWyFRLl3bZLwYa87pf1NhJ/JGuABg2wVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953716; c=relaxed/simple;
	bh=s93ATeDVRQTEUX7ypkN+F/Ibrc7HgOQIkHgV3WSgzNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzXe/1JXrKVOe6BGrHIl8y6X/pX3ccVrX81kTZeE7D4XJdAu4u+2HXNhTWfHPvbpenoNZj6quLyUO9r4qLa0QNpdakNlRPdq7YkRNkCfl+4k/jDiZLRtIZKJrQOQNZEx9t42iBpWtse2n8YZlUultOX9hcuRdRLo5UpDcoAJKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ia/4QcC2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715953715; x=1747489715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s93ATeDVRQTEUX7ypkN+F/Ibrc7HgOQIkHgV3WSgzNQ=;
  b=ia/4QcC2HdaNJd8sZdOiTX4c1XP9B5kjacgxfoc/zIhe6sI1pa7rAZ6b
   uTQPLU4n8OmcvbESbf0KEqIHUyL985lseo+FO2aot1GwzsxIxr8mtgyO/
   5KFei+UILq0890SKwkNQNrUxMfOKQNx0uAQUfcI/swnIcf7rq2L5mjkkz
   hq4KRGtF2yqipGZJVbdhlKPxm+X1KSGHO4bPmFc1TLsKP2jlwCXlxnBSI
   QS9lrmFDteLyS2o0k+aK1VqQ7HCZUREuKL4tq1YkeJr3KLpeIlsexFmkd
   aoLMQQf+VSPqNq5FZI8M6J6W+uNlmwJ0jzqybPOj6GvPWsfTXWJBLDWBP
   g==;
X-CSE-ConnectionGUID: GvSEZaFMTIGtuBhDG19SFA==
X-CSE-MsgGUID: 2DQ7RC2cR6aiUd8z/NS6xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="29647282"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="29647282"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:48:34 -0700
X-CSE-ConnectionGUID: nLI3sxIGQmqHciyW5bgI9A==
X-CSE-MsgGUID: HxKfErc+RX64gcA27homYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31786507"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:48:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7xwi-00000008Lyl-3UwN;
	Fri, 17 May 2024 16:48:28 +0300
Date: Fri, 17 May 2024 16:48:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Adam Dunlap <acdunlap@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86/cpu: Fix boot on Intel Quark X1000
Message-ID: <ZkdgLI8PGutkQGKK@smile.fi.intel.com>
References: <20240516173928.3960193-1-andriy.shevchenko@linux.intel.com>
 <8286f8b9-488c-418f-8bad-d23871a8afab@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8286f8b9-488c-418f-8bad-d23871a8afab@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 16, 2024 at 11:21:13AM -0700, Dave Hansen wrote:
> On 5/16/24 10:39, Andy Shevchenko wrote:
> > The initial change to set x86_virt_bits to the correct value straight
> > away broke boot on Intel Quark X1000 CPUs (which are family 5, model 9,
> > stepping 0)
> 
> Do you know what _actually_ broke?  Like was there a crash somewhere?

Nope, I have no a single character to tell anything about this.
Note, earlyprintk may not be helpful as this SoC doesn't have legacy UARTs.

> > With deeper investigation it appears that the Quark doesn't have
> > the bit 19 set in 0x01 CPUID leaf, which means it doesn't provide
> > any clflush instructions and hence the cache alignment is set to 0.
> > The actual cache line size is 16 bytes, hence we may set the alignment
> > accordingly. At the same time the physical and virtual address bits
> > are retrieved via 0x80000008 CPUID leaf.
> 
> This seems to be saying that ->x86_clflush_size must come from CPUID.
> But there _are_ CPUID-independent defaults set in identify_cpu().  How
> do those fit in?

Where? The mentioned fbf6449f84bf dropped those for this case.

> > Note, we don't really care about the value of x86_clflush_size as it
> > is either used with a proper check for the instruction to be present,
> > or, like in PCI case, it assumes 32 bytes for all supported 32-bit CPUs
> > that have actually smaller cache line sizes and don't advertise it.
> 
> Are you trying to say that having ->x86_clflush_size==0 is not fatal
> while having ->x86_cache_alignment==0 _is_ fatal?

I'm only saying that clflush is not implemented there and having
a dangled value is not a problem.

But it indeed implies what you are saying.

> > The commit fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct
> > value straight away, instead of a two-phase approach") basically
> > revealed the issue that has been present from day 1 of introducing
> > the Quark support.
> 
> How did it do that, exactly?  It's still not crystal clear.

See above, it removes, like you said, the CPUID independent defaults which
were set unconditionally and implied that cache alignment should come from
CPUID (clflush bits).

...

> > +	/*
> > +	 * The Quark doesn't have bit 19 set in 0x01 CPUID leaf, which means
> > +	 * it doesn't provide any clflush instructions and hence the cache
> > +	 * alignment is set to 0. The actual cache line size is 16 bytes,
> > +	 * hence set the alignment accordingly. At the same time the physical
> > +	 * and virtual address bits are retrieved via 0x80000008 CPUID leaf.
> > +	 */
> > +	if (c->x86 == 5 && c->x86_model == 9)
> > +		c->x86_cache_alignment = 16;
> 
> What are the odds that another CPU has this issue?

I'm not sure I follow.

> I'm thinking we should just set a default in addition to hacking around this
> for Quark.

-- 
With Best Regards,
Andy Shevchenko



