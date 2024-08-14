Return-Path: <stable+bounces-67626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A49518C6
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E981C22171
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22831AE02D;
	Wed, 14 Aug 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RnV9NQLT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74D1AD9F9;
	Wed, 14 Aug 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631328; cv=none; b=JfqNyt7vzwjlCgijjjPP6DJQgwyowt+DdI7pxwF+Q9vvN1h7FYHnmsRL0UNUOgGjgecUp9ii5TF4FLvj/l1yeORp71zO8v12HUDlB/+KwiB0r9H9e9sU5cUeQEm5287VSkXg2b9ADjTSZ1KH0mWEWgWa0vJLfDKYjWTPSx6jHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631328; c=relaxed/simple;
	bh=PYhboboW0J7yyThkK/Ip75Zay3YzaZ/i0K2pgWRQvY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBgS7hJ7rXe9qqqrmtX4uo225LNgnzlMbdxp3j87iqHAX+LGbJbSmMFR5klDDKI6Z9dKe9lEpANcHcL7zQlyFqCqJCctFfCrPd9Xi5gZUwKfIxRNEeaPCfTbxU+ZDrLedLiYLIHhXv+9a2K8rYORFNMlqKiv5sLKXxDCjO4p1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RnV9NQLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501C0C32786;
	Wed, 14 Aug 2024 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723631327;
	bh=PYhboboW0J7yyThkK/Ip75Zay3YzaZ/i0K2pgWRQvY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RnV9NQLTJGQpmtw5XXgIuFkYXHrqahohgcRLQdoqXZqB2wptiZAi/8RlzIO3kwvcC
	 XC+Ly4yAV3CzPI86hfN8gtkIYuBro+V8qhFBtM1716hdiwcisx4wu2DWdKW/ddUnkU
	 YKutAoNzhB+hxEcmBBsyxrM++kNG85NsprAnvkb4=
Date: Wed, 14 Aug 2024 12:28:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jirislaby@kernel.org, u.kleine-koenig@pengutronix.de,
	tglx@linutronix.de, zhang_shurong@foxmail.com, B56683@freescale.com,
	cosmin.stoica@nxp.com, stefan-gabriel.mirea@nxp.com,
	Larisa.Grigore@nxp.com, matthew.nunez@nxp.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: Add a NULL check for of_node
Message-ID: <2024081416-gigabyte-stuck-2d4d@gregkh>
References: <20240814101520.17129-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814101520.17129-1-make24@iscas.ac.cn>

On Wed, Aug 14, 2024 at 06:15:20PM +0800, Ma Ke wrote:
> The pdev->dev.of_node can be NULL if the "serial" node is absent.

When will that happen?

> Add a NULL check for np to return an error in such cases.
> 
> Found by code review. Compile tested only.

So this never can happen?

> 
> Cc: stable@vger.kernel.org
> Fixes: 09864c1cdf5c ("tty: serial: Add linflexuart driver for S32V234")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/tty/serial/fsl_linflexuart.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index e972df4b188d..f46f3c21ee1b 100644
> --- a/drivers/tty/serial/fsl_linflexuart.c
> +++ b/drivers/tty/serial/fsl_linflexuart.c
> @@ -811,6 +811,9 @@ static int linflex_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret;
>  
> +	if (!np)
> +		return -ENODEV;

Again, how can this happen?  Probe is only called if the platform device
is found, so why wouldn't the of_node pointer be set?

Don't check for impossible things.

thanks,

greg k-h

