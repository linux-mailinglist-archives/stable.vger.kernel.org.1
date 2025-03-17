Return-Path: <stable+bounces-124565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41151A63AC6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 02:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4209B3AB388
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 01:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFE13B7B3;
	Mon, 17 Mar 2025 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzUFglXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2079D2;
	Mon, 17 Mar 2025 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742176487; cv=none; b=WWGRS6jmLiFqUZSdyT21rI2kjKVjp72Qexaj8komZu4twmJCRNaDV+1WL0dTIo/ZT1Q5LbD3iRz3valrzyS0EDSdp01lNYEILuFe0mODv2ND2UAYBCOck3FHMmHzPz8Y5WAitbrt2Z0wGKpY4o3gNBdIBYY1SIrLT7oHeKyAfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742176487; c=relaxed/simple;
	bh=i8Zgs3umIvGH2qQwYjil63u/LJvMP0AVGyrUYdKPEh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA3z7dlDRUZKK45Ae0C+/ldkTusEYu1ys4Ze6pT0UMY+GoK1FO7qR4eZCP2mKhbSiVfaK+X4LD3qp2zhy13urF5FEcuSrat/CtJcXYFVosX+xyVMP0EuvjbEQ0yU2x7SKf+9ANlOP3EJpVrrIiiFSXDDI5npxb/1F8Ti/wF1sE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzUFglXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F3BC4CEDD;
	Mon, 17 Mar 2025 01:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742176487;
	bh=i8Zgs3umIvGH2qQwYjil63u/LJvMP0AVGyrUYdKPEh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzUFglXM3IaoIi+CZRubjx8LO9MQgySMquQ29q/nXWST9VMICxfYxpX7aprmijkRp
	 IyaOmCZF39L+Of3uSbI79cSE+L+cGC1H+jDCL+jBEu5L/8ghWsVfIe3nhs2tcicz6h
	 PmHoymoqQzzaTeg3heDCKFyJ4ZLaZmI0YD28HpI4eR618aGnM1p70hLCANded8hKLj
	 iQ8pieiuXtkWkgidlGT5iKzPP+VRcqoPcPfZVtPHm3E4VpdBzS16DDTDdWzD0CjEng
	 e5dZ5peRF3H/1j2/dlP6d++Y4GCmtFE8FEIZXgFgkgFBxun2RTBhU/c8xpspvmKP4j
	 7KwTqaIUoBCYQ==
Date: Mon, 17 Mar 2025 09:54:37 +0800
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
Subject: Re: [PATCH v2 2/3] usb: chipidea: ci_hdrc_imx: fix call balance of
 regulator routines
Message-ID: <20250317015437.GB218167@nchen-desktop>
References: <20250316102658.490340-1-pchelkin@ispras.ru>
 <20250316102658.490340-3-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316102658.490340-3-pchelkin@ispras.ru>

On 25-03-16 13:26:55, Fedor Pchelkin wrote:
> Upon encountering errors during the HSIC pinctrl handling section the
> regulator should be disabled.
> 
> Use devm_add_action_or_reset() to let the regulator-disabling routine be
> handled by device resource management stack.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 4d6141288c33 ("usb: chipidea: imx: pinctrl for HSIC is optional")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Peter Chen <peter.chen@kernel.org>


> ---
> v2: simplify the patch taking advantage of devm-helper (Frank Li)
> 
> It looks like devm_regulator_get_enable_optional() exists for this very
> use case utilized in the driver but it's not present in old supported
> stable kernels and I may say those dependency-patches wouldn't apply there
> cleanly. So fix the problem first, further code simplification is a
> subject to cleanup patch.
> 
>  drivers/usb/chipidea/ci_hdrc_imx.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 619779eef333..d942b3c72640 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -336,6 +336,13 @@ static int ci_hdrc_imx_notify_event(struct ci_hdrc *ci, unsigned int event)
>  	return ret;
>  }
>  
> +static void ci_hdrc_imx_disable_regulator(void *arg)
> +{
> +	struct ci_hdrc_imx_data *data = arg;
> +
> +	regulator_disable(data->hsic_pad_regulator);
> +}
> +
>  static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  {
>  	struct ci_hdrc_imx_data *data;
> @@ -394,6 +401,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  					"Failed to enable HSIC pad regulator\n");
>  				goto err_put;
>  			}
> +			ret = devm_add_action_or_reset(dev,
> +					ci_hdrc_imx_disable_regulator, data);
> +			if (ret) {
> +				dev_err(dev,
> +					"Failed to add regulator devm action\n");
> +				goto err_put;
> +			}
>  		}
>  	}
>  
> @@ -432,11 +446,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  
>  	ret = imx_get_clks(dev);
>  	if (ret)
> -		goto disable_hsic_regulator;
> +		goto qos_remove_request;
>  
>  	ret = imx_prepare_enable_clks(dev);
>  	if (ret)
> -		goto disable_hsic_regulator;
> +		goto qos_remove_request;
>  
>  	ret = clk_prepare_enable(data->clk_wakeup);
>  	if (ret)
> @@ -526,10 +540,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(data->clk_wakeup);
>  err_wakeup_clk:
>  	imx_disable_unprepare_clks(dev);
> -disable_hsic_regulator:
> -	if (data->hsic_pad_regulator)
> -		/* don't overwrite original ret (cf. EPROBE_DEFER) */
> -		regulator_disable(data->hsic_pad_regulator);
> +qos_remove_request:
>  	if (pdata.flags & CI_HDRC_PMQOS)
>  		cpu_latency_qos_remove_request(&data->pm_qos_req);
>  	data->ci_pdev = NULL;
> @@ -557,8 +568,6 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
>  		clk_disable_unprepare(data->clk_wakeup);
>  		if (data->plat_data->flags & CI_HDRC_PMQOS)
>  			cpu_latency_qos_remove_request(&data->pm_qos_req);
> -		if (data->hsic_pad_regulator)
> -			regulator_disable(data->hsic_pad_regulator);
>  	}
>  	if (data->usbmisc_data)
>  		put_device(data->usbmisc_data->dev);
> -- 
> 2.48.1
> 

-- 

Best regards,
Peter

