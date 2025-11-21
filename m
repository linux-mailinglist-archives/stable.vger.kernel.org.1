Return-Path: <stable+bounces-196486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCFC7A2D3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 06A2732498
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E2345750;
	Fri, 21 Nov 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iXlmGEBj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DA30AD19;
	Fri, 21 Nov 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734712; cv=none; b=X9RuIspFBjfbVhwLZbbayT2PH7qXtmhxCHukcIVGIvhV4P/27P2p6cxLB+uE6yuXs+skxBwxOBZPtELwv/oFwf+ZQQGgmGcpD002ZLRrV0kd1hS+IENyNtlbStiSUXUmsWwGV0gEHOIdMtQwCAybkI7oKseuYzr0kcfMTNrxyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734712; c=relaxed/simple;
	bh=SBMXop/PAw5czQpijsWvGpCFvDrNh6vBAkrLsdRGe/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjBj6AecmEnKPVKPdul4vk8msTxh2i9SdJuYGUFemcZCgMG/5gOxhLEcZkMiWbeVMZ7LzfB6+ySpFdZf4FLXIUPNXFp7v/A2bnH1JQxqREefzwnRYe9Z4Ys7mmVGYE7OwWYYXAQhB/YTMynvRV8LYaleYBr6Nj4MH8ekZaN0c9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iXlmGEBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF5BC4CEF1;
	Fri, 21 Nov 2025 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763734711;
	bh=SBMXop/PAw5czQpijsWvGpCFvDrNh6vBAkrLsdRGe/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXlmGEBjAAAtAuRE3vwVXLn0igIqx3dDNExfg8002OsqugiET0N2Yt1o1xK0iN/fB
	 XGR7wOGuY+70Ip3KzZWht2JmEjWuth78hAWq7BzPo51e/xsV74e7hG/IjrA292mdvE
	 ymk6ZxYcZIg7Txwf8osWh5roiD4T0VsfpuPuQLfU=
Date: Fri, 21 Nov 2025 15:04:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: vz@mleia.com, piotr.wojtaszczyk@timesys.com, arnd@arndb.de,
	stigge@antcom.de, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: Fix error handling in gadget driver
Message-ID: <2025112122-fedora-tiny-6fa3@gregkh>
References: <20251116014948.14093-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116014948.14093-1-make24@iscas.ac.cn>

On Sun, Nov 16, 2025 at 09:49:48AM +0800, Ma Ke wrote:
> lpc32xx_udc_probe() acquires an i2c_client reference through
> isp1301_get_client() but fails to release it in both error handling
> paths and the normal removal path. This could result in a reference
> count leak for the I2C device, preventing proper cleanup and
> potentially leading to resource exhaustion. Add put_device() to
> release the reference in the probe failure path and in the remove
> function.
> 
> Calling path: isp1301_get_client() -> of_find_i2c_device_by_node() ->
> i2c_find_device_by_fwnode(). As comments of
> i2c_find_device_by_fwnode() says, 'The user must call
> put_device(&client->dev) once done with the i2c client.'
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/lpc32xx_udc.c | 35 +++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index 1a7d3c4f652f..b6fddfff712d 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -2986,6 +2986,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>  	int retval, i;
>  	dma_addr_t dma_handle;
>  	struct device_node *isp1301_node;
> +	bool isp1301_acquired = false;

This bool should not be needed, you "know" if you have acquired this or
not by virtue of being later in the function call.


>  
>  	udc = devm_kmemdup(dev, &controller_template, sizeof(*udc), GFP_KERNEL);
>  	if (!udc)
> @@ -3013,6 +3014,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>  	if (!udc->isp1301_i2c_client) {
>  		return -EPROBE_DEFER;
>  	}
> +	isp1301_acquired = true;
>  
>  	dev_info(udc->dev, "ISP1301 I2C device at address 0x%x\n",
>  		 udc->isp1301_i2c_client->addr);
> @@ -3020,7 +3022,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>  	pdev->dev.dma_mask = &lpc32xx_usbd_dmamask;
>  	retval = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>  	if (retval)
> -		return retval;
> +		goto i2c_fail;
>  
>  	udc->board = &lpc32xx_usbddata;
>  
> @@ -3038,28 +3040,32 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>  	/* Get IRQs */
>  	for (i = 0; i < 4; i++) {
>  		udc->udp_irq[i] = platform_get_irq(pdev, i);
> -		if (udc->udp_irq[i] < 0)
> -			return udc->udp_irq[i];
> +		if (udc->udp_irq[i] < 0) {
> +			retval = udc->udp_irq[i];
> +			goto i2c_fail;
> +		}
>  	}
>  
>  	udc->udp_baseaddr = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(udc->udp_baseaddr)) {
>  		dev_err(udc->dev, "IO map failure\n");
> -		return PTR_ERR(udc->udp_baseaddr);
> +		retval = PTR_ERR(udc->udp_baseaddr);
> +		goto i2c_fail;
>  	}
>  
>  	/* Get USB device clock */
>  	udc->usb_slv_clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(udc->usb_slv_clk)) {
>  		dev_err(udc->dev, "failed to acquire USB device clock\n");
> -		return PTR_ERR(udc->usb_slv_clk);
> +		retval = PTR_ERR(udc->usb_slv_clk);
> +		goto i2c_fail;
>  	}
>  
>  	/* Enable USB device clock */
>  	retval = clk_prepare_enable(udc->usb_slv_clk);
>  	if (retval < 0) {
>  		dev_err(udc->dev, "failed to start USB device clock\n");
> -		return retval;
> +		goto i2c_fail;
>  	}
>  
>  	/* Setup deferred workqueue data */
> @@ -3161,6 +3167,8 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>  	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
>  			  udc->udca_v_base, udc->udca_p_base);
>  i2c_fail:
> +	if (isp1301_acquired && udc->isp1301_i2c_client)
> +		put_device(&udc->isp1301_i2c_client->dev);
>  	clk_disable_unprepare(udc->usb_slv_clk);
>  	dev_err(udc->dev, "%s probe failed, %d\n", driver_name, retval);
>  
> @@ -3170,6 +3178,18 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>  static void lpc32xx_udc_remove(struct platform_device *pdev)
>  {
>  	struct lpc32xx_udc *udc = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct device_node *isp1301_node;
> +	bool isp1301_acquired = false;

This bool isn't needed either, just trigger off of isp1301_node.

But really:

> +
> +	/* Check if we acquired isp1301 via device tree */
> +	if (dev->of_node) {
> +		isp1301_node = of_parse_phandle(dev->of_node, "transceiver", 0);

Shouldn't this node be saved in the device structure instead?  That's
the "correct" solution here.

thanks,

greg k-h

