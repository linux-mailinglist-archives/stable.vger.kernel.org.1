Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23DC7803FA
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 04:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357332AbjHRCxc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 22:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357375AbjHRCxY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 22:53:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08F3A9F;
        Thu, 17 Aug 2023 19:53:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bda9207132so3985125ad.0;
        Thu, 17 Aug 2023 19:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692327200; x=1692932000;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFdQg13s6mOpRmarJ14t6fkWGA8UwDkTquU8FxA9ysA=;
        b=aRqotHA0wr4M0Lw6hXieDga90ZQ2DD8n/tzkqbfi73XLR+xsZ4jBqXi1lqh13bz74y
         sOfWD9qqQa5S8wUS+2JHiPWmxQxugCNGHziqUwidVdZRLhxersGv0oiX2k6sd7NEBmxZ
         PKzTPDjNPacyhA306i8TiGXhpNUvO6ZLQjCNGkWcD2Lax2d2r2h2+SQuCWb13gJTqU5E
         E3ofIC3p6g7ZUHMkpwduG2KtWl9HH3E902krBO8VNR96goGrBouxBh9NSO15w6QOHhJ4
         uL6CJdopRIYhkEPP46pLtbxRxfw7oQi3stxbQb7G3LhkDt+WCyIoxr4XGajs+sVU21dy
         aPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327200; x=1692932000;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rFdQg13s6mOpRmarJ14t6fkWGA8UwDkTquU8FxA9ysA=;
        b=BMjCWNrvq3DQrGJPrxWE7CNb3wM0ikXOtLcPeaGFjwRVArF4HJjBiE9oRCgJNkAJOK
         qHu8mW+SDmVqhDvvTUqY/GTBYUIAPmAkVRD4bq2YCzukNLKS31LlZb3NkwytQgi4kape
         dIcxz5jwKuVVagVZTLN8pTi5/IDgInIUmqza1zgNrzq8fq1LN9Yp1SmE09K3z0rCK3HM
         7dcMozFgt0BPpq7ahMhRcv+gvzp9yUubiPuVQ9NyheXNp/IpuWEsGmvapYFVTZvNTtrK
         ERVzyKgTJmweY3R3PWibWSpizC6Pr9N+j82KndfKAt8TAUOpjt5KfxL+rgrPH4iN0I2g
         IJpA==
X-Gm-Message-State: AOJu0Yw7LjzmXtbZJt+WPbkH0ZFL+30hvMbYhiEDP2S4DhbjODNye+Ka
        8R/sOU/ZlCdUOrKescjEIjk=
X-Google-Smtp-Source: AGHT+IF0dwAX5/39BBQ385fDjAoDX09nzBFXSGG+umy2zqP1kXboGx0OOs28gSq78GmWjZC5dPfUGw==
X-Received: by 2002:a17:903:11c4:b0:1bb:9b48:ea94 with SMTP id q4-20020a17090311c400b001bb9b48ea94mr1408013plh.32.1692327200107;
        Thu, 17 Aug 2023 19:53:20 -0700 (PDT)
