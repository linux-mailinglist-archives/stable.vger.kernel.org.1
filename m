Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAB7824E0
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjHUHuw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Mon, 21 Aug 2023 03:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjHUHuw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 03:50:52 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA56C0;
        Mon, 21 Aug 2023 00:50:48 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58fc4eaa04fso15675297b3.0;
        Mon, 21 Aug 2023 00:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692604247; x=1693209047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m45Hh8p8kmMhNIID8xMBwPWwp+qRb3TqygQoUrMVJXU=;
        b=bVmnJ7E3H1btuLavJadslw8KSSK4+qQ5WPUoEOqTob2GlO/3OwDh4mM+oq94ZnV3iS
         AqpMkWhFF/46O3ACUQh3h1R2z9FFZJjqmwRsG/muTFIvt3btKDAbKp6/b6k1FZ3NDwRQ
         qL+e/QmaWfykpQFNPiRx+Meg3go/BmqXlPQ7oNIwyocRPcfxkHPI0+cIZ6BbDEyVr2FG
         1Qy3gEz6qLtV10DX7GGglQHB8BZ/1IhVKtCcZm/qGpSg3bxH1QqqCSQdKoHqXH36Kl16
         16wk68mANn6ngVA/AT1Opl6v1FFWbTIWrtS4MHgnUJDcK+fhqU53gFQulJt/u0EZw8nJ
         UtSw==
X-Gm-Message-State: AOJu0YzLmqZTtHIosuJFXQASgg/v/F8BlZImqSiHAb5sDebD7X2WcVNe
        Mqa8v84pcNqOMNM8XlQci6i00/Ote2G6PQ==
X-Google-Smtp-Source: AGHT+IGXLdQfleiQtiQ3ylW/53c2Lp2932DTVC3+rbSc1/YkDrU8uk/t8vLl7v2aE4V1cLKv+s1gHQ==
X-Received: by 2002:a81:8395:0:b0:589:fb69:a4ef with SMTP id t143-20020a818395000000b00589fb69a4efmr5155373ywf.3.1692604247528;
        Mon, 21 Aug 2023 00:50:47 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id j1-20020a0dc701000000b0058ddb62f99bsm2145361ywd.38.2023.08.21.00.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:50:47 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d712d86eb96so2763447276.3;
        Mon, 21 Aug 2023 00:50:47 -0700 (PDT)
X-Received: by 2002:a25:d149:0:b0:d55:370b:aa2e with SMTP id
 i70-20020a25d149000000b00d55370baa2emr6832480ybg.25.1692604246943; Mon, 21
 Aug 2023 00:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230818234903.9226-1-schmitzmic@gmail.com> <20230818234903.9226-2-schmitzmic@gmail.com>
In-Reply-To: <20230818234903.9226-2-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 09:50:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com>
Message-ID: <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ata: pata_falcon: fix IO base selection for Q40
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Michael,

On Sat, Aug 19, 2023 at 1:49 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
> with pata_falcon and falconide"), the Q40 IDE driver was
> replaced by pata_falcon.c.
>
> Both IO and memory resources were defined for the Q40 IDE
> platform device, but definition of the IDE register addresses
> was modeled after the Falcon case, both in use of the memory
> resources and in including register scale and byte vs. word
> offset in the address.
>
> This was correct for the Falcon case, which does not apply
> any address translation to the register addresses. In the
> Q40 case, all of device base address, byte access offset
> and register scaling is included in the platform specific
> ISA access translation (in asm/mm_io.h).
>
> As a consequence, such address translation gets applied
> twice, and register addresses are mangled.
>
> Use the device base address from the platform IO resource,
> and use standard register offsets from that base in order
> to calculate register addresses (the IO address translation
> will then apply the correct ISA window base and scaling).
>
> Encode PIO_OFFSET into IO port addresses for all registers
> except the data transfer register. Encode the MMIO offset
> there (pata_falcon_data_xfer() directly uses raw IO with
> no address translation).
>
> Reported-by: William R Sowerbutts <will@sowerbutts.com>
> Closes: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
> Link: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
> Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
> Cc: stable@vger.kernel.org
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: William R Sowerbutts <will@sowerbutts.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Thanks for the update!

> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>         ap->pio_mask = ATA_PIO4;
>         ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>
> -       base = (void __iomem *)base_mem_res->start;
>         /* N.B. this assumes data_addr will be used for word-sized I/O only */
> -       ap->ioaddr.data_addr            = base + 0 + 0 * 4;
> -       ap->ioaddr.error_addr           = base + 1 + 1 * 4;
> -       ap->ioaddr.feature_addr         = base + 1 + 1 * 4;
> -       ap->ioaddr.nsect_addr           = base + 1 + 2 * 4;
> -       ap->ioaddr.lbal_addr            = base + 1 + 3 * 4;
> -       ap->ioaddr.lbam_addr            = base + 1 + 4 * 4;
> -       ap->ioaddr.lbah_addr            = base + 1 + 5 * 4;
> -       ap->ioaddr.device_addr          = base + 1 + 6 * 4;
> -       ap->ioaddr.status_addr          = base + 1 + 7 * 4;
> -       ap->ioaddr.command_addr         = base + 1 + 7 * 4;
> -
> -       base = (void __iomem *)ctl_mem_res->start;
> -       ap->ioaddr.altstatus_addr       = base + 1;
> -       ap->ioaddr.ctl_addr             = base + 1;
> -
> -       ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> -                     (unsigned long)base_mem_res->start,
> -                     (unsigned long)ctl_mem_res->start);
> +       ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
> +
> +       if (base_res) {         /* only Q40 has IO resources */
> +               io_offset = 0x10000;
> +               reg_scale = 1;
> +               base = (void __iomem *)base_res->start;
> +               ctl_base = (void __iomem *)ctl_res->start;
> +
> +               ata_port_desc(ap, "cmd %pa ctl %pa",
> +                             &base_res->start,
> +                             &ctl_res->start);

This can be  moved outside the else, using %px to format base and
ctl_base.

> +       } else {
> +               base = (void __iomem *)base_mem_res->start;
> +               ctl_base = (void __iomem *)ctl_mem_res->start;
> +
> +               ata_port_desc(ap, "cmd %pa ctl %pa",
> +                             &base_mem_res->start,
> +                             &ctl_mem_res->start);
> +       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
