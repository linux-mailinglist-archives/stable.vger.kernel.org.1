Return-Path: <stable+bounces-86631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC19A245D
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B5F285960
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C81DDA24;
	Thu, 17 Oct 2024 13:54:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B611B1DDA0F;
	Thu, 17 Oct 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173280; cv=none; b=fVU+d37ENo66TLr9+iOM7j1E4UJraFdKdqAZyjC1mIZZt58BcZDcvuP8bafJdSTJwTBcs6Off1UyktU0p4dpYAqOhrn59Zi7ZIRDcvjhLaIWp7RAtGeEwZCEKmAksMdnDYYIcs7Uo2zm8yi29si0vwLtizO68nWKH+wKWeJ5Yd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173280; c=relaxed/simple;
	bh=dR1/iF0hamAmACkYIu6ORSod6DVPZnh+qVKWQ1c6eVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwTxOod+OcjzoYGh/6SczIX9ku+VUIvQV0UU2C81wWu9Giwuyc3Ls8RNNFKpsAZYjz8xUsk7eOth/eEAoWLW87D5XgMd+rmhlASNdmJN0BnGmaGq72ZOZuFIFPIWYCIp6pg2c9G/9wrnQxC66DkgoS4qN0p+oRXt0o1EgUFfJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5ACCDA7;
	Thu, 17 Oct 2024 06:55:03 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD09A3F528;
	Thu, 17 Oct 2024 06:54:31 -0700 (PDT)
Message-ID: <3925d2f0-3b1f-4200-acc4-8f991616ec0f@arm.com>
Date: Thu, 17 Oct 2024 14:54:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: Defer probe of clients after smmu
 device bound
To: Pratyush Brahma <quic_pbrahma@quicinc.com>, will@kernel.org
Cc: joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com,
 robdclark@chromium.org, quic_c_gdjako@quicinc.com,
 dmitry.baryshkov@linaro.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 quic_charante@quicinc.com, stable@vger.kernel.org,
 Prakash Gupta <quic_guptap@quicinc.com>
References: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
 <d4a52579-0e2a-4df3-a1fa-e8e154ff1e90@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <d4a52579-0e2a-4df3-a1fa-e8e154ff1e90@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2024 2:31 pm, Pratyush Brahma wrote:
> 
> On 10/4/2024 2:34 PM, Pratyush Brahma wrote:
>> Null pointer dereference occurs due to a race between smmu
>> driver probe and client driver probe, when of_dma_configure()
>> for client is called after the iommu_device_register() for smmu driver
>> probe has executed but before the driver_bound() for smmu driver
>> has been called.
>>
>> Following is how the race occurs:
>>
>> T1:Smmu device probe        T2: Client device probe
>>
>> really_probe()
>> arm_smmu_device_probe()
>> iommu_device_register()
>>                     really_probe()
>>                     platform_dma_configure()
>>                     of_dma_configure()
>>                     of_dma_configure_id()
>>                     of_iommu_configure()
>>                     iommu_probe_device()
>>                     iommu_init_device()
>>                     arm_smmu_probe_device()
>>                     arm_smmu_get_by_fwnode()
>>                         driver_find_device_by_fwnode()
>>                         driver_find_device()
>>                         next_device()
>>                         klist_next()
>>                             /* null ptr
>>                                assigned to smmu */
>>                     /* null ptr dereference
>>                        while smmu->streamid_mask */
>> driver_bound()
>>     klist_add_tail()
>>
>> When this null smmu pointer is dereferenced later in
>> arm_smmu_probe_device, the device crashes.
>>
>> Fix this by deferring the probe of the client device
>> until the smmu device has bound to the arm smmu driver.
>>
>> Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration 
>> support")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
>> Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
>> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
>> ---
>> Changes in v2:
>>   Fix kernel test robot warning
>>   Add stable kernel list in cc
>>   Link to v1: 
>> https://lore.kernel.org/all/20241001055633.21062-1-quic_pbrahma@quicinc.com/
>>
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 723273440c21..7c778b7eb8c8 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -1437,6 +1437,9 @@ static struct iommu_device 
>> *arm_smmu_probe_device(struct device *dev)
>>               goto out_free;
>>       } else {
>>           smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>> +        if (!smmu)
>> +            return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
>> +                        "smmu dev has not bound yet\n"));
>>       }
>>       ret = -EINVAL;
> 
> 
> Hi
> Can someone please review this patch? Let me know if any further 
> information is required.

This really shouldn't be leaking into drivers... :(

Honestly, I'm now so fed up of piling on hacks around the fundamental 
mis-design here, I think it's finally time to blow everything else off 
and spend a few days figuring out the most expedient way to fix it 
properly once and for all. Watch this space...

Thanks,
Robin.

