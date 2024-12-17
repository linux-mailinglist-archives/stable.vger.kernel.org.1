Return-Path: <stable+bounces-104432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472319F436A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F061885BD9
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1546E14AD3D;
	Tue, 17 Dec 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY9oz9/n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68018BF8;
	Tue, 17 Dec 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416327; cv=none; b=erFtUfpCXFWU7nnocJtdbyjrVq95M2aeNkLG0C87AWd4xs87NBTNVNl3VTiF/VxiBFOc9KRCSRgyGy6ER5xWOH5VaSn5D26YSzlZ/EE+eZAW3Ur0xVPX7HLFAvFDpVvoIWOYOeBEYeeyAQ+EMvKkMm2++NlJpA1j4qlK+L0EsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416327; c=relaxed/simple;
	bh=tdc+cyJu1FKUnRHoM2wya2+WStBzz1cra54EZ9pwlB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4IUKxBM4GxScnGsjCqbW4koBs5HanJ0VPA7oSdmwdhSmM6X8riGW2SqAy2Z65DmX79eAdHew1bSem+Lc8vu918OXf5PTrcqcqlIfAneP+Yv6w2X5Xfd807uFSbG25nOyAZ1RWLb2Wl9J+mM+Gw7XQDfE7O50+6Br0RvDsK8BbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY9oz9/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7654C4CED3;
	Tue, 17 Dec 2024 06:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734416327;
	bh=tdc+cyJu1FKUnRHoM2wya2+WStBzz1cra54EZ9pwlB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YY9oz9/nb1QyteKTn15smQYNRVRNYbHZETDkPbC0rZhGexDZYXtHbMH0XPOFQ2Lhe
	 MF1RJjkbLDd3kS+K+6YLSgfbXWphIArzYAxq34gOGAwsuIWkf5/lRmFUUwaWrNqsvC
	 tezRmXzzFeIKi7Qktg8wSPer5wbK930NVrtNtiKAUMo5pUm+sTdtS841c8JECm7hik
	 xR++L2GxST/+UBEPt2xNAbUBOSpPENe31ndffU67trgEZR2MNDX81vH77MW561fQ6A
	 aoThUjVGYJCbRkqFpfVvR/0l3LEU/FzGFVquazQZV9k9MMneHrYSVV3/wlJoxnPXhV
	 JZzMCkgWUi1Mg==
Date: Tue, 17 Dec 2024 14:18:39 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: gregkh@linuxfoundation.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: chipidea: ci_hdrc_imx: decrement device's
 refcount in .remove() and in the error path of .probe()
Message-ID: <20241217061839.GC13482@nchen-desktop>
References: <20241216015539.352579-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216015539.352579-1-joe@pf.is.s.u-tokyo.ac.jp>

On 24-12-16 10:55:39, Joe Hattori wrote:
> Current implementation of ci_hdrc_imx_driver does not decrement the
> refcount of the device obtained in usbmisc_get_init_data(). Add a
> put_device() call in .remove() and in .probe() before returning an
> error.
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Cc: stable@vger.kernel.org
> Fixes: f40017e0f332 ("chipidea: usbmisc_imx: Add USB support for VF610 SoCs")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
> Changes in v2:
> - Put the device in .remove() as well.
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index f2801700be8e..1a7fc638213e 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -370,25 +370,29 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		data->pinctrl = devm_pinctrl_get(dev);
>  		if (PTR_ERR(data->pinctrl) == -ENODEV)
>  			data->pinctrl = NULL;
> -		else if (IS_ERR(data->pinctrl))
> -			return dev_err_probe(dev, PTR_ERR(data->pinctrl),
> +		else if (IS_ERR(data->pinctrl)) {
> +			ret = dev_err_probe(dev, PTR_ERR(data->pinctrl),
>  					     "pinctrl get failed\n");
> +			goto err_put;
> +		}
>  
>  		data->hsic_pad_regulator =
>  				devm_regulator_get_optional(dev, "hsic");
>  		if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
>  			/* no pad regulator is needed */
>  			data->hsic_pad_regulator = NULL;
> -		} else if (IS_ERR(data->hsic_pad_regulator))
> -			return dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
> +		} else if (IS_ERR(data->hsic_pad_regulator)) {
> +			ret = dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
>  					     "Get HSIC pad regulator error\n");
> +			goto err_put;
> +		}
>  
>  		if (data->hsic_pad_regulator) {
>  			ret = regulator_enable(data->hsic_pad_regulator);
>  			if (ret) {
>  				dev_err(dev,
>  					"Failed to enable HSIC pad regulator\n");
> -				return ret;
> +				goto err_put;
>  			}
>  		}
>  	}
> @@ -402,13 +406,14 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  			dev_err(dev,
>  				"pinctrl_hsic_idle lookup failed, err=%ld\n",
>  					PTR_ERR(pinctrl_hsic_idle));
> -			return PTR_ERR(pinctrl_hsic_idle);
> +			ret = PTR_ERR(pinctrl_hsic_idle);
> +			goto err_put;
>  		}
>  
>  		ret = pinctrl_select_state(data->pinctrl, pinctrl_hsic_idle);
>  		if (ret) {
>  			dev_err(dev, "hsic_idle select failed, err=%d\n", ret);
> -			return ret;
> +			goto err_put;
>  		}
>  
>  		data->pinctrl_hsic_active = pinctrl_lookup_state(data->pinctrl,
> @@ -417,7 +422,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  			dev_err(dev,
>  				"pinctrl_hsic_active lookup failed, err=%ld\n",
>  					PTR_ERR(data->pinctrl_hsic_active));
> -			return PTR_ERR(data->pinctrl_hsic_active);
> +			ret = PTR_ERR(data->pinctrl_hsic_active);
> +			goto err_put;
>  		}
>  	}
>  
> @@ -527,6 +533,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  	if (pdata.flags & CI_HDRC_PMQOS)
>  		cpu_latency_qos_remove_request(&data->pm_qos_req);
>  	data->ci_pdev = NULL;
> +err_put:
> +	put_device(data->usbmisc_data->dev);
>  	return ret;
>  }
>  
> @@ -551,6 +559,7 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
>  		if (data->hsic_pad_regulator)
>  			regulator_disable(data->hsic_pad_regulator);
>  	}
> +	put_device(data->usbmisc_data->dev);
>  }
>  
>  static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
> -- 
> 2.34.1
> 

