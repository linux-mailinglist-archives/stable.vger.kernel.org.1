Return-Path: <stable+bounces-148052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B99AC7753
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 06:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791DB1C03CF2
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 04:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFA9252288;
	Thu, 29 May 2025 04:49:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D441A2643;
	Thu, 29 May 2025 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748494189; cv=none; b=oAU0l3vy9Ys5jzO+eLfvGE9d4RTdp7jFdT+kQsE8NAw6uqlQ5s3mrtYVSmPLNNAFnNmH0yKxdifnwdB2Q3V5plFp/PGOcyeKgJMbAjkZl4s/dibgaoyxv8RFnvncGBaMlcpmLfeZ6ONAHNVX3ooGPvdPaRzFsQvO9QzQcZLTQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748494189; c=relaxed/simple;
	bh=vXoHgD2spVyw9syIdi/Knpz2uIGNMnz0/ZStU6iAVms=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cvL+hJ0lQvbr3QFNRDtcxi2cvrIoVDGNS8yPKrBoCZc4uYg3w1ORusP09clm78jF4l9fPnlayN2AUhOiJ2+hK/8mo6F7SPPi3S5VTIfpS4P1U+opS80LBmapszM7wOuuRMbpnHQeWNE/IwhaFZ5x9TfcvoaZQyp5uCSYBWpKdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 34c1c53c;
	Wed, 28 May 2025 21:49:40 -0700 (PDT)
Date: Wed, 28 May 2025 21:49:40 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
cc: Guenter Roeck <linux@roeck-us.net>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Linux stable <stable@vger.kernel.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
In-Reply-To: <20250528005520.dpip4qe45zvsn7vw@desk>
Message-ID: <b8a9acaf-3d3e-7931-23ce-d61ee77b4e10@aaazen.com>
References: <20250520125753.836407405@linuxfoundation.org> <0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net> <67f03e41-245e-202-f0df-687cc4d9a915@aaazen.com> <20250528005520.dpip4qe45zvsn7vw@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 May 2025, Pawan Gupta wrote:

> On Tue, May 27, 2025 at 12:31:47PM -0700, Richard Narron wrote:
> > On Fri, 23 May 2025, Guenter Roeck wrote:
> >
> > > On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.184 release.
> > > > There are 59 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > >
> > > Build reference: v5.15.184
> > > Compiler version: x86_64-linux-gcc (GCC) 12.4.0
> > > Assembler version: GNU assembler (GNU Binutils) 2.40
> > >
> > > Configuration file workarounds:
> > >     "s/CONFIG_FRAME_WARN=.*/CONFIG_FRAME_WARN=0/"
> > >
> > > Building i386:defconfig ... passed
> > > Building i386:allyesconfig ... failed
> > > --------------
> > > Error log:
> > > x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> > > `__static_call_transform':
> > > static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > > make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> > > --------------
> > > Building i386:allmodconfig ... failed
> > > --------------
> > > Error log:
> > > x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> > > `__static_call_transform':
> > > static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > > make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> > > --------------
> > >
> > > In v5.15.y, cpu_wants_rethunk_at is only built if CONFIG_STACK_VALIDATION=y,
> > > but that is not supported for i386 builds. The dummy function in
> > > arch/x86/include/asm/alternative.h doesn't take that dependency into account.
> > >
> >
> > I found this bug too using the Slackware 15.0 32-bit kernel
> > configuration.
> >
> > Here is a simple work around patch, but there may be a better solution...
> >
> > --- arch/x86/kernel/static_call.c.orig	2025-05-22 05:08:28.000000000 -0700
> > +++ arch/x86/kernel/static_call.c	2025-05-27 10:25:27.630496538 -0700
> > @@ -81,9 +81,12 @@
> >  		break;
> >
> >  	case RET:
> > +
> > +#ifdef CONFIG_64BIT
> >  		if (cpu_wants_rethunk_at(insn))
> >  			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
> >  		else
> > +#endif
> >  			code = &retinsn;
> >  		break;
> >
>
> Another option is to define the empty function when CONFIG_STACK_VALIDATION=n as below:
>
> --- 8< ---
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Subject: [PATCH] x86/its: Fix undefined reference to cpu_wants_rethunk_at()
>
> Below error was reported in 32-bit kernel build:
>
>   static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
>   make[1]: [Makefile:1234: vmlinux] Error
>
> This is because the definition of cpu_wants_rethunk_at() depends on
> CONFIG_STACK_VALIDATION which is only enabled in 64-bit mode.
>
> Define the empty function when CONFIG_STACK_VALIDATION=n, rethunk mitigation
> is anyways not supported without it.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/stable/0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net/
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/include/asm/alternative.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 1797f80c10de..a5f704dbb4a1 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -98,7 +98,7 @@ static inline u8 *its_static_thunk(int reg)
>  }
>  #endif
>
> -#ifdef CONFIG_RETHUNK
> +#if defined(CONFIG_RETHUNK) && defined(CONFIG_STACK_VALIDATION)
>  extern bool cpu_wants_rethunk(void);
>  extern bool cpu_wants_rethunk_at(void *addr);
>  #else
> --
> 2.34.1
>

Thanks for looking at this Pawan.

Your new patch works fine on both Slackware 15.0 32-bit and 64-bit
systems.


