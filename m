Return-Path: <stable+bounces-5502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD780CEAA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F63B20E81
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0979F495E2;
	Mon, 11 Dec 2023 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="gsXMqkQA"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D0C3;
	Mon, 11 Dec 2023 06:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=kEmVlye6CMrVPDyTmVFhOQ15lLv0MDG5hDAupVdWbcI=; b=gsXMqkQARmulOgWXmYNgBvmkpk
	3QX7SSPv47Y/AVWozhPBPlR3/0omDCt9HHk4eqe6vmnzVKA7eVEaC4Koa0om8RkdVuOfFXTorn8uT
	48s2HbOm9zme/QgYf6307hmA/tZ4eEF9MgEtFDUKBDlmtCuh2eu5hicPLqCCTdnl023w=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:45548 helo=debian-acer)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rChbI-0002gh-29; Mon, 11 Dec 2023 09:49:40 -0500
Date: Mon, 11 Dec 2023 09:49:38 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 ilpo.jarvinen@linux.intel.com, u.kleine-koenig@pengutronix.de,
 shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
 stable@vger.kernel.org
Message-Id: <20231211094938.11c3322b80c2b827b46725c5@hugovil.com>
In-Reply-To: <20231209125836.16294-2-l.sanfilippo@kunbus.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
	<20231209125836.16294-2-l.sanfilippo@kunbus.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: [PATCH v5 1/7] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Sat,  9 Dec 2023 13:58:30 +0100
Lino Sanfilippo <l.sanfilippo@kunbus.com> wrote:

> Both the imx and stm32 driver set the rx-during-tx GPIO in rs485_config().
> Since this function is called with the port lock held, this can be an
> problem in case that setting the GPIO line can sleep (e.g. if a GPIO
> expander is used which is connected via SPI or I2C).
> 
> Avoid this issue by moving the GPIO setting outside of the port lock into
> the serial core and thus making it a generic feature.
> 
> Fixes: c54d48543689 ("serial: stm32: Add support for rs485 RX_DURING_TX output GPIO")
> Fixes: ca530cfa968c ("serial: imx: Add support for RS485 RX_DURING_TX output GPIO")
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/imx.c         |  4 ----
>  drivers/tty/serial/serial_core.c | 12 ++++++++++++
>  drivers/tty/serial/stm32-usart.c |  5 +----
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 708b9852a575..9cffeb23112b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1943,10 +1943,6 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
>  	    rs485conf->flags & SER_RS485_RX_DURING_TX)
>  		imx_uart_start_rx(port);
>  
> -	if (port->rs485_rx_during_tx_gpio)
> -		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> -					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f1348a509552..a0290a5fe8b3 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1402,6 +1402,16 @@ static void uart_set_rs485_termination(struct uart_port *port,
>  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
>  }
>  
> +static void uart_set_rs485_rx_during_tx(struct uart_port *port,
> +					const struct serial_rs485 *rs485)
> +{
> +	if (!(rs485->flags & SER_RS485_ENABLED))
> +		return;
> +
> +	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> +				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
> +}
> +
>  static int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 = &port->rs485;
> @@ -1413,6 +1423,7 @@ static int uart_rs485_config(struct uart_port *port)
>  
>  	uart_sanitize_serial_rs485(port, rs485);
>  	uart_set_rs485_termination(port, rs485);
> +	uart_set_rs485_rx_during_tx(port, rs485);
>  
>  	uart_port_lock_irqsave(port, &flags);
>  	ret = port->rs485_config(port, NULL, rs485);
> @@ -1457,6 +1468,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  		return ret;
>  	uart_sanitize_serial_rs485(port, &rs485);
>  	uart_set_rs485_termination(port, &rs485);
> +	uart_set_rs485_rx_during_tx(port, &rs485);
>  
>  	uart_port_lock_irqsave(port, &flags);
>  	ret = port->rs485_config(port, &tty->termios, &rs485);
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 3048620315d6..ec9a72a5bea9 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -226,10 +226,7 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
>  
>  	stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
>  
> -	if (port->rs485_rx_during_tx_gpio)
> -		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> -					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
> -	else
> +	if (!port->rs485_rx_during_tx_gpio)
>  		rs485conf->flags |= SER_RS485_RX_DURING_TX;
>  
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
> -- 
> 2.42.0
> 

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hugo

