Return-Path: <stable+bounces-40740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B28AF4C1
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E28F1C21D21
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D3813D638;
	Tue, 23 Apr 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9uYhkMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733513D62A
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891608; cv=none; b=UQUwMr1i5jn0MuW7rM6deGKq9JQMbIHH8byDwmUdp8ejH//2VOkc+mQOUNkGlnnuqwksR1v15jnlv+77iBvNTq/uXT77Bne9boZc5cnqNi4P3O2ey/s69EeNg5IUyI2GIW2eeAFKPnTYfTZcX8HeDTXP9mWoApnDPSkJHk5PpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891608; c=relaxed/simple;
	bh=HMEAYGajsCffoylvJDgJxt0Wvfz5vPmcyCHzShNi58A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2o8xhBnM25MQXTpPY6IXu9E2g1MC02oXOC06XUpRSX+2U0ExWbeyyvvHbeEIB1tai5dNdgrHvjnPNSJSELWfCau3VRaagnntN4Fv/Rl+JxRa40K9OGGKZP00u8zXqQGYB7zSxH4amqZqn3+CdJfpifUfjR4NS6Ad4t0tFQcbpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9uYhkMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48290C116B1;
	Tue, 23 Apr 2024 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713891608;
	bh=HMEAYGajsCffoylvJDgJxt0Wvfz5vPmcyCHzShNi58A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9uYhkMioyW2qxKbVswj/kBJp2NfbKm7e/4/p3H5b7zZg2b3WcvjxQK2T2aHgS1bH
	 XmJuYl+X3mBdikofcYeJxHIpaPIuQPZc1mGnH2HzR/Rx/ic/Bz/pgYPKpjG5OLr4NL
	 5Yh8p1/x0/bagTK7PTrqtdRGuKbfQYXxabKPy8cw=
Date: Tue, 23 Apr 2024 09:59:58 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org,
	petr@tesarici.cz, Sasha Levin <sashal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	kernel mailing list <kernel@lists.collabora.co.uk>,
	kernel@collabora.com, skhan@linuxfoundation.org
Subject: Re: stable-rc: 5.10: arm: u64_stats_sync.h:136:2: error: implicit
 declaration of function 'preempt_disable_nested'
Message-ID: <2024042331-pusher-snowfall-2e23@gregkh>
References: <CA+G9fYsyacpJG1NwpbyJ_68B=cz5DvpRpGCD_jw598H3FXgUdQ@mail.gmail.com>
 <2024042307-detract-flammable-d542@gregkh>
 <7dc1b-6627e780-5-39ef3480@154053587>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dc1b-6627e780-5-39ef3480@154053587>

On Tue, Apr 23, 2024 at 05:53:18PM +0100, Shreeya Patel wrote:
> On Tuesday, April 23, 2024 21:52 IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Apr 23, 2024 at 01:35:28PM +0530, Naresh Kamboju wrote:
> > > The arm and i386 builds failed with clang-17 and gcc-12 on stable-rc
> > > linux.5.10.y
> > > branch with linked config [1].
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > In file included from init/do_mounts.c:7:
> > > In file included from include/linux/suspend.h:5:
> > > In file included from include/linux/swap.h:9:
> > > In file included from include/linux/memcontrol.h:13:
> > > In file included from include/linux/cgroup.h:28:
> > > In file included from include/linux/cgroup-defs.h:20:
> > > include/linux/u64_stats_sync.h:136:2: error: implicit declaration of
> > > function 'preempt_disable_nested'
> > > [-Werror,-Wimplicit-function-declaration]
> > >   136 |         preempt_disable_nested();
> > >       |         ^
> > 
> > That function is not in the queue at all, are you sure you are up to
> > date?
> > 
> 
> Hi Greg,
> 
> Just to add, KernelCI has also reported these failures on stable-rc 5.10 kernel recently.
> Following are the details for it :-
> 
> 32r2el_defconfig ‐ mips ‐ gcc-101 warning — 2 errors
> allnoconfig ‐ i386 ‐ gcc-101 warning — 2 errors
> haps_hs_smp_defconfig ‐ arc ‐ gcc-107 warnings — 14 errors
> i386_defconfig ‐ i386 ‐ gcc-101 warning — 2 errors
> imx_v6_v7_defconfig ‐ arm ‐ gcc-107 warnings — 14 errors
> multi_v5_defconfig ‐ arm ‐ gcc-108 warnings — 16 errors
> multi_v7_defconfig ‐ arm ‐ gcc-107 warnings — 14 errors
> omap2plus_defconfig ‐ arm ‐ gcc-108 warnings — 16 errors
> rv32_defconfig ‐ riscv ‐ gcc-1010 warnings — 16 errors
> tinyconfig ‐ i386 ‐ gcc-101 warning — 2 errors
> vexpress_defconfig ‐ arm ‐ gcc-109 warnings — 18 errors
> 
> Build Logs Summary
> Errors Summary
> include/linux/u64_stats_sync.h:143:2: error: implicit declaration of function ‘preempt_enable_nested’; did you mean ‘preempt_enable_no_resched’? [-Werror=implicit-function-declaration]
> include/linux/u64_stats_sync.h:136:2: error: implicit declaration of function ‘preempt_disable_nested’; did you mean ‘preempt_disable_notrace’? [-Werror=implicit-function-declaration]
> include/linux/u64_stats_sync.h:143:2: error: implicit declaration of function 'preempt_enable_nested'; did you mean 'preempt_enable_no_resched'? [-Werror=implicit-function-declaration]
> include/linux/u64_stats_sync.h:136:2: error: implicit declaration of function 'preempt_disable_nested'; did you mean 'preempt_disable_notrace'? [-Werror=implicit-function-declaration]

Again, very odd, I do not see that anywhere in the patch queue.  I've
updated the -rc git tree, perhaps an old version was in there somehow...

thanks,

greg k-h

