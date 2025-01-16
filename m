Return-Path: <stable+bounces-109220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFEBA133EA
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 08:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EEB188294B
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B219ABC2;
	Thu, 16 Jan 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ss9FfK8X"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3A199FC1;
	Thu, 16 Jan 2025 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012482; cv=none; b=oXjTHPPHgPZW/6dwrIQfqbVam2Qdun5K+mMJoBpQbnTpD5d+qD3yFedMbqAIWvMqJQi357uqOMK47BqDeVm7Y2T7wOkDhRM6dO/YVt1Jd29cHoZJYRRfr2KFLBncamSqk4vyP+P45SNLzAA6v+pUofkE6ZVUgh2Y2YcJfOhl0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012482; c=relaxed/simple;
	bh=DMKREo++5GYgYbU7DrQaKy55Cmlm9KURSOVKcrmn5zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iB5cY3srNEda8IoCpacyVFDygCF2Wbh/DK0lXrCCZZvU9ejzEW38UwTz3ItsCEeglweCu3t5hYtQn1aumvIlZUeKDMyq2kpheq9ZvV42u2nqSCLPYPdCJgeBzjxTq3LecKa5teWxrwn8yVtBu1YiP2z7hNwncIQsCgB7jFLDJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ss9FfK8X; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50G7RBDo3602966
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 15 Jan 2025 23:27:12 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50G7RBDo3602966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737012432;
	bh=ZwfUBejq+Moxf/HAMrR5/vFX6Uq3zII0FJYRH/4Un2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ss9FfK8X2P7iTUASdvVFQHcoBH1FX2JdGHR/iQPrpM9bx0dgMe5rGYagXFFdUse35
	 Iks9G97h5ERHZp1g+AaZPqiLZMu4SDWHxKAXL9O2SzBEVYct+GnMDsx2YoWMYHPbNX
	 N2W0NJbev1SB8q8NWK7TVs/qzJ4Fhdzswf+JaoCzme+vmX3V24KgW1SrjhkioKRC5M
	 /UrTnf8WOJDkkdMKXmHe9skUx10eAsUQLIEmU+o7+aNFg7kVpTDzbnEi7RDGpHdWUQ
	 ZkZvXjJjNAw8S+H38T+a7dX+o4pgo/yLlhffQ5NYXreQ1AJAqX+MFXNQ70nz33QIzh
	 4lMDJCi3npQtA==
Message-ID: <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
Date: Wed, 15 Jan 2025 23:27:11 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, andrew.cooper3@citrix.com, mingo@redhat.com,
        bp@alien8.de, etzhao@outlook.com
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/2025 10:51 PM, Ethan Zhao wrote:
> External interrupts (EVENT_TYPE_EXTINT) and system calls (EVENT_TYPE_OTHER)
> occur more frequently than other events in a typical system. Prioritizing
> these events saves CPU cycles and optimizes the efficiency of performance-
> critical paths.

We deliberately hold off sending performance improvement patches at this
point, but first of all please read:
     https://lore.kernel.org/lkml/87fs766o3t.ffs@tglx/

Thanks!
     Xin

