Return-Path: <stable+bounces-126694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D8A714CA
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 11:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA31D16A18D
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD521B393A;
	Wed, 26 Mar 2025 10:26:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B9191461;
	Wed, 26 Mar 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984817; cv=none; b=fPE8kOoyLrJrLrW61hj9hvrH5jG6k/YUbzB5LOJOVUPkFxVAMHKuUVtWJJ2w5KUiPkufMfKxlE4lnSpJzRCp+k0WXSDksAmt1CyA/CfGXvz6dLBg7WzrzD6gjswaqvYVR/MCiDP7nmpGHb5caY71MohhxGgrXgwP6S4u4LXCnMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984817; c=relaxed/simple;
	bh=VEhmgpq1s0Ug82Q8m70cpZGMZbID/iw6lPxuMv95EIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1UCtIgYd2RFavi0oHcYWeAjUXeMFGEsJhh7C/ODvc6iNeP0LOWS8Kv4E+Ai8XbWMe8ELLdrB5mwTd66BbZWem6vbqa9SnGn/Q9yv+Ve1LrURnWtKOKH3cG8cU6gamiQ5dx9QzyvLKiUNVKJ67t1Rmo+QCRX+y9Il/qD8pPyDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDE88106F;
	Wed, 26 Mar 2025 03:26:59 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EBC63F58B;
	Wed, 26 Mar 2025 03:26:52 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:26:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Keir Fraser <keirf@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: mops: Do not dereference src reg for a set
 operation
Message-ID: <Z-PWZ98oNna6nVu1@J2N7QTR9R3>
References: <20250326070255.2567981-1-keirf@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326070255.2567981-1-keirf@google.com>

On Wed, Mar 26, 2025 at 07:02:55AM +0000, Keir Fraser wrote:
> The register is not defined and reading it can result in a UBSAN
> out-of-bounds array access error, specifically when the srcreg field
> value is 31.

I'm assuming this is for a MOPS exception taken from a SET* sequence
with XZR as the source?

It'd be nice to say that explicitly, as this is the only case where any
of the src/dst/size fields in the ESR can be reported as 31. In all
other cases where a CPY* or SET* instruction takes register 31 as an
argument, the behaviour is CONSTRAINED UNPREDICTABLE and cannot generate
a MOPS exception.

Note that in ARM DDI 0487 L.a there's a bug where:

* The prose says that SET* taking XZR as a src is CONSTRAINED
  UNPREDICTABLE, per K1.2.17.1.1 linked from C6.2.332.

  The title for the K1.2.17.1.1 is "Memory Copy and Memory Set CPY*",
  which looks like an editing error.

* The pseudocode is explicit that the CONSTRAINED UNPREDICTABLE
  behaviours differ for CPY* and SET* per J1.1.3.121
  CheckCPYConstrainedUnpredictable() and J1.1.3.125
  CheckSETConstrainedUnpredictable().

... and I'll go file a ticket about that soon if someone doesn't beat me
to it.

> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Looks like this should have:

Fixes: 2de451a329cf662b ("KVM: arm64: Add handler for MOPS exceptions")

Prior to that, the code in do_el0_mops() was benign as the use of
pt_regs_read_reg() prevented the out-of-bounds access. It'd also be nice
to note that in the commit message.

Mark.

> Signed-off-by: Keir Fraser <keirf@google.com>
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

