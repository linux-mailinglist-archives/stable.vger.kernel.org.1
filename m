Return-Path: <stable+bounces-165603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC93B16912
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 00:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707A516A673
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 22:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2465221F24;
	Wed, 30 Jul 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cdoZlXYw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580F1F2BB5
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914801; cv=none; b=SstzxLgA9iXZeFlC8L221jpstMDxsyNKmU9jEJgfRoho6QFYzPrb5hA2CrxHAmnJ7m5sLB1BiL9F6yvdm2DV97Et36Qsa6pNYhv1ZiJQi8GA2oW0d2iG0q30ovnTx2Bw7bmGxy4Pxyi6tlagMp5l9ljAIllAzBAWcHJZeEhGAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914801; c=relaxed/simple;
	bh=CBP7jso/Xp5ZMfEj8/eklaWto5oiOkPvduOFttctQ1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rCPwnVzkkq85kWxugUaGCCT0AkM1j0R2+fb41PV2m3IUbHJ1WIvniuHXNQZ3VNrKYkuI3WeMGv3ihY7GxHyw7wUZ8Pn9stjeI0pGR0RPi7JtGPNqxmVplg+vkDzBkPUifKRTfP1qwqNBn5zXDzZIaWkzf4k6THPrX3jVvh07hOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cdoZlXYw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24099fade34so3495935ad.0
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753914799; x=1754519599; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps72b4v6Wc6/nkbPn38PGEcuWdxubn4Q9XVtS2h3BXc=;
        b=cdoZlXYwHsafghJfUg9vgvE7zbEXDUtKyzPaKCtHy06F/1sYbEpjUXczjbJKPBgnQ5
         +b2vkNVFUUmtc8f3OaOQ1DUZ3e+QmnKOikNKEH7bIHCVUcPLXEe5Cbg+aD4lFB3nX5FF
         JyliPeyFKr+lRMQAzPb0hR9MpB7tJtNm+MYmBvYqJyph9OjHjQN8ugeNfEXdP8sAZtjX
         pSRPSFurk4Lu8Emk5sgzyFIWkWIbFN8sSZ5WyIby15WriDMAqGiLfb5//J6OwS2j5TkE
         p5pcVmx4IPmnz5+dC5C83CQWvez9qNhEma/pdgyuKiqJYcibzIPGof7ov7QLSmxOVCYd
         PjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914799; x=1754519599;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps72b4v6Wc6/nkbPn38PGEcuWdxubn4Q9XVtS2h3BXc=;
        b=ikfmgyim+jq7oWuuO+pFyt58nPmVZipaWkrcAtMGgt8kDKdQlRpbFAobwzMGXzuGPO
         XZA8tN1nDFiK44uNFtN94sPYw/foZaPIlWJFmFYZFRfcngUMFwBVzE7h8Vs+9Fx/htgk
         yjwmEjC1vLHIsIMNNZ4f3BxoJxHJJ6luu/B7EWizZYDduvjzcGaqncH7sn9DvWEiBHMG
         0EcHbKBPctb3vM2FRBSecZ94/wt014VLAsMkab0wjxjxpglTqJvyWjne2lyAO+oiDp3h
         diG7OLK5e1QUd0yKNBqhPvQE+Q0GIIq4Tzf368o54D/qRv4yA8tBwoxOIZCqK1hBPk+O
         By5w==
X-Forwarded-Encrypted: i=1; AJvYcCXKN6sMw/GTHH0A9/ZnWgkEcZqIFXsmQON/e/Z8ahLd6i2bINz4UdL35VDqs6Uy49tQr5pYORM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhjh2h6u/HTJ1RdAHnK5jtSo8k1+GjdjtXv77o4L1qzRPj4nhZ
	tf8LovQAv2Dx/dAJpgczS/UkGyeZoSqUDPumrv8I4V3/OLqmNXtC9R2qgMQyOvsQA9I=
X-Gm-Gg: ASbGncu1c1JvEQcpArcmSwukV27CFBWN99yDIB+f3npF253xOC0VnNWLgeHdRnolam2
	OYEwmeb3PA9lLOWeGRSA/8BecSUKOhWkal4Z1Apj3wRmop8pQoXqFfFQDk5HmHHRd7iMaCClmza
	p4XJRlSUXeg/uXQwpfNedHh8Os319B3n4yDkuAZiAMgUq3d9NUmQ+8VPpZwRtg7vTE1DzE8knWf
	2ZhyQKeYXdrq3yMCSElpmYU2bECE/KyMTkZCFRXmPCjSF7+oRxeLAuCS7+DjwPwcev+xBlgiFmr
	NpeYhb4wy7vfDXInM1sFy4PC/tpA27tGkJwtMEe08G/MsPUepqoJPjvxZ+xpEBhDDN/OrUz6BjU
	rW3TouT6RMvEO96ojG1EC
X-Google-Smtp-Source: AGHT+IEeqos7CIku+zP9/irmW0u5wzQb5lU9PgyKItg6ERfePipoY9vyNWFmppJ8TSOaNVwTJTDdkA==
X-Received: by 2002:a17:903:41c4:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-24096a47498mr85346865ad.1.1753914799167;
        Wed, 30 Jul 2025 15:33:19 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a814sm1291845ad.117.2025.07.30.15.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 15:33:18 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Bin Liu <b-liu@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 stable@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 4/5] usb: musb: omap2430: fix device leak at unbind
In-Reply-To: <20250724091910.21092-5-johan@kernel.org>
References: <20250724091910.21092-1-johan@kernel.org>
 <20250724091910.21092-5-johan@kernel.org>
Date: Wed, 30 Jul 2025 15:33:18 -0700
Message-ID: <7hqzxxb975.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johan Hovold <johan@kernel.org> writes:

> Make sure to drop the reference to the control device taken by
> of_find_device_by_node() during probe when the driver is unbound.
>
> Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
> Cc: stable@vger.kernel.org	# 3.13
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/usb/musb/omap2430.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 2970967a4fd2..36f756f9b7f6 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -400,7 +400,7 @@ static int omap2430_probe(struct platform_device *pdev)
>  	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add resources\n");
> -		goto err2;
> +		goto err_put_control_otghs;
>  	}
>  
>  	if (populate_irqs) {
> @@ -413,7 +413,7 @@ static int omap2430_probe(struct platform_device *pdev)
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  		if (!res) {
>  			ret = -EINVAL;
> -			goto err2;
> +			goto err_put_control_otghs;
>  		}
>  
>  		musb_res[i].start = res->start;
> @@ -441,14 +441,14 @@ static int omap2430_probe(struct platform_device *pdev)
>  		ret = platform_device_add_resources(musb, musb_res, i);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to add IRQ resources\n");
> -			goto err2;
> +			goto err_put_control_otghs;
>  		}
>  	}
>  
>  	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add platform_data\n");
> -		goto err2;
> +		goto err_put_control_otghs;
>  	}
>  
>  	pm_runtime_enable(glue->dev);
> @@ -463,7 +463,9 @@ static int omap2430_probe(struct platform_device *pdev)
>  
>  err3:
>  	pm_runtime_disable(glue->dev);
> -
> +err_put_control_otghs:
> +	if (!IS_ERR(glue->control_otghs))
> +		put_device(glue->control_otghs);
>  err2:
>  	platform_device_put(musb);
>  
> @@ -477,6 +479,8 @@ static void omap2430_remove(struct platform_device *pdev)
>  
>  	platform_device_unregister(glue->musb);
>  	pm_runtime_disable(glue->dev);
> +	if (!IS_ERR(glue->control_otghs))
> +		put_device(glue->control_otghs);
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.49.1

