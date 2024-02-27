Return-Path: <stable+bounces-23840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE5868ABF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4392881D7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4964CD0;
	Tue, 27 Feb 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGDjJS8W"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76C63130
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022479; cv=none; b=WHWknbEHwA5cW6S/+8MFTe3rUJmO6pdaMSjx2Nk4aHpSEIrN9PSq2+r3NAZtfwtf1Knr+99mXKibZhe8kDp6Dw9hvl6WMUZhotUkkolCK51bJfRFA6I3/qi40eSXacymWPPny4tKiEw2HAKP723BwBdh5X3SxbZamBob1YwE0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022479; c=relaxed/simple;
	bh=VNxRXNo8a+y7Y4UPl02rbwN8NKglfDAdXaaJJ/4Ajho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6WUl0+evPyvqHAKWz1MGHRE4U1FmqJFxjLGJ8KUwBnCMrlm7dNG23m8U9x1q/BKJPjXJEO0AhmM2S259pxuRlfUdUEkZJbENfZ26uc9li4T01vAuJxwY1xqVLX73hxYL7OIao8ycus8ydK78FK7t4iibjzUG13pRIZdiRTRezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGDjJS8W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709022478; x=1740558478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VNxRXNo8a+y7Y4UPl02rbwN8NKglfDAdXaaJJ/4Ajho=;
  b=KGDjJS8WcdR1r57daRtnG8biAjSAMly+rMehoiF6lUloF7EAaYR+Ur8x
   yvjWkjmA9vQaLO8obqjvz/4W2uQyL7Qv+OkIQCoiyyWri3sYG1z/YAzKH
   pQ36L/f6va0ESmC0NJltznSlEf2ilaEhN+VXVCbr2famfbHIkqWu9ACah
   cNxp+phKuLWHvCweZHDK1kXxFgXwx2nqUi7eUnu83PEcevYWSA1b7+x/1
   o1OiyqXYN04TvC07/ovWrTtTIm0QwFVwgPzSeMJcfgTvV+be2LPNMn4Zb
   djwIVUPud+a60AdjMEK5LyrIT+yuwDmN8V3VLhONN+cqnDN8tyiJfRlBB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3212289"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3212289"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="44457846"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:27:58 -0800
Date: Tue, 27 Feb 2024 00:27:55 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.7.y 1/6] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20240227082755.yl7ny34o33uotqww@desk>
References: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>
 <20240226-delay-verw-backport-6-7-y-v1-1-ab25f643173b@linux.intel.com>
 <c9ede8e2-5066-435b-bd1d-1971a8072952@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ede8e2-5066-435b-bd1d-1971a8072952@kernel.org>

On Tue, Feb 27, 2024 at 08:40:26AM +0100, Jiri Slaby wrote:
> On 27. 02. 24, 6:00, Pawan Gupta wrote:
> > commit baf8361e54550a48a7087b603313ad013cc13386 upstream.
> > 
> > MDS mitigation requires clearing the CPU buffers before returning to
> > user. This needs to be done late in the exit-to-user path. Current
> > location of VERW leaves a possibility of kernel data ending up in CPU
> > buffers for memory accesses done after VERW such as:
> > 
> >    1. Kernel data accessed by an NMI between VERW and return-to-user can
> >       remain in CPU buffers since NMI returning to kernel does not
> >       execute VERW to clear CPU buffers.
> >    2. Alyssa reported that after VERW is executed,
> >       CONFIG_GCC_PLUGIN_STACKLEAK=y scrubs the stack used by a system
> >       call. Memory accesses during stack scrubbing can move kernel stack
> >       contents into CPU buffers.
> >    3. When caller saved registers are restored after a return from
> >       function executing VERW, the kernel stack accesses can remain in
> >       CPU buffers(since they occur after VERW).
> > 
> > To fix this VERW needs to be moved very late in exit-to-user path.
> > 
> > In preparation for moving VERW to entry/exit asm code, create macros
> > that can be used in asm. Also make VERW patching depend on a new feature
> > flag X86_FEATURE_CLEAR_CPU_BUF.
> ...
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -315,6 +315,17 @@
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
> Why is not rip-relative preserved here?

Because Nikolay reported that it was creating a problem for backports on
kernels that don't support relocations in alternatives. More on this
here:

  https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/

Also, RIP-relative addressing was a requirement only for the initial
versions of the series, where the VERW operand was pointing within the
macro. For performance gains, later versions switched to the
implementation in which all VERW sites were pointing to single memory
location. With that, RIP-relative addressing could be droped in favor of
fixed addresses.

> Will this work at all (it looks like verw would now touch random
> memory)?

AFAIK, all memory operand variants of VERW have the CPU buffer clearing
behavior. I will confirm this with the CPU architects.

> In any way, should you do any changes during the backport, you shall
> document that.

Sorry, I missed to mention this change in 6.7.y backport. I did include
this info in the other backports I sent:

  https://lore.kernel.org/stable/20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com/T/
  https://lore.kernel.org/stable/20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com/T/

