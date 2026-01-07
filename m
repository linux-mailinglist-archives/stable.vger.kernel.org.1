Return-Path: <stable+bounces-206184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E580CFF54C
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3422E36D2429
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722538A9CB;
	Wed,  7 Jan 2026 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrdJXSNs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38038A295;
	Wed,  7 Jan 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802977; cv=none; b=Kx7XfhgAN+SKb10dDNYeFkNMtmmV5bty5trakbfaI6zlV1Ek/d1saxOyLiVP3r6RlDqh8ovaKSTO0NUeNquiekMyI+6/p2ywIzM/hdqZMuo1G9Mi2dLqv5Vm64HZOMXHiz/M+btsIrfmxUUs55rh+iPfNrlKecadlBL8jZyQExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802977; c=relaxed/simple;
	bh=h/t0IMw2r1KOgVik7fGfiSYqStx+dX2QtV1GaNuybx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vwzr1RG0fHVat3PjAzaT0UXuF57rj+rawOZG2cd0O3djCDuJKcsZRshJL5Idjk+PBlRMJYPlcl8KZToa5Xs9Qq3I2cO6gblOb/t56zeCImNykkBHE8fNfuog3/VqUaALKqpQEYvvN0IYPb4JnJS1qm2PkHr4CQk5fjzrouD2Yn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrdJXSNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E877C4CEF1;
	Wed,  7 Jan 2026 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802973;
	bh=h/t0IMw2r1KOgVik7fGfiSYqStx+dX2QtV1GaNuybx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrdJXSNsL5LUoWximIzD8J5mik0J7vkN/69IxB3kLi2JQbNzM0M/E7WmzHN2322L0
	 pRMDF/eqoJIoeKMjxqqvTQXeaES6SGTonc+KJew1QcPNnAJtJ9HwMqY63Zq0NyMPsj
	 lAQ7abZtSP2JXi7HwtrYj+GYAQlygFZBwgrqt3LJA748pA6bo/GE34QvQi/SuX/C0S
	 RmFsOY/7yJSDH0+jwQK0oLHzmTs98488opQZfVTIoqEMQuOL/F+VqB1PVu37lGaruJ
	 a+71pHzEWLylilQ3GIp4Q8SXkPANYZLge8Te+X9Wv/0qou7ZXCMQop2V6kj0DepxGe
	 Nb3HTggQ9cFcQ==
Date: Wed, 7 Jan 2026 16:22:48 +0000
From: Will Deacon <will@kernel.org>
To: Lucas Wei <lucaswei@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, sjadavani@google.com,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com
Subject: Re: [PATCH v2] arm64: errata: Workaround for SI L1 downstream
 coherency issue
Message-ID: <aV6IWBtqp1dnOZuX@willie-the-truck>
References: <20251229033621.996546-1-lucaswei@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229033621.996546-1-lucaswei@google.com>

[+Robin as he's been involved with this]

On Mon, Dec 29, 2025 at 03:36:19AM +0000, Lucas Wei wrote:
> When software issues a Cache Maintenance Operation (CMO) targeting a
> dirty cache line, the CPU and DSU cluster may optimize the operation by
> combining the CopyBack Write and CMO into a single combined CopyBack
> Write plus CMO transaction presented to the interconnect (MCN).
> For these combined transactions, the MCN splits the operation into two
> separate transactions, one Write and one CMO, and then propagates the
> write and optionally the CMO to the downstream memory system or external
> Point of Serialization (PoS).
> However, the MCN may return an early CompCMO response to the DSU cluster
> before the corresponding Write and CMO transactions have completed at
> the external PoS or downstream memory. As a result, stale data may be
> observed by external observers that are directly connected to the
> external PoS or downstream memory.
> 
> This erratum affects any system topology in which the following
> conditions apply:
>  - The Point of Serialization (PoS) is located downstream of the
>    interconnect.
>  - A downstream observer accesses memory directly, bypassing the
>    interconnect.
> 
> Conditions:
> This erratum occurs only when all of the following conditions are met:
>  1. Software executes a data cache maintenance operation, specifically,
>     a clean or invalidate by virtual address (DC CVAC, DC CIVAC, or DC
>     IVAC), that hits on unique dirty data in the CPU or DSU cache. This
>     results in a combined CopyBack and CMO being issued to the
>     interconnect.

Why do we need to worry about IVAC here? Even though that might be
upgraded to CIVAC and result in the erratum conditions, the DMA API
shouldn't use IVAC on dirty lines so I don't think we need to worry
about it.

> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index f0ca7196f6fa..d3d46e5f7188 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -381,6 +381,9 @@ alternative_endif
>  	.macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
>  	sub	\tmp, \linesz, #1
>  	bic	\start, \start, \tmp
> +alternative_if ARM64_WORKAROUND_4311569
> +	mov	\tmp, \start
> +alternative_else_nop_endif
>  .Ldcache_op\@:
>  	.ifc	\op, cvau
>  	__dcache_op_workaround_clean_cache \op, \start
> @@ -402,6 +405,13 @@ alternative_endif
>  	add	\start, \start, \linesz
>  	cmp	\start, \end
>  	b.lo	.Ldcache_op\@
> +alternative_if ARM64_WORKAROUND_4311569
> +	.ifnc	\op, cvau
> +	mov	\start, \tmp
> +	mov	\tmp, xzr
> +	cbnz	\start, .Ldcache_op\@
> +	.endif
> +alternative_else_nop_endif

So you could also avoid this for ivac, although it looks like this is
only called for civac, cvau, cvac and cvap so perhaps not worth it.

> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index 503567c864fd..ddf0097624ed 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -143,9 +143,14 @@ SYM_FUNC_END(dcache_clean_pou)
>   *	- end     - kernel end address of region
>   */
>  SYM_FUNC_START(__pi_dcache_inval_poc)
> +alternative_if ARM64_WORKAROUND_4311569
> +	mov	x4, x0
> +	mov	x5, x1
> +	mov	x6, #1
> +alternative_else_nop_endif
>  	dcache_line_size x2, x3
>  	sub	x3, x2, #1
> -	tst	x1, x3				// end cache line aligned?
> +again:	tst	x1, x3				// end cache line aligned?
>  	bic	x1, x1, x3
>  	b.eq	1f
>  	dc	civac, x1			// clean & invalidate D / U line
> @@ -158,6 +163,12 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
>  3:	add	x0, x0, x2
>  	cmp	x0, x1
>  	b.lo	2b
> +alternative_if ARM64_WORKAROUND_4311569
> +	mov	x0, x4
> +	mov	x1, x5
> +	sub	x6, x6, #1
> +	cbz	x6, again
> +alternative_else_nop_endif
>  	dsb	sy
>  	ret
>  SYM_FUNC_END(__pi_dcache_inval_poc)

But this whole part could be dropped? The CIVACs are just for the
unaligned parts at the ends of the buffer and we shouldn't need to worry
about propagating them -- we just don't want to chuck them away with an
invalidation!

Will

