Return-Path: <stable+bounces-150770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F1ACCF6A
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 23:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D3F16FFFC
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F624BBE4;
	Tue,  3 Jun 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYClOzA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1823BCE4;
	Tue,  3 Jun 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987674; cv=none; b=KOF/jZi2qkRTwI7sKn59TnpR9fib86xH7ivjBkFTWYGFI/mzYdKgltmLy0fiB6zwKx01T7QMyJMLZaD2rG5W1dyNutOp/P9NwzsvdjhKUC0YtH1ei+uFOUgzJOueTsHqe4ddhyBH+0NMAz1BLKgMYIT3Z2XSIYAd0NFf6O888Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987674; c=relaxed/simple;
	bh=zZE3sqGdwymSsm8+G9zuai/4BA8hi6aRGnzezn7VdJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAznPn4jGw3PqLzfksQAfLE9ZdYGzXqa4dzYEc6OuLgItxZT3hUcUVmnSAilQUJ7GPY4nNfwIelLcktrxlrIPHxfJiEG+QeVuHu1cYyVjwU6ZbniE4Pg8h2SO+enVeGHdqKv/eJErK8wPLrqHdTgp0lirWeWxlk9MA+sHWdEB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYClOzA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02954C4CEED;
	Tue,  3 Jun 2025 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748987673;
	bh=zZE3sqGdwymSsm8+G9zuai/4BA8hi6aRGnzezn7VdJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYClOzA/a9OT+R6dBzOMSbI5dMErWu7R/kDsvMsAQYMoNrBrvaXnUHokvssDKwCRd
	 nDA7KtQmADZUVCuu06x0sa/NtSgtwO8t97nhzCI5ly21Tpcnofs0eynZcSbnXYURA3
	 X9gNoXcU7q9AmP8DY6ybe92149TdmM4e6TsEF9cQnHXCfmvbqOoESC6Du/Swh7iKnH
	 tx3tPBjSmPXOmvv3FGOmY2SfLQSliUmzRmYHLzDlXXEYNlUGeM+Xg2Wh/t/2/TB+s4
	 PN8by/Z6/Y3h6siNP2SpPNFG8GbLMxAtNqR2mnwWnTjrFF0OKIRUOcXDrvuvM5B0zl
	 K66u0FRPFlRcw==
Date: Tue, 3 Jun 2025 14:54:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: vDSO: correctly use asm parameters in syscall
 wrappers
Message-ID: <20250603215427.GB3631276@ax162>
References: <20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>

On Tue, Jun 03, 2025 at 01:48:54PM +0200, Thomas Weiﬂschuh wrote:
> The syscall wrappers use the "a0" register for two different register
> variables, both the first argument and the return value. The "ret"
> variable is used as both input and output while the argument register is
> only used as input. Clang treats the conflicting input parameters as
> undefined behaviour and optimizes away the argument assignment.
> 
> The code seems to work by chance for the most part today but that may
> change in the future. Specifically clock_gettime_fallback() fails with
> clockids from 16 to 23, as implemented by the upcoming auxiliary clocks.
> 
> Switch the "ret" register variable to a pure output, similar to the other
> architectures' vDSO code. This works in both clang and GCC.
> 
> Link: https://lore.kernel.org/lkml/20250602102825-42aa84f0-23f1-4d10-89fc-e8bbaffd291a@linutronix.de/
> Link: https://lore.kernel.org/lkml/20250519082042.742926976@linutronix.de/
> Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> Fixes: 18efd0b10e0f ("LoongArch: vDSO: Wire up getrandom() vDSO implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

This is definitely an odd interaction because of the register variables
using the same value.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/loongarch/include/asm/vdso/getrandom.h    | 2 +-
>  arch/loongarch/include/asm/vdso/gettimeofday.h | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/include/asm/vdso/getrandom.h
> index 48c43f55b039b42168698614d0479b7a872d20f3..a81724b69f291ee49dd1f46b12d6893fc18442b8 100644
> --- a/arch/loongarch/include/asm/vdso/getrandom.h
> +++ b/arch/loongarch/include/asm/vdso/getrandom.h
> @@ -20,7 +20,7 @@ static __always_inline ssize_t getrandom_syscall(void *_buffer, size_t _len, uns
>  
>  	asm volatile(
>  	"      syscall 0\n"
> -	: "+r" (ret)
> +	: "=r" (ret)
>  	: "r" (nr), "r" (buffer), "r" (len), "r" (flags)
>  	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8",
>  	  "memory");
> diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
> index 88cfcf13311630ed5f1a734d23a2bc3f65d79a88..f15503e3336ca1bdc9675ec6e17bbb77abc35ef4 100644
> --- a/arch/loongarch/include/asm/vdso/gettimeofday.h
> +++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
> @@ -25,7 +25,7 @@ static __always_inline long gettimeofday_fallback(
>  
>  	asm volatile(
>  	"       syscall 0\n"
> -	: "+r" (ret)
> +	: "=r" (ret)
>  	: "r" (nr), "r" (tv), "r" (tz)
>  	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
>  	  "$t8", "memory");
> @@ -44,7 +44,7 @@ static __always_inline long clock_gettime_fallback(
>  
>  	asm volatile(
>  	"       syscall 0\n"
> -	: "+r" (ret)
> +	: "=r" (ret)
>  	: "r" (nr), "r" (clkid), "r" (ts)
>  	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
>  	  "$t8", "memory");
> @@ -63,7 +63,7 @@ static __always_inline int clock_getres_fallback(
>  
>  	asm volatile(
>  	"       syscall 0\n"
> -	: "+r" (ret)
> +	: "=r" (ret)
>  	: "r" (nr), "r" (clkid), "r" (ts)
>  	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
>  	  "$t8", "memory");
> 
> ---
> base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
> change-id: 20250603-loongarch-vdso-syscall-f585a99bea03
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 

