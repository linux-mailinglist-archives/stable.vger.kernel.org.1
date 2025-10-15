Return-Path: <stable+bounces-185767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D9BDD7AF
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D0614E632A
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A81316910;
	Wed, 15 Oct 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ir6Zs0hN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44595316904;
	Wed, 15 Oct 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517948; cv=none; b=qqK85h5INcqwm+UeFwTYi2C5VSDLlUA+dQ+SvKKbVYenNoh4NHu6oLjopO1X5T3nvOwTD17PUF1L4Q+gbhVVzziE4NeTcCdQYA7bMcKkrm/GKVUBMh5AfcSIXuFznMSBG6EVNSjBpN21t+Z6z7XbQeKv78E17qQtNvW8irbQxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517948; c=relaxed/simple;
	bh=DTtavYtlGb2w1Yr8Tphl10sFarIb3c8z9mxfW4goRPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKaViSFP82bNist+782dU09+215FyvAr1B4+WSZM03/s1UXJnCQ6kNj+exyoRGDUGBpT4cAfh30Qqpps74mg4IyHRCHxZs1kG7BMDEm2LEDxzJBFU8qdI1xiwIBru7s9d+bbf2gbomXu7dtqGaqXtUh8efIamdyQocLtf/bWJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ir6Zs0hN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A971FC4CEF9;
	Wed, 15 Oct 2025 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760517948;
	bh=DTtavYtlGb2w1Yr8Tphl10sFarIb3c8z9mxfW4goRPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ir6Zs0hNhL/mYGjccGOJDmxazlR91P0F+S7IeEN0iBCsCRFgOwTsEM/dtU1R51YIf
	 t14M195A0RwqYbS2PAnRGFgzbNPjRHHxFKtkP4yKimhBc/umuoBP9Eg9D72+oGsnOY
	 IND+URhpHbe4/MrclFJw577zI8mCz41Afc+5TiaE=
Date: Wed, 15 Oct 2025 10:45:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wen Yang <wen.yang@linux.dev>, Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1 0/6] fix invalid sleeping in detect_cache_attributes()
Message-ID: <2025101512-overlap-maggot-441c@gregkh>
References: <cover.1759251543.git.wen.yang@linux.dev>
 <2025101509-bucktooth-reawake-5176@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101509-bucktooth-reawake-5176@gregkh>

On Wed, Oct 15, 2025 at 10:43:01AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 01, 2025 at 01:27:25AM +0800, Wen Yang wrote:
> > commit 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection
> > in the CPU hotplug path")
> > adds a call to detect_cache_attributes() to populate the cacheinfo
> > before updating the siblings mask. detect_cache_attributes() allocates
> > memory and can take the PPTT mutex (on ACPI platforms). On PREEMPT_RT
> > kernels, on secondary CPUs, this triggers a:
> >   'BUG: sleeping function called from invalid context'
> > as the code is executed with preemption and interrupts disabled:
> > 
> >  | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> >  | in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/111
> >  | preempt_count: 1, expected: 0
> >  | RCU nest depth: 1, expected: 1
> >  | 3 locks held by swapper/111/0:
> >  |  #0:  (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x218/0x12c8
> >  |  #1:  (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x48/0xf0
> >  |  #2:  (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x64/0xa80
> >  | irq event stamp: 0
> >  | hardirqs last  enabled at (0):  0x0
> >  | hardirqs last disabled at (0):  copy_process+0x5dc/0x1ab8
> >  | softirqs last  enabled at (0):  copy_process+0x5dc/0x1ab8
> >  | softirqs last disabled at (0):  0x0
> >  | Preemption disabled at:
> >  |  migrate_enable+0x30/0x130
> >  | CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-rt6-[...]
> >  | Call trace:
> >  |  __kmalloc+0xbc/0x1e8
> >  |  detect_cache_attributes+0x2d4/0x5f0
> >  |  update_siblings_masks+0x30/0x368
> >  |  store_cpu_topology+0x78/0xb8
> >  |  secondary_start_kernel+0xd0/0x198
> >  |  __secondary_switched+0xb0/0xb4
> > 
> > 
> > Pierre fixed this issue in the upstream 6.3 and the original series is follows:
> > https://lore.kernel.org/all/167404285593.885445.6219705651301997538.b4-ty@arm.com/
> > 
> > We also encountered the same issue on 6.1 stable branch,  and need to backport this series.
> > 
> > Pierre Gondois (6):
> >   cacheinfo: Use RISC-V's init_cache_level() as generic OF
> >     implementation
> >   cacheinfo: Return error code in init_of_cache_level()
> >   cacheinfo: Check 'cache-unified' property to count cache leaves
> >   ACPI: PPTT: Remove acpi_find_cache_levels()
> >   ACPI: PPTT: Update acpi_find_last_cache_level() to
> >     acpi_get_cache_info()
> >   arch_topology: Build cacheinfo from primary CPU
> 
> This series seems to have broken existing systems, as reported here:
> 	https://lore.kernel.org/r/046f08cb-0610-48c9-af24-4804367df177@nvidia.com
> 
> so I'm going to drop it from the queue at this point in time.  Please
> work to resolve this before resubmitting it.

Also note that there was a non-trivial number of follow-on fixes for
patches in this series that I had to backport to the tree as well.
When/if you resubmit this, please also include all of those fixes also.

thanks,

greg k-h

