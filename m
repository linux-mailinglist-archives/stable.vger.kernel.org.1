Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A14783A47
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 09:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjHVHFl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Tue, 22 Aug 2023 03:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjHVHFk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 03:05:40 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38736130;
        Tue, 22 Aug 2023 00:05:38 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6b9e478e122so3014179a34.1;
        Tue, 22 Aug 2023 00:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692687937; x=1693292737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP+rN1To96ZQXN7U+PR1AbeNniKJvG7oUIaVqHzjBVA=;
        b=aMGRmJ/h8n3Dedq2jcNv3UzInaJd+Z0kCZSGw5aAa6Oa/5rAL8kNGNn6apMQbbD/yh
         BukbfpQQFnbUMett49DgDgmXIpG7QubK9ZaqI+XFOLU1yTZBKlbxl2A8QP0z2wEsgFUN
         fPgtUBSpz46SvEXmZw+GN0JykcCzSuPZR4qlF8gWEm1ZFnBOil47W+LdLvyQI47mZbjn
         OTDxNCxtQb98vCqytrn/Ln/pNPrOYKi7B+URDKYVIkoHtgHeTRs/ZXxs/lCWzNptNxmk
         Xhhx5EmOTlQj0s3a66x2ryucZ6HOcwOJnMCPXeDFccCO5lEXST5eENnW2+v0mPolnjSQ
         Sb6g==
X-Gm-Message-State: AOJu0YwPDBqFQDCVjqwas3iS1FHWWPjyGXAAfLK8dbJ/RtaGcOKSg5Sz
        AtHI7fLRTGTfeYA02NtRtunJUKCV/d1J0Q==
X-Google-Smtp-Source: AGHT+IEESA9ekd/cOzcINSehY57L9fJJjfhPDsdM2WDpqZHxunCDX1BbUo5QGY0qkaUdOj74evFhGg==
X-Received: by 2002:a9d:631a:0:b0:6bb:1071:ea72 with SMTP id q26-20020a9d631a000000b006bb1071ea72mr9407843otk.36.1692687937203;
        Tue, 22 Aug 2023 00:05:37 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id x5-20020a05683000c500b006b8a959ac32sm4337024oto.48.2023.08.22.00.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 00:05:36 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3a8614fe8c4so886413b6e.1;
        Tue, 22 Aug 2023 00:05:36 -0700 (PDT)
X-Received: by 2002:a05:6358:c1d:b0:134:cb65:fbbe with SMTP id
 f29-20020a0563580c1d00b00134cb65fbbemr10587247rwj.13.1692687936653; Tue, 22
 Aug 2023 00:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230818234903.9226-1-schmitzmic@gmail.com> <20230818234903.9226-2-schmitzmic@gmail.com>
 <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com> <07f8a1f9-e145-2b0a-61f0-ac5fe5a8fa58@gmail.com>
In-Reply-To: <07f8a1f9-e145-2b0a-61f0-ac5fe5a8fa58@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Aug 2023 09:05:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNm7RdZcTa5EaWaFZ4NhPi75y8i31C2dkzJ5Hc4rtSJA@mail.gmail.com>
Message-ID: <CAMuHMdWNm7RdZcTa5EaWaFZ4NhPi75y8i31C2dkzJ5Hc4rtSJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ata: pata_falcon: fix IO base selection for Q40
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Michael,

On Tue, Aug 22, 2023 at 1:57 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 21/08/23 19:50, Geert Uytterhoeven wrote:
> > On Sat, Aug 19, 2023 at 1:49 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
> >> with pata_falcon and falconide"), the Q40 IDE driver was
> >> replaced by pata_falcon.c.
> >>
> >> Both IO and memory resources were defined for the Q40 IDE
> >> platform device, but definition of the IDE register addresses
> >> was modeled after the Falcon case, both in use of the memory
> >> resources and in including register scale and byte vs. word
> >> offset in the address.
> >>
> >> This was correct for the Falcon case, which does not apply
> >> any address translation to the register addresses. In the
> >> Q40 case, all of device base address, byte access offset
> >> and register scaling is included in the platform specific
> >> ISA access translation (in asm/mm_io.h).
> >>
> >> As a consequence, such address translation gets applied
> >> twice, and register addresses are mangled.
> >>
> >> Use the device base address from the platform IO resource,
> >> and use standard register offsets from that base in order
> >> to calculate register addresses (the IO address translation
> >> will then apply the correct ISA window base and scaling).
> >>
> >> Encode PIO_OFFSET into IO port addresses for all registers
> >> except the data transfer register. Encode the MMIO offset
> >> there (pata_falcon_data_xfer() directly uses raw IO with
> >> no address translation).
> >>
> >> Reported-by: William R Sowerbutts <will@sowerbutts.com>
> >> Closes: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
> >> Link: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
> >> Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
> >> Cc: stable@vger.kernel.org
> >> Cc: Finn Thain <fthain@linux-m68k.org>
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Tested-by: William R Sowerbutts <will@sowerbutts.com>
> >> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> > Thanks for the update!
> >
> >> --- a/drivers/ata/pata_falcon.c
> >> +++ b/drivers/ata/pata_falcon.c
> >> @@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
> >>          ap->pio_mask = ATA_PIO4;
> >>          ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
> >>
> >> -       base = (void __iomem *)base_mem_res->start;
> >>          /* N.B. this assumes data_addr will be used for word-sized I/O only */
> >> -       ap->ioaddr.data_addr            = base + 0 + 0 * 4;
> >> -       ap->ioaddr.error_addr           = base + 1 + 1 * 4;
> >> -       ap->ioaddr.feature_addr         = base + 1 + 1 * 4;
> >> -       ap->ioaddr.nsect_addr           = base + 1 + 2 * 4;
> >> -       ap->ioaddr.lbal_addr            = base + 1 + 3 * 4;
> >> -       ap->ioaddr.lbam_addr            = base + 1 + 4 * 4;
> >> -       ap->ioaddr.lbah_addr            = base + 1 + 5 * 4;
> >> -       ap->ioaddr.device_addr          = base + 1 + 6 * 4;
> >> -       ap->ioaddr.status_addr          = base + 1 + 7 * 4;
> >> -       ap->ioaddr.command_addr         = base + 1 + 7 * 4;
> >> -
> >> -       base = (void __iomem *)ctl_mem_res->start;
> >> -       ap->ioaddr.altstatus_addr       = base + 1;
> >> -       ap->ioaddr.ctl_addr             = base + 1;
> >> -
> >> -       ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> >> -                     (unsigned long)base_mem_res->start,
> >> -                     (unsigned long)ctl_mem_res->start);
> >> +       ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
> >> +
> >> +       if (base_res) {         /* only Q40 has IO resources */
> >> +               io_offset = 0x10000;
> >> +               reg_scale = 1;
> >> +               base = (void __iomem *)base_res->start;
> >> +               ctl_base = (void __iomem *)ctl_res->start;
> >> +
> >> +               ata_port_desc(ap, "cmd %pa ctl %pa",
> >> +                             &base_res->start,
> >> +                             &ctl_res->start);
> > This can be  moved outside the else, using %px to format base and
> > ctl_base.
>
> Right - do we need some additional message spelling out what address Q40
> uses for data transfers? (Redundant for Falcon, of course ...)
>
> Though that could be handled outside the else, too:
>
> ata_port_desc(ap, "cmd %px ctl %px data %pa",
>                base, ctl_base, &ap->ioaddr.data_addr);

I guess that wouldn't hurt.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
