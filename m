Return-Path: <stable+bounces-206386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9036D04899
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1A9B3115FDB
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA232DCF46;
	Thu,  8 Jan 2026 16:41:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6062DCBF2;
	Thu,  8 Jan 2026 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890514; cv=none; b=jrfO5U5EcxtZFu3ff1Fn9pRjhZsRdnypoAs2szWAC72nt36x7kwxlU9rQ+d91GBIpLE/0P/gXJG13aY1FP8zNon03oJXgI4OtKDJALn4+maTiX566b2tviir0EMf9BwOagHTEZoWfx0QBx1GcbFPEqNPDGld/qL2hmDxqAG7TOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890514; c=relaxed/simple;
	bh=Go6tZvfw0P1naOPXvuPKJwwSMuPcQyT/vASOvZVvRVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gaeqxl4ywpNIxXfOzAwjGH/sdZexjV4sD59EYVvhbNtt+GnYfx5b0QeJbxe5LGb7/aWTNnk91dsLgOj4xTWeisGsE8QBm/y9nLKfC7tWvROu/gFRjJMPhlkVPELzT4uzzpUuPmk8VqLGuGxtYSRSVfK0DctukRQ1RYcg0DQUmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63214497;
	Thu,  8 Jan 2026 08:41:44 -0800 (PST)
Received: from [10.1.29.34] (010265703453.cambridge.arm.com [10.1.29.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744FC3F5A1;
	Thu,  8 Jan 2026 08:41:49 -0800 (PST)
Message-ID: <a0fd155b-67fc-45a4-8510-01f89681d6fa@arm.com>
Date: Thu, 8 Jan 2026 16:41:47 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: errata: Workaround for SI L1 downstream
 coherency issue
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Lucas Wei <lucaswei@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 sjadavani@google.com, kernel test robot <lkp@intel.com>,
 stable@vger.kernel.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, smostafa@google.com, jgg@nvidia.com
References: <20251229033621.996546-1-lucaswei@google.com>
 <87o6ndduye.wl-maz@kernel.org> <aV6K7QnUa7jDpKw-@willie-the-truck>
 <7cd7b4f0-7aa5-4ca0-adc6-44d968c1ed48@arm.com>
 <aV_KqiaDf9-2NcxH@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aV_KqiaDf9-2NcxH@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-08 3:18 pm, Will Deacon wrote:
> On Wed, Jan 07, 2026 at 05:55:40PM +0000, Robin Murphy wrote:
>> On 2026-01-07 4:33 pm, Will Deacon wrote:
>>> On Thu, Jan 01, 2026 at 06:55:05PM +0000, Marc Zyngier wrote:
>>>> The other elephant in the room is virtualisation: how does a guest
>>>> performing CMOs deals with this? How does it discover the that the
>>>> host is broken? I also don't see any attempt to make KVM handle the
>>>> erratum on behalf of the guest...
>>>
>>> A guest shouldn't have to worry about the problem, as it only affects
>>> clean to PoC for non-coherent DMA agents that reside downstream of the
>>> SLC in the interconnect. Since VFIO doesn't permit assigning
>>> non-coherent devices to a guest, guests shouldn't ever need to push
>>> writes that far (and FWB would cause bigger problems if that was
>>> something we wanted to support)
>>>
>>> +Mostafa to keep me honest on the VFIO front.
>>
>> I don't think we actually prevent non-coherent devices being assigned, we
>> just rely on the IOMMU supporting IOMMU_CAP_CACHE_COHERENCY. Thus if there's
>> an I/O-coherent SMMU then it could end up being permitted, however I would
>> hope that either the affected devices are not behind such an SMMU, or at
>> least that if the SMMU imposes cacheable attributes then that prevents
>> traffic from taking the back-door path to RAM.
> 
> I think IOMMU_CAP_CACHE_COHERENCY is supposed to indicate whether or not
> the endpoint devices are coherent (i.e. whether IOMMU_CACHE makes sense)
> but it's true that, for the SMMU, we tie this to the coherency of the
> SMMU itself so it is a bit sketchy. There's an interesting thread between
> Mostafa and Jason about it:
> 
> https://lore.kernel.org/all/ZtHhdj6RAKACBCUG@google.com/

The point is that if there's a coherent interconnect downstream of the 
SMMU - which we infer from the SMMU's own coherency - then we should be 
able to make the *output* of SMMU translation coherent, regardless of 
what the incoming attributes from the device are. In the IORT terms, CPM 
is really what matters for IOMMU_CACHE, not DACS.

> But, that aside, FWB throws a pretty big spanner in the works if we want
> to assign non-coherent devices.

If you mean having FWB on the CPU *without* also having it on the SMMU, 
then yes, there are various ways that could be problematic even with 
nominally-coherent devices. S2FWB on the SMMU, however, is *almost* the 
magic bullet that makes things fine for VFIO in general, except for the 
annoying mis-step that it's not guaranteed to override PCIe No Snoop 
(hopefully that might get fixed in future, but we'll still have today's 
implementations that do have the not-particularly-useful behaviour.)

This may be straying a bit far off $SUBJECT though - do we know if the 
affected devices in this case are behind a coherent SMMU, and how things 
work for IWB-OWB-ISh output attributes if so?

Thanks,
Robin.

