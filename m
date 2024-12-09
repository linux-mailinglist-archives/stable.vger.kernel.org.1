Return-Path: <stable+bounces-100168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E89E96B4
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867A416AE39
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA451A239D;
	Mon,  9 Dec 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0MC7bdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF251A239A
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750302; cv=none; b=iYRhCpfPFw2hYA/j/fZnkZ7z1YffZyMMGzEvnCJVvxhfkM3T1EUFeV9VAdOslnGqeAaHe6JCEoxnX8/c7s7KruN5Wy0kS1WVDFqy4YHSUYvPZXWoifaDMh3Sl50V4XsJtGoWbITRrPTn7OygiHPM2y0uJuoKD6/kr8IqYYIptck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750302; c=relaxed/simple;
	bh=IKpdyTxaL6MHQtXFHVt4rKA2u0Wimp9puiY3v89GaLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=I8gbmf0G07t+gWgD02/eDKFaZZUDEIfcyeA9bpSpEazTITKVpyQIZqMXgClmKUfh6qWQSHFWgHl1R8lTdrB4T+h0YtP+kch1sZZ+5+IjfmxZlyjoxOTUSER/907Cl2f/AMLO5qdguCh0lVRyo8QjgOKuT9nygUV9v84P794DPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0MC7bdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DA0C4AF0B
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 13:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733750302;
	bh=IKpdyTxaL6MHQtXFHVt4rKA2u0Wimp9puiY3v89GaLE=;
	h=References:In-Reply-To:From:Date:Subject:Cc:From;
	b=b0MC7bdicccUdWj4HvtRFAm3v5BODcJAsqXp0HjMaRSaCz+m+lqx0XGgwCLyMmZYx
	 3PCIMg6FrdiyHC8agM3Hy62Z3813iP5O1Cd2d5F7BAgjIHyP17HBrPRNAN5xHM7QKp
	 hk+1lIbY6V3fPwotjtUj45r8aZBZ0p47kl1M/AARpk+qrHyon4SmFoPLKx9yXNmh3Z
	 8yuDqp/zV3o/2BHH1DrD92IbgObnTWjxzq+EW67ZTJDbCWSgcLC9wIGXXF2RpH5VXF
	 sUeBETRieXkd0JMj121y64BUa7/Zzap4Yc62kzzeMroJ1gEden+8AdYsq7aBEKokFG
	 pjP3TPVrdKuZA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so14231381fa.3
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 05:18:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW46uBYMB14JRAk+RpDP3rldgiywjFysQH2AnjTB7bG5+Wl3HccI6chZmMlH2yz+e/Gr24ktOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl5oW13JjWjjurU7Tg9Wal52mvbnExmhFyv5FvmE+i6MAX166r
	ZMdZMtoMEIZInCsbl1VQvxgDqLmb5eH1MNuTWkQC5Y+Aa3zG/ewQiw1uukLqEL29RdNWzDZuXG8
	SRXV/oN7L4ukU1Sd93qU3ucCRZ28=
X-Received: by 2002:a05:651c:19a9:b0:300:33b1:f0e2 with SMTP id
 38308e7fff4ca-3022fb3859emt1236351fa.3.1733750300533; Mon, 09 Dec 2024
 05:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205150229.3510177-8-ardb+git@google.com> <20241205150229.3510177-9-ardb+git@google.com>
In-Reply-To: <20241205150229.3510177-9-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 9 Dec 2024 14:18:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFUVS_TdQb_Q_ta1BfSMUnAtB7zJpxDDtkFX6Q3tiUtcA@mail.gmail.com>
Message-ID: <CAMj1kXFUVS_TdQb_Q_ta1BfSMUnAtB7zJpxDDtkFX6Q3tiUtcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64/mm: Reduce PA space to 48 bits when LPA2 is
 not enabled
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 16:03, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Currently, LPA2 kernel support implies support for up to 52 bits of
> physical addressing, and this is reflected in global definitions such as
> PHYS_MASK_SHIFT and MAX_PHYSMEM_BITS.
>
> This is potentially problematic, given that LPA2 hardware support is
> modeled as a CPU feature which can be overridden, and with LPA2 hardware
> support turned off, attempting to map physical regions with address bits
> [51:48] set (which may exist on LPA2 capable systems booting with
> arm64.nolva) will result in corrupted mappings with a truncated output
> address and bogus shareability attributes.
>
> This means that the accepted physical address range in the mapping
> routines should be at most 48 bits wide when LPA2 support is configured
> but not enabled at runtime.
>
> Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 6 ------
>  arch/arm64/include/asm/pgtable-prot.h  | 7 +++++++
>  arch/arm64/include/asm/sparsemem.h     | 4 +++-
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index c78a988cca93..a9136cc551cc 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -222,12 +222,6 @@
>   */
>  #define S1_TABLE_AP            (_AT(pmdval_t, 3) << 61)
>
> -/*
> - * Highest possible physical address supported.
> - */
> -#define PHYS_MASK_SHIFT                (CONFIG_ARM64_PA_BITS)
> -#define PHYS_MASK              ((UL(1) << PHYS_MASK_SHIFT) - 1)
> -
>  #define TTBR_CNP_BIT           (UL(1) << 0)
>
>  /*
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 9f9cf13bbd95..a95f1f77bb39 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -81,6 +81,7 @@ extern unsigned long prot_ns_shared;
>  #define lpa2_is_enabled()      false
>  #define PTE_MAYBE_SHARED       PTE_SHARED
>  #define PMD_MAYBE_SHARED       PMD_SECT_S
> +#define PHYS_MASK_SHIFT                (CONFIG_ARM64_PA_BITS)
>  #else
>  static inline bool __pure lpa2_is_enabled(void)
>  {
> @@ -89,8 +90,14 @@ static inline bool __pure lpa2_is_enabled(void)
>
>  #define PTE_MAYBE_SHARED       (lpa2_is_enabled() ? 0 : PTE_SHARED)
>  #define PMD_MAYBE_SHARED       (lpa2_is_enabled() ? 0 : PMD_SECT_S)
> +#define PHYS_MASK_SHIFT                (lpa2_is_enabled() ? CONFIG_ARM64_PA_BITS : 48)
>  #endif
>
> +/*
> + * Highest possible physical address supported.
> + */
> +#define PHYS_MASK              ((UL(1) << PHYS_MASK_SHIFT) - 1)
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
> -#define MAX_PHYSMEM_BITS       CONFIG_ARM64_PA_BITS
> +#include <asm/pgtable-prot.h>
> +
> +#define MAX_PHYSMEM_BITS       PHYS_MASK_SHIFT
>

This needs

--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -7,7 +7,8 @@

 #include <asm/pgtable-prot.h>

-#define MAX_PHYSMEM_BITS       PHYS_MASK_SHIFT
+#define MAX_PHYSMEM_BITS               PHYS_MASK_SHIFT
+#define MAX_POSSIBLE_PHYSMEM_BITS      (52)

 /*
  * Section size must be at least 512MB for 64K base

applied on top to make the ZSMALLOC code happy.

