Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA97824D5
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjHUHqU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjHUHqT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 03:46:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C0B5;
        Mon, 21 Aug 2023 00:46:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf5c314a57so4313555ad.1;
        Mon, 21 Aug 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692603976; x=1693208776;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLag0Z0HRE6pIAHnpxT0qgRuGZis2m6NT4juYzJgVHM=;
        b=et1cL7LdO+GBNyPQgA4GjDd2zZizCPvJG/l4gpLdo3uqjnX7Ef/C7RJ7EWm5qZSNJS
         Uh4ECT/G/Oxf7Tfdfq16pG+juUiMmP4bh+ANiRCaEo8cbAzIDkhH6C8LHFEHlM4wj1AM
         TRkMFD4BjUR8LSdRSMMWhhw/QB67pdVehdJMxrHnrNUv9y/OLg9uI/VB0ZOXFw5Xq47q
         85fZIeHMzhM99dK4RF2+gSG9SsjYJcEGGQrzKhd70JCdW7ChapFWATnwbcw69GuKo9Xi
         3urr7G5iRxBtVdrqN9JSMFXFT8KN5GXi4tjLLepsOJekcCUBwKctqP7aju+oRs+GgnVf
         oi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603976; x=1693208776;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLag0Z0HRE6pIAHnpxT0qgRuGZis2m6NT4juYzJgVHM=;
        b=Zy6k4jM9dePttN1vJcEzZSMSluzEPW9yCzf0N4dnP7JSr++0+cLlc3/xq+bOiF9qei
         mUY1xSrRarcL2DCzq6lojTz6x0M6Lmm0+33Z8QYNoUujTMVH6O9BzjfkZW5ONb1K0wvB
         InVn8WfbqtsjPd8RxupzfowEIVBrnlp0XLY47Htutkz+xTtZvP+eaP0Q4YNHtIjus7/5
         vghCZqP2wKMRuXTH3A0RHHfVWbdihZJxRsINAQJz7GgGjyzjoAMIzoqkDD985sEyx4ML
         POTI3srUeXkSFcKesrdvbw4OVSitGHDf6dFkNqnyN+mWjyFJ8tXeS2/4mVy8F4R5IYIT
         YIIQ==
X-Gm-Message-State: AOJu0Yxc/Axv9WLEOvHiCXytue4Xw8mhZlDb7upW6fTWiR0tJDX/Ggf+
        H4wigyVMWUHIXgHD+BzPfxg=
X-Google-Smtp-Source: AGHT+IEUnqYOnPAG6QcssE2jsng8EwAq1YOa/bDZ5Htjt2St/e6pHVugiiS6/LRej2ZgbnKhf4IXmA==
X-Received: by 2002:a17:902:e881:b0:1bd:c9cb:ffdc with SMTP id w1-20020a170902e88100b001bdc9cbffdcmr4636534plg.7.1692603976166;
        Mon, 21 Aug 2023 00:46:16 -0700 (PDT)
Received: from [10.1.1.24] (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c20a00b001a9b29b6759sm1247679pll.183.2023.08.21.00.46.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:46:15 -0700 (PDT)
Subject: Re: [PATCH 1/3] m68k/q40: fix IO base selection for Q40 in
 pata_falcon.c
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-2-schmitzmic@gmail.com>
 <82f37617-949b-bcfa-8531-c0a9790aaf48@omp.ru>
 <3afffc69-62a3-2a11-0c22-8301300e0d50@gmail.com>
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        Damien Le Moal <dlemoal@kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <f15858a3-de77-32fb-4854-521e2c18c4fd@gmail.com>
Date:   Mon, 21 Aug 2023 19:46:08 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <3afffc69-62a3-2a11-0c22-8301300e0d50@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Sergey,

Am 21.08.2023 um 07:19 schrieb Michael Schmitz:
>>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>>> index 996516e64f13..346259e3bbc8 100644
>>> --- a/drivers/ata/pata_falcon.c
>>> +++ b/drivers/ata/pata_falcon.c
>>> @@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct
>>> platform_device *pdev)
>>>       struct resource *base_res, *ctl_res, *irq_res;
>>>       struct ata_host *host;
>>>       struct ata_port *ap;
>>> -    void __iomem *base;
>>> -    int irq = 0;
>>> +    void __iomem *base, *ctl_base;
>>> +    int irq = 0, io_offset = 1, reg_scale = 4;
>>     Maybe reg_step?
>
> Could name it that, too. I can't recall where I picked up the term
> 'register scaling'...
>
> I'll see what's the consensus (if any) in drivers/.

I've seen some use of 'step' but mostly use of 'shift'.

Rewriting pata_falcon_init_one() to use register shift instead of 
register step is trivial, so unless anyone objects, I'll send that 
version as v4.

Cheers,

	Michael

>
> Cheers,
>
>     Michael
>
>
>>
>> [...]
>>
>> MBR, Sergey
