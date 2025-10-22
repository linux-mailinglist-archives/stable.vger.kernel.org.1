Return-Path: <stable+bounces-188955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBD5BFB416
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AE29504C8A
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809431B11F;
	Wed, 22 Oct 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNqJ5pC8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CDA315D42;
	Wed, 22 Oct 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127067; cv=none; b=BYwi8iK4LqoeUgWcmxwwcSEdXmclcuAj0+YHd2LY5srezEq73pxm8YfO5QthaBMxDlUuLU9tHQ0BUb9AOm3VmtZTvzUcRIp2Dj7qVL4kiDDfpzfnME4lSwpdRLvfUyEyW62benlbW7xFaaRBU38IT8S08ALFHq8kdGTQup+pyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127067; c=relaxed/simple;
	bh=7A1KpfR0RlRnCRdnu9t09fhdInNhsVZdUl5tQbeore4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DURIyVocZ0kOhPAgIDqGUNXuh3jpGR3PMSQk0AYZr+BAONpyUUt3ttoMiFPNbfnhCnKcCMr5MoCRGDLMy+zjlI+40wBhffLdm6zed7q2CAVdCK29P6uUM3Elymm0WkQStx57fy3YcdKtOUaNIXJhiL4t34vXi79EASX2/W5M5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNqJ5pC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A439CC4CEE7;
	Wed, 22 Oct 2025 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761127067;
	bh=7A1KpfR0RlRnCRdnu9t09fhdInNhsVZdUl5tQbeore4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNqJ5pC8uPR3bKmyL5D+Cnsj3weyAt9W5wzH2U2cZSVdz4LX6KZlTeTGZy6+D8gnI
	 J4+ebKDXyoNd/ohCcjVlTldhy4ZKSCGFZ1+GjZOLM1H7yXCOva1HGOrgRvBdcAKyiJ
	 2uT9CRW8lCLJON92XOhx84HYrhbio+SqouzQB5aw=
Date: Wed, 22 Oct 2025 11:57:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	songmuchun@bytedance.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250: always disable IRQ during THRE test
Message-ID: <2025102231-fender-bovine-ecd9@gregkh>
References: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016070516.37549-1-zhangpeng.00@bytedance.com>

On Thu, Oct 16, 2025 at 03:05:16PM +0800, Peng Zhang wrote:
> commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
> has been set up") moved IRQ setup before the THRE test, so the interrupt
> handler can run during the test and race with its IIR reads. This can
> produce wrong THRE test results and cause spurious registration of the
> serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
> short duration of the test and re-enable it afterwards to avoid the race.
> 
> Cc: stable@vger.kernel.org
> Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 719faf92aa8a..f1740cc91143 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct uart_port *port)
>  	if (up->port.flags & UPF_NO_THRE_TEST)
>  		return;
>  
> -	if (port->irqflags & IRQF_SHARED)
> -		disable_irq_nosync(port->irq);
> +	disable_irq(port->irq);
>  
>  	/*
>  	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
> @@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct uart_port *port)
>  		serial_port_out(port, UART_IER, 0);
>  	}
>  
> -	if (port->irqflags & IRQF_SHARED)
> -		enable_irq(port->irq);
> +	enable_irq(port->irq);
>  
>  	/*
>  	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
> -- 
> 2.20.1
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

