Return-Path: <stable+bounces-81-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D067F6555
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 18:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EA3281DAB
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086C405D4;
	Thu, 23 Nov 2023 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARnpA8sM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BBB405CD;
	Thu, 23 Nov 2023 17:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80025C433CB;
	Thu, 23 Nov 2023 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700760179;
	bh=XJ7kY1GciSBN8ZVxLG7wgVhOwuwldl8TrXxYyhxZJk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARnpA8sMQbZuhIT+Z/k4mFB5iiosqNIbRQs/7slljkiTk/VdyZ10RTaFGTBpww0MQ
	 2zlYhndKiGi8LNsfvLqVuSPqF7k8jy8XciAE7KzwE3KTr2tCC88rO/3MJxqeNINiWj
	 Wsmj7MiYWZb38lteGIZjFpGaTdD0PN4n4Ktro2zw=
Date: Thu, 23 Nov 2023 14:17:52 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
	u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [RESEND PATCH v4 1/7] serial: Do not hold the port lock when
 setting rx-during-tx GPIO
Message-ID: <2023112304-cornbread-coping-cdce@gregkh>
References: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
 <20231119112856.11587-2-l.sanfilippo@kunbus.com>
 <a2b54b76-01ce-4aa2-a00b-e65e123ba7e9@kunbus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b54b76-01ce-4aa2-a00b-e65e123ba7e9@kunbus.com>

On Wed, Nov 22, 2023 at 12:55:49PM +0100, Lino Sanfilippo wrote:
> 
> 
> On 19.11.23 12:28, Lino Sanfilippo wrote:
> > Both the imx and stm32 driver set the rx-during-tx GPIO in rs485_config().
> > Since this function is called with the port lock held, this can be an
> > problem in case that setting the GPIO line can sleep (e.g. if a GPIO
> > expander is used which is connected via SPI or I2C).
> > 
> > Avoid this issue by moving the GPIO setting outside of the port lock into
> > the serial core and thus making it a generic feature.
> > 
> > Since both setting the term and the rx-during-tx GPIO is done at the same
> > code place, move it into a common function.
> 
> > -				       const struct serial_rs485 *rs485)
> > +/*
> > + * Set optional RS485 GPIOs for bus termination and data reception during
> > + * transmission. These GPIOs are controlled by the serial core independently
> > + * from the UART driver.
> > + */
> > +static void uart_set_rs485_gpios(struct uart_port *port,
> > +				 const struct serial_rs485 *rs485)
> >  {
> >  	if (!(rs485->flags & SER_RS485_ENABLED))
> >  		return;
> >  
> >  	gpiod_set_value_cansleep(port->rs485_term_gpio,
> >  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
> > +	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> > +				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
> >  }
> >  
> 
> Rasmus is about to add support for another RS485 related GPIO (see 
> https://lore.kernel.org/all/20231120151056.148450-3-linux@rasmusvillemoes.dk/ )
> which has to be configured both before and after port->rs485_config(). This
> does not fit very well with the idea of handling all these GPIOs in
> one function. 
> 
> So I would like to revise this patch and send an updated version in a v5
> of this series in which the suggestion from Hugo
> (see https://lore.kernel.org/all/20231011183656.5111ba32ec0c9d43171662a1@hugovil.com/)
> is implemented to use separate functions for the GPIO configurations.
> 

I'll drop this, thanks for letting me know.

There are WAY too many different "enable 485 in this way" patches that
are all conflicting with each other.  Can you all decide on a common way
to handle this, otherwise none of these are going to be acceptable :(

thanks,

greg k-h

