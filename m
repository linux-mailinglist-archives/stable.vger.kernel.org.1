Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB04C7746BD
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 21:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjHHTAb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjHHS7z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:59:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEED17D4AD
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 10:26:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-317f1c480eeso1418690f8f.2
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691515583; x=1692120383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjMinkLLG+ohV2ywpwHhC/4FY8Aaak2xsS4jq8Jnyf4=;
        b=XGHWAc60M15JIVh/DWYbf25adbLRZIXP0lEWzZwkbsDtvzbyxWP9sOyOyYXHFGQ/OT
         Vdt5mdAC1o5BsEHFKV89HnXok3jMDjTKXXLfUIBjGCQAGU7rijpqM9VLO+Q2daUt8pZF
         ScCYTxtCeZdL8x6lfQg5UtK2qNyppznCKRsAna6sd3aSg3fWjQIM6cJouGoRCiyDEfAb
         GensOvMyvEKslJQh3bMDx6U1DDuu51XNTI2ed1dnEpFcwxumkAD1q2dfxvW0253VLH0h
         9JM/FJUh5G7kPFDTZLL77ipz6Ppantzuo2OO0E6zEysAogEQ7ktlx8WCNsePVHHkt+yl
         mjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515583; x=1692120383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjMinkLLG+ohV2ywpwHhC/4FY8Aaak2xsS4jq8Jnyf4=;
        b=I3MUhKAhNrmE1lDf9Fx4wfecUSJbKBjCHLjCEYPEEOMHiH0nO5nDc6147m7770YKUG
         N3w8r6062wo6gvgKW/68FdIx7pm7QmPrl/xDKKR9c0bQJkE0xl7jGMYiqahN88mBbPLc
         WkcDFZQSJFioVkDf71FuwxDjuk+xRACdwGRRFpaOteD8PBP5SjynZoyVFAJKq5szPgAz
         SNXpgNC83+wIg7qw8Aen25vFb8ktlacuEkYncwYFQ5oJdsYQMWcQDaqzG6vom2js7eFs
         Jfe0jHuTt9YeSDZFPKwGmpJ6QdAeStoekRikoR8D13u0/ST9qZIJSgz1fpOyfxEQAzwL
         KJsA==
X-Gm-Message-State: AOJu0YwMDFc3NTqOdMXcu+/ZpQmE7PjwQl+ngpmL5A9QSRM1cjXT26HM
        NCKd04pphf84ohzOtD64GohjOgBcOFSbA3CW86RA3Sfljxm2ebtNlKw=
X-Google-Smtp-Source: AGHT+IFsNbOIL8bGxLbliJ4Rutzgzhsr0cGwpEiIgGnCjKczhEVVkqh+j/n632P2kk2A+Tq1xTBlCB4cXMos31imSHc=
X-Received: by 2002:a2e:9c02:0:b0:2b6:d8d5:15b1 with SMTP id
 s2-20020a2e9c02000000b002b6d8d515b1mr7681471lji.50.1691481263044; Tue, 08 Aug
 2023 00:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-purse-hydrant-6f44f77364b0@wendy> <20230802-detention-second-82ab2b53e07a@wendy>
In-Reply-To: <20230802-detention-second-82ab2b53e07a@wendy>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Tue, 8 Aug 2023 00:54:11 -0700
Message-ID: <CAHBxVyGgSJ66zMj65tRup2u23KP4=RJ5zN7hj5=K9e91NA9eog@mail.gmail.com>
Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 2, 2023 at 4:14=E2=80=AFAM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> Add an erratum for versions [v0.8 to v1.3) of OpenSBI which fail to add
> the "no-map" property to the reserved memory nodes for the regions it
> has protected using PMPs.
>
> Our existing fix sweeping hibernation under the carpet by marking it
> NONPORTABLE is insufficient as there are other ways to generate
> accesses to these reserved memory regions, as Petr discovered [1]
> while testing crash kernels & kdump.
>
> Intercede during the boot process when the afflicted versions of OpenSBI
> are present & set the "no-map" property in all "mmode_resv" nodes before
> the kernel does its reserved memory region initialisation.
>

We have different mechanisms of DT being passed to the kernel.

1. A prior stage(e.g U-Boot SPL) to M-mode runtime firmware (e.g.
OpenSBI, rustSBI) passes the DT to M-mode runtime firmware and it
passes to the next stage.
In this case, M-mode runtime firmware gets a chance to update the
no-map property in DT that the kernel can parse.

2. User loads the DT from the boot loader (e.g EDK2, U-Boot proper).
Any DT patching done by the M-mode firmware is useless. If these DTBs
don't have the no-map
property, hibernation or EFI booting will have issues as well.

We are trying to solve only one part of problem #1 in this patch. I
don't think any other M-mode runtime firmware patches DT with no-map
property as well.
Please let me know if I am wrong about that. The problem is not
restricted to [v0.8 to v1.3) of OpenSBI.

