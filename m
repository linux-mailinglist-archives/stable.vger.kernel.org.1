Return-Path: <stable+bounces-111206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2589DA22392
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DB018833A0
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A731E0084;
	Wed, 29 Jan 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IUAExHMk"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E319259D
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173938; cv=none; b=UOaat8S2NSxCzUceDyGT9ihIYuQ31t4Y2ooRWJ9X0uJdZnCM+RZ5ibh4JzvY5/CVMx/BRZFkmaTgFfmTD3iGoUKLtq0daXFSDPll3lhue5L/OpaUpOUEx7l0y/Z8DS16pNQeYBPkpQZqYn4mRSu00261fGfRWN9BPPheIWQyV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173938; c=relaxed/simple;
	bh=tWQC08RMBAfbXDyJ6v/gxwUgNiQfEOP3L3RrWumRnDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWCnZGUu7syEVymOt4SqXhWmhQ97lmqATq4MSk8iRADLmpLxrhB1hIqfjD7+MzdwvtltWJdDRi/sYMycs9NzWgXaSQFnzdw6Yw1AqkDvQ7M/DjRpU80MZcG7cO05rszbU4Nrost+aFwuO4wb31Td2QbGBg9S3xmoAqBYVK/qxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IUAExHMk; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eb3c143727so472790b6e.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738173935; x=1738778735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DrCQOuFa6l/xRX2rnecr/gRUO/M95pHUhfJz5UMBqm4=;
        b=IUAExHMkETAU/A4/0yD6qntvATYKDSyVVM0pyRtfTKiVUwTj4zE06UVFvFUg0134kz
         AgioisHEd/BWW+Pn0WJp3E4qMc/jaxlo68O1xeakWnIuCMsCmIgQjyP/WlwIdffuvjm7
         djNthvJIrVT2hciPpY+jIqTFKwLOTmGv2G2ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738173935; x=1738778735;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrCQOuFa6l/xRX2rnecr/gRUO/M95pHUhfJz5UMBqm4=;
        b=bAQ36WBDAKsJ3fp3PpK+IEMQgviDNcDjfH2MQwEC3SontMLlom25JnVrtq0O6ZZ3NP
         r6TZf3pSnLzme3ruN1zBYTL70BRaeGqU09bAkPHAxT7MbKlQEYczIzFvXCSvgUrj+Lk6
         ID6JKqcYvIdXbAbv+ImKH6O9AA7coJ/Se/dF0bU7T9M4gJMlc5SUNrPKFd0hfF5AvGsW
         3CYJkOc0M5bEHGbvJJWrMWDTKwE0605AWooDZgINiRwsz51P4lJoAUzFNafxFIhTlHNK
         2Ef/8j8AkBcw4eMMEWBEKhrwJ8IEdP3Pj1+db+byrmXghEOFvdLIkmj2MR2tzuqJdfmI
         RnIg==
X-Gm-Message-State: AOJu0Yy1RJYsZ0krXyftTC6GQ51b28rnnULKb/q7Mns6wMoWyb9i7cTS
	FxsT5UseAtA/H0Tb6FerFq3BTPFYsV6WRe+pZ+0NIksv4CAngVIfn+s7BIkm2A==
X-Gm-Gg: ASbGncuPX7akRIUK0Iq/a/1aaV3mQs7T6GEUqF2kGSrJ6/1OkDDk4WUukG6S6cJI//B
	LX0r8I6IEgTWWgrR8KkmxtuGWBFlRH2G5zezZG2gJGlXLhp9RvrUSkEOHeoUveIHY9V926vgBj8
	lmILff7PvWgmXh8mNbbISeBEzr3PzWrH78A+rCDxG6DZeMhdNZNsbIlad4rqOblG+Nk/pg/nd+i
	fNTla14m1cZIMeTMLAhLKX8BvwohXtPvnvADWXc8K3i4HK6sDQfsnJN/6NlRFJ0FNZ9OjISJ8yO
	EiaWqVQd1pfcJmukVT5Fg8OK7uPmrjzLdg98FTGfmyby3LltTKxgXMw=
