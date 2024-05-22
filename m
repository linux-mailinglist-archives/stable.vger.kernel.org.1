Return-Path: <stable+bounces-45559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242C8CBC8C
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82391F21691
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804D79949;
	Wed, 22 May 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2+/g0JC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E8182DB;
	Wed, 22 May 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364842; cv=none; b=Rsd4OJXHGwixoPpsKBD5y/dtx4TNwxl9CylgXPQbW+mEQciCB0dAotMucz5AU8CgunpzUNxYUvN0GWM275owSOW2gSimf6/rjv+pvCEUc+NDXgUJH6jWaUBK5caBS41ozR01fLWpjhpNaiK5YyrJyJDu+ATEe7lcPXiIkZKCehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364842; c=relaxed/simple;
	bh=aV7NdtVB/SzBUj/d+kn2bUhxu2Qvmc8Xm3U4xn5YA3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3cIOO/p7ji+gnAh0VWNHY7IwmoX+wpnpJp1xCfPcQ/3AQzn6vRxXJIKeOEjObIylCaK7x4wPPL6PhDt3BvBF3gwY6fVqr/BhiG+/HpC1dhvTEme8avge3a9U+MjvZXUMdulpfOk7kU1mC/P32ntMUtP1uEuaxgXVL5JbiDd8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2+/g0JC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C107C32781;
	Wed, 22 May 2024 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716364842;
	bh=aV7NdtVB/SzBUj/d+kn2bUhxu2Qvmc8Xm3U4xn5YA3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k2+/g0JCirUhfOBiUEonbgEDaaTA+nXUollhqidvEQ+V0rOCM7bqkiEdg1d0mXeve
	 NnhvCUndy/vQpprZQQZ9ZXrby+qNvJ65l9nnxXqfdLwxATBOWm5cJ4zsOXA4CD89H1
	 6VVoaBc5S0m/7xE2FubaLEPr5E4Zx+su482GaoiAGq5GCVrkG9CATqFQkIZAkArPJc
	 M2O5CwvGOUpoZYKYQYXn76tOWSIgJMt58BeURUcJVQEKazq1kPz2nKx8oEOIcB8Wnb
	 RrVCPS173Z+uA1niHUqmf+7oN6018eJo1TinQB2++q2Rtq3Iab85c9muTGEemmlT9s
	 0BAD+M4RwZnnw==
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so530809f8f.3;
        Wed, 22 May 2024 01:00:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbUFKZjD+U3bK9afaEqpXx4+njt8196yWfWTAE6olDOIVR7xB+dLiV+UDTd/kdVSJ/NgqYOH+nkJCwZHx4zQU2RcMdTmJM/ABnHS6aOobuJPn+Pk6N8UpsMOtdA1wr1OdKTJ9c
X-Gm-Message-State: AOJu0YylA8zSTz9pphnZKWMQPgTQF5B/nnSLTRIQHMeMIdsmWBamVVUW
	GKxR1WZxz+i2dt2hJPLet0rsi4Fhii7dKrKIyZIL6PstaSEMwYFlb3YF1lTDdvgLXsiLdIFlW97
	y04AkqeLnTjJc8K5VR+29/ubYvnU=
X-Google-Smtp-Source: AGHT+IGB9BIS9Kop1kEq4bxJyatyF4JrT25siZ44mZDszmXdW0jKScK7W34sTieEYRDBfaV1TG/QovV0S90rAFTzvIM=
X-Received: by 2002:a05:6000:bd0:b0:34c:71d0:1151 with SMTP id
 ffacd0b85a97d-354d8c75e43mr1050070f8f.10.1716364840755; Wed, 22 May 2024
 01:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com> <20240522-loongarch-booting-fixes-v2-3-727edb96e548@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v2-3-727edb96e548@flygoat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 May 2024 16:00:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7+2BFEN4qgkJ0N48t8o7rixPK7_kn8jwowWPNHS7=Ohw@mail.gmail.com>
Message-ID: <CAAhV-H7+2BFEN4qgkJ0N48t8o7rixPK7_kn8jwowWPNHS7=Ohw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] LoongArch: Fix entry point in image header
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jiaxun,

On Wed, May 22, 2024 at 2:30=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> Currently kernel entry in head.S is in DMW address range,
> firmware is instructed to jump to this address after loading
> the image.
>
> However kernel should not make any assumption on firmware's
> DMW setting, thus the entry point should be a physical address
> falls into direct translation region.
>
> Fix by applying a calculation to the entry and amend entry
> calculation logic in libstub accordingly.
>
> Note that due to relocation restriction TO_PHYS can't be used
> in assembly, we can only do plus and minus here.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Fix efistub
> ---
>  arch/loongarch/kernel/head.S             | 2 +-
>  drivers/firmware/efi/libstub/loongarch.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index c4f7de2e2805..1a83564023e1 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -22,7 +22,7 @@
>  _head:
>         .word   MZ_MAGIC                /* "MZ", MS-DOS header */
>         .org    0x8
> -       .dword  kernel_entry            /* Kernel entry point */
> +       .dword  PHYS_LINK_KADDR + (kernel_entry - _head)        /* Kernel=
 entry point */
It could be better to calculate it in the link script, just as _kernel_asiz=
e.

Huacai

>         .dword  _kernel_asize           /* Kernel image effective size */
>         .quad   PHYS_LINK_KADDR         /* Kernel image load offset from =
start of RAM */
>         .org    0x38                    /* 0x20 ~ 0x37 reserved */
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/=
efi/libstub/loongarch.c
> index 684c9354637c..60c145121393 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -41,7 +41,7 @@ static efi_status_t exit_boot_func(struct efi_boot_memm=
ap *map, void *priv)
>  unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
>                 efi_loaded_image_t *image)
>  {
> -       return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS=
 + kernel_addr;
> +       return *(unsigned long *)(kernel_addr + 8) - TO_PHYS(VMLINUX_LOAD=
_ADDRESS) + kernel_addr;
>  }
>
>  efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
>
> --
> 2.43.0
>
>

