Return-Path: <stable+bounces-104302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210EB9F27C6
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 02:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B51D1655B8
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7FB101EE;
	Mon, 16 Dec 2024 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGNZAQBm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495CF9DD;
	Mon, 16 Dec 2024 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734312570; cv=none; b=QnZiKExhmwR+28JTUheodBmm0DMcq3hrdGYYCZW8nU2yNGggV37lY2xBvYH6cW2EJQ7xngtFG9OtsrOpmXd+pcs2OGNwwTqJPxHruIk1RvmqCSleHYgqESn5stmA6B3Q3WbwSYKhUGYtL3dM6YwKAOi9nfCYaZZG4rjsdaf8BNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734312570; c=relaxed/simple;
	bh=jMkke77rPQvcJJ0rdaw2kiRhZ+G5mtAK+9KZFaDeOIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=errvc3+tZESacfYza3/dSzoJXb5Rm4pFelgjGKfTGKFyXPuQGePR060JxKQ4F3TWFHyv9RqHvy5HvT8x6mN4ekE/sO8zMWlfcg6i5GalJ9XgIP2auKKymwdHJy5GJi9Fv0/3bz1gLhWlIC+yo8fJlmkX+h73gXfVlseqHaNhkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGNZAQBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE66C4CECE;
	Mon, 16 Dec 2024 01:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734312570;
	bh=jMkke77rPQvcJJ0rdaw2kiRhZ+G5mtAK+9KZFaDeOIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGNZAQBm5O+nzAkQEUP/tk5roAYX4D7m+yXNGa5O7bFIUW9bG9nUnBXLWt95z/590
	 hRe/nL4J6MC5MZU+ekVsJJZPIUVpdoIQ9IbxK/tMXkIuLFr256e7wIBr+VClQpg5bD
	 XvnOujtXPmcZOvG16GaIfNrdMEi/GdGHdKHQOscDl8wAXSAWFj1mzK1voR9lqlaHLm
	 H3FolfjvaJ7PfhtuXdRjG/Gts39DxivM0ptWfG3v6C2AKd6dA5bki5oH7JVBUMOFW/
	 jPU1tin5za2UYR9SgRDyiktwjThOxVSmRA4nv4+0b5JqoyRUmJxqYSsf2lLvdsnQdo
	 DeqWRd4ftZp3g==
Date: Mon, 16 Dec 2024 09:29:21 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: gregkh@linuxfoundation.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: ci_hdrc_imx: decrement device's refcount
 on the error path of .probe()
Message-ID: <20241216012921.GA4105602@nchen-desktop>
References: <20241212094945.3784866-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212094945.3784866-1-joe@pf.is.s.u-tokyo.ac.jp>

On 24-12-12 18:49:45, Joe Hattori wrote:
> Current implementation of ci_hdrc_imx_probe() does not decrement the
> refcount of the device obtained in usbmisc_get_init_data(). Add a
> put_device() call before returning an error after the call.
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Cc: stable@vger.kernel.org
> Fixes: f40017e0f332 ("chipidea: usbmisc_imx: Add USB support for VF610 SoCs")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index f2801700be8e..6418052264f2 100644
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

Thanks for your fix, would you mind also add put_device at the end of 
ci_hdrc_imx_remove?

Peter

