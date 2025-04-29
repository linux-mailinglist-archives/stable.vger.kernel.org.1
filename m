Return-Path: <stable+bounces-137101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C1AA0E9E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F557A59A1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB32D29DC;
	Tue, 29 Apr 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O/I49wVX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564227CCD7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936550; cv=none; b=FWrqFk+JBbtBOsNGL0pKTR+XhccZK2AdopTj+3xglSPx6Yqa47YacdDehfNmWyd/OM4w+WCOVqDwUJmPfzy7tJXo2J6bp065F0acuETNBW3d2yO0xMwesmLrVdAj/IRggyrBt1IoNUG46cQmtydocAraD0jHozqXVxCnGXTQTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936550; c=relaxed/simple;
	bh=V4gr3dgIGZQqOYKEDqnuGJkjpKD9CAk9xqcSU7WRIjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVFRGxF23Us47j14zT9OyqyyCWaZd509uTM18qjceB6g29IT1OojiE8IAQtf9wfsZOSL+MJVB4M35leuNd/1QNeHX6+8rl/tkk/T3wYahs4psn0tIhMbqTMuEwZfFupOyjwttCKKEpXDmKkULXYq82xfHUK0WoLiVO5gurtnkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O/I49wVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C743FC4CEE3;
	Tue, 29 Apr 2025 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745936550;
	bh=V4gr3dgIGZQqOYKEDqnuGJkjpKD9CAk9xqcSU7WRIjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/I49wVX8x/oevk24gOA8Rs4DvzFH46FKLv7he49XarL9hlUY9Q5vGshMJH1XbYLi
	 pAP805An+J5SYQKHcF7I+rHKavRsGpItj4OY3Mi9eYmkJ2OYwVRnXAJvQ3gle/TzWJ
	 /4xbAp5Z+bcMyObsdco+JzyNcsPlS/eE8t+ORdU0=
Date: Tue, 29 Apr 2025 16:22:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v3 6.6] iommu: Handle race with default domain setup
Message-ID: <2025042921-banish-detached-4d91@gregkh>
References: <f0cac3a642f34d0d239f8d7870e33881fc7081d6.1745923148.git.robin.murphy@arm.com>
 <2025042954-factual-vengeful-6614@gregkh>
 <8b202837-b759-4d66-8e1a-a15ac22049cc@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b202837-b759-4d66-8e1a-a15ac22049cc@arm.com>

On Tue, Apr 29, 2025 at 02:07:19PM +0100, Robin Murphy wrote:
> On 29/04/2025 2:00 pm, Greg KH wrote:
> > On Tue, Apr 29, 2025 at 11:47:40AM +0100, Robin Murphy wrote:
> > > [ Upstream commit b46064a18810bad3aea089a79993ca5ea7a3d2b2 ]
> > > 
> > > It turns out that deferred default domain creation leaves a subtle
> > > race window during iommu_device_register() wherein a client driver may
> > > asynchronously probe in parallel and get as far as performing DMA API
> > > operations with dma-direct, only to be switched to iommu-dma underfoot
> > > once the default domain attachment finally happens, with obviously
> > > disastrous consequences. Even the wonky of_iommu_configure() path is at
> > > risk, since iommu_fwspec_init() will no longer defer client probe as the
> > > instance ops are (necessarily) already registered, and the "replay"
> > > iommu_probe_device() call can see dev->iommu_group already set and so
> > > think there's nothing to do either.
> > > 
> > > Fortunately we already have the right tool in the right place in the
> > > form of iommu_device_use_default_domain(), which just needs to ensure
> > > that said default domain is actually ready to *be* used. Deferring the
> > > client probe shouldn't have too much impact, given that this only
> > > happens while the IOMMU driver is probing, and thus due to kick the
> > > deferred probe list again once it finishes.
> > > 
> > > [ Backport: The above is true for mainline, but here we still have
> > > arch_setup_dma_ops() to worry about, which is not replayed if the
> > > default domain happens to be allocated *between* that call and
> > > subsequently reaching iommu_device_use_default_domain(), so we need an
> > > additional earlier check to cover that case. Also we're now back before
> > > the nominal commit 98ac73f99bc4 so we need to tweak the logic to depend
> > > on IOMMU_DMA as well, to avoid falsely deferring on architectures not
> > > using default domains. This then serves us back as far as f188056352bc,
> > > where this specific form of the problem first arises. ]
> > > 
> > > Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> > > Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> > > Fixes: f188056352bc ("iommu: Avoid locking/unlocking for iommu_probe_device()")
> > > Link: https://lore.kernel.org/r/e88b94c9b575034a2c98a48b3d383654cbda7902.1740753261.git.robin.murphy@arm.com
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > > 
> > > Resending as a new version with a new Message-Id so as not to confuse
> > > the tools... 6.12.y should simply have a straight cherry-pick of the
> > > mainline commit - 98ac73f99bc4 was in 6.7 so I'm not sure why autosel
> > > hasn't picked that already?
> > 
> > autosel is "maybe we get it", NEVER rely on it for an actual backport to
> > happen.
> > 
> > If you want this in 6.12.y, and it applies cleanly, just ask!  But I
> > can't take this 6.6.y patch before that happens for obvious reasons.
> 
> Understood; I shall try harder to remember to include explicit stable tags
> in future.
> 
> Could you please pick b46064a18810 for 6.12? I checked and there are indeed
> no conflicts :)

Great, all now queued up.

greg k-h

