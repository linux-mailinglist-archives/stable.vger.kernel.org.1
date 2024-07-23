Return-Path: <stable+bounces-60800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CA93A420
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54E41F240D0
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CAF157490;
	Tue, 23 Jul 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOqphG6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C213B599;
	Tue, 23 Jul 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750671; cv=none; b=JpvlXGG4Smya5pu86sHMpJKWBVL4z9728Ig04VTzl9sDakJ7atkf3dt3B67kOqBE//661xOpPtcp/7IQydGKow+rLnAZe+3jmvuQ6C5TVul+WD91tyIQPT01NtZxrCGFpekj86HTvZDR7H3wvY1Rerjy3PYhc8xzbdVA3GOOqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750671; c=relaxed/simple;
	bh=W/+fwuK1CNAAfIupAvdNDpGXw3AXSDiI3VRVBEBzu8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jwt/W0sdlvrjVJwVhtt/FXUtnocVxwLH2b2EDBQF5yGEAQl/gMc8pbhnDrP5c+YHkYGfQSIsDHehltGk81eOH6c5wFBb5VZcOM6dvWXQAdfb67lpQYJxtBeP9iMO4Imy2akgM4bwBxZRTNs89T+HSTCYoPMuUHPpmIUJWfG2Gfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOqphG6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8A1C4AF09;
	Tue, 23 Jul 2024 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721750671;
	bh=W/+fwuK1CNAAfIupAvdNDpGXw3AXSDiI3VRVBEBzu8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOqphG6HOCuTixwQcQs2fjwA/9NFC7QrHNjGwhIaGxyVvlj8WV8bSPo0km0+hJZOZ
	 PPZPunccS1zR+DEcDXuuioers0KBGQOF7vIlFYWTM1EwwNP1XqCTEYyfizf4WRmIQ2
	 1A1crfZiXkCbMOyaNPP0rwrSMRDhD90CK9gNidt5rzsRy4LzqFlQMokCVySxdkYNF2
	 qO4NXzinLAEPSWMF8l5A66NJE/7jhse9NnPBH9Xx1ZtiLmYf84w6GT6WMqCgyIxqVB
	 459IZv6cKBTpqg3XcGdh7eKvpOyEz32AJ4PqyFBSWbcs/XdTriGfKgJpTRnzRx49pF
	 6rFOxePeCXeWg==
Date: Tue, 23 Jul 2024 18:04:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: tj@kernel.org, dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, linux-ide@vger.kernel.org,
	stable@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Message-ID: <Zp/Uh/mavwo+755Q@x1-carbon.lan>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>

On Fri, Jul 19, 2024 at 01:42:14PM +0800, Richard Zhu wrote:
> Since i.MX8QM AHCI SATA only has 32bits DMA capability.
> Add 32bits DMA limit here.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/ata/ahci_imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 4dd98368f8562..e94c0fdea2260 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -827,6 +827,9 @@ static const struct scsi_host_template ahci_platform_sht = {
>  
>  static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
>  {
> +	if (!(dev->bus_dma_limit))
> +		dev->bus_dma_limit = DMA_BIT_MASK(32);
> +
>  	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
>  	if (IS_ERR(imxpriv->sata_phy))
>  		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
> -- 
> 2.37.1
> 

Why is this needed?

ahci_imx.c calls ahci_platform_init_host(), which calls
dma_coerce_mask_and_coherent():
https://github.com/torvalds/linux/blob/v6.10/drivers/ata/libahci_platform.c#L750-L756

Should this code perhaps look more like:
https://github.com/torvalds/linux/blob/v6.10/drivers/ata/ahci.c#L1048-L1054

where we set it to 64 or 32 bit explicitly.

Does this solve your problem:
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 581704e61f28..fc86e2c8c42b 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -747,12 +747,11 @@ int ahci_platform_init_host(struct platform_device *pdev,
                        ap->ops = &ata_dummy_port_ops;
        }
 
-       if (hpriv->cap & HOST_CAP_64) {
-               rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
-               if (rc) {
-                       dev_err(dev, "Failed to enable 64-bit DMA.\n");
-                       return rc;
-               }
+       rc = dma_coerce_mask_and_coherent(dev,
+                       DMA_BIT_MASK((hpriv->cap & HOST_CAP_64) ? 64 : 32));
+       if (rc) {
+               dev_err(dev, "DMA enable failed\n");
+               return rc;
        }
 
        rc = ahci_reset_controller(host);



Kind regards,
Niklas

