Return-Path: <stable+bounces-126698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CFA71545
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 12:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC63E16BDED
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCF1C8638;
	Wed, 26 Mar 2025 11:05:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E0F19CCF5;
	Wed, 26 Mar 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987108; cv=none; b=Z3xKzetE7kbKZJQGThQklGFkri6fW9sqGZfNHtMzI9ghwx7Z0YHFEAMRM3zso0v8fDzRgLtHGTLWezU3zb2eKQc8ISGoBzXsRTvlcAJ8SdU7rGJyB9SL5btQgHgXnq0cNxvwzRJeTP2aAW/wzO70RRYQmoofHsshx5d2SCUlLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987108; c=relaxed/simple;
	bh=Q60MixkAwvDuXI55g+9gruousR6Y8HcEeGI/LVfDzkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdllNhI/Gn5fqEFX+16b7aWZIsEob34ieeys/moq2Vzd0N8DH7uW0nIpRvxHVa5L/OCjYju8pA7HE/d6oH3/OwJDoR8TGX87+fQaYbQQ6USB+EuJfDi6YXjYw+TSWWututhoVXyPgY59rJZR79dC58xcP9EuO/qM5b5QmJscl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31C7F1596;
	Wed, 26 Mar 2025 04:05:11 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 139003F63F;
	Wed, 26 Mar 2025 04:05:03 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:05:00 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Keir Fraser <keirf@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, stable@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64: mops: Do not dereference src reg for a set
 operation
Message-ID: <Z-PfXFHBcXhDe03b@J2N7QTR9R3>
References: <20250326110059.3773318-1-keirf@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326110059.3773318-1-keirf@google.com>

On Wed, Mar 26, 2025 at 11:00:58AM +0000, Keir Fraser wrote:
> The source register is not used for SET* and reading it can result in
> a UBSAN out-of-bounds array access error, specifically when the MOPS
> exception is taken from a SET* sequence with XZR (reg 31) as the
> source. Architecturally this is the only case where a src/dst/size
> field in the ESR can be reported as 31.
> 
> Prior to 2de451a329cf662b the code in do_el0_mops() was benign as the
> use of pt_regs_read_reg() prevented the out-of-bounds access.
> 
> Fixes: 2de451a329cf662b ("KVM: arm64: Add handler for MOPS exceptions")
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: stable@vger.kernel.org
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Keir Fraser <keirf@google.com>

Thanks!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/traps.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> index d780d1bd2eac..82cf1f879c61 100644
> --- a/arch/arm64/include/asm/traps.h
> +++ b/arch/arm64/include/asm/traps.h
> @@ -109,10 +109,9 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
>  	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
>  	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
>  	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
> -	unsigned long dst, src, size;
> +	unsigned long dst, size;
>  
>  	dst = regs->regs[dstreg];
> -	src = regs->regs[srcreg];
>  	size = regs->regs[sizereg];
>  
>  	/*
> @@ -129,6 +128,7 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
>  		}
>  	} else {
>  		/* CPY* instruction */
> +		unsigned long src = regs->regs[srcreg];
>  		if (!(option_a ^ wrong_option)) {
>  			/* Format is from Option B */
>  			if (regs->pstate & PSR_N_BIT) {
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

