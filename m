Return-Path: <stable+bounces-78594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487D98CC33
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 06:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFB1281B1D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 04:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443017C79;
	Wed,  2 Oct 2024 04:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Q2iOuQwZ"
X-Original-To: stable@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE97168B8;
	Wed,  2 Oct 2024 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727844189; cv=none; b=d4s/jUnkP3OnEnnQwoo9m1ePjhSSBFoZdxdLIr1+MihbNjJONg4WQ+5ihq0uN84mFwedwCOmBmQfq4KRYdsCk4sJ5t8IUq6bs22P6pRqY2MMm0hU9+QiOXx6EBYDo7jwcSen7Va+qSdeeCVpme5EyhyJa/jjOmKEM6vbnfrxEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727844189; c=relaxed/simple;
	bh=5DtRqM9QLkqt5hhs4CLcP1lfXbjzUAKy39nCpNuMxts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xh4DFzB2UE4HfgirF5rUvQkMioTjjzflE8Z4pcLfSer/BJ64jVQ/H5SomhwfAHvITXOhS4f480/JDyLEOIALQ6CmL3g2IaNGSip6BYe9QOTJz8Bb3zmR31T4oHbgmZbxPa+01mLn2BIqVhm5IAEOVO8wuFl7tuDjrzwHrA3r99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Q2iOuQwZ; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tvSPOhJ3UnuWKnl/SQdjFqbtKiC7eCIb0ktBQEagEBk=; b=Q2iOuQwZJ8/2Y1BIpDP9FSeK64
	FkxA0pCgilbFOSdsrC/Z7dfaV9macf67Jj1nUvjkT0TWtuGcn1meDOcZOCwPT6vmSfyvBz+EgWB13
	VUEIJOLaLFesaWw3FvfZ7UxGsj8o6HV3sZ3yJtVpVGqxDeaARKUhRJv1qQodcfrEUrA9Qy2zxOj0l
	j6MklcIm3//qeQLazCoRU5D2oKV0Sc0MxwCUDOrJ4/LfiqAc0kUs621hNWWzAolih60VATGLGFnOa
	SebbFjhLUTuMp7gpJxVwuta9abAsOPj9ZmXyVbN3EjflaWBlrvwifoc71DQGXDo8AHBSSnKk/TmAj
	stjamXww==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1svrCS-000EPK-Ix; Wed, 02 Oct 2024 06:42:56 +0200
Received: from [80.62.117.232] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1svrCR-0005g8-1s;
	Wed, 02 Oct 2024 06:42:55 +0200
From: Esben Haabendal <esben@geanix.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-serial@vger.kernel.org,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>,  Christoph Niedermaier
 <cniedermaier@dh-electronics.com>,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Fabio Estevam <festevam@gmail.com>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jiri Slaby
 <jirislaby@kernel.org>,  Lino Sanfilippo <l.sanfilippo@kunbus.com>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Rasmus Villemoes
 <linux@rasmusvillemoes.dk>,  Rickard x Andersson <rickaran@axis.com>,
  Sascha Hauer <s.hauer@pengutronix.de>,  Shawn Guo <shawnguo@kernel.org>,
  Stefan Eichenberger <stefan.eichenberger@toradex.com>,
  imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] serial: imx: Update mctrl old_status on RTSD interrupt
In-Reply-To: <20241002041125.155643-1-marex@denx.de> (Marek Vasut's message of
	"Wed, 2 Oct 2024 06:11:16 +0200")
References: <20241002041125.155643-1-marex@denx.de>
Date: Wed, 02 Oct 2024 06:42:55 +0200
Message-ID: <87frpfcdyo.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27414/Tue Oct  1 10:44:50 2024)

Marek Vasut <marex@denx.de> writes:

> When sending data using DMA at high baudrate (4 Mbdps in local test case)=
 to
> a device with small RX buffer which keeps asserting RTS after every recei=
ved
> byte, it is possible that the iMX UART driver would not recognize the fal=
ling
> edge of RTS input signal and get stuck, unable to transmit any more data.
>
> This condition happens when the following sequence of events occur:
> - imx_uart_mctrl_check() is called at some point and takes a snapshot of =
UART
>   control signal status into sport->old_status using imx_uart_get_hwmctrl=
().
>   The RTSS/TIOCM_CTS bit is of interest here (*).
> - DMA transfer occurs, the remote device asserts RTS signal after each by=
te.
>   The i.MX UART driver recognizes each such RTS signal change, raises an
>   interrupt with USR1 register RTSD bit set, which leads to invocation of
>   __imx_uart_rtsint(), which calls uart_handle_cts_change().
>   - If the RTS signal is deasserted, uart_handle_cts_change() clears
>     port->hw_stopped and unblocks the port for further data transfers.
>   - If the RTS is asserted, uart_handle_cts_change() sets port->hw_stopped
>     and blocks the port for further data transfers. This may occur as the
>     last interrupt of a transfer, which means port->hw_stopped remains set
>     and the port remains blocked (**).
> - Any further data transfer attempts will trigger imx_uart_mctrl_check(),
>   which will read current status of UART control signals by calling
>   imx_uart_get_hwmctrl() (***) and compare it with sport->old_status .
>   - If current status differs from sport->old_status for RTS signal,
>     uart_handle_cts_change() is called and possibly unblocks the port
>     by clearing port->hw_stopped .
>   - If current status does not differ from sport->old_status for RTS
>     signal, no action occurs. This may occur in case prior snapshot (*)
>     was taken before any transfer so the RTS is deasserted, current
>     snapshot (***) was taken after a transfer and therefore RTS is
>     deasserted again, which means current status and sport->old_status
>     are identical. In case (**) triggered when RTS got asserted, and
>     made port->hw_stopped set, the port->hw_stopped will remain set
>     because no change on RTS line is recognized by this driver and
>     uart_handle_cts_change() is not called from here to unblock the
>     port->hw_stopped.
>
> Update sport->old_status in __imx_uart_rtsint() accordingly to make
> imx_uart_mctrl_check() detect such RTS change. Note that TIOCM_CAR
> and TIOCM_RI bits in sport->old_status do not suffer from this problem.
>
> Fixes: ceca629e0b48 ("[ARM] 2971/1: i.MX uart handle rts irq")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Esben Haabendal <esben@geanix.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Rickard x Andersson <rickaran@axis.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-serial@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 67d4a72eda770..3ad7f42790ef9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -762,6 +762,10 @@ static irqreturn_t __imx_uart_rtsint(int irq, void *=
dev_id)
>=20=20
>  	imx_uart_writel(sport, USR1_RTSD, USR1);
>  	usr1 =3D imx_uart_readl(sport, USR1) & USR1_RTSS;
> +	if (usr1 & USR1_RTSS)
> +		sport->old_status |=3D TIOCM_CTS;
> +	else
> +		sport->old_status &=3D ~TIOCM_CTS;
>  	uart_handle_cts_change(&sport->port, usr1);
>  	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);

Reviewed-by: Esben Haabendal <esben@geanix.com>

