Return-Path: <stable+bounces-47656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8879F8D3E53
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 20:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59031C20FE5
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4DC15D5AF;
	Wed, 29 May 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJXnETLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895D139588;
	Wed, 29 May 2024 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007341; cv=none; b=OqoovyEAHloB/PA01q1vSTNYByb2GcrlGKFRzGd+nVWGTDFXvqxdnNr826vU26wNIdJnMm1H+GIzrXJ9PaKmG9AO7PLM7PpEiozYfInLJUW2fbWo1EUi6MrkFJWWCVdgwwc/hofs71eJFIpsue58+5lNijXDG2JoWdM6aqQqswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007341; c=relaxed/simple;
	bh=F+taAuGNZhYoMVVTU7lLtx1SfJK0lEHssiup5OjbRwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poWNIdkMcU/yUyadDcvrE4H72IWejS6PuNAyviFT87LO28DogZyb5QquVTFeb4h4SqnIBZB56W04BOCn38cZBTI6fr2LRG60NKw9rC5yawMxjYbrzkD+WfDAezdbpnQRXoz5HeoxjO62bzNaU67aFz8lrlyI+99GgnCc1zWNCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJXnETLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98A3C113CC;
	Wed, 29 May 2024 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717007341;
	bh=F+taAuGNZhYoMVVTU7lLtx1SfJK0lEHssiup5OjbRwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJXnETLB0f223e8W2RsjVYjIMqr7bToNJyCmyAB7OTW0Iicuh+rYG+KqGLCO7ayAa
	 5Zjo3ibnNU2XwEc8OSrrpR+1TAEW1ZAKLXmVnd7TwUVt+pkO/C7yQit4ADtk1by60H
	 18N9HLeNgZt14M20HKEBHZXu0bPKDdCnhjCZWpkCqd+Ag4TPBIn7/Mv5/bwJC5PQCh
	 VBT/OnOdiSVlRL7tTRDbSpnUUoY0jGfrW3YsMZPt1mmZKjBvj+ukeeS4wMX0qXYyEc
	 v9Zo2t6/fE7gXSOVGqjADcEXaVQ08aKhfDUg/zief3WxpW+mv7LHka2D7m4VfgEWE9
	 lc2xnfVCwm4dg==
Date: Wed, 29 May 2024 11:28:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 3/4] LoongArch: Fix entry point in image header
Message-ID: <20240529182859.GA3994034@thelio-3990X>
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
 <20240522-loongarch-booting-fixes-v3-3-25e77a8fc86e@flygoat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-loongarch-booting-fixes-v3-3-25e77a8fc86e@flygoat.com>

Hi Jiaxun,

On Wed, May 22, 2024 at 11:02:19PM +0100, Jiaxun Yang wrote:
> Currently kernel entry in head.S is in DMW address range,
> firmware is instructed to jump to this address after loading
> the image.
> 
> However kernel should not make any assumption on firmware's
> DMW setting, thus the entry point should be a physical address
> falls into direct translation region.
> 
> Fix by converting entry address to physical and amend entry
> calculation logic in libstub accordingly.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Fix efistub
> v3: Move calculation to linker script
> ---
>  arch/loongarch/kernel/head.S             | 2 +-
>  arch/loongarch/kernel/vmlinux.lds.S      | 2 ++
>  drivers/firmware/efi/libstub/loongarch.c | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index c4f7de2e2805..2cdc1ea808d9 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -22,7 +22,7 @@
>  _head:
>  	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
>  	.org	0x8
> -	.dword	kernel_entry		/* Kernel entry point */
> +	.dword	_kernel_entry_phys	/* Kernel entry point (physical address) */
>  	.dword	_kernel_asize		/* Kernel image effective size */
>  	.quad	PHYS_LINK_KADDR		/* Kernel image load offset from start of RAM */
>  	.org	0x38			/* 0x20 ~ 0x37 reserved */
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index e8e97dbf9ca4..c6f89e51257a 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -6,6 +6,7 @@
>  
>  #define PAGE_SIZE _PAGE_SIZE
>  #define RO_EXCEPTION_TABLE_ALIGN	4
> +#define TO_PHYS_MASK			0x000fffffffffffff /* 48-bit */
>  
>  /*
>   * Put .bss..swapper_pg_dir as the first thing in .bss. This will
> @@ -142,6 +143,7 @@ SECTIONS
>  
>  #ifdef CONFIG_EFI_STUB
>  	/* header symbols */
> +	_kernel_entry_phys = kernel_entry & TO_PHYS_MASK;
>  	_kernel_asize = _end - _text;
>  	_kernel_fsize = _edata - _text;
>  	_kernel_vsize = _end - __initdata_begin;
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
> index 684c9354637c..60c145121393 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -41,7 +41,7 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
>  unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
>  		efi_loaded_image_t *image)
>  {
> -	return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS + kernel_addr;
> +	return *(unsigned long *)(kernel_addr + 8) - TO_PHYS(VMLINUX_LOAD_ADDRESS) + kernel_addr;
>  }
>  
>  efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> 
> -- 
> 2.43.0
> 

