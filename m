Return-Path: <stable+bounces-132376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B91A8763A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 05:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21FC87A78AE
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 03:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D0C5D738;
	Mon, 14 Apr 2025 03:24:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB9DF5C
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744601090; cv=none; b=o6W/MzMEM0sKW3SDXbdcwRKWGV2Z9O8MO3O/rMc4wH3QqeejAbwGda/tq1Arlpc7kXiK8b+0WfWugJX4nNDpcQhzJGI0mT/yZZfwhC9Kgf1ys3QSgDY0rkL1oVbQcBb/9a/DkhJB5p1RTHQ1nYzK5ZSzJ955XmrQEJxYnomxlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744601090; c=relaxed/simple;
	bh=DXac5AFvvnUwLq7xmBC+1VkfT/YluSXpcGdKs2i1Tjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biNJyLhWFEiFQPtTRDCUzC04idP7gttUcEoemF21QxtXlZwv2pyF2lSXLZa0eyC4nAvcnu3RuL1L/dCb4PuCY7e/nyQzTjyOfnqtGU9vmdMDgMIIa3YEOzKe8BHUMG8Hm5mm4PJ7xl0aZifjyshw7oLISQkInLjD1tFpD8y0URE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51F261007;
	Sun, 13 Apr 2025 20:24:45 -0700 (PDT)
Received: from [10.162.16.153] (unknown [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8963F66E;
	Sun, 13 Apr 2025 20:24:44 -0700 (PDT)
Message-ID: <e2f43f00-2a0b-4604-a91b-dd0e72cd9190@arm.com>
Date: Mon, 14 Apr 2025 08:54:42 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 1/8] perf/arm_pmuv3: Add PMUv3.9 per counter EL0
 access control
To: Rob Herring <robh@kernel.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com
References: <20250410035543.1518500-1-anshuman.khandual@arm.com>
 <20250410035543.1518500-2-anshuman.khandual@arm.com>
 <CAL_JsqKNf5JOWDocjOqmKTi0DMzn1Q_=er1W9JNFuya6Awpikg@mail.gmail.com>
 <f9c54759-6e4e-4c00-8c68-ea73c8fe1fa5@arm.com>
 <CAL_JsqKuxfMbg0U+hBosG-kA_D1+NN8JpBkOebDYAjccV6B6bg@mail.gmail.com>
 <CAL_JsqKqkNXrMWNCD7zgTaS8XhzK5us-i83+7TjY0E88_vn-6Q@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAL_JsqKqkNXrMWNCD7zgTaS8XhzK5us-i83+7TjY0E88_vn-6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/11/25 18:35, Rob Herring wrote:
> On Fri, Apr 11, 2025 at 8:03 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Thu, Apr 10, 2025 at 11:24 PM Anshuman Khandual
>> <anshuman.khandual@arm.com> wrote:
>>>
>>>
>>>
>>> On 4/10/25 22:20, Rob Herring wrote:
>>>> On Wed, Apr 9, 2025 at 10:55 PM Anshuman Khandual
>>>> <anshuman.khandual@arm.com> wrote:
>>>>>
>>>>> From: "Rob Herring (Arm)" <robh@kernel.org>
>>>>>
>>>>> Armv8.9/9.4 PMUv3.9 adds per counter EL0 access controls. Per counter
>>>>> access is enabled with the UEN bit in PMUSERENR_EL1 register. Individual
>>>>> counters are enabled/disabled in the PMUACR_EL1 register. When UEN is
>>>>> set, the CR/ER bits control EL0 write access and must be set to disable
>>>>> write access.
>>>>>
>>>>> With the access controls, the clearing of unused counters can be
>>>>> skipped.
>>>>>
>>>>> KVM also configures PMUSERENR_EL1 in order to trap to EL2. UEN does not
>>>>> need to be set for it since only PMUv3.5 is exposed to guests.
>>>>>
>>>>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>>>>> Link: https://lore.kernel.org/r/20241002184326.1105499-1-robh@kernel.org
>>>>> Signed-off-by: Will Deacon <will@kernel.org>
>>>>> [cherry picked from commit 0bbff9ed81654d5f06bfca484681756ee407f924]
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>
>>>> This one doesn't belong in 6.12. It's a feature that landed in 6.13.
>>>> It's only the fixed instruction counter support that landed in 6.12.
>>>
>>> Are you suggesting that this patch is not required for 6.12.y backport ?
>>
>> Yes.
>>
>>> We need this commit for ID_AA64DFR0_EL1_PMUVer_V3P9 definition. Should
>>> this change be added in the last commit itself in the series instead ?
>>
>> Ah, that's unfortunate. I suppose adding the hunk to the last commit
>> is the easiest. Not sure what the preference would be here.
> 
> You could also change the comparison from <3.9 to <=3.8 and avoid
> needing the definition.

.macro __init_el2_fgt2
	..............
	..............
        cmp     x1, #ID_AA64DFR0_EL1_PMUVer_V3P9		<=========
        b.lt    .Lskip_pmuv3p9_\@

        orr     x0, x0, #HDFGRTR2_EL2_nPMICNTR_EL0
        orr     x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
        orr     x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1

Are you suggesting that the above check against ID_AA64DFR0_EL1_PMUVer_V3P9
be replaced with ID_AA64DFR0_EL1_PMUVer_V3P8 instead ? But EL3 trap disable
for PMUACR_EL1 is only applicable when FEAT_PMUv3p9 is enabled.

Also seems like adding a hunk defining ID_AA64DFR0_EL1_PMUVer_V3P9 is much
cleaner and easier to follow rather than changing the comparison here IMHO.

But will be happy to change as preferred.

