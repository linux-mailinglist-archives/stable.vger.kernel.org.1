Return-Path: <stable+bounces-52550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C773990B217
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCE41C2309A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B0519B5A8;
	Mon, 17 Jun 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuQmpaIV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B4198A39;
	Mon, 17 Jun 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632162; cv=none; b=a+NBkb9Xa1C5v/Ga6AjiVDCwosyMzF+EYIep20hK5p+lnhjS7C5RnBYuV1iNGgobcO1ESslweHUPviHFjVovMtMxhbw506CUCvQcXqAL13dygl1ShU49/s7ESBIlXrC0Z7lkfP8CKzooVQFIHaE8nRKw3HI7NFh7GQCVOkObK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632162; c=relaxed/simple;
	bh=HqF4isRv+ArtpWG9OQ68NdMlDfuDGfF02uZsD8+0IVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjNG7hQYrO22epMyG4d9sxqjT6au+t4M61DkoO+hg3q0JOBD+04J9cUl3EZdOqwthplFME5uQH2I172uaKu1GiXs9N+Rm12KYHIG/NKibjvUlwkTkyvz1jCwwv/vE1nwrhFHKqhfWYEpKdjbhitw1gQghAOjcVsK13RdMDeD4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuQmpaIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91169C4AF49;
	Mon, 17 Jun 2024 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718632161;
	bh=HqF4isRv+ArtpWG9OQ68NdMlDfuDGfF02uZsD8+0IVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VuQmpaIVwaTyg5OMoP0pXhm0Vy2VX5swQY3VSPwDmrB7xDsKCFLgvpDV/3Lw27RZ4
	 e5SOTu6v1+a7qE5TE9HA1zXI2OzlcTbVyKM/dg9HwOo4+Q7zZQ9M05aGoherz45OUN
	 9ef4Q0ITItGlOkZhA6Za3x52dkBHzC84fHWlwmq7Tp7kgc5xRZwx00P0bipnxd4bC9
	 kv6rQu+ea2ZKi9I/J+MzKmYpHyUEJoTuLUbKfwgIVgyV4p2YqG5ANC0RgaE5Ld/MS9
	 vQyh3ySFaQj00hpGiYTVbPFXSD4Es4C4RRm4k5dsX9ftdjSFmax8RKlmJsmuLZ2Fuy
	 qLwWTOcjtFicg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so5150007a12.2;
        Mon, 17 Jun 2024 06:49:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6m4QTz6+Sx1ctIeTZ4xFRHF+IKfrAADcOs7YvjgSsbcGyclXcNFjmEJt16k6C5INya2s0T+cJmxZMkkhGttHtNboqz5bSPQ/DUg0biva68IPpvwyp9p1zQTVSFtPEuUVehCp/
X-Gm-Message-State: AOJu0YxGVJ5Hz/Yy8Ggxa+xghSs1zJ4WKYVTFtT/ijPST4XvWIa6i/9F
	l5bDrWm1N8gECBCDcYUrqjZtQC999jRsGWEqvfzH2+dg4Bj80AiIpJHrzXag7FMe9UrNI/hcmrt
	bpYTaBL/xmImdYVUemKWSMqpiWlY=
X-Google-Smtp-Source: AGHT+IF/bQhrXZWDIcE6nt9iGYTRSapLq5kG6SVBui7JWuoMT5hDRYJsYe2vSL3kzufUGoaIlUNzXzhM4BKP0uETtpE=
X-Received: by 2002:a50:955c:0:b0:579:cf9d:d6a with SMTP id
 4fb4d7f45d1cf-57cbd67dc3cmr5392873a12.20.1718632160011; Mon, 17 Jun 2024
 06:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
 <20240613-loongarch64-sleep-v1-1-a245232af5e4@flygoat.com>
 <CAAhV-H7TqgJiR9z9jEOpv34kijONLVu5Bv2PChjUWxhMKU_Zvw@mail.gmail.com> <3e3d6ee8-a758-4d99-be77-89b26b0ab591@app.fastmail.com>
In-Reply-To: <3e3d6ee8-a758-4d99-be77-89b26b0ab591@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Jun 2024 21:49:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H54ORMNCQpJahPiSdrrUita7V1-08jZsERF9K+q=B-fGg@mail.gmail.com>
Message-ID: <CAAhV-H54ORMNCQpJahPiSdrrUita7V1-08jZsERF9K+q=B-fGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: Initialise unused Direct Map Windows
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:18=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=883:13=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> > Hi, Jiaxun,
> >
> > On Fri, Jun 14, 2024 at 12:41=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygo=
at.com> wrote:
> >>
> >> DMW 2 & 3 are unused by kernel, however firmware may leave
> >> garbage in them and interfere kernel's address mapping.
> >>
> >> Clear them as necessary.
> > I think the current status is as expected, we don't want kernel access
> > to non-8000 and non-9000 addresses. And low-end chips may have only
> > two DMWs.
>
> I see, I'll remove U-Boot's dependency to DMW 2 and 3 then.
I was told that DMW2&3 are probably exist (but cannot used for
instruction fetch), so I applied this patch and implement DMW-based
ioremap_wc().

https://github.com/chenhuacai/linux/commit/fa9f4109bf19a19736877d01e3e35297=
56a96095


Huacai

