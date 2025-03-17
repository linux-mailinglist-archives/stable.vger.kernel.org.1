Return-Path: <stable+bounces-124566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EDA63AD5
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 02:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7623AC2B5
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACBB13CA9C;
	Mon, 17 Mar 2025 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgO6gic3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2E79D2;
	Mon, 17 Mar 2025 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742176570; cv=none; b=LWjNrQ5ujv0mnGa51/sd8jNtfwly6MiXp+8zWJmb1ov3zoBYPWj4NTChrk2oAs+GeS7Q7QDvd8dVWl0ZGwAI0BbOKYKPXKiCtTA0tiu7qhe7GH456b816v7VpSQKqOkT0JYOz1HZJpjvR2DX9bGBWJbtCoJD2Hqi3o9qfwnRuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742176570; c=relaxed/simple;
	bh=DW/PqvX6IeUImr+orrmNc0CoOSwyap646QVZ5Tbd3sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU48FuQMvkeuR+qBdvD2IkMDoClrahJxFkOuglF5Pr80gDrlOX2C9CI4iN6xrE63tgzoeGrsR3rIysXxmUMkRhoWrhJfStVORvElVWnv6E+j2jc+gITJkAKnWZ1GBtd4uwJDyu4nWlWo/HqtaqFmcPlVUXKZLD4oUH8F73TBp30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgO6gic3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA194C4CEDD;
	Mon, 17 Mar 2025 01:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742176569;
	bh=DW/PqvX6IeUImr+orrmNc0CoOSwyap646QVZ5Tbd3sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgO6gic3aLP5WD4qeK/GnvwCiJSitTz2Gt1erDNWLnNrEkznxdXhqdc+O75VTAdxr
	 61ZnvHhdUVMXBt5XeFtR9/A0H/OpeEG5Dg5ery/d6mRbPS3IIPbVr2NauH2bds90Xb
	 oF5pg6/M568SpedRB0+4TCbcBKrbV7CVXP7XXSeerfOMCq5HQ2OcMlHSTHgASYe4WI
	 ROiiBVv2ivwoe8mv9X89u2tpEWAsr/qZWwp0ADenS+DlqtIz8iXTJMSByy0k1QGhGc
	 cue4kBlKeuA+rX6fTqLdLjoQSnM0MZqTTEvemDBE31VX4R5tCbBV3Wf/o8SEFaDY4f
	 9expRlxM54ztg==
Date: Mon, 17 Mar 2025 09:56:01 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Frank Li <Frank.li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Sebastian Reichel <sre@kernel.org>,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
	linux-usb@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: chipidea: ci_hdrc_imx: implement
 usb_phy_init() error handling
Message-ID: <20250317015601.GC218167@nchen-desktop>
References: <20250316102658.490340-1-pchelkin@ispras.ru>
 <20250316102658.490340-4-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316102658.490340-4-pchelkin@ispras.ru>

On 25-03-16 13:26:56, Fedor Pchelkin wrote:
> usb_phy_init() may return an error code if e.g. its implementation fails
> to prepare/enable some clocks. And properly rollback on probe error path
> by calling the counterpart usb_phy_shutdown().
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: be9cae2479f4 ("usb: chipidea: imx: Fix ULPI on imx53")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index d942b3c72640..4f8bfd242b59 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -484,7 +484,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
>  		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
>  		data->override_phy_control = true;
> -		usb_phy_init(pdata.usb_phy);
> +		ret = usb_phy_init(pdata.usb_phy);
> +		if (ret) {
> +			dev_err(dev, "Failed to init phy\n");
> +			goto err_clk;
> +		}
>  	}
>  
>  	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
> @@ -493,7 +497,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  	ret = imx_usbmisc_init(data->usbmisc_data);
>  	if (ret) {
>  		dev_err(dev, "usbmisc init failed, ret=%d\n", ret);
> -		goto err_clk;
> +		goto phy_shutdown;
>  	}
>  
>  	data->ci_pdev = ci_hdrc_add_device(dev,
> @@ -502,7 +506,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->ci_pdev)) {
>  		ret = PTR_ERR(data->ci_pdev);
>  		dev_err_probe(dev, ret, "ci_hdrc_add_device failed\n");
> -		goto err_clk;
> +		goto phy_shutdown;
>  	}
>  
>  	if (data->usbmisc_data) {
> @@ -536,6 +540,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  
>  disable_device:
>  	ci_hdrc_remove_device(data->ci_pdev);
> +phy_shutdown:
> +	if (data->override_phy_control)
> +		usb_phy_shutdown(data->phy);
>  err_clk:
>  	clk_disable_unprepare(data->clk_wakeup);
>  err_wakeup_clk:
> -- 
> 2.48.1
> 

-- 

Best regards,
Peter

