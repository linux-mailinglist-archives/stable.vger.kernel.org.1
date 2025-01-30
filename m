Return-Path: <stable+bounces-111734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8255A2348A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB661884255
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8AD1F0E41;
	Thu, 30 Jan 2025 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YY+t7owF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808671F03F2
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264364; cv=none; b=rsZnEqMhHdyp60+8e5xPt/9FwDrENIxYACrM9PAFU8QvFPQ4epLsVE1M2GL8eXhTeDoXx9X0DCZHhJknEDwI5R70IGPpj9acYv6ilss4l6srcTPOxj4rv5sf/wwz7EPJuK+5jYuWn3C7TiyB3o3x/lJ40cIF7MVXXHa1iqutpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264364; c=relaxed/simple;
	bh=csWxAYG1dByi5AlAZd+J0/HIf6l/oOlji3xkDKBmXds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYimzs9oo+ujG/9+5RekdC3p7db2+FmNIOhymqsaue4SA3HMmpHzUmpO2Ec/4TqSKy8BqALk8zZan3WhAuSzpnRNldXNgMPkBj9DmfGN3AUdDbUD6DR7xctkso75J2tfKA5Y7DAtUpeTXd38BGTjUYT656ZGqiC9jsykDdPjAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YY+t7owF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71deb3745easo254910a34.3
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738264360; x=1738869160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej/HJej+nDo1kjKJ6ZoMtjoZevPYe999ZPstxeFX4iY=;
        b=YY+t7owFUBIVe3rV4voL2Q7M8krXKfK0ksaklP5/p6BBfnHGtd3Z27vALrWA9rZVOI
         P7u/g4VzkFumTMJGPp4dL+VufTLegDrQmTNHOhuUDXpTRZRtXjT4fLvtpbd4YWrNVbAJ
         s00XKhuqghRYZy7DD6kgkqSKJP7VlNwjQOiCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738264360; x=1738869160;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej/HJej+nDo1kjKJ6ZoMtjoZevPYe999ZPstxeFX4iY=;
        b=IwjX7BGOWlltWfvtQFIxA/3ET6N3r4Q2kOA4L48KogJJb09XnsKUcdjj3WzirjCCsn
         OJBVfUb07AehUb74ZczNAXd0YPf1du7V5Jn1Chl+if8jhGEfrImEAVpVJrom9mfwma0N
         NQ6JRoDQZGOyBvj4Ga9MVP3kpNRxbKQ7gqIUezwHZWzOejOBjx2lMLPJeBT6CneFfUq2
         D9rJ4nV0Hpq1x/C8sKIreDYGWgAR4nmO3Ol8jpl0quQ6CanxrT7Itfs9O9HGPKQ/MiQE
         OMLZiSfnXj+HyoPlPzIL7WTtMyDqPOTba7mAQuP8bVKAqDzYOhBxNTM+0pIsl6s3RPkr
         Bjmw==
X-Forwarded-Encrypted: i=1; AJvYcCWuhwjYgNZ4OcSi82fLFlcxF5X/j9kYiP/SugxkAfQWEBjsdY4gfhmt6WvJM0nAchfQggowiPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTYxu56M0oGAcWVq44QIYidPNACZUeS0JEBsQuEqYFUpriWoc
	dsct9rku9M5IjOsU0r2HOVFshqvnyWekDL7IesqFicijEaYMhWL8dkkmbZz+cw==
X-Gm-Gg: ASbGncsCeT6SaEGSfv87kWNaefoYk4MeFbRfYc0mceOuyMReRn5kwGWQdgjmAgC1kRR
	ZNktUUyte6mFKK0MOdaqrAaIELH7Up9pze/nwRIa9RUqSp8AoZAozBsUNUNUFI1vfMo8owjHazf
	WRjssr+tZGgWNUrT0hs+8CLTDWPAFQ89b9alGZ47ZyCazQlFegh9SeIPCE0DTLyN6Jx1xZudwPr
	zsrAixNH3gw3fzh6MqhQus4gfbFyAYYm0pO58o4BaCgvd1/dz1ZTmKCO/I/DadQ0qVbTtJbWuzd
	26p+zVaxi091WovDASRgwlkKzxcnEiGrVkyORHKZ8ug4AYVbDlU9LPk=
