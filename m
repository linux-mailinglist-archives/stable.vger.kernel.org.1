Return-Path: <stable+bounces-105526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3859D9F9FBA
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 10:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155E918914B4
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ECB1EC4F7;
	Sat, 21 Dec 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AaaEw4HT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240B1D959B
	for <stable@vger.kernel.org>; Sat, 21 Dec 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734772584; cv=none; b=VK5TjSX25OyKjQ6srHr1kF6yPeW6c8AqyTqaDMrMM7wp6BftSpXxIvJHp8Q43lunG3MqM4Bl/0Z75MEr2MWuNI/yPhk0Z57HyM5LQEuXlDaTa8LCimBu0l+mV5bUaMTvoYmV2UZj0Y+v2NcNmAI2vJdRsf3r867kUrk41wYWpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734772584; c=relaxed/simple;
	bh=EFzshZOaAHiXln3S9ny1EvTjPXRIIhUR6sm1JxbAkRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiI4AzRgS+P4XfPLRNLn3vAKias1THGSGIT0vWdmaNQc6I5d4J5my6tA1cWTltYKCaM5qAzs1qL7mx2rnGnKE/Ny1mHcoH1ibyu39uyiQf1jTIUYTBFvaLYLX1+Kg9a4Rc+9v3ZFpgzC/EfW5wKrk1ii6IU/C9ntkBh7nuFeYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AaaEw4HT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6aad76beeso411544166b.2
        for <stable@vger.kernel.org>; Sat, 21 Dec 2024 01:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734772581; x=1735377381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7y7OwDWmkLJB5LcPl9h/nsEPz8MIspvq4TozD4gpmk=;
        b=AaaEw4HTDMfytB9HwBt0eWNJjpz4oJU5Z7jCa430vzzohZOH+IovJvc2FHKbfbYV9d
         0FegVBtNUNeF2C4XTApYm41EmIhzHH659pP3IsNIcCI5+l1AwD4KC/9wi76NY0frdQBv
         XuCupPu71j6ubiSsUKM2XkbOQLeEwK6IOboCyRbEfTYGmnOblNtz9eOp04+DnOmnrD7y
         xG6VRejVU2l2Z7GrQcT6CH36g4oTBn33h0jJbYKdRL4HP+tfpOjSNdxaXwAGvXJYp2GX
         Uow1AfxUqPfcVKMAwLRAn8BO1X+TS1fvH5/assHfrwdW289HP0uztUJ2YexYQIzjRLP0
         SZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734772581; x=1735377381;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7y7OwDWmkLJB5LcPl9h/nsEPz8MIspvq4TozD4gpmk=;
        b=YHtCCgU1waoaN87tS5SbqcsFRzbeWEQyydL65kvrP0ZjbxLqd7r9UA2TROUzWTQT0y
         RATrSc6BsaKfRzocI+THGC3Tl/ocIXtn1xToijzVlbNfoK19Y4D5JbfcySH1p+OWiHQr
         /W8baiF0L26dduaUWA6upY89jYFHg1LHSGv/8gfIqJ7eFLY34nCUdixjWzhw6BJq7cUG
         sRCt62zMdfn3wz0wRSB/JGuVzjWxtXbXjdyzUX/sMwhk3S64uKg+6ymtwlldBhf9sbAB
         zDpjs5GAUguZiV55MzrSSyU4JBqauTeeCO7tYfaXHrhIpeyCwyRwrm7XgbPK0vEE2ZZW
         5YEg==
X-Forwarded-Encrypted: i=1; AJvYcCUtbgyWW+335ww2I4Jtq8V0WTxSOUPDC6fPQJUh2HY+AFhujoGls8hJq7cALBVGTA/h566QqfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCROwELUoswOpl+pO6ZxDDb0bcEyJREy762LyQDDwaBIzzHmcs
	iov4HDaIi9q1Vsinq05iW4Jw9ksmjdkh2GjQYi5hfL8Vn3g6EIx6s+kgPEIKx3o=
X-Gm-Gg: ASbGncuNlXs0vvJCKpKBZJeapof12/LefOUo7cqeYbKF84WiOTMPnEzAR0lQlsV5PVt
	IhOtaQM/8SqGDSHEEZ9ygqElQpZ4foAY5szvGT7ppf7RL0DPtP5DkLYFHy2ZZb0fz1VfguPU0/P
	CihR6buxVmwKP7HVnuTOWGG3mVVP4mf1ESgRzx413lHyRmfByW3z2kjn/t3H+vUs3HST5Y8mxVc
	8Fc9DZ2fLba+7tpOkC+lNk8iI3oxVv44Yi8hAPg803fuWDUHeImInqZg6ue8Bx03w==
X-Google-Smtp-Source: AGHT+IH6Mir6kvKhmopEih92UvP+T0jN4L75qV3Wl9MZkk+P+O1n54beK06Tmw3gpGrq/IpPTKrwPQ==
X-Received: by 2002:a17:907:94c6:b0:aa6:79fa:b47d with SMTP id a640c23a62f3a-aac2703375bmr565246966b.1.1734772581479;
        Sat, 21 Dec 2024 01:16:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f065391sm259457366b.178.2024.12.21.01.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 01:16:20 -0800 (PST)
Message-ID: <316408fc-156d-4c80-b62e-bcf1c4bd3c08@tuxon.dev>
Date: Sat, 21 Dec 2024 11:16:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 1/6] serial: sh-sci: Check if TX data was written to
 device in .tx_empty()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 wsa+renesas@sang-engineering.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 lethal@linux-sh.org, g.liakhovetski@gmx.de, groeck@chromium.org,
 mka@chromium.org, ulrich.hecht+renesas@gmail.com,
 ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <20241204155806.3781200-2-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWv-+gWkH2K0r740BaKLwnTm7RdOTd71DkWMDR0A52qEA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWv-+gWkH2K0r740BaKLwnTm7RdOTd71DkWMDR0A52qEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 19.12.2024 11:46, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Dec 4, 2024 at 4:58 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
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
>> been called (meaning something has been transmitted). In the tx_empty()
>> API the status of the DMA transaction is also checked and if it is
>> completed or in progress the code falls back in checking the hardware
>> registers instead of relying on the software variable.
>>
>> Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Thanks for your patch, which is now commit 7cc0e0a43a910524 ("serial:
> sh-sci: Check if TX data was written to device in .tx_empty()") in
> v6.13-rc3.
> 
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -885,6 +887,7 @@ static void sci_transmit_chars(struct uart_port *port)
>>                 }
>>
>>                 sci_serial_out(port, SCxTDR, c);
>> +               s->tx_occurred = true;
> And you cannot use the existing port->icount.tx below, as that is not
> reset to zero on sci_startup(), right?

I missed that the driver is incrementing the port->icount.tx . I'm not sure
we can use it though, as it is not reset on sci_startup(), as you pointed out.

Thank you,
Claudiu

