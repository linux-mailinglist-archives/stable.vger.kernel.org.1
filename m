Return-Path: <stable+bounces-105528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5A9F9FCE
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 10:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951817A05F9
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398471F0E37;
	Sat, 21 Dec 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kBjW+FHF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED01EC4EF
	for <stable@vger.kernel.org>; Sat, 21 Dec 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774029; cv=none; b=qyxkK4dU5FfgLMTb0/WKGTpD0qd6KsEEXlHSXWEuiX2MqxUP301y8rQuoj23HdxzV32h+c88lwUoG16GQ+DhcU9+L3m6HNwhQipjDF9WpyoNd6wFxemRocBRUtjOrIjIFjnCrSmv4aLMK4nmrg2RWiw0D9sdYzGnYbnHhf7Z79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774029; c=relaxed/simple;
	bh=QtSPJr5dnw06t/X8uoWn8Tq53GlF4BWXzKW3aahojdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXd3iLoWT1Puei29JOR+HTV2O+QcgY/SoP4/Cpx+PUHKdbiyBeC9brdhh1qKe/L7ynXPBd4+loglk1nyt7JCWdlEb85Rzz6bnIM8TdO27s+VrjpHsTjNQxMcMmtdCP0kTPyzCfcduyazh+0ctsNoTYkBXiV6J+mojOY6FaQ6PTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kBjW+FHF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d6d5765so1625944f8f.3
        for <stable@vger.kernel.org>; Sat, 21 Dec 2024 01:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734774025; x=1735378825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIwB/oZQl4g7ieJFtTHNp5DE7Eonl9+QTD4Sz6RGG6k=;
        b=kBjW+FHFKP2t9NmIoFhCCFxdxikgJyEUbTrsOqy6ZE5D3wC3Codx0eT/GnEM2ushb1
         kKH58gYzJgK14lyqs3HVRv1pKpjpYZG+0Wy6gnGs26qRuOSGGqivPAAqCEEbkdbvhjm6
         ri8xODhAsaykoB4rUmLITbGJ5Q/J4lTi7sZ+0/VmYRqi+GevdvXmtcNwFrOpsgJT1aS6
         RWBHC8dPJ20OREZhA04Xd9C6xuX+IYuZregPtVDFRWou197SiF7diFyd2zNCDUD0VhqZ
         JmRFl/x3kuV7ZRuJwNSGYKvpPt1emAZq4qKCXqPHLtF1j8axPsyc5HtFs8CQ4s80MYm4
         MPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734774025; x=1735378825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIwB/oZQl4g7ieJFtTHNp5DE7Eonl9+QTD4Sz6RGG6k=;
        b=WC98QpjVW9VvClPYvQbBadIBJbyWh8AegGlL8PgNMYxYQkjzID4BUM0mb/SRC8wr2X
         t3P8v8doZRj4Y8Jrjo/tsgHt9rludMfwTDZVN/tfWHLRfbiitA66Aim5U/3Ga/fCwwsC
         F8jIKkTEKyFMFs9IngfObmfPMgcwCXIDSjGurvv1l6QS7WoOiJtaXMT9QngDKA6apPdB
         6mGpAYB0u7ogiq5v/s6LMPFqsDRXTUbc2LxCrZo+49t2Uf4mvJEYY2r71LZMBC3Ywdcn
         3nZ1c0ThZ1tcR2K6C14oAnSm0g2ongeBaxDtsK9NMpdJqzYWp4bmhX0RIQk55Gz3VyvR
         qj9A==
X-Forwarded-Encrypted: i=1; AJvYcCVFXVwOMuGWv1tuSuNChcIbfPmmr13iysqe9gwQwWKLroPfA3byHIXT/HMzahiz3TRWGs/Dy44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9HkoaCHFdzHWzubiNh4Jz5n1SIjUYtmwyI3597PLpJf4KyTf
	S/4x+31wrkaB/iKpxMi04x/BzoGHSXqiOMNuq5GjglmqvWq+ZiGj3nF4injXUHI=
X-Gm-Gg: ASbGncs9f2gV/NcbAG/8JenqV/nvCXfXshJFRQSNlGOVXNdN6HFTQt/dbj0SkOTxm2A
	9+WUBlAYf/R4rvLhUjxaWHlUuB/SHo6sGk/cDejncQPqqccdfc/1hPS9vQTfgd95+1OmroCjNsb
	0xOi3zFCycNeHm/Zw4tf9mUePY8p1fQH+E/y6eGmlCm6rWD0157SGFfL1WN05eEtMt2fOuDt0y9
	owAyq2ZyhrrK7v87ADzG56SS5CSLIx8df3CQEAufwGB54zTwJIOskSw5AQQpyFK/A==
