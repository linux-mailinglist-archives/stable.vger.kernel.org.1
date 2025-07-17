Return-Path: <stable+bounces-163258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EDB08CF2
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EB5563E01
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9502BEFF7;
	Thu, 17 Jul 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQG//UeG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DBD145348;
	Thu, 17 Jul 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755578; cv=none; b=CUfyB9cXktBBcYD/e3D9cOSMvRs2YjcLr9n6SY1cpzvp5rW3Zq+gg9+zfpU1Rs22roWRoZbxethaE0uHoXNyCoeVeC0Ka539QN1RuJoKzHCY8YtT4D7EWZ2XsWOk/F0iuvMVerF/j6FcFDHpJpcW00rPEVMX6bHgEEtqUzGNLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755578; c=relaxed/simple;
	bh=rdPFi5QLTTflYAbwD68jBOXBNxPndlpe1P3irxScbmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de939/BrRw69V/qiR7CBsODoMFKgCfM6hrZEgexe3RLGjjd4137uyRUhL+N54GquvN4ttoQK0cpVt57Y539pJkUnvTC/dZ8M6EjhMjCsYcyUijhmGn1sanmnH9odSamNOpERRife/BCzOGe5ZDohtpeqAjdX0vFHbm8Q6raiBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQG//UeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBD8C4CEE3;
	Thu, 17 Jul 2025 12:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752755576;
	bh=rdPFi5QLTTflYAbwD68jBOXBNxPndlpe1P3irxScbmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQG//UeGbraxLmYxHhN9mn7YW8gALZci7ndhYDRGxcs2tbVIKfNHga5XJkMRhKl90
	 YBF6New1T3mXEfEsd3gaJRwj00eS+86mcxOFdDFxph9ncSS4e8zV9WYvm0/drAR9w+
	 Gv7psowxXhOzpXHjY1UtOXfRVidwOfC6Kr6tu48M=
Date: Thu, 17 Jul 2025 14:32:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: John Ogness <john.ogness@linutronix.de>, arnd@arndb.de,
	andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org, jkeeping@inmusicbrands.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	markus.mayer@linaro.org, matt.porter@linaro.org,
	namcao@linutronix.de, paulmck@kernel.org, pmladek@suse.com,
	schnelle@linux.ibm.com, sunilvl@ventanamicro.com,
	tim.kryger@linaro.org, stable@vger.kernel.org
Subject: Re: [External] Re: [PATCH v9 1/4] serial: 8250: fix panic due to
 PSLVERR
Message-ID: <2025071729-exemplary-smelting-08fe@gregkh>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-2-cuiyunhui@bytedance.com>
 <84bjqik6ch.fsf@jogness.linutronix.de>
 <CAEEQ3wnBJUjArdfs+vgrsfoQaVJPKD3uwD8hwgg963fUBaNGrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wnBJUjArdfs+vgrsfoQaVJPKD3uwD8hwgg963fUBaNGrA@mail.gmail.com>

On Thu, Jul 17, 2025 at 08:19:48PM +0800, yunhui cui wrote:
> Hi John,
> 
> On Fri, Jun 20, 2025 at 7:20 PM John Ogness <john.ogness@linutronix.de> wrote:
> >
> > On 2025-06-10, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
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
> >
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 
> In this patchset, patch[4] has been dropped, and patch[2] may still
> need discussion. Could you please pick patch[1] and patch[3] first?

Please resend just the patches you want applied, picking out of a series
is hard with our current tools, and confusing.

thanks,

greg k-h

