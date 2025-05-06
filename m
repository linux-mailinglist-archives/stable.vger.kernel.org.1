Return-Path: <stable+bounces-141788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4CFAAC15A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C75C4A4567
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C50275869;
	Tue,  6 May 2025 10:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9185238C25;
	Tue,  6 May 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527348; cv=none; b=jwHJXJ/qEZamY5tX3tJaxftUmUzvyuOC3JAiasOKWF569MPs3UJZWn+GChnpmjyYwxDM8D0JO7aUhXtskVeikJPI3YhHcKMnkz7UrE77SCL8x0bNfkOoYW0Cb6zFeREQ06udbM0W3sSWrIMmrq89OR0CNCBCSuH+CGSIz8ftq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527348; c=relaxed/simple;
	bh=RvVgQRuS1ioTG27+rPn4EgtU4kcWSyIYqIhT8KufxXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOHEN84q81fRdzuhuqQ7Wwm9C0yim0Rg0/d8liAVl6Uxp/E5gRfpMkZkG4MbHy03iCWMtK4t+SpdmZd7eEI+HOr/5AVBqxAUZNBeiAq8HDDYiPrJgr57q8uVOwOl71FS8lIlWbdMKxooO8Cl71bjqpjgbWWITZehFsFHWzJzurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1012FC4CEE4;
	Tue,  6 May 2025 10:29:04 +0000 (UTC)
Date: Tue, 6 May 2025 11:29:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
	will@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnkbkVMEAQsYIpJ@arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
 <aBnhwZKInFEiPkhz@arm.com>
 <3cfcd0c5-79a2-45de-8497-fb95ef834dc1@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cfcd0c5-79a2-45de-8497-fb95ef834dc1@arm.com>

On Tue, May 06, 2025 at 11:22:47AM +0100, Ryan Roberts wrote:
> On 06/05/2025 11:17, Catalin Marinas wrote:
> > On Tue, May 06, 2025 at 11:41:05AM +0200, Ard Biesheuvel wrote:
> >> On Tue, 6 May 2025 at 10:16, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>> On 06/05/2025 09:09, Yeoreum Yun wrote:
> >>>>> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> >>>>>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> >>>>>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> >>>>>>>>> create_init_idmap() could be called before .bss section initialization
> >>>>>>>>> which is done in early_map_kernel().
> >>>>>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> >>>>>>>>>
> >>>>>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> >>>>>>>>> and this variable places in .bss section.
> >>>>>>>>>
> >>>>>>>>> [...]
> >>>>>>>>
> >>>>>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> >>>>>>>> comment, thanks!
> >>>>>>>>
> >>>>>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> >>>>>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> >>>>>>>
> >>>>>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> >>>>>>> version I have around (Debian sid) fails to boot, gets stuck early on:
> >>>>>>>
> >>>>>>> $ clang --version
> >>>>>>> Debian clang version 19.1.5 (1)
> >>>>>>> Target: aarch64-unknown-linux-gnu
> >>>>>>> Thread model: posix
> >>>>>>> InstalledDir: /usr/lib/llvm-19/bin
> >>>>>>>
> >>>>>>> I didn't have time to investigate, disassemble etc. I'll have a look
> >>>>>>> next week.
> >>>>>>
> >>>>>> Just for your information.
> >>>>>> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> >>>>>>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> >>>>>>
> >>>>>> and the default version for sid is below:
> >>>>>>
> >>>>>> $ clang-19 --version
> >>>>>> Debian clang version 19.1.7 (3)
> >>>>>> Target: aarch64-unknown-linux-gnu
> >>>>>> Thread model: posix
> >>>>>> InstalledDir: /usr/lib/llvm-19/bin
> >>>>>>
> >>>>>> When I tested with above version with arm64-linux's for-next/fixes
> >>>>>> including this patch. it works well.
> >>>>>
> >>>>> It doesn't seem to be toolchain related. It fails with gcc as well from
> >>>>> Debian stable but you'd need some older CPU (even if emulated, e.g.
> >>>>> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> >>>>> Neoverse-N2. Also changing the annotation from __ro_after_init to
> >>>>> __read_mostly also works.
> >>>
> >>> I think this is likely because __ro_after_init is also "ro before init" - i.e.
> >>> if you try to write to it in the PI code an exception is generated due to it
> >>> being mapped RO. Looks like early_map_kernel() is writiing to it.
> >>
> >> Indeed.
> >>
> >>> I've noticed a similar problem in the past and it would be nice to fix it so
> >>> that PI code maps __ro_after_init RW.
> >>
> >> The issue is that the store occurs via the ID map, which only consists
> >> of one R-X and one RW- section. I'm not convinced that it's worth the
> >> hassle to relax this.
> >>
> >> If moving the variable to .data works, then let's just do that.
> > 
> > Good to know there's no other more serious issue. I'll move this
> > variable to __read_mostly.
> > 
> > It seems to fail in early_map_kernel() if RANDOMIZE_BASE is enabled.
> 
> Ahh that explains why Yeoreum Yun can't see the issue:
> 
> 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> 		u64 kaslr_seed = kaslr_early_init(fdt, chosen);
> 
> 		if (kaslr_seed && kaslr_requires_kpti())
> 			arm64_use_ng_mappings = true;
> 
> 		kaslr_offset |= kaslr_seed & ~(MIN_KIMG_ALIGN - 1);
> 	}

Yeah, you may need this as well for qemu:

	-object rng-random,filename=/dev/urandom,id=rng0 \
	-device virtio-rng-pci,rng=rng0 \

BTW, some architectures have RO_DATA immediately after _sdata but for us
it messes up some of the contig mappings, so the safest is to move the
variable to the .data section.

-- 
Catalin

