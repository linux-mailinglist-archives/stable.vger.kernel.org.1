Return-Path: <stable+bounces-212834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOnZEpQrfGkYLAIAu9opvQ
	(envelope-from <stable+bounces-212834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:55:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01927B6EF0
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53F9830065F9
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 03:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B4352933;
	Fri, 30 Jan 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CbjmrdpP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBB314D26
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 03:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745294; cv=none; b=qgEU3YrNkTDurMuy+TisobLjvs5XOqw4r+TV7Y/OvaBWO0lkyBCzhSnxmlUppxRC5kviRllTpr2WmnKIUelsdJFi4Hk/kdYFT/6EZ2qE13e0M4eIsZXDAnqK1eNtfHpSjo+Vg5Uzw3Sl0RN1TabE2ManxnXFII2IuT2S2myXKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745294; c=relaxed/simple;
	bh=61AdblHSKpwEd8XSc8ByKLLBiiiUs87L9eDfd5ye0XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3ufh6BrmfzqDheNTsOtChZ2Jlv1tS8kCMSkdS1gPrcDa1ZZFiLDVJCbcYnKOYoI9y0u5QS8kcTvemopuXXkYPK1IKYjKj7Z+1lP+yMHQuybZ5Qq1P5H7odDzL1zMtzoxJWHkwuyCfga5MezDi2fR7lTyMcn8inQy9+QJrmzrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CbjmrdpP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4043b909ed4so1005819fac.3
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 19:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769745291; x=1770350091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKrsJyAADsVbRFEkxPd+kVRNcQo0Gojt5413CoBLvuY=;
        b=CbjmrdpPxsILGAeCGCoFsxIlxBXDsw3nlfndAbrgw/q2e9TfpMKNzRy+OGfKtuQqXR
         b2PRgSDzM6SwKsRl1NNZtnBg8yof8//DdIk+lHNA2nyq5gurWTzMV9LxYzvtHDDAeV3a
         w7LjHPRdGA+zWV6YPfSZ8bUpMPJEPZh7MhkCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769745291; x=1770350091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKrsJyAADsVbRFEkxPd+kVRNcQo0Gojt5413CoBLvuY=;
        b=DG1DLHCZWBxho9w/v/92wyfDPUX74zoFYCqkoThQJye5ZnkXZuSEdkD0kEjnPuA+jJ
         8cej9+Ib5Ak+y9RBa8xMDDX7q/bM8njf/ocegRiyTerzE2fkDkXIlgHz6m2NuCRRYs7i
         5K0Tct58RvfWVz2lelMCMzvGQs4xY3ZbgqFzQblstyUdNBBg/9vYdMHPWx6P5y8i5fV8
         aDNu995X0cnU9nYiQif8qgyojBcYL7FzEphY0OShlA5rZJGpRhybRFopEdTLfg+CCVyQ
         LxW45Blb79Q63Qoq62xynIcilzooYdDNPE4L0qg/rOSfm50Bs3pHwWPq7yC6NhC13MCd
         PFyg==
X-Forwarded-Encrypted: i=1; AJvYcCXzJD8fmdSPh24Mt4jYtIbK9mQHgJTIbgGDxG+b/TrBXvjiJ6mnBUg1KobPuUQ2gshyefRNb/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu38z+RvEpIyuJwMd0RKTlcAH1i2X4v1MDRYvBPJ0KC5uDrxDN
	EcxF7v2CSui13j8Odc3qr5w8xrjZM5LH1IfcQU/5qYSO7JSdjGjGUuZLPpY9715GUw==
X-Gm-Gg: AZuq6aLKznHGmL3iqhSwZpDATpyg7CuC74K1pQZHMdbTNqP/9zmsIhItXW0ZA+6XNuH
	8caBd2OPtuTwsVqrjU6YL31plO9YQXwAA+W0PO2xcS1LYuLEVYzaJFns+8uPb1CRl8+NWoSh869
	AyOKh1gSmT6Gz1H1jzMRuogyFtanj0pRvz0MIEkCCIK2bT3W17NJFDZVQaaE9/m1aAaUKzgU9wB
	G/4jPKSHetlNjC8UnR6tzY44P3YYMqy3klXiKfz4RHPSQ8B7ZXsCdOLhrkYSdVjkyJl4xQEJyCI
	IdAgoCNdZFUdI12WiRHZ1UVHmblvsVQigNazMR20jWWWxvdjj+xZp9eNMfjlP0Kuq3qnGgQYjD4
	1x9Gy0BQBjKUQt3zWEOyHsBJrRMcZpXMaE5t62x9oD5sN9aWNuyuT7DVITXs9d79KMqCTjFkc1H
	LPrsR2eqwVrHB65A+cTzZgeTOW1ewIUAsSe5Vj+EKI2s55ksG7g9XM5iAvlUKnGihb
X-Received: by 2002:a05:6820:820:b0:662:c372:4cc9 with SMTP id 006d021491bc7-6630f3d7346mr805426eaf.79.1769745290803;
        Thu, 29 Jan 2026 19:54:50 -0800 (PST)
Received: from google.com (h96-60-216-201.arvdco.broadband.dynamic.tds.net. [96.60.216.201])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a18de2sm4424183eaf.11.2026.01.29.19.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 19:54:49 -0800 (PST)
Date: Thu, 29 Jan 2026 20:54:45 -0700
From: Raul E Rangel <rrangel@chromium.org>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250: Fix fifo underflow on flush
Message-ID: <aXwrhV6_FQ-o8KY2@google.com>
References: <20250208124148.1189191-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208124148.1189191-1-jkeeping@inmusicbrands.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212834-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,kernel.org,linux.intel.com,ventanamicro.com,suse.com,arndb.de,linutronix.de,exalondelft.nl,linux.ibm.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rrangel@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inmusicbrands.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 01927B6EF0
X-Rspamd-Action: no action

On Sat, Feb 08, 2025 at 12:41:44PM +0000, John Keeping wrote:
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
> Changes in v3:
> - Fix !CONFIG_SERIAL_8250_DMA build
> Changes in v2:
> - Add Fixes: tag
> - Return early to reduce indentation in serial8250_tx_dma_flush()
> 
>  drivers/tty/serial/8250/8250.h      |  2 ++
>  drivers/tty/serial/8250/8250_dma.c  | 16 ++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c |  9 +++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 11e05aa014e54..b861585ca02ac 100644
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
> @@ -406,6 +407,7 @@ static inline int serial8250_tx_dma(struct uart_8250_port *p)
>  {
>  	return -1;
>  }
> +static inline void serial8250_tx_dma_flush(struct uart_8250_port *p) { }
>  static inline int serial8250_rx_dma(struct uart_8250_port *p)
>  {
>  	return -1;
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

Hrmm, I think this is causing a deadlock.
If the DMA transaction is canceled, then the callback might not run.
This leaves dma->tx_running set to 1 causing the channel to never
restart the channel.

I tried the following fix (and it works for me), but I'm not sure it's
the correct fix.

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bdd26c9f34bd..58b914c20d98 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -162,7 +162,22 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p)
         */
        dma->tx_size = 0;

+       /*
+        * We can't use `dmaengine_terminate_sync` because `uart_flush_buffer` is
+        * holding the uart port spinlock.
+        */
        dmaengine_terminate_async(dma->txchan);
+
+       /*
+        * The callback might or might not run. If it doesn't run, we need to ensure
+        * that `tx_running` is cleared so that we can schedule new transactions.
+        * If it does run, then the zombie callback will clear `tx_running` for us
+        * and perform a no-op since `tx_size` was cleared.
+        *
+        * In either case, we assume DMA transaction will be terminated or the
+        * callback will run before we issue a new `serial8250_tx_dma`.
+        */
+       dma->tx_running = 0;
 }

 int serial8250_rx_dma(struct uart_8250_port *p)

