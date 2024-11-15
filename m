Return-Path: <stable+bounces-93516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603E9CDDB0
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94BE280A1E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F0A1B218E;
	Fri, 15 Nov 2024 11:47:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB452F9E
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671268; cv=none; b=mYdkfq9AmPCuTFgLF3m3lQ/6OrXnzKPitE33pm85/eIHmm8jMOvMuR85sb9rPK3eKFkRCFwwMjzMAgokHcpRpoVsCqfhxhJuXiSt0LtNYMo91eU7fUAapa6k+DLepsf/EPtX8ekr4KlCGH+GoOE+GjxI8gpcvGGafIGrpdR41DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671268; c=relaxed/simple;
	bh=iB4fsaJnn1iKj81v9nFYoz25EWj8BquPxoskapPwDyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tguMn1rVCcQd+GchkIJDmh4GuK/JGbizW51QtbrDz3gTwBw845PehA0xlS7LE9iZggNcL4d8MMTdepwxCH5GJx9zH3asL/UhxdxXezYFYui45SOBmDudJ52vgcPULMbSPs3rle/lXLBc0K4jix+Ud1Pzn/yPrmY+MKXwifAGIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C5C11476;
	Fri, 15 Nov 2024 03:48:15 -0800 (PST)
Received: from [10.163.46.21] (unknown [10.163.46.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8EAF3F6A8;
	Fri, 15 Nov 2024 03:47:41 -0800 (PST)
Message-ID: <84b7b8fb-8f84-4a36-8277-893cba1d6381@arm.com>
Date: Fri, 15 Nov 2024 17:17:39 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm64/mm: Override PARange for !LPA2 and use it
 consistently
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Kees Cook <keescook@chromium.org>,
 stable@vger.kernel.org
References: <20241111083544.1845845-8-ardb+git@google.com>
 <20241111083544.1845845-10-ardb+git@google.com>
 <ea124997-8dee-457c-bef1-d5d829c84da3@arm.com>
 <CAMj1kXF1kYaiJmQXdvfSzGmgO78cechpm-JC=n3yGhRBXQF6nw@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAMj1kXF1kYaiJmQXdvfSzGmgO78cechpm-JC=n3yGhRBXQF6nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/24 14:30, Ard Biesheuvel wrote:
> Hi Anshuman,
> 
> On Fri, 15 Nov 2024 at 07:05, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> On 11/11/24 14:05, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> When FEAT_LPA{,2} are not implemented, the ID_AA64MMFR0_EL1.PARange and
>>> TCR.IPS values corresponding with 52-bit physical addressing are
>>> reserved.
>>>
>>> Setting the TCR.IPS field to 0b110 (52-bit physical addressing) has side
>>> effects, such as how the TTBRn_ELx.BADDR fields are interpreted, and so
>>> it is important that disabling FEAT_LPA2 (by overriding the
>>> ID_AA64MMFR0.TGran fields) also presents a PARange field consistent with
>>> that.
>>>
>>> So limit the field to 48 bits unless LPA2 is enabled, and update
>>> existing references to use the override consistently.
>>>
>>> Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm64/include/asm/assembler.h    | 5 +++++
>>>  arch/arm64/kernel/cpufeature.c        | 2 +-
>>>  arch/arm64/kernel/pi/idreg-override.c | 9 +++++++++
>>>  arch/arm64/kernel/pi/map_kernel.c     | 6 ++++++
>>>  arch/arm64/mm/init.c                  | 2 +-
>>>  5 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>>> index 3d8d534a7a77..ad63457a05c5 100644
>>> --- a/arch/arm64/include/asm/assembler.h
>>> +++ b/arch/arm64/include/asm/assembler.h
>>> @@ -343,6 +343,11 @@ alternative_cb_end
>>>       // Narrow PARange to fit the PS field in TCR_ELx
>>>       ubfx    \tmp0, \tmp0, #ID_AA64MMFR0_EL1_PARANGE_SHIFT, #3
>>>       mov     \tmp1, #ID_AA64MMFR0_EL1_PARANGE_MAX
>>> +#ifdef CONFIG_ARM64_LPA2
>>> +alternative_if_not ARM64_HAS_VA52
>>> +     mov     \tmp1, #ID_AA64MMFR0_EL1_PARANGE_48
>>> +alternative_else_nop_endif
>>> +#endif
>>
>> I guess this will only take effect after cpu features have been finalized
>> but will not be applicable for __cpu_setup() during primary and secondary
>> cpu bring up during boot.
>>
> 
> It is the other way around, actually. This limit will always be

Right, missed the '_if_not' part.

> applied on primary boot, which is why IPS is updated again in
> set_ttbr0_for_lpa2() [below]. Before booting the secondaries (or other
> subsequent invocations of this code, e.g., in the resume path), this
> MOV will be NOPed out if LPA2 support is enabled.

Understood.

> 
> 
>>>       cmp     \tmp0, \tmp1
>>>       csel    \tmp0, \tmp1, \tmp0, hi
>>>       bfi     \tcr, \tmp0, \pos, #3
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 37e4c02e0272..6f5137040ff6 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -3399,7 +3399,7 @@ static void verify_hyp_capabilities(void)
>>>               return;
>>>
>>>       safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
>>> -     mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
>>> +     mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>>
>> Small nit, should be renamed as safe_mmfr0 to be consistent with safe_mmfr1 ?
>>
> 
> safe_mmfr1 exists because there is also mmfr1 in the same scope. No
> such distinction exists for mmfr0, so I opted for keeping the name.

Fair enough.

> 
>>>       mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
>>>
>>>       /* Verify VMID bits */
>>> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
>>> index 22159251eb3a..c6b185b885f7 100644
>>> --- a/arch/arm64/kernel/pi/idreg-override.c
>>> +++ b/arch/arm64/kernel/pi/idreg-override.c
>>> @@ -83,6 +83,15 @@ static bool __init mmfr2_varange_filter(u64 val)
>>>               id_aa64mmfr0_override.val |=
>>>                       (ID_AA64MMFR0_EL1_TGRAN_LPA2 - 1) << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
>>>               id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
>>> +
>>> +             /*
>>> +              * Override PARange to 48 bits - the override will just be
>>> +              * ignored if the actual PARange is smaller, but this is
>>> +              * unlikely to be the case for LPA2 capable silicon.
>>> +              */
>>> +             id_aa64mmfr0_override.val |=
>>> +                     ID_AA64MMFR0_EL1_PARANGE_48 << ID_AA64MMFR0_EL1_PARANGE_SHIFT;
>>> +             id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_PARANGE_SHIFT;
>> Could these be used instead ?
>>
>> SYS_FIELD_PREP_ENUM(ID_AA64MMFR0_EL1, PARANGE, 48)
>> ID_AA64MMFR0_EL1_PARANGE_MASK ?
>>
> 
> Yes, but 2 lines before, there is another occurrence of this idiom,
> and I did not want to deviate from that.
> 
> We could update both, or update the other one first in a separate
> patch, I suppose.

Sure, have your choice, don't have a strong view on either method.

> 
> 
>>
>>>       }
>>>  #endif
>>>       return true;
>>> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
>>> index f374a3e5a5fe..e57b043f324b 100644
>>> --- a/arch/arm64/kernel/pi/map_kernel.c
>>> +++ b/arch/arm64/kernel/pi/map_kernel.c
>>> @@ -136,6 +136,12 @@ static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
>>>  {
>>>       u64 sctlr = read_sysreg(sctlr_el1);
>>>       u64 tcr = read_sysreg(tcr_el1) | TCR_DS;
>>> +     u64 mmfr0 = read_sysreg(id_aa64mmfr0_el1);
>>> +     u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
>>> +                                                        ID_AA64MMFR0_EL1_PARANGE_SHIFT);
>>> +
>>> +     tcr &= ~TCR_IPS_MASK;
>>
>> Could there be a different IPS value in TCR ? OR is this just a normal
>> clean up instead.
>>
> 
> As explained above, TCR.IPS will be capped at 48 bits up to this point.

Alright

> 
>>> +     tcr |= parange << TCR_IPS_SHIFT;
>>
>> Wondering if FIELD_PREP() could be used here.
>>
> 
> AIUI we'd end up with
> 
> tcr &= ~TCR_IPS_MASK;
> tcr |= FIELD_PREP(TCR_IPS_MASK, parange);
> 
> Is that really so much better?

Not really, can be left unchanged.

> 
> 
>>>
>>>       asm("   msr     sctlr_el1, %0           ;"
>>>           "   isb                             ;"
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index d21f67d67cf5..4db9887b2aef 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -280,7 +280,7 @@ void __init arm64_memblock_init(void)
>>>
>>>       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>>>               extern u16 memstart_offset_seed;
>>> -             u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
>>> +             u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>>
>> Could this have a comment explaining the need for sanitized value ?
>>
> 
> Sure. Actually, it shouldn't make any difference here (unless we allow
> PARange to be narrowed even further, which might make sense if we care
> about enabling randomization of the linear map on systems where
> PARange is much larger than the size of the physical address space
> that is actually populated). However, for consistency, it is better to
> avoid the 52-bit PARange if LPA2 is disabled.

Got it, thanks for the explanation.

> 
> 
>>>               int parange = cpuid_feature_extract_unsigned_field(
>>>                                       mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
>>>               s64 range = linear_region_size -
>>
>> Otherwise LGTM.
> 
> Thanks!

