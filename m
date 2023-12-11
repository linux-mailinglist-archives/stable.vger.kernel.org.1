Return-Path: <stable+bounces-5285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955A780C6B8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 11:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27202816CB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998F25544;
	Mon, 11 Dec 2023 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPGKXszV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A9091;
	Mon, 11 Dec 2023 02:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702290942; x=1733826942;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T/g9OIy8Vyvst0xoBB57v3aZ0Z/9mgDwUmJDjiLJt/4=;
  b=nPGKXszVkCCuJp4Kfcdv54WanG2cLoczhqGsxE+KYxnQ7yRcCvsXMLIo
   J0W14C5EcPJQJN0hW16Rgf724uENyhwaWwKb6eHyItlD1pA2qExF0xbX6
   Ertjkbuli3GUCSP7vKPvA9RYiwmKeb1RODREaoMWsOhoOrdiVLJ+E/txr
   XoDRM2FF3CMeK5vCi+zr0btdWppXVTeDfKsgfMMg8HHmzvNFic15RcnTu
   LO9n1d/J6sq7sUXpryf5bd900byilPM+U2QckRyaAXDFX8f7iJxHnKZeL
   cFoPwBBoCOiyv2bg/Na5rG8EwGUK+cLtnkKa/VvAvzMcHeKMIJ6knLooj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="425752835"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="425752835"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:35:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104426813"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104426813"
Received: from lmckeon-mobl.ger.corp.intel.com (HELO iboscu-mobl2.ger.corp.intel.com) ([10.252.48.111])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:35:38 -0800
Date: Mon, 11 Dec 2023 12:35:36 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de, 
    shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com, 
    alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com, 
    hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, LinoSanfilippo@gmx.de, 
    Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v5 1/7] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
In-Reply-To: <20231209125836.16294-2-l.sanfilippo@kunbus.com>
Message-ID: <e65d73ed-9d7f-8037-78c9-48c817ea3492@linux.intel.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com> <20231209125836.16294-2-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1936067011-1702290941=:1867"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1936067011-1702290941=:1867
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 9 Dec 2023, Lino Sanfilippo wrote:

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

Also a nice simplification of driver-side code.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Just noting since this is now in core that if ->rs485_config() fails,
I suppose it's just normal to not rollback gpiod_set_value_cansleep() 
(skimming through existing users in tree, it looks it's practically
never touched on the error rollback paths so I guess it's the normal
practice)?

Anyway, since neither of the users currently don't fail in their 
->rs485_config() so it doesn't seem a critical issue.


-- 
 i.

--8323329-1936067011-1702290941=:1867--

