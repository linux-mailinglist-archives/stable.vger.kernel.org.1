Return-Path: <stable+bounces-204847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F1DCF4A03
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3270C320B429
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01A5308F2A;
	Mon,  5 Jan 2026 16:02:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E43054EF;
	Mon,  5 Jan 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628961; cv=none; b=ltMqIRDV2oU/yO5cnbdU7Q6UjS5fxtdPbyw5LshbBn/YYuKOt9H17baokeTIIc2uiqSMthUIhgltMaKZ8Lq94suFs2tynmbyQFl3iRkhNOyKgxy242L+qwHeEqluca2sAij+MXySZhqCiDZROAvdRI7KM56ExVIPS/A4F/hTQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628961; c=relaxed/simple;
	bh=di2LhU3ug2I5hflVeQXXWfZTSChbqV7U/Q/81dEwXT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fep7xbzVqFP2i1+ZwF6mznd6WyobmXpxx13UM4YvH+RdpZDhLDorq0vskfFaFK7YBJNG4l2kyKk9QmEGaqpCFHAZBMcVeWXFQjmAxG48sZ7aOtqoD0VwuBufgyk9yjK07h81ycC1Dwtjtiw7pSor2R2PHpYN70UqF0Zc4ObxqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73603339;
	Mon,  5 Jan 2026 08:02:31 -0800 (PST)
Received: from [10.57.49.14] (unknown [10.57.49.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2F973F6A8;
	Mon,  5 Jan 2026 08:02:36 -0800 (PST)
Message-ID: <f253d6aa-1dc2-4b1a-85df-f43b06719c04@arm.com>
Date: Mon, 5 Jan 2026 16:02:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dawei Li <dawei.li@linux.dev>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, set_pte_at@outlook.com, stable@vger.kernel.org
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>
 <20260105145321.GD125261@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260105145321.GD125261@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-05 2:53 pm, Jason Gunthorpe wrote:
> On Mon, Jan 05, 2026 at 01:33:34PM +0000, Robin Murphy wrote:
>> The assumption is that if the SMMU is not I/O-coherent, then the Normal
>> Cacheable attribute will inherently degrade to a non-snooping (and thus
>> effectively Normal Non-Cacheable) one, as that's essentially what AXI will
>> do in practice, and thus the attribute doesn't actually matter all that much
>> in terms of functional correctness. If the SMMU _is_ capable of snooping but
>> is not described as such then frankly firmware is wrong.
> 
> Sadly I am aware of people doing this.. Either a HW bug or some other
> weird issue forces the FW to set a non-coherent FW attribute even
> though the HW is partially or fully able to process cachable AXI
> attributes.

What I've seen more often is that firmware authors ignore (or don't even 
realise) I/O-coherency, then someone ends up trying to "fix" Linux with 
wacky DMA API patches when things start going wrong on mis-described 
hardware... Yes, they might happen to get away with it with stuff like 
SMMUs or Mali GPUs where a "well-behaved" driver might have control of 
the source attributes, but where AxCACHE/AxDOMAIN are hard-wired there's 
really no option other than to describe the hardware correctly, hence 
that should always be the primary consideration.

And as I say, if there *is* some reason to specifically avoid using 
certain attributes, then deliberately describing the hardware 
incorrectly, in the hope that OS drivers might be "well-behaved" in a 
way that just happens to lead to them not using those attributes, is 
really not a robust workaround anyway.

> It is reasonable that Linux will set the attributes properly based on
> what it is doing. Setting the wrong attributes and expecting the HW to
> ignore them seems like a hacky direction.

Oh, I'm not saying that we *shouldn't* set our attributes more exactly - 
this would still be needed for doing things the "right" way too - I just 
want to be very clear on the reasons why. The current assumption is not 
a bug per se, and although it's indeed not 100% robust, the cases where 
it doesn't hold are more often than not for the wrong reason. Therefore 
I would say doing this purely for the sake of working around bad 
firmware - and especially errata - is just as hacky if not more so.

> I didn't see anything in the spec that says COHACC means the memory
> attributes are ignored and forced to non-coherent, even though that is
> the current assumption of the driver.

It kinda works the other way round: COHACC==1 says that the Cacheability 
and Shareability attributes *can* be configured to snoop CPU caches 
(although do not have to be); therefore the "If a system does not 
support IO-coherent access from the SMMU, SMMU_IDR0.COHACC must be 0" 
case implies that the SMMU is incapable of snooping regardless of how 
those attributes are set, thus must at least be in a different Inner 
Shareability domain from the CPUs, at which point the Cacheability 
domains probably aren't too meaningful either. I would consider it would 
be unexpectedly incorrect behaviour for an SMMU reporting COHACC==0 to 
actually be capable of snooping.

>> If prople have a good reason for wanting to use a coherent SMMU
>> non-coherently (and/or control of allocation hints), then that should really
>> be some kind of driver-level option - it would need a bit of additional DMA
>> API work (which has been low down my to-do list for a few years now...), but
>> it's perfectly achievable, and I think it's still preferable to abusing the
>> COHACC override in firmware.
> 
> IMHO, this is a different topic, and something that will probably
> become interesting this year. I'm aware of some HW/drivers that needs
> optional non-coherent mappings for isochronous flows - but it is not
> the DMA API that is the main issue but the page table walks :\

Hmm, yeah, potentially configuring PTW attributes for a DMA domain is 
something I hadn't even thought about - the DMA API aspect I mean is 
that in general we need some sort of DMA_ATTR_NO_SNOOP when 
mapping/allocating such isochronous buffers/pagetables etc., to make the 
DMA layer still do the cache maintenance/non-cacheable remaps despite 
dev_is_dma_coherent() being true.

Thanks,
Robin.

