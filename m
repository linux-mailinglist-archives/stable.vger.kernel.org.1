Return-Path: <stable+bounces-161621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D6BB0112D
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 04:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642CD4A8552
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 02:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A1185B67;
	Fri, 11 Jul 2025 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="czD+YZ4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D654758
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200372; cv=none; b=jqxuovQLHPAdeAlumH7BjzUFUJh5ZDRfYUepS9hDos3oEDwSmxNfWuBkLJ73bJgKJJdL1NWxiFt+nZSyvAVVAJkGXwlX7n0r5pqkCjV3yi8A1xl7+S1Gd9Thin26/kX9yJG1zUZjedHTmV4PYJVk3RVsc8izoYpiYNBJzvUrQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200372; c=relaxed/simple;
	bh=y4jCcuJN7yjOr2y3cVPXJ+KAMqtUM1NbU0hlYIYhLMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnsVRoK985l72Zfv6DYP9dYO9wRGZvFjlNU5w9njiCrf46MoHGsyZKRNoTlzSLdo16R1IRHn2ZXNY0SdptVWl20Z7gymxwE6NOp9wfMHIVoK4wPzurrI0eVII7uCUNeMzkmq91oakhi0Bo7dX1SYid5YtJNRrhSBCJJO7dGrrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=czD+YZ4O; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40a4bf1ebb7so876222b6e.0
        for <stable@vger.kernel.org>; Thu, 10 Jul 2025 19:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752200368; x=1752805168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LguYWqKU69s8fXl+FAzLjDH/VFGVUbcH34uXEnvqnA=;
        b=czD+YZ4Og7rcEYzX78IQFVIEmFmxyFmKllaVmoCvFSxG62wcF8+7rJlGMnM8tezkJM
         3JvUJ2il+Z9ud0FX3cyWL3e1mrcTljkjvaL4lFvkZWNmaXiYUTd4LS+LH2BL7FbcY0t1
         MArj91zZQALa/TkLw0VPzHFJby/4H9awlWXjFcY9XSeybGNtE3bPNV7yj6mb2sF7Vv1A
         larPhjm/5b+ldI+qO8UQF/XThJ2UJSJ8Kq/xJju5x3XUFlqbZuUmoUOE1AxYSX2hTIbA
         q3esIf/HOwM94sRyuWH/1/iIkiqR6V41ZixzTxY12zYTTNcf7TdU+jYHAbMRrT71oaSn
         pPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752200368; x=1752805168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LguYWqKU69s8fXl+FAzLjDH/VFGVUbcH34uXEnvqnA=;
        b=fnEdjTRHA7KiAmXA0LyagxDPkUEV3lnVfT9EreBxIFnHzzqlJnEAXauyKjmipLwpuy
         NXenEeDJ+fPLZE6rkHefvh/vPygmEZa/g2iEYY59wFNQ/586bUD9ggUPrQAZ4EdKTYea
         7wD87u6SliHfkaYNQz1ntiMqDQjjaAt4tjQ9+MPeoKHywIxle3aks6aMh6ECC2iCXJk7
         3NAdzLDtf/u3aQhCV1uRcqvBPI5UKypcdkZcL5TuMMRk7bYexSZGJebCs04yhRdIzjjM
         HWgkkzH3tjdH2cYXzi/nqgnBRR/CJi0tTHccdB4bDsrCBWh6WhidKilLcHEc2ir7/LZt
         X+9g==
X-Forwarded-Encrypted: i=1; AJvYcCXZdiQQbbwfTiLET3II5ajDmyCAL7z8fqVr3Trq0Zw1tIv1i3ctHNDur3nqgG3Zs/H0JZQEYcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOS4XbU3mfhls73HqDQwppWKrjMsB7lAwJnlVTSxGz8lxj2XL/
	mwnfsqlWlHUvLbAQRQums09vemZ1DNXID/Z1C+SD3U7QqXskWrBw+6m46kUm9RwqpSecxUfZ03N
	2UgKyhYQhBbzQ6pluCsOk+BIU4Y/1UB7qxskP0AiTUg==
X-Gm-Gg: ASbGncv0RHjOpOiCYr8JFT4oEPNqtEWGNDha1pni6nhTmjI4u5SSk0ahi4kxyr4TMCG
	udKJXHzrkmsCKL88/E83Xva9Icxu0A/rzz86w5omc3J60qnpH01Bo7hrc7IoSgS8Mr3Air/hzlh
	dLK/9Lu4R2/4j/fhViGsd/Y6jjQoz4s76awO5oFFasrGhfpLVqVzemHnO2REgHTuDSNlqI/0HRL
	bAyLCZHxw==
