Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA036FB167
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjEHNZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHNZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 09:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D59383
        for <stable@vger.kernel.org>; Mon,  8 May 2023 06:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F80639DC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 13:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92E6C433D2;
        Mon,  8 May 2023 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683552314;
        bh=xNoSJkBze9zmRIp6cBsfukeWzToDTAhsz0GIxBWHwDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9NF0L0+jG+zuf8GMwiCnTpL925Y6PByTdhs4795j50bxKw+uWi/uuDMJw2btmWsQ
         LFkaE9AI/4Kl45idyexQ/unE7KOUHeoizMTLogU1fecDMFCxVFxepb3DWygSVir/xL
         EcnskRR59pGcw0IgERFul0X/2iaftvsTaryBq+IY=
Date:   Mon, 8 May 2023 15:25:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 455/611] spi: bcm63xx: remove PM_SLEEP based
 conditional compilation
Message-ID: <2023050845-pancreas-postage-5769@gregkh>
References: <20230508094421.513073170@linuxfoundation.org>
 <20230508094436.944529030@linuxfoundation.org>
 <0138fb50-507d-bccf-40bb-07340f3cbb33@ti.com>
 <2023050808-overbite-dancing-53c5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023050808-overbite-dancing-53c5@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023 at 03:15:15PM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 08, 2023 at 05:55:50PM +0530, Dhruva Gole wrote:
> > Hi Greg,
> > 
> > On 08/05/23 15:14, Greg Kroah-Hartman wrote:
> > > From: Dhruva Gole <d-gole@ti.com>
> > > 
> > > [ Upstream commit 25f0617109496e1aff49594fbae5644286447a0f ]
> > > 
> > > Get rid of conditional compilation based on CONFIG_PM_SLEEP because
> > > it may introduce build issues with certain configs where it maybe disabled
> > > This is because if above config is not enabled the suspend-resume
> > > functions are never part of the code but the bcm63xx_spi_pm_ops struct
> > > still inits them to non-existent suspend-resume functions.
> > > 
> > > Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
> > > 
> > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > Link: https://lore.kernel.org/r/20230420121615.967487-1-d-gole@ti.com
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >   drivers/spi/spi-bcm63xx.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> > > index 80fa0ef8909ca..0324ab3ce1c84 100644
> > > --- a/drivers/spi/spi-bcm63xx.c
> > > +++ b/drivers/spi/spi-bcm63xx.c
> > > @@ -630,7 +630,6 @@ static int bcm63xx_spi_remove(struct platform_device *pdev)
> > >   	return 0;
> > >   }
> > > -#ifdef CONFIG_PM_SLEEP
> > >   static int bcm63xx_spi_suspend(struct device *dev)
> > >   {
> > >   	struct spi_master *master = dev_get_drvdata(dev);
> > > @@ -657,7 +656,6 @@ static int bcm63xx_spi_resume(struct device *dev)
> > >   	return 0;
> > >   }
> > > -#endif
> > 
> > This patch may cause build failures with some of the configs that disable
> > CONFIG_PM I understand,
> > So to fix that I had sent another patch:
> > https://lore.kernel.org/all/CAOiHx==anPTqXNJNG7zap1XP2zKUp5SbaVJdyUsUvvitKRUHZw@mail.gmail.com/
> > 
> > However missed out adding the fixes tag.
> > 
> > I humbly request you to add
> > https://lore.kernel.org/all/20230424102546.1604484-1-d-gole@ti.com/
> > 
> > this patch to fix this patch throughout the stable fixes trees.
> > 
> > It can also be found on Linus' master branch here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-bcm63xx.c?id=cc5f6fa4f6590e3b9eb8d34302ea43af4a3cfed7
> > >   static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
> > >   	SET_SYSTEM_SLEEP_PM_OPS(bcm63xx_spi_suspend, bcm63xx_spi_resume)
> 
> Sure, now queued up, thanks!


Nope, sorry, that broke the build in many places, so I've dropped it now
from kernels 5.15.y and older.

thanks,

greg k-h
