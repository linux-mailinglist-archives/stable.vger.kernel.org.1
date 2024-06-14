Return-Path: <stable+bounces-52126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F2908171
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 04:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2295283251
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 02:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6301822F8;
	Fri, 14 Jun 2024 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS0L4guD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08927158D83;
	Fri, 14 Jun 2024 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331235; cv=none; b=FMmB0Rd1oDDB4tcRem1bmMczTDfX+hQywWghprB1/1d4QusfdnRXvqjlr3G5KDr8+RcMOR9ufRFeGj/YZAKFfNAV9Jg/uQWE5glcCJjFl6FFln+32rp3Z3TG5fZbhMsPe7ogiT08mTtHzSMIep6XsoQATYDTDrydbGoVPcE4UW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331235; c=relaxed/simple;
	bh=kYRitAYoLOr0m1tvCQEPOA0/A0P+Jb2sUUooQCK4bJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjIe5OWqBYEDelr2pAivBW/0BqluaRWIGvnnadDGdUMbldHFisH3oKbkvKRYDyi4MbX8rP7S/quILL7jiRg9+J3uvcEJ5jTAc8GCtrYsPqG/a2ZZbLPdcQ9dqCutfNdfaSTeforDUF1jGbDDiUMnYGqIE6en5HAHTBJi8S274Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS0L4guD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2A4C2BBFC;
	Fri, 14 Jun 2024 02:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718331234;
	bh=kYRitAYoLOr0m1tvCQEPOA0/A0P+Jb2sUUooQCK4bJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iS0L4guDyjtkvAsVhet1/LeAb+X8diGvPsjDgxbHhveHbqBTgKtEuYMvn0idsfrg7
	 9gSVILivlW5XqrwCsXBe1sWG9S0qzGp0QWAFeGlVm45ykOIP/ry9ghsCglHCyDuaM2
	 zmjjYYF8V/sQ6+vVm/PSYmgQ9bUabZxsci3E646x0r7XnWXNKlJIu1R73HaYMnAQej
	 HcGKfT+Xj8UPQdBgwMhvgP78i6wSYJPQqUbrbs/Wf+UHdBmEJNJU8gDq1Uu++96sz7
	 fD7oYOyLbRG4tovaX82Ohm5tR7T3f67JZECg5dKVA/iyoVrfQxWiqpe1gc9Iqb8hpp
	 le+kbyGHeHUdQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f0e153eddso224535566b.0;
        Thu, 13 Jun 2024 19:13:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1j47vzzXh20GRUbgyO+adWp199poD9PngUzPuy+xIem8poS4hlSfLyuiZrwMPNrCcUdU8/OjT09RQn9OYnBDwtxHyTVL3TbhR9wnDvF4IQ/uHjlmdawZprWjy4H6Gb8hWJvzi
X-Gm-Message-State: AOJu0Ywqs5dK3Ah5mfU0Z/Ox7YxzJxiYlTbRZ5TVezStzOkVFngLbxzp
	BGCi26NNfNsAG4dnCBiDc0AZSgY7yAOurQQlBd+E5mD5CAG+VXl05HD0gSXPLLMRj/hTPUyPlQJ
	BQtLw66dPhZMWuEif3sHO1mxum5g=
X-Google-Smtp-Source: AGHT+IERDSfcdHikl1zjbRLyfFvLWCxoqWg4p6jz+GceJ8kF7rq02uYjYp+gl7Pj7LQAJZ1COyLlFpAEYLCkROW50R8=
X-Received: by 2002:a17:906:c091:b0:a6f:5150:b807 with SMTP id
 a640c23a62f3a-a6f60d3cde2mr91833866b.35.1718331233152; Thu, 13 Jun 2024
 19:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com> <20240613-loongarch64-sleep-v1-1-a245232af5e4@flygoat.com>
In-Reply-To: <20240613-loongarch64-sleep-v1-1-a245232af5e4@flygoat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 14 Jun 2024 10:13:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7TqgJiR9z9jEOpv34kijONLVu5Bv2PChjUWxhMKU_Zvw@mail.gmail.com>
Message-ID: <CAAhV-H7TqgJiR9z9jEOpv34kijONLVu5Bv2PChjUWxhMKU_Zvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: Initialise unused Direct Map Windows
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jiaxun,

