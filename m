Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FB7802CB
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 02:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356662AbjHRAmw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 20:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356755AbjHRAmc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 20:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5F2D67;
        Thu, 17 Aug 2023 17:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4744A62024;
        Fri, 18 Aug 2023 00:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11CBC433C7;
        Fri, 18 Aug 2023 00:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692319350;
        bh=lqPhcmZdU378XL1xiL/op1vF3k5fYX3kUjV/ZYwwFC8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=t1lVX0VxOVASifoeaANRHQrLcDOgsgqDPfXaBjAE2/asiCHgQUoiX6Lgnw8O8KnyR
         9HdWr/ow2HKE7Hv3sZe2fjBoakqg5KFt7yY9fsiixdHEa5/vO8tv1x8DBk+k8kepbU
         vpnW7O0YU6iPofRle0IOmwFI8X3agfZFzoa2+iMbTM7l732PSF5qXYP0pOdcGisG/M
         6ppwSDRcu1LmTSvOYwlks/ZSbMtiXEtzP2gZLt01CO+RA5/mj3OEKI7NcshE/JiV9x
         oaoV3Uhu+cho7br9oLIyJqreqEQCjThaJB0JRgOSdJsYCi+RmKy2X4eJw2mShIjKQY
         6HjQ6r318+L2g==
Message-ID: <ca753d89-ad51-d901-4058-d974fea7e658@kernel.org>
Date:   Fri, 18 Aug 2023 09:42:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] m68k/q40: fix IO base selection for Q40 in
 pata_falcon.c
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>, s.shtylyov@omp.ru,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-2-schmitzmic@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230817221232.22035-2-schmitzmic@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023/08/18 7:12, Michael Schmitz wrote:
> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
> with pata_falcon and falconide"), the Q40 IDE driver was
> replaced by pata_falcon.c.

Please change the patch title to:

ata: pata_falcon: fix IO base selection for Q40

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

5.14+ ? But I do not think you need to specify anything anyway since you have
the Fixes tag.

> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> ---
> 
> Changes from RFC v3:
> 
> - split off byte swap option into separate patch
> 
> Geert Uytterhoeven:
> - review comments
> 
> Changes from RFC v2:
> - add driver parameter 'data_swap' as bit mask for drives to swap
> 
> Changes from RFC v1:
> 
> Finn Thain:
> - take care to supply IO address suitable for ioread8/iowrite8
> - use MMIO address for data transfer
> ---
>  drivers/ata/pata_falcon.c | 55 ++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
> 
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
>  
>  	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
>  
> @@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
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
> +		reg_scale = 1;
> +		base = (void __iomem *)base_res->start;
> +		ctl_base = (void __iomem *)ctl_res->start;
> +
> +		ata_port_desc(ap, "cmd %pa ctl %pa",
> +			      &base_res->start,
> +			      &ctl_res->start);
> +	} else {
> +		base = (void __iomem *)base_mem_res->start;
> +		ctl_base = (void __iomem *)ctl_mem_res->start;
> +
> +		ata_port_desc(ap, "cmd %pa ctl %pa",
> +			      &base_mem_res->start,
> +			      &ctl_mem_res->start);
> +	}
> +
> +	ap->ioaddr.error_addr	= base + io_offset + 1 * reg_scale;
> +	ap->ioaddr.feature_addr	= base + io_offset + 1 * reg_scale;
> +	ap->ioaddr.nsect_addr	= base + io_offset + 2 * reg_scale;
> +	ap->ioaddr.lbal_addr	= base + io_offset + 3 * reg_scale;
> +	ap->ioaddr.lbam_addr	= base + io_offset + 4 * reg_scale;
> +	ap->ioaddr.lbah_addr	= base + io_offset + 5 * reg_scale;
> +	ap->ioaddr.device_addr	= base + io_offset + 6 * reg_scale;
> +	ap->ioaddr.status_addr	= base + io_offset + 7 * reg_scale;
> +	ap->ioaddr.command_addr	= base + io_offset + 7 * reg_scale;
> +
> +	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
> +	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>  
>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (irq_res && irq_res->start > 0) {

-- 
Damien Le Moal
Western Digital Research

