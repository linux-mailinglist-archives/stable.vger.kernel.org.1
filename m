Return-Path: <stable+bounces-137093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEB6AA0CFA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30CE5A1D0F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6684D2D320C;
	Tue, 29 Apr 2025 13:07:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9109E2D3200
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745932044; cv=none; b=A4t/zKtEsJKHXbFhJ5YzrB0alZ0FV3ozJLFDQqd541ktupbXBfpm2c1z9J8d7CbsvPgHydcfCZv4bI3ok7aG5+6wRCsdlQYCrlkxqMwUgaSnUe/FyhCv/8ybnfF7LvIPw3FoSWcB5vGj8AAGjqnB2otdJ49X+WSfBQq2rVquCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745932044; c=relaxed/simple;
	bh=V5HvgMGJGtv8yLrLQ/BuzvR0FxiKGyxYggj4psdJ+G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8E0DAwG19ujk7S0MAcAsx6WOW691LX/l/f/HBakU+58T2HWExMEpaoV3I7BE5iOMWMHCgpfz+1PMFlTEG7UlOBkKD67lIbbHjcxIuOkRAK4n+t9lYQ20fZHeVhCJ4A1CVyEaAcmt6/Bte2cQMPmA5rvHpyeQZK7TotRtC5bU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B0261516;
	Tue, 29 Apr 2025 06:07:15 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 625B43F7A6;
	Tue, 29 Apr 2025 06:07:21 -0700 (PDT)
Message-ID: <8b202837-b759-4d66-8e1a-a15ac22049cc@arm.com>
Date: Tue, 29 Apr 2025 14:07:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6.6] iommu: Handle race with default domain setup
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
References: <f0cac3a642f34d0d239f8d7870e33881fc7081d6.1745923148.git.robin.murphy@arm.com>
 <2025042954-factual-vengeful-6614@gregkh>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2025042954-factual-vengeful-6614@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2025 2:00 pm, Greg KH wrote:
> On Tue, Apr 29, 2025 at 11:47:40AM +0100, Robin Murphy wrote:
>> [ Upstream commit b46064a18810bad3aea089a79993ca5ea7a3d2b2 ]
>>
>> It turns out that deferred default domain creation leaves a subtle
>> race window during iommu_device_register() wherein a client driver may
>> asynchronously probe in parallel and get as far as performing DMA API
>> operations with dma-direct, only to be switched to iommu-dma underfoot
>> once the default domain attachment finally happens, with obviously
>> disastrous consequences. Even the wonky of_iommu_configure() path is at
>> risk, since iommu_fwspec_init() will no longer defer client probe as the
>> instance ops are (necessarily) already registered, and the "replay"
>> iommu_probe_device() call can see dev->iommu_group already set and so
>> think there's nothing to do either.
>>
>> Fortunately we already have the right tool in the right place in the
>> form of iommu_device_use_default_domain(), which just needs to ensure
>> that said default domain is actually ready to *be* used. Deferring the
>> client probe shouldn't have too much impact, given that this only
>> happens while the IOMMU driver is probing, and thus due to kick the
>> deferred probe list again once it finishes.
>>
>> [ Backport: The above is true for mainline, but here we still have
>> arch_setup_dma_ops() to worry about, which is not replayed if the
>> default domain happens to be allocated *between* that call and
>> subsequently reaching iommu_device_use_default_domain(), so we need an
>> additional earlier check to cover that case. Also we're now back before
>> the nominal commit 98ac73f99bc4 so we need to tweak the logic to depend
>> on IOMMU_DMA as well, to avoid falsely deferring on architectures not
>> using default domains. This then serves us back as far as f188056352bc,
>> where this specific form of the problem first arises. ]
>>
>> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
>> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
>> Fixes: f188056352bc ("iommu: Avoid locking/unlocking for iommu_probe_device()")
>> Link: https://lore.kernel.org/r/e88b94c9b575034a2c98a48b3d383654cbda7902.1740753261.git.robin.murphy@arm.com
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Resending as a new version with a new Message-Id so as not to confuse
>> the tools... 6.12.y should simply have a straight cherry-pick of the
>> mainline commit - 98ac73f99bc4 was in 6.7 so I'm not sure why autosel
>> hasn't picked that already?
> 
> autosel is "maybe we get it", NEVER rely on it for an actual backport to
> happen.
> 
> If you want this in 6.12.y, and it applies cleanly, just ask!  But I
> can't take this 6.6.y patch before that happens for obvious reasons.

Understood; I shall try harder to remember to include explicit stable 
tags in future.

Could you please pick b46064a18810 for 6.12? I checked and there are 
indeed no conflicts :)

Thanks,
Robin.

