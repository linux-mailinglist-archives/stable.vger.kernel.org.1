Return-Path: <stable+bounces-144364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2504AB6B24
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99EF97ACDCB
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630F1EB36;
	Wed, 14 May 2025 12:11:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C2146A66
	for <stable@vger.kernel.org>; Wed, 14 May 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224692; cv=none; b=csnUs9Ni1mDtPkZ4M50olBiXJKZ5b0hJ44mKpGUUuBs2Bls7/KVAjc90FlIcn4egzi8UdM/0odMZOIEJUnWQKvh/d5B4vsbs89iN9AIvfsXDG6Eu3huncE7yvReh3p2+HPxmHUtT3ve2rF1i5uTCYqf6lTIqZNxTy1Y3LYMXyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224692; c=relaxed/simple;
	bh=D57LKE1u3NDy9QDKMQFK8Hh8U6hG9jJB59CJi0d0qGA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=snNKvro2yu7TfiZHgtlRYmCnfmxC7RoDwzSO0pGt764cwXnahXkDmBtK1bIpIYdSUlA/2OhVuEUuHF9peFjJFDyVE6mhBm9us/hbiXsd38tH8VJjIQrKRdK5qTPYdDJkp+MK9BAmsx9k4fokx55gYCy1Adu38bvQLTF47VnMjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id BB6A412500D;
	Wed, 14 May 2025 14:11:26 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 773516018BE80;
	Wed, 14 May 2025 14:11:26 +0200 (CEST)
Subject: Re: 6.14.7-rc1: undefined reference to
 `__x86_indirect_its_thunk_array' when CONFIG_CPU_MITIGATIONS is off
To: Peter Zijlstra <peterz@infradead.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <0fd6d544-c045-4cf5-e5ab-86345121b76a@applied-asynchrony.com>
 <f88e97c3-aaa0-a24f-3ef6-f6da38706839@applied-asynchrony.com>
 <20250514113952.GB16434@noisy.programming.kicks-ass.net>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <fe4e737e-d2b4-1d62-d5ef-b6f294f5909e@applied-asynchrony.com>
Date: Wed, 14 May 2025 14:11:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250514113952.GB16434@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-05-14 13:39, Peter Zijlstra wrote:
> On Wed, May 14, 2025 at 12:13:29PM +0200, Holger Hoffstätte wrote:
>> cc: peterz
>>
>> On 2025-05-14 09:45, Holger Hoffstätte wrote:
>>> While trying to build 6.14.7-rc1 with CONFIG_CPU_MITIGATIONS unset:
>>>
>>>     LD      .tmp_vmlinux1
>>> ld: arch/x86/net/bpf_jit_comp.o: in function `emit_indirect_jump':
>>> /tmp/linux-6.14.7/arch/x86/net/bpf_jit_comp.c:660:(.text+0x97e): undefined reference to `__x86_indirect_its_thunk_array'
>>> make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
>>> make[1]: *** [/tmp/linux-6.14.7/Makefile:1234: vmlinux] Error 2
>>> make: *** [Makefile:251: __sub-make] Error 2
>>>
>>> - applying 9f35e33144ae aka "x86/its: Fix build errors when CONFIG_MODULES=n"
>>> did not help
>>>
>>> - mainline at 9f35e33144ae does not have this problem (same config)
>>>
>>> Are we missing a commit in stable?
>>
>> It seems commit e52c1dc7455d ("x86/its: FineIBT-paranoid vs ITS") [1]
>> is missing in the stable queue. It replaces the direct array reference
>> in bpf_jit_comp.c:emit_indirect_jump() with a mostly-empty function stub
>> when !CONFIG_MITIGATION_ITS, which is why mainline built and -stable
>> does not.
>>
>> Unfortunately it does not seem to apply on top of 6.14.7-rc1 at all.
>> Any good suggestions?
>>
>> thanks
>> Holger
>>
>> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e52c1dc7455d32c8a55f9949d300e5e87d011fa6
> 
> Right, this is forever the problem with these embargoed things that
> side-step the normal development cycle and need to be backported to hell
> :/
> 
> Let me go update this stable.git thing.
> 
> /me twiddles thumbs for a bit, this is one fat tree it is..
> 
> Argh, I needed stable-rc.git
> 
> more thumb twiddling ...
> 
> simply picking the few hunks from that fineibt commit should do the
> trick I think.
> 
> /me stomps on it some ... voila! Not the prettiest thing, but definilty
> good enough I suppose. Builds now, must be perfect etc.. :-)
> 
> ---
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 47948ebbb409..f2294784babc 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -6,6 +6,7 @@
>   #include <linux/stringify.h>
>   #include <linux/objtool.h>
>   #include <asm/asm.h>
> +#include <asm/bug.h>
>   
>   #define ALT_FLAGS_SHIFT		16
>   
> @@ -128,10 +129,17 @@ static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
>   extern void its_init_mod(struct module *mod);
>   extern void its_fini_mod(struct module *mod);
>   extern void its_free_mod(struct module *mod);
> +extern u8 *its_static_thunk(int reg);
>   #else /* CONFIG_MITIGATION_ITS */
>   static inline void its_init_mod(struct module *mod) { }
>   static inline void its_fini_mod(struct module *mod) { }
>   static inline void its_free_mod(struct module *mod) { }
> +static inline u8 *its_static_thunk(int reg)
> +{
> +	WARN_ONCE(1, "ITS not compiled in");
> +
> +	return NULL;
> +}
>   #endif
>   
>   #if defined(CONFIG_MITIGATION_RETHUNK) && defined(CONFIG_OBJTOOL)
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 7a10e3ed5d0b..48fd04e90114 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -240,6 +272,13 @@ static void *its_allocate_thunk(int reg)
>   	return its_init_thunk(thunk, reg);
>   }
>   
> +u8 *its_static_thunk(int reg)
> +{
> +	u8 *thunk = __x86_indirect_its_thunk_array[reg];
> +
> +	return thunk;
> +}
> +
>   #endif
>   
>   /*
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a5b65c09910b..a31e58c6d89e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -663,7 +663,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
>   
>   	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
>   		OPTIMIZER_HIDE_VAR(reg);
> -		emit_jump(&prog, &__x86_indirect_its_thunk_array[reg], ip);
> +		emit_jump(&prog, its_static_thunk(reg), ip);
>   	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
>   		EMIT_LFENCE();
>   		EMIT2(0xFF, 0xE0 + reg);
> 

Can confirm that it now links, as expected. Just in case:

   Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Thank you!

cheers
Holger

