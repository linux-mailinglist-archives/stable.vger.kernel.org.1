Return-Path: <stable+bounces-86594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86E9A200C
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE11C21EBA
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182F1D31A8;
	Thu, 17 Oct 2024 10:30:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B861B0F08
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161032; cv=none; b=fDeybJRa/p/uniKO1ES/Ch+8EkHzJ4cojguQsj7Pg3zZ3RTooExif26XRdGcqDQoww0O2eX2MWnvz/mo6ew7+iwfFvqQRcz0nKvpa6C+CFlSZ9ic8xIZx5hULnBlPhQoYSiHg2bdZUs+OvMv8MOaGheKqQC4Q0pe3cMkn1VzBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161032; c=relaxed/simple;
	bh=O1F0Nb7e0VeCZvYWYViC43sVpZP1jYDo/g+ajhGoObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pugW40ywwrDQLUIqFpfBXWU7bsB7iS5bjIwQ8kAVeOx70mVyAypCkmb+8+HwSNfNcE9FWqQ5ayE0sUauD51/PQxrlZ0qIKS9a3A3N0u/MXIEviIdADqP+MHCVFS6LVtQFevEyAUl7lKuogZN7twq8X8gcFAYZJrR5jfxhO06G6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00F7FEC;
	Thu, 17 Oct 2024 03:30:57 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4DD43F71E;
	Thu, 17 Oct 2024 03:30:25 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:30:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
Message-ID: <ZxDnP3rAAHLHgEXc@J2N7QTR9R3>
References: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org>
 <20241016-arm-kasan-vmalloc-crash-v2-1-0a52fd086eef@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-arm-kasan-vmalloc-crash-v2-1-0a52fd086eef@linaro.org>

On Wed, Oct 16, 2024 at 09:15:21PM +0200, Linus Walleij wrote:
> When sync:ing the VMALLOC area to other CPUs, make sure to also
> sync the KASAN shadow memory for the VMALLOC area, so that we
> don't get stale entries for the shadow memory in the top level PGD.
> 
> Since we are now copying PGDs in two instances, create a helper
> function named memcpy_pgd() to do the actual copying, and
> create a helper to map the addresses of VMALLOC_START and
> VMALLOC_END into the corresponding shadow memory.
> 
> Cc: stable@vger.kernel.org
> Fixes: 565cbaad83d8 ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
> Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/
> Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mm/ioremap.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index 794cfea9f9d4..94586015feed 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -23,6 +23,7 @@
>   */
>  #include <linux/module.h>
>  #include <linux/errno.h>
> +#include <linux/kasan.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/io.h>
> @@ -115,16 +116,32 @@ int ioremap_page(unsigned long virt, unsigned long phys,
>  }
>  EXPORT_SYMBOL(ioremap_page);
>  
> +static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
> +{
> +	return (unsigned long)kasan_mem_to_shadow((void *)addr);
> +}
> +
> +static void memcpy_pgd(struct mm_struct *mm, unsigned long start,
> +		       unsigned long end)
> +{
> +	memcpy(pgd_offset(mm, start), pgd_offset_k(start),
> +	       sizeof(pgd_t) * (pgd_index(end) - pgd_index(start)));
> +}
> +
>  void __check_vmalloc_seq(struct mm_struct *mm)
>  {
>  	int seq;
>  
>  	do {
>  		seq = atomic_read(&init_mm.context.vmalloc_seq);
> -		memcpy(pgd_offset(mm, VMALLOC_START),
> -		       pgd_offset_k(VMALLOC_START),
> -		       sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
> -					pgd_index(VMALLOC_START)));
> +		memcpy_pgd(mm, VMALLOC_START, VMALLOC_END);
> +		if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> +			unsigned long start =
> +				arm_kasan_mem_to_shadow(VMALLOC_START);
> +			unsigned long end =
> +				arm_kasan_mem_to_shadow(VMALLOC_END);
> +			memcpy_pgd(mm, start, end);
> +		}

This looks good; FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

As a separate thing, I believe we also need to use atomic_read_acquire()
for the reads of vmalloc_seq to pair with the atomic_*_release() on each
update.

Otherwise, this can be reordered, e.g.

	do {
		memcpy_pgd(...);
		seq = atomic_read(&init_mm.context.vmalloc_seq);
		atomic_set_release(&mm->context.vmalloc_seq, seq);
	} while (seq != atomic_read(&init_mm.context.vmalloc_seq)

... and we might fail to copy the relevant table entries from init_mm,
but still think we're up-to-date and update mm's vmalloc_seq.

Ard, does that sound right to you, or am I missing something?

Mark.