X-Google-Smtp-Source: AGHT+IHK6s97CUwK+kadE59Hks/0lrOCzfa2i8Af29kyMeDIF8LB0pBhMRxIhpWy17frQ5IaPxmD8g==
X-Received: by 2002:a05:6808:1a1c:b0:3ea:4b5c:60a8 with SMTP id 5614622812f47-3f330e930e6mr167264b6e.17.1738173934845;
        Wed, 29 Jan 2025 10:05:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09bc270sm3930646b6e.44.2025.01.29.10.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 10:05:33 -0800 (PST)
Message-ID: <213f28ff-2034-467e-8269-58b6e6f578df@broadcom.com>
Date: Wed, 29 Jan 2025 10:05:29 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 5.4] arm64: mm: account for hotplug memory when
 randomizing the linear region
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Will Deacon
 <will@kernel.org>, Steven Price <steven.price@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Petr Tesarik <ptesarik@suse.com>, Joey Gouly <joey.gouly@arm.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Baoquan He <bhe@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
 <2025011217-swizzle-unusual-dd7b@gregkh>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <2025011217-swizzle-unusual-dd7b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/12/25 03:53, Greg KH wrote:
> On Thu, Jan 09, 2025 at 08:54:16AM -0800, Florian Fainelli wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
>>
>> As a hardening measure, we currently randomize the placement of
>> physical memory inside the linear region when KASLR is in effect.
>> Since the random offset at which to place the available physical
>> memory inside the linear region is chosen early at boot, it is
>> based on the memblock description of memory, which does not cover
>> hotplug memory. The consequence of this is that the randomization
>> offset may be chosen such that any hotplugged memory located above
>> memblock_end_of_DRAM() that appears later is pushed off the end of
>> the linear region, where it cannot be accessed.
>>
>> So let's limit this randomization of the linear region to ensure
>> that this can no longer happen, by using the CPU's addressable PA
>> range instead. As it is guaranteed that no hotpluggable memory will
>> appear that falls outside of that range, we can safely put this PA
>> range sized window anywhere in the linear region.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   arch/arm64/mm/init.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index cbcac03c0e0d..a6034645d6f7 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -392,15 +392,18 @@ void __init arm64_memblock_init(void)
>>   
>>   	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>>   		extern u16 memstart_offset_seed;
>> -		u64 range = linear_region_size -
>> -			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
>> +		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
>> +		int parange = cpuid_feature_extract_unsigned_field(
>> +					mmfr0, ID_AA64MMFR0_PARANGE_SHIFT);
>> +		s64 range = linear_region_size -
>> +			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
>>   
>>   		/*
>>   		 * If the size of the linear region exceeds, by a sufficient
>> -		 * margin, the size of the region that the available physical
>> -		 * memory spans, randomize the linear region as well.
>> +		 * margin, the size of the region that the physical memory can
>> +		 * span, randomize the linear region as well.
>>   		 */
>> -		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
>> +		if (memstart_offset_seed > 0 && range >= (s64)ARM64_MEMSTART_ALIGN) {
>>   			range /= ARM64_MEMSTART_ALIGN;
>>   			memstart_addr -= ARM64_MEMSTART_ALIGN *
>>   					 ((range * memstart_offset_seed) >> 16);
>> -- 
>> 2.43.0
>>
>>
> 
> You are not providing any information as to WHY this is needed in stable
> kernels at all.  It just looks like an unsolicted backport with no
> changes from upstream, yet no hint as to any bug it fixes.

See the response in the other thread.

> 
> And you all really have hotpluggable memory on systems that are running
> th is old kernel?  Why are they not using newer kernels if they need
> this?  Surely lots of other bugs they need are resolved there, right?

Believe it or not, but memory hotplug works really well for us, in a 
somewhat limited configuration on the 5.4 kernel whereby we simply plug 
memory, and never unplug it thereafter, but still, we have not had to 
carry hotplug related patches other than this one.

Trying to be a good citizen here: one of my colleague has identified an 
upstream fix that works, that we got tested, cherry picked cleanly into 
both 5.4 and 5.10, so it's not even like there was any fuzz.

I was sort of hoping that giving my history of regularly testing stable 
kernels for the past years, as well as submitting a fair amount of 
targeted bug fixes to the stable branches that there would be some level 
of trust here.

Thanks
-- 
Florian

