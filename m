Return-Path: <stable+bounces-136710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD1FA9CB99
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CC69A4F0B
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE2F2580C4;
	Fri, 25 Apr 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zd6BSsSQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECB23C8D5;
	Fri, 25 Apr 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590836; cv=none; b=KVNeYYfVNFxmT5xwOuCIHDjo1dtEv+dc+BZv/qyhHYs0LYw0h02VhnUy0FCs1Cg9ZPIHoPPZIHRJasS/0VPAX/kNgAv8/yBLYermxtMpMd6IM6y8o73k+ZQ+qEQb0eCtXISDipIg6mhGkUi7m+XaaXQxyIIFwdpDSBnUiLuUJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590836; c=relaxed/simple;
	bh=it9jBt7bfo25JeN+Ebx+NFRwSthw27Mi5965vRDXuAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acbsirAMItbBn0oX7awQX7zfpNUIqqtLxVmI+HDoTdHYuiW6ZQk/aYCRyMrZjx2WL6mUi8p/XLvxukuAJYzl8HP8taMIUTMPvSI2IRMWpm/wRa0ANeFBpgWGbyu0HsJxMxfkzWRXNbUMwm06WFEXsRB/sRTaOv1qistMEEwJVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zd6BSsSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE47C4CEE4;
	Fri, 25 Apr 2025 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745590836;
	bh=it9jBt7bfo25JeN+Ebx+NFRwSthw27Mi5965vRDXuAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zd6BSsSQMKTiq3B4Ei09zDGzUWldKyFQLJFL+r1Fsh896nNiaXy6oDWsr3QopQt6v
	 aWWGo5cw5ffoGRiat+DXLZJG4/ATJ2NYNhpdI/I17xmDLziWOEi/2XiBCTE12l9bqh
	 pwrDdlkhT+QDc4jNtUVgSDkh4gwieKomU/9rat6g=
Date: Fri, 25 Apr 2025 16:20:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: uhci-platform: Make the clock really optional
Message-ID: <2025042549-comma-whoever-ffe7@gregkh>
References: <20250425-uhci-clock-optional-v1-1-a1d462592f29@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-uhci-clock-optional-v1-1-a1d462592f29@gmail.com>

On Fri, Apr 25, 2025 at 06:11:11PM +0400, Alexey Charkov wrote:
> Device tree bindings state that the clock is optional for UHCI platform
> controllers, and some existing device trees don't provide those - such
> as those for VIA/WonderMedia devices.
> 
> The driver however fails to probe now if no clock is provided, because
> devm_clk_get returns an error pointer in such case.
> 
> Switch to devm_clk_get_optional instead, so that it could probe again
> on those platforms where no clocks are given.
> 
> Cc: stable@vger.kernel.org
> Fixes: 26c502701c52 ("usb: uhci: Add clk support to uhci-platform")
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  drivers/usb/host/uhci-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index a7c934404ebc7ed74f64265fafa7830809979ba5..62318291f5664c9ec94f24535c71d962e28354f3 100644
> --- a/drivers/usb/host/uhci-platform.c
> +++ b/drivers/usb/host/uhci-platform.c
> @@ -121,7 +121,7 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Get and enable clock if any specified */
> -	uhci->clk = devm_clk_get(&pdev->dev, NULL);
> +	uhci->clk = devm_clk_get_optional(&pdev->dev, NULL);

Why does this need to go to all stable trees all of a sudden?  This has
been "broken" for years, what changed recently to cause this to show up?

thanks,

greg k-h

