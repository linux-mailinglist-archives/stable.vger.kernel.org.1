Return-Path: <stable+bounces-179591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE6B56CE5
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 00:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81F354E1398
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 22:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB4221269;
	Sun, 14 Sep 2025 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LJyyPdZh"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80E23B0
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757889349; cv=none; b=IG7d3b/nuGZBQ5zWK090IRW9Q6nYCqbsQ4uC50rrEY1/8neWu+ZBS49QLlpwrrOcBMbsYyKQ04IqtclaO/2d8R4zwQze0DluSux0Kcni4We94lJ6CLyC6rE/32zTeSpB99GluYaLLbi9/S0zXZCOPob2nj7Ci7TvOwRsUzp2FwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757889349; c=relaxed/simple;
	bh=SHRqWZStk4jjsfVvVO8cy3nO5bV41blXrDgUeD33Ejw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVLfS478SoIJf/nGVUTqZazUwZUTt4NvxaIynqODMoI6/NQGP/1r+AqeF3MvFLhu53UN3TDTeHNAnZY6AJWU5bvqEdufg3wihFq8+Uvt8v8qPLRQvAWNvJJqbXF/RV76ScpRfrSG+NoLuf3AJLOBaVtWUXKrWwslwbeVNew0j2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LJyyPdZh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B751F1A0DFB;
	Sun, 14 Sep 2025 22:35:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C9C46063F;
	Sun, 14 Sep 2025 22:35:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DCA7102F2A7F;
	Mon, 15 Sep 2025 00:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757889342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uS+VvMqb+a9u8UaM1CIJlh7p5HYzlaJPl5trvc+YJcQ=;
	b=LJyyPdZhcMlBCqhzaVq9bSNCh0bh0BqoF13nVbahmwH8z73aKoDNGvGZZ14i3pWBtjPNGj
	jDfQ4a+2GysGbCzvk+WyKg0W7Zd+dnpeFROpP7ybLemlREvOpXYWqW38IgFIjtm3hbKk1X
	BtWcYCdq6XhH67Q1h9AT6ajphZTUvw272GXwGSwSSJgdcAUqBBtpWOWYEe8qtSoarwEGl4
	QQiYUOPIWUwvEUZoTN0KJhRIX/D53VDeJeZUDWfojg27BOGc8ZgiELC3KIleJWrnn8DjVX
	GnPkCAhN41ytZPMspY2CAMz+4qEOR+JOqTZGBUYRtIKseQBGg0aCPF4WWe9uag==
Date: Mon, 15 Sep 2025 00:35:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: linux-rtc@vger.kernel.org, stable@vger.kernel.org,
	Elena Popa <elena.popa@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH] rtc: pcf2127: fix SPI command byte for PCF2131 backport
Message-ID: <2025091422353715503104@mail.local>
References: <20250820193016.7987-1-bruno.thomsen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820193016.7987-1-bruno.thomsen@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Bruno,

I guess you'd have to send this directly to stable and gkh so he wll
notice it.

On 20/08/2025 21:30:16+0200, Bruno Thomsen wrote:
> When commit fa78e9b606a472495ef5b6b3d8b45c37f7727f9d upstream was
> backported to LTS branches linux-6.12.y and linux-6.6.y, the SPI regmap
> config fix got applied to the I2C regmap config. Most likely due to a new
> RTC get/set parm feature introduced in 6.14 causing regmap config sections
> in the buttom of the driver to move. LTS branch linux-6.1.y and earlier
> does not have PCF2131 device support.
> 
> Issue can be seen in buttom of this diff in stable/linux.git tree:
> git diff master..linux-6.12.y -- drivers/rtc/rtc-pcf2127.c
> 
> Fixes: ee61aec8529e ("rtc: pcf2127: fix SPI command byte for PCF2131")
> Fixes: 5cdd1f73401d ("rtc: pcf2127: fix SPI command byte for PCF2131")
> Cc: stable@vger.kernel.org
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Elena Popa <elena.popa@nxp.com>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index fc079b9dcf71..502571f0c203 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -1383,11 +1383,6 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
>  		variant = &pcf21xx_cfg[type];
>  	}
>  
> -	if (variant->type == PCF2131) {
> -		config.read_flag_mask = 0x0;
> -		config.write_flag_mask = 0x0;
> -	}
> -
>  	config.max_register = variant->max_register,
>  
>  	regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
> @@ -1461,6 +1456,11 @@ static int pcf2127_spi_probe(struct spi_device *spi)
>  		variant = &pcf21xx_cfg[type];
>  	}
>  
> +	if (variant->type == PCF2131) {
> +		config.read_flag_mask = 0x0;
> +		config.write_flag_mask = 0x0;
> +	}
> +
>  	config.max_register = variant->max_register;
>  
>  	regmap = devm_regmap_init_spi(spi, &config);
> 
> base-commit: 880e4ff5d6c8dc6b660f163a0e9b68b898cc6310
> -- 
> 2.50.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

