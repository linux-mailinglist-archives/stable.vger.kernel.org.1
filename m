Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F159C7853A3
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 11:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjHWJPP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Wed, 23 Aug 2023 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjHWJON (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 05:14:13 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5474C1F;
        Wed, 23 Aug 2023 02:06:14 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-58e6c05f529so58825167b3.3;
        Wed, 23 Aug 2023 02:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781549; x=1693386349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m79gx8dN5ohFqZGK9FnVxYrPifm4a64GSj4+jVOq7EE=;
        b=L+d/kPWfIGvAQr0V2oumJgsxoX1bn4kfwD9M/sHoJNAmue+30ETAq913/jgmFGjPS1
         r4KvTQMcMebYuwUJR56H3DiZnmYmzjJ913LokfrHO5V4lUK63jfVac8UArurmqc7L1uU
         cW9r6HkT3ef6SzZ3Be6q2WqnbJWZ7EHFJ48AOW5udH+542LHafpY98EGJ+XeWhzzqrsA
         P1uVBHwRGvldCZXxCrFBA5xtKcJKMJitymX+P2TmpAMcSozTTBGj5CawF3fZKQV6RvhS
         U4N2yNZI9L+13MbCN7VXzRiZAEZSXiZb+RzpT7KE3aXkvh0mENEU5+h1ruAMOBCuvTY6
         gmuA==
X-Gm-Message-State: AOJu0Yzw037LbKxv/h8j3yLT86GLxh0crPjsVTTWOStBOVn/+tdm6bOT
        siwQlfZoPfUUAjgE7o3KYxtQQ6+XAXHXkw==
X-Google-Smtp-Source: AGHT+IEZss8SY8QIF57kTiYD8odx3RutImf8Lq9xA+wltVVAwqCjajJISeuHv4+fS5LiEuMWOHnGWQ==
X-Received: by 2002:a0d:e24d:0:b0:583:307d:41bc with SMTP id l74-20020a0de24d000000b00583307d41bcmr12278812ywe.27.1692781549493;
        Wed, 23 Aug 2023 02:05:49 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id d73-20020a814f4c000000b005925765aa30sm576638ywb.135.2023.08.23.02.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:05:49 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d743f58050bso4695256276.1;
        Wed, 23 Aug 2023 02:05:49 -0700 (PDT)
X-Received: by 2002:a25:6d0a:0:b0:d77:d593:da9 with SMTP id
 i10-20020a256d0a000000b00d77d5930da9mr523178ybc.28.1692781548838; Wed, 23 Aug
 2023 02:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230822221359.31024-1-schmitzmic@gmail.com> <20230822221359.31024-2-schmitzmic@gmail.com>
In-Reply-To: <20230822221359.31024-2-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Aug 2023 11:05:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcFprFuwyfvRdKeyvjVAG6hre9S+hU1FvoM69d9_qR-w@mail.gmail.com>
Message-ID: <CAMuHMdUcFprFuwyfvRdKeyvjVAG6hre9S+hU1FvoM69d9_qR-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ata: pata_falcon: fix IO base selection for Q40
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     sergei.shtylyov@gmail.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org, stable@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
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

On Wed, Aug 23, 2023 at 12:14 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
> with pata_falcon and falconide"), the Q40 IDE driver was
> replaced by pata_falcon.c.
>
> Both IO and memory resources were defined for the Q40 IDE
> platform device, but definition of the IDE register addresses
> was modeled after the Falcon case, both in use of the memory
> resources and in including register shift and byte vs. word
> offset in the address.
>
> This was correct for the Falcon case, which does not apply
> any address translation to the register addresses. In the
> Q40 case, all of device base address, byte access offset
> and register shift is included in the platform specific
> ISA access translation (in asm/mm_io.h).
>
> As a consequence, such address translation gets applied
> twice, and register addresses are mangled.
>
> Use the device base address from the platform IO resource
> for Q40 (the IO address translation will then add the correct
> ISA window base address and byte access offset), with register
> shift 1. Use MMIO base address and register shift 2 as before
> for Falcon.
>
> Encode PIO_OFFSET into IO port addresses for all registers
> for Q40 except the data transfer register. Encode the MMIO
> offset there (pata_falcon_data_xfer() directly uses raw IO
> with no address translation).
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
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> ---
>
> Changes from v3:
>
> Sergey Shtylyov:
> - change use of reg_scale to reg_shift
>
> Geert Uytterhoeven:
> - factor out ata_port_desc() from platform specific code

Thanks for the update!

> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c

> +       ata_port_desc(ap, "cmd %px ctl %px data %pa",
> +                     base, ctl_base, &ap->ioaddr.data_addr);

%px and ap->ioaddr.data_addr

The rest LGTM, so with the above fixed
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