This patch is now in -next as commit 75461304ee4e ("LoongArch: Fix entry
point in kernel image header"). I just bisected a build failure that I
see when building with LLVM (either 18 or 19) to this change.

$ make -skj"$(nproc)" ARCH=loongarch LLVM=1 defconfig vmlinux
...
kallsyms failure: relative symbol value 0x9000000000200000 out of range in relative mode
make[4]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
...

Does kallsyms need some adjustment for this?

Cheers,
Nathan

# bad: [9d99040b1bc8dbf385a8aa535e9efcdf94466e19] Add linux-next specific files for 20240529
# good: [e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc] Merge tag 'tpmdd-next-6.10-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
git bisect start '9d99040b1bc8dbf385a8aa535e9efcdf94466e19' 'e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc'
# bad: [270c6bb9d5e8448b74950f23ff2a192faaf10428] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect bad 270c6bb9d5e8448b74950f23ff2a192faaf10428
# good: [c38b067bf2ab58d93590a50cbc06c992fe00447e] Merge branch 'ti-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
git bisect good c38b067bf2ab58d93590a50cbc06c992fe00447e
# bad: [6bcfb2dcf8b00c0b4cef68ac026c71dae3c25070] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
git bisect bad 6bcfb2dcf8b00c0b4cef68ac026c71dae3c25070
# good: [2ca0cd490407a728a9aa57b9538f3ca8b287a089] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
git bisect good 2ca0cd490407a728a9aa57b9538f3ca8b287a089
# good: [f3760c80d06a838495185c0fe341c043e6495142] Merge branch 'rework/write-atomic' into for-next
git bisect good f3760c80d06a838495185c0fe341c043e6495142
# good: [b9fc9904efcaea8470f0d4cd0691f1295add9381] Merge branch 'vfs.module.description' into vfs.all
git bisect good b9fc9904efcaea8470f0d4cd0691f1295add9381
# good: [88dbb5f3c068ba8944e97235ccfdc5fbd6c7d577] Merge branch '9p-next' of git://github.com/martinetd/linux
git bisect good 88dbb5f3c068ba8944e97235ccfdc5fbd6c7d577
# bad: [b4660cd50cb1e5821532e34dbc7f47cb155ba57b] Merge branch 'next' of git://git.monstr.eu/linux-2.6-microblaze.git
git bisect bad b4660cd50cb1e5821532e34dbc7f47cb155ba57b
# bad: [c768fc96978cd0f74dd297d58720cb984a7f6341] LoongArch: Override higher address bits in JUMP_VIRT_ADDR
git bisect bad c768fc96978cd0f74dd297d58720cb984a7f6341
# good: [2624e739c2e9abe5f6cc9acc37f9752f0055fb5f] LoongArch: Add all CPUs enabled by fdt to NUMA node 0
git bisect good 2624e739c2e9abe5f6cc9acc37f9752f0055fb5f
# bad: [75461304ee4e7e2cb282265a6a89c35b81282d19] LoongArch: Fix entry point in kernel image header
git bisect bad 75461304ee4e7e2cb282265a6a89c35b81282d19
# first bad commit: [75461304ee4e7e2cb282265a6a89c35b81282d19] LoongArch: Fix entry point in kernel image header

