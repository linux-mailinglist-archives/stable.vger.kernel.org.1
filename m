Return-Path: <stable+bounces-109456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BFA15E7E
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7888318876CA
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 18:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA51199E80;
	Sat, 18 Jan 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UvW5rH59"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEB136327;
	Sat, 18 Jan 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737225272; cv=none; b=CtxPusdXWLBIUx71U8jjdypo8ATBynyenOUSpR+aivy4L2kmsv8OXXar/WzFa2l1XcwUdMXJn1tSXxeUlSjuJs6LFOymvuwKbPwJtgLYFwYwHk0wNl6AIA7Y1V7WKM/YZQJkoRP5mY/Gdq7+anOVXPaSTEbVqnhFp0DrQVSsKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737225272; c=relaxed/simple;
	bh=IoLx0q33muIRoc+FyUAakuyNRNMpFLDewAsvu4nikUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNJgEN2LYbddgzEyzoYP4ZEbdni4deCDzj5CPdNL5MIWZxQ9gzxeUVw1bj9encdgtd1/5vZ5BKetwI4mCI0dKhv8hro7mWHtgWsGEVgziq9ewftRWSFvV48Vkfl6Fur2upYr+lvV/B6Y1qsbGiRxdv8SkI3NsLbkPo9ZurJV7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UvW5rH59; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50IIY2qZ531378
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 18 Jan 2025 10:34:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50IIY2qZ531378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737225243;
	bh=fTjGjExodEaRKg4PbMW//fTamnQV4P6JqeCg5VNB6UQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UvW5rH59qJm70SPjp8LLvI6VHzX+ljDtK4VXvloS7QAEzny4opoFP4+yQd+EPFMwS
	 HcLFLveiwDSrpi9IlEa3c+Zo+C8JAHVSf8Jf7Q9Aq5KOotCRNaUcDwnFBTtkD7eWhd
	 IFpdbwN18ZQ63B0NhvADTT0umEX2O5//8lL8OisDE7nvQ1j9MArSlrDSqwVxKyeNxx
	 jKpy8V0WLUCATL8nBRq0dDM5TEsFpyOiatDv6+uR4mvdLeUTX9T6U3zcGcZ6NCnNoy
	 XRNsbGdxksIaw76Owsg1x3e0aNFHjmiKCwS6Rkg+XHsrlBV4+oXKyLadzcVtHA9IbV
	 kWE669dnPq1tA==
Message-ID: <ff96c2db-2424-4d11-bfbd-e5b131a5d025@zytor.com>
Date: Sat, 18 Jan 2025 10:34:02 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG ? exc_page_fault() was optimized out of fred_hwexc() by gcc
 with default kernel build option (-O2).
To: Ethan Zhao <etzhao@outlook.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, stable@vger.kernel.org,
        Ethan Zhao <haifeng.zhao@linux.intel.com>
References: <TYZPR03MB88013AABBBC2B40F7B955825D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <TYZPR03MB88013AABBBC2B40F7B955825D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/18/2025 5:50 AM, Ethan Zhao wrote:
> Hi, Xin, Peter
> 
>    While checking the asm code of arch/x86/entry/entry_fred.o about 
> function fred_hwexc(),
> found the code was generated as following :
> 
> 0000000000000200 <fred_hwexc.constprop.0>:
>   200:   0f b6 87 a4 00 00 00    movzbl 0xa4(%rdi),%eax
>   207:   3c 0e                   cmp    $0xe,%al /* match X86_TRAP_PF */
>   209:   75 05                   jne    210 <fred_hwexc.constprop.0+0x10>
>   20b:   e9 00 00 00 00          jmp    210 <fred_hwexc.constprop.0+0x10>
>   210:   3c 0b                   cmp    $0xb,%al
>   212:   74 6a                   je     27e <fred_hwexc.constprop.0+0x7e>
>   214:   77 17                   ja     22d <fred_hwexc.constprop.0+0x2d>
>   216:   3c 06                   cmp    $0x6,%al
>   218:   0f 84 83 00 00 00       je     2a1 <fred_hwexc.constprop.0+0xa1>
>   21e:   76 29                   jbe    249 <fred_hwexc.constprop.0+0x49>
>   220:   3c 08                   cmp    $0x8,%al
>   222:   74 78                   je     29c <fred_hwexc.constprop.0+0x9c>
>   224:   3c 0a                   cmp    $0xa,%al
>   226:   75 18                   jne    240 <fred_hwexc.constprop.0+0x40>
>   228:   e9 00 00 00 00          jmp    22d <fred_hwexc.constprop.0+0x2d>
>   22d:   3c 11                   cmp    $0x11,%al
>   22f:   74 66                   je     297 <fred_hwexc.constprop.0+0x97>
>   231:   76 2c                   jbe    25f <fred_hwexc.constprop.0+0x5f>
>   233:   3c 13                   cmp    $0x13,%al
>   235:   74 5b                   je     292 <fred_hwexc.constprop.0+0x92>
>   237:   3c 15                   cmp    $0x15,%al
>   239:   75 1b                   jne    256 <fred_hwexc.constprop.0+0x56>
>   23b:   e9 00 00 00 00          jmp    240 <fred_hwexc.constprop.0+0x40>
>   240:   3c 07                   cmp    $0x7,%al
>   242:   75 49                   jne    28d <fred_hwexc.constprop.0+0x8d>
>   244:   e9 00 00 00 00          jmp    249 <fred_hwexc.constprop.0+0x49>
>   249:   3c 01                   cmp    $0x1,%al
>   24b:   74 3b                   je     288 <fred_hwexc.constprop.0+0x88>
>   24d:   3c 05                   cmp    $0x5,%al
>   24f:   75 1b                   jne    26c <fred_hwexc.constprop.0+0x6c>
>   251:   e9 00 00 00 00          jmp    256 <fred_hwexc.constprop.0+0x56>
>   256:   3c 12                   cmp    $0x12,%al
>   258:   75 33                   jne    28d <fred_hwexc.constprop.0+0x8d>
>   25a:   e9 00 00 00 00          jmp    25f <fred_hwexc.constprop.0+0x5f>
> 
> seems the following calling to exc_page_fault() was optimized out from 
> fred_hwexc() by gcc,
> 
> if(likely(regs->fred_ss.vector==X86_TRAP_PF))
> returnexc_page_fault(regs,error_code);
> 
> gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
> 
> GNU objdump (GNU Binutils) 2.43
> 
> 
> default kernel config.
> .config:CONFIG_X86_FRED=y
> 
> my understanding, -O2 is the default kernel KBUILD_CFLAGS
> So, Are there any workaround needed to make the kernel works with 
> default build ?
> or just as Peter said in another loop, manually loading some event bits 
> to make the
> over-smart gcc behave normally ？or fall back to -O(ption)0 ?
> 
> Any idea, much appreciated !

This is an optimization done in the original code:

static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long 
error_code)
{
         /* Optimize for #PF. That's the only exception which matters 
performance wise */
         if (likely(regs->fred_ss.vector == X86_TRAP_PF))
                 return exc_page_fault(regs, error_code);

         switch (regs->fred_ss.vector) {


