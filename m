Return-Path: <stable+bounces-76948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF8983B43
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 04:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3A7B2251F
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829CC8EB;
	Tue, 24 Sep 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0ItYPpy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9FC8CE;
	Tue, 24 Sep 2024 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727145616; cv=none; b=QWEmwfXcydOsEDtR2tE+nhxqysZf/g9LiQySG9FRLpqc5QVBU7zUlS5ylYQF7eV2+rYFwL0zTpowEkbWFXZJVgypwtBSa7U9qKKZCHri8uKSMb9XEg1a4d9R5csj51c9xbUy1+VcX9D3yDFRACNAccFBdINhlt5aaGjYlPy4AlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727145616; c=relaxed/simple;
	bh=AxIeSno/1DoU++XQOIvkR6IyM7d89vGa8e+sDw3eF1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqakfc4CJyA5shCLCN2XE+9U4+1hv6hEANqWnciFKO7KvINOja0IOPTUTlv3hWr7CLUzDQCohI1EmpuE7dQwIa2Cx7wzRrXWv9zzRcUcTkLUn4b71PYF7/8vCRnGWURFsGNpzMXR/4haX9TSaMFqrW62sj15FGCtZTPjXyzlN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0ItYPpy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727145615; x=1758681615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AxIeSno/1DoU++XQOIvkR6IyM7d89vGa8e+sDw3eF1g=;
  b=P0ItYPpyWPw5kG1QsCmzjvAw0EQ7pfbn5kpUJdCjjAMA4pSKeO0Cml+O
   B1vF25gvlhJ09tYfwdoOVrUmYi9oSiSZXYLs/wLFHvPT9ezEXgTd7Rgil
   pKSm4jDKdiKxHD7ie3gHbF69iZma+mYNVaEfh/4P/UHIIcra1VKJYqXJz
   GuiqhDYve0P0+kglpkfb5w/ETbl1ZG9RCBKBJIkxWlwkg0X6tEI0Ab2An
   6dyS8rUpUdTiJDdpOV9rZ92s0YwwdVOtSMKTotJqbTjTbXmRFXnNQseTn
   kIc3JgyyWNOJDTZrceF/bq88LZ1iGQPjS1g/rW8xAS4oxHHoPm0oDzIwM
   g==;
X-CSE-ConnectionGUID: aoapjH3tTFONNgf2+ZF4gA==
X-CSE-MsgGUID: DHUMkAZwRcCURcWzntHP9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29835816"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="29835816"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 19:40:14 -0700
X-CSE-ConnectionGUID: 7aoVqqMLRMutRrlIwUo6hg==
X-CSE-MsgGUID: 5yg3wsnDQOGGUZY47dBnjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="70857713"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 19:40:13 -0700
Date: Mon, 23 Sep 2024 19:45:51 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>,
	"regressions@leemhuis.info" <regressions@leemhuis.info>,
	"Neri, Ricardo" <ricardo.neri@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"Gupta, Pawan Kumar" <pawan.kumar.gupta@intel.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"thomas.lindroth@gmail.com" <thomas.lindroth@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Message-ID: <20240924024551.GA13538@ranerica-svr.sc.intel.com>
References: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
 <a79fa3cc-73ef-4546-b110-1f448480e3e6@leemhuis.info>
 <2024081217-putt-conform-4b53@gregkh>
 <05ced22b5b68e338795c8937abb8141d9fa188e6.camel@intel.com>
 <2024091900-unimpeded-catalyst-b09f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024091900-unimpeded-catalyst-b09f@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Sep 19, 2024 at 01:19:27PM +0200, gregkh@linuxfoundation.org wrote:
