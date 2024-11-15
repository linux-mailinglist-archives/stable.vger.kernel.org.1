Return-Path: <stable+bounces-93077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4399CD665
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5981F2293D
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287467DA6D;
	Fri, 15 Nov 2024 05:05:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8454264D
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647115; cv=none; b=gTUYQfYuDRSRYxjEembg6f3RSBQDw7+SoE+QdEJurU4c1Lgx6BVIfFekhGUo0xalw1i4x6SW4K0n1WQXKkFdbSEa5MGIT/ew5vEGiMHEFdR5KOfG4xDY9Ecmhkl6TnTRBMRueMn0iHDMOmDS+vC1TNk9vTtIOh5PeyzXH6b3zmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647115; c=relaxed/simple;
	bh=4pNOTFBR83zADwgFsg/3A4sQnjOghxD0UgllA9vP5ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi0uJtsPuOPr3GUsX6lBdsjaxZ5xSv7GcgI4wG04z/GykWZmgEM+rPC5a1lbT7NukG3QV09wN8TUh8vbk8d2bP/i4vCxBey72ChB03vqf7qoGe9uPM6NiU3U7uFYWvGpuJh2JwU4wG5C1l4JhPsLuuuPjpGCyRbUuE85b9NfEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5893015BF;
	Thu, 14 Nov 2024 21:05:40 -0800 (PST)
Received: from [10.163.45.151] (unknown [10.163.45.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11F8E3F66E;
	Thu, 14 Nov 2024 21:05:06 -0800 (PST)
Message-ID: <7d89e43a-1a8d-4bac-804b-eac1ed9d8d90@arm.com>
Date: Fri, 15 Nov 2024 10:35:03 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64/mm: Reduce PA space to 48 bits when LPA2 is not
 enabled
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Kees Cook <keescook@chromium.org>,
 stable@vger.kernel.org
References: <20241111083544.1845845-8-ardb+git@google.com>
 <20241111083544.1845845-9-ardb+git@google.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241111083544.1845845-9-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/24 14:05, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Currently, LPA2 support implies support for up to 52 bits of physical
> addressing, and this is reflected in global definitions such as
> PHYS_MASK_SHIFT and MAX_PHYSMEM_BITS.
> 
> This is potentially problematic, given that LPA2 support is modeled as a
> CPU feature which can be overridden, and with LPA2 support turned off,
> attempting to map physical regions with address bits [51:48] set (which
> may exist on LPA2 capable systems booting with arm64.nolva) will result
> in corrupted mappings with a truncated output address and bogus
> shareability attributes.
> 
> This means that the accepted physical address range in the mapping
> routines should be at most 48 bits wide when LPA2 is supported but not
> enabled.
> 
> Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 6 ------
>  arch/arm64/include/asm/pgtable-prot.h  | 7 +++++++
>  arch/arm64/include/asm/sparsemem.h     | 4 +++-
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index fd330c1db289..a970def932aa 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -218,12 +218,6 @@
>   */
>  #define S1_TABLE_AP		(_AT(pmdval_t, 3) << 61)
>  
> -/*
> - * Highest possible physical address supported.
> - */
> -#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
> -#define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
> -
>  #define TTBR_CNP_BIT		(UL(1) << 0)
>  
>  /*
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 9f9cf13bbd95..a95f1f77bb39 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -81,6 +81,7 @@ extern unsigned long prot_ns_shared;
>  #define lpa2_is_enabled()	false
>  #define PTE_MAYBE_SHARED	PTE_SHARED
>  #define PMD_MAYBE_SHARED	PMD_SECT_S
> +#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
>  #else
>  static inline bool __pure lpa2_is_enabled(void)
>  {
> @@ -89,8 +90,14 @@ static inline bool __pure lpa2_is_enabled(void)
>  
>  #define PTE_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PTE_SHARED)
>  #define PMD_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PMD_SECT_S)
> +#define PHYS_MASK_SHIFT		(lpa2_is_enabled() ? CONFIG_ARM64_PA_BITS : 48)
>  #endif
>  
> +/*
> + * Highest possible physical address supported.
> + */
> +#define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
> +
>  /*
>   * If we have userspace only BTI we don't want to mark kernel pages
>   * guarded even if the system does support BTI.
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 8a8acc220371..035e0ca74e88 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -5,7 +5,9 @@
>  #ifndef __ASM_SPARSEMEM_H
>  #define __ASM_SPARSEMEM_H
>  
> -#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> +#include <asm/pgtable-prot.h>
> +
> +#define MAX_PHYSMEM_BITS	PHYS_MASK_SHIFT
>  
>  /*
>   * Section size must be at least 512MB for 64K base

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

