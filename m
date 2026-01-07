Return-Path: <stable+bounces-206195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63190CFF901
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA78131C2791
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712E33A9D5;
	Wed,  7 Jan 2026 17:55:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1C33BBB8;
	Wed,  7 Jan 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808554; cv=none; b=ch8V0N178Rbgg6LMF8DhO6e9C3a+UZckxxBq+GO9MLuu6bHAqXACGszAzY9KWFjzBKbvFaRTEzRwXMkoZ43KokBUE+rxzvck3vd0u/XRRWWarlU4jxnPx7oDZnNaGWlLqCiWq/Z8GEoVbGw/eapgI6FC6HLk20jPu7QQIGmjxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808554; c=relaxed/simple;
	bh=1lRn2piInez3ev2oqRjOMUDIpyzbE0FPizQmQSR2JQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElIVBdrhrcLaQuRNJLlrWCiTFQ45cfEZ70i0QesoW88PV4M+gCvpSphLc9iV2ilsOR8ZdkoN/oy1yyzcanGUjUW6GrdeOkT1CXakFSmjckM5WVqUdNg9/5eoOOlovCRPgQXws9XxllVmHwMtE5Dq8glyUVuD1IQEuo+YQi6mgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F046497;
	Wed,  7 Jan 2026 09:55:38 -0800 (PST)
Received: from [10.57.48.49] (unknown [10.57.48.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A763F5A1;
	Wed,  7 Jan 2026 09:55:42 -0800 (PST)
Message-ID: <7cd7b4f0-7aa5-4ca0-adc6-44d968c1ed48@arm.com>
Date: Wed, 7 Jan 2026 17:55:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: errata: Workaround for SI L1 downstream
 coherency issue
To: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: Lucas Wei <lucaswei@google.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 sjadavani@google.com, kernel test robot <lkp@intel.com>,
 stable@vger.kernel.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, smostafa@google.com
References: <20251229033621.996546-1-lucaswei@google.com>
 <87o6ndduye.wl-maz@kernel.org> <aV6K7QnUa7jDpKw-@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aV6K7QnUa7jDpKw-@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-07 4:33 pm, Will Deacon wrote:
> Hey Marc,
> 
> On Thu, Jan 01, 2026 at 06:55:05PM +0000, Marc Zyngier wrote:
>> On Mon, 29 Dec 2025 03:36:19 +0000,
>> Lucas Wei <lucaswei@google.com> wrote:
>>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>>> index 8cb3b575a031..5c0ab6bfd44a 100644
>>> --- a/arch/arm64/kernel/cpu_errata.c
>>> +++ b/arch/arm64/kernel/cpu_errata.c
>>> @@ -141,6 +141,30 @@ has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
>>>   	return (ctr_real != sys) && (ctr_raw != sys);
>>>   }
>>>   
>>> +#ifdef CONFIG_ARM64_ERRATUM_4311569
>>> +static DEFINE_STATIC_KEY_FALSE(arm_si_l1_workaround_4311569);
>>> +static int __init early_arm_si_l1_workaround_4311569_cfg(char *arg)
>>> +{
>>> +	static_branch_enable(&arm_si_l1_workaround_4311569);
>>> +	pr_info("Enabling cache maintenance workaround for ARM SI-L1 erratum 4311569\n");
>>> +
>>> +	return 0;
>>> +}
>>> +early_param("arm_si_l1_workaround_4311569", early_arm_si_l1_workaround_4311569_cfg);
>>> +
>>> +/*
>>> + * We have some earlier use cases to call cache maintenance operation functions, for example,
>>> + * dcache_inval_poc() and dcache_clean_poc() in head.S, before making decision to turn on this
>>> + * workaround. Since the scope of this workaround is limited to non-coherent DMA agents, its
>>> + * safe to have the workaround off by default.
>>> + */
>>> +static bool
>>> +need_arm_si_l1_workaround_4311569(const struct arm64_cpu_capabilities *entry, int scope)
>>> +{
>>> +	return static_branch_unlikely(&arm_si_l1_workaround_4311569);
>>> +}
>>> +#endif
>>
>> But this isn't a detection mechanism. That's relying on the user
>> knowing they are dealing with broken hardware. How do they find out?
> 
> Sadly, I'm not aware of a mechanism to detect this reliably at runtime
> but adding Robin in case he knows of one. Linux generally doesn't need
> to worry about the SLC, so we'd have to add something to DT to detect
> it and even then I don't know whether it's something that is typically
> exposed to non-secure...
> 
> We also need the workaround to be up early enough that drivers don't
> run into issues, so that would probably involve invasive surgery in the
> DT parsing code.

Indeed even if we did happen to know where the interconnect registers 
are, I'm not sure there's any ID bit for the relevant configuration 
option, plus that still wouldn't be accurate anyway - it's fine to have 
a downstream cache/PoS *without* any back-door observers, so the actual 
problematic condition we need to detect is outside the SI IP altogether. 
It's a matter of SoC-level integration, so AFAICS the realistic options 
are likely to be:

  - SMCCC SOC_ID (if available early enough)
  - Match a top-level SoC/platform compatible out of the flat DT
  - Just trust that affected platforms' bootloaders will know to add the 
command-line option :/

>> You don't even call out what platform is actually affected...
> 
> Well, it's an Android phone :)
> 
> More generally, it's going to be anything with an Arm "SI L1" configured
> to work with non-coherent DMA agents below it. Christ knows whose bright
> idea it was to put "L1" in the name of the thing containing the system
> cache.

I'm still thankful the Neoverse product line skipped "MMU S1" and "MMU 
S2"...

>> The other elephant in the room is virtualisation: how does a guest
>> performing CMOs deals with this? How does it discover the that the
>> host is broken? I also don't see any attempt to make KVM handle the
>> erratum on behalf of the guest...
> 
> A guest shouldn't have to worry about the problem, as it only affects
> clean to PoC for non-coherent DMA agents that reside downstream of the
> SLC in the interconnect. Since VFIO doesn't permit assigning
> non-coherent devices to a guest, guests shouldn't ever need to push
> writes that far (and FWB would cause bigger problems if that was
> something we wanted to support)
> 
> +Mostafa to keep me honest on the VFIO front.

I don't think we actually prevent non-coherent devices being assigned, 
we just rely on the IOMMU supporting IOMMU_CAP_CACHE_COHERENCY. Thus if 
there's an I/O-coherent SMMU then it could end up being permitted, 
however I would hope that either the affected devices are not behind 
such an SMMU, or at least that if the SMMU imposes cacheable attributes 
then that prevents traffic from taking the back-door path to RAM.

Thanks,
Robin.

