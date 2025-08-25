Return-Path: <stable+bounces-172855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78FB33FC7
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1083BB75C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA91B3923;
	Mon, 25 Aug 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6nd4XEI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3M2mO2f/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFAA1C861A;
	Mon, 25 Aug 2025 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125693; cv=none; b=F9vbHTiwDyzgxEE+9Lfwn7EDpJEA/GI53YYCN4gO7CVibKrr05Kwa8AiG5+qevuhCdiNjl4cjYLkJck/+qPTbImEQzt21Wj9lymCRdTRqaakY/PA3NgqaiXdLjuDBoGenkYcyt250RHL2MF/hD6s8gJxLflmspVGfBUwng4iVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125693; c=relaxed/simple;
	bh=drS+7Jc99v8F6SCyAYxWgUjYCvcczRNk9DipJZn+UWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkjFTESXsa5yYNocz5oj7x3wK/1w5AoEUaohN4Ybpr5Uph7P6WGT2ia26AZ3OZ0J9FZMTK7Sx/Tn7cSTRz4GRGsJVEdcsJVnR3XnlMq8r0H75BkeP+r7ALSxahl57MTEwzIJ5hnXaRAu6X3kG2fkfSM4MNfLrQ89LE2/obnv+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O6nd4XEI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3M2mO2f/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <e25ab816-f05a-4fcd-9a71-8b71e4e3c299@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756125689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq2aAFJ1dGYsKZ/Qg+GXuSNHlBTVofWi29Ow53+X4wQ=;
	b=O6nd4XEI++qqz/dVpXBbxa7IqbweJEG4/hzKUO3FKRMgoy8no8/1XeXs+SCGxqAGz1lgBH
	uk0k0n+5ZhBAjKxVpt3gKKjnZChd/LqXFZ67aRTapOV5JoV8+pI4uzJUN5AQAOAuDhvPtP
	YSvllIaDPYBiFr9Yzm+p47khoXMGgkzoBvttaJxTpmylghZViDUjP9Gv4oYjRENohsqXJ6
	LSltrlwSeAByZ150NyaWd7rRJ2yVUnGbcLXIUsrUoRI8cS+aCHC+OSviTw1uStlQ3Rs1Ng
	dNk1gZBQRWgUhiTEXwV7wQg+DGOnKXHtBMA7yWiNLkrT+kxCNmRhxGwTIPD75Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756125689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq2aAFJ1dGYsKZ/Qg+GXuSNHlBTVofWi29Ow53+X4wQ=;
	b=3M2mO2f/ILOF6DxH9S3rxCRg9bm7/1+1YNeOuXWTHa9WCHKDehIIAeB6XDV0dVJtUj+Ehl
	nHa+NUimbvcavbAQ==
Date: Mon, 25 Aug 2025 14:41:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 Michal Simek <michal.simek@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250825092251.1444274-1-martin.kaistra@linutronix.de>
 <DB6PR05MB4551C55567E135005F7E6E95833EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <DB6PR05MB4551C55567E135005F7E6E95833EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.08.25 um 13:58 schrieb Maarten Brock:
> Hello Martin,

Hi Maarten,

> 
> Why not just start the timer and check TEMT after it has elapsed and restart the timer if not empty?
> It would prevent busy-loop waiting.

It would, yes, but couldn't this cause the time between last transmitted byte 
and switching the RTS GPIO to be less than the specified RTS delay?

Martin

> 
> Kind regards,
> Maarten Brock
> 
> ________________________________________
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Monday, August 25, 2025 11:22
> To: Michal Simek <michal.simek@amd.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-serial@vger.kernel.org <linux-serial@vger.kernel.org>
> Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>; stable@vger.kernel.org <stable@vger.kernel.org>
> Subject: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO prematurely
> 
> 
> After all bytes to be transmitted have been written to the FIFO
> register, the hardware might still be busy actually sending them.
> 
> Thus, wait for the TX FIFO to be empty before starting the timer for the
> RTS after send delay.
> 
> Cc: stable@vger.kernel.org
> Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
> Changes in v2:
> - Add cc stable
> - Add timeout
> 
>   drivers/tty/serial/xilinx_uartps.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index fe457bf1e15bb..e1dd3843d563c 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -429,7 +429,7 @@ static void cdns_uart_handle_tx(void *dev_id)
>           struct uart_port *port = (struct uart_port *)dev_id;
>           struct cdns_uart *cdns_uart = port->private_data;
>           struct tty_port *tport = &port->state->port;
> -       unsigned int numbytes;
> +       unsigned int numbytes, tmout;
>           unsigned char ch;
>   
>           if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
> @@ -454,6 +454,13 @@ static void cdns_uart_handle_tx(void *dev_id)
>   
>           if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
>               (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
> +               /* Wait for the tx fifo to be actually empty */
> +               for (tmout = 1000000; tmout; tmout--) {
> +                       if (cdns_uart_tx_empty(port) == TIOCSER_TEMT)
> +                               break;
> +                       udelay(1);
> +               }
> +
>                   hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
>                   hrtimer_start(&cdns_uart->tx_timer,
>                                 ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);



