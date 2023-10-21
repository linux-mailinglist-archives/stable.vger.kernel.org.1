Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5177D1BD7
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJUI74 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJUI7z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 04:59:55 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Oct 2023 01:59:50 PDT
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEC16D71
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 01:59:50 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id u7iPq7tspMEM0u7iPqRk9P; Sat, 21 Oct 2023 10:52:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697878338;
        bh=GxQB0k3jsJwtA2JiUZnn8f7IQsmdbKwWjelgZ0513b4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dO3VaNU+B2+6QtEwZShNAsFLzts7aZjyx7crZ7/Ka3CpZn6/H1/Qfqira844sWYeA
         Vgsl2np8bBoKYTcWugnM+lHC4vnhejlHQOr9EYA9J+vrQF9Ks+1a3mcGH/dDlAj2TM
         lQ0m6R5cNB2r99mQjnqzC444G2d5v4MFam7vGfQerMuVTkL1DY00fp9wPBRPP/kte6
         LKnmNHPL+DbY8AMtK9fdpMUOGnyoIHEp1NzDDO6RmpY7xeI5nO4V76zhoEkJqtCbfp
         9SYYsFLwq1bIhdkLjt3Yo8aoKXJuotlST0n1eyAhJqBhozTjpRyYLsmp5i16JLFdW7
         5dEYqCddS1cIg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Oct 2023 10:52:18 +0200
X-ME-IP: 86.243.2.178
Message-ID: <203646d1-7dc9-436d-a556-ea2861ac3d4c@wanadoo.fr>
Date:   Sat, 21 Oct 2023 10:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ice: Remove useless DMA-32 fallback configuration" has
 been added to the 5.15-stable tree
Content-Language: fr, en-US
To:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20231021002330.1609939-1-sashal@kernel.org>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231021002330.1609939-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Le 21/10/2023 à 02:23, Sasha Levin a écrit :
> This is a note to let you know that I've just added the patch titled
>
>      ice: Remove useless DMA-32 fallback configuration
>
> to the 5.15-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       ice-remove-useless-dma-32-fallback-configuration.patch
> and it can be found in the queue-5.15 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Why is it needed for backport, it is only dead code.

Another patch depends on it?

Looking *quickly* in other patches at [1], I've not seen anything that 
conflicts.

CJ


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=ea20ae5ac61b1af9c12d4cb5292920136a683199

>
>
> commit 6f77725babf0559f90f19df76ff71f7807dff67f
> Author: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Date:   Sun Jan 9 19:25:05 2022 +0100
>
>      ice: Remove useless DMA-32 fallback configuration
>      
>      [ Upstream commit 9c3e54a632637f27d98fb0ec0c44f7039925809d ]
>      
>      As stated in [1], dma_set_mask() with a 64-bit mask never fails if
>      dev->dma_mask is non-NULL.
>      So, if it fails, the 32 bits case will also fail for the same reason.
>      
>      Simplify code and remove some dead code accordingly.
>      
>      [1]: https://lkml.org/lkml/2021/6/7/398
>      
>      Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      Reviewed-by: Christoph Hellwig <hch@lst.de>
>      Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>      Tested-by: Gurucharan G <gurucharanx.g@intel.com>
>      Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>      Stable-dep-of: 0288c3e709e5 ("ice: reset first in crash dump kernels")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 691c4320b6b1d..4aad089ea1f5d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4292,8 +4292,6 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>   
>   	/* set up for high or low DMA */
>   	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> -	if (err)
> -		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>   	if (err) {
>   		dev_err(dev, "DMA configuration failed: 0x%x\n", err);
>   		return err;
