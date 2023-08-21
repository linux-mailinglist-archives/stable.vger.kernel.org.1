Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F94783684
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 01:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjHUX5a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 19:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjHUX53 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 19:57:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5A180;
        Mon, 21 Aug 2023 16:57:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-688787570ccso2613660b3a.2;
        Mon, 21 Aug 2023 16:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692662247; x=1693267047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmgujr3k2OHKU4Xq9+wJms6GtoqA2tOqi+nY9NdatTY=;
        b=CEsbBtbnLTMHpIGoaaMSAanL7C3FtKAEaRkE2oJFlQrAr3Gen324tajghaWBvE7x/Z
         zACbcZfEyQu4p/CHuDHFmCfHmEoCmreSETegI+ZphUIOkjR5i+GcAT74jF0L6zsXef2u
         3Gg3IiMRPLVr/3T2mv+rYgYaCz8590/mkJFlaGKyQsO8BHxGWKvx2hydRaKP46I1dXIg
         L4FU58bTUHePzP+ZmFNIHSSlyIwXYI3+oFZBnuvj9DxgH59HWW5eevhlVtVsl2c2DPmO
         oHntfQmOHjQo3LVrB3dfnzODqNg37sIj6b1/P9kwYlEl7xr8h5Dzp679mTLUD6vVXJxM
         /xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692662247; x=1693267047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmgujr3k2OHKU4Xq9+wJms6GtoqA2tOqi+nY9NdatTY=;
        b=ayECbq8qc7oLOy+TWvSFJ8t0wcxKIXMBkcaeRgIEGjyB9jG9oT3DCSM1tIVznijgKy
         TQKecAwZ5lyEON/BkAb6jgpiYNyEpOmhFE2hrgnyj48PVC8IqNnryVocyEB8jZFn71yW
         icrxpUQOahvxA/Q1UwefY3A/UNeO1lgYh1jZaPGVqy1qBnPKJ61H+g86RWPw2xK6Jmlo
         gzIeR6+oam1FNIRgBjjGC7fX4FOXdOeDh311dMiAIMn5/zg37Gl/MOzITzjEvJ5PxGhw
         qLgfwmhYeBYxHOX6NzolvEt3T6/0QwJrGstZr/JQnaqKCvZbTbF0eHR+ml7DbRORvVKH
         7mRg==
X-Gm-Message-State: AOJu0YzO4KEcFsTxrhkbVzRo5kDKEr85F08Rj0gcjUnL5xuqSuj5Wtsx
        HLf8epNmMk3a+DLw3TlY+5nOqEpxHDI=
X-Google-Smtp-Source: AGHT+IE/uQZjN23ewjCLUcyKw9Xynox5/VNmEH0caCPOAPlTGz1ul8AM7fei8EWayHwmuYrT6YFz7Q==
X-Received: by 2002:a05:6a20:a10a:b0:138:1980:1375 with SMTP id q10-20020a056a20a10a00b0013819801375mr6963581pzk.25.1692662247286;
        Mon, 21 Aug 2023 16:57:27 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:7453:afaf:134e:1bdb? ([2001:df0:0:200c:7453:afaf:134e:1bdb])
        by smtp.gmail.com with ESMTPSA id ey20-20020a056a0038d400b0068a4193f09fsm3053056pfb.64.2023.08.21.16.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 16:57:26 -0700 (PDT)
Message-ID: <07f8a1f9-e145-2b0a-61f0-ac5fe5a8fa58@gmail.com>
Date:   Tue, 22 Aug 2023 11:57:20 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] ata: pata_falcon: fix IO base selection for Q40
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
References: <20230818234903.9226-1-schmitzmic@gmail.com>
 <20230818234903.9226-2-schmitzmic@gmail.com>
 <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Geert,

