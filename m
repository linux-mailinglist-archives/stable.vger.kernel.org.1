Return-Path: <stable+bounces-155320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51457AE3864
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A6116BEC3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB7A22D7A7;
	Mon, 23 Jun 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lkQF8OCx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CECKkIHZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B737211C;
	Mon, 23 Jun 2025 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667548; cv=none; b=gwLwrdSCnjw3122DmPIwFQk0k6I59guePh+NlxdOUJhiXChRe8OZWvNZb72+EzvkgnBYH45/BygFiT+1Z/zBiH7V+/uu8QOv0hoQpZwRfEFFdqB9ab2y68OKpGAIC7XmLwI6h8XGT9LVZvr7UnFMedYKvSIhvwVVUcv2utNXuH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667548; c=relaxed/simple;
	bh=NkTK2xU5GNOOTzt4+4ac7aMoAn+9hIaNTqCBu3oKpbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OUN+8fJUFUMa+k4CuV7UjZOcsp9TQSjYOddRqooKnHDS4Z7qB9M0UyD6K8GkADV+SVe8jiJLygZugd13NJE+4+fRjBSQXr5dOKI2s5Ch4AoA1kCrecigQcVF8MgzZoqB61KTZY/Y3Ub/jRf5SdZLl7tS8FJ8DTIcYcqinvD9VYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lkQF8OCx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CECKkIHZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750667544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TBn4MEBOK0ZmxdXFsUTHmooPn2yAfLFgSEgICXe3Wg=;
	b=lkQF8OCxmCGCB6iWsrGliKc+7GLLsC5mdKAEbfMLPnyPcZgyYVvBdn14i2CUlL6qLCCM5Q
	DfgA782HtzGnZt0nxPzgX27haotYmdzZiV3VEfTOSwtmgnwsNsMxx4SFlj2eHQWsThWOOF
	P7CkXc2yIGGRCnXwG3LyjXSNM+gX6WIp2Aney+BaSdJVu/g3mr+0CoSBlZ9pUKYL1rl89M
	MsRQltWBKCrAhF6hcm3P62Cj7kIS2r90Sqb9euXnhOXmFmqdY4C4v0sVfp4M0XtlAbkYQ6
	6+ciq7Nk6N/Fg3hbmYZhlugJ9qCQgIzOeQwk4+uE3LyYTtt9x7xUQHLsYGMP0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750667544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TBn4MEBOK0ZmxdXFsUTHmooPn2yAfLFgSEgICXe3Wg=;
	b=CECKkIHZGm4M0F5XqJ/bjKbES7SjUlsNHDOD4Vw5cw3bx6wC3oCXUZavDxLcNMs9twGyJq
	AG4iZr9bntxaYMDA==
To: yunhui cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
 cuiyunhui@bytedance.com, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 jirislaby@kernel.org, jkeeping@inmusicbrands.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de,
 paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com,
 sunilvl@ventanamicro.com, tim.kryger@linaro.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v9 2/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
In-Reply-To: <CAEEQ3w=pUPEVOM4fG6wr06eOD_uO6_ZBzORaG1zhtPswD8HLNQ@mail.gmail.com>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-3-cuiyunhui@bytedance.com>
 <CAEEQ3w=pUPEVOM4fG6wr06eOD_uO6_ZBzORaG1zhtPswD8HLNQ@mail.gmail.com>
Date: Mon, 23 Jun 2025 10:38:23 +0206
Message-ID: <84cyauq2nc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Yunhui,

On 2025-06-23, yunhui cui <cuiyunhui@bytedance.com> wrote:
>> The DW UART may trigger the RX_TIMEOUT interrupt without data
>> present and remain stuck in this state indefinitely. The
>> dw8250_handle_irq() function detects this condition by checking
>> if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
>> detected, it performs a "dummy read" to recover the DW UART from
>> this state.
>>
>> When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
>> while the FIFO is enabled and UART_LSR_DR is not set will generate a
>> PSLVERR error, which may lead to a system panic. There are two methods
>> to prevent PSLVERR: one is to check if UART_LSR_DR is set before reading
>> UART_RX when the FIFO is enabled, and the other is to read UART_RX when
>> the FIFO is disabled.
>>
>> Given these two scenarios, the FIFO must be disabled before the
>> "dummy read" operation and re-enabled afterward to maintain normal
>> UART functionality.
>>
>> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index 1902f29444a1c..082b7fcf251db 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -297,9 +297,17 @@ static int dw8250_handle_irq(struct uart_port *p)
>>                 uart_port_lock_irqsave(p, &flags);
>>                 status = serial_lsr_in(up);
>>
>> -               if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>> +               if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
>> +                       /* To avoid PSLVERR, disable the FIFO first. */
>> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
>> +                               serial_out(up, UART_FCR, 0);
>> +
>>                         serial_port_in(p, UART_RX);
>>
>> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
>> +                               serial_out(up, UART_FCR, up->fcr);
>> +               }
>> +
>>                 uart_port_unlock_irqrestore(p, flags);
>>         }
>>
>> --
>> 2.39.5
>
> Any comments on this patch?

I do not know enough about the hardware. Is a dummy read really the only
way to exit the RX_TIMEOUT state?

What if there are bytes in the TX-FIFO. Are they in danger of being
cleared?

From [0] I see:

"Writing a "0" to bit 0 will disable the FIFOs, in essence turning the
 UART into 8250 compatibility mode. In effect this also renders the rest
 of the settings in this register to become useless. If you write a "0"
 here it will also stop the FIFOs from sending or receiving data, so any
 data that is sent through the serial data port may be scrambled after
 this setting has been changed. It would be recommended to disable FIFOs
 only if you are trying to reset the serial communication protocol and
 clearing any working buffers you may have in your application
 software. Some documentation suggests that setting this bit to "0" also
 clears the FIFO buffers, but I would recommend explicit buffer clearing
 instead using bits 1 and 2."

Have you performed tests where you fill the TX-FIFO and then
disable/enable the FIFO to see if the TX-bytes survive?

John Ogness

[0] https://en.wikibooks.org/wiki/Serial_Programming/8250_UART_Programming