>
> Thanks
> - Jiaxun
>
> >
> > Huacai
> >
> >
> > Huacai
> >
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> ---
> >>  arch/loongarch/include/asm/loongarch.h   |  4 ++++
> >>  arch/loongarch/include/asm/stackframe.h  | 11 +++++++++++
> >>  arch/loongarch/kernel/head.S             | 12 ++----------
> >>  arch/loongarch/power/suspend_asm.S       |  6 +-----
> >>  drivers/firmware/efi/libstub/loongarch.c |  2 ++
> >>  5 files changed, 20 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/i=
nclude/asm/loongarch.h
> >> index eb09adda54b7..3720096efcf9 100644
> >> --- a/arch/loongarch/include/asm/loongarch.h
> >> +++ b/arch/loongarch/include/asm/loongarch.h
> >> @@ -889,6 +889,10 @@
> >>  #define CSR_DMW1_BASE          (CSR_DMW1_VSEG << DMW_PABITS)
> >>  #define CSR_DMW1_INIT          (CSR_DMW1_BASE | CSR_DMW1_MAT | CSR_DM=
W1_PLV0)
> >>
> >> +/* Direct Map window 2/3 - unused */
> >> +#define CSR_DMW2_INIT          0
> >> +#define CSR_DMW3_INIT          0
> >> +
> >>  /* Performance Counter registers */
> >>  #define LOONGARCH_CSR_PERFCTRL0                0x200   /* 32 perf eve=
nt 0 config */
> >>  #define LOONGARCH_CSR_PERFCNTR0                0x201   /* 64 perf eve=
nt 0 count value */
> >> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/=
include/asm/stackframe.h
> >> index d9eafd3ee3d1..10c5dcf56bc7 100644
> >> --- a/arch/loongarch/include/asm/stackframe.h
> >> +++ b/arch/loongarch/include/asm/stackframe.h
> >> @@ -38,6 +38,17 @@
> >>         cfi_restore \reg \offset \docfi
> >>         .endm
> >>
> >> +       .macro SETUP_DMWS temp1
> >> +       li.d    \temp1, CSR_DMW0_INIT
> >> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN0
> >> +       li.d    \temp1, CSR_DMW1_INIT
> >> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN1
> >> +       li.d    \temp1, CSR_DMW2_INIT
> >> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN2
> >> +       li.d    \temp1, CSR_DMW3_INIT
> >> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN3
> >> +       .endm
> >> +
> >>  /* Jump to the runtime virtual address. */
> >>         .macro JUMP_VIRT_ADDR temp1 temp2
> >>         li.d    \temp1, CACHE_BASE
> >> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head=
.S
> >> index 4677ea8fa8e9..1a71fc09bfd6 100644
> >> --- a/arch/loongarch/kernel/head.S
> >> +++ b/arch/loongarch/kernel/head.S
> >> @@ -44,11 +44,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
> >>  SYM_CODE_START(kernel_entry)                   # kernel entry point
> >>
> >>         /* Config direct window and set PG */
> >> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0, 0x8000 xxx=
x xxxx xxxx
> >> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
> >> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0, 0x9000 xxx=
x xxxx xxxx
> >> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
> >> -
> >> +       SETUP_DMWS      t0
> >>         JUMP_VIRT_ADDR  t0, t1
> >>
> >>         /* Enable PG */
> >> @@ -124,11 +120,7 @@ SYM_CODE_END(kernel_entry)
> >>   * function after setting up the stack and tp registers.
> >>   */
> >>  SYM_CODE_START(smpboot_entry)
> >> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0
> >> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
> >> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> >> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
> >> -
> >> +       SETUP_DMWS      t0
> >>         JUMP_VIRT_ADDR  t0, t1
> >>
> >>  #ifdef CONFIG_PAGE_SIZE_4KB
> >> diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power=
/suspend_asm.S
> >> index e2fc3b4e31f0..6fdd74eb219b 100644
> >> --- a/arch/loongarch/power/suspend_asm.S
> >> +++ b/arch/loongarch/power/suspend_asm.S
> >> @@ -73,11 +73,7 @@ SYM_FUNC_START(loongarch_suspend_enter)
> >>          * Reload all of the registers and return.
> >>          */
> >>  SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
> >> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0
> >> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
> >> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> >> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
> >> -
> >> +       SETUP_DMWS      t0
> >>         JUMP_VIRT_ADDR  t0, t1
> >>
> >>         /* Enable PG */
> >> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmwa=
re/efi/libstub/loongarch.c
> >> index d0ef93551c44..3782d0a187d1 100644
> >> --- a/drivers/firmware/efi/libstub/loongarch.c
> >> +++ b/drivers/firmware/efi/libstub/loongarch.c
> >> @@ -74,6 +74,8 @@ efi_status_t efi_boot_kernel(void *handle, efi_loade=
d_image_t *image,
> >>         /* Config Direct Mapping */
> >>         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> >>         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> >> +       csr_write64(CSR_DMW2_INIT, LOONGARCH_CSR_DMWIN2);
> >> +       csr_write64(CSR_DMW3_INIT, LOONGARCH_CSR_DMWIN3);
> >>
> >>         real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr=
, image);
> >>
> >>
> >> --
> >> 2.43.0
> >>
> >>
>
> --
> - Jiaxun
>

