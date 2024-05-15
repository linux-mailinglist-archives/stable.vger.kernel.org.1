Return-Path: <stable+bounces-45154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8B8C63B0
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 11:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D771A1C221BA
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3358ADD;
	Wed, 15 May 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNef67uq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921558AC3;
	Wed, 15 May 2024 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765462; cv=none; b=sOPLazdOCBr3x76W+ooC/bOp+1kQeOVjdASq4PhCYnEBKtqHap00ZRj1005hTkNTzOJfK3/HF3a4RVOCEO84BXDOR1QW42DbgGbkBOXyzX1PcmR+xaczESGWQFwVK1pP2cLsps4GCHWi6sn8L6IKNS88MEexq66LjmsHr6help4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765462; c=relaxed/simple;
	bh=x0WiLqGSoZ3LIOEaEn9qtWswtKOTZTI/9ZmHSmH3WiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMDPeN/X7JC12Wlte9wxybVxx5WgFZKhYmWEX4D1c6QgNP3q1XBR10Xg1yHscXu5uoRGyvO3ndpChapw4cLnucUIck3FSF66wyY64+HjKfKJtOum53SkOaPRqoV8fGXRg5qAoaNAuV/VrgUn+aotuB56CR0IQpI+X+tBCT9r80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNef67uq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715765461; x=1747301461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x0WiLqGSoZ3LIOEaEn9qtWswtKOTZTI/9ZmHSmH3WiA=;
  b=NNef67uqwRctz1IzaiLdjyzjK3pa72EbfGsoLR+JBTgSs6owD28UW4/v
   15t3blYy0696ApdaqgnkL5V0Q8CRkIj0zN6OIwmltbeubGBdfT3vTsEiU
   w7bAqippbw+UAhvkXO2fxNjareen0OwoAXUkXdKMtaQkRBpYoqXAoYxlC
   UQdE0L8MzwG/APy295olbapZ71CUQuNj25sAEM/fHmhHLx+VPmqffUemH
   Amz3qhAVHPZBZmrt12VUwWWBISL/8GGqd6V9ahyvctAd+5S1sgyTzcQBY
   EiuCcVqPutgn2xkbj140HsEBBYe1ByJmKV2WYnYACoDAL3Hk4lj6KsrX5
   Q==;
X-CSE-ConnectionGUID: w5G1RsEHQmGKy7BVRFANdQ==
X-CSE-MsgGUID: ihwy01NbS4CvNsdl5bBJVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22386718"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="22386718"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 02:31:00 -0700
X-CSE-ConnectionGUID: rmsMv8BmTx6TfL6MlANqLg==
X-CSE-MsgGUID: BeMOF8duQBW8pYVgEsaE4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31078044"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 15 May 2024 02:30:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 95B0F327; Wed, 15 May 2024 12:30:56 +0300 (EEST)
Date: Wed, 15 May 2024 12:30:56 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv4 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
Message-ID: <hlif565xmuj4oqdpap3boizepwg5ch3dssb67zzvy7i7smzp3n@x6hzdyc2qk4y>
References: <20240512122154.2655269-1-kirill.shutemov@linux.intel.com>
 <20240512122154.2655269-4-kirill.shutemov@linux.intel.com>
 <4019eff6-18a9-49b2-9567-096cdb498fb0@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4019eff6-18a9-49b2-9567-096cdb498fb0@suse.com>

On Tue, May 14, 2024 at 05:56:21PM +0300, Nikolay Borisov wrote:
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 1ff571cb9177..ba37f4306f4e 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
> >   		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
> >   }
> > +/* Read TD-scoped metadata */
> > +static inline u64 tdg_vm_rd(u64 field, u64 *value)
> > +{
> > +	struct tdx_module_args args = {
> > +		.rdx = field,
> > +	};
> > +	u64 ret;
> > +
> > +	ret = __tdcall_ret(TDG_VM_RD, &args);
> > +	*value = args.r8;
> > +
> > +	return ret;
> > +}
> 
> nit: Perhaps this function can be put in the first patch and the description
> there be made more generic, something along the lines of "introduce
> functions for tdg_rd/tdg_wr" ?

A static function without an user will generate a build warning. I don't
think it is good idea.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

