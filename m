Return-Path: <stable+bounces-139502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D58AA7734
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2183C4E0496
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A625D55B;
	Fri,  2 May 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3aZWnUC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43D3C465;
	Fri,  2 May 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203147; cv=none; b=qd1oJkhfvMXXL9uqRC/ubZGLTCuyaDIlUrzZdOET8DQ9jXx96aJ2Yt1IyfxGlFl6bq4kZIDVPVb7nnC0c3OjRDSl1Drg0qXpIraoRKqu5RzwY8+bHuRJetFMTgxC2hxsXHj79vRmxY6UK+DdjiuyvMMG1AnmnLzDhvN5FKqAwBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203147; c=relaxed/simple;
	bh=SoYH9fAelyV/OGDhVqF4z37NINCFU2ZaE+FhKzVeIgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJbWBrs2DhECXLW7VKSDmGzoQo4JMaHXs4hTfTyyVILPJLbMDHoiIaAs2IQ/H1mjbktAWQYRg+VXrMWXCImvk4n1uCcUuBQ/2MS3SBhAzPL16cvgz/5DJYBveDGHlXB2aKa/JVySa/+ZiVsqOc/+6jrf3lmYSZP+2EeQJZpUgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3aZWnUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E031EC4CEE4;
	Fri,  2 May 2025 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746203146;
	bh=SoYH9fAelyV/OGDhVqF4z37NINCFU2ZaE+FhKzVeIgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3aZWnUC7rLjBGOG9+KQzip5059CX5+9VT5bsv/KBfc4elrFh/gzXzTK3m2E2QQiz
	 fbjvGUiHQay8r796UJYOfLqaIEbfmV+6ESJDNghy8HQbO2RYxTwyOk98ZDgDaCfUqq
	 LZXftpF9Bq07uj9d7RLg4yrgtBfhSVyabZU0dW19Kw/+9rLizT5rGAXKj5rVyuyTfF
	 JbNkDDj082obrn6ccHXC4ghILL+t7IHORhDnE3MK392SNO4IedGTxBgzBMyi3eIqBG
	 n4E/Q2kn2FAYOvxOI7Oy6ez03U7rxWCbeb5Cu4pBgaivkDzLQYEYwdJQ7ttWIkHfb1
	 2UDsTPggFuylQ==
Date: Fri, 2 May 2025 09:25:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, frederic@kernel.org, joey.gouly@arm.com,
	james.morse@arm.com, hardevsinh.palaniya@siliconsignals.io,
	shameerali.kolothum.thodi@huawei.com, ardb@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <20250502162540.GB2850065@ax162>
References: <20250502145755.3751405-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502145755.3751405-1-yeoreum.yun@arm.com>

Hi Yeoreum,

