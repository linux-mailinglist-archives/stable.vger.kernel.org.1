Return-Path: <stable+bounces-86790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194419A390A
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8712810A5
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09518FC7F;
	Fri, 18 Oct 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kgZ0Pny4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2118E76B
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241241; cv=none; b=qdD0filJFxuadtXhDgCXkLqa0QuWR+b1D0WToE5TCl6WiOFc2QrB4W/lCaJZOGHqtpLs2pLU+gTq8pqtzADnY3dJnMIpiNtRvZlReUFStJbSkGlSFkT4Xacjjshukhn0LKsq+mf0Uru0geModJISahHEKxA3YURGpx62S6+1nwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241241; c=relaxed/simple;
	bh=fQeb01CaKI5jdhIpCvwWzDL/PMMLZyYp4syorKQpjfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAzUH3ml/R9bUftwM2RhQwrElCKf3fJmb1xwmIeMyOVMf5xKTKCyNEWdfGX8Cqj3X1MVF4gE20QXzEiWJpLikCX+3RvYRa6NhA1HlMhh+yfPIKXbx168xNugrjawZRZQM8O+LZN9wmA2sWCuM6PuFDSzHvVauwq10/WxTdPilq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kgZ0Pny4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81759C4CEC3;
	Fri, 18 Oct 2024 08:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729241240;
	bh=fQeb01CaKI5jdhIpCvwWzDL/PMMLZyYp4syorKQpjfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kgZ0Pny4HdNf86e62RL4uom3yOHqaK2hQxuksFRta1pDyA/Jv1+WFYnyYK5w+0wgi
	 OA+NtXJdGQ5GsyyYEZccFgVAO+ZdJYJD81imxHl3pF/bgKsZ/JrJ7RJwgIYnOckz/w
	 nxttjp7N2LsaUcGpcNFeWY6k/j9txkPvqb3D6dNM=
Date: Fri, 18 Oct 2024 10:47:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org, Patrick Roy <roypat@amazon.co.uk>
Subject: Re: [PATCH 5.15.y] secretmem: disable memfd_secret() if arch cannot
 set direct map
Message-ID: <2024101853-margin-clumsily-6239@gregkh>
References: <2024101412-prowling-snowflake-9fe0@gregkh>
 <20241014152103.1328260-1-rppt@kernel.org>
 <2024101410-jiffy-handsaw-43e3@gregkh>
 <Zw1IN_Gm8LZjWEO4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw1IN_Gm8LZjWEO4@kernel.org>

On Mon, Oct 14, 2024 at 07:35:03PM +0300, Mike Rapoport wrote:
> On Mon, Oct 14, 2024 at 05:55:22PM +0200, Greg KH wrote:
> > On Mon, Oct 14, 2024 at 06:21:03PM +0300, Mike Rapoport wrote:
> > > From: Patrick Roy <roypat@amazon.co.uk>
> > > 
> > > Return -ENOSYS from memfd_secret() syscall if !can_set_direct_map().
> > > This is the case for example on some arm64 configurations, where marking
> > > 4k PTEs in the direct map not present can only be done if the direct map
> > > is set up at 4k granularity in the first place (as ARM's
> > > break-before-make semantics do not easily allow breaking apart
> > > large/gigantic pages).
> > > 
> > > More precisely, on arm64 systems with !can_set_direct_map(),
> > > set_direct_map_invalid_noflush() is a no-op, however it returns success
> > > (0) instead of an error. This means that memfd_secret will seemingly
> > > "work" (e.g. syscall succeeds, you can mmap the fd and fault in pages),
> > > but it does not actually achieve its goal of removing its memory from
> > > the direct map.
> > > 
> > > Note that with this patch, memfd_secret() will start erroring on systems
> > > where can_set_direct_map() returns false (arm64 with
> > > CONFIG_RODATA_FULL_DEFAULT_ENABLED=n, CONFIG_DEBUG_PAGEALLOC=n and
> > > CONFIG_KFENCE=n), but that still seems better than the current silent
> > > failure. Since CONFIG_RODATA_FULL_DEFAULT_ENABLED defaults to 'y', most
> > > arm64 systems actually have a working memfd_secret() and aren't be
> > > affected.
> > > 
> > > >>From going through the iterations of the original memfd_secret patch
> > > series, it seems that disabling the syscall in these scenarios was the
> > > intended behavior [1] (preferred over having
> > > set_direct_map_invalid_noflush return an error as that would result in
> > > SIGBUSes at page-fault time), however the check for it got dropped
> > > between v16 [2] and v17 [3], when secretmem moved away from CMA
> > > allocations.
> > > 
> > > [1]: https://lore.kernel.org/lkml/20201124164930.GK8537@kernel.org/
> > > [2]: https://lore.kernel.org/lkml/20210121122723.3446-11-rppt@kernel.org/#t
> > > [3]: https://lore.kernel.org/lkml/20201125092208.12544-10-rppt@kernel.org/
> > > 
> > > Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> > > Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> > > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >  mm/secretmem.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > What is the git id of this change in Linus's tree?
> 
> 532b53cebe58f34ce1c0f34d866f5c0e335c53c6

Thanks, next time please include that in the original patch so we don't
have to do this back/forth emails :)

now queued up.

greg k-h