Received: from [10.1.1.24] (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902ea9300b001b8b0ac2258sm485010plb.174.2023.08.17.19.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 19:53:19 -0700 (PDT)
Subject: Re: [PATCH 1/3] m68k/q40: fix IO base selection for Q40 in
 pata_falcon.c
To:     Damien Le Moal <dlemoal@kernel.org>, s.shtylyov@omp.ru,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-2-schmitzmic@gmail.com>
 <ca753d89-ad51-d901-4058-d974fea7e658@kernel.org>
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a75c21bc-c776-cf19-a5b2-9163af035d65@gmail.com>
Date:   Fri, 18 Aug 2023 14:53:09 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <ca753d89-ad51-d901-4058-d974fea7e658@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Damien,

thanks for your review!

Am 18.08.2023 um 12:42 schrieb Damien Le Moal:
> On 2023/08/18 7:12, Michael Schmitz wrote:
>> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
>> with pata_falcon and falconide"), the Q40 IDE driver was
>> replaced by pata_falcon.c.
>
> Please change the patch title to:
>
> ata: pata_falcon: fix IO base selection for Q40

Will do.

>
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
>> Cc: <stable@vger.kernel.org> # 5.14
>
> 5.14+ ? But I do not think you need to specify anything anyway since you have
> the Fixes tag.

5.14+ perhaps. I'll check the docs again to see whether Fixes: obsoletes 
the stable backport tag. I've so far used both together...

Cheers,

	Michael


>
>> Cc: Finn Thain <fthain@linux-m68k.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>
>> ---
>>
>> Changes from RFC v3:
>>
>> - split off byte swap option into separate patch
>>
>> Geert Uytterhoeven:
>> - review comments
>>
>> Changes from RFC v2:
>> - add driver parameter 'data_swap' as bit mask for drives to swap
>>
>> Changes from RFC v1:
>>
>> Finn Thain:
>> - take care to supply IO address suitable for ioread8/iowrite8
>> - use MMIO address for data transfer
>> ---
>>  drivers/ata/pata_falcon.c | 55 ++++++++++++++++++++++++---------------
>>  1 file changed, 34 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>> index 996516e64f13..346259e3bbc8 100644
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	struct resource *base_res, *ctl_res, *irq_res;
>>  	struct ata_host *host;
>>  	struct ata_port *ap;
>> -	void __iomem *base;
>> -	int irq = 0;
>> +	void __iomem *base, *ctl_base;
>> +	int irq = 0, io_offset = 1, reg_scale = 4;
>>
>>  	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
>>
>> @@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	ap->pio_mask = ATA_PIO4;
>>  	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>>
>> -	base = (void __iomem *)base_mem_res->start;
>>  	/* N.B. this assumes data_addr will be used for word-sized I/O only */
>> -	ap->ioaddr.data_addr		= base + 0 + 0 * 4;
>> -	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
>> -	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
>> -	ap->ioaddr.nsect_addr		= base + 1 + 2 * 4;
>> -	ap->ioaddr.lbal_addr		= base + 1 + 3 * 4;
>> -	ap->ioaddr.lbam_addr		= base + 1 + 4 * 4;
>> -	ap->ioaddr.lbah_addr		= base + 1 + 5 * 4;
>> -	ap->ioaddr.device_addr		= base + 1 + 6 * 4;
>> -	ap->ioaddr.status_addr		= base + 1 + 7 * 4;
>> -	ap->ioaddr.command_addr		= base + 1 + 7 * 4;
>> -
>> -	base = (void __iomem *)ctl_mem_res->start;
>> -	ap->ioaddr.altstatus_addr	= base + 1;
>> -	ap->ioaddr.ctl_addr		= base + 1;
>> -
>> -	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
>> -		      (unsigned long)base_mem_res->start,
>> -		      (unsigned long)ctl_mem_res->start);
>> +	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
>> +
>> +	if (base_res) {		/* only Q40 has IO resources */
>> +		io_offset = 0x10000;
>> +		reg_scale = 1;
>> +		base = (void __iomem *)base_res->start;
>> +		ctl_base = (void __iomem *)ctl_res->start;
>> +
>> +		ata_port_desc(ap, "cmd %pa ctl %pa",
>> +			      &base_res->start,
>> +			      &ctl_res->start);
>> +	} else {
>> +		base = (void __iomem *)base_mem_res->start;
>> +		ctl_base = (void __iomem *)ctl_mem_res->start;
>> +
>> +		ata_port_desc(ap, "cmd %pa ctl %pa",
>> +			      &base_mem_res->start,
>> +			      &ctl_mem_res->start);
>> +	}
>> +
>> +	ap->ioaddr.error_addr	= base + io_offset + 1 * reg_scale;
>> +	ap->ioaddr.feature_addr	= base + io_offset + 1 * reg_scale;
>> +	ap->ioaddr.nsect_addr	= base + io_offset + 2 * reg_scale;
>> +	ap->ioaddr.lbal_addr	= base + io_offset + 3 * reg_scale;
>> +	ap->ioaddr.lbam_addr	= base + io_offset + 4 * reg_scale;
>> +	ap->ioaddr.lbah_addr	= base + io_offset + 5 * reg_scale;
>> +	ap->ioaddr.device_addr	= base + io_offset + 6 * reg_scale;
>> +	ap->ioaddr.status_addr	= base + io_offset + 7 * reg_scale;
>> +	ap->ioaddr.command_addr	= base + io_offset + 7 * reg_scale;
>> +
>> +	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
>> +	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>>
>>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>  	if (irq_res && irq_res->start > 0) {
>
