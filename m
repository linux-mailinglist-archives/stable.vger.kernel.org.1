Return-Path: <stable+bounces-139281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A72AA5B86
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 09:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB473B0EB7
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EEB20D505;
	Thu,  1 May 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oy7LkTke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DB18641
	for <stable@vger.kernel.org>; Thu,  1 May 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746085593; cv=none; b=Viq3YIZ2J9L9lS7yK8tV7NFaSj/yWF3ZDDxSJjNL7iTlg/t5DIbF3kOIKkcvt278ZXoZ3G/QOh9umMpQc/wq5hT4ncfE+3kBzLD+sJufkrBjO8Vdzabn4Oafz/BFO8qWg/PumwxzK4lmKSOhSH3S1aBcPr4+xcBomqhlV5PqtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746085593; c=relaxed/simple;
	bh=blrvMJ6wl7y3ZsGlaD/RuaZyXaClihwvj6PlWaJhMMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtwoA551u9XTHgRmpztCNdXjid6S31Js1Y2lKnQo/p39We47x46hEGCA6nlGQ+a5uBqSVCjRN13u2KKt1buGSExs/0m12rgOebF/PYaV8YMIgsem5FoXb1TFh2myV6D+jMIXShNwRNrzd1MwmEDOU5Ol8br7Kt88COqyncyLaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oy7LkTke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BDFC4CEE3;
	Thu,  1 May 2025 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746085593;
	bh=blrvMJ6wl7y3ZsGlaD/RuaZyXaClihwvj6PlWaJhMMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oy7LkTke9cTe8N0FWodeSLe6g2M8I/HuwQFrZaYz6ry2rmlArWXoKScjN4bnChJis
	 SkfJMyewckA455e7sKy4ge3RkmZoDK/KiixteN/q9bnk9pWhl7veboTgXBG2Y0scPR
	 0Uh6e3QRlv8HkOod65gyTBB6fib3Nx7qF7NKCpyA=
Date: Thu, 1 May 2025 09:46:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v3 6.6] iommu: Handle race with default domain setup
Message-ID: <2025050141-coagulant-flail-8060@gregkh>
References: <f0cac3a642f34d0d239f8d7870e33881fc7081d6.1745923148.git.robin.murphy@arm.com>
 <2025042954-factual-vengeful-6614@gregkh>
 <8b202837-b759-4d66-8e1a-a15ac22049cc@arm.com>
 <2025042921-banish-detached-4d91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042921-banish-detached-4d91@gregkh>

On Tue, Apr 29, 2025 at 04:22:27PM +0200, Greg KH wrote:
> On Tue, Apr 29, 2025 at 02:07:19PM +0100, Robin Murphy wrote:
> > On 29/04/2025 2:00 pm, Greg KH wrote:
> > > On Tue, Apr 29, 2025 at 11:47:40AM +0100, Robin Murphy wrote:
> > > > [ Upstream commit b46064a18810bad3aea089a79993ca5ea7a3d2b2 ]
> > > > 
> > > > It turns out that deferred default domain creation leaves a subtle
> > > > race window during iommu_device_register() wherein a client driver may
> > > > asynchronously probe in parallel and get as far as performing DMA API
> > > > operations with dma-direct, only to be switched to iommu-dma underfoot
> > > > once the default domain attachment finally happens, with obviously
> > > > disastrous consequences. Even the wonky of_iommu_configure() path is at
> > > > risk, since iommu_fwspec_init() will no longer defer client probe as the
> > > > instance ops are (necessarily) already registered, and the "replay"
> > > > iommu_probe_device() call can see dev->iommu_group already set and so
> > > > think there's nothing to do either.
> > > > 
> > > > Fortunately we already have the right tool in the right place in the
> > > > form of iommu_device_use_default_domain(), which just needs to ensure
> > > > that said default domain is actually ready to *be* used. Deferring the
> > > > client probe shouldn't have too much impact, given that this only
> > > > happens while the IOMMU driver is probing, and thus due to kick the
> > > > deferred probe list again once it finishes.
> > > > 
> > > > [ Backport: The above is true for mainline, but here we still have
> > > > arch_setup_dma_ops() to worry about, which is not replayed if the
> > > > default domain happens to be allocated *between* that call and
> > > > subsequently reaching iommu_device_use_default_domain(), so we need an
> > > > additional earlier check to cover that case. Also we're now back before
> > > > the nominal commit 98ac73f99bc4 so we need to tweak the logic to depend
> > > > on IOMMU_DMA as well, to avoid falsely deferring on architectures not
> > > > using default domains. This then serves us back as far as f188056352bc,
> > > > where this specific form of the problem first arises. ]
> > > > 
> > > > Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> > > > Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> > > > Fixes: f188056352bc ("iommu: Avoid locking/unlocking for iommu_probe_device()")
> > > > Link: https://lore.kernel.org/r/e88b94c9b575034a2c98a48b3d383654cbda7902.1740753261.git.robin.murphy@arm.com
> > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > > ---
> > > > 
> > > > Resending as a new version with a new Message-Id so as not to confuse
> > > > the tools... 6.12.y should simply have a straight cherry-pick of the
> > > > mainline commit - 98ac73f99bc4 was in 6.7 so I'm not sure why autosel
> > > > hasn't picked that already?
> > > 
> > > autosel is "maybe we get it", NEVER rely on it for an actual backport to
> > > happen.
> > > 
> > > If you want this in 6.12.y, and it applies cleanly, just ask!  But I
> > > can't take this 6.6.y patch before that happens for obvious reasons.
> > 
> > Understood; I shall try harder to remember to include explicit stable tags
> > in future.
> > 
> > Could you please pick b46064a18810 for 6.12? I checked and there are indeed
> > no conflicts :)
> 
> Great, all now queued up.

And now there's reports it is causing problems in the 6.6-stable queue:
	https://lore.kernel.org/r/1903a129-6e06-47d9-862b-ab23f72a9fea@nvidia.com
so I'm going to drop it from the 6.6.y tree now, sorry.

Can you work with Jon to to get this figured out?

thanks,

greg k-h