The problem is IIUC, that we need to either use dmaengine_terminate_sync
or dmaengine_synchronize so we can guarantee that the hardware is
stopped, the callback is done, and we can free-reuse the resources.
I think a better approach might be to add a `tx_flushing` bool and push
a job onto a work queue that calls `dmaengine_terminate_sync`, and then
sets `tx_running=0` and `tx_flushing=0`. I'm not sure what happens
though if something comes along and starts writing to the UART registers
while we are waiting for the DMA transaction to complete.

Thoughts?

---
Here is the debug trace I took that shows the problem:

< lots of tty_write omitted >
3250.941306 |    0)               |  tty_write() {
3250.941307 |    0)   0.174 us    |    tty_ldisc_ref_wait();
3250.941307 |    0)   0.154 us    |    tty_hung_up_p();
3250.941307 |    0)               |    tty_write_room() {
3250.941308 |    0)   0.211 us    |      uart_write_room();
3250.941308 |    0)   0.542 us    |    }
3250.941308 |    0)               |    uart_write() {
3250.941308 |    0)               |      serial8250_start_tx() {
3250.941309 |    0)               |        serial8250_tx_dma() {
3250.941309 |    0)               |          /* serial8250_tx_dma: tx_running => 1 */
3250.941309 |    0)   0.408 us    |        }
3250.941309 |    0)   0.714 us    |      }
3250.941309 |    0)   1.261 us    |    }
3250.941310 |    0)               |    tty_write_room() {
3250.941310 |    0)   0.217 us    |      uart_write_room();
3250.941310 |    0)   0.489 us    |    }
3250.941310 |    0)               |    uart_flush_chars() {
3250.941310 |    0)               |      uart_start() {
3250.941311 |    0)               |        serial8250_start_tx() {
3250.941311 |    0)               |          serial8250_tx_dma() {
3250.941311 |    0)               |            /* serial8250_tx_dma: tx_running => 1 */
3250.941311 |    0)   0.389 us    |          }
3250.941311 |    0)   0.681 us    |        }
3250.941312 |    0)   1.207 us    |      }
3250.941312 |    0)   1.488 us    |    }
3251.008825 |   10)               |  serial8250_interrupt() {
3251.008828 |   10)               |    serial8250_default_handle_irq() {
3251.008830 |   10) + 17.915 us   |      dw8250_serial_in32 [8250_dw]();
3251.008848 |   10)   0.207 us    |      serial8250_handle_irq();
3251.008849 |   10) + 20.208 us   |    }
3251.008849 |   10) + 27.505 us   |  }
3251.008862 |   10)               |  /* __dma_tx_complete: tx_running <= 0 */
3251.008863 |   10)               |  serial8250_tx_dma() {
3251.008864 |   10)               |  /* serial8250_tx_dma: tx_running => 0 */
3251.008872 |   10)               |  /* serial8250_tx_dma: tx_running <= 1 */
3251.008879 |   10)   9.410 us    |  }
3251.107685 |   10)               |  serial8250_interrupt() {
3251.107688 |   10)               |    serial8250_default_handle_irq() {
3251.107689 |   10) + 18.007 us   |      dw8250_serial_in32 [8250_dw]();
3251.107707 |   10)               |      serial8250_handle_irq() {
3251.107708 |   10)   1.847 us    |        dw8250_serial_in32 [8250_dw]();
3251.107713 |   10)   1.003 us    |        serial8250_rx_dma_flush();
3251.107714 |   10)               |        serial8250_read_char() {
3251.107715 |   10) + 17.452 us   |          dw8250_serial_in32 [8250_dw]();
3251.107732 |   10)   1.008 us    |          uart_insert_char();
3251.107734 |   10) + 19.136 us   |        }
3251.107734 |   10)   3.914 us    |        dw8250_serial_in32 [8250_dw]();
3251.107739 |   10)   6.789 us    |        tty_flip_buffer_push();
3251.107746 |   10)               |        serial8250_modem_status() {
3251.107746 |   10) + 17.556 us   |          dw8250_serial_in32 [8250_dw]();
3251.107764 |   10) + 18.039 us   |        }
3251.107764 |   10) + 56.710 us   |      }
3251.107764 |   10) + 76.870 us   |    }
3251.107765 |   10)               |    serial8250_default_handle_irq() {
3251.107765 |   10)   4.205 us    |      dw8250_serial_in32 [8250_dw]();
3251.107769 |   10)   0.219 us    |      serial8250_handle_irq();
3251.107770 |   10)   5.076 us    |    }
3251.107770 |   10) + 88.331 us   |  }
3251.107805 |    6)               |  tty_port_default_receive_buf() {
3251.107808 |    6)   1.377 us    |    tty_ldisc_ref();
3251.107810 |    6)               |    tty_ldisc_receive_buf() {
3251.107813 |    6)   0.639 us    |      tty_get_pgrp();
3251.107823 |    6)               |      tty_driver_flush_buffer() {
3251.107824 |    6)               |        uart_flush_buffer() {
3251.107825 |    6)               |          serial8250_flush_buffer() {
3251.107826 |    6)               |            serial8250_tx_dma_flush() {
3251.107829 |    6)               |              /* serial8250_tx_dma_flush: tx_running => 1 */
                                                 /* Notice the callback is never ran */
