Return-Path: <stable+bounces-65971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD8394B31E
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 00:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D179B1F2380D
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B215099D;
	Wed,  7 Aug 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEGa2nht"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FF84037;
	Wed,  7 Aug 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070108; cv=none; b=XCnzPEfbbKSmE0FYqOCQHyXwbMCn28AsvM0J3px/m8XWLSt0kWYb/I2detg3cRCrE34Vs/BcM25TUONSj0JqcbczJh+3MkF8UngQZEKzqBLRF3bAbV2d5e66uQeob9wCuujiXedgv1Sbd6uGp2+n1dabASveplxG02D1FtgRM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070108; c=relaxed/simple;
	bh=4SW2koNLSR3UGJDCQ4tfaSCI1PPYQl+YNGBqJggCxkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilraU9e/cz3fYtA6PfXDaJc3wMJnj3TIe90njjQU1nbiPyxhezSoc+LrrJ+4EdTuKKOwD3sE8arkZxHwf3To27iRdbbXMoIUTvHQhUjJHk1ETTfohBMOdmZ/gx2F11VyVBjYXrfS8HHU2WZngxcM+EdpbPMs5RzGTHHPlpsVB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEGa2nht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2001FC4AF0D;
	Wed,  7 Aug 2024 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723070108;
	bh=4SW2koNLSR3UGJDCQ4tfaSCI1PPYQl+YNGBqJggCxkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEGa2nhtWx0OmR2n5WPnJGF7lXEYDWPQbd9goc340or6vClcv7BK8g+LXX5K7zMbm
	 7gTaJJ8GueY/qPpqV3LI6rPdh1sb9V818kNypu3NDb1MlunXw+/i98worzpGRUUy4O
	 jhpHTyuOR3zUiKUoKU+DTQyGfnVKaLlWHXaKl8V2bNClU9NDY/s89LdDt0qOZo8oNF
	 BLTgshL4skQl6QHFdslAxXtOFGYUfB0DpczeDbwAn5ciEjMXyfNDVhMO9DMFeQWF4e
	 eRlSqLrTFOFFnwckjRICPqfoFNnUC744CAYuS2wtbHhxTCynLgeVJSLPWTvdHVWZLF
	 RdiqgOdEPYXCA==
Date: Thu, 8 Aug 2024 00:35:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "tj@kernel.org" <tj@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Message-ID: <ZrP2lUjTAazBlUVO@x1-carbon.lan>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
 <Zp/Uh/mavwo+755Q@x1-carbon.lan>
 <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Fri, Aug 02, 2024 at 02:30:45AM +0000, Hongxing Zhu wrote:
> >
> > Does this solve your problem:
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 581704e61f28..fc86e2c8c42b 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -747,12 +747,11 @@ int ahci_platform_init_host(struct platform_device
> > *pdev,
> >                         ap->ops = &ata_dummy_port_ops;
> >         }
> >
> > -       if (hpriv->cap & HOST_CAP_64) {
> > -               rc = dma_coerce_mask_and_coherent(dev,
> > DMA_BIT_MASK(64));
> > -               if (rc) {
> > -                       dev_err(dev, "Failed to enable 64-bit DMA.\n");
> > -                       return rc;
> > -               }
> > +       rc = dma_coerce_mask_and_coherent(dev,
> > +                       DMA_BIT_MASK((hpriv->cap & HOST_CAP_64) ? 64 :
> > 32));
> > +       if (rc) {
> > +               dev_err(dev, "DMA enable failed\n");
> > +               return rc;
> >         }
> >
> >         rc = ahci_reset_controller(host);
> >
> Hi Niklas:
> I'm so sorry to reply late.
> About the 32bit DMA limitation of i.MX8QM AHCI SATA.
> It's seems that one "dma-ranges" property in the DT can let i.MX8QM SATA
>  works fine in my past days tests without this commit.
> How about drop these driver changes, and add "dma-ranges" for i.MX8QM SATA?
> Thanks a lot for your kindly help.

Hello Richard,

did you try my suggested patch above?


If you look at dma-ranges:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#dma-ranges

"dma-ranges" property should be used on a bus device node
(such as PCI host bridges).

It does not seem correct to add this property (describing the DMA limit
of the AHCI controller, a PCI endpoint) on the PCI host bridge/controller.

This property belongs to the AHCI controller, not the upstream PCI
host bridge/controller.

AHCI has a specific register to describe if the hardware can support
64-bit DMA addresses or not, so if my suggested patch works for you,
it seems like a more elegant solution (which also avoids having to
abuse device tree properties).


Kind regards,
Niklas

