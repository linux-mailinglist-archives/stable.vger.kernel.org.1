Return-Path: <stable+bounces-132657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EACA88AFA
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 20:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD5C7A8D95
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC728B50C;
	Mon, 14 Apr 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsvItA+H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF328B508;
	Mon, 14 Apr 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655194; cv=none; b=LXoe90PDPpQfYU1JMcoaGnskWVETcCSiQvBqi3lHTREF33wcYU3czsS8B/Ih6b0uaZKuth8HL8/3S0ucw+tsSr6ZcfpD5rIVzn+Ezu3oFelYDZinoD4squqLVADBqvSR27nbnBnocZjbhu/Cw22Ft/nW68PFsWU4wB+iHgDGzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655194; c=relaxed/simple;
	bh=zxI4p+wjrRQ0jkQ2RkuWxk4aLUvNDztSLjxQS/HnlH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkJjf90lb2ItQG+udbT3WDWNXl8BPLD4aLKM3qAtkmaBYOHEkda5G+5NHLTr5e1TkcoHkY4FfQl0Bd5vZtte83QipjSa6wLIABXPlWITAMcd5Mngbu0aurohGKK9tFhz0z9w2a+kXQZsDfC53EKepj7qM5A/wP3qEP6za3fafAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsvItA+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8447C4CEEC;
	Mon, 14 Apr 2025 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744655193;
	bh=zxI4p+wjrRQ0jkQ2RkuWxk4aLUvNDztSLjxQS/HnlH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsvItA+HZnP3HMwBQ0qn+x/+lX1FG8CYN4emOP0fuPiFIaW0eg0g2P3VCBAqIkWzd
	 PyZIJd0I99m2kBnv9F5ZVfljpT0YVJ5Gjn2yBkvzwbNKMgbrRuWM306E91jCF/YkrJ
	 dE1ODM/M5U/z9xyjxZYb9/ladb++fU2RT8Zz+oiA78qQGbf24NpbOrIZxvuL9P0YQf
	 cfnKSNQ4ak4I9cEGuFl64IV62zdVUO0OB9zF8lP49BvRVYoP2q0/vk9Rrro4qTmpM2
	 Cvq2b7ko1z2JRarESeNUDv/Oou4PimbWKUJztypjS19v0aHQcvqNUOiPxTsC5z43sh
	 WFKs/m81h9LKA==
Date: Mon, 14 Apr 2025 23:52:45 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.hansen@linux.intel.com, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Kirill Shutemov <kirill.shutemov@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/devmem: Restrict /dev/mem access for
 potentially unaccepted memory by default
Message-ID: <l2crzyeoux2pammbifkivrhp637gza7piumd3s6j66mezsfvdy@nwczgs2hkq4f>
References: <174433453526.924142.15494575917593543330.stgit@dwillia2-xfh.jf.intel.com>
 <174433455868.924142.4040854723344197780.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174433455868.924142.4040854723344197780.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Apr 10, 2025 at 06:22:38PM -0700, Dan Williams wrote:
> Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> address space) via /dev/mem results in an SEPT violation.
> 
> The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
> unencrypted mapping where the kernel had established an encrypted
> mapping previously.
> 
> An initial attempt to fix this revealed that TDX and SEV-SNP have
> different expectations about which and when address ranges can be mapped
> via /dev/mem.
> 
> Rather than develop a precise set of allowed /dev/mem capable TVM
> address ranges, teach devmem_is_allowed() to always restrict access to
> the BIOS data space.

This patch does more than just restrict the BIOS data space - it rejects 
all accesses to /dev/mem _apart_ from the first 1MB. That should be made 
clear here.