On Fri, Jun 14, 2024 at 12:41=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
>
> DMW 2 & 3 are unused by kernel, however firmware may leave
> garbage in them and interfere kernel's address mapping.
>
> Clear them as necessary.
I think the current status is as expected, we don't want kernel access
to non-8000 and non-9000 addresses. And low-end chips may have only
two DMWs.

Huacai


Huacai

>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/loongarch/include/asm/loongarch.h   |  4 ++++
>  arch/loongarch/include/asm/stackframe.h  | 11 +++++++++++
>  arch/loongarch/kernel/head.S             | 12 ++----------
>  arch/loongarch/power/suspend_asm.S       |  6 +-----
>  drivers/firmware/efi/libstub/loongarch.c |  2 ++
>  5 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/incl=
ude/asm/loongarch.h
> index eb09adda54b7..3720096efcf9 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -889,6 +889,10 @@
>  #define CSR_DMW1_BASE          (CSR_DMW1_VSEG << DMW_PABITS)
>  #define CSR_DMW1_INIT          (CSR_DMW1_BASE | CSR_DMW1_MAT | CSR_DMW1_=
PLV0)
>
> +/* Direct Map window 2/3 - unused */
> +#define CSR_DMW2_INIT          0
> +#define CSR_DMW3_INIT          0
> +
>  /* Performance Counter registers */
>  #define LOONGARCH_CSR_PERFCTRL0                0x200   /* 32 perf event =
0 config */
>  #define LOONGARCH_CSR_PERFCNTR0                0x201   /* 64 perf event =
0 count value */
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/inc=
lude/asm/stackframe.h
> index d9eafd3ee3d1..10c5dcf56bc7 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -38,6 +38,17 @@
>         cfi_restore \reg \offset \docfi
>         .endm
>
> +       .macro SETUP_DMWS temp1
> +       li.d    \temp1, CSR_DMW0_INIT
> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN0
> +       li.d    \temp1, CSR_DMW1_INIT
> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN1
> +       li.d    \temp1, CSR_DMW2_INIT
> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN2
> +       li.d    \temp1, CSR_DMW3_INIT
> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN3
> +       .endm
> +
>  /* Jump to the runtime virtual address. */
>         .macro JUMP_VIRT_ADDR temp1 temp2
>         li.d    \temp1, CACHE_BASE
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 4677ea8fa8e9..1a71fc09bfd6 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -44,11 +44,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>  SYM_CODE_START(kernel_entry)                   # kernel entry point
>
>         /* Config direct window and set PG */
> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0, 0x8000 xxxx x=
xxx xxxx
> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0, 0x9000 xxxx x=
xxx xxxx
> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
> -
> +       SETUP_DMWS      t0
>         JUMP_VIRT_ADDR  t0, t1
>
>         /* Enable PG */
> @@ -124,11 +120,7 @@ SYM_CODE_END(kernel_entry)
>   * function after setting up the stack and tp registers.
>   */
>  SYM_CODE_START(smpboot_entry)
> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0
> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
> -
> +       SETUP_DMWS      t0
>         JUMP_VIRT_ADDR  t0, t1
>
>  #ifdef CONFIG_PAGE_SIZE_4KB
> diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/su=
spend_asm.S
> index e2fc3b4e31f0..6fdd74eb219b 100644
> --- a/arch/loongarch/power/suspend_asm.S
> +++ b/arch/loongarch/power/suspend_asm.S
> @@ -73,11 +73,7 @@ SYM_FUNC_START(loongarch_suspend_enter)
>          * Reload all of the registers and return.
>          */
>  SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0
> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
> -
> +       SETUP_DMWS      t0
>         JUMP_VIRT_ADDR  t0, t1
>
>         /* Enable PG */
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/=
efi/libstub/loongarch.c
> index d0ef93551c44..3782d0a187d1 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -74,6 +74,8 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_i=
mage_t *image,
>         /* Config Direct Mapping */
>         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
>         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> +       csr_write64(CSR_DMW2_INIT, LOONGARCH_CSR_DMWIN2);
> +       csr_write64(CSR_DMW3_INIT, LOONGARCH_CSR_DMWIN3);
>
>         real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr, i=
mage);
>
>
> --
> 2.43.0
>
>

