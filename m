Return-Path: <stable+bounces-147881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4585CAC5ADF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 21:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E068A54AD
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA228A3F2;
	Tue, 27 May 2025 19:38:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFB2701D6;
	Tue, 27 May 2025 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374710; cv=none; b=Ai/OcACPVEC2E7DgBV7c4IYN6bnJc+ZIyT84r1qykpmbOJVyBJESYUIG33e+lozLAm/8eqV6qHJScUIlmAfT2bnn0ng1BeAt63wf3JRj+ksANYSBy2BAiUBJHrroSBVdYa9n0bVhShM+JOVZwMRrfdn8Fu02HRkJkmjaQHCobs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374710; c=relaxed/simple;
	bh=KPnnEbEzDg1iO5SPzFnVAGmm/vw403K+t6jriv7b9v4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nYlwrkhsYmVtl4qJnckQE7V34SDwAYs4aKdEy436PSUUypCdwDYG1GEvxvSu/Ce9aJr+Zhd7sUoZ85+iUbS0PbA8F2jfKmSQWtKgIVb9U6SXDTe22WC2RsLIAcD4cNVzt8b9IiAJwXiMufykuWO5c/oWUq0lhm+8ZoeYMcISKow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id a4d15d45;
	Tue, 27 May 2025 12:31:47 -0700 (PDT)
Date: Tue, 27 May 2025 12:31:47 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Guenter Roeck <linux@roeck-us.net>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Linux stable <stable@vger.kernel.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
In-Reply-To: <0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net>
Message-ID: <67f03e41-245e-202-f0df-687cc4d9a915@aaazen.com>
References: <20250520125753.836407405@linuxfoundation.org> <0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 May 2025, Guenter Roeck wrote:

> On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.184 release.
> > There are 59 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> > Anything received after that time might be too late.
> >
>
> Build reference: v5.15.184
> Compiler version: x86_64-linux-gcc (GCC) 12.4.0
> Assembler version: GNU assembler (GNU Binutils) 2.40
>
> Configuration file workarounds:
>     "s/CONFIG_FRAME_WARN=.*/CONFIG_FRAME_WARN=0/"
>
> Building i386:defconfig ... passed
> Building i386:allyesconfig ... failed
> --------------
> Error log:
> x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> `__static_call_transform':
> static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> --------------
> Building i386:allmodconfig ... failed
> --------------
> Error log:
> x86_64-linux-ld: arch/x86/kernel/static_call.o: in function
> `__static_call_transform':
> static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
> make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
> --------------
>
> In v5.15.y, cpu_wants_rethunk_at is only built if CONFIG_STACK_VALIDATION=y,
> but that is not supported for i386 builds. The dummy function in
> arch/x86/include/asm/alternative.h doesn't take that dependency into account.
>

I found this bug too using the Slackware 15.0 32-bit kernel
configuration.

Here is a simple work around patch, but there may be a better solution...

--- arch/x86/kernel/static_call.c.orig	2025-05-22 05:08:28.000000000 -0700
+++ arch/x86/kernel/static_call.c	2025-05-27 10:25:27.630496538 -0700
@@ -81,9 +81,12 @@
 		break;

 	case RET:
+
+#ifdef CONFIG_64BIT
 		if (cpu_wants_rethunk_at(insn))
 			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
+#endif
 			code = &retinsn;
 		break;

--------------
Richard Narron

