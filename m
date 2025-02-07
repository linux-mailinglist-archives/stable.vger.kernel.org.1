Return-Path: <stable+bounces-114245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CB7A2C236
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 13:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FF93ABA90
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916A91DF725;
	Fri,  7 Feb 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkWAUpNM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BADF2417C7;
	Fri,  7 Feb 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930114; cv=none; b=vE0nYm2PT+c2b/tWEgPFXPRevkridzqP9MEqA8QHuin41YFuNLJbJ/Qkjflp3iXa8X9mU23DUUJDq/WxgrucqfkMDxt7eZBb1AXI+f0BOQ+SImbSc+Rz9t0EVsSTxYvdVbZ0A0nyvEfyUKgWvclkaUtgEKQ8qg4n/SaNlYFmNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930114; c=relaxed/simple;
	bh=da95x+iEjKk4AnIyzWr4OF402Q3KQTuVcmxNR1uChYw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oRvznNmFDLNXTVr3mjjDppuEb/FjxaXlF8keGKpyof3f8t0ETBlqBcblehtgwRhOV2gkBtXFsfKCtwQEA3tf6i9+NfsvRVyYu7T6HMDEsiaSIoQOn5Xot+4CTHkQyroRl8BW7cE5cQXIhVKfnzbuh802k/UfVNoCBrfopqOvywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkWAUpNM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738930112; x=1770466112;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=da95x+iEjKk4AnIyzWr4OF402Q3KQTuVcmxNR1uChYw=;
  b=fkWAUpNMkplCVLfA4+fZ8z+l9eR7Aydu+5dbGMEnt+I61OY3ZkZpdHjn
   mtx9fpemQxaDmYkPg0QN9CD9eeEFW53M5WkF3CGWl8xP9h17CUWswl9Ph
   JohCdRr0s9hPBHVw9DB7Q77no2T0ytag0s0eTkSmjv1VZtjG6CSv4LNFB
   lbHiJ1ZL9t+1+t9k8nOk8u1AQdNczG4U5rzSpbJbZGi7uyU4eeCDH9TJt
   RXGSWgtff9vY4/Knxc+d5lVWpo42f/k4bhyJhqkz/cr+B3gAR/l62k3rK
   owIDlh9dXRUWPXRiD9avUxMOMghuai7zGrgFcp+jRWiUoWcfuPe5YFt2r
   Q==;
X-CSE-ConnectionGUID: J4Qfq6TbQDael52MmodE7g==
X-CSE-MsgGUID: UWOS7vlRRLK8P7pN02/qSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50207779"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="50207779"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 04:08:31 -0800
X-CSE-ConnectionGUID: /25sh4qZTMmGnYayCZPUMQ==
X-CSE-MsgGUID: ZWLVXRUIQgmxLG1TxorF9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116452167"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 04:08:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Feb 2025 14:08:22 +0200 (EET)
To: John Keeping <jkeeping@inmusicbrands.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Sunil V L <sunilvl@ventanamicro.com>, Petr Mladek <pmladek@suse.com>, 
    Arnd Bergmann <arnd@arndb.de>, John Ogness <john.ogness@linutronix.de>, 
    Ferry Toth <ftoth@exalondelft.nl>, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Serge Semin <fancer.lancer@gmail.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250: Fix fifo underflow on flush
In-Reply-To: <20250207112608.693947-1-jkeeping@inmusicbrands.com>
Message-ID: <f41ac9f6-9796-5405-df66-a38d7bec06b6@linux.intel.com>
References: <20250207112608.693947-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Feb 2025, John Keeping wrote:

