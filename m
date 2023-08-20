Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8076781F7D
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 21:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjHTTXf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjHTTXb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 15:23:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB753A9F;
        Sun, 20 Aug 2023 12:19:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-689f9576babso1651208b3a.0;
        Sun, 20 Aug 2023 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692559165; x=1693163965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riEdQ0/KKB8twEGcsiHLnyZVpKYp4ho0euYIivvuAIY=;
        b=cxLPLE7u0Ylld8wA/0I3+jEST8LVhjjyB0LcDL2tVOtgdD8L2K9ZqiTs58XQLZFKYB
         cajdF5ULyfqGBeyBQwkuDl3h95WgYahHpMy5nWLb0e2gohLM5zVVjYkvAaM5wK0OF5ZZ
         867Xeu2pwjobxrG41Wcd7/pOQVQ1M8FKsUXebc8cVJiA5cV/3sAYWNvlMZ6hciHG3mPE
         6StrSVrz1W6pmaV5o0MkBMoHwVbTCuDQjfJMBUpTdU8btjUA5b938sJpoKCZvlDW2E5P
         QQAKGGbr68JkjobZeAsmp8N56u1m8YTtu42GCqCTLTbbcTUBgZBKbF8f010JQsA3xKit
         prPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692559165; x=1693163965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riEdQ0/KKB8twEGcsiHLnyZVpKYp4ho0euYIivvuAIY=;
        b=TLemFGExKooq3kxjjaKUXf9UssSlYOVa+CHJUDOcPn8Q1AWJVU5dXw4kZgYcqbGxfT
         ZzUKScKTmQOr/M6O4+CB6wOYJSEaGpx2VrZqEowu/QQ2Yi00pP9ABhxK1CPRGAkAo/mr
         +SudUygxea2cbQetOI+Yj2wWeTn4iEAjbLlIRv8I9VbxcF/LlCf5o4pyLVifOjUgBiZs
         kd9ByU3JvirxdEOmAJIDX7ouUT69K8lBzlSek77tddjy9UTkt8cHyxWqgax1JyeBYKPY
         8AeRyvf83PG9OfMtlRn/7OCn0lNeXw5Sgr6RzsghY93YznhpXalVAa2epnKUP4kFNmKc
         aauA==
X-Gm-Message-State: AOJu0YxDderG+2u7WJU7MfAtVXwRF/cfaRjrAgQgHe5JZ4u55k2tdxmL
        /+orBK3kPhAYZwKDmeW91ncEVpsK3SU=
X-Google-Smtp-Source: AGHT+IFm3UbuhUJOjChLtp2eL8rSOxfb/1jKxZkbqV38LsWUwGEJkesyIZhltc1mJ8M1UwSC6i+wPg==
X-Received: by 2002:a05:6a00:1590:b0:672:264c:e8cf with SMTP id u16-20020a056a00159000b00672264ce8cfmr3940593pfk.7.1692559165268;
        Sun, 20 Aug 2023 12:19:25 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:fc82:cbbc:8740:8921? ([2001:df0:0:200c:fc82:cbbc:8740:8921])
        by smtp.gmail.com with ESMTPSA id u16-20020a62ed10000000b00682669dc19bsm4675216pfh.201.2023.08.20.12.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 12:19:24 -0700 (PDT)
Message-ID: <3afffc69-62a3-2a11-0c22-8301300e0d50@gmail.com>
Date:   Mon, 21 Aug 2023 07:19:16 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] m68k/q40: fix IO base selection for Q40 in
 pata_falcon.c
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-2-schmitzmic@gmail.com>
 <82f37617-949b-bcfa-8531-c0a9790aaf48@omp.ru>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <82f37617-949b-bcfa-8531-c0a9790aaf48@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Sergey,

thanks for your review!

On 20/08/23 08:29, Sergey Shtylyov wrote:
> Hello!
>
> On 8/18/23 1:12 AM, Michael Schmitz wrote:
>
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
>> Cc: <stable@vger.kernel.org> # 5.14
>> Cc: Finn Thain <fthain@linux-m68k.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> [...]
>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>> index 996516e64f13..346259e3bbc8 100644
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>   	struct resource *base_res, *ctl_res, *irq_res;
>>   	struct ata_host *host;
>>   	struct ata_port *ap;
>> -	void __iomem *base;
>> -	int irq = 0;
>> +	void __iomem *base, *ctl_base;
>> +	int irq = 0, io_offset = 1, reg_scale = 4;
>     Maybe reg_step?

Could name it that, too. I can't recall where I picked up the term 
'register scaling'...

I'll see what's the consensus (if any) in drivers/.

Cheers,

     Michael


>
> [...]
>
> MBR, Sergey
