Return-Path: <stable+bounces-137086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4750AA0C96
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C99F48546D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79120FAA1;
	Tue, 29 Apr 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jzLRKMHb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0281547D2
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931642; cv=none; b=L0A9dJss6Q1ITu2htTLigW0flfYUTWmCFrloPjZ595+j/4c7ErSvaf/W1J7Hufx+fyzVQS6rlv17fUjJTgIMg/YSM8tl59iqxfpuntzRqxKPRu7PMxehSg0XfcPycgXd2+mhRnq5pWSCBesnthdqBA9hsTJZFqgQSzvT7X2t3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931642; c=relaxed/simple;
	bh=yhD41auVD012ylE1lmtJC9qjrqta9v7tflRH8xxmOxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLd8nK+c2g2T6dVEV1xFQj8EwOWnLAAB6KFyxiM94AHMdfKiE/hwsprCzeVZVHEtPtq4/Q1sTGTq+4sWkx7yw8naiSdFLZBg/34o2QyHp0M8xBOGJyn3HFb4hgUmXIIeVojXfJChvwZUhaxM67zH9HZw6msXnOj9N7ThlXLWk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jzLRKMHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26F6C4CEE3;
	Tue, 29 Apr 2025 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745931641;
	bh=yhD41auVD012ylE1lmtJC9qjrqta9v7tflRH8xxmOxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzLRKMHbPOgaRc9VYv2JTsyJe5/EzXziPhVF4BP07nB9ONv+lt/VKziIGcJ0YFxYU
	 deKSpIY8VOp2OynpySCgSdF0AgJZ1lZzAR2y7Gs0wiVrBAzbu4CF4BvifhBYJgatE4
	 IrHeomdoZj1fgKvX8xD0kyZA3aGEISv6dEtT1RoU=
Date: Tue, 29 Apr 2025 15:00:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v3 6.6] iommu: Handle race with default domain setup
Message-ID: <2025042954-factual-vengeful-6614@gregkh>
References: <f0cac3a642f34d0d239f8d7870e33881fc7081d6.1745923148.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cac3a642f34d0d239f8d7870e33881fc7081d6.1745923148.git.robin.murphy@arm.com>

On Tue, Apr 29, 2025 at 11:47:40AM +0100, Robin Murphy wrote:
> [ Upstream commit b46064a18810bad3aea089a79993ca5ea7a3d2b2 ]
> 
> It turns out that deferred default domain creation leaves a subtle
> race window during iommu_device_register() wherein a client driver may
> asynchronously probe in parallel and get as far as performing DMA API
> operations with dma-direct, only to be switched to iommu-dma underfoot
> once the default domain attachment finally happens, with obviously
> disastrous consequences. Even the wonky of_iommu_configure() path is at
> risk, since iommu_fwspec_init() will no longer defer client probe as the
> instance ops are (necessarily) already registered, and the "replay"
> iommu_probe_device() call can see dev->iommu_group already set and so
> think there's nothing to do either.
> 
> Fortunately we already have the right tool in the right place in the
> form of iommu_device_use_default_domain(), which just needs to ensure
> that said default domain is actually ready to *be* used. Deferring the
> client probe shouldn't have too much impact, given that this only
> happens while the IOMMU driver is probing, and thus due to kick the
> deferred probe list again once it finishes.
> 
> [ Backport: The above is true for mainline, but here we still have
> arch_setup_dma_ops() to worry about, which is not replayed if the
> default domain happens to be allocated *between* that call and
> subsequently reaching iommu_device_use_default_domain(), so we need an
> additional earlier check to cover that case. Also we're now back before
> the nominal commit 98ac73f99bc4 so we need to tweak the logic to depend
> on IOMMU_DMA as well, to avoid falsely deferring on architectures not
> using default domains. This then serves us back as far as f188056352bc,
> where this specific form of the problem first arises. ]
> 
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> Fixes: f188056352bc ("iommu: Avoid locking/unlocking for iommu_probe_device()")
> Link: https://lore.kernel.org/r/e88b94c9b575034a2c98a48b3d383654cbda7902.1740753261.git.robin.murphy@arm.com
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Resending as a new version with a new Message-Id so as not to confuse
> the tools... 6.12.y should simply have a straight cherry-pick of the
> mainline commit - 98ac73f99bc4 was in 6.7 so I'm not sure why autosel
> hasn't picked that already?

autosel is "maybe we get it", NEVER rely on it for an actual backport to
happen.

If you want this in 6.12.y, and it applies cleanly, just ask!  But I
can't take this 6.6.y patch before that happens for obvious reasons.

thanks,

greg k-h

