Return-Path: <stable+bounces-53807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A090E734
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E0B210D5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037980638;
	Wed, 19 Jun 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aAEVdF/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C959182DF
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790112; cv=none; b=d/Qha/641nYd3NvH3uZO1ihan+XLujv26KAUCShRZ7/VXNEd+EDVocBMyIzW/l+5e5SnIa5DvXo7hVepndPl/DS0im0x8aAVfWXzZWfWUU8OOVcOHQh8uMFzKfJhGY5yfKaHce5YPINpo2paFw2YNoImKizCBQzThQRCptBanbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790112; c=relaxed/simple;
	bh=rg8UCdDfSzLb6t/E4pFgdWe6dnAsphcoFZhDqV9fyhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9/nWn+T9b15TQ/RuHnHDJks3IYed2xqJYk+3n7zX15w0Xf1IUBkSErPB2FYel/Xjg5ptqHufIJuEzJwNPpIfMZll7jnOKlCR4ofrT07Jw5ULnozs5bnI73Lm4rOm6/nkTjf3+xvOjx0DonLh6qLyRPeRuuza57d2NZRdcJwngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aAEVdF/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4533DC2BBFC;
	Wed, 19 Jun 2024 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718790111;
	bh=rg8UCdDfSzLb6t/E4pFgdWe6dnAsphcoFZhDqV9fyhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAEVdF/MBEp0sWowN49/wdZ9exL8nJmqBWOiy2+d7eHHeNWbWk533BdchZU3/lVcw
	 NwtrWp6xbQB0rVeYRLD6x5wKXxh6QUOc6CY0rZ3W+pISFncZ1vrx7LCmXTGTtNpwjZ
	 c7VahiOoju3Uv5MtSop24YygHuPB80IzbcyakhzE=
Date: Wed, 19 Jun 2024 11:41:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Doug Brown <doug@schmorgal.com>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 6.6.y] serial: 8250_pxa: Configure tx_loadsz to match
 FIFO IRQ level
Message-ID: <2024061938-pursuant-dispersed-8e4c@gregkh>
References: <2024061754-ceremony-sturdily-fedb@gregkh>
 <20240619020926.502759-1-doug@schmorgal.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619020926.502759-1-doug@schmorgal.com>

On Tue, Jun 18, 2024 at 07:09:29PM -0700, Doug Brown wrote:
> The FIFO is 64 bytes, but the FCR is configured to fire the TX interrupt
> when the FIFO is half empty (bit 3 = 0). Thus, we should only write 32
> bytes when a TX interrupt occurs.
> 
> This fixes a problem observed on the PXA168 that dropped a bunch of TX
> bytes during large transmissions.
> 
> Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> Link: https://lore.kernel.org/r/20240519191929.122202-1-doug@schmorgal.com
> Cc: stable <stable@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit 5208e7ced520a813b4f4774451fbac4e517e78b2)
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/tty/serial/8250/8250_pxa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
> index a5b3ea27fc90..2cbaf68d2811 100644
> --- a/drivers/tty/serial/8250/8250_pxa.c
> +++ b/drivers/tty/serial/8250/8250_pxa.c
> @@ -124,6 +124,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
>  	uart.port.regshift = 2;
>  	uart.port.irq = irq;
>  	uart.port.fifosize = 64;
> +	uart.tx_loadsz = 32;
>  	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
>  	uart.port.dev = &pdev->dev;
>  	uart.port.uartclk = clk_get_rate(data->clk);
> -- 
> 2.34.1
> 
>

All now queued up, thanks.

greg k-h

