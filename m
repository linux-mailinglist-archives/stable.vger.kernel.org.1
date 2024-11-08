Return-Path: <stable+bounces-91923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525109C1CCA
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125E3284348
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07B31E6DC1;
	Fri,  8 Nov 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="URZmWQz5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F731E573F
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068350; cv=none; b=AFFCrYe/i2Gre5LPH5+6bOxc87NZYdDVTRo0Fw5POumdg5kO0ClmhE6J89coNam/H8U9NbDnpMxE3O5+qDevdrq7F5LIdI8Znecr7KX9s1CV8i8ncnVK2rYxS5GP+/nszt7DX0VGmCw+CHdgPrPDrEUPfRg4MS5mxLB4TK7Agfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068350; c=relaxed/simple;
	bh=E4hEyj64Y9ak1ZD0SXt2+VnHjsiH3Ux2FturG9AliIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtKlL/Vt07XYjx64HaZvgYCMr/tkojCWy06sYNJuvlcdx0Kek8TvUcZKUEKj4vteRFaLSrVDGD8i5vZxpbFFwwrOn0dmx02KYxVrHlfTXUtJ570L7M/yNPToxAq1brvDIWhdAyGj760AiUMWSyrZdgzLSxSsmaNt35D79GHw9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=URZmWQz5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ec267b879so331458166b.2
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731068346; x=1731673146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNZul4H1oMCNnykvJMOdWlF4kN9Sf3IXvwJGAyLoPjc=;
        b=URZmWQz56oQyU3m8aoud3pJR5Ovsu+F84EqLMLVPiIRbIhzJ5wsOaly2HtoaTaRZIk
         0q10lZ9OD1gf0kA4d3F3WzcW6Vk02S6nE2Ru4HgxuBnoxetkzg/Rds9BfiMi1doVwqPn
         +rFEnmC+fQMd/DFklEMGj0oyagGLEOCUSCwNLDZQWbBoO4j3dZ+bSwi2gbDidr+gLDlZ
         bWily5vEsWjxnlMiNDxr8q4zsN17zuRrcZRNUnKDMfxR7idPAMLG2l3GCU+iKZsOPHhT
         Tds6ZKzuATJJzb1joDh4Pfjw1McTd+V3rWXEiqlzDnfg0A3BNotOSS8St06V6P/bplf5
         Jn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731068346; x=1731673146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNZul4H1oMCNnykvJMOdWlF4kN9Sf3IXvwJGAyLoPjc=;
        b=P9XpeNBUMn3AfnP34I78UUSED4G2A4zwOWco0lTmhe4i3xOF7+MXiwPub3RGy+2ZaB
         YVFJrpGDXABSZQAdkwhrq9VKLgEhIg/65zzSUAlejoMf/bqADtSHd85W9x1OUG7dVe1u
         BDvwifHQBNmbm6k+9gCEJQ7wzdZn4LF7n/Z43h9TjCFgyBNbdX9uAsckjt3s703xMyv9
         cOs2Sv4HCuIKQkg3RkMbXUbyqThwdTBhJRjUn7PtbkGucQtHD/HqKGhn9qBvLrqfk/DB
         o0aJJBKIbMLs97f6Z/7Ccpl4kbV1bh4/Pzz2q48i+LWqyArEXLFNkVAwQJmCPYeAEFyT
         myrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeqrUsMIF+Xc97YA8zLxRsC7OG2suwXnu7phK9ym6Vq8Zg91mdZKGCCkCsMV4XwaFxu4gZgrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjEEFBHBsirw6b/adiatt0IQR/heHUrcH1z6jsXwKFMf661qE
	dSMnMHIywjt/KPu1Oupdi8mUMifdqQHaHCNw6NkKGEh32kIu+xgX3UX3OI0qhiM=
X-Google-Smtp-Source: AGHT+IGoWl/C9/mrxka0P/xeIR6D/+yIUWsRutPZMQtY4LzR5g4j1yykV4TLsvWsuHbCY7xpoS7sEg==
X-Received: by 2002:a17:907:728a:b0:a9e:43d9:402d with SMTP id a640c23a62f3a-a9eeff0e43fmr227236166b.21.1731068345746;
        Fri, 08 Nov 2024 04:19:05 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4b82csm229764266b.67.2024.11.08.04.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 04:19:05 -0800 (PST)
Message-ID: <3711546e-a551-4cc9-a378-17aab5b426ef@tuxon.dev>
Date: Fri, 8 Nov 2024 14:19:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] serial: sh-sci: Check if TX data was written to
 device in .tx_empty()
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
 magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 gregkh@linuxfoundation.org, p.zabel@pengutronix.de, g.liakhovetski@gmx.de,
 lethal@linux-sh.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-serial@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
 <20241108100513.2814957-3-claudiu.beznea.uj@bp.renesas.com>
 <530f4a8e-b71a-4db1-a2cc-df1fcfa132ec@kernel.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <530f4a8e-b71a-4db1-a2cc-df1fcfa132ec@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Jiri,

