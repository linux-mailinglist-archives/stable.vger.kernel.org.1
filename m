Return-Path: <stable+bounces-116436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B51A3642F
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C2F16D18F
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D5F267B81;
	Fri, 14 Feb 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKUaBru4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB362676D6
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553258; cv=none; b=onscYCPx298Qm8VyqpWPAdwy3ebUB7p6+Wr/qPR4cCt096nsnkgYD+o9bKXNgT8dMa2QRmgT1mKlm/nkQaLWnV+QaSZ9fNb1Y1LuxdSdVzyO+tCk+G7YaQY8+RnzkqqWc5IkliVTjvWSyUxonCwNoj9ZVOjFocI7jS0n8hR/TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553258; c=relaxed/simple;
	bh=GCT3tjmLaUYH2vmBJeZHXbttCdIkYNXzAdwNeEZ+HwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3LCaekhUAyORsyNOOULPkMXdwdqX9Jcc6WLhxPJirR/NJo3rGvvLlPVys7W78Dq6RuTEqvcK+kosB5DmjsqK9/jQIdugvRpvwOSg+MZnWgRFyVJqFRSOXqEkjBpTv0WnSnQ9aRkBwAzgsGKDKRcDXgCOLblrnq4Fo26OdH/tGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZKUaBru4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220bfdfb3f4so48635025ad.2
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739553256; x=1740158056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73h6zgdjYwKV/mV0oFHEsq1W810FrZfJYhYEewVFptA=;
        b=ZKUaBru44S9sCHWC+mMzy7pfykjEvSR1+6AKvetGONum7hQyEdJnbIn0Wy6RUJmc9e
         jZvJh29g0hn2JYku5RS+w3KVwtqQkgoMXYXsMaEmf5g29V/wf481ScU6B99bj2f3sVNW
         XkXo4qtNgPQVQOtfhVf7te/gGbBlFBYJITOM3n/lFkKMs1SY9TT/hjt2yFlfQya8jhg3
         IOzC4YG5f5UGQyEJuQdbE5BM2Jinlpu9GEbjz8A0CrnRx3ez0ogoa5j05tQpi2RhjtlR
         mXqu/ofXiaLoHv+Rn8QGAcOut+lxR53eM00l2JFgk5eezsvbdUTMQLJecvocAkrwBsUD
         EqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553256; x=1740158056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73h6zgdjYwKV/mV0oFHEsq1W810FrZfJYhYEewVFptA=;
        b=oLxU2sELBWfXq1uHklXZdKP89KEcPqBmTE56qfQcQhx2MQjtXmETcPGvx9EgJs6Iy9
         nRchwaTzHXfh16dGPxWKR/WB1yuapQuWJBIbA1SdF2zjMolr8iEdHvuNS0t8JgdtCETS
         e6wFxghOctpxFHe7F7K01fRVKFkbrT1ioolGsbHJGE+09cXKleF0OzePjt9gI3utY5pL
         VMuyDcvVdQjL1UQZm9N1/7Q2ZgoTxB/UEIzI2knW9rl1CnEebr5rIUK6/R2LC5dF0wZv
         I8fKexQNFZKBHYxJlWbL9ChIWWHXM95XnxFpr8dR1gXkyJtDcu0o0DiLrz1CG3tl+ZpA
         2sbA==
X-Forwarded-Encrypted: i=1; AJvYcCWcjXPugeWPtg07inhQRjHeUXpdEZu94RRLuvfUNAc2Z2JOth/3dlY7P2tZ7dGW9PFwvI+7rzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnFKy/gm1+repDlPs2FHG2wLYryBhnijlLAk0638r2NeLmDSC
	u31sK4FQMVXVL2JDOyDcfbH0UfTgtgMEu+2BMVnyf03myaUruHeIMWO6CCWMRQ==
