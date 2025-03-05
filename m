Return-Path: <stable+bounces-121090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15CA50A34
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B01917251C
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B195D2512EF;
	Wed,  5 Mar 2025 18:48:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7951A5BB7;
	Wed,  5 Mar 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200506; cv=none; b=XYsXAUb0PltZEk57k+dEWoziFULGuBO3s+YlONvdKoBFz9xTYucR6XEJeB5lBTwhLwnPsp4Ex/pXqIA835aiwZx4r6bE/uHKrxDBAqA6T4OL1ysJi6Le4BAZlRKk8QzlvZM9qCjziNjJQsFCewm15L1/WtO1YULFAzWRatoAoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200506; c=relaxed/simple;
	bh=4Jo28D0D/+VynJE9hqj9lJ05PZTxswCglwzTgDRosFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/vS/XuoqZyZc69IST4s8v7sAraVSrPuM11KTpuXVvUmS+GEhe6hW+SMFj2RMQp/KS/WDPct5VadWHK3jGENBivNAorpTvhE0MTsfDrUutwpvqlLp2sMFdKyYdHpEWRs6WGtXshu5hjaEghcPSgRrBBOThXbaxEc5BtJe23xLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70DCC4CED1;
	Wed,  5 Mar 2025 18:48:22 +0000 (UTC)
Date: Wed, 5 Mar 2025 18:48:19 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] [arm64/tlb] Fix mmu notifiers for range-based invalidates
Message-ID: <Z8iccxCo7tkqvE_p@arm.com>
References: <20250304085127.2238030-1-pjaroszynski@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304085127.2238030-1-pjaroszynski@nvidia.com>

On Tue, Mar 04, 2025 at 12:51:27AM -0800, Piotr Jaroszynski wrote:
> Update the __flush_tlb_range_op macro not to modify its parameters as
> these are unexepcted semantics. In practice, this fixes the call to
> mmu_notifier_arch_invalidate_secondary_tlbs() in
> __flush_tlb_range_nosync() to use the correct range instead of an empty
> range with start=end. The empty range was (un)lucky as it results in
> taking the invalidate-all path that doesn't cause correctness issues,
> but can certainly result in suboptimal perf.
> 
> This has been broken since commit 6bbd42e2df8f ("mmu_notifiers: call
> invalidate_range() when invalidating TLBs") when the call to the
> notifiers was added to __flush_tlb_range(). It predates the addition of
> the __flush_tlb_range_op() macro from commit 360839027a6e ("arm64: tlb:
> Refactor the core flush algorithm of __flush_tlb_range") that made the
> bug hard to spot.

That's the problem with macros.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Will, do you want to take this as a fix? It's only a performance
regression, though you never know how it breaks the callers of the macro
at some point.

> Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")
> 
> Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Raghavendra Rao Ananta <rananta@google.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/tlbflush.h | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index bc94e036a26b..8104aee4f9a0 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -396,33 +396,35 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  #define __flush_tlb_range_op(op, start, pages, stride,			\
>  				asid, tlb_level, tlbi_user, lpa2)	\
>  do {									\
> +	typeof(start) __flush_start = start;				\
> +	typeof(pages) __flush_pages = pages;				\
>  	int num = 0;							\
>  	int scale = 3;							\
>  	int shift = lpa2 ? 16 : PAGE_SHIFT;				\
>  	unsigned long addr;						\
>  									\
> -	while (pages > 0) {						\
> +	while (__flush_pages > 0) {					\
>  		if (!system_supports_tlb_range() ||			\
> -		    pages == 1 ||					\
> -		    (lpa2 && start != ALIGN(start, SZ_64K))) {		\
> -			addr = __TLBI_VADDR(start, asid);		\
> +		    __flush_pages == 1 ||				\
> +		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
> +			addr = __TLBI_VADDR(__flush_start, asid);	\
>  			__tlbi_level(op, addr, tlb_level);		\
>  			if (tlbi_user)					\
>  				__tlbi_user_level(op, addr, tlb_level);	\
> -			start += stride;				\
> -			pages -= stride >> PAGE_SHIFT;			\
> +			__flush_start += stride;			\
> +			__flush_pages -= stride >> PAGE_SHIFT;		\
>  			continue;					\
>  		}							\
>  									\
> -		num = __TLBI_RANGE_NUM(pages, scale);			\
> +		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
>  		if (num >= 0) {						\
> -			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
> +			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
>  						scale, num, tlb_level);	\
>  			__tlbi(r##op, addr);				\
>  			if (tlbi_user)					\
>  				__tlbi_user(r##op, addr);		\
> -			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
> -			pages -= __TLBI_RANGE_PAGES(num, scale);	\
> +			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
> +			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
>  		}							\
>  		scale--;						\
>  	}								\
> 
> base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
> -- 
> 2.22.1.7.gac84d6e93c.dirty

-- 
Catalin