On Fri, May 02, 2025 at 03:57:55PM +0100, Yeoreum Yun wrote:
> create_init_idmap() could be called before .bss section initialization
> which is done in early_map_kernel() since data/test_prot could be set
> wrong for PTE_MAYBE_NG macro.
> 
> PTE_MAYBE_NG macro is set according to value of "arm64_use_ng_mappings".
> and this variable is located in .bss section.
> 
>    # llvm-objdump-21 --syms vmlinux-gcc | grep arm64_use_ng_mappings
>      ffff800082f242a8 g O .bss    0000000000000001 arm64_use_ng_mappings
> 
> If .bss section doesn't initialized, "arm64_use_ng_mappings" would be set
> with garbage value ant then the text_prot or data_prot could be set
> with garbgae value.
> 
> Here is what i saw with kernel compiled via llvm-21
> 
>   // create_init_idmap()
>   ffff80008255c058: d10103ff     	sub	sp, sp, #0x40
>   ffff80008255c05c: a9017bfd     	stp	x29, x30, [sp, #0x10]
>   ffff80008255c060: a90257f6     	stp	x22, x21, [sp, #0x20]
>   ffff80008255c064: a9034ff4     	stp	x20, x19, [sp, #0x30]
>   ffff80008255c068: 910043fd     	add	x29, sp, #0x10
>   ffff80008255c06c: 90003fc8     	adrp	x8, 0xffff800082d54000
>   ffff80008255c070: d280e06a     	mov	x10, #0x703     // =1795
>   ffff80008255c074: 91400409     	add	x9, x0, #0x1, lsl #12 // =0x1000
>   ffff80008255c078: 394a4108     	ldrb	w8, [x8, #0x290] ------------- (1)
>   ffff80008255c07c: f2e00d0a     	movk	x10, #0x68, lsl #48
>   ffff80008255c080: f90007e9     	str	x9, [sp, #0x8]
>   ffff80008255c084: aa0103f3     	mov	x19, x1
>   ffff80008255c088: aa0003f4     	mov	x20, x0
>   ffff80008255c08c: 14000000     	b	0xffff80008255c08c <__pi_create_init_idmap+0x34>
>   ffff80008255c090: aa082d56     	orr	x22, x10, x8, lsl #11 -------- (2)
> 
> Note (1) is load the arm64_use_ng_mappings value in w8.
> and (2) is set the text or data prot with the w8 value to set PTE_NG bit.
> If .bss section doesn't initialized, x8 can include garbage value
> -- In case of some platform, x8 loaded with 0xcf -- it could generate
> wrong mapping. (i.e) text_prot is expected with
> PAGE_KERNEL_ROX(0x0040000000000F83) but
> with garbage x8 -- 0xcf, it sets with (0x0040000000067F83)
> and This makes boot failure with translation fault.
> 
> This error cannot happen according to code generated by compiler.
> here is the case of gcc:
> 
>    ffff80008260a940 <__pi_create_init_idmap>:
>    ffff80008260a940: d100c3ff      sub     sp, sp, #0x30
>    ffff80008260a944: aa0003ed      mov     x13, x0
>    ffff80008260a948: 91400400      add     x0, x0, #0x1, lsl #12 // =0x1000
>    ffff80008260a94c: a9017bfd      stp     x29, x30, [sp, #0x10]
>    ffff80008260a950: 910043fd      add     x29, sp, #0x10
>    ffff80008260a954: f90017e0      str     x0, [sp, #0x28]
>    ffff80008260a958: d00048c0      adrp    x0, 0xffff800082f24000 <reset_devices>
>    ffff80008260a95c: 394aa000      ldrb    w0, [x0, #0x2a8]
>    ffff80008260a960: 37000640      tbnz    w0, #0x0, 0xffff80008260aa28 <__pi_create_init_idmap+0xe8> ---(3)
>    ffff80008260a964: d280f060      mov     x0, #0x783      // =1923
>    ffff80008260a968: d280e062      mov     x2, #0x703      // =1795
>    ffff80008260a96c: f2e00800      movk    x0, #0x40, lsl #48
>    ffff80008260a970: f2e00d02      movk    x2, #0x68, lsl #48
>    ffff80008260a974: aa2103e4      mvn     x4, x1
>    ffff80008260a978: 8a210049      bic     x9, x2, x1
>    ...
>    ffff80008260aa28: d281f060      mov     x0, #0xf83      // =3971
>    ffff80008260aa2c: d281e062      mov     x2, #0xf03      // =3843
>    ffff80008260aa30: f2e00800      movk    x0, #0x40, lsl #48
> 
> In case of gcc, according to value of arm64_use_ng_mappings (annoated as(3)),
> it branches to each prot settup code.

> However this is also problem since it branches according to garbage
> value too -- idmapping with wrong pgprot.
> 
> To resolve this, annotate arm64_use_ng_mappings as ro_after_init.
> 
> Fixes: 84b04d3e6bdb ("arm64: kernel: Create initial ID map from C code")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---

This appears to resolve the issue that I reported to LLVM upstream:

https://github.com/llvm/llvm-project/issues/138019

Tested-by: Nathan Chancellor <nathan@kernel.org>

It does not look like there is anything for the compiler to fix in this
case, correct?

> ---
>  arch/arm64/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d2104a1e7843..967ffb1cbd52 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -114,7 +114,7 @@ static struct arm64_cpu_capabilities const __ro_after_init *cpucap_ptrs[ARM64_NC
> 
>  DECLARE_BITMAP(boot_cpucaps, ARM64_NCAPS);
> 
> -bool arm64_use_ng_mappings = false;
> +bool arm64_use_ng_mappings __ro_after_init = false;
>  EXPORT_SYMBOL(arm64_use_ng_mappings);
> 
>  DEFINE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector) = vectors;
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
> 

