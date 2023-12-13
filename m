Return-Path: <stable+bounces-6674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4081214B
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB56B2122D
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 22:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2BF7FBDC;
	Wed, 13 Dec 2023 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="KTlTE20b"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60C4AC;
	Wed, 13 Dec 2023 14:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702505663; x=1703110463; i=linosanfilippo@gmx.de;
	bh=VD92t9JQp648Z2BNkoulPTRk8jdfCT5rO006AN+QRvs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KTlTE20beEeIhJ6autpBTl+6pkkXbzaZrpyLfnJDYuxsNtQY7eal/CvkoPKCFn1I
	 RRttj9oQBue6q+G9M28VyBPB8vZkU5QaI7j0yKBg3EaC0794dzVoBerb9PLElb3Mn
	 z7HWdHwZchQVN8OrnXb22TF/iKou3qjg3B4tRBCSVdV1RxAndc4J+tFciuORDM7at
	 K2tewL/KsU02zTqJlgG5YT+ZTUFS3A04F6B1F+9VWmq6qqD8gIKPvNdIUzB8+rtpw
	 xghaRgu9YMI7uSZlsdQe3GXhndaXsw0iMhgye9i09t6AQgTbYz7/O5hZCrCgkXMd1
	 /2gLU4SHGtvCmGVO7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1r6fzw1Kmp-007SSp; Wed, 13
 Dec 2023 23:14:23 +0100
Message-ID: <422984bc-897c-45b5-8ac0-639e295a729b@gmx.de>
Date: Wed, 13 Dec 2023 23:14:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de,
 shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
 hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
 p.rosenberger@kunbus.com, stable@vger.kernel.org
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
 <20231209125836.16294-2-l.sanfilippo@kunbus.com>
 <e65d73ed-9d7f-8037-78c9-48c817ea3492@linux.intel.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <e65d73ed-9d7f-8037-78c9-48c817ea3492@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VdkmPdhHd+Q5Mw4KhPwk/5s/309926jL8kYFEFZPuJVod6yL9Xv
 c/E3PF5DfqrwgPlFqgPPq3z0xyMCp+7lLOjK/EuzKfUsREaAVvQL1ARNvbdCwA18hgKQEQr
 bWele30U/C12E6kCMo78X5v0p2AyuZ7WZSk5gFM6PIiz1UdL1If5ZEvYjG2JoHxE6XzYAXo
 MZJKIsKSQGyj+CA3uh7Tg==
UI-OutboundReport: notjunk:1;M01:P0:6jZAvjpyU2Y=;GRvwOnRBB/3apl3heyZlbMRdJOF
 PVTFgh3B/x8JjwF+KH/HdRWvGFekTxirpGPJi7FIYm0K5qOeRjf19EhhzhzZHzsXsfkOiPkEG
 2ZRIr3CIzgGGc6Afg8+JpJvDWHW0jNGQFF2zud5LhAhLeBJ+q3dnnF/4xZnfqDSN2ifVcjXxC
 z7Id2tRMR328W9RikJpYTcq2m0WIsVC9lVqsa3IoQEIDcaDGuo+U0DPH0/PGMkYK+TO316Rm7
 7FprM2XcQIjQwnfsRFsgsNNLmpskqI6vfDYBWZ4aU1qRX+u1Px6r/8TIm8f5IvVoqve3FCBo9
 7iupQIWvu8kbAXh41J7GMgRu+U683yHqoOVECZDw9srILNgEGg8DbAme34et45/wv+UU3grSE
 +0PKRd59xGqaA1jDvpX5puIc+Nzcod83rCcPKhMStTlU4dN4AQYoTSxRbdzqdAiaC4Z7RMd5V
 rkQaBPrck515wFgtDSgbAy9y8TlO3E4EZP8ETTuK2ZnOJ/w5eNcHxj0sVoLxyOZKy1SnReVa7
 m6eLYLnq6aYbCVP1odQHymwnIbXDT2FRyniXd1ZEuO953MvHnyX6h3aemJZ2QOGg7H1gP5l01
 V/9RX+5r1NhhGUJL+hUTidWgBZeVq7SzITImE1vHFt9p+Ot6VaR5KGY4jYo1bErDF4Goj/9eB
 chWZvhHRDUGpeF1qFlWsdQYLJRnCdzWgKQ8uhsT7/e9GY7axIgaIeZfYIIz7SO/dkIXl8n1++
 85eCEaKqJKm8y1qF94u20PrwMdorPtjzMs7mc1QcbmadHh7ATR8aEgeBitcMsuAGWwrRxZ/ji
 ZgoSJ+T85X75RjbF25U388zFpcBXo0ifh9EYOy04tp2bOovbBga3Qwb48Y4I4gUApzmf7VTx7
 dkiO3ibSa43wTmli6kUupf89jCHjpnYkzT+FlGzHsm1mXpsd69iiVtq6zXaU864U7d8HG+9pt
 co9UOA==