3251.108186 |    6) ! 360.293 us  |            }
3251.108186 |    6) ! 361.125 us  |          }
3251.108196 |    6)               |          tty_port_tty_wakeup() {
3251.108196 |    6)               |            tty_port_default_wakeup() {
3251.108196 |    6)   1.146 us    |              tty_wakeup();
3251.108198 |    6)   0.247 us    |              tty_kref_put();
3251.108198 |    6)   2.359 us    |            }
3251.108199 |    6)   2.987 us    |          }
3251.108199 |    6) ! 374.727 us  |        }
3251.108199 |    6) ! 375.679 us  |      }
3251.108202 |    6)               |      tty_write_room() {
3251.108203 |    6)   0.286 us    |        uart_write_room();
3251.108203 |    6)   1.074 us    |      }
3251.108204 |    6)               |      tty_put_char() {
3251.108204 |    6)   0.487 us    |        uart_put_char();
3251.108205 |    6)   1.177 us    |      }
3251.108205 |    6)               |      tty_put_char() {
3251.108205 |    6)   0.261 us    |        uart_put_char();
3251.108206 |    6)   0.677 us    |      }
3251.108206 |    6)               |      uart_flush_chars() {
3251.108207 |    6)               |        uart_start() {
3251.108208 |    6)               |          serial8250_start_tx() {
3251.108209 |    6)               |            serial8250_tx_dma() {
3251.108210 |    6)               |              /* serial8250_tx_dma: tx_running => 1 */
3251.108210 |    6)   1.194 us    |            }
3251.108211 |    6)   2.251 us    |          }
3251.108213 |    6)   5.829 us    |        }
3251.108213 |    6)   6.532 us    |      }
3251.108214 |    6) ! 404.132 us  |    }
3251.108214 |    6)   0.238 us    |    tty_ldisc_deref();
3251.108214 |    6) ! 411.672 us  |  }
3251.108260 |    0)   3.102 us    |    tty_ldisc_deref();
3251.108263 |    0) @ 166956.2 us |  }
3251.108270 |    0)   0.465 us    |  tty_audit_exit();
3251.109013 |   11)   2.680 us    |  tty_kref_put();
3251.109059 |   11)               |  tty_ioctl() {
3251.109060 |   11)               |    tty_jobctrl_ioctl() {
3251.109060 |   11)   0.622 us    |      __tty_check_change();
3251.109062 |   11)   2.450 us    |    }
3251.109063 |   11)   4.003 us    |  }
3251.109064 |   11)               |  tty_ioctl() {
3251.109064 |   11)   0.225 us    |    tty_jobctrl_ioctl();
3251.109065 |   11)   1.550 us    |    uart_ioctl();
3251.109067 |   11)   0.554 us    |    tty_ldisc_ref_wait();
3251.109069 |   11)               |    tty_mode_ioctl() {
3251.109069 |   11)               |      tty_check_change() {
3251.109070 |   11)   0.282 us    |        __tty_check_change();
3251.109070 |   11)   0.662 us    |      }
3251.109071 |   11)   0.477 us    |      tty_termios_input_baud_rate();
3251.109071 |   11)   0.214 us    |      tty_termios_baud_rate();
3251.109072 |   11)   0.483 us    |      uart_chars_in_buffer();
3251.109073 |   11)   0.247 us    |      uart_chars_in_buffer();
------------------------------------------
11)    sh-7708     =>   kworker-90
------------------------------------------

3251.686493 |   11)               |  serial8250_start_tx() {
3251.686496 |   11)               |    serial8250_tx_dma() {
3251.686500 |   11)               |      /* serial8250_tx_dma: tx_running => 1 */
3251.686501 |   11)   4.696 us    |    }
3251.686501 |   11) + 12.203 us   |  }
3252.311575 |   11)               |  serial8250_start_tx() {
3252.311579 |   11)               |    serial8250_tx_dma() {
3252.311582 |   11)               |      /* serial8250_tx_dma: tx_running => 1 */
3252.311583 |   11)   4.020 us    |    }
3252.311583 |   11) + 10.556 us   |  }
3252.936657 |   11)               |  serial8250_start_tx() {
3252.936661 |   11)               |    serial8250_tx_dma() {
3252.936664 |   11)               |      /* serial8250_tx_dma: tx_running => 1 */
3252.936665 |   11)   3.989 us    |    }
3252.936665 |   11) + 10.880 us   |  }

Thanks,
Raul