> On Wed, Sep 18, 2024 at 06:54:33AM +0000, Zhang, Rui wrote:
> > On Mon, 2024-08-12 at 14:11 +0200, Greg KH wrote:
> > > On Wed, Aug 07, 2024 at 10:15:23AM +0200, Thorsten Leemhuis wrote:
> > > > [CCing the x86 folks, Greg, and the regressions list]
> > > > 
> > > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > > > 
> > > > On 30.07.24 18:41, Thomas Lindroth wrote:
> > > > > I upgraded from kernel 6.1.94 to 6.1.99 on one of my machines and
> > > > > noticed that
> > > > > the dmesg line "Incomplete global flushes, disabling PCID" had
> > > > > disappeared from
> > > > > the log.
> > > > 
> > > > Thomas, thx for the report. FWIW, mainline developers like the x86
> > > > folks
> > > > or Tony are free to focus on mainline and leave stable/longterm
> > > > series
> > > > to other people -- some nevertheless help out regularly or
> > > > occasionally.
> > > > So with a bit of luck this mail will make one of them care enough
> > > > to
> > > > provide a 6.1 version of what you afaics called the "existing fix"
> > > > in
> > > > mainline (2eda374e883ad2 ("x86/mm: Switch to new Intel CPU model
> > > > defines") [v6.10-rc1]) that seems to be missing in 6.1.y. But if
> > > > not I
> > > > suspect it might be up to you to prepare and submit a 6.1.y variant
> > > > of
> > > > that fix, as you seem to care and are able to test the patch.
> > > 
> > > Needs to go to 6.6.y first, right?  But even then, it does not apply
> > > to
> > > 6.1.y cleanly, so someone needs to send a backported (and tested)
> > > series
> > > to us at stable@vger.kernel.org and we will be glad to queue them up
> > > then.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > There are three commits involved.
> > 
> > commit A:
> >    4db64279bc2b (""x86/cpu: Switch to new Intel CPU model defines"") 
> >    This commit replaces
> >       X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),             /* SNC */
> >    with
> >       X86_MATCH_VFM(INTEL_ANY,         1),    /* SNC */
> >    This is a functional change because the family info is replaced with
> > 0. And this exposes a x86_match_cpu() problem that it breaks when the
> > vendor/family/model/stepping/feature fields are all zeros.
> > 
> > commit B:
> >    93022482b294 ("x86/cpu: Fix x86_match_cpu() to match just
> > X86_VENDOR_INTEL")
> >    It addresses the x86_match_cpu() problem by introducing a valid flag
> > and set the flag in the Intel CPU model defines.
> >    This fixes commit A, but it actually breaks the x86_cpu_id
> > structures that are constructed without using the Intel CPU model
> > defines, like arch/x86/mm/init.c.
> > 
> > commit C:
> >    2eda374e883a ("x86/mm: Switch to new Intel CPU model defines")
> >    arch/x86/mm/init.c: broke by commit B but fixed by using the new
> > Intel CPU model defines
> > 
> > In 6.1.99,
> > commit A is missing
> > commit B is there
> > commit C is missing
> > 
> > In 6.6.50,
> > commit A is missing
> > commit B is there
> > commit C is missing
> > 
> > Now we can fix the problem in stable kernel, by converting
> > arch/x86/mm/init.c to use the CPU model defines (even the old style
> > ones). But before that, I'm wondering if we need to backport commit B
> > in 6.1 and 6.6 stable kernel because only commit A can expose this
> > problem.
> 
> If so, can you submit the needed backports for us to apply?  That's the
> easiest way for us to take them, thanks.

I audited all the uses of x86_match_cpu(match). All callers that construct
the `match` argument using the family of X86_MATCH_* macros from arch/x86/
include/asm/cpu_device_id.h function correctly because the commit B has
been backported to v6.1.99 and to v6.6.50 -- 93022482b294 ("x86/cpu: Fix
x86_match_cpu() to match just X86_VENDOR_INTEL").

Only those callers that use their own thing to compose the `match` argument
are buggy:
    * arch/x86/mm/init.c
    * drivers/powercap/intel_rapl_msr.c (only in 6.1.99)

Summarizing, v6.1.99 needs these two commits from mainline
    * d05b5e0baf42 ("powercap: RAPL: fix invalid initialization for
      pl4_supported field")
    * 2eda374e883a ("x86/mm: Switch to new Intel CPU model defines")

v6.6.50 only needs the second commit.

I will submit these backports.

Thanks and BR,
Ricardo