On 21/08/23 19:50, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Sat, Aug 19, 2023 at 1:49 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
>> with pata_falcon and falconide"), the Q40 IDE driver was
>> replaced by pata_falcon.c.
>>
>> Both IO and memory resources were defined for the Q40 IDE
>> platform device, but definition of the IDE register addresses
>> was modeled after the Falcon case, both in use of the memory
>> resources and in including register scale and byte vs. word
>> offset in the address.
>>
>> This was correct for the Falcon case, which does not apply
>> any address translation to the register addresses. In the
>> Q40 case, all of device base address, byte access offset
>> and register scaling is included in the platform specific
>> ISA access translation (in asm/mm_io.h).
>>
>> As a consequence, such address translation gets applied
>> twice, and register addresses are mangled.
>>
>> Use the device base address from the platform IO resource,
>> and use standard register offsets from that base in order
>> to calculate register addresses (the IO address translation
>> will then apply the correct ISA window base and scaling).
>>
>> Encode PIO_OFFSET into IO port addresses for all registers
>> except the data transfer register. Encode the MMIO offset
>> there (pata_falcon_data_xfer() directly uses raw IO with
>> no address translation).
>>
>> Reported-by: William R Sowerbutts <will@sowerbutts.com>
>> Closes: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
>> Link: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
>> Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
>> Cc: stable@vger.kernel.org
>> Cc: Finn Thain <fthain@linux-m68k.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Tested-by: William R Sowerbutts <will@sowerbutts.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Thanks for the update!
>
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>          ap->pio_mask = ATA_PIO4;
>>          ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>>
>> -       base = (void __iomem *)base_mem_res->start;
>>          /* N.B. this assumes data_addr will be used for word-sized I/O only */
>> -       ap->ioaddr.data_addr            = base + 0 + 0 * 4;
>> -       ap->ioaddr.error_addr           = base + 1 + 1 * 4;
>> -       ap->ioaddr.feature_addr         = base + 1 + 1 * 4;
>> -       ap->ioaddr.nsect_addr           = base + 1 + 2 * 4;
>> -       ap->ioaddr.lbal_addr            = base + 1 + 3 * 4;
>> -       ap->ioaddr.lbam_addr            = base + 1 + 4 * 4;
>> -       ap->ioaddr.lbah_addr            = base + 1 + 5 * 4;
>> -       ap->ioaddr.device_addr          = base + 1 + 6 * 4;
>> -       ap->ioaddr.status_addr          = base + 1 + 7 * 4;
>> -       ap->ioaddr.command_addr         = base + 1 + 7 * 4;
>> -
>> -       base = (void __iomem *)ctl_mem_res->start;
>> -       ap->ioaddr.altstatus_addr       = base + 1;
>> -       ap->ioaddr.ctl_addr             = base + 1;
>> -
>> -       ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
>> -                     (unsigned long)base_mem_res->start,
>> -                     (unsigned long)ctl_mem_res->start);
>> +       ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
>> +
>> +       if (base_res) {         /* only Q40 has IO resources */
>> +               io_offset = 0x10000;
>> +               reg_scale = 1;
>> +               base = (void __iomem *)base_res->start;
>> +               ctl_base = (void __iomem *)ctl_res->start;
>> +
>> +               ata_port_desc(ap, "cmd %pa ctl %pa",
>> +                             &base_res->start,
>> +                             &ctl_res->start);
> This can be  moved outside the else, using %px to format base and
> ctl_base.

Right - do we need some additional message spelling out what address Q40 
uses for data transfers? (Redundant for Falcon, of course ...)

Though that could be handled outside the else, too:

ata_port_desc(ap, "cmd %px ctl %px data %pa",
               base, ctl_base, &ap->ioaddr.data_addr);

Cheers,

     Michael

>> +       } else {
>> +               base = (void __iomem *)base_mem_res->start;
>> +               ctl_base = (void __iomem *)ctl_mem_res->start;
>> +
>> +               ata_port_desc(ap, "cmd %pa ctl %pa",
>> +                             &base_mem_res->start,
>> +                             &ctl_mem_res->start);
>> +       }
> Gr{oetje,eeting}s,
>
>                          Geert
>
