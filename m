Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84FC7864F6
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 03:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbjHXB4q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 21:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbjHXB4j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 21:56:39 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0312C;
        Wed, 23 Aug 2023 18:56:37 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-570e005c480so2033811eaf.0;
        Wed, 23 Aug 2023 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692842196; x=1693446996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDemwXq/DdkqOc6ex+LY3QeGlo1RMV+Rv38vQP7YGLw=;
        b=l9PgHKs80qxZuGEkczdT46PKEnNf6zOFG6vOaKS/FYoORUJ6S/iVsCk0dFaTo3UMZB
         r5Yb0gwUOAae+gxnLzhSgnkydne4jAmU0E7POufV+ABBZWE/X1haxtkKMY/fZYDtxQ90
         +0KSc3Vo9y0Br6h6jXBN6Ue9hkTY4qflR9tweFAp1Nznpxsinp5KHc3XmuwiQsKKkZeF
         CRZXGYsy4b9rpiT9835WgYvUL/Gx/T9YIowdZeu9RG+xL1HPkq1JmpAzoLp+NYMspJA3
         vnMqgzP48luoYN8XDm5SlWc9+HS+zweDxVMKSukwr/TEISOejcQ1hRNMKYuVYSnbQSIe
         i9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692842196; x=1693446996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDemwXq/DdkqOc6ex+LY3QeGlo1RMV+Rv38vQP7YGLw=;
        b=Ee9GaR2Zs5FVsg4h+eq52ShX8zsiUY9VMbV2x0yNKQWlPQ5IJeRKJFMJiBzD6ZvuxD
         6ZG9A+X9h8IYzkJmuAHdHiARzuvEsirSeMDq4/2pIU5EROzEvwUj1OAHznRoRkOEQMXR
         GpcJ7wFIGMb3TTI8daR7MkSSbLElJi3cJBmiiqUdjL5LL2Rp81+pcSeH0lP8pviWuLJx
         XnWflN9buCpsa44Jz4vc/ADUK+FV05q7UHs+y20gSgol9iFblr6otIRY4m4AKfSw0h6I
         27NouZbiQZcaOqpB//0MUFDCcqs5h9XxY3oizJa6IW/MCr5CWKmaQpbpoZ2cwDEuRpdy
         /o/Q==
X-Gm-Message-State: AOJu0Yzm/nj12MJbLVY+VxkZaFjeL6ocuJD7c8OEb4jG8DVMBFhM6kSG
        n6Ayed75E4+HCUUXOznnGzc=
X-Google-Smtp-Source: AGHT+IFUKmgrpdpeGUDx3EBNOtgzTwqPNYJBfzDKpSBL9gpyrnReSV5h9ilTACyGbQN6y4BEEwMy3A==
X-Received: by 2002:a05:6358:704:b0:129:c477:289c with SMTP id e4-20020a056358070400b00129c477289cmr15330696rwj.26.1692842196598;
        Wed, 23 Aug 2023 18:56:36 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:34d2:df92:ba7c:a2e2? ([2001:df0:0:200c:34d2:df92:ba7c:a2e2])
        by smtp.gmail.com with ESMTPSA id p8-20020a63ab08000000b005642a68a508sm10485090pgf.35.2023.08.23.18.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 18:56:36 -0700 (PDT)
Message-ID: <0d490219-a0e2-94d9-4427-39c151fb90b5@gmail.com>
Date:   Thu, 24 Aug 2023 13:56:29 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] ata: pata_falcon: fix IO base selection for Q40
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
 <20230822221359.31024-2-schmitzmic@gmail.com>
 <34db6315-ed69-6775-efc1-97a351198713@omp.ru>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <34db6315-ed69-6775-efc1-97a351198713@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Sergey,

On 24/08/23 04:05, Sergey Shtylyov wrote:
> Hello!
>
>     I prefer CCing my OMP account when you send the PATA patches,
> as is returned by scripts/get_maintainer.pl...
Sorry, I was left with the impression OMP was rejecting list messages 
from linux-ide ...
>
> On 8/23/23 1:13 AM, Michael Schmitz wrote:
>
>> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
>> with pata_falcon and falconide"), the Q40 IDE driver was
>> replaced by pata_falcon.c.
>>
>> Both IO and memory resources were defined for the Q40 IDE
>> platform device, but definition of the IDE register addresses
>> was modeled after the Falcon case, both in use of the memory
>> resources and in including register shift and byte vs. word
>> offset in the address.
>>
>> This was correct for the Falcon case, which does not apply
>> any address translation to the register addresses. In the
>> Q40 case, all of device base address, byte access offset
>> and register shift is included in the platform specific
>> ISA access translation (in asm/mm_io.h).
>>
>> As a consequence, such address translation gets applied
>> twice, and register addresses are mangled.
>>
>> Use the device base address from the platform IO resource
>> for Q40 (the IO address translation will then add the correct
>> ISA window base address and byte access offset), with register
>> shift 1. Use MMIO base address and register shift 2 as before
>> for Falcon.
>>
>> Encode PIO_OFFSET into IO port addresses for all registers
>> for Q40 except the data transfer register. Encode the MMIO
>> offset there (pata_falcon_data_xfer() directly uses raw IO
>> with no address translation).
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
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> [...]
>
>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>> index 996516e64f13..3841ea200bcb 100644
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
> [...]
>> @@ -165,26 +165,34 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>   	ap->pio_mask = ATA_PIO4;
>>   	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>>   
>> -	base = (void __iomem *)base_mem_res->start;
>>   	/* N.B. this assumes data_addr will be used for word-sized I/O only */
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
>> +		reg_shift = 0;
>> +		base = (void __iomem *)base_res->start;
>> +		ctl_base = (void __iomem *)ctl_res->start;
>> +	} else {
>> +		base = (void __iomem *)base_mem_res->start;
>> +		ctl_base = (void __iomem *)ctl_mem_res->start;
>> +	}
>> +
>> +	ap->ioaddr.error_addr	= base + io_offset + (1 << reg_shift);
>> +	ap->ioaddr.feature_addr	= base + io_offset + (1 << reg_shift);
>> +	ap->ioaddr.nsect_addr	= base + io_offset + (2 << reg_shift);
>> +	ap->ioaddr.lbal_addr	= base + io_offset + (3 << reg_shift);
>> +	ap->ioaddr.lbam_addr	= base + io_offset + (4 << reg_shift);
>> +	ap->ioaddr.lbah_addr	= base + io_offset + (5 << reg_shift);
>> +	ap->ioaddr.device_addr	= base + io_offset + (6 << reg_shift);
>> +	ap->ioaddr.status_addr	= base + io_offset + (7 << reg_shift);
>> +	ap->ioaddr.command_addr	= base + io_offset + (7 << reg_shift);
>> +
>> +	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
>> +	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>> +
>> +	ata_port_desc(ap, "cmd %px ctl %px data %pa",
>> +		      base, ctl_base, &ap->ioaddr.data_addr);
>     Like Geert said, use "%px" and ap->ioaddr.data_addr here...

Will do.

Cheers,

     Michael

>
> [...]
>
> MBR, Sergey
