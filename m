Return-Path: <stable+bounces-152037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F140AD1F36
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A455168414
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B325A2AA;
	Mon,  9 Jun 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zf1/luDr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1613B788;
	Mon,  9 Jun 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476670; cv=none; b=nZflIgvxg21xMtZFB8sXLFYDviMF3XJ0gHGhiN4fYhkQepYCucbJqSFczaOmqE4kCB5hWhvREfJhnxtWksaYib9+9mhUaktIbZYF0xrAqEhLfzuJ/6lzDqkWjRl/P8P5LhjfbrRvwM8RcJE8xbKoCgxKfUrgpScBiZwTDQRLcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476670; c=relaxed/simple;
	bh=5BuPaG5TR3ib8h0lahXBVyhI0uc/Ra4ZLBsfgLQLIkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6lBaCZxnkECwoC9p0CfSH4Vw8wM4dVZ7uk2tTQuXUmr3mc7uno0CbDsWq6MhjA5LoFkUjjWrwMPIFV2VjbZwC5ZPFKTXa53ho8RtMkQgDP9YZ+/L3uaJZQIchySBKJ98EGRKovFmOeth0wv3YdOAcmKcQ0W+sPreaqCm9n3psY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zf1/luDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A99C4CEF2;
	Mon,  9 Jun 2025 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749476669;
	bh=5BuPaG5TR3ib8h0lahXBVyhI0uc/Ra4ZLBsfgLQLIkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zf1/luDrz2L0Gyf0p39lf0hyPc98ionSghj2F7/wzJRtJA/lP9+VeIx/AtSLbnpuP
	 u+ccMeJumCkrFDcuSLIGwNk8PP/wgmL123ity58fns9iLPbNw28rdNsoOakmpiT+9k
	 QaHHuNQye61PTjp/00Tmk1mVAGN0wvB8tIujW2sg=
Date: Mon, 9 Jun 2025 15:44:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu, heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	markus.mayer@linaro.org, matt.porter@linaro.org,
	namcao@linutronix.de, paulmck@kernel.org, pmladek@suse.com,
	schnelle@linux.ibm.com, sunilvl@ventanamicro.com,
	tim.kryger@linaro.org, stable@vger.kernel.org
Subject: Re: [External] Re: [PATCH v8 1/4] serial: 8250: fix panic due to
 PSLVERR
Message-ID: <2025060925-curator-stubbed-bfb4@gregkh>
References: <20250609074348.54899-1-cuiyunhui@bytedance.com>
 <2025060913-suave-riveter-66d0@gregkh>
 <CAEEQ3wmaiwd4TZfTa0YrLcKui9fSNJT0fR3j1=H1EK0T3npfyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmaiwd4TZfTa0YrLcKui9fSNJT0fR3j1=H1EK0T3npfyw@mail.gmail.com>

On Mon, Jun 09, 2025 at 09:18:02PM +0800, yunhui cui wrote:
> Hi Greg,
> 
> On Mon, Jun 9, 2025 at 6:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 09, 2025 at 03:43:45PM +0800, Yunhui Cui wrote:
> > > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > > an error response if an attempt is made to read an empty RBR (Receive
> > > Buffer Register) while the FIFO is enabled.
> > >
> > > In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> > > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > > Execution proceeds to the serial_port_in(port, UART_RX).
> > > This satisfies the PSLVERR trigger condition.
> > >
> > > When another CPU (e.g., using printk()) is accessing the UART (UART
> > > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> > > (lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
> > > dw8250_force_idle().
> > >
> > > Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
> > > to fix this issue.
> > >
> > > Panic backtrace:
> > > [    0.442336] Oops - unknown exception [#1]
> > > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > > ...
> > > [    0.442416] console_on_rootfs+0x26/0x70
> > >
> > > Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
> > > Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/tty/serial/8250/8250_port.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > index 6d7b8c4667c9c..07fe818dffa34 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port)
> > >       /*
> > >        * Now, initialize the UART
> > >        */
> > > -     serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > >
> > >       uart_port_lock_irqsave(port, &flags);
> > > +     serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > > +
> > >       if (up->port.flags & UPF_FOURPORT) {
> > >               if (!up->port.irq)
> > >                       up->port.mctrl |= TIOCM_OUT1;
> > > --
> > > 2.39.5
> > >
> > >
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/process/submitting-patches.rst for what
> >   needs to be done here to properly describe this.
> 
> Can this issue reported by the bot be ignored?

No, why?  How do we know what changed from previous versions?  Otherwise
we assume you just ignored previous review comments?

This series took at least 8 tries for some reason, might as well
document it, right?  :)

thanks,

greg k-h