> When flushing the serial port's buffer, uart_flush_buffer() calls
> kfifo_reset() but if there is an outstanding DMA transfer then the
> completion function will consume data from the kfifo via
> uart_xmit_advance(), underflowing and leading to ongoing DMA as the
> driver tries to transmit another 2^32 bytes.
> 
> This is readily reproduced with serial-generic and amidi sending even
> short messages as closing the device on exit will wait for the fifo to
> drain and in the underflow case amidi hangs for 30 seconds on exit in
> tty_wait_until_sent().  A trace of that gives:
> 
>      kworker/1:1-84    [001]    51.769423: bprint:               serial8250_tx_dma: tx_size=3 fifo_len=3
>            amidi-763   [001]    51.769460: bprint:               uart_flush_buffer: resetting fifo
>  irq/21-fe530000-76    [000]    51.769474: bprint:               __dma_tx_complete: tx_size=3
>  irq/21-fe530000-76    [000]    51.769479: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294967293
>  irq/21-fe530000-76    [000]    51.781295: bprint:               __dma_tx_complete: tx_size=4096
>  irq/21-fe530000-76    [000]    51.781301: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294963197
>  irq/21-fe530000-76    [000]    51.793131: bprint:               __dma_tx_complete: tx_size=4096
>  irq/21-fe530000-76    [000]    51.793135: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294959101
>  irq/21-fe530000-76    [000]    51.804949: bprint:               __dma_tx_complete: tx_size=4096
> 
> Since the port lock is held in when the kfifo is reset in
> uart_flush_buffer() and in __dma_tx_complete(), adding a flush_buffer
> hook to adjust the outstanding DMA byte count is sufficient to avoid the
> kfifo underflow.
> 
> Fixes: 9ee4b83e51f74 ("serial: 8250: Add support for dmaengine")
> Cc: stable@vger.kernel.org
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> ---
> Changes in v2:
> - Add Fixes: tag
> - Return early to reduce indentation in serial8250_tx_dma_flush()
> 
>  drivers/tty/serial/8250/8250.h      |  1 +
>  drivers/tty/serial/8250/8250_dma.c  | 16 ++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c |  9 +++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 11e05aa014e54..8ef45622e4363 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -374,6 +374,7 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
>  
>  #ifdef CONFIG_SERIAL_8250_DMA
>  extern int serial8250_tx_dma(struct uart_8250_port *);
> +extern void serial8250_tx_dma_flush(struct uart_8250_port *);
>  extern int serial8250_rx_dma(struct uart_8250_port *);
>  extern void serial8250_rx_dma_flush(struct uart_8250_port *);
>  extern int serial8250_request_dma(struct uart_8250_port *);

Will build fail if !CONFIG_SERIAL_8250_DMA ?

> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index d215c494ee24c..f245a84f4a508 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -149,6 +149,22 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>  	return ret;
>  }
>  
> +void serial8250_tx_dma_flush(struct uart_8250_port *p)
> +{
> +	struct uart_8250_dma *dma = p->dma;
> +
> +	if (!dma->tx_running)
> +		return;
> +
> +	/*
> +	 * kfifo_reset() has been called by the serial core, avoid
> +	 * advancing and underflowing in __dma_tx_complete().
> +	 */
> +	dma->tx_size = 0;
> +
> +	dmaengine_terminate_async(dma->rxchan);
> +}
> +
>  int serial8250_rx_dma(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma		*dma = p->dma;
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d7976a21cca9c..442967a6cd52d 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2555,6 +2555,14 @@ static void serial8250_shutdown(struct uart_port *port)
>  		serial8250_do_shutdown(port);
>  }
>  
> +static void serial8250_flush_buffer(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +
> +	if (up->dma)
> +		serial8250_tx_dma_flush(up);
> +}
> +
>  static unsigned int serial8250_do_get_divisor(struct uart_port *port,
>  					      unsigned int baud,
>  					      unsigned int *frac)
> @@ -3244,6 +3252,7 @@ static const struct uart_ops serial8250_pops = {
>  	.break_ctl	= serial8250_break_ctl,
>  	.startup	= serial8250_startup,
>  	.shutdown	= serial8250_shutdown,
> +	.flush_buffer	= serial8250_flush_buffer,
>  	.set_termios	= serial8250_set_termios,
>  	.set_ldisc	= serial8250_set_ldisc,
>  	.pm		= serial8250_pm,
> 

-- 
 i.