On 08.11.2024 12:57, Jiri Slaby wrote:
> On 08. 11. 24, 11:05, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On the Renesas RZ/G3S, when doing suspend to RAM, the uart_suspend_port()
>> is called. The uart_suspend_port() calls 3 times the
>> struct uart_port::ops::tx_empty() before shutting down the port.
>>
>> According to the documentation, the struct uart_port::ops::tx_empty()
>> API tests whether the transmitter FIFO and shifter for the port is
>> empty.
>>
>> The Renesas RZ/G3S SCIFA IP reports the number of data units stored in the
>> transmit FIFO through the FDR (FIFO Data Count Register). The data units
>> in the FIFOs are written in the shift register and transmitted from there.
>> The TEND bit in the Serial Status Register reports if the data was
>> transmitted from the shift register.
>>
>> In the previous code, in the tx_empty() API implemented by the sh-sci
>> driver, it is considered that the TX is empty if the hardware reports the
>> TEND bit set and the number of data units in the FIFO is zero.
>>
>> According to the HW manual, the TEND bit has the following meaning:
>>
>> 0: Transmission is in the waiting state or in progress.
>> 1: Transmission is completed.
>>
>> It has been noticed that when opening the serial device w/o using it and
>> then switch to a power saving mode, the tx_empty() call in the
>> uart_port_suspend() function fails, leading to the "Unable to drain
>> transmitter" message being printed on the console. This is because the
>> TEND=0 if nothing has been transmitted and the FIFOs are empty. As the
>> TEND=0 has double meaning (waiting state, in progress) we can't
>> determined the scenario described above.
>>
>> Add a software workaround for this. This sets a variable if any data has
>> been sent on the serial console (when using PIO) or if the DMA callback has
>> been called (meaning something has been transmitted).
>>
>> Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - use bool type instead of atomic_t
>>
>>   drivers/tty/serial/sh-sci.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 136e0c257af1..65514d37bfe2 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -157,6 +157,7 @@ struct sci_port {
>>         bool has_rtscts;
>>       bool autorts;
>> +    bool first_time_tx;
> 
> This is a misnomer. It suggests to be set only during the first TX. 

I chose this naming as this was the scenario I discovered it didn't work.
Reproducible though these steps:

1/ open the serial device (w/o running any TX/RX)
2/ call tx_empty()

What
> about ::did_tx, ::performed_tx, ::transmitted, or alike?

I have nothing against any of these. Can you please let me know if you have
a preferred one?

> 
>> @@ -885,6 +887,7 @@ static void sci_transmit_chars(struct uart_port *port)
>>           }
>>             sci_serial_out(port, SCxTDR, c);
>> +        s->first_time_tx = true;
>>             port->icount.tx++;
>>       } while (--count > 0);
>> @@ -1241,6 +1244,8 @@ static void sci_dma_tx_complete(void *arg)
>>       if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>>           uart_write_wakeup(port);
>>   +    s->first_time_tx = true;
> 
> This is too late IMO. The first in-flight dma won't be accounted in
> sci_tx_empty(). From DMA submit up to now.

If it's in-flight we can't determine it's status anyway with one variable.
We can set this variable later but it wouldn't tell the truth as the TX
might be in progress anyway or may have been finished?

The hardware might help with this though the TEND bit. According to the HW
manual, the TEND bit has the following meaning:

0: Transmission is in the waiting state or in progress.
1: Transmission is completed.

But the problem, from my point of view, is that the 0 has double meaning.

I noticed the tx_empty() is called in kernel multiple times before
declaring TX is empty or not. E.g., uart_suspend_port() call it 3 times,
uart_wait_until_sent() call it in a while () look with a timeout. There is
the uart_ioctl() which calls it though uart_get_lsr_info() only one time
but I presumed the user space might implement the same multiple trials
approach before declaring it empty.

Because of this I considered it wouldn't be harmful for the scenario you
described "The first in-flight dma won't be accounted in sci_tx_empty()"
as the user may try again later to check the status. For this reason I also
chose to have no extra locking around this variable.

Please let me know if you consider otherwise.

Thank you,
Claudiu Beznea

> 
>> @@ -2076,6 +2081,10 @@ static unsigned int sci_tx_empty(struct uart_port
>> *port)
>>   {
>>       unsigned short status = sci_serial_in(port, SCxSR);
>>       unsigned short in_tx_fifo = sci_txfill(port);
>> +    struct sci_port *s = to_sci_port(port);
>> +
>> +    if (!s->first_time_tx)
>> +        return TIOCSER_TEMT;
> 
> So perhaps check if there is a TX DMA running here too?
> 
>>         return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT
>> : 0;
>>   }
> 
> thanks,

