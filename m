Return-Path: <stable+bounces-111982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051D2A2528B
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 07:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB7E3A475B
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F01D86DC;
	Mon,  3 Feb 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DkNGtS3Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4728F4502F;
	Mon,  3 Feb 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564689; cv=none; b=ZVU7vUCmqjkLWHL9rn3/+7RPYGnLa431+rQukCDURbqB6kEWbL1/eyHQkZT5tKepFu06JrBHxfLoF4axixMO65egiTmhJxIJlkKpUnlYl/5t40watls0gWy0gzTPJvk2kzoE9nrApnvqxxiYNFdBAqEtTrjLavB36bUJ0LhzxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564689; c=relaxed/simple;
	bh=4ZAGAaI9Vpn3TPg4K2QrvEklxrVNZBoiXZohN6WtLQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcTXEenLrH3c+3t1CIR/iHzPqvl7ijfQ50Cmr6Gv4MeXrlH/AzFH2ZULWi/JUfBd5LgKNmE0eUngI6p3FqcvZzqM3ZwP1/7nEaMvZjID/B9XhIZcWs2vvvu54lEoB5NP9mUaC1YrejELU3itGJGL9GXqgDaBTG6Lw/djs5dlBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DkNGtS3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCBBC4CEE2;
	Mon,  3 Feb 2025 06:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738564688;
	bh=4ZAGAaI9Vpn3TPg4K2QrvEklxrVNZBoiXZohN6WtLQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkNGtS3QZHpyMACWuq6EfWWUCl66GD3eyZJXyD/78av3l/dHqp7YiUBBznGpsmA10
	 pOuuBb+OXmXgg7sZhF30TScA+nD2+TgTgNMXDH8a2OhQwaOkeJ+Tw2AGDm+fZa55Pg
	 RnGEa70bMbqNYFWFqRyH0q1rCvfbaipv/bX7BW1c=
Date: Mon, 3 Feb 2025 07:37:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: broonie@kernel.org, rafael@kernel.org, dakr@kernel.org,
	mazziesaccount@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] regmap-irq: Add missing kfree()
Message-ID: <2025020351-cornfield-affix-8cf4@gregkh>
References: <20250202200512.24490-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202200512.24490-1-jiashengjiangcool@gmail.com>

On Sun, Feb 02, 2025 at 08:05:12PM +0000, Jiasheng Jiang wrote:
> Add kfree() for "d->main_status_buf" in the error-handling path to prevent
> a memory leak.
> 
> Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  drivers/base/regmap/regmap-irq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index 0bcd81389a29..b73ab3cda781 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -906,6 +906,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>  	kfree(d->wake_buf);
>  	kfree(d->mask_buf_def);
>  	kfree(d->mask_buf);
> +	kfree(d->main_status_buf);
>  	kfree(d->status_buf);
>  	kfree(d->status_reg_buf);
>  	if (d->config_buf) {
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