X-Google-Smtp-Source: AGHT+IFBh7LzTFN9rD6gbXHF6ywmERfYcfitKd7WVxt6xE3tRn5i23AvprpdjVhHYknMIA3w2g9HGwRoOBZcHNEc3MQ=
X-Received: by 2002:a05:6808:16aa:b0:40b:1222:8fd8 with SMTP id
 5614622812f47-41539f925c2mr885406b6e.35.1752200367955; Thu, 10 Jul 2025
 19:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-3-cuiyunhui@bytedance.com> <CAEEQ3w=pUPEVOM4fG6wr06eOD_uO6_ZBzORaG1zhtPswD8HLNQ@mail.gmail.com>
 <84cyauq2nc.fsf@jogness.linutronix.de>
In-Reply-To: <84cyauq2nc.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 11 Jul 2025 10:19:16 +0800
X-Gm-Features: Ac12FXxBhZNNUH-29Cczmz3xlktD2RZw1X21GwvxVue8j6YX6ffOS8u3DsWgqNU
Message-ID: <CAEEQ3w==dO2i+ZSsRZG0L1S+ccHSJQ-aUa9KE638MwnBM4+Jvw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 2/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: John Ogness <john.ogness@linutronix.de>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, jkeeping@inmusicbrands.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Mon, Jun 23, 2025 at 4:32=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> Hi Yunhui,
>
> On 2025-06-23, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >> The DW UART may trigger the RX_TIMEOUT interrupt without data
> >> present and remain stuck in this state indefinitely. The
> >> dw8250_handle_irq() function detects this condition by checking
> >> if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
> >> detected, it performs a "dummy read" to recover the DW UART from
> >> this state.
> >>
> >> When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
> >> while the FIFO is enabled and UART_LSR_DR is not set will generate a
> >> PSLVERR error, which may lead to a system panic. There are two methods
> >> to prevent PSLVERR: one is to check if UART_LSR_DR is set before readi=
ng
> >> UART_RX when the FIFO is enabled, and the other is to read UART_RX whe=
n
> >> the FIFO is disabled.
> >>
> >> Given these two scenarios, the FIFO must be disabled before the
> >> "dummy read" operation and re-enabled afterward to maintain normal
> >> UART functionality.
> >>
> >> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogu=
s rx timeout interrupt")
> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/82=
50/8250_dw.c
> >> index 1902f29444a1c..082b7fcf251db 100644
> >> --- a/drivers/tty/serial/8250/8250_dw.c
> >> +++ b/drivers/tty/serial/8250/8250_dw.c
> >> @@ -297,9 +297,17 @@ static int dw8250_handle_irq(struct uart_port *p)
> >>                 uart_port_lock_irqsave(p, &flags);
> >>                 status =3D serial_lsr_in(up);
> >>
> >> -               if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> >> +               if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> >> +                       /* To avoid PSLVERR, disable the FIFO first. *=
/
> >> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
> >> +                               serial_out(up, UART_FCR, 0);
> >> +
> >>                         serial_port_in(p, UART_RX);
> >>
> >> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
> >> +                               serial_out(up, UART_FCR, up->fcr);
> >> +               }
> >> +
> >>                 uart_port_unlock_irqrestore(p, flags);
> >>         }
> >>
> >> --
> >> 2.39.5
> >
> > Any comments on this patch?
>
> I do not know enough about the hardware. Is a dummy read really the only
> way to exit the RX_TIMEOUT state?
>
> What if there are bytes in the TX-FIFO. Are they in danger of being
> cleared?
>
> From [0] I see:
>
> "Writing a "0" to bit 0 will disable the FIFOs, in essence turning the
>  UART into 8250 compatibility mode. In effect this also renders the rest
>  of the settings in this register to become useless. If you write a "0"
>  here it will also stop the FIFOs from sending or receiving data, so any
>  data that is sent through the serial data port may be scrambled after
>  this setting has been changed. It would be recommended to disable FIFOs
>  only if you are trying to reset the serial communication protocol and
>  clearing any working buffers you may have in your application
>  software. Some documentation suggests that setting this bit to "0" also
>  clears the FIFO buffers, but I would recommend explicit buffer clearing
>  instead using bits 1 and 2."
>
> Have you performed tests where you fill the TX-FIFO and then
> disable/enable the FIFO to see if the TX-bytes survive?

Sorry, I haven't conducted relevant tests. The reason I made this
modification is that it clearly contradicts the logic of avoiding
PSLVERR. Disabling the FIFO can at least prevent the Panic() caused by
PSVERR.

>
> John Ogness
>
> [0] https://en.wikibooks.org/wiki/Serial_Programming/8250_UART_Programmin=
g

Thanks,
Yunhui

