Return-Path: <stable+bounces-247620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLlWInLkBmoHowIAu9opvQ
	(envelope-from <stable+bounces-247620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:16:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B254C397
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 926233102E44
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDABA3E3C6F;
	Fri, 15 May 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0xwtDflI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7B25393B;
	Fri, 15 May 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834939; cv=none; b=BQFwBfCmfeWrldu+EXoFdkORXqzA5qKO32SMR88PuOZoyhW+3ikeyjqnMxHXWENVS5VRcSEqxQsZtndLd6eyU7JcZAwJKgVV0qBcJUeYB8Me0TIvqQfAATsumL/ZmmgvvCWkbLtuKQ497iI3YNrDtB6PkqqOUL00YFmW5kK7X1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834939; c=relaxed/simple;
	bh=X55FBUEWdUMR9C2/1A9kyhs0C+tKllBvYRUZQMpblyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z28Ms4AvJqKyiagMCp0pxhjiJsgsDBrkt7d/NcP5JB9jKDJxuGXPGxwrXtZI4bDTUrZREAF21ewRZZLiobC6ujsYcggbOXIp9RFf7m82mz04qq1V5JD7tKph/Kx+ayPifzbWuijljbMzYf7mSW8aoeUC1VTTknJsJBvw6HwMUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0xwtDflI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A816C2BCB0;
	Fri, 15 May 2026 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834939;
	bh=X55FBUEWdUMR9C2/1A9kyhs0C+tKllBvYRUZQMpblyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0xwtDflIa4ZMNbZEhCtdt1qFoW2JzUu3nBhqeuC2aY4HT9FmBAwfnWI9QrkKVDZRB
	 KrTN7+jdNjbghWRWLN+EHqirVkr/rz57aYJfN8nG2nY34IPuqT2nb3rz/iy0jt+pE4
	 o/o+FvN9Rl6muvYWlzvs6dExEXWWtl+piPT3LRb0=
Date: Fri, 15 May 2026 10:49:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: dpenkler@gmail.com, dominik.karol.piatkowski@protonmail.com,
	adam.quandour@gmail.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpib: cb7210: Fix region leak when request_irq fails
Message-ID: <2026051551-oblivious-wackiness-bc40@gregkh>
References: <20260515083521.62437-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515083521.62437-1-zenghongling@kylinos.cn>
X-Rspamd-Queue-Id: ED0B254C397
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247620-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,protonmail.com,kernel.org,vger.kernel.org,126.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:35:21PM +0800, Hongling Zeng wrote:
> When request_irq() fails, the region allocated by request_region()
> is not released. Fix this by adding an error handling path with
> proper goto labels to release the region.
> 
> Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpib/cb7210/cb7210.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpib/cb7210/cb7210.c b/drivers/gpib/cb7210/cb7210.c
> index 6dd8637c5964..673b5bfe2e7d 100644
> --- a/drivers/gpib/cb7210/cb7210.c
> +++ b/drivers/gpib/cb7210/cb7210.c
> @@ -1049,7 +1049,8 @@ static int cb_isa_attach(struct gpib_board *board, const struct gpib_board_confi
>  	if (!request_region(config->ibbase, cb7210_iosize, DRV_NAME)) {
>  		dev_err(board->gpib_dev, "ioports starting at 0x%x are already in use\n",
>  			config->ibbase);
> -		return -EBUSY;
> +		retval = -EBUSY;
> +		goto err_release_region;
>  	}
>  	nec_priv->iobase = config->ibbase;
>  	cb_priv->fifo_iobase = nec7210_iobase(cb_priv);
> @@ -1062,11 +1063,16 @@ static int cb_isa_attach(struct gpib_board *board, const struct gpib_board_confi
>  	// install interrupt handler
>  	if (request_irq(config->ibirq, cb7210_interrupt, isr_flags, DRV_NAME, board)) {
>  		dev_err(board->gpib_dev, "failed to obtain IRQ %d\n", config->ibirq);
> -		return -EBUSY;
> +		retval = -EBUSY;
> +		goto err_release_region;
>  	}
>  	cb_priv->irq = config->ibirq;
>  
>  	return cb7210_init(cb_priv, board);
> +
> +err_release_region:
> +	release_region(nec7210_iobase(cb_priv), cb7210_iosize);
> +	return retval;
>  }
>  
>  static void cb_isa_detach(struct gpib_board *board)
> -- 
> 2.25.1
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