X-Google-Smtp-Source: AGHT+IHMLt7sw59zjA4AxgytvkGEZMWpIHVweCwdf6FZU4uum50SrSuqctHjx4dowMEouH+bo/X6wQ==
X-Received: by 2002:a05:6830:6517:b0:71d:f3be:438c with SMTP id 46e09a7af769-72656731295mr5817714a34.4.1738264360461;
        Thu, 30 Jan 2025 11:12:40 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617bad7fsm456338a34.2.2025.01.30.11.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 11:12:39 -0800 (PST)
Message-ID: <32d37869-003c-46eb-bee5-00d561daddbd@broadcom.com>
Date: Thu, 30 Jan 2025 11:12:37 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Anshuman Khandual <anshuman.khandual@arm.com>, Will Deacon
 <will@kernel.org>, Steven Price <steven.price@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Petr Tesarik <ptesarik@suse.com>, Mark Rutland <mark.rutland@arm.com>,
 Joey Gouly <joey.gouly@arm.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
 <20250109165419.1623683-2-florian.fainelli@broadcom.com>
 <62786457-d4a1-4861-8bec-7e478626f4db@broadcom.com>
 <2025011247-enable-freezing-ffa2@gregkh>
 <27bbea11-61fa-4f41-8b39-8508f2d2e385@broadcom.com>
 <2025012002-tactics-murky-aaab@gregkh>
 <41550c7f-1313-41b4-aa2e-cb4809ad68c2@broadcom.com>
 <2025012938-abreast-explain-f5f7@gregkh>
 <1fc6d5c8-80ec-4d6b-bc14-c584d89c15b4@broadcom.com>
 <CAMj1kXHheRQYHddgehLbZot6o-xAxkbeHBUq7nS8npyB9A0FvQ@mail.gmail.com>
 <8994e7c5-812c-4605-9bdf-18a5b402196a@broadcom.com>
 <CAMj1kXHhgyRSzSgRQfWKRseFSifV1X=OqcTkL0_7ZWfi+UjhcA@mail.gmail.com>
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
In-Reply-To: <CAMj1kXHhgyRSzSgRQfWKRseFSifV1X=OqcTkL0_7ZWfi+UjhcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 02:05, Ard Biesheuvel wrote:
> On Thu, 30 Jan 2025 at 00:31, Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 1/29/25 14:15, Ard Biesheuvel wrote:
>>> On Wed, 29 Jan 2025 at 18:45, Florian Fainelli
>>> <florian.fainelli@broadcom.com> wrote:
>>>>
>>>> On 1/29/25 01:17, Greg KH wrote:
>>>>> On Mon, Jan 20, 2025 at 08:33:12AM -0800, Florian Fainelli wrote:
>>>>>>
>>>>>>
>>>>>> On 1/20/2025 5:59 AM, Greg KH wrote:
>>>>>>> On Mon, Jan 13, 2025 at 07:44:50AM -0800, Florian Fainelli wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/12/2025 3:54 AM, Greg KH wrote:
>>>>>>>>> On Thu, Jan 09, 2025 at 09:01:13AM -0800, Florian Fainelli wrote:
>>>>>>>>>> On 1/9/25 08:54, Florian Fainelli wrote:
>>>>>>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>>>>
>>>>>>>>>>> commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
>>>>>>>>>>>
>>>>>>>>>>> As a hardening measure, we currently randomize the placement of
>>>>>>>>>>> physical memory inside the linear region when KASLR is in effect.
>>>>>>>>>>> Since the random offset at which to place the available physical
>>>>>>>>>>> memory inside the linear region is chosen early at boot, it is
>>>>>>>>>>> based on the memblock description of memory, which does not cover
>>>>>>>>>>> hotplug memory. The consequence of this is that the randomization
>>>>>>>>>>> offset may be chosen such that any hotplugged memory located above
>>>>>>>>>>> memblock_end_of_DRAM() that appears later is pushed off the end of
>>>>>>>>>>> the linear region, where it cannot be accessed.
>>>>>>>>>>>
>>>>>>>>>>> So let's limit this randomization of the linear region to ensure
>>>>>>>>>>> that this can no longer happen, by using the CPU's addressable PA
>>>>>>>>>>> range instead. As it is guaranteed that no hotpluggable memory will
>>>>>>>>>>> appear that falls outside of that range, we can safely put this PA
>>>>>>>>>>> range sized window anywhere in the linear region.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>>>>>> Cc: Steven Price <steven.price@arm.com>
>>>>>>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>>>>>>>> Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
>>>>>>>>>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>>>>>>>
>>>>>>>>>> Forgot to update the patch subject, but this one is for 5.10.
>>>>>>>>>
>>>>>>>>> You also forgot to tell us _why_ this is needed :(
>>>>>>>>
>>>>>>>> This is explained in the second part of the first paragraph:
>>>>>>>>
>>>>>>>> The consequence of this is that the randomization offset may be chosen such
>>>>>>>> that any hotplugged memory located above memblock_end_of_DRAM() that appears
>>>>>>>> later is pushed off the end of the linear region, where it cannot be
>>>>>>>> accessed.
>>>>>>>>
>>>>>>>> We use both memory hotplug and KASLR on our systems and that's how we
>>>>>>>> eventually found out about the bug.
>>>>>>>
>>>>>>> And you still have 5.10.y ARM64 systems that need this?  Why not move to
>>>>>>> a newer kernel version already?
>>>>>>
>>>>>> We still have ARM64 systems running 5.4 that need this, and the same bug
>>>>>> applies to 5.10 that we used to support but dropped in favor of 5.15/6.1.
>>>>>> Those are the kernel versions used by Android, and Android TV in particular,
>>>>>> so it's kind of the way it goes for us.
>>>>>>
>>>>>>>
>>>>>>> Anyway, I need an ack from the ARM64 maintainers that this is ok to
>>>>>>> apply here before I can take it.
>>>>>>
>>>>>> Just out of curiosity, the change is pretty innocuous and simple to review,
>>>>>> why the extra scrutiny needed here?
>>>>>
>>>>> Why shouldn't the maintainers review a proposed backport patch for core
>>>>> kernel code that affects everyone who uses that arch?
>>>>
>>>> They should, but they are not, we can keep sending messages like those
>>>> in the hope that someone does, but clearly that is not working at the
>>>> moment.
>>>>
>>>> This patch cherry picked cleanly into 5.4 and 5.10 maybe they just trust
>>>> whoever submit stable bugfixes to have done their due diligence, too, I
>>>> don't know how to get that moving now but it fixes a real problem we
>>>> observed.
>>>>
>>>
>>> FWIW, I understand why this might be useful when running under a
>>> non-KVM hypervisor that relies on memory hotplug to perform resource
>>> balancing between VMs. But the upshot of this change is that existing
>>> systems that do not rely on memory hotplug at all will suddenly lose
>>> any randomization of the linear map if its CPU happens to be able to
>>> address more than ~40 bits of physical memory. So I'm not convinced
>>> this is a change we should make for these older kernels.
>>
>> Are there other patches that we could backport in order not to lose the
>> randomization in the linear range?
> 
> No, this never got fixed. Only recently, I proposed some patches that
> allow the PARange field in the CPU id registers to be overridden, and
> this would also bring back the ability to randomize the linear map on
> CPUs with a wide PARange.
> 
> Android also enables memory hotplug, and so I didn't bother with
> preserving the old behavior when memory hotplug is disabled, and so
> linear map randomization has basically been disabled ever since
> (unless you are using an older core with only 40 physical address
> bits).

We are using Brahma-B53 cores with 5.4 primarily which are 
architecturally equivalent to a Cortex-A53 where 
ID_AA64MMFR0_EL1.PARange = 0b0010 -> 40 bits only. The other platform 
that we use has a Cortex-A72 that supports up to 44 bits of PA, but that 
one could probably get a custom kernel with memory hotplug disabled.

> 
> Nobody ever complained about losing this linear map randomization, but
> taking it away at this point from 5.4 and 5.10 goes a bit too far imo.

Fair enough thanks for the background!
-- 
Florian