> 
> When examining the compiler-generated assembly code for event dispatching
> in the functions fred_entry_from_user() and fred_entry_from_kernel(), it
> was observed that the compiler intelligently uses a binary search to match
> all event type values (0-7) and perform dispatching. As a result, even if
> the following cases:
> 
> 	case EVENT_TYPE_EXTINT:
> 		return fred_extint(regs);
> 	case EVENT_TYPE_OTHER:
> 		return fred_other(regs);
> 
> are placed at the beginning of the switch() statement, the generated
> assembly code would remain the same, and the expected prioritization would
> not be achieved.
> 
> Command line to check the assembly code generated by the compiler for
> fred_entry_from_user():
> 
> $objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
> 
> 00000000000015a0 <fred_entry_from_user>:
> 15a0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
> 15a7:       48 8b 77 78             mov    0x78(%rdi),%rsi
> 15ab:       55                      push   %rbp
> 15ac:       48 c7 47 78 ff ff ff    movq   $0xffffffffffffffff,0x78(%rdi)
> 15b3:       ff
> 15b4:       83 e0 0f                and    $0xf,%eax
> 15b7:       48 89 e5                mov    %rsp,%rbp
> 15ba:       3c 04                   cmp    $0x4,%al
> -->>			            /* match 4(EVENT_TYPE_SWINT) first */
> 15bc:       74 78                   je     1636 <fred_entry_from_user+0x96>
> 15be:       77 15                   ja     15d5 <fred_entry_from_user+0x35>
> 15c0:       3c 02                   cmp    $0x2,%al
> 15c2:       74 53                   je     1617 <fred_entry_from_user+0x77>
> 15c4:       77 65                   ja     162b <fred_entry_from_user+0x8b>
> 15c6:       84 c0                   test   %al,%al
> 15c8:       75 42                   jne    160c <fred_entry_from_user+0x6c>
> 15ca:       e8 71 fc ff ff          callq  1240 <fred_extint>
> 15cf:       5d                      pop    %rbp
> 15d0:       e9 00 00 00 00          jmpq   15d5 <fred_entry_from_user+0x35>
> 15d5:       3c 06                   cmp    $0x6,%al
> 15d7:       74 7c                   je     1655 <fred_entry_from_user+0xb5>
> 15d9:       72 66                   jb     1641 <fred_entry_from_user+0xa1>
> 15db:       3c 07                   cmp    $0x7,%al
> 15dd:       75 2d                   jne    160c <fred_entry_from_user+0x6c>
> 15df:       8b 87 a4 00 00 00       mov    0xa4(%rdi),%eax
> 15e5:       25 ff 00 00 02          and    $0x20000ff,%eax
> 15ea:       3d 01 00 00 02          cmp    $0x2000001,%eax
> 15ef:       75 6f                   jne    1660 <fred_entry_from_user+0xc0>
> 15f1:       48 8b 77 50             mov    0x50(%rdi),%rsi
> 15f5:       48 c7 47 50 da ff ff    movq   $0xffffffffffffffda,0x50(%rdi)
> ... ...
> 
> Command line to check the assembly code generated by the compiler for
> fred_entry_from_kernel():
> 
> $objdump -d vmlinux.o | awk '/<fred_entry_from_kernel>:/{c=65} c&&c--'
> 
> 00000000000016b0 <fred_entry_from_kernel>:
> 16b0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
> 16b7:       48 8b 77 78             mov    0x78(%rdi),%rsi
> 16bb:       55                      push   %rbp
> 16bc:       48 c7 47 78 ff ff ff    movq   $0xffffffffffffffff,0x78(%rdi)
> 16c3:       ff
> 16c4:       83 e0 0f                and    $0xf,%eax
> 16c7:       48 89 e5                mov    %rsp,%rbp
> 16ca:       3c 03                   cmp    $0x3,%al
> -->>                                /* match 3(EVENT_TYPE_HWEXC) first */
> 16cc:       74 3c                 je     170a <fred_entry_from_kernel+0x5a>
> 16ce:       76 13                 jbe    16e3 <fred_entry_from_kernel+0x33>
> 16d0:       3c 05                 cmp    $0x5,%al
> 16d2:       74 41                 je     1715 <fred_entry_from_kernel+0x65>
> 16d4:       3c 06                 cmp    $0x6,%al
> 16d6:       75 27                 jne    16ff <fred_entry_from_kernel+0x4f>
> 16d8:       e8 73 fe ff ff        callq  1550 <fred_swexc.isra.3>
> 16dd:       5d                    pop    %rbp
> ... ...
> 
> Therefore, it is necessary to handle EVENT_TYPE_EXTINT and EVENT_TYPE_OTHER
> before the switch statement using if-else syntax to ensure the compiler
> generates the desired code. After applying the patch, the verification
> results are as follows:
> 
> $objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
> 
> 00000000000015a0 <fred_entry_from_user>:
> 15a0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
> 15a7:       48 8b 77 78             mov    0x78(%rdi),%rsi
> 15ab:       55                      push   %rbp
> 15ac:       48 c7 47 78 ff ff ff    movq   $0xffffffffffffffff,0x78(%rdi)
> 15b3:       ff
> 15b4:       48 89 e5                mov    %rsp,%rbp
> 15b7:       83 e0 0f                and    $0xf,%eax
> 15ba:       74 34                   je     15f0 <fred_entry_from_user+0x50>
> -->>				    /* match 0(EVENT_TYPE_EXTINT) first */
> 15bc:       3c 07                   cmp    $0x7,%al
> -->>                                /* match 7(EVENT_TYPE_OTHER) second *
> 15be:       74 6e                   je     162e <fred_entry_from_user+0x8e>
> 15c0:       3c 04                   cmp    $0x4,%al
> 15c2:       0f 84 93 00 00 00       je     165b <fred_entry_from_user+0xbb>
> 15c8:       76 13                   jbe    15dd <fred_entry_from_user+0x3d>
> 15ca:       3c 05                   cmp    $0x5,%al
> 15cc:       74 41                   je     160f <fred_entry_from_user+0x6f>
> 15ce:       3c 06                   cmp    $0x6,%al
> 15d0:       75 51                   jne    1623 <fred_entry_from_user+0x83>
> 15d2:       e8 79 ff ff ff          callq  1550 <fred_swexc.isra.3>
> 15d7:       5d                      pop    %rbp
> 15d8:       e9 00 00 00 00          jmpq   15dd <fred_entry_from_user+0x3d>
> 15dd:       3c 02                   cmp    $0x2,%al
> 15df:       74 1a                   je     15fb <fred_entry_from_user+0x5b>
> 15e1:       3c 03                   cmp    $0x3,%al
> 15e3:       75 3e                   jne    1623 <fred_entry_from_user+0x83>
> ... ...
> 
> The same desired code in fred_entry_from_kernel is no longer repeated.
> 
> While the C code with if-else placed before switch() may appear ugly, it
> works. Additionally, using a jump table is not advisable; even if the jump
> table resides in the L1 cache, the cost of loading it is over 10 times the
> latency of a cmp instruction.
> 
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
> base commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
> ---
>   arch/x86/entry/entry_fred.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
> index f004a4dc74c2..591f47771ecf 100644
> --- a/arch/x86/entry/entry_fred.c
> +++ b/arch/x86/entry/entry_fred.c
> @@ -228,9 +228,18 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
>   	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
>   	regs->orig_ax = -1;
>   
> -	switch (regs->fred_ss.type) {
> -	case EVENT_TYPE_EXTINT:
> +	if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>   		return fred_extint(regs);
> +	else if (regs->fred_ss.type == EVENT_TYPE_OTHER)
> +		return fred_other(regs);
> +
> +	/*
> +	 * Dispatch EVENT_TYPE_EXTINT and EVENT_TYPE_OTHER(syscall) type events
> +	 * first due to their high probability and let the compiler create binary search
> +	 * dispatching for the remaining events
> +	 */
> +
> +	switch (regs->fred_ss.type) {
>   	case EVENT_TYPE_NMI:
>   		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>   			return fred_exc_nmi(regs);
> @@ -245,8 +254,6 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
>   		break;
>   	case EVENT_TYPE_SWEXC:
>   		return fred_swexc(regs, error_code);
> -	case EVENT_TYPE_OTHER:
> -		return fred_other(regs);
>   	default: break;
>   	}
>   
> @@ -260,9 +267,15 @@ __visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
>   	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
>   	regs->orig_ax = -1;
>   
> -	switch (regs->fred_ss.type) {
> -	case EVENT_TYPE_EXTINT:
> +	if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>   		return fred_extint(regs);
> +
> +	/*
> +	 * Dispatch EVENT_TYPE_EXTINT type event first due to its high probability
> +	 * and let the compiler do binary search dispatching for the other events
> +	 */
> +
> +	switch (regs->fred_ss.type) {
>   	case EVENT_TYPE_NMI:
>   		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>   			return fred_exc_nmi(regs);