> This means return 0s for read(), drop write(), and
> -EPERM mmap(). This can still be later relaxed as specific needs arise,
> but in the meantime, close off this source of mismatched
> IORES_MAP_ENCRYPTED expectations.
> 
> Cc: <x86@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/Kconfig                |    2 ++
>  arch/x86/include/asm/x86_init.h |    2 ++
>  arch/x86/kernel/x86_init.c      |    6 ++++++
>  arch/x86/mm/init.c              |   23 +++++++++++++++++------
>  4 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4b9f378e05f6..12a1b5acd55b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -891,6 +891,7 @@ config INTEL_TDX_GUEST
>  	depends on X86_X2APIC
>  	depends on EFI_STUB
>  	depends on PARAVIRT
> +	depends on STRICT_DEVMEM
>  	select ARCH_HAS_CC_PLATFORM
>  	select X86_MEM_ENCRYPT
>  	select X86_MCE
> @@ -1510,6 +1511,7 @@ config AMD_MEM_ENCRYPT
>  	bool "AMD Secure Memory Encryption (SME) support"
>  	depends on X86_64 && CPU_SUP_AMD
>  	depends on EFI_STUB
> +	depends on STRICT_DEVMEM
>  	select DMA_COHERENT_POOL
>  	select ARCH_USE_MEMREMAP_PROT
>  	select INSTRUCTION_DECODER
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 213cf5379a5a..0ae436b34b88 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -305,6 +305,7 @@ struct x86_hyper_runtime {
>   * 				semantics.
>   * @realmode_reserve:		reserve memory for realmode trampoline
>   * @realmode_init:		initialize realmode trampoline
> + * @devmem_is_allowed		restrict /dev/mem and PCI sysfs resource access
>   * @hyper:			x86 hypervisor specific runtime callbacks
>   */
>  struct x86_platform_ops {
> @@ -323,6 +324,7 @@ struct x86_platform_ops {
>  	void (*set_legacy_features)(void);
>  	void (*realmode_reserve)(void);
>  	void (*realmode_init)(void);
> +	bool (*devmem_is_allowed)(unsigned long pfn);
>  	struct x86_hyper_runtime hyper;
>  	struct x86_guest guest;
>  };
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 0a2bbd674a6d..346301375bd4 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -143,6 +143,11 @@ static void enc_kexec_begin_noop(void) {}
>  static void enc_kexec_finish_noop(void) {}
>  static bool is_private_mmio_noop(u64 addr) {return false; }
>  
> +static bool platform_devmem_is_allowed(unsigned long pfn)
> +{
> +	return !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
> +}
> +
>  struct x86_platform_ops x86_platform __ro_after_init = {
>  	.calibrate_cpu			= native_calibrate_cpu_early,
>  	.calibrate_tsc			= native_calibrate_tsc,
> @@ -156,6 +161,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
>  	.restore_sched_clock_state	= tsc_restore_sched_clock_state,
>  	.realmode_reserve		= reserve_real_mode,
>  	.realmode_init			= init_real_mode,
> +	.devmem_is_allowed		= platform_devmem_is_allowed,
>  	.hyper.pin_vcpu			= x86_op_int_noop,
>  	.hyper.is_private_mmio		= is_private_mmio_noop,
>  
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index bfa444a7dbb0..df5435c8dbea 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -861,18 +861,23 @@ void __init poking_init(void)
>   * area traditionally contains BIOS code and data regions used by X, dosemu,
>   * and similar apps. Since they map the entire memory range, the whole range
>   * must be allowed (for mapping), but any areas that would otherwise be
> - * disallowed are flagged as being "zero filled" instead of rejected.
> + * disallowed are flagged as being "zero filled" instead of rejected, for
> + * read()/write().
> + *
>   * Access has to be given to non-kernel-ram areas as well, these contain the
>   * PCI mmio resources as well as potential bios/acpi data regions.
>   */
>  int devmem_is_allowed(unsigned long pagenr)
>  {
> +	bool platform_allowed = x86_platform.devmem_is_allowed(pagenr);
> +

If we are going to do this, I don't see the point of having an 
x86_platform_op. It may be better to simply gate this on  
cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) directly here.


Thanks,
Naveen

>  	if (region_intersects(PFN_PHYS(pagenr), PAGE_SIZE,
>  				IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
>  			!= REGION_DISJOINT) {
>  		/*
> -		 * For disallowed memory regions in the low 1MB range,
> -		 * request that the page be shown as all zeros.
> +		 * For disallowed memory regions in the low 1MB range, request
> +		 * that the page be shown as all zeros for read()/write(), fail
> +		 * mmap()
>  		 */
>  		if (pagenr < 256)
>  			return 2;
> @@ -885,14 +890,20 @@ int devmem_is_allowed(unsigned long pagenr)
>  	 * restricted resource under CONFIG_STRICT_DEVMEM.
>  	 */
>  	if (iomem_is_exclusive(pagenr << PAGE_SHIFT)) {
> -		/* Low 1MB bypasses iomem restrictions. */
> -		if (pagenr < 256)
> +		/*
> +		 * Low 1MB bypasses iomem restrictions unless the platform says
> +		 * the physical address is not suitable for direct access.
> +		 */
> +		if (pagenr < 256) {
> +			if (!platform_allowed)
> +				return 2;
>  			return 1;
> +		}
>  
>  		return 0;
>  	}
>  
> -	return 1;
> +	return platform_allowed;
>  }
>  
>  void free_init_pages(const char *what, unsigned long begin, unsigned long end)
> 

