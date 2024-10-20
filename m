Return-Path: <stable+bounces-86965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E904C9A537D
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 12:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1693281A24
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 10:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B69186E58;
	Sun, 20 Oct 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZIS2PZh"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D23B2BB
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729420840; cv=none; b=Aev3ldmlj7QwAV/BzitGFzunn+14uHeoBnf+ln2wE69oa93VsFz3rj3qVvhAeH/SwYY+EtRNnQrSqqLIEQ+8BodFeDwUMuD3ZiQ6DIzw0AZ3eOCMzcElTZtWH6GyHDY3/f6b6KiZfgsEZcXe0j8STJjQ6yRHNEbteRcdF1oz2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729420840; c=relaxed/simple;
	bh=e6Zx+YooRSyCvyeXZGGGQhAAfGoOuT2cf3p2UYYwbfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug72X+dvv/i820PSRaGGSlWTlxTnM/tqLmHejX/qXA3ZqYC9Mtppi5dJ5vHvMflUyxmPaHwirAm6j6x994yn5iA6qnsbbqtyMLhvZq5FEIXO7+UDUFDfIjojP2yCLGg2Sy4/SUELiO46n8339ET0gPOK2jWdL28v1emBZ7GE11g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HZIS2PZh; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb58980711so36498901fa.0
        for <stable@vger.kernel.org>; Sun, 20 Oct 2024 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729420836; x=1730025636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Big7GRyU+UAfruB67dvDyIF5xLwYENedGA5XWw38ccM=;
        b=HZIS2PZhnWzv4IJs7BMXfbMz0ge8OFJmcUmGx+y3mme3E0yxQt4v4tFNl65ypfnKzA
         0iIqzZ/U3ioS4KHo6/iwfuW30Uum13VCOC9JJismiU0h56/B67PKHBy1VzzzRRWy7YUD
         ZpfuccJ9nMzIUWf+OOmlEf6gw5omZKZzAOJGyw8g0HavQs8sY3CF3LglMa+uaNN3nVKo
         7M1UO4vZp/7OufcCYdTHZYCffcbmdmTMn/6oUW9FD45RThOUInALO66x8EdUdE/twcHT
         Dkk2fB3bDJNA3GOMPZwiAkkjrP8gn/SMethvC/MlQDIOns2R1ZcEl5N10hRTZwXSV+l5
         qKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729420836; x=1730025636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Big7GRyU+UAfruB67dvDyIF5xLwYENedGA5XWw38ccM=;
        b=o15S9Uoko/UrTTfhiW8RcW3YOMZK8YimIzV2rVGzt2FnjAoTx+5IXJYWogOlOxTFsw
         GPgNs7vm7wnEg1cV1fzHXnbcew0QdyTE49zVArVFt8CNL2/GUHtjWwYusfTDrq0YyHFv
         ioO+SALBwQ7UvzMTau0Cbfdg3zFqqdn1SWrJV6WKFwbZzjA+Z2XAddPi90ikw0Nm6eot
         lX8+CANYxiyX9AmVPDRIXUMcrDXozi0Pt2PPjxiRm9VqJOyZhtQX7CtLUvKSMzqIrvVm
         sEg1rdrzEUA0zumjCJ8p2JFvKite2fck4BTkSiOgKOhvCaOL/8bYRUHoI3+psCyb9r3P
         RNYg==
X-Forwarded-Encrypted: i=1; AJvYcCXYa31IQJIxXjBnHagnK77k1Y/uJKTbsnQFMLqSLHtbRbmkOd4lUwcdrnGFaHp6hlm4xFhirLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaIUgRF9xXOu9ieFPKKO8faaVNo5hjd/1V/Tw/uN8dTle3VYw
	k3bty5cN93IkbYU+Q1FGH/7kcnn5sf1ZiOmH8ke1Gn92Lc+BoAMH1jMpJMK2ebU=
X-Google-Smtp-Source: AGHT+IF7RhC0ss4D/GUbjaVcpKS0Kwjy6EO8ydxnPbYU8S1RzlzA0UxTIbmGS1nJrZQfTQTYhR/O+Q==
X-Received: by 2002:a05:651c:1986:b0:2fa:bb5d:db67 with SMTP id 38308e7fff4ca-2fb83260f85mr36077151fa.32.1729420834784;
        Sun, 20 Oct 2024 03:40:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad91535sm1978321fa.72.2024.10.20.03.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 03:40:33 -0700 (PDT)
Date: Sun, 20 Oct 2024 13:40:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: fix missing fwnode removal
 in error path
Message-ID: <nsmpyy736kfdn5h727bfgfd6lufecyi5kz6kfiyzndgz3xiei5@7uzrrve4q3fb>
References: <20241019-qcom_pmic_typec-fwnode_remove-v1-1-884968902979@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-qcom_pmic_typec-fwnode_remove-v1-1-884968902979@gmail.com>

On Sat, Oct 19, 2024 at 11:10:51PM +0200, Javier Carrasco wrote:
> If drm_dp_hpd_bridge_register() fails, the probe function returns
> without removing the fwnode via fwnode_remove_software_node(), leaking
> the resource.
> 
> Jump to fwnode_remove if drm_dp_hpd_bridge_register() fails to remove
> the software node acquired with device_get_named_child_node().

I think the fwnode_remove_software_node() is not a proper cleanup
function here (and was most likely c&p from some other driver). See the
comment in front of device_get_named_child_node().

Please add another patch before this one, replacing
fwnode_remove_software_node() with fwnode_handle_put().

> 
> Cc: stable@vger.kernel.org
> Fixes: 7d9f1b72b296 ("usb: typec: qcom-pmic-typec: switch to DRM_AUX_HPD_BRIDGE")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index 2201eeae5a99..776fc7f93f37 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -93,8 +93,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	bridge_dev = devm_drm_dp_hpd_bridge_alloc(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
> -	if (IS_ERR(bridge_dev))
> -		return PTR_ERR(bridge_dev);
> +	if (IS_ERR(bridge_dev)) {
> +		ret = PTR_ERR(bridge_dev);
> +		goto fwnode_remove;
> +	}
>  
>  	tcpm->tcpm_port = tcpm_register_port(tcpm->dev, &tcpm->tcpc);
>  	if (IS_ERR(tcpm->tcpm_port)) {
> 
> ---
> base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> change-id: 20241019-qcom_pmic_typec-fwnode_remove-00dc49054cf7
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 

-- 
With best wishes
Dmitry