The booting doc now says that no-map property must be set and any
usage of DTBs without that (via #1 or #2) will have unintended
consequences.

> Reported-by: Song Shuai <suagrfillet@gmail.com>
> Link: https://lore.kernel.org/all/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_vhB+vm_1=
dHJxPNi75YDQ_Q@mail.gmail.com/
> Reported-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ITXwaKfA6z8
> Reported-by: Petr Tesarik <petrtesarik@huaweicloud.com>
> Closes: https://lore.kernel.org/linux-riscv/76ff0f51-d6c1-580d-f943-061e9=
3073306@huaweicloud.com/ [1]
> CC: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/sbi.h |  5 +++++
>  arch/riscv/kernel/sbi.c      | 42 +++++++++++++++++++++++++++++++++++-
>  arch/riscv/mm/init.c         |  3 +++
>  3 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 5b4a1bf5f439..5360f3476278 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -252,6 +252,9 @@ enum sbi_pmu_ctr_type {
>  #define SBI_ERR_ALREADY_STARTED -7
>  #define SBI_ERR_ALREADY_STOPPED -8
>
> +/* SBI implementation IDs */
> +#define SBI_IMP_OPENSBI        1
> +
>  extern unsigned long sbi_spec_version;
>  struct sbiret {
>         long error;
> @@ -259,6 +262,8 @@ struct sbiret {
>  };
>
>  void sbi_init(void);
> +void sbi_apply_reserved_mem_erratum(void *dtb_va);
> +
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>                         unsigned long arg1, unsigned long arg2,
>                         unsigned long arg3, unsigned long arg4,
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index c672c8ba9a2a..aeb27263fa53 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -5,8 +5,10 @@
>   * Copyright (c) 2020 Western Digital Corporation or its affiliates.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/bits.h>
>  #include <linux/init.h>
> +#include <linux/libfdt.h>
>  #include <linux/pm.h>
>  #include <linux/reboot.h>
>  #include <asm/sbi.h>
> @@ -583,6 +585,40 @@ long sbi_get_mimpid(void)
>  }
>  EXPORT_SYMBOL_GPL(sbi_get_mimpid);
>
> +static long sbi_firmware_id;
> +static long sbi_firmware_version;
> +
> +/*
> + * For devicetrees patched by OpenSBI a "mmode_resv" node is added to co=
ver
> + * the region OpenSBI has protected by means of a PMP. Some versions of =
OpenSBI,
> + * [v0.8 to v1.3), omitted the "no-map" property, but this trips up hibe=
rnation
> + * among other things.
> + */
> +void __init sbi_apply_reserved_mem_erratum(void *dtb_pa)
> +{
> +       int child, reserved_mem;
> +
> +       if (sbi_firmware_id !=3D SBI_IMP_OPENSBI)
> +               return;
> +
> +       if (!acpi_disabled)
> +               return;
> +
> +       if (sbi_firmware_version >=3D 0x10003 || sbi_firmware_version < 0=
x8)
> +               return;
> +
> +       reserved_mem =3D fdt_path_offset((void *)dtb_pa, "/reserved-memor=
y");
> +       if (reserved_mem < 0)
> +               return;
> +
> +       fdt_for_each_subnode(child, (void *)dtb_pa, reserved_mem) {
> +               const char *name =3D fdt_get_name((void *)dtb_pa, child, =
NULL);
> +
> +               if (!strncmp(name, "mmode_resv", 10))
> +                       fdt_setprop((void *)dtb_pa, child, "no-map", NULL=
, 0);
> +       }
> +};
> +
>  void __init sbi_init(void)
>  {
>         int ret;
> @@ -596,8 +632,12 @@ void __init sbi_init(void)
>                 sbi_major_version(), sbi_minor_version());
>
>         if (!sbi_spec_is_0_1()) {
> +               sbi_firmware_id =3D sbi_get_firmware_id();
> +               sbi_firmware_version =3D sbi_get_firmware_version();
> +
>                 pr_info("SBI implementation ID=3D0x%lx Version=3D0x%lx\n"=
,
> -                       sbi_get_firmware_id(), sbi_get_firmware_version()=
);
> +                       sbi_firmware_id, sbi_firmware_version);
> +
>                 if (sbi_probe_extension(SBI_EXT_TIME)) {
>                         __sbi_set_timer =3D __sbi_set_timer_v02;
>                         pr_info("SBI TIME extension detected\n");
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 70fb31960b63..cb16bfdeacdb 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -29,6 +29,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/sections.h>
>  #include <asm/soc.h>
> +#include <asm/sbi.h>
>  #include <asm/io.h>
>  #include <asm/ptdump.h>
>  #include <asm/numa.h>
> @@ -253,6 +254,8 @@ static void __init setup_bootmem(void)
>          * in the device tree, otherwise the allocation could end up in a
>          * reserved region.
>          */
> +
> +       sbi_apply_reserved_mem_erratum(dtb_early_va);
>         early_init_fdt_scan_reserved_mem();
>
>         /*
> --
> 2.40.1
>
