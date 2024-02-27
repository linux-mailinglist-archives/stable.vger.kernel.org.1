Return-Path: <stable+bounces-23843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A5868AEA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE26280F93
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6312FB34;
	Tue, 27 Feb 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8/Scr+i"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9F537F4
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023263; cv=none; b=u7LT+LBhAr4dheHQloxzxNnoEgJMgD0J9RkynxRbAo+2mKQ94ZrOtKx+MGW6j5TytTNFl/hCC4C6vb/kp4oXxND82Ko70wJRJAxABXsyd3CCF7q0Agn0ICfIAUw6uAFR9t94KR2GHbCpUfw69r5uMIZJkdT0jE2sER0G4vVor74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023263; c=relaxed/simple;
	bh=O5aqhj3lLTxKFQJG0TKeGqG03PBoRs/Mlpf2Bh5LqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HViJgvKEzJ5xfBRJPxDGkyJqnDt7nRloa29Y7HF0pDThfuFzjZYaFTsL2w06JwrVyZPHvuEpNEXLCJqq+YuGdJjgh3T35SP1oTpSypHt2rLiqOPYtoBbpF70ajq/Bbw5trRst5L80hoO2lB2wvIiyh1Is0XgcMXufmPFpmBlvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8/Scr+i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709023262; x=1740559262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O5aqhj3lLTxKFQJG0TKeGqG03PBoRs/Mlpf2Bh5LqJc=;
  b=Z8/Scr+iKLE7rwLVgkIfre5E9cR2ZKa2RlRKeyx8KCrB0xVO739socUw
   Uyvh/yT8lhQLp/DGM7sE9vL8ScMXuF4v30Vbdkwra9EVdX+a8SOV5X3pm
   lkaeWtsBgInT3+5TzQdQUxg26CPrPgH+mKOx5IInTnH1V824HyhnZbpFW
   rUjrmvSIGn/Sdfj32+McWk0iPuLl69AzOi5JPbpmBwuACi9yujE/oUMqc
   rOynvJvUqg2Obn25n4EqCCQHVsnCyZ5iA3bgGvna+UlJAWVbeRSKVNzoR
   DqD6Feqm6yK+mSGY2xuGfy2KUJOMOJ21hBPtezS9RB7inud9lHs1aDCjY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3469083"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3469083"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:41:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7172351"
Received: from akonar-mobl.amr.corp.intel.com (HELO desk) ([10.209.73.210])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:41:00 -0800
Date: Tue, 27 Feb 2024 00:40:58 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.1.y 1/6] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20240227084058.6wxdwzhr5sb34rhm@desk>
References: <20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com>
 <20240226-delay-verw-backport-6-1-y-v1-1-b3a2c5b9b0cb@linux.intel.com>
 <5a289118-f6d2-4471-b833-1565fd51cbdd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a289118-f6d2-4471-b833-1565fd51cbdd@kernel.org>

On Tue, Feb 27, 2024 at 09:19:13AM +0100, Jiri Slaby wrote:
> On 27. 02. 24, 9:00, Pawan Gupta wrote:
> > commit baf8361e54550a48a7087b603313ad013cc13386 upstream.
> ...
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -194,6 +194,17 @@
> >   #endif
> >   .endm
> > +/*
> > + * Macro to execute VERW instruction that mitigate transient data sampling
> > + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> > + *
> > + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> > + */
> > +.macro CLEAR_CPU_BUFFERS
> > +	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
> 
> The same here. Except 6.1 (I didn't check stable-6.1) does not have:
> commit 270a69c4485d7d07516d058bcc0473c90ee22185
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Wed Feb 8 18:10:52 2023 +0100
> 
>     x86/alternative: Support relocations in alternatives
> 
> yet. You likely need to backport that too.

I will backport this patch too if rip-relative turns out to be a must.
At this point, I am not sure if VERW buffer clearing behavior will be
impacted by fixed addressing.