X-Google-Smtp-Source: AGHT+IHq5KVl/zqdJubE8s9A3F+aeH47eWLbCb3zyQd2iMVbVph3maumX8hfuBUW6E7CE87SwbGqEw==
X-Received: by 2002:a05:6000:713:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-38a221f2ec7mr5968387f8f.7.1734774025442;
        Sat, 21 Dec 2024 01:40:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2311b3c8sm3643925f8f.25.2024.12.21.01.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 01:40:24 -0800 (PST)
Message-ID: <0ef6c596-92c1-4d02-b589-f5e9aee96088@tuxon.dev>
Date: Sat, 21 Dec 2024 11:40:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 6/6] serial: sh-sci: Increment the runtime usage
 counter for the earlycon device
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 wsa+renesas@sang-engineering.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 lethal@linux-sh.org, g.liakhovetski@gmx.de, groeck@chromium.org,
 mka@chromium.org, ulrich.hecht+renesas@gmail.com,
 ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <20241204155806.3781200-7-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWB2q7=gkHUsmVWwZMCWaj-htUpOQCr24y5HsbQvM+HMA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWB2q7=gkHUsmVWwZMCWaj-htUpOQCr24y5HsbQvM+HMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19.12.2024 16:30, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Dec 4, 2024 at 4:58 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
>> with earlycon mapped at index zero.
>>
>> The uart_add_one_port() function eventually calls __device_attach(),
>> which, in turn, calls pm_request_idle(). The identified code path is as
>> follows:
>>
>> uart_add_one_port() ->
>>   serial_ctrl_register_port() ->
>>     serial_core_register_port() ->
>>       serial_core_port_device_add() ->
>>         serial_base_port_add() ->
>>           device_add() ->
>>             bus_probe_device() ->
>>               device_initial_probe() ->
>>                 __device_attach() ->
>>                   // ...
>>                   if (dev->p->dead) {
>>                     // ...
>>                   } else if (dev->driver) {
>>                     // ...
>>                   } else {
>>                     // ...
>>                     pm_request_idle(dev);
>>                     // ...
>>                   }
>>
>> The earlycon device clocks are enabled by the bootloader. However, the
>> pm_request_idle() call in __device_attach() disables the SCI port clocks
>> while earlycon is still active.
>>
>> The earlycon write function, serial_console_write(), calls
>> sci_poll_put_char() via serial_console_putchar(). If the SCI port clocks
>> are disabled, writing to earlycon may sometimes cause the SR.TDFE bit to
>> remain unset indefinitely, causing the while loop in sci_poll_put_char()
>> to never exit. On single-core SoCs, this can result in the system being
>> blocked during boot when this issue occurs.
>>
>> To resolve this, increment the runtime PM usage counter for the earlycon
>> SCI device before registering the UART port.
>>
>> Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3435,7 +3435,24 @@ static int sci_probe_single(struct platform_device *dev,
>>                 sciport->port.flags |= UPF_HARD_FLOW;
>>         }
>>
>> +       /*
>> +        * In case:
>> +        * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
>> +        * - it now maps to an alias other than zero and
>> +        * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
>> +        *   available in bootargs)
>> +        *
>> +        * we need to avoid disabling clocks and PM domains through the runtime
>> +        * PM APIs called in __device_attach(). For this, increment the runtime
>> +        * PM reference counter (the clocks and PM domains were already enabled
>> +        * by the bootloader). Otherwise the earlycon may access the HW when it
>> +        * has no clocks enabled leading to failures (infinite loop in
>> +        * sci_poll_put_char()).
>> +        */
>> +
>>         if (sci_ports[0].earlycon && sci_ports[0].port.mapbase == sci_res->start) {
> 
> Now there are two tests for mapbase: here and in sci_probe()...

I'll adjust it!

Thank you for your review,
Claudiu

> 
>> +               pm_runtime_get_noresume(&dev->dev);
>> +
>>                 /*
>>                  * Skip cleanup up the sci_port[0] in early_console_exit(), this
>>                  * port is the same as the earlycon one.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


