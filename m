Return-Path: <stable+bounces-23841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F058868AC5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB43B2171E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446264AB6;
	Tue, 27 Feb 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AE6jCo44"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A11BC27
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022601; cv=none; b=IyS1OpxLH8t2Xbg0D87sYF+fIbYoDZ60NyEItpcguItFNNO4AITdvyqZVQ4ndtWCgrhDar5zqnVcwJgQrO7yohuXgNJ1ZVIvm852wjTU1hbHdBBTcMkmEp32TLcEAUEQ1G+Cp2CdbrA0iQbwa6ofxTCxVVA74jyyD3Dou9slMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022601; c=relaxed/simple;
	bh=rPRuiJiP5JF3BU23PdrgXuVNvo4R7wVK5iYwOTPfT3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQRdJkX4U11sGsGMNn/vKLB8oYQytJHkfmOGEirzY98eWPfwzPArRgmyr01Cjb3hVPVZYv68gYuSp/XA4d9QkVfiRLhOQfoBPckC9JQo2WxN2HKLJJalfwP+A4PmkgFWqHmaExxBVWT9Bk9AsFVif3vhzaEDmMWzgF3PMspIWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AE6jCo44; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709022600; x=1740558600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rPRuiJiP5JF3BU23PdrgXuVNvo4R7wVK5iYwOTPfT3o=;
  b=AE6jCo44Kv+5cLET32RV/p+1dsxOylBDdWGNProxvOuYLnC9YlSw6JAR
   iHsqDYqzVL3rDGN6wdOcZLlZnbD/i1KNZHLqZwZ/fEKM38Akc4/K+adq3
   Kalw2KXOq1P+rQfBWW2BBfgKtrC/f7VIeeedlfJiQS+STaDNQsN/CHKmb
   ySWvZoWq831mZxKrdFXGum8sgCPGe9S2OavCiFeu8NiV6J51UJw0B5eqF
   F2QNC3Ysf3QPQ3n6WXT7QJ3ZAGpYI9U4TZeOLuLxPSB/IKR77FdE3KE7P
   uRQeEyfvkaWPV745hDHwSppCIP/eqQqQ/wV/1EP16q872G14Iv17KEoMI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20895330"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="20895330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7313009"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:29:15 -0800
Date: Tue, 27 Feb 2024 00:29:13 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.7.y 1/6] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20240227082913.3qenqigux7hikunt@desk>
References: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>
 <20240226-delay-verw-backport-6-7-y-v1-1-ab25f643173b@linux.intel.com>
 <c9ede8e2-5066-435b-bd1d-1971a8072952@kernel.org>
 <2024022716-dormitory-breeches-574a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022716-dormitory-breeches-574a@gregkh>

On Tue, Feb 27, 2024 at 08:47:46AM +0100, Greg KH wrote:
> On Tue, Feb 27, 2024 at 08:40:26AM +0100, Jiri Slaby wrote:
> > On 27. 02. 24, 6:00, Pawan Gupta wrote:
> > > commit baf8361e54550a48a7087b603313ad013cc13386 upstream.
> > > 
> > > MDS mitigation requires clearing the CPU buffers before returning to
> > > user. This needs to be done late in the exit-to-user path. Current
> > > location of VERW leaves a possibility of kernel data ending up in CPU
> > > buffers for memory accesses done after VERW such as:
> > > 
> > >    1. Kernel data accessed by an NMI between VERW and return-to-user can
> > >       remain in CPU buffers since NMI returning to kernel does not
> > >       execute VERW to clear CPU buffers.
> > >    2. Alyssa reported that after VERW is executed,
> > >       CONFIG_GCC_PLUGIN_STACKLEAK=y scrubs the stack used by a system
> > >       call. Memory accesses during stack scrubbing can move kernel stack
> > >       contents into CPU buffers.
> > >    3. When caller saved registers are restored after a return from
> > >       function executing VERW, the kernel stack accesses can remain in
> > >       CPU buffers(since they occur after VERW).
> > > 
> > > To fix this VERW needs to be moved very late in exit-to-user path.
> > > 
> > > In preparation for moving VERW to entry/exit asm code, create macros
> > > that can be used in asm. Also make VERW patching depend on a new feature
> > > flag X86_FEATURE_CLEAR_CPU_BUF.
> > ...
> > > --- a/arch/x86/include/asm/nospec-branch.h
> > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > @@ -315,6 +315,17 @@
> > >   #endif
> > >   .endm
> > > +/*
> > > + * Macro to execute VERW instruction that mitigate transient data sampling
> > > + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> > > + *
> > > + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> > > + */
> > > +.macro CLEAR_CPU_BUFFERS
> > > +	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
> > 
> > Why is not rip-relative preserved here? Will this work at all (it looks like
> > verw would now touch random memory)?
> > 
> > In any way, should you do any changes during the backport, you shall
> > document that.
> 
> s/shall/MUST/

Noted.

