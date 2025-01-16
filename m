Return-Path: <stable+bounces-109230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F8A13680
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D097A326C
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14A1D7E4F;
	Thu, 16 Jan 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkOJGH+t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFE1DB362;
	Thu, 16 Jan 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019380; cv=none; b=XdPFENQtR464WpXxxZ3ND8zcu69t5BvLV9kBoGylIw6Yrfb5twGVjDEOjk9IlU8GHIO9Ipn82623DXSdeFgnSlHJGR7O3XGUrbbNO6YgGS++2DrPiMc2nnIak2pKkFWYqeaWrB0Fi/rTcGB0SFy+bhr612rhfD3ImRENv32rd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019380; c=relaxed/simple;
	bh=DhaybTlHtk+Vvdu0TPo8t6A6qMl08tO4nR6CIQdbpvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHGCoBeQF3zCAGW4qOr94RUi1oago/YkF5fef/yBPOuqg4dyKlbtmOmgbCTRCIutZ73hquCIJAAotPlqz8TlSrZSZ8TTA8UL1Oj/YaSrmRxdPatYA6utbhXDWfai6qW3DguAGWC5tpchMvJODF20d+iiR3IPn+RpAV2m4eIEvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkOJGH+t; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737019379; x=1768555379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DhaybTlHtk+Vvdu0TPo8t6A6qMl08tO4nR6CIQdbpvg=;
  b=BkOJGH+tqv0erdo9TG5YvfuW+H1ssWKNhrlGfCCVFmQCD0zcBhzO+LkZ
   jbPj7w57dG50aKttLz3n8RzEQ/3D+hQSg7ixhtgH8OgdKKp53S6BT6LTu
   slky3rbegmFGKW7A5s1ZHum22KFOyf035YjJP08MsUBi9Oky9dqiKIWlt
   9LQRHpdXUqdJC03OOZEoX7Q+hUhuepkgm50dIIqgQ57LKQCv/PCDf3Qxw
   w9kr/865BHxBXW2TWO/vu1TmHkHOrinwWEl5Y6M8pddwCRM5vaYVDMUv5
   67qxt95SczecZ1XjCxTFnVMU2EE5NrEfgFQx1lNPS+AQr7vCuPXzstmNR
   w==;
X-CSE-ConnectionGUID: vnC8wokYSjGQiym8Ng1YpQ==
X-CSE-MsgGUID: axciQFEpRWCB/BEjrRoyUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48052089"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="48052089"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:22:58 -0800
X-CSE-ConnectionGUID: OmriBog4RBKVJCVEB1Pd9g==
X-CSE-MsgGUID: dpL1yGeES/C35NZSUNipcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128683976"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.124.240.60]) ([10.124.240.60])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:22:55 -0800
Message-ID: <f87f21d3-731d-4c39-9a38-038d158a647e@linux.intel.com>
Date: Thu, 16 Jan 2025 17:22:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de,
 etzhao@outlook.com
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/1/16 15:27, Xin Li 写道:
> On 1/15/2025 10:51 PM, Ethan Zhao wrote:
>> External interrupts (EVENT_TYPE_EXTINT) and system calls 
>> (EVENT_TYPE_OTHER)
>> occur more frequently than other events in a typical system. 
>> Prioritizing
>> these events saves CPU cycles and optimizes the efficiency of 
>> performance-
>> critical paths.
>
> We deliberately hold off sending performance improvement patches at this
> point, but first of all please read:
>     https://lore.kernel.org/lkml/87fs766o3t.ffs@tglx/

   Got it, seems there is jump table implenmentation in that link page.  
will read

and discuss it -- two years ago, too old to reply that post.


Thanks,

Ethan

