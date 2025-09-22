Return-Path: <stable+bounces-180887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 197A5B8F246
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED78A188BB39
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 06:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166323D7E0;
	Mon, 22 Sep 2025 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTHAWmcp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD10188734
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522540; cv=none; b=aDQAhfLXzJbutcxe1pJpWgBTwyNjuDBGAvS0BSYxnxxLCCxv0Qxlhmc6/JI3wvBaPhMxe6Wn5Z4lLj7zyxkGjEziFeMJ9auM0e6ko/Il790f9vfhds6Q2zyM0c+MYsrGQSLmldQiWKuJFb9hmAfBMh8zdaX9jP/euuz44yXLfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522540; c=relaxed/simple;
	bh=jS7CeHrv/AeGZdOQ/WoM0enjwVnBDM2WkTpACOOaB8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/6QTihuWFhGLZevw82kOmTUivOTCkgDcc2UOuLoXeBYcJrT0JYPtcfS+5VHct9iJBxvsNxJyFPhl9p1gXJ/EuDSoPbjcfOvFNVOKn/I0QeLnGK8xDu90iQmnhL594wAd200f5Hh+XFZfrPHmdlakv1g1NuhTBk79/Qe17elseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZTHAWmcp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2490021f8f.1
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758522536; x=1759127336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZLlyj1lrTQJXPVDMgRBgvEm8gNKaL9UfywhFXowTYg=;
        b=ZTHAWmcpm3OyJKN8XoWT1WF2E+hQUCexKvpGkwv9x4vA0NN8Fs3urJZtlzkoJ3qkwP
         6Itrs6PIHQgC+pZkVJkzPYl5yNT15V8cVqXEr3EtWfDSq2ASIeulGZrpanAY7fcyI6ah
         IVGmFZyAnCjCPC8l58ghF/Xnpsqf6cca1QPIbZlYbCn9rc14jR/21XgUv1e23znb3cdg
         /eWgUe4fewpsOrSpGf1HIVDh3/gzcWA3MrosfjSVdvFQ586LdNYy/GnBGABXIh+VPDWu
         tU9xvY3d1QF+7wRjPhiIrmiRlGI8fhaRlY89NObd/+BnzY2eziwcGesZN1yVgh7GxT7W
         iemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522536; x=1759127336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZLlyj1lrTQJXPVDMgRBgvEm8gNKaL9UfywhFXowTYg=;
        b=n2NjMlQDDpUPRLWLso/pga6d/JPRd0qFX9MMRi/f97VbokdGs1S71KSeC3uBrKaIR+
         aq5m85q22sGp+ZYN+nsZYtp1YUO2DTpqYmbq3TdiNwpjWDBvg1FIwiwb2Hj1viG+Jhkk
         9yiiGnsWdoL2/PtnDy6uSsaakGOQ5tADs8B4062gwhymLdwuJ9PPE1XBMdBX0JCavupD
         APPmh18T7I+tA4542l92fvABjlOwp9nwTzYQ2ofvVDfwSgqE6nEm7UK+ulp36xQYqrFW
         W47XGC/aZs1jiobrqEt15yFbXCbj/2b8iPA7p7EdLuRVLS3MpaIX56Znizr7DUQbDqYK
         j+wA==
X-Forwarded-Encrypted: i=1; AJvYcCUL7/VwM6GkpHAVjkCFam9JTjDDWnivKEmoNkjsD6kkLmhWOjpmYFtnJCfw5rHLquXUHcr7qMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXKUQYkArhODfW5FK92b+VXhSJ3Eo2DmN/04io6QSiQ1mFK2V
	t1+SuKWkVCwRYY8eAqTJtTpMKYT4Q5tnlHLnamQAkKP/C4nPqYSKYqCjkjfOfNs6AAU=
X-Gm-Gg: ASbGncvcy4BNLxRUFWYvdbnmhusRUBXnoqCV0F/Rh7qGzGifyf2H9atbf5xrlaIH1RO
	MYWN4OBpMpVfx/zwt3Oyq3sf0ArhmsniJqts1zgGOnOhG6mESgJceMYxTey4HX9lUIf2e7+/yOd
	eHKTjCB6BHz6AnXec52NQ7PMXQ+mK4CoMg8fsSQIjyZeYoqS3vii4MmjYXKrOZvKNcksd9KHB9Y
	nupFUPUjbVYbVdts6lcHnGF6h5aScgzsqBB4n+X6/X5xH0iTbqZbaAX+OmiXwi1u/xrN/F993oG
	Oq1WxdsXg91hUmDjJkF0LP6nPgaIwbwWQv8+V/LdG+jtaZvvqRd7u31Rea5q8fqKYi9aYoF/4up
	K3p//+uGe1wdFZ77xrfoCJgK3eQyL
X-Google-Smtp-Source: AGHT+IEi7y+wmyoeJmcLrzMj7JBQYxtJq3v3U/Csxfuh3DcOz0vyeFncb6QmMd0G2jzMcncIY5GShg==
X-Received: by 2002:a05:6000:248a:b0:3df:22a3:d240 with SMTP id ffacd0b85a97d-3edd43ac9ebmr12498231f8f.4.1758522536140;
        Sun, 21 Sep 2025 23:28:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f0aac3fdsm183666865e9.1.2025.09.21.23.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 23:28:55 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:28:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	matchstick@neverthere.org, dominik.karol.piatkowski@protonmail.com,
	arnd@arndb.de, nichen@iscas.ac.cn, paul.retourne@orange.fr,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Fix device reference leak in fmh_gpib
 driver
