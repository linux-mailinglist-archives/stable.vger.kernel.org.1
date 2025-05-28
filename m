Return-Path: <stable+bounces-147902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86452AC5E93
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 02:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E3C3A8FAA
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 00:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CAD14F104;
	Wed, 28 May 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHx0eK8N"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27A1862;
	Wed, 28 May 2025 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393735; cv=none; b=csbKzvyouYSlnSI2SAWML2cBKoFAhLlECp69W2DjbpCVJ5qnAy1y5uEpX91tCx2SdCNrolvbw0/2u9blyzcwE1BN6jWhRBrlG4e0BFLtoBhXtOIBJ5Eh6CUz2oOquAIEfWFzMe1L5Od2ZY/0AhpRU+q+cgIUH4lu3XJ5vgBYM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393735; c=relaxed/simple;
	bh=xhMTQgkewqj4hAWzEuXm8wFwVJIuDz5U3oNtAMSo+AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0uf+8Lp7e47s9Wl+WugnmvPBDXWFQLEEP3HungWQ6TuYW0sBUFBWrnJzB5R2+itaabsbafKGpablGsK6b3RQQd6fzstWaViobgdYJgppPp33Kn9bEMMhRF2RBwLSeRryAF5cZmpKjkSfN3m2TQ9xC9FzzjDItRc2RpBDK8MWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHx0eK8N; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748393734; x=1779929734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhMTQgkewqj4hAWzEuXm8wFwVJIuDz5U3oNtAMSo+AE=;
  b=cHx0eK8N5zeUzszNn4mBmwHO8ApYUKC/3cCjxdUGHKQuSW91/CeEnIum
   m/8tCTG3HQ58+uUGStqkRUGf3OXQr9DaYubaA6En7vbzr6O0aOuQcXNS7
   vYbA8i5MgNN9FPGv2vryUky6DyChT1w2XsnXX3ALniQvzHmHoHEBCPl8u
   OOxRXjFmC5OZn+980uuMRNostGYWa7PxPHHsl4yVFVebyzhHPo/WkSgUf
   hmYBybzbu0i+a+Cn/g/mqFEO0JgCmOLwIda/ywnJj/Nw1RSzS6kZ3EBBG
   jCL6KhCLLmpHz5HNGmT9CFYfaTy2hPFfppKth+x+l7JIsyF8NN95JYUtM
   g==;
X-CSE-ConnectionGUID: q8xo7aRqTaOVEbfYNTrcdg==
X-CSE-MsgGUID: /apA/Ik1R8mpS5OVLp8L8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50330214"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="50330214"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 17:55:33 -0700
X-CSE-ConnectionGUID: udApDBw6R16xWsCUAFlsCw==
X-CSE-MsgGUID: vU6BaKi5SQWbhuClCMpeGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="143021978"
Received: from bethpric-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 17:55:32 -0700
Date: Tue, 27 May 2025 17:55:20 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Richard Narron <richard@aaazen.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux stable <stable@vger.kernel.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
Message-ID: <20250528005520.dpip4qe45zvsn7vw@desk>
References: <20250520125753.836407405@linuxfoundation.org>
 <0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net>
 <67f03e41-245e-202-f0df-687cc4d9a915@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f03e41-245e-202-f0df-687cc4d9a915@aaazen.com>

On Tue, May 27, 2025 at 12:31:47PM -0700, Richard Narron wrote:
> On Fri, 23 May 2025, Guenter Roeck wrote:
> 
> > On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.15.184 release.
> > > There are 59 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> > > Anything received after that time might be too late.
> > >
> >
> > Build reference: v5.15.184
> > Compiler version: x86_64-linux-gcc (GCC) 12.4.0
> > Assembler version: GNU assembler (GNU Binutils) 2.40
> >
> > Configuration file workarounds:
> >     "s/CONFIG_FRAME_WARN=.*/CONFIG_FRAME_WARN=0/"
> >
> > Building i386:defconfig ... passed
> > Building i386:allyesconfig ... failed
> > --------------
> > Error log:
> > x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> > `__static_call_transform':
> > static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> > --------------
> > Building i386:allmodconfig ... failed
> > --------------
> > Error log:
> > x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> > `__static_call_transform':
> > static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> > --------------
> >
> > In v5.15.y, cpu_wants_rethunk_at is only built if CONFIG_STACK_VALIDATION=y,
> > but that is not supported for i386 builds. The dummy function in
> > arch/x86/include/asm/alternative.h doesn't take that dependency into account.
> >
> 
> I found this bug too using the Slackware 15.0 32-bit kernel
> configuration.
> 
> Here is a simple work around patch, but there may be a better solution...
> 
> --- arch/x86/kernel/static_call.c.orig	2025-05-22 05:08:28.000000000 -0700
> +++ arch/x86/kernel/static_call.c	2025-05-27 10:25:27.630496538 -0700
> @@ -81,9 +81,12 @@
>  		break;
> 
>  	case RET:
> +
> +#ifdef CONFIG_64BIT
>  		if (cpu_wants_rethunk_at(insn))
>  			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
>  		else
> +#endif
>  			code = &retinsn;
>  		break;
> 

Another option is to define the empty function when CONFIG_STACK_VALIDATION=n as below:

--- 8< ---
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH] x86/its: Fix undefined reference to cpu_wants_rethunk_at()

Below error was reported in 32-bit kernel build:

  static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
  make[1]: [Makefile:1234: vmlinux] Error

This is because the definition of cpu_wants_rethunk_at() depends on
CONFIG_STACK_VALIDATION which is only enabled in 64-bit mode.

Define the empty function when CONFIG_STACK_VALIDATION=n, rethunk mitigation
is anyways not supported without it.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/stable/0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net/
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 1797f80c10de..a5f704dbb4a1 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -98,7 +98,7 @@ static inline u8 *its_static_thunk(int reg)
 }
 #endif
 
-#ifdef CONFIG_RETHUNK
+#if defined(CONFIG_RETHUNK) && defined(CONFIG_STACK_VALIDATION)
 extern bool cpu_wants_rethunk(void);
 extern bool cpu_wants_rethunk_at(void *addr);
 #else
-- 
2.34.1


