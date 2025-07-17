Return-Path: <stable+bounces-163269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E179AB08EEC
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC29CA4150B
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9542F6FAB;
	Thu, 17 Jul 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zzyPBc/m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KN43jpMp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7727A448;
	Thu, 17 Jul 2025 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761674; cv=none; b=IU7Cxvqu4VtexmKE743roTi6HVUcaHbf3SlEP5hdUF1X7IHagdQOz1BUiakIP/9MTZ+r1lziGh98QtSdzB9JFqcQ5iX9a1DJsZyQES/hke29rf+kGaUwQgJlkEf8bKO3A1nLiEmW+nwVioEV6xztq2iDPv8a4oeM/HwgGCI3AxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761674; c=relaxed/simple;
	bh=h2ovWkYi0w+2CUPEop0nRx81HZrnRolcW8rIZF7cDAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IcNR0CkfFs4h+U+ba0oq7ahrT6I344rI9DkFClAbEmYa+PcF8xQge6FGzdt5+jnR7zbgpz1wsI2yg1a7bPxG8Ph8vJPdFnX4pJDqAY7q2UnLohxwqofBgyvvRYYPGJMYXXJdUvd+sVBHNA+x7YtACYHDXiwP6jdAxC4UkZMBGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zzyPBc/m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KN43jpMp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752761670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6HPPKpd3naPxlyUGoW7Ppyv/8Hu5ztE7m1CGPnk5wg=;
	b=zzyPBc/miPJU/u7WKM24c2CZTcIjKrDs0cVK5zkudVgEUOyqQJs43mLHdaE8Hs0t5bYuRA
	+0IqbnsoVET0JduaEVBts2WloZDphRnnu0POXKn+H4j9qrxN/gA2Vd764JXtLpG/tylNWp
	LcqvSefr4ApByOTGEcI+YEIcDKUAyjqE8PpJZcn4gA/rsCX3oubzy6DH7AiFz//tIzpyYy
	HqcpCCbVcM1H75HjUrFF2LteLKlbJwrjZ7v47lxtk2tcBUYMccAWS+xlkpuyS4ylSWQqU9
	lBq7+mFlSgCqaJ834E3N63FsHjiHhDjKv8rU1T1kANypxAUtp4hBkXcHueMAKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752761670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6HPPKpd3naPxlyUGoW7Ppyv/8Hu5ztE7m1CGPnk5wg=;
	b=KN43jpMpHBUFYieRN4GY8Lzu/uNUCcCuhlLUjFaoPW4EoF8sfgvOU33kr2IFTswtfPpXgr
	T86rfnsZLCapEaCA==
To: yunhui cui <cuiyunhui@bytedance.com>, Douglas Anderson
 <dianders@chromium.org>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com,
 benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 jirislaby@kernel.org, jkeeping@inmusicbrands.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de,
 paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com,
 sunilvl@ventanamicro.com, tim.kryger@linaro.org, stable@vger.kernel.org
Subject: Re: [External] Re: [PATCH v9 2/4] serial: 8250_dw: fix PSLVERR on
 RX_TIMEOUT
In-Reply-To: <CAEEQ3w==dO2i+ZSsRZG0L1S+ccHSJQ-aUa9KE638MwnBM4+Jvw@mail.gmail.com>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-3-cuiyunhui@bytedance.com>
 <CAEEQ3w=pUPEVOM4fG6wr06eOD_uO6_ZBzORaG1zhtPswD8HLNQ@mail.gmail.com>
 <84cyauq2nc.fsf@jogness.linutronix.de>
 <CAEEQ3w==dO2i+ZSsRZG0L1S+ccHSJQ-aUa9KE638MwnBM4+Jvw@mail.gmail.com>
