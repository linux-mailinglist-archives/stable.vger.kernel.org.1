Return-Path: <stable+bounces-100422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428609EB117
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318A616AD4E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741261A4E77;
	Tue, 10 Dec 2024 12:44:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733AE1CD15;
	Tue, 10 Dec 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834664; cv=none; b=fxcQoDApF8v9ZRhHlxYoXSGiJk1k9JuIgQo3GKtF4CZtiyIAmMCCJuYBWXACouxzl7vJjlILNnTRfoX7a+VTqn6/viuijxHlN6+gzcSJhcJhnmiw6u7mdm3XcyooRx/S/IO0w9spFvRJalCSXXXIIdZUVDi+9SFy1bYg9I+isvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834664; c=relaxed/simple;
	bh=bP5eP4t8PpPZ2cJQvIVipwyYHR5VY9ahYWxT7HdzSGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpGZjYhiyemhSzfnnbyrhILGr14TpvzT2aJm67WTQuZFLBzxO+sXfCShqkgY68WS0XRiVYhtJ5oKeMp0sHth9Aotb0NDIsFQ4mAboW2hw0Ef2IlgzUqeO8E8Rjs8caTHFuOXPt80hd3wkqOz3uvopHGPJ2CBl7ykNxOphyBxTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9E17106F;
	Tue, 10 Dec 2024 04:44:49 -0800 (PST)
Received: from [10.57.91.204] (unknown [10.57.91.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E808E3F5A1;
	Tue, 10 Dec 2024 04:44:20 -0800 (PST)
Message-ID: <e3b34cf1-9039-403c-b96b-533d4e1880a9@arm.com>
Date: Tue, 10 Dec 2024 12:44:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "iommu/arm-smmu: Defer probe of clients after smmu device
 bound" has been added to the 6.6-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 quic_pbrahma@quicinc.com, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <20241209112749.3166445-1-sashal@kernel.org>
 <7dc48afa-1ea8-4ed4-8e55-7c108299522b@arm.com>
 <2024121030-donated-giggly-0c15@gregkh>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2024121030-donated-giggly-0c15@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-10 12:18 pm, Greg KH wrote:
> On Tue, Dec 10, 2024 at 12:14:44PM +0000, Robin Murphy wrote:
>> On 2024-12-09 11:27 am, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>       iommu/arm-smmu: Defer probe of clients after smmu device bound
>>>
>>> to the 6.6-stable tree which can be found at:
>>>       http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>        iommu-arm-smmu-defer-probe-of-clients-after-smmu-dev.patch
>>> and it can be found in the queue-6.6 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>>
>> FWIW the correct resolution for cherry-picking this directly is the
>> logically-straightforward one, as below (git is mostly just confused by
>> the context)
>>
>> Cheers,
>> Robin.
>>
>> ----->8-----
>> diff --cc drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index d6d1a2a55cc0,14618772a3d6..000000000000
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@@ -1357,10 -1435,19 +1357,21 @@@ static struct iommu_device *arm_smmu_pr
>>    		fwspec = dev_iommu_fwspec_get(dev);
>>    		if (ret)
>>    			goto out_free;
>>   -	} else {
>>   +	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
>>    		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>> +
>> + 		/*
>> + 		 * Defer probe if the relevant SMMU instance hasn't finished
>> + 		 * probing yet. This is a fragile hack and we'd ideally
>> + 		 * avoid this race in the core code. Until that's ironed
>> + 		 * out, however, this is the most pragmatic option on the
>> + 		 * table.
>> + 		 */
>> + 		if (!smmu)
>> + 			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
>> + 						"smmu dev has not bound yet\n"));
>>   +	} else {
>>   +		return ERR_PTR(-ENODEV);
>>    	}
>>    	ret = -EINVAL;a
> 
> Can you resend this in a patch that we can apply as-is?

Hope I got the tagging right :)

https://lore.kernel.org/stable/acd8068372673fb881aa9e13531470669c985519.1733834302.git.robin.murphy@arm.com/

Cheers,
Robin.

> 
> thanks,
> 
> greg k-h


