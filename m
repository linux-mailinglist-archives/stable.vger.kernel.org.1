Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0812781B8E
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjHTALF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 19 Aug 2023 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHTAKn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 19 Aug 2023 20:10:43 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E821201;
        Sat, 19 Aug 2023 13:29:25 -0700 (PDT)
Received: from [192.168.1.103] (178.176.78.25) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 19 Aug
 2023 23:29:21 +0300
Subject: Re: [PATCH 1/3] m68k/q40: fix IO base selection for Q40 in
 pata_falcon.c
To:     Michael Schmitz <schmitzmic@gmail.com>,
        <linux-ide@vger.kernel.org>, <linux-m68k@vger.kernel.org>
CC:     <will@sowerbutts.com>, <rz@linux-m68k.org>, <geert@linux-m68k.org>,
        <stable@vger.kernel.org>, Finn Thain <fthain@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-2-schmitzmic@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <82f37617-949b-bcfa-8531-c0a9790aaf48@omp.ru>
Date:   Sat, 19 Aug 2023 23:29:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230817221232.22035-2-schmitzmic@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.78.25]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 08/19/2023 20:10:14
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 179337 [Aug 18 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.25 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.25 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.25
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/19/2023 20:13:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/19/2023 5:17:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On 8/18/23 1:12 AM, Michael Schmitz wrote:

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
> Cc: <stable@vger.kernel.org> # 5.14
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]
> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 996516e64f13..346259e3bbc8 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	struct resource *base_res, *ctl_res, *irq_res;
>  	struct ata_host *host;
>  	struct ata_port *ap;
> -	void __iomem *base;
> -	int irq = 0;
> +	void __iomem *base, *ctl_base;
> +	int irq = 0, io_offset = 1, reg_scale = 4;

   Maybe reg_step?

[...]

MBR, Sergey
