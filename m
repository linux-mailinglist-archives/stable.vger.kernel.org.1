Return-Path: <stable+bounces-109481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C458FA160FC
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 10:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FF01882FD7
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3604E1991A1;
	Sun, 19 Jan 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3uJkeUe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517D1885A1;
	Sun, 19 Jan 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737279825; cv=none; b=evSv+uJivy2yHLgM0fRn+/eOE8kfMlPj3Iyjsum7T+W3z1UwDItI9DLhiQHaLnjBOVf0a0acIWkIEGy9Kc+E8Hp/b6yswZz8JkA/IuOM/imFsQ+0+AmYOb1ro3DE8rQjZHEr4D2Ji7ndOA5QMgh9VpicHcF9IBXd+t/IM/8GVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737279825; c=relaxed/simple;
	bh=sOuo5FAigjIZyzMJdjLzWmlN1vhvJiGRByTmx+2rKcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHS4FOT8jn+6TSInEPMiGWanS15lykxJK56sFNyOeV2tXm4b7E3Z95A10vKamcgm1jvImxdNpytZhXYhZ/BdBikvjwuQrwNl15oIUR4qUhUB7XqKoISwPmI8RHEeuPoPLQb1NUqP3mRe5LsfVGfpu1BZCZC2HzhBPv95bzWeMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3uJkeUe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737279823; x=1768815823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sOuo5FAigjIZyzMJdjLzWmlN1vhvJiGRByTmx+2rKcQ=;
  b=e3uJkeUeU9kJ+PLygXNtFX1hmjX5B9NjzYsNHXvU3Cj6oBGXFOoF6qQR
   m0Z+0+w7Od1rKaOTtVoY8Mv9SARIoPl8tVJN/R3dCgU5ARayTS/don+8N
   XHeKoqK+8AvEr/UZgOl8SFJuh+gxmwq3DrI1JiXlsp4kU3gaautlhgwWM
   FCv91HlnG17TAQIX1SfpNfgBJS7aDiJ7vek9pFqCu2BjOW96cinYR+WM2
   8pLsF51ifFrXhbtghEOVnJx3/vpiRmPfiYJNrYxWAcAYluM76Ns96GheK
   95IYS3gOFCExAE84kqPI+kooqjxa0eU3Hy6aWj4nQfVPOsU21IFgMLKG8
   w==;
X-CSE-ConnectionGUID: wDkMRfKERXSokKu+EZs+hQ==
X-CSE-MsgGUID: R3f8qCx4Th6GSKclGLriIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37773466"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37773466"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 01:43:40 -0800
X-CSE-ConnectionGUID: tLz3b9d9Rbqj49fznqf7uw==
X-CSE-MsgGUID: z0OO8lmDQf6lcpqLS4dRFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106659869"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.124.240.60]) ([10.124.240.60])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 01:43:36 -0800
Message-ID: <d9d943c7-e20c-4987-9c9e-076faad52558@linux.intel.com>
Date: Sun, 19 Jan 2025 17:43:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG ? exc_page_fault() was optimized out of fred_hwexc() by gcc
 with default kernel build option (-O2).
