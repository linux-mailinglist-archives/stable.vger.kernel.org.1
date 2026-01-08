Return-Path: <stable+bounces-206368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA26D0418A
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A643A308A4D7
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8502346ADD;
	Thu,  8 Jan 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO1qsb8s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175032C306;
	Thu,  8 Jan 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885490; cv=none; b=eff/ezwLDexpXHf2oy1B1sJC7W3k5qUxt6284CVz0DDqnpbJ1ORlHuyvedNSspsK8PzrOKd8zTDeqKlUtLzMDWhj/ixaCEzj0DqLmQfO79sPUlRJMhoVY4yk7h6jVNFZIqlHVqDJulyBBzi5yr+tJmKsID9WG0Z5BH/82p2nDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885490; c=relaxed/simple;
	bh=wElAgqmhU2sH9+PAc4srlbsEZTYYJ/yrdkxVw3n95E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcQ0/QNEjZ8Ru8ods0ug4ahvMOHGvr672K+ZgKalWR1P9XmEaG+GUz/NYJqthsJOUJjXgCPB33egX+FHrAEvcd18jjbEDgvjH6uxs9NTEHyGUE9rElVdNPIEo0Rx6TXW4qcUSMf/rXORhVQ/JNR0fDkEB1bHliRf6bLUHSiGuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO1qsb8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44600C116C6;
	Thu,  8 Jan 2026 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767885489;
	bh=wElAgqmhU2sH9+PAc4srlbsEZTYYJ/yrdkxVw3n95E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tO1qsb8sbuPY7+2dsp6sLheV0BkRESLekNwWZbmqFgFXIIziFd5Floa7jzGp6hYUk
	 CYNMtda0ceV8AyHG7sCetgbEk31JXOT/XLZ5tdKPWa5w3cnrpuRU8KDxsE46ydSVOn
	 R1YRBaBh5u54nOteVa5lrG74sRUessVMtPlY+2qtjKTxkf9FS9DVl7KLAqwzXhhXB0
	 yb9THS8iMBaP+j+OwNlk3uBFRbd+SqpQH5GCaMI0F6sbI4Z8tr2ynupQ8dzYqH6XfY
	 /sqjX6gttRsZU/xm8pRFz899DYRmDn7yNDS44+5VVPf+s8nyEdwbQgexsyvqYMF3ji
	 RRcWhQdF9TkUw==
Date: Thu, 8 Jan 2026 15:18:02 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Lucas Wei <lucaswei@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, sjadavani@google.com,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	smostafa@google.com, jgg@nvidia.com
Subject: Re: [PATCH v2] arm64: errata: Workaround for SI L1 downstream
 coherency issue
Message-ID: <aV_KqiaDf9-2NcxH@willie-the-truck>
References: <20251229033621.996546-1-lucaswei@google.com>
 <87o6ndduye.wl-maz@kernel.org>
 <aV6K7QnUa7jDpKw-@willie-the-truck>
 <7cd7b4f0-7aa5-4ca0-adc6-44d968c1ed48@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd7b4f0-7aa5-4ca0-adc6-44d968c1ed48@arm.com>

On Wed, Jan 07, 2026 at 05:55:40PM +0000, Robin Murphy wrote:
> On 2026-01-07 4:33 pm, Will Deacon wrote:
> > On Thu, Jan 01, 2026 at 06:55:05PM +0000, Marc Zyngier wrote:
> > > The other elephant in the room is virtualisation: how does a guest
> > > performing CMOs deals with this? How does it discover the that the
> > > host is broken? I also don't see any attempt to make KVM handle the
> > > erratum on behalf of the guest...
> > 
> > A guest shouldn't have to worry about the problem, as it only affects
> > clean to PoC for non-coherent DMA agents that reside downstream of the
> > SLC in the interconnect. Since VFIO doesn't permit assigning
> > non-coherent devices to a guest, guests shouldn't ever need to push
> > writes that far (and FWB would cause bigger problems if that was
> > something we wanted to support)
> > 
> > +Mostafa to keep me honest on the VFIO front.
> 
> I don't think we actually prevent non-coherent devices being assigned, we
> just rely on the IOMMU supporting IOMMU_CAP_CACHE_COHERENCY. Thus if there's
> an I/O-coherent SMMU then it could end up being permitted, however I would
> hope that either the affected devices are not behind such an SMMU, or at
> least that if the SMMU imposes cacheable attributes then that prevents
> traffic from taking the back-door path to RAM.

I think IOMMU_CAP_CACHE_COHERENCY is supposed to indicate whether or not
the endpoint devices are coherent (i.e. whether IOMMU_CACHE makes sense)
but it's true that, for the SMMU, we tie this to the coherency of the
SMMU itself so it is a bit sketchy. There's an interesting thread between
Mostafa and Jason about it:

https://lore.kernel.org/all/ZtHhdj6RAKACBCUG@google.com/

But, that aside, FWB throws a pretty big spanner in the works if we want
to assign non-coherent devices.

Will

