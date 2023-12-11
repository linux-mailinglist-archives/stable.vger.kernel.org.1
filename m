Return-Path: <stable+bounces-5288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9337A80C750
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 11:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3347AB20FE4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87252D618;
	Mon, 11 Dec 2023 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGGQk718"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D434F9A;
	Mon, 11 Dec 2023 02:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702292027; x=1733828027;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ouVr0xABC0VbnKadiPp9N3JbAXoUMby9A2Sjw5UigG0=;
  b=GGGQk718QXtJgbl1nZKyfuk7gr/3KCUTbALkrOlvBBjy5hNag4weqanX
   OgSfkKA5NBD/gis9oGyz8cw5EKjVd7ZCzx1OA2PnNN+U7r+5B7G1bbQNk
   MqhRtYl1Q2Hdn/DfG3yLCRNZNC6tC0mwb4MeeaMld3V5iUYanmvaCVJFz
   eATKyjU6FlF6/FciIttKSlwtne8Lq2uGR2/Mih8jejf9oJole7ihXerjl
   ppG3E4aiwhjLJrV7ElC0X6GLyUVpkPSoNONT4exZ28o4Kn9q+fKh3Oigv
   i+ce5ka2jBo/zRv78AEpNaWiswXJb6AWGdokocfmoNLfoX4TcMV1WBEZV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1467599"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1467599"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:53:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="21035894"
Received: from lmckeon-mobl.ger.corp.intel.com ([10.252.48.111])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:53:42 -0800
Date: Mon, 11 Dec 2023 12:53:39 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de, 
    shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com, 
    alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com, 
    hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, LinoSanfilippo@gmx.de, 
    Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v5 4/7] serial: core: make sure RS485 cannot be enabled
 when it is not supported
In-Reply-To: <20231209125836.16294-5-l.sanfilippo@kunbus.com>
Message-ID: <5a1f1e87-38c8-7f0-35bf-689ceff844ba@linux.intel.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com> <20231209125836.16294-5-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1804116021-1702292026=:1867"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1804116021-1702292026=:1867
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 9 Dec 2023, Lino Sanfilippo wrote:

> Some uart drivers specify a rs485_config() function and then decide later
> to disable RS485 support for some reason (e.g. imx and ar933).
> 
> In these cases userspace may be able to activate RS485 via TIOCSRS485
> nevertheless, since in uart_set_rs485_config() an existing rs485_config()
> function indicates that RS485 is supported.
> 
> Make sure that this is not longer possible by checking the uarts
> rs485_supported.flags instead and bailing out if SER_RS485_ENABLED is not
> set.
> 
> Furthermore instead of returning an empty structure return -ENOTTY if the
> RS485 configuration is requested via TIOCGRS485 but RS485 is not supported.
> This has a small impact on userspace visibility but it is consistent with
> the -ENOTTY error for TIOCGRS485.
> 
> Fixes: e849145e1fdd ("serial: ar933x: Fill in rs485_supported")
> Fixes: 55e18c6b6d42 ("serial: imx: Remove serial_rs485 sanitization")
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/serial_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 4eae1406cb6c..661074ab8edb 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1448,6 +1448,9 @@ static int uart_get_rs485_config(struct uart_port *port,
>  	unsigned long flags;
>  	struct serial_rs485 aux;
>  
> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
> +		return -ENOTTY;
> +
>  	uart_port_lock_irqsave(port, &flags);
>  	aux = port->rs485;
>  	uart_port_unlock_irqrestore(port, flags);
> @@ -1465,7 +1468,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  	int ret;
>  	unsigned long flags;
>  
> -	if (!port->rs485_config)
> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
>  		return -ENOTTY;
>  
>  	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))

Looking through debian code search entries for TIOCGRS485, this might 
actually fly... I'd suggest splitting this into two patches though.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1804116021-1702292026=:1867--