X-Gm-Gg: ASbGncuj5xgrn1LQOTTbp18Lvvon2RPUIxuuM8IQ4HZY3NKQpbWxDq/UAFHUYvuvSgl
	8VgPIA4f95v1yXEEfIDrSpyhZ4gftguez+QtbZmlhnNxlmsASQ557Bu85fXFPIsFzDhXbI++gYQ
	oIutGGVTU9bwpUm/8Gi40fMxVvlAVlXA8r5Ti43OGelMjmrjnjnERXDDKEo173Aw141bTWDX8uN
	nvGrZoen+GP0O6KzAMj8DH9bshfRysGuiUje7lRaglFQSbUyCXZPCid0pEup/5smWekf4dlZAQQ
	ItqjzF6A4NNiGamQ/brsdbtAWBM=
X-Google-Smtp-Source: AGHT+IGEjW1+nSnm03Sb/7JjOqd2fLGFWNtn2pSYwsh2yOQR3S+BitUF4p8rbuVp0ACw3TNqwyLoRw==
X-Received: by 2002:a05:6a00:4fd2:b0:732:1f45:fcca with SMTP id d2e1a72fcca58-732618fa57dmr185138b3a.21.1739553256278;
        Fri, 14 Feb 2025 09:14:16 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm2520712b3a.75.2025.02.14.09.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:14:15 -0800 (PST)
Date: Fri, 14 Feb 2025 22:44:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Amit Singh Tomar <amittomer25@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: owl-uart: fix call balance of owl_port->clk
 handling routines
Message-ID: <20250214171405.kvyyespxtfqxhapc@thinkpad>
References: <20250213112416.1610678-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213112416.1610678-1-mordan@ispras.ru>

On Thu, Feb 13, 2025 at 02:24:16PM +0300, Vitalii Mordan wrote:
> If owl_port->clk was enabled in owl_uart_probe(), it must be disabled in
> all error paths to ensure proper cleanup. However, if uart_add_one_port()
> returns an error in owl_uart_probe(), the owl_port->clk clock will not be
> disabled.
> 
> Use the devm_clk_get_enabled() helper function to ensure proper call
> balance for owl_port->clk.
> 

Do not use newly introduced APIs to fix old bugs. The bug should be fixed
separately to allow backporting and the conversion should be done on top.

- Mani

> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: abf42d2f333b ("tty: serial: owl: add "much needed" clk_prepare_enable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---
>  drivers/tty/serial/owl-uart.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> index 0542882cfbbe..64446820437c 100644
> --- a/drivers/tty/serial/owl-uart.c
> +++ b/drivers/tty/serial/owl-uart.c
> @@ -680,18 +680,12 @@ static int owl_uart_probe(struct platform_device *pdev)
>  	if (!owl_port)
>  		return -ENOMEM;
>  
> -	owl_port->clk = devm_clk_get(&pdev->dev, NULL);
> +	owl_port->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(owl_port->clk)) {
> -		dev_err(&pdev->dev, "could not get clk\n");
> +		dev_err(&pdev->dev, "could not get and enable clk\n");
>  		return PTR_ERR(owl_port->clk);
>  	}
>  
> -	ret = clk_prepare_enable(owl_port->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "could not enable clk\n");
> -		return ret;
> -	}
> -
>  	owl_port->port.dev = &pdev->dev;
>  	owl_port->port.line = pdev->id;
>  	owl_port->port.type = PORT_OWL;
> @@ -701,7 +695,6 @@ static int owl_uart_probe(struct platform_device *pdev)
>  	owl_port->port.uartclk = clk_get_rate(owl_port->clk);
>  	if (owl_port->port.uartclk == 0) {
>  		dev_err(&pdev->dev, "clock rate is zero\n");
> -		clk_disable_unprepare(owl_port->clk);
>  		return -EINVAL;
>  	}
>  	owl_port->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
> @@ -725,7 +718,6 @@ static void owl_uart_remove(struct platform_device *pdev)
>  
>  	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
>  	owl_uart_ports[pdev->id] = NULL;
> -	clk_disable_unprepare(owl_port->clk);
>  }
>  
>  static struct platform_driver owl_uart_platform_driver = {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

