Return-Path: <stable+bounces-86486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C59A086A
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC752862C3
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D7920607F;
	Wed, 16 Oct 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYnWyXnD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFF1D63E1
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078382; cv=none; b=Ric/MESbTiDdjpdTLo60x0lu3JWkxIpjSg6mnCDe8Kie8l45XIob7uBnKDq6yRibQEr8OV2ZpcOgrO85+ZGpsyJfDtKoI9VRkvAo118+Cvb/sEySqEDcr4+hT6CHvr68lVo3pv6nZ0lZXcDYpePX25I6hEkwOeg4qMOKX6VWAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078382; c=relaxed/simple;
	bh=AgAb2/0Ar0SNrTRqLsq8IGW9WXAFzXTWj6vD2c0csaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0MJTu/aAnilNoImlWk3SIMuqhlPKB0YSNBP+5z0ogAsVD4VmsYSku9cRnwq9BiTqpTDzuCr2BENaZdps5EBN9TaUNq3dO76I6SSNAvuPwOzno2ai+MHFVyfqE6KtYIlJ7VZg4f1LxHB61SEcGl4PMAanekPp9+xqbPXItgEAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYnWyXnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E25C4CED4
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729078381;
	bh=AgAb2/0Ar0SNrTRqLsq8IGW9WXAFzXTWj6vD2c0csaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uYnWyXnDKbzlY5CliMnpskooLOd8vvnA3ggEPgdkRfgerLYOY/7WULiAAITDpIwUE
	 9vk74pr0eXb0bS2+RpVU+EiXMgLsLHE6+4hyoxYhtBdoShgxgvGbUucD+Qe5+C9fN5
	 ea7xMx6U6i8zk4C5I8S8BQJrfwngTcdnnlD6kOQ2T+0M0nxvMYz/4Xl1wQ3EszRIcD
	 AA+J4KhQxOm3b3ImGVdUVMClp4rDbFFjDQoUSyggHpvvYHy7vhsIHq7GR0Y324SZZ+
	 BWVp9lRti4zBud6MD5oFsHAXg0GnHQ6jNqnjSbByLXrFJXWb0LyooSsvrs36cchkVL
	 pavyHnJ6zN1jg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so7537031fa.1
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 04:33:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWg4HeG9w7CDD8QW6LIKw6NJIu4k8xBgwIF9WnMCKLAf8YRuwXtqekzvYUvXPpKZFND1YagQnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rK8aDBtgORzZ76BvGbWQwXHEVC4++g2Qn/KuZVk1QcSMhR7a
	9cpPaHWfpNSdS8OuR6KSa3+57LuIggQh/qJ2vSu926nqRgIiwactN/fPWVKsRexR7pBgRooys6K
	dBLpPhyyC6q4DBb5vWi6myNuxzF4=
X-Google-Smtp-Source: AGHT+IHrgsSoxLlIJcPoKJq8iBlYE3eb86eDcfSfZ6Vt9oZtqS4DVKxBoJPTTgmTOC+VgTV+sz8N7qsFIS19fkP9Tr0=
X-Received: by 2002:a05:651c:2209:b0:2fb:55b0:82b8 with SMTP id
 38308e7fff4ca-2fb61b34167mr12008591fa.4.1729078379930; Wed, 16 Oct 2024
 04:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org> <20241015-arm-kasan-vmalloc-crash-v1-1-dbb23592ca83@linaro.org>
In-Reply-To: <20241015-arm-kasan-vmalloc-crash-v1-1-dbb23592ca83@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 16 Oct 2024 13:32:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHuJ9JjbxcG0LkRpQiPzW-BDfX+LoW3+W_cfsD=1hdPDg@mail.gmail.com>
Message-ID: <CAMj1kXHuJ9JjbxcG0LkRpQiPzW-BDfX+LoW3+W_cfsD=1hdPDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: ioremap: Flush PGDs for VMALLOC shadow
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 23:37, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> When sync:ing the VMALLOC area to other CPUs, make sure to also
> sync the KASAN shadow memory for the VMALLOC area, so that we
> don't get stale entries for the shadow memory in the top level PGD.
>
> Cc: stable@vger.kernel.org
> Fixes: 565cbaad83d8 ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
> Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/
> Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mm/ioremap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index 794cfea9f9d4..449f1f04814c 100644
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
> @@ -125,6 +126,12 @@ void __check_vmalloc_seq(struct mm_struct *mm)
>                        pgd_offset_k(VMALLOC_START),
>                        sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
>                                         pgd_index(VMALLOC_START)));
> +               if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> +                       memcpy(pgd_offset(mm, (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START)),
> +                              pgd_offset_k((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START)),
> +                              sizeof(pgd_t) * (pgd_index((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_END)) -
> +                                               pgd_index((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START))));
> +               }

+1 to Russell's suggestion to change this wall of text into something legible.

Then, there is another part to this: in arch/arm/kernel/traps.c, we
have the following code

void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
{
    if (start < VMALLOC_END && end > VMALLOC_START)
        atomic_inc_return_release(&init_mm.context.vmalloc_seq);
}

where we only bump vmalloc_seq if the updated region overlaps with the
vmalloc region, so this will need a similar treatment afaict.