Hi,

On 11.12.23 11:35, Ilpo J=C3=A4rvinen wrote:
> On Sat, 9 Dec 2023, Lino Sanfilippo wrote:
>
>> Both the imx and stm32 driver set the rx-during-tx GPIO in rs485_config=
().
>> Since this function is called with the port lock held, this can be an
>> problem in case that setting the GPIO line can sleep (e.g. if a GPIO
>> expander is used which is connected via SPI or I2C).
>>
>> Avoid this issue by moving the GPIO setting outside of the port lock in=
to
>> the serial core and thus making it a generic feature.
>>
>> Fixes: c54d48543689 ("serial: stm32: Add support for rs485 RX_DURING_TX=
 output GPIO")
>> Fixes: ca530cfa968c ("serial: imx: Add support for RS485 RX_DURING_TX o=
utput GPIO")
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/imx.c         |  4 ----
>>  drivers/tty/serial/serial_core.c | 12 ++++++++++++
>>  drivers/tty/serial/stm32-usart.c |  5 +----
>>  3 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 708b9852a575..9cffeb23112b 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1943,10 +1943,6 @@ static int imx_uart_rs485_config(struct uart_por=
t *port, struct ktermios *termio
>>  	    rs485conf->flags & SER_RS485_RX_DURING_TX)
>>  		imx_uart_start_rx(port);
>>
>> -	if (port->rs485_rx_during_tx_gpio)
>> -		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
>> -					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
>> -
>>  	return 0;
>>  }
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
>> index f1348a509552..a0290a5fe8b3 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1402,6 +1402,16 @@ static void uart_set_rs485_termination(struct ua=
rt_port *port,
>>  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
>>  }
>>
>> +static void uart_set_rs485_rx_during_tx(struct uart_port *port,
>> +					const struct serial_rs485 *rs485)
>> +{
>> +	if (!(rs485->flags & SER_RS485_ENABLED))
>> +		return;
>> +
>> +	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
>> +				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
>> +}
>> +
>>  static int uart_rs485_config(struct uart_port *port)
>>  {
>>  	struct serial_rs485 *rs485 =3D &port->rs485;
>> @@ -1413,6 +1423,7 @@ static int uart_rs485_config(struct uart_port *po=
rt)
>>
>>  	uart_sanitize_serial_rs485(port, rs485);
>>  	uart_set_rs485_termination(port, rs485);
>> +	uart_set_rs485_rx_during_tx(port, rs485);
>>
>>  	uart_port_lock_irqsave(port, &flags);
>>  	ret =3D port->rs485_config(port, NULL, rs485);
>> @@ -1457,6 +1468,7 @@ static int uart_set_rs485_config(struct tty_struc=
t *tty, struct uart_port *port,
>>  		return ret;
>>  	uart_sanitize_serial_rs485(port, &rs485);
>>  	uart_set_rs485_termination(port, &rs485);
>> +	uart_set_rs485_rx_during_tx(port, &rs485);
>>
>>  	uart_port_lock_irqsave(port, &flags);
>>  	ret =3D port->rs485_config(port, &tty->termios, &rs485);
>
> Also a nice simplification of driver-side code.
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> Just noting since this is now in core that if ->rs485_config() fails,
> I suppose it's just normal to not rollback gpiod_set_value_cansleep()
> (skimming through existing users in tree, it looks it's practically
> never touched on the error rollback paths so I guess it's the normal
> practice)?
>
> Anyway, since neither of the users currently don't fail in their
> ->rs485_config() so it doesn't seem a critical issue.
>

Thats a good point actually. Rolling back is not hard to implement and
although it may not matter right now since currently no driver returns an =
error
code, this can change very soon.
So I will rework this patch for the next version, thanks!

Regards,
Lino