>
> Thanks!
>     Xin
>
>>
>> When examining the compiler-generated assembly code for event 
>> dispatching
>> in the functions fred_entry_from_user() and fred_entry_from_kernel(), it
>> was observed that the compiler intelligently uses a binary search to 
>> match
>> all event type values (0-7) and perform dispatching. As a result, 
>> even if
>> the following cases:
>>
>>     case EVENT_TYPE_EXTINT:
>>         return fred_extint(regs);
>>     case EVENT_TYPE_OTHER:
>>         return fred_other(regs);
>>
>> are placed at the beginning of the switch() statement, the generated
>> assembly code would remain the same, and the expected prioritization 
>> would
>> not be achieved.
>>
>> Command line to check the assembly code generated by the compiler for
>> fred_entry_from_user():
>>
>> $objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
>>
>> 00000000000015a0 <fred_entry_from_user>:
>> 15a0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
>> 15a7:       48 8b 77 78             mov    0x78(%rdi),%rsi
>> 15ab:       55                      push   %rbp
>> 15ac:       48 c7 47 78 ff ff ff    movq $0xffffffffffffffff,0x78(%rdi)
>> 15b3:       ff
>> 15b4:       83 e0 0f                and    $0xf,%eax
>> 15b7:       48 89 e5                mov    %rsp,%rbp
>> 15ba:       3c 04                   cmp    $0x4,%al
>> -->>                        /* match 4(EVENT_TYPE_SWINT) first */
>> 15bc:       74 78                   je     1636 
>> <fred_entry_from_user+0x96>
>> 15be:       77 15                   ja     15d5 
>> <fred_entry_from_user+0x35>
>> 15c0:       3c 02                   cmp    $0x2,%al
>> 15c2:       74 53                   je     1617 
>> <fred_entry_from_user+0x77>
>> 15c4:       77 65                   ja     162b 
>> <fred_entry_from_user+0x8b>
>> 15c6:       84 c0                   test   %al,%al
>> 15c8:       75 42                   jne    160c 
>> <fred_entry_from_user+0x6c>
>> 15ca:       e8 71 fc ff ff          callq  1240 <fred_extint>
>> 15cf:       5d                      pop    %rbp
>> 15d0:       e9 00 00 00 00          jmpq   15d5 
>> <fred_entry_from_user+0x35>
>> 15d5:       3c 06                   cmp    $0x6,%al
>> 15d7:       74 7c                   je     1655 
>> <fred_entry_from_user+0xb5>
>> 15d9:       72 66                   jb     1641 
>> <fred_entry_from_user+0xa1>
>> 15db:       3c 07                   cmp    $0x7,%al
>> 15dd:       75 2d                   jne    160c 
>> <fred_entry_from_user+0x6c>
>> 15df:       8b 87 a4 00 00 00       mov    0xa4(%rdi),%eax
>> 15e5:       25 ff 00 00 02          and    $0x20000ff,%eax
>> 15ea:       3d 01 00 00 02          cmp    $0x2000001,%eax
>> 15ef:       75 6f                   jne    1660 
>> <fred_entry_from_user+0xc0>
>> 15f1:       48 8b 77 50             mov    0x50(%rdi),%rsi
>> 15f5:       48 c7 47 50 da ff ff    movq $0xffffffffffffffda,0x50(%rdi)
>> ... ...
>>
>> Command line to check the assembly code generated by the compiler for
>> fred_entry_from_kernel():
>>
>> $objdump -d vmlinux.o | awk '/<fred_entry_from_kernel>:/{c=65} c&&c--'
>>
>> 00000000000016b0 <fred_entry_from_kernel>:
>> 16b0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
>> 16b7:       48 8b 77 78             mov    0x78(%rdi),%rsi
>> 16bb:       55                      push   %rbp
>> 16bc:       48 c7 47 78 ff ff ff    movq $0xffffffffffffffff,0x78(%rdi)
>> 16c3:       ff
>> 16c4:       83 e0 0f                and    $0xf,%eax
>> 16c7:       48 89 e5                mov    %rsp,%rbp
>> 16ca:       3c 03                   cmp    $0x3,%al
>> -->>                                /* match 3(EVENT_TYPE_HWEXC) 
>> first */
>> 16cc:       74 3c                 je     170a 
>> <fred_entry_from_kernel+0x5a>
>> 16ce:       76 13                 jbe    16e3 
>> <fred_entry_from_kernel+0x33>
>> 16d0:       3c 05                 cmp    $0x5,%al
>> 16d2:       74 41                 je     1715 
>> <fred_entry_from_kernel+0x65>
>> 16d4:       3c 06                 cmp    $0x6,%al
>> 16d6:       75 27                 jne    16ff 
>> <fred_entry_from_kernel+0x4f>
>> 16d8:       e8 73 fe ff ff        callq  1550 <fred_swexc.isra.3>
>> 16dd:       5d                    pop    %rbp
>> ... ...
>>
>> Therefore, it is necessary to handle EVENT_TYPE_EXTINT and 
>> EVENT_TYPE_OTHER
>> before the switch statement using if-else syntax to ensure the compiler
>> generates the desired code. After applying the patch, the verification
>> results are as follows:
>>
>> $objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
>>
>> 00000000000015a0 <fred_entry_from_user>:
>> 15a0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
>> 15a7:       48 8b 77 78             mov    0x78(%rdi),%rsi
>> 15ab:       55                      push   %rbp
>> 15ac:       48 c7 47 78 ff ff ff    movq $0xffffffffffffffff,0x78(%rdi)
>> 15b3:       ff
>> 15b4:       48 89 e5                mov    %rsp,%rbp
>> 15b7:       83 e0 0f                and    $0xf,%eax
>> 15ba:       74 34                   je     15f0 
>> <fred_entry_from_user+0x50>
>> -->>                    /* match 0(EVENT_TYPE_EXTINT) first */
>> 15bc:       3c 07                   cmp    $0x7,%al
>> -->>                                /* match 7(EVENT_TYPE_OTHER) 
>> second *
>> 15be:       74 6e                   je     162e 
>> <fred_entry_from_user+0x8e>
>> 15c0:       3c 04                   cmp    $0x4,%al
>> 15c2:       0f 84 93 00 00 00       je     165b 
>> <fred_entry_from_user+0xbb>
>> 15c8:       76 13                   jbe    15dd 
>> <fred_entry_from_user+0x3d>
>> 15ca:       3c 05                   cmp    $0x5,%al
>> 15cc:       74 41                   je     160f 
>> <fred_entry_from_user+0x6f>
>> 15ce:       3c 06                   cmp    $0x6,%al
>> 15d0:       75 51                   jne    1623 
>> <fred_entry_from_user+0x83>
>> 15d2:       e8 79 ff ff ff          callq  1550 <fred_swexc.isra.3>
>> 15d7:       5d                      pop    %rbp
>> 15d8:       e9 00 00 00 00          jmpq   15dd 
>> <fred_entry_from_user+0x3d>
>> 15dd:       3c 02                   cmp    $0x2,%al
>> 15df:       74 1a                   je     15fb 
>> <fred_entry_from_user+0x5b>
>> 15e1:       3c 03                   cmp    $0x3,%al
>> 15e3:       75 3e                   jne    1623 
>> <fred_entry_from_user+0x83>
>> ... ...
>>
>> The same desired code in fred_entry_from_kernel is no longer repeated.
>>
>> While the C code with if-else placed before switch() may appear ugly, it
>> works. Additionally, using a jump table is not advisable; even if the 
>> jump
>> table resides in the L1 cache, the cost of loading it is over 10 
>> times the
>> latency of a cmp instruction.
>>
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>> base commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
>> ---
>>   arch/x86/entry/entry_fred.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
>> index f004a4dc74c2..591f47771ecf 100644
>> --- a/arch/x86/entry/entry_fred.c
>> +++ b/arch/x86/entry/entry_fred.c
>> @@ -228,9 +228,18 @@ __visible noinstr void 
>> fred_entry_from_user(struct pt_regs *regs)
>>       /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>>       regs->orig_ax = -1;
>>   -    switch (regs->fred_ss.type) {
>> -    case EVENT_TYPE_EXTINT:
>> +    if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>>           return fred_extint(regs);
>> +    else if (regs->fred_ss.type == EVENT_TYPE_OTHER)
>> +        return fred_other(regs);
>> +
>> +    /*
>> +     * Dispatch EVENT_TYPE_EXTINT and EVENT_TYPE_OTHER(syscall) type 
>> events
>> +     * first due to their high probability and let the compiler 
>> create binary search
>> +     * dispatching for the remaining events
>> +     */
>> +
>> +    switch (regs->fred_ss.type) {
>>       case EVENT_TYPE_NMI:
>>           if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>>               return fred_exc_nmi(regs);
>> @@ -245,8 +254,6 @@ __visible noinstr void 
>> fred_entry_from_user(struct pt_regs *regs)
>>           break;
>>       case EVENT_TYPE_SWEXC:
>>           return fred_swexc(regs, error_code);
>> -    case EVENT_TYPE_OTHER:
>> -        return fred_other(regs);
>>       default: break;
>>       }
>>   @@ -260,9 +267,15 @@ __visible noinstr void 
>> fred_entry_from_kernel(struct pt_regs *regs)
>>       /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>>       regs->orig_ax = -1;
>>   -    switch (regs->fred_ss.type) {
>> -    case EVENT_TYPE_EXTINT:
>> +    if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>>           return fred_extint(regs);
>> +
>> +    /*
>> +     * Dispatch EVENT_TYPE_EXTINT type event first due to its high 
>> probability
>> +     * and let the compiler do binary search dispatching for the 
>> other events
>> +     */
>> +
>> +    switch (regs->fred_ss.type) {
>>       case EVENT_TYPE_NMI:
>>           if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>>               return fred_exc_nmi(regs);
>
-- 
"firm, enduring, strong, and long-lived"


