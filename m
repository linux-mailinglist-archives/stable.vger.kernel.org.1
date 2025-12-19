Return-Path: <stable+bounces-203038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C915CCE07F
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 01:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1449301E1A6
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100065477E;
	Fri, 19 Dec 2025 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="tD0PfHPY";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="tD0PfHPY"
X-Original-To: stable@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F9288D2;
	Fri, 19 Dec 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103116; cv=none; b=d7SkSdZkl4JQsFegTeYcLwsfwUnEi66TMOmgTR6LVyICTRgStuZD5O3fw1n0rNCZIJlhzduaULC+l74H9PFuFWiIAH7izTA+Bjpo0zq5LhWrAd8KiqrsuWeVe736jx6Po/dsSddBfTy17I+elBZOuEQmojo8+ngwwTPWFzW9qlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103116; c=relaxed/simple;
	bh=cOkukcP8nflrHoCJOtq1UgUziZQoyIsXmaKZOMWJORc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt6a5CUE5ZtaHzsnSkjDq1yLPGotEIktpOYpQMccqtrtZ78aagxltHlsbh5H+4xtZi/FpL9BFdwyOCIl4bC4BfOzJa+93D099ZS1vcojIEG3DHAwQZTQQt4jjxqhNsxSyU2mnKsqX0DjOyeKagoch9E5Dp+BzSUqYdCbT+VvmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=tD0PfHPY; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=tD0PfHPY; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766103106; bh=cOkukcP8nflrHoCJOtq1UgUziZQoyIsXmaKZOMWJORc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tD0PfHPYFRb3+drddmWGRo3gp4OjQEEQgZFOHoo3Scspxqb3QIcSJUpWzbsiIUJFD
	 XJkMpg/myYv6jAqN2B2YJaHKe383ISChum4xMNF/5SwlAUIQaCtpWMFeq9BKL9hC0p
	 lrO6CJUxfsGOHuhUnAarPtbT+snJCzjOdKmEOt1FxegPsUh631Q+YsX6zN67WV7Mh8
	 w5St+T0tJWdDV0ly4/qqDWK9oIQXl87qMRBGjG2mZqC1rxfgOOBlTPhXkw039GRfpd
	 RsFY+FLlUzXcv5buIn2GUK1jCT85VhflOeeyh9gb/Pd9cySeY27c1/bpiU9ysfcP7U
	 3+Y744VpeKbng==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id B6F213E7A9A;
	Fri, 19 Dec 2025 00:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766103106; bh=cOkukcP8nflrHoCJOtq1UgUziZQoyIsXmaKZOMWJORc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tD0PfHPYFRb3+drddmWGRo3gp4OjQEEQgZFOHoo3Scspxqb3QIcSJUpWzbsiIUJFD
	 XJkMpg/myYv6jAqN2B2YJaHKe383ISChum4xMNF/5SwlAUIQaCtpWMFeq9BKL9hC0p
	 lrO6CJUxfsGOHuhUnAarPtbT+snJCzjOdKmEOt1FxegPsUh631Q+YsX6zN67WV7Mh8
	 w5St+T0tJWdDV0ly4/qqDWK9oIQXl87qMRBGjG2mZqC1rxfgOOBlTPhXkw039GRfpd
	 RsFY+FLlUzXcv5buIn2GUK1jCT85VhflOeeyh9gb/Pd9cySeY27c1/bpiU9ysfcP7U
	 3+Y744VpeKbng==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 399263E769B;
	Fri, 19 Dec 2025 00:11:46 +0000 (UTC)
Message-ID: <6355f7da-9b60-4e71-8ea0-da76ed4c0330@mleia.com>
Date: Fri, 19 Dec 2025 02:11:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] usb: gadget: lpc32xx_udc: fix clock imbalance in
 error path
To: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Alan Stern <stern@rowland.harvard.edu>, Ma Ke <make24@iscas.ac.cn>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251218153519.19453-1-johan@kernel.org>
 <20251218153519.19453-2-johan@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251218153519.19453-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251219_001146_766961_8BF98C20 
X-CRM114-Status: GOOD (  22.29  )

Hi Johan,

thank you for looking at the issue.

On 12/18/25 17:35, Johan Hovold wrote:
> A recent change fixing a device reference leak introduced a clock
> imbalance by reusing an error path so that the clock may be disabled
> before having been enabled.
> 
> Note that the clock framework allows for passing in NULL clocks so there
> is no risk for a NULL pointer dereference.
> 
> Also drop the bogus I2C client NULL check added by the offending commit
> as the pointer has already been verified to be non-NULL.
> 
> Fixes: c84117912bdd ("USB: lpc32xx_udc: Fix error handling in probe")

This commit didn't get a proper review, and it is broken in so many ways,
that I'd say it has to be reverted.

> Cc: stable@vger.kernel.org
> Cc: Ma Ke <make24@iscas.ac.cn>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/usb/gadget/udc/lpc32xx_udc.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index 73c0f28a8585..a962d4294fbe 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -3020,7 +3020,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>   	pdev->dev.dma_mask = &lpc32xx_usbd_dmamask;
>   	retval = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>   	if (retval)
> -		goto i2c_fail;
> +		goto err_put_client;
>   
>   	udc->board = &lpc32xx_usbddata;
>   
> @@ -3040,7 +3040,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>   		udc->udp_irq[i] = platform_get_irq(pdev, i);
>   		if (udc->udp_irq[i] < 0) {
>   			retval = udc->udp_irq[i];
> -			goto i2c_fail;
> +			goto err_put_client;
>   		}
>   	}
>   
> @@ -3048,7 +3048,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>   	if (IS_ERR(udc->udp_baseaddr)) {
>   		dev_err(udc->dev, "IO map failure\n");
>   		retval = PTR_ERR(udc->udp_baseaddr);
> -		goto i2c_fail;
> +		goto err_put_client;
>   	}
>   
>   	/* Get USB device clock */
> @@ -3056,14 +3056,14 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>   	if (IS_ERR(udc->usb_slv_clk)) {
>   		dev_err(udc->dev, "failed to acquire USB device clock\n");
>   		retval = PTR_ERR(udc->usb_slv_clk);
> -		goto i2c_fail;
> +		goto err_put_client;
>   	}
>   
>   	/* Enable USB device clock */
>   	retval = clk_prepare_enable(udc->usb_slv_clk);
>   	if (retval < 0) {
>   		dev_err(udc->dev, "failed to start USB device clock\n");
> -		goto i2c_fail;
> +		goto err_put_client;
>   	}
>   
>   	/* Setup deferred workqueue data */
> @@ -3165,9 +3165,10 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
>   	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
>   			  udc->udca_v_base, udc->udca_p_base);
>   i2c_fail:
> -	if (udc->isp1301_i2c_client)
> -		put_device(&udc->isp1301_i2c_client->dev);
>   	clk_disable_unprepare(udc->usb_slv_clk);
> +err_put_client:
> +	put_device(&udc->isp1301_i2c_client->dev);
> +
>   	dev_err(udc->dev, "%s probe failed, %d\n", driver_name, retval);
>   
>   	return retval;
> @@ -3195,10 +3196,9 @@ static void lpc32xx_udc_remove(struct platform_device *pdev)
>   	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
>   			  udc->udca_v_base, udc->udca_p_base);
>   
> -	if (udc->isp1301_i2c_client)
> -		put_device(&udc->isp1301_i2c_client->dev);
> -
>   	clk_disable_unprepare(udc->usb_slv_clk);
> +
> +	put_device(&udc->isp1301_i2c_client->dev);
>   }
>   
>   #ifdef CONFIG_PM

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir

