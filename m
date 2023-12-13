Return-Path: <stable+bounces-6582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C2810E69
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 11:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE06AB20CB2
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA452224ED;
	Wed, 13 Dec 2023 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2Kuf9Wk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A3DB;
	Wed, 13 Dec 2023 02:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702463182; x=1733999182;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1tYxh5KDFW8jW7XIdLhEhe4VnSkz8vV7KmPG573q+vc=;
  b=n2Kuf9WkYzq/SyPgzCXoKmlyZeOueYBPZsyGkzlldf3rXy4Ybq7EQUP2
   N1nFINaUQf2214ZoL3E01uM56Ga1HfH+ESLQRkUR+uRW1amUNwjm80bg9
   S8q4QXucub4QbXtWL9QIZCpAeV43xT/wxhgpgKcZA8cW1qPS3eLsA4irg
   otCTRZ8LO9ZWYZyzNMJvDFjb2Sr+iS2kIzQXbCCNYYKTUghfdK8PQtdGE
   FyQkUB9Cp9Rhq3Xs6kZxHA5fpUJbT1IenHz00SA+mfVdJz1uG7m1/pCpN
   n1Gmv9B9XpRLMMy5PynzdqwlR5Ilv+VIzBOMUzn9UBqfAHSF5xeyXzyXG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="16497467"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="16497467"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 02:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897276991"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="897276991"
Received: from stetter-mobl1.ger.corp.intel.com ([10.252.50.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 02:26:17 -0800
Date: Wed, 13 Dec 2023 12:26:16 +0200 (EET)
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
Subject: Re: [PATCH v5 6/7] serial: omap: do not override settings for RS485
 support
In-Reply-To: <20231209125836.16294-7-l.sanfilippo@kunbus.com>
Message-ID: <e1e8d86e-2cb-db8d-77a5-dcb5cd3fbb22@linux.intel.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com> <20231209125836.16294-7-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 9 Dec 2023, Lino Sanfilippo wrote:

> In serial_omap_rs485() RS485 support may be deactivated due to a missing

There's no serial_omap_rs485() function. I assume/know you meant 
serial_omap_probe_rs485() but please correct.

> RTS GPIO. This is done by nullifying the ports rs485_supported struct.
> After that however the serial_omap_rs485_supported struct is assigned to
> the same structure unconditionally, which results in an unintended
> reactivation of RS485 support.
>
> Fix this by callling serial_omap_rs485() after the assignment of

callling -> calling.

Again, the function name is incorrect.

> rs485_supported.

Wouldn't it be better if all rs485 init/setups would occur in the same 
place rather than being spread around? That is, move the rs485_config and 
rs485_supported setup into serial_omap_probe_rs485()?

-- 
 i.

> Fixes: e2752ae3cfc9 ("serial: omap: Disallow RS-485 if rts-gpio is not specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/omap-serial.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index ad4c1c5d0a7f..d9b2936308c4 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1604,10 +1604,6 @@ static int serial_omap_probe(struct platform_device *pdev)
>  		dev_info(up->port.dev, "no wakeirq for uart%d\n",
>  			 up->port.line);
>  
> -	ret = serial_omap_probe_rs485(up, &pdev->dev);
> -	if (ret < 0)
> -		goto err_rs485;
> -
>  	sprintf(up->name, "OMAP UART%d", up->port.line);
>  	up->port.mapbase = mem->start;
>  	up->port.membase = base;
> @@ -1622,6 +1618,10 @@ static int serial_omap_probe(struct platform_device *pdev)
>  			 DEFAULT_CLK_SPEED);
>  	}
>  
> +	ret = serial_omap_probe_rs485(up, &pdev->dev);
> +	if (ret < 0)
> +		goto err_rs485;
> +
>  	up->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>  	up->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>  	cpu_latency_qos_add_request(&up->pm_qos_request, up->latency);
> -- 
> 2.42.0
> 
> 

