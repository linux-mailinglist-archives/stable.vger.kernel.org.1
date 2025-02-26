Return-Path: <stable+bounces-119745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7265A46B51
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C1168E5B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E212512D2;
	Wed, 26 Feb 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA2dDNUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38A21CC4E;
	Wed, 26 Feb 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599107; cv=none; b=HTcKE0CNQvThgeViotavG3leBwggWkgJ9U9XgjTDMjN/MMiBKq0h7e8IGp1LnXy4lFajqFTqjvndDowshN0kVOcKwVmZ8sy2L/GDycC1bQl0Ms7F+WfXKuibzqdptngkV0EM8Q/NEj5yyWc8ovUlbmhZwow/aXqYCHmKe0BSMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599107; c=relaxed/simple;
	bh=s4HTmS1RTtakgkLAflASCylKWxFWUJx+7Ik4bWDC0Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV8ndDvJsNOnp2fe7aB+N1gxlEMJ2sO6fnj6guzG7MPXkNZ6QgBpuD+odoP7cXk33InRB9LgsW4q63ufwTOh4yxcmn8Kot0ewCCUBRAYELZvszEW6ZHTBdDGqvNPxXxZtrqFO1uujejmEUfnCcC9OvXKw1j5CeNmeDd9evGgy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA2dDNUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139A5C4CEE8;
	Wed, 26 Feb 2025 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740599107;
	bh=s4HTmS1RTtakgkLAflASCylKWxFWUJx+7Ik4bWDC0Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qA2dDNUdFanFEAB3AZe7mBnxiyrrh0JRS2r1PRtfRYeadPWaPkctR6PARH/JjtzRL
	 errWXmlXMUHycaz7CqyqERZFMihYL3yJRZLDxHedM/tAk0DxsoY04CDAiKcutlgJeZ
	 21IYNPrTvW96DcOerL962toCHLSHqb7MJexz07aiCjEV/JjTOZpnF6L/8yLHb+Tznb
	 Vot1du6O56UkhTEe5ihvLg1iQjPdvxKgEfZbLSYDgmwtXtR+ZO3h7SRJDbIQ3dZuVt
	 gnD8+nJuc32PPq++Dt1qHI97mSIm07bY7ZjQ0Xbxeod/k6a5yVrFalJtXRilNGXu0d
	 sml/cl0vz9IHw==
Date: Wed, 26 Feb 2025 13:45:05 -0600
From: Rob Herring <robh@kernel.org>
To: William McVicker <willmcvicker@google.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, Zijun Hu <zijun_hu@icloud.com>,
	Saravana Kannan <saravanak@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Marc Zyngier <maz@kernel.org>,
	Andreas Herrmann <andreas.herrmann@calxeda.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
Message-ID: <20250226194505.GA3407277-robh@kernel.org>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>
 <20250113232551.GB1983895-robh@kernel.org>
 <Z70aTw45KMqTUpBm@google.com>
 <97ac58b1-e37c-4106-b32b-74e041d7db44@quicinc.com>
 <Z74CDp6FNm9ih3Nf@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z74CDp6FNm9ih3Nf@google.com>

On Tue, Feb 25, 2025 at 09:46:54AM -0800, William McVicker wrote:
> On 02/25/2025, Zijun Hu wrote:
> > On 2/25/2025 9:18 AM, William McVicker wrote:
> > > Hi Zijun and Rob,
> > > 
> > > On 01/13/2025, Rob Herring wrote:
> > >> On Thu, Jan 09, 2025 at 09:27:00PM +0800, Zijun Hu wrote:
> > >>> From: Zijun Hu <quic_zijuhu@quicinc.com>
> > >>>
> > >>> According to DT spec, size of property 'alignment' is based on parent
> > >>> node’s #size-cells property.
> > >>>
> > >>> But __reserved_mem_alloc_size() wrongly uses @dt_root_addr_cells to get
> > >>> the property obviously.
> > >>>
> > >>> Fix by using @dt_root_size_cells instead of @dt_root_addr_cells.
> > >>
> > >> I wonder if changing this might break someone. It's been this way for 
> > >> a long time. It might be better to change the spec or just read 
> > >> 'alignment' as whatever size it happens to be (len / 4). It's not really 
> > >> the kernel's job to validate the DT. We should first have some 
> > >> validation in place to *know* if there are any current .dts files that 
> > >> would break. That would probably be easier to implement in dtc than 
> > >> dtschema. Cases of #address-cells != #size-cells should be pretty rare, 
> > >> but that was the default for OpenFirmware.
> > >>
> > >> As the alignment is the base address alignment, it can be argued that 
> > >> "#address-cells" makes more sense to use than "#size-cells". So maybe 
> > >> the spec was a copy-n-paste error.
> > > 
> > > Yes, this breaks our Pixel downstream DT :( Also, the upstream Pixel 6 device
> > > tree has cases where #address-cells != #size-cells.
> > >

I thought downstream kept kernels and DTs in sync, so the dts could be 
fixed?
 
> > 
> > it seems upstream upstream Pixel 6 has no property 'alignment'
> > git grep alignment arch/arm64/boot/dts/exynos/google/
> > so it should not be broken.
> 
> That's right. I was responding to Rob's statement about #address-cells !=
> #size-cells being pretty rare. And wanted to give credance to the idea that
> this change could possible break someone.
> 
> > 
> > > I would prefer to not have this change, but if that's not possible, could we
> > > not backport it to all the stable branches? That way we can just force new
> > > devices to fix this instead of existing devices on older LTS kernels?
> > > 
> > 
> > the fix have stable and fix tags. not sure if we can control its
> > backporting. the fix has been backported to 6.1/6.6/6.12/6.13 automatically.
> 
> Right, I think it's already backported to the LTS kernels, but if it breaks any
> in-tree users then we'd have to revert it. I just like Rob's idea to instead
> change the spec for obvious reasons :)

While if it is downstream, it doesn't exist, I'm reverting this for now. 
We need the tools to check this and look at other projects to see what 
they expect. Then we can think about changing the spec.

Rob