Date: Thu, 17 Jul 2025 16:20:29 +0206
Message-ID: <84ikjqaoqi.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Added Douglas Anderson, author of commit 424d79183af0 ("serial: 8250_dw:
Avoid "too much work" from bogus rx timeout interrupt").

On 2025-07-11, yunhui cui <cuiyunhui@bytedance.com> wrote:
>> On 2025-06-23, yunhui cui <cuiyunhui@bytedance.com> wrote:
>> >> The DW UART may trigger the RX_TIMEOUT interrupt without data
>> >> present and remain stuck in this state indefinitely. The
>> >> dw8250_handle_irq() function detects this condition by checking
>> >> if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
>> >> detected, it performs a "dummy read" to recover the DW UART from
>> >> this state.
>> >>
>> >> When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
>> >> while the FIFO is enabled and UART_LSR_DR is not set will generate a
>> >> PSLVERR error, which may lead to a system panic. There are two methods
>> >> to prevent PSLVERR: one is to check if UART_LSR_DR is set before reading
>> >> UART_RX when the FIFO is enabled, and the other is to read UART_RX when
>> >> the FIFO is disabled.
>> >>
>> >> Given these two scenarios, the FIFO must be disabled before the
>> >> "dummy read" operation and re-enabled afterward to maintain normal
>> >> UART functionality.
>> >>
>> >> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
>> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> >> Cc: stable@vger.kernel.org
>> >> ---
>> >>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
>> >>  1 file changed, 9 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> >> index 1902f29444a1c..082b7fcf251db 100644
>> >> --- a/drivers/tty/serial/8250/8250_dw.c
>> >> +++ b/drivers/tty/serial/8250/8250_dw.c
>> >> @@ -297,9 +297,17 @@ static int dw8250_handle_irq(struct uart_port *p)
>> >>                 uart_port_lock_irqsave(p, &flags);
>> >>                 status = serial_lsr_in(up);
>> >>
>> >> -               if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>> >> +               if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
>> >> +                       /* To avoid PSLVERR, disable the FIFO first. */
>> >> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
>> >> +                               serial_out(up, UART_FCR, 0);
>> >> +
>> >>                         serial_port_in(p, UART_RX);
>> >>
>> >> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
>> >> +                               serial_out(up, UART_FCR, up->fcr);
>> >> +               }
>> >> +
>> >>                 uart_port_unlock_irqrestore(p, flags);
>> >>         }
>>
>> I do not know enough about the hardware. Is a dummy read really the only
>> way to exit the RX_TIMEOUT state?
>>
>> What if there are bytes in the TX-FIFO. Are they in danger of being
>> cleared?
>>
>> From [0] I see:
>>
>> "Writing a "0" to bit 0 will disable the FIFOs, in essence turning the
>>  UART into 8250 compatibility mode. In effect this also renders the rest
>>  of the settings in this register to become useless. If you write a "0"
>>  here it will also stop the FIFOs from sending or receiving data, so any
>>  data that is sent through the serial data port may be scrambled after
>>  this setting has been changed. It would be recommended to disable FIFOs
>>  only if you are trying to reset the serial communication protocol and
>>  clearing any working buffers you may have in your application
>>  software. Some documentation suggests that setting this bit to "0" also
>>  clears the FIFO buffers, but I would recommend explicit buffer clearing
>>  instead using bits 1 and 2."
>>
>> Have you performed tests where you fill the TX-FIFO and then
>> disable/enable the FIFO to see if the TX-bytes survive?
>
> Sorry, I haven't conducted relevant tests. The reason I made this
> modification is that it clearly contradicts the logic of avoiding
> PSLVERR. Disabling the FIFO can at least prevent the Panic() caused by
> PSVERR.

I am just wondering if there is some other way to avoid this. But since
we are talking about a hardware quirk and it is only related to
suspend/resume, maybe it is acceptable to risk data corruption in this
case. (?)

I am hoping Douglas can chime in.

John Ogness

>> [0] https://en.wikibooks.org/wiki/Serial_Programming/8250_UART_Programming

