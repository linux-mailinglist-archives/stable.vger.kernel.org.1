Return-Path: <stable+bounces-139733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16490AA9C35
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 21:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2803C1A808C4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E52264FB1;
	Mon,  5 May 2025 19:05:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456525C838;
	Mon,  5 May 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471938; cv=none; b=oiDibLew+PIIMcZ4trztzHOsY7zU2t6C/Bs16jY5ruzOR4/6pQB+C1+BnjzvgVDqWMKJejddnPunO8rf6mpnmaZyeGCSIuWkzCTgyTjMZA8qRjcBqBKiXvl+dy9wSZ6yQh2vzpqVi0qHltY+fEMQje4oRbunT7dx1yqOIjTyUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471938; c=relaxed/simple;
	bh=zLLFEBlol02oWM0LKpfVuL7nVrFwbxR9+q4EorbEX8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwuNzWySuEV5E4NaAVVdO8z3b7mIkPnvgH7bFbkrYSgVRzh/dYNSm7NNbGpHysXc/7y8F3lXDwV6nyTyPiDUNbNYKe/9/MdmmpMtb53V7RBUjKb6W6ZW/sPrY+4rqBfzcR5j58h05zqrEB32Cs4+HnAPwy/+elyyS6gJwO5lebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C264C4CEE4;
	Mon,  5 May 2025 19:05:34 +0000 (UTC)
Date: Mon, 5 May 2025 20:05:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: will@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBkL-zUpbg7_gCEp@arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBZ7P3/dUfSjB0oV@e129823.arm.com>

On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> Hi Catalin,
> 
> > On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > > On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > > > create_init_idmap() could be called before .bss section initialization
> > > > which is done in early_map_kernel().
> > > > Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > > >
> > > > PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > > > and this variable places in .bss section.
> > > >
> > > > [...]
> > >
> > > Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > > comment, thanks!
> > >
> > > [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> > >       https://git.kernel.org/arm64/c/12657bcd1835
> >
> > I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> > version I have around (Debian sid) fails to boot, gets stuck early on:
> >
> > $ clang --version
> > Debian clang version 19.1.5 (1)
> > Target: aarch64-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/lib/llvm-19/bin
> >
> > I didn't have time to investigate, disassemble etc. I'll have a look
> > next week.
> 
> Just for your information.
> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> 
> and the default version for sid is below:
> 
> $ clang-19 --version
> Debian clang version 19.1.7 (3)
> Target: aarch64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/lib/llvm-19/bin
> 
> When I tested with above version with arm64-linux's for-next/fixes
> including this patch. it works well.

It doesn't seem to be toolchain related. It fails with gcc as well from
Debian stable but you'd need some older CPU (even if emulated, e.g.
qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
Neoverse-N2. Also changing the annotation from __ro_after_init to
__read_mostly also works.

I haven't debugged it yet but I wonder whether something wants to write
this variable after it was made read-only (well, I couldn't find any by
grep'ing the code, so it needs some step-by-step debugging).

-- 
Catalin

