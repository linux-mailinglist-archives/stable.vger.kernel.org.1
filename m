Return-Path: <stable+bounces-148111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F98AC81C4
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 19:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391241BC51EE
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6222D4EF;
	Thu, 29 May 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3ybn94Y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AFB67F;
	Thu, 29 May 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748540426; cv=none; b=qs6a0to/uAucMnAzL4HHfVLG9wsd+XsmMq3GuavK0zAKkQ+oV5TlzqhYduTBmZKvpToWCmN9pLZKKpjG/WRl5lBfYCEaroNJyCysw5o7TnedzkGaOY20uFPkcrr1WStooUs9pPkdTimOuUaOMoQWL2Id1C/Vbenw6vk3UeeQSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748540426; c=relaxed/simple;
	bh=CTuAedKq0U54g+MH81XEGkmCLAnq8aSybpfDBpJIdQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN0+4jRZutimTPsv7Av5swjUI0AMGbxh/0Z02I2cfuy4kND+rq6Y9eN7f4ZzvamfKjFSgcOp/+bOLB/CIZ+8/QTTYI45GelCcZPTrs9bPhW3ud7BKT5XEZEwC9vwnYWCRKcjOLCLNNcZA9cIXpovfoYtRZ629ic2ilJu4fW5/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3ybn94Y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748540424; x=1780076424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CTuAedKq0U54g+MH81XEGkmCLAnq8aSybpfDBpJIdQ4=;
  b=a3ybn94YriLPw0naUJlYW/EuPXmhAzMubVHvb57TCP/4i7YJJro2FDW/
   kuLFn73hsn9Z4m01FznfObucT6hA95teb6ixGiWYuG57If8TOxM1Q9Go9
   6zHwQtxKdjlynOifE3ppL+Hk8ARuKU5aA+pp4OkoJezQWz/Qi3TaFFWEj
   fKDZ6+jXzTbMsNfeCsCdKDUhU3LMEiEfzlwSEDHeCAUpKxD3+EZwPbp7W
   JWk+hLxJgeJIc3ZuDwOG8496UbZCp4UbVoWzDiyq4wHJS+qh8hSZNQ9WN
   R8awft4+mepUmPU1SRwO8hANqDMgHHGBX+J5HgYo1as7ZVz8bjQVzrIiC
   w==;
X-CSE-ConnectionGUID: ipejCPvORiqXHvYEznl2sA==
X-CSE-MsgGUID: UNtPL2HzQB2LTrbbKbgXGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="61963929"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="61963929"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 10:40:23 -0700
X-CSE-ConnectionGUID: OvceDlaHQH6JgxsUOXFn1A==
X-CSE-MsgGUID: 3iC4sBmBRcyPk8AEgUMAGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="174628041"
Received: from chandhni-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.31])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 10:40:23 -0700
Date: Thu, 29 May 2025 10:40:17 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Richard Narron <richard@aaazen.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux stable <stable@vger.kernel.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
Message-ID: <20250529174017.lwctaondsbg7tk37@desk>
References: <20250520125753.836407405@linuxfoundation.org>
 <0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net>
 <67f03e41-245e-202-f0df-687cc4d9a915@aaazen.com>
 <20250528005520.dpip4qe45zvsn7vw@desk>
 <b8a9acaf-3d3e-7931-23ce-d61ee77b4e10@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a9acaf-3d3e-7931-23ce-d61ee77b4e10@aaazen.com>

On Wed, May 28, 2025 at 09:49:40PM -0700, Richard Narron wrote:
> On Tue, 27 May 2025, Pawan Gupta wrote:
> 
> > On Tue, May 27, 2025 at 12:31:47PM -0700, Richard Narron wrote:
> > > On Fri, 23 May 2025, Guenter Roeck wrote:
> > >
> > > > On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 5.15.184 release.
> > > > > There are 59 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> > > > > Anything received after that time might be too late.
> > > > >
> > > >
> > > > Build reference: v5.15.184
> > > > Compiler version: x86_64-linux-gcc (GCC) 12.4.0
> > > > Assembler version: GNU assembler (GNU Binutils) 2.40
> > > >
> > > > Configuration file workarounds:
> > > >     "s/CONFIG_FRAME_WARN=.*/CONFIG_FRAME_WARN=0/"
> > > >
> > > > Building i386:defconfig ... passed
> > > > Building i386:allyesconfig ... failed
> > > > --------------
> > > > Error log:
> > > > x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> > > > `__static_call_transform':
> > > > static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > > > make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> > > > --------------
> > > > Building i386:allmodconfig ... failed
> > > > --------------
> > > > Error log:
> > > > x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> > > > `__static_call_transform':
> > > > static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > > > make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> > > > --------------
> > > >
> > > > In v5.15.y, cpu_wants_rethunk_at is only built if CONFIG_STACK_VALIDATION=y,
> > > > but that is not supported for i386 builds. The dummy function in
> > > > arch/x86/include/asm/alternative.h doesn't take that dependency into account.
> > > >
> > >
> > > I found this bug too using the Slackware 15.0 32-bit kernel
> > > configuration.
> > >
> > > Here is a simple work around patch, but there may be a better solution...
> > >
> > > --- arch/x86/kernel/static_call.c.orig	2025-05-22 05:08:28.000000000 -0700
> > > +++ arch/x86/kernel/static_call.c	2025-05-27 10:25:27.630496538 -0700
> > > @@ -81,9 +81,12 @@
> > >  		break;
> > >
> > >  	case RET:
> > > +
> > > +#ifdef CONFIG_64BIT
> > >  		if (cpu_wants_rethunk_at(insn))
> > >  			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
> > >  		else
> > > +#endif
> > >  			code = &retinsn;
> > >  		break;
> > >
> >
> > Another option is to define the empty function when CONFIG_STACK_VALIDATION=n as below:
> >
> > --- 8< ---
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Subject: [PATCH] x86/its: Fix undefined reference to cpu_wants_rethunk_at()
> >
> > Below error was reported in 32-bit kernel build:
> >
> >   static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> >   make[1]: [Makefile:1234: vmlinux] Error
> >
> > This is because the definition of cpu_wants_rethunk_at() depends on
> > CONFIG_STACK_VALIDATION which is only enabled in 64-bit mode.
> >
> > Define the empty function when CONFIG_STACK_VALIDATION=n, rethunk mitigation
> > is anyways not supported without it.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lore.kernel.org/stable/0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net/
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  arch/x86/include/asm/alternative.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> > index 1797f80c10de..a5f704dbb4a1 100644
> > --- a/arch/x86/include/asm/alternative.h
> > +++ b/arch/x86/include/asm/alternative.h
> > @@ -98,7 +98,7 @@ static inline u8 *its_static_thunk(int reg)
> >  }
> >  #endif
> >
> > -#ifdef CONFIG_RETHUNK
> > +#if defined(CONFIG_RETHUNK) && defined(CONFIG_STACK_VALIDATION)
> >  extern bool cpu_wants_rethunk(void);
> >  extern bool cpu_wants_rethunk_at(void *addr);
> >  #else
> > --
> > 2.34.1
> >
> 
> Thanks for looking at this Pawan.
> 
> Your new patch works fine on both Slackware 15.0 32-bit and 64-bit
> systems.

Thank you for verifying the patch.

