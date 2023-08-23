Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC96785CF7
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjHWQFS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbjHWQFS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 12:05:18 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD93E71;
        Wed, 23 Aug 2023 09:05:14 -0700 (PDT)
Received: from [192.168.1.103] (178.176.72.129) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 23 Aug
 2023 19:05:10 +0300
Subject: Re: [PATCH v4 1/2] ata: pata_falcon: fix IO base selection for Q40
To:     Michael Schmitz <schmitzmic@gmail.com>, <dlemoal@kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-m68k@vger.kernel.org>
CC:     <will@sowerbutts.com>, <rz@linux-m68k.org>, <geert@linux-m68k.org>,
        <stable@vger.kernel.org>, Finn Thain <fthain@linux-m68k.org>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
 <20230822221359.31024-2-schmitzmic@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <34db6315-ed69-6775-efc1-97a351198713@omp.ru>
Date:   Wed, 23 Aug 2023 19:05:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230822221359.31024-2-schmitzmic@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.129]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 08/23/2023 15:38:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 179410 [Aug 23 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.129 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.129 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.129
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/23/2023 15:42:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/23/2023 2:00:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

   I prefer CCing my OMP account when you send the PATA patches,
as is returned by scripts/get_maintainer.pl...

On 8/23/23 1:13 AM, Michael Schmitz wrote:

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

[...]

> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 996516e64f13..3841ea200bcb 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
[...]
> @@ -165,26 +165,34 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ap->pio_mask = ATA_PIO4;
>  	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>  
> -	base = (void __iomem *)base_mem_res->start;
>  	/* N.B. this assumes data_addr will be used for word-sized I/O only */
> -	ap->ioaddr.data_addr		= base + 0 + 0 * 4;
> -	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
> -	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
> -	ap->ioaddr.nsect_addr		= base + 1 + 2 * 4;
> -	ap->ioaddr.lbal_addr		= base + 1 + 3 * 4;
> -	ap->ioaddr.lbam_addr		= base + 1 + 4 * 4;
> -	ap->ioaddr.lbah_addr		= base + 1 + 5 * 4;
> -	ap->ioaddr.device_addr		= base + 1 + 6 * 4;
> -	ap->ioaddr.status_addr		= base + 1 + 7 * 4;
> -	ap->ioaddr.command_addr		= base + 1 + 7 * 4;
> -
> -	base = (void __iomem *)ctl_mem_res->start;
> -	ap->ioaddr.altstatus_addr	= base + 1;
> -	ap->ioaddr.ctl_addr		= base + 1;
> -
> -	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> -		      (unsigned long)base_mem_res->start,
> -		      (unsigned long)ctl_mem_res->start);
> +	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
> +
> +	if (base_res) {		/* only Q40 has IO resources */
> +		io_offset = 0x10000;
> +		reg_shift = 0;
> +		base = (void __iomem *)base_res->start;
> +		ctl_base = (void __iomem *)ctl_res->start;
> +	} else {
> +		base = (void __iomem *)base_mem_res->start;
> +		ctl_base = (void __iomem *)ctl_mem_res->start;
> +	}
> +
> +	ap->ioaddr.error_addr	= base + io_offset + (1 << reg_shift);
> +	ap->ioaddr.feature_addr	= base + io_offset + (1 << reg_shift);
> +	ap->ioaddr.nsect_addr	= base + io_offset + (2 << reg_shift);
> +	ap->ioaddr.lbal_addr	= base + io_offset + (3 << reg_shift);
> +	ap->ioaddr.lbam_addr	= base + io_offset + (4 << reg_shift);
> +	ap->ioaddr.lbah_addr	= base + io_offset + (5 << reg_shift);
> +	ap->ioaddr.device_addr	= base + io_offset + (6 << reg_shift);
> +	ap->ioaddr.status_addr	= base + io_offset + (7 << reg_shift);
> +	ap->ioaddr.command_addr	= base + io_offset + (7 << reg_shift);
> +
> +	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
> +	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
> +
> +	ata_port_desc(ap, "cmd %px ctl %px data %pa",
> +		      base, ctl_base, &ap->ioaddr.data_addr);

   Like Geert said, use "%px" and ap->ioaddr.data_addr here...

[...]

MBR, Sergey
