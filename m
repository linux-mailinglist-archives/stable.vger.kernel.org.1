Return-Path: <stable+bounces-91925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3811B9C1DAA
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 14:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CEF1F22201
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5391EABAF;
	Fri,  8 Nov 2024 13:11:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A81EABA7;
	Fri,  8 Nov 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071485; cv=none; b=F/IhNhsZNS5Enhwaa/vDkoqKf78+qKfi9RJLfvyAZHWl0y022N9+/CRtEbKUrR5uIItLHucQfU2xVGCPf+fJiRs11KF1IHl/RVGBFuN04hrBQAZBPLFo7cwy2VNa7OGRhqSi4qFNGKi2LdMpaYwA3nKxJIaH3WXGAIXYuxQKXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071485; c=relaxed/simple;
	bh=QjA5EMYFJ6xfhGH9fzDGKSBNyr2o8zURlscSe7enCB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaUYXT3/E3vSZlliJ7y36AFJ/DMgmyu6gxrGunvv5iOui4nqWDzqiResHsE+HBPRJ55oZXKMSmaFdDrqdfY/08dA6uJ+ZRyELJrgpwEXWvmhiJ/Ln59cRjYGeaTzBaYcNpLKrra6ZWYz/+cqCDKMZ8Phge3GNDKmghvPzyyY5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C173A497;
	Fri,  8 Nov 2024 05:11:51 -0800 (PST)
Received: from [10.57.90.136] (unknown [10.57.90.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C940B3F528;
	Fri,  8 Nov 2024 05:11:20 -0800 (PST)
Message-ID: <74e82b40-ecf9-4f20-9a33-c5369e04ea85@arm.com>
Date: Fri, 8 Nov 2024 13:11:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: Reserve iova ranges for reserved regions of
 all devices
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241024153412.141765-1-jsnitsel@redhat.com>
 <vup5ms2p5o4ao3t57kfgqtnnna7e4jcvkvup2vmyf6o4qrb3qu@3aanawjzggyh>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <vup5ms2p5o4ao3t57kfgqtnnna7e4jcvkvup2vmyf6o4qrb3qu@3aanawjzggyh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-06 7:13 pm, Jerry Snitselaar wrote:
> On Thu, Oct 24, 2024 at 08:34:12AM -0700, Jerry Snitselaar wrote:
>> Only the first device that is passed when the domain is set up will
>> have its reserved regions reserved in the iova address space.  So if
>> there are other devices in the group with unique reserved regions,
>> those regions will not get reserved in the iova address space.  All of
>> the ranges do get set up in the iopagetables via calls to
>> iommu_create_device_direct_mappings for all devices in a group.
>>
>> In the case of vt-d system this resulted in messages like the following:
>>
>> [ 1632.693264] DMAR: ERROR: DMA PTE for vPFN 0xf1f7e already set (to f1f7e003 not 173025001)
>>
>> To make sure iova ranges are reserved for the reserved regions all of
>> the devices, call iova_reserve_iommu_regions in iommu_dma_init_domain
>> prior to exiting in the case where the domain is already initialized.
>>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: stable@vger.kernel.org
>> Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> ---
>> Robin: I wasn't positive if this is the correct solution, or if it should be
>>         done for the entire group at once.
>>
>>   drivers/iommu/dma-iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 2a9fa0c8cc00..5fd3cccbb233 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -707,7 +707,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
>>   			goto done_unlock;
>>   		}
>>   
>> -		ret = 0;
>> +		ret = iova_reserve_iommu_regions(dev, domain);
>>   		goto done_unlock;
>>   	}
>>   
>> -- 
>> 2.44.0
>>
> 
> Robin,
> 
> Any thoughts on this patch? In the case where this originally popped
> up it was likely a crap DMAR table in an HPE system with an ilo, as
> the RMRR in question had a device in the list that as far as I could
> tell didn't actually exist. The 2nd function of the sata controller
> was in the list, but not the first, and the first function was the
> device where the group/domain was initialized. With some debugging
> code I could see it set up the ioptes for the 2nd function, but it
> wasn't reserving the range of iovas.

Yeah, this one's tricky - the current behaviour is not entirely 
unintentional since there's not really a right answer. It's also 
possible for the second device to get here after the first device has 
already started using the domain, so at that point it's no longer safe 
to use reserve_iova() due to how it merges overlapping and adjacent 
rbtree nodes, which could really screw things up once there are normal 
allocations in the tree as well. So in truth it was rather a case of 
crossing my fingers and quietly hoping this particular set of 
circumstances was unlikely enough to never come up... :/

Thanks,
Robin.

