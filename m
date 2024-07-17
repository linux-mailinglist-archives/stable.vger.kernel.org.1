Return-Path: <stable+bounces-60474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE193423B
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28277283720
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10211849C9;
	Wed, 17 Jul 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIqOSzqm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE461836C4;
	Wed, 17 Jul 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240693; cv=none; b=Ztxl+yVvo/knW4+i9t6fqQR7Rkp4dEhKM+RM2F7HTRBfhmOQzIemqSl1QwDTNo4FF66eHJ4JCCCenP/t9URWuNgFgSHJh+vV6XQwnRby5a9biG9MGUK8CH+gk0wOLnxPQxAxKpQi3cWJJgreoflcJqY+EbLEvIS8LlPbuh04E3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240693; c=relaxed/simple;
	bh=C++kSOLhIP5PSq6tF2bjAs5Xhpug33YPSaVFZ8do+YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJELVKY4kwgg/DeZm92+/s73PUX8kcfejyF1qZJoeyD1I6hYkgu2FHIyFtWbjZ0t7VM6j2TB2wpyotgX2PyUK/w3x5Bz3KmgJ3EXJj9DAjjSU34GphgtgItbFLzk7cCCaeUr2V3/Yo87BlDyM/2ZiyCDfvSm/t4RLzGb2Yzqw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIqOSzqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6429EC4AF0B;
	Wed, 17 Jul 2024 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721240692;
	bh=C++kSOLhIP5PSq6tF2bjAs5Xhpug33YPSaVFZ8do+YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIqOSzqmR44B1nzxPCPJH2o6GTxE2nt2Hhe9ArYOEprmgc8xLjQAmduIF9Bs6Vdew
	 EUnltYNEoe7YcYxEGpDsK8jwk6A9LBGIp69e3oGFwox9uG8tS7BX2tOhpc2oK/qRU1
	 aGIJaQG5x1UA3E3heOVTQ7diXTF5eS4mVIXluetMD8a34yUe6t6BN+AbptVTBUKBq2
	 zkdEZmSiYnUDy4vBmofSpsz9l1vuYAptvR7N1jLZ4rZGKpGPFj1ReJOo3LnT2FigrR
	 Mlz4in3o8Lv6qZyXaOc/Fmg4PCWgRwIk7zo4UNx/xwZVoiHTN/V6K1Qkjt9y/OtrWP
	 VAL7rD1O6AC4Q==
Date: Wed, 17 Jul 2024 20:24:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: tj@kernel.org, dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, linux-ide@vger.kernel.org,
	stable@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 2/4] ata: ahci_imx: Clean up code by using i.MX8Q HSIO
 PHY driver
Message-ID: <ZpgMbvuSpgGoISN1@ryzen.lan>
References: <1721099895-26098-1-git-send-email-hongxing.zhu@nxp.com>
 <1721099895-26098-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721099895-26098-3-git-send-email-hongxing.zhu@nxp.com>

On Tue, Jul 16, 2024 at 11:18:13AM +0800, Richard Zhu wrote:
> Clean up code by using PHY interface.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/ata/ahci_imx.c | 396 ++++++++++-------------------------------
>  1 file changed, 98 insertions(+), 298 deletions(-)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index cb768f66f0a70..e94c0fdea2260 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -986,65 +827,22 @@ static const struct scsi_host_template ahci_platform_sht = {
>  
>  static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
>  {
> -	struct resource *phy_res;
> -	struct platform_device *pdev = imxpriv->ahci_pdev;
> -	struct device_node *np = dev->of_node;
> -
> -	if (of_property_read_u32(np, "fsl,phy-imp", &imxpriv->imped_ratio))
> -		imxpriv->imped_ratio = IMX8QM_SATA_PHY_IMPED_RATIO_85OHM;
> -	phy_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> -	if (phy_res) {
> -		imxpriv->phy_base = devm_ioremap(dev, phy_res->start,
> -					resource_size(phy_res));
> -		if (!imxpriv->phy_base) {
> -			dev_err(dev, "error with ioremap\n");
> -			return -ENOMEM;
> -		}
> -	} else {
> -		dev_err(dev, "missing *phy* reg region.\n");
> -		return -ENOMEM;
> -	}
> -	imxpriv->gpr =
> -		 syscon_regmap_lookup_by_phandle(np, "hsio");
> -	if (IS_ERR(imxpriv->gpr)) {
> -		dev_err(dev, "unable to find gpr registers\n");
> -		return PTR_ERR(imxpriv->gpr);
> -	}
> -
> -	imxpriv->epcs_tx_clk = devm_clk_get(dev, "epcs_tx");
> -	if (IS_ERR(imxpriv->epcs_tx_clk)) {
> -		dev_err(dev, "can't get epcs_tx_clk clock.\n");
> -		return PTR_ERR(imxpriv->epcs_tx_clk);
> -	}
> -	imxpriv->epcs_rx_clk = devm_clk_get(dev, "epcs_rx");
> -	if (IS_ERR(imxpriv->epcs_rx_clk)) {
> -		dev_err(dev, "can't get epcs_rx_clk clock.\n");
> -		return PTR_ERR(imxpriv->epcs_rx_clk);
> -	}
> -	imxpriv->phy_pclk0 = devm_clk_get(dev, "phy_pclk0");
> -	if (IS_ERR(imxpriv->phy_pclk0)) {
> -		dev_err(dev, "can't get phy_pclk0 clock.\n");
> -		return PTR_ERR(imxpriv->phy_pclk0);
> -	}
> -	imxpriv->phy_pclk1 = devm_clk_get(dev, "phy_pclk1");
> -	if (IS_ERR(imxpriv->phy_pclk1)) {
> -		dev_err(dev, "can't get phy_pclk1 clock.\n");
> -		return PTR_ERR(imxpriv->phy_pclk1);
> -	}
> -	imxpriv->phy_apbclk = devm_clk_get(dev, "phy_apbclk");
> -	if (IS_ERR(imxpriv->phy_apbclk)) {
> -		dev_err(dev, "can't get phy_apbclk clock.\n");
> -		return PTR_ERR(imxpriv->phy_apbclk);
> -	}
> -
> -	/* Fetch GPIO, then enable the external OSC */
> -	imxpriv->clkreq_gpiod = devm_gpiod_get_optional(dev, "clkreq",
> -				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> -	if (IS_ERR(imxpriv->clkreq_gpiod))
> -		return PTR_ERR(imxpriv->clkreq_gpiod);
> -	if (imxpriv->clkreq_gpiod)
> -		gpiod_set_consumer_name(imxpriv->clkreq_gpiod, "SATA CLKREQ");
> -
> +	if (!(dev->bus_dma_limit))
> +		dev->bus_dma_limit = DMA_BIT_MASK(32);

These two lines look like a unrelated change, should be in a separate commit
with a proper commit message.


Kind regards,
Niklas

