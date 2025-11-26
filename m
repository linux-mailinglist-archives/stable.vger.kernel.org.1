Return-Path: <stable+bounces-197006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28FC89A07
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB2A3B0E70
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4CB31C58A;
	Wed, 26 Nov 2025 11:59:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BAEED8
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158353; cv=none; b=Rn4GFt70xbkm2y5/YdU6oiLYGdq9gEtvI/noKK8uBHeiezphGAmjqKwlexjWXK8tb4usNuOxlcnGTHw7rUe+5+xDC7Gv7Eiw22Rzrh4pRnLothAMaUIiyYRqNI40k4CCNpvgcaYbBpqPJIM4IfQ8d9p2fZe4czlPaH9J2vOwoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158353; c=relaxed/simple;
	bh=hhip2iV+U/mR38ZSH8I0PHuv7pgd809quVb2yumdbxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrbZ3q8tulbzS5S3tUYPT1eOvH385iVmCeDfB7oR32FRLR64n+/33qrY1c+erPQzzBE32h/BB2FvjrsK16mOKjAKcQLLuYbFNinYM0NzQsn7xP1MpdL2K+0qOolbynSg0dcdw1/NrgNv1OXHKCnk74O3JE/Pgj3YF+hu2jmU+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D3AA168F;
	Wed, 26 Nov 2025 03:59:04 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B19953F73B;
	Wed, 26 Nov 2025 03:59:10 -0800 (PST)
Date: Wed, 26 Nov 2025 11:59:07 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6.1.y] pmdomain: arm: scmi: Fix genpd leak on provider
 registration failure
Message-ID: <20251126-sticky-hornet-of-hurricane-a4cac5@sudeepholla>
References: <2025112053-shallot-unsold-98f0@gregkh>
 <20251121160416.2587981-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121160416.2587981-1-sashal@kernel.org>

On Fri, Nov 21, 2025 at 11:04:16AM -0500, Sasha Levin wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> [ Upstream commit 7458f72cc28f9eb0de811effcb5376d0ec19094a ]
> 
> If of_genpd_add_provider_onecell() fails during probe, the previously
> created generic power domains are not removed, leading to a memory leak
> and potential kernel crash later in genpd_debug_add().
> 
> Add proper error handling to unwind the initialized domains before
> returning from probe to ensure all resources are correctly released on
> failure.
> 
> Example crash trace observed without this fix:
> 
>   | Unable to handle kernel paging request at virtual address fffffffffffffc70
>   | CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc1 #405 PREEMPT
>   | Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform
>   | pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   | pc : genpd_debug_add+0x2c/0x160
>   | lr : genpd_debug_init+0x74/0x98
>   | Call trace:
>   |  genpd_debug_add+0x2c/0x160 (P)
>   |  genpd_debug_init+0x74/0x98
>   |  do_one_initcall+0xd0/0x2d8
>   |  do_initcall_level+0xa0/0x140
>   |  do_initcalls+0x60/0xa8
>   |  do_basic_setup+0x28/0x40
>   |  kernel_init_freeable+0xe8/0x170
>   |  kernel_init+0x2c/0x140
>   |  ret_from_fork+0x10/0x20
> 
> Fixes: 898216c97ed2 ("firmware: arm_scmi: add device power domain support using genpd")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [ drivers/pmdomain/arm/scmi_pm_domain.c -> drivers/firmware/arm_scmi/scmi_pm_domain.c ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks Sasha, for following up on all these backports that didn't apply
cleanly by default. I was away from computer and couldn't do that myself.
Thanks again for this help and much appreciated! They all look good to me.

-- 
Regards,
Sudeep