Message-ID: <aNDspDsgj5I5KGLe@stanley.mountain>
References: <20250922023831.21343-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922023831.21343-1-make24@iscas.ac.cn>

On Mon, Sep 22, 2025 at 10:38:31AM +0800, Ma Ke wrote:
> The fmh_gpib driver contains a device reference count leak in
> fmh_gpib_attach_impl() where driver_find_device() increases the
> reference count of the device by get_device() when matching but this
> reference is not properly decreased. Add put_device() in
> fmh_gpib_attach_impl() and add put_device() in fmh_gpib_detach(),
> which ensures that the reference count of the device is correctly
> managed.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
> index 4138f3d2bae7..245c8fe87eaa 100644
> --- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
> +++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
> @@ -1395,14 +1395,17 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>  	pdev = to_platform_device(board->dev);
>  
>  	retval = fmh_gpib_generic_attach(board);
> -	if (retval)
> +	if (retval) {
> +		put_device(board->dev);
>  		return retval;

Do this with an unwind goto.

	if (reval)
		goto put_dev;

	...

	retval = fmh_gpib_init(...);  /* this bug wasn't fixed btw */
	if (retval)
		goto put_dev;

	return 0;

put_dev:
	put_device(board->dev);
	return retval;

Actually, this function needs a bunch of other frees as well.  See
my blog for more details:

https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

> +	}
>  
>  	e_priv = board->private_data;
>  	nec_priv = &e_priv->nec7210_priv;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpib_control_status");
>  	if (!res) {
> +		put_device(board->dev);
>  		dev_err(board->dev, "Unable to locate mmio resource\n");
>  		return -ENODEV;
>  	}
> @@ -1410,6 +1413,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>  	if (request_mem_region(res->start,
>  			       resource_size(res),
>  			       pdev->name) == NULL) {
> +		put_device(board->dev);
>  		dev_err(board->dev, "cannot claim registers\n");
>  		return -ENXIO;
>  	}

request_mem_region() needs a release_region().

> @@ -1418,6 +1422,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>  	nec_priv->mmiobase = ioremap(e_priv->gpib_iomem_res->start,
>  				     resource_size(e_priv->gpib_iomem_res));
>  	if (!nec_priv->mmiobase) {
> +		put_device(board->dev);
>  		dev_err(board->dev, "Could not map I/O memory\n");
>  		return -ENOMEM;
>  	}

ioremap() needs an iounmap();

> @@ -1426,12 +1431,14 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos");
>  	if (!res) {
> +		put_device(board->dev);
>  		dev_err(board->dev, "Unable to locate mmio resource for gpib dma port\n");
>  		return -ENODEV;
>  	}
>  	if (request_mem_region(res->start,
>  			       resource_size(res),
>  			       pdev->name) == NULL) {
> +		put_device(board->dev);
>  		dev_err(board->dev, "cannot claim registers\n");
>  		return -ENXIO;
>  	}

release_region()

> @@ -1439,6 +1446,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>  	e_priv->fifo_base = ioremap(e_priv->dma_port_res->start,
>  				    resource_size(e_priv->dma_port_res));
>  	if (!e_priv->fifo_base) {
> +		put_device(board->dev);
>  		dev_err(board->dev, "Could not map I/O memory for fifos\n");
>  		return -ENOMEM;
>  	}

iounmap();

> @@ -1447,10 +1455,14 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>  		(unsigned long)resource_size(e_priv->dma_port_res));
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> +	if (irq < 0) {
> +		put_device(board->dev);
>  		return -EBUSY;
> +	}
> +
>  	retval = request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev->name, board);
>  	if (retval) {
> +		put_device(board->dev);
>  		dev_err(board->dev,
>  			"cannot register interrupt handler err=%d\n",
>  			retval);

request_irq() needs a release_irq()

> @@ -1461,6 +1473,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>  	if (acquire_dma) {
>  		e_priv->dma_channel = dma_request_slave_channel(board->dev, "rxtx");
>  		if (!e_priv->dma_channel) {
> +			put_device(board->dev);
>  			dev_err(board->dev, "failed to acquire dma channel \"rxtx\".\n");
>  			return -EIO;
>  		}

This needs a free too.  There may be other things outside of what I
can see in this email.

> @@ -1517,6 +1530,12 @@ void fmh_gpib_detach(struct gpib_board *board)
>  					   resource_size(e_priv->gpib_iomem_res));
>  	}
>  	fmh_gpib_generic_detach(board);
> +
> +	if (board->dev) {
> +		dev_set_drvdata(board->dev, NULL);
> +		put_device(board->dev);
> +		board->dev = NULL;

I explain this in my blog, that the free function should be a cut
and paste of the cleanup.  So this stuff isn't done in the cleanup
so one or the other of these is not correct.

The question is should this be done in one patch or several patches?
Adding cleanup to one function is generally considered One Thing
in terms of One Thing Per Path.  If we were going to backport bits
of cleanup to different stable kernels then we would want to break
it up into the easiest way for backporting.  But realistically we're
not going to do that here because this doesn't affect real life
users generally.  It's just from review.  It's not a security patch.
And this is staging as well so the standards for backports are not
necessarily as strict.  (Staging drivers are often really really bad).

regards,
dan carpenter


