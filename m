Return-Path: <stable+bounces-119800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00EA47593
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02BC188ED1C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58812192E7;
	Thu, 27 Feb 2025 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOztkfhi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8709217654
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635724; cv=none; b=pTvR37qmkG7zZK6W8O1HbzpZugLqPcME40oGxyfSX/z0EqKkushwExZsrQkkXbJ9PKxGYgNI+3T5yUCh3yMCa1Wnj4tt1nZzpMif6J5w/uVS+dt6smex0metqalKcdEDd1ygPUT0GxpwVMxbY9wzzu7ZFfkDK929Dg/FPGuj05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635724; c=relaxed/simple;
	bh=a16PvwGm4qBXlLLL+417IRkJ59dGv0+RH3qh8OGB5uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCeeup7xx6dvQWdylfy/nYRHsgILfXH7YZ/qf7COk1qQZwywoe7m5zwrAG7j+xpZl1VWPqvr1lbHkxLoqmGQIV++GHb50a85v+pCKaVGWWiAhl4RSyJ77ZJgdv3ZK9N3x0dmodPRiPB8i1QE6ShcOBF806YVk2L7bw3pxn+Bx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOztkfhi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso654172a12.1
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 21:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740635721; x=1741240521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRjkJZuFXwrWKhSpmIetOy8zuA4supf8coHnaUjnRXM=;
        b=MOztkfhieG3QwCVFRhKOpGwbrP53/vISRtW6S8zjNjc15S8DLHypX7hZyQ3JgqEs3W
         TppJ1N5N8ZXmiwL/PtNNJNhFI++88dYIt7ayHF76MmZvsZ7PLwkToDbkT00CwPsPTdAk
         MbcVsagEM6IAEUh4WD7j104pyZ0BVcAF3xXNmGAp/keR6KKNds8OJ0n10ZJUaLpvqbPo
         OsQscQQ+R+wlIZnfbXa+OpCxAY7P5rEK1h2msFNdX3ZZ/5E0dIghiNXiH6tcLKcVXjKP
         SgWvp1Yub4EmvsSwCicLXX06YpnsaBLAgTuYKW03x4bNqkuIyc9dxgdmgEkPOGW5tkj7
         RcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635721; x=1741240521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRjkJZuFXwrWKhSpmIetOy8zuA4supf8coHnaUjnRXM=;
        b=Nel+lHmeLWeHRJU5ES3HhfcJyJM2Eh0TqKcATfbYMkPshyy9mi5B8FY3Hwu2LUzZnX
         mOue1qUKlsXVirdDT5iYAvuw805ZGKbgNgObRuS5lwJu92U+ySqspP+gdo8MREmai3BY
         nkc3NiyGvppxrCBSdTmQ3rAtFXtUZEdWN1Z3tGrxhR+Sy0LtAzUoTPfiQUq2wSD389F6
         gLUgAo+tk3lHEfQzzds2NvESFIDQBrdACYq3qRdmgVs7aXoNuYqN/s//EKweVqHxHnHm
         /j2cRzi+/Xn04aX8IKTGbRzfHt5YpFZR3QHLpHwOm8KpqIQZJ/TOsenk/4l6RdyGL/8U
         62Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV9s/ZUAwwt2P6mcmTABcYpduyn0spuiGpQuXR578xKcTxUPNRO8rGqCM2NjRTJpuExNJm7rGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjB3B5OsKRxv4cOilJi7C3+PV2jt/092j3LfnglruIUkdFYpn
	Kq5DDC8yrHfhuNPOr6Vh2T19Nb9pii0UA7orZJxawlw9aV8hIzyxUMHcjJqJ2LE=
X-Gm-Gg: ASbGnctje9Qf8ZdtIR6a6HB3Hb7XsgTnRAI7EYNZn+qPcwX4+aN322wVI6Sh6oZq/hi
	nH2A1e/nqLujmiBD/MTvMxZcHp4NJ7xz90JdGtgBuVmp5B3EB5/vIWppvcfxeb5tueOpaTYbTRC
	t/50ix+L2D1XCLQcLc8mbAWNjeZe1N+Se0+HtFB0UcNyi00VAgcC6gyYZZneRc8ue1F89xHPrvU
	Lj9lqMsu7Hsk98IKKyPPTfL5XwsT1/+c6MNraYoDciUhMpOIsD5owdD/r8X66iZvDWCwYjxlcmw
	qUQSTemux4zm3o+fQo/5YKFCpE6TN4w=
X-Google-Smtp-Source: AGHT+IF7QEecXEFd6GRvVvQxUkIk6G36vs7TrNq5mJmrzU0yTJVfAsEa/DfPng5kBj+wVjn1N7h90w==
X-Received: by 2002:a17:907:d8d:b0:aba:6378:5ba8 with SMTP id a640c23a62f3a-abeeefd2b42mr753662166b.55.1740635721079;
        Wed, 26 Feb 2025 21:55:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c0dc6adsm66911866b.55.2025.02.26.21.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 21:55:20 -0800 (PST)
Date: Thu, 27 Feb 2025 08:55:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com, error27@gmail.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix an API misues when rio_add_net() fails
Message-ID: <9b3d1ab0-1313-4f87-9b98-15dd78ca24a8@stanley.mountain>
References: <20250227035859.3675795-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227035859.3675795-1-haoxiang_li2024@163.com>

On Thu, Feb 27, 2025 at 11:58:59AM +0800, Haoxiang Li wrote:
> rio_add_net() calls device_register() and fails when device_register()
> fails. Thus, put_device() should be used rather than kfree().
> 
> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 27afbb9d544b..cfff1c82fb25 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -1742,7 +1742,7 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
>  		err = rio_add_net(net);
>  		if (err) {
>  			rmcd_debug(RDEV, "failed to register net, err=%d", err);
> -			kfree(net);
> +			put_device(&net->dev);

Yeah, you're right.  But the worse bug is that we're missing an
"mport->net = NULL;" before this goto.  It leads to a quite bad
use after free issue if we trigger this path.

Please fix that as well and resend.

regards,
dan carpenter

>  			goto cleanup;
>  		}
>  	}
> -- 
> 2.25.1