To: Ethan Zhao <etzhao@outlook.com>, Xin Li <xin@zytor.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@linux.intel.com, tglx@linutronix.de, stable@vger.kernel.org
References: <TYZPR03MB88013AABBBC2B40F7B955825D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <TYZPR03MB88013AABBBC2B40F7B955825D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/18 21:50, Ethan Zhao 写道:
> Hi, Xin, Peter
>
>   While checking the asm code of arch/x86/entry/entry_fred.o about 
> function fred_hwexc(),
> found the code was generated as following :
>
> 0000000000000200 <fred_hwexc.constprop.0>:
>  200:   0f b6 87 a4 00 00 00    movzbl 0xa4(%rdi),%eax
>  207:   3c 0e                   cmp    $0xe,%al /* match X86_TRAP_PF */
>  209:   75 05                   jne    210 <fred_hwexc.constprop.0+0x10>
>  20b:   e9 00 00 00 00          jmp    210 <fred_hwexc.constprop.0+0x10>
>  210:   3c 0b                   cmp    $0xb,%al
>  212:   74 6a                   je     27e <fred_hwexc.constprop.0+0x7e>
>  214:   77 17                   ja     22d <fred_hwexc.constprop.0+0x2d>
>  216:   3c 06                   cmp    $0x6,%al
>  218:   0f 84 83 00 00 00       je     2a1 <fred_hwexc.constprop.0+0xa1>
>  21e:   76 29                   jbe    249 <fred_hwexc.constprop.0+0x49>
>  220:   3c 08                   cmp    $0x8,%al
>  222:   74 78                   je     29c <fred_hwexc.constprop.0+0x9c>
>  224:   3c 0a                   cmp    $0xa,%al
>  226:   75 18                   jne    240 <fred_hwexc.constprop.0+0x40>
>  228:   e9 00 00 00 00          jmp    22d <fred_hwexc.constprop.0+0x2d>
>  22d:   3c 11                   cmp    $0x11,%al
>  22f:   74 66                   je     297 <fred_hwexc.constprop.0+0x97>
>  231:   76 2c                   jbe    25f <fred_hwexc.constprop.0+0x5f>
>  233:   3c 13                   cmp    $0x13,%al
>  235:   74 5b                   je     292 <fred_hwexc.constprop.0+0x92>
>  237:   3c 15                   cmp    $0x15,%al
>  239:   75 1b                   jne    256 <fred_hwexc.constprop.0+0x56>
>  23b:   e9 00 00 00 00          jmp    240 <fred_hwexc.constprop.0+0x40>
>  240:   3c 07                   cmp    $0x7,%al
>  242:   75 49                   jne    28d <fred_hwexc.constprop.0+0x8d>
>  244:   e9 00 00 00 00          jmp    249 <fred_hwexc.constprop.0+0x49>
>  249:   3c 01                   cmp    $0x1,%al
>  24b:   74 3b                   je     288 <fred_hwexc.constprop.0+0x88>
>  24d:   3c 05                   cmp    $0x5,%al
>  24f:   75 1b                   jne    26c <fred_hwexc.constprop.0+0x6c>
>  251:   e9 00 00 00 00          jmp    256 <fred_hwexc.constprop.0+0x56>
>  256:   3c 12                   cmp    $0x12,%al
>  258:   75 33                   jne    28d <fred_hwexc.constprop.0+0x8d>
>  25a:   e9 00 00 00 00          jmp    25f <fred_hwexc.constprop.0+0x5f>
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
> or just as Peter said in another loop, manually loading some event 
> bits to make the
> over-smart gcc behave normally ？or fall back to -O(ption)0 ?
>
> Any idea, much appreciated !
>
>
> Thanks,
> Ethan
>
>

Rebuild the same lastest stable kernel with FRED enabled, default -O2 on RHEL 8.6, got
correct result:

ffffffff820a7430 <fred_hwexc>:
ffffffff820a7430:       55                      push   %rbp
ffffffff820a7431:       0f b6 87 a4 00 00 00    movzbl 0xa4(%rdi),%eax
ffffffff820a7438:       48 89 e5                mov    %rsp,%rbp
ffffffff820a743b:       3c 0e                   cmp    $0xe,%al
ffffffff820a743d:       75 0b                   jne    ffffffff820a744a <fred_hwexc+0x1a>
ffffffff820a743f:       e8 4c 50 00 00          callq  ffffffff820ac490 <exc_page_fault>
ffffffff820a7444:       5d                      pop    %rbp

gcc version 8.5.0 20210514 (Red Hat 8.5.0-10) (GCC)

whatever CONFIG_JUMP_LABEL=y or CONFIG_JUMP_LABEL is not set.

so the issue seems only about WSL ubuntu toolchain.

Thanks,
Ethan



>
>
-- 
"firm, enduring, strong, and long-lived"


