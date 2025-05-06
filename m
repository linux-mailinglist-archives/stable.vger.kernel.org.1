Return-Path: <stable+bounces-141786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C00AAC12B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9BB3A74D0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7A263C9E;
	Tue,  6 May 2025 10:17:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24394212B04;
	Tue,  6 May 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526663; cv=none; b=RIOnHNEmNHf8Y9GI9R/yJw6Fd5wHnRN24V+O00o/RCUpZeDYECBARUQQHQE/PVJrg9W009DfIEh6Ri1TNi9Fp+deQGw8t9u3CTNyovBcM4hGDlM3WLWfTQmzBFT1BVDayUsJ+TpOCe2Ar/qu/eJfv94q7J7PrYMHs6+uMbpnbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526663; c=relaxed/simple;
	bh=IX+PP8LlX1bH0FcoepRyMQgD9hjjLVq86Rm6toSU0G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxRiCQlZuU0G2YXLSOS5EaSxBP0oGyYWJks3OsdqYZ4aHLCpWRMallsFwb/W1RUQdhDo3fphUOti8tuY5YnTvdtQ9pSb4b8Q8c8r4nEx5LtJFMvI6Lic8D4Y0F0apGX54FP5DHEBHB9iD7G9KZHQXEqAFDGt56BtJJyq3oYFvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8494CC4CEE4;
	Tue,  6 May 2025 10:17:39 +0000 (UTC)
Date: Tue, 6 May 2025 11:17:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
	will@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnhwZKInFEiPkhz@arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>

On Tue, May 06, 2025 at 11:41:05AM +0200, Ard Biesheuvel wrote:
> On Tue, 6 May 2025 at 10:16, Ryan Roberts <ryan.roberts@arm.com> wrote:
> > On 06/05/2025 09:09, Yeoreum Yun wrote:
> > >> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> > >>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > >>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > >>>>>> create_init_idmap() could be called before .bss section initialization
> > >>>>>> which is done in early_map_kernel().
> > >>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > >>>>>>
> > >>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > >>>>>> and this variable places in .bss section.
> > >>>>>>
> > >>>>>> [...]
> > >>>>>
> > >>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > >>>>> comment, thanks!
> > >>>>>
> > >>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> > >>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> > >>>>
> > >>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> > >>>> version I have around (Debian sid) fails to boot, gets stuck early on:
> > >>>>
> > >>>> $ clang --version
> > >>>> Debian clang version 19.1.5 (1)
> > >>>> Target: aarch64-unknown-linux-gnu
> > >>>> Thread model: posix
> > >>>> InstalledDir: /usr/lib/llvm-19/bin
> > >>>>
> > >>>> I didn't have time to investigate, disassemble etc. I'll have a look
> > >>>> next week.
> > >>>
> > >>> Just for your information.
> > >>> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> > >>>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> > >>>
> > >>> and the default version for sid is below:
> > >>>
> > >>> $ clang-19 --version
> > >>> Debian clang version 19.1.7 (3)
> > >>> Target: aarch64-unknown-linux-gnu
> > >>> Thread model: posix
> > >>> InstalledDir: /usr/lib/llvm-19/bin
> > >>>
> > >>> When I tested with above version with arm64-linux's for-next/fixes
> > >>> including this patch. it works well.
> > >>
> > >> It doesn't seem to be toolchain related. It fails with gcc as well from
> > >> Debian stable but you'd need some older CPU (even if emulated, e.g.
> > >> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> > >> Neoverse-N2. Also changing the annotation from __ro_after_init to
> > >> __read_mostly also works.
> >
> > I think this is likely because __ro_after_init is also "ro before init" - i.e.
> > if you try to write to it in the PI code an exception is generated due to it
> > being mapped RO. Looks like early_map_kernel() is writiing to it.
> 
> Indeed.
> 
> > I've noticed a similar problem in the past and it would be nice to fix it so
> > that PI code maps __ro_after_init RW.
> 
> The issue is that the store occurs via the ID map, which only consists
> of one R-X and one RW- section. I'm not convinced that it's worth the
> hassle to relax this.
> 
> If moving the variable to .data works, then let's just do that.

Good to know there's no other more serious issue. I'll move this
variable to __read_mostly.

It seems to fail in early_map_kernel() if RANDOMIZE_BASE is enabled.

-- 
Catalin

