Return-Path: <stable+bounces-148137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625AAC87C1
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 07:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627571BA59E9
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 05:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558531E8323;
	Fri, 30 May 2025 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wlCNc1dB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFDF1E572F;
	Fri, 30 May 2025 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748582034; cv=none; b=OLB5WsDmzWl2marI/kDV2iP4qk5RiMN2G9QoHE5tnIDjijHHLQGPa1nPsJubtL+JGuiJZ2+IsvC10/rc+GwBasQNdOn8A+r966d7+9SS3u57DghoIu3oFoam1+1S+I1C17qzJzHU+oaWQllCSs9335OKop36dag8TlFxJDqhkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748582034; c=relaxed/simple;
	bh=0a50+Hp19JQF0AMt+fssCSo2Xt5F5UE65SizAj0FMmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx7BmlAoGvy5EQ6HDZV4awOLi4anNveWE4Yhp5R63SGgCA5QdCru2aa2pw/8gUlF/VmhO35ijSlsRZhYwsGqKAqTfAgNjZwvA8XLnsG7sL4ngmXldp8EWFBa1Oq7ifZ3AobUkfUFd6YY0AQnGh39yDLsBd57qQ2p730cGjNbd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wlCNc1dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A81C4CEE9;
	Fri, 30 May 2025 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748582033;
	bh=0a50+Hp19JQF0AMt+fssCSo2Xt5F5UE65SizAj0FMmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wlCNc1dB1M2+jmQGGGsvYrTiX7YTWkVBJQ76qyHvwspOJGAtGDhB0sndzDkC/4Gph
	 RuY3wxXDWVmENYgJiAjBKKHRrA/WU2al4Y0yQfPFoSQwfy0O9UcATJBWnOzezPO8Md
	 X+ydF3blCnvBSIQsRU1AJZqhMfvTW/pKEDJdzfDk=
Date: Fri, 30 May 2025 07:11:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Richard Narron <richard@aaazen.com>, Guenter Roeck <linux@roeck-us.net>,
	Linux stable <stable@vger.kernel.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
Message-ID: <2025053037-tribunal-shortlist-5207@gregkh>
References: <20250520125753.836407405@linuxfoundation.org>
 <0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net>
 <67f03e41-245e-202-f0df-687cc4d9a915@aaazen.com>
 <20250528005520.dpip4qe45zvsn7vw@desk>
 <b8a9acaf-3d3e-7931-23ce-d61ee77b4e10@aaazen.com>
 <20250529174017.lwctaondsbg7tk37@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529174017.lwctaondsbg7tk37@desk>

On Thu, May 29, 2025 at 10:40:17AM -0700, Pawan Gupta wrote:
> On Wed, May 28, 2025 at 09:49:40PM -0700, Richard Narron wrote:
> > On Tue, 27 May 2025, Pawan Gupta wrote:
> > 
> > > On Tue, May 27, 2025 at 12:31:47PM -0700, Richard Narron wrote:
> > > > On Fri, 23 May 2025, Guenter Roeck wrote:
> > > >
> > > > > On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 5.15.184 release.
> > > > > > There are 59 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > >
> > > > >
> > > > > Build reference: v5.15.184
> > > > > Compiler version: x86_64-linux-gcc (GCC) 12.4.0
> > > > > Assembler version: GNU assembler (GNU Binutils) 2.40
> > > > >
> > > > > Configuration file workarounds:
> > > > >     "s/CONFIG_FRAME_WARN=.*/CONFIG_FRAME_WARN=0/"
> > > > >
> > > > > Building i386:defconfig ... passed
> > > > > Building i386:allyesconfig ... failed
> > > > > --------------
> > > > > Error log:
> > > > > x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> > > > > `__static_call_transform':
> > > > > static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > > > > make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> > > > > --------------
> > > > > Building i386:allmodconfig ... failed
> > > > > --------------
> > > > > Error log:
> > > > > x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> > > > > `__static_call_transform':
> > > > > static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > > > > make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> > > > > --------------
> > > > >
> > > > > In v5.15.y, cpu_wants_rethunk_at is only built if CONFIG_STACK_VALIDATION=y,
> > > > > but that is not supported for i386 builds. The dummy function in
> > > > > arch/x86/include/asm/alternative.h doesn't take that dependency into account.
> > > > >
> > > >
> > > > I found this bug too using the Slackware 15.0 32-bit kernel
> > > > configuration.
> > > >
> > > > Here is a simple work around patch, but there may be a better solution...
> > > >
> > > > --- arch/x86/kernel/static_call.c.orig	2025-05-22 05:08:28.000000000 -0700
> > > > +++ arch/x86/kernel/static_call.c	2025-05-27 10:25:27.630496538 -0700
> > > > @@ -81,9 +81,12 @@
> > > >  		break;
> > > >
> > > >  	case RET:
> > > > +
> > > > +#ifdef CONFIG_64BIT
> > > >  		if (cpu_wants_rethunk_at(insn))
> > > >  			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
> > > >  		else
> > > > +#endif
> > > >  			code = &retinsn;
> > > >  		break;
> > > >
> > >
> > > Another option is to define the empty function when CONFIG_STACK_VALIDATION=n as below:
> > >
> > > --- 8< ---
> > > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > Subject: [PATCH] x86/its: Fix undefined reference to cpu_wants_rethunk_at()
> > >
> > > Below error was reported in 32-bit kernel build:
> > >
> > >   static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> > >   make[1]: [Makefile:1234: vmlinux] Error
> > >
> > > This is because the definition of cpu_wants_rethunk_at() depends on
> > > CONFIG_STACK_VALIDATION which is only enabled in 64-bit mode.
> > >
> > > Define the empty function when CONFIG_STACK_VALIDATION=n, rethunk mitigation
> > > is anyways not supported without it.
> > >
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Link: https://lore.kernel.org/stable/0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net/
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---
> > >  arch/x86/include/asm/alternative.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> > > index 1797f80c10de..a5f704dbb4a1 100644
> > > --- a/arch/x86/include/asm/alternative.h
> > > +++ b/arch/x86/include/asm/alternative.h
> > > @@ -98,7 +98,7 @@ static inline u8 *its_static_thunk(int reg)
> > >  }
> > >  #endif
> > >
> > > -#ifdef CONFIG_RETHUNK
> > > +#if defined(CONFIG_RETHUNK) && defined(CONFIG_STACK_VALIDATION)
> > >  extern bool cpu_wants_rethunk(void);
> > >  extern bool cpu_wants_rethunk_at(void *addr);
> > >  #else
> > > --
> > > 2.34.1
> > >
> > 
> > Thanks for looking at this Pawan.
> > 
> > Your new patch works fine on both Slackware 15.0 32-bit and 64-bit
> > systems.
> 
> Thank you for verifying the patch.

Is someone going to submit this in a form we can apply it in?  (hint...)

