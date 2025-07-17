Return-Path: <stable+bounces-163257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25037B08CB4
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC6A45233
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6329E11A;
	Thu, 17 Jul 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HbrbVzTo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50A27B4FA
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754801; cv=none; b=no+OGQe+H9PgcoCIY7ocQ2ZApPudexDKZuR8UD+/lcvrdtNb6Wr/uZD2NHGSfoN6kg2I0V6xZ2e/oA/7t8Xf54DiJoJ6NZVPNe//u0bh5UCDfzdTQE1J/Uv4glSgnt5zoSPNS4njmKXbbE098Pjzd9zkcXYyysH8MIZSFyVPbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754801; c=relaxed/simple;
	bh=9BstoysraPcNdXHc1n0mia/3lc0Re5lG7hJE8+pelyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llFcXlSh9OqZLE0xK8oDg6e19Uw0qRFQhFMvdNIXYzAg7krSV71frpOnXT7E2IZM9LCaOuXxblyhnNdA8VFoy3EtGUntLD8Ohmbskvpjdgn6y9jhK78YAIPi6Rks6ORAcyXcNXNiQCgtJIk7n076biQqNz/KnznW8v/j5E0Purw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HbrbVzTo; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e586fcc28so1135823a34.0
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752754799; x=1753359599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/4/2GlFbqg9HLiAULIFmkWsYiTvbSro9cghjbjmQBg=;
        b=HbrbVzToAmyaAKLqriCpirFkAhW86rX5D9S6irC1xCmkWyVJJnDu5GEKi8nG3J6EO6
         UBPjpPWIZNhklZVgLI6pVdoO+3y3de8Qhi/OFrtc3xVVNFAX9Fo3GdrjAAqM/KxPQzK/
         qANvAcF90Rbk/1cjiEEJywVd2haeLn/8xaBFm5no1jCLA+zcDpYcGz3xpfFIY41Z803U
         5kEcDVpUldCibmnggSIJJEkfvmsdFQI+X9BHqIafDIS9Eru/mFbXllHjclll2Mns6TUZ
         un9PwlUWbh4/YzDCclyn4V9WhIQFmPaZR/2KxmLnKoMpa91C6K44kRCy+/VL4y/Np6iP
         SmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752754799; x=1753359599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/4/2GlFbqg9HLiAULIFmkWsYiTvbSro9cghjbjmQBg=;
        b=fyHR205MXRalwmFfkRefcpZ6ChBWB/isQcTmhDQRCm6IV+NhsPNgbEkND3iUQ5sgmF
         hzVCG8hrLVEfHM0ihg0YPVPx8sK+oJ943NF4b/bptIJuzblxJqvTh/tvfRn8MZt5/lc/
         ZJp5G/Tg1vQWwe6F6061vNUqURuz08bTiWNs1ImyvU9zOKt7NNsvgmHT61GqhkYcIc5w
         Wtrl4hk7gBkCvD2z3Knx1RV1YJhW62gpLDSRQUjCz94BSb9a9LQMKa0bhY/Rf+ESzl45
         nwJxvnbc2ImbXOpfe3FexCUHoWnHdBdOPEmp7sE/PP+/pMCoh22IEAQag8JwX2v/xsWa
         sAjA==
X-Forwarded-Encrypted: i=1; AJvYcCXxl6eG0q4vi3cro3LBuiDjSNA1Y3J3FnaF3j/vj9Hlm7P6LCyuDFB9Tr5BNYuvJJ/3fMnE6E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUfHPoQ8Bhp4SUowZnnCzBlpPp3vExd+qp+pISevR72nQrqvM
	ju/x9s4MB8tjT5hG/0G+Y3TSjOShZ/3EYkiX1j5s3pRha8As388IVsVAL3FWprHSBNDZA6Fysq8
	vwjx1APt7hMvvru+wi2lzI/xeLTOjcToJpV48ZVz6Ww==
X-Gm-Gg: ASbGncu6NMZg9rmEvB9kgSQRYqRJsFRKLubqAj+gZEbU+IrDFL8ex0i3/GE2eahxCa3
	q17jWp9FJ8EBvCvot3m107mupVnA/ulaLck2qCmlLosbEjbfDsEcQfhZhXL0MAALkUSu5Di7DJy
	70yUzxY0YlLGPTr3zphvCvqMR6r+vxNjTOiKB4S26ccew/kk4sTXPNvyMxLB/PgLaeNbm+f2CV7
	NN9bEk0UPKr4m5l5V8MEs5/Cv2oUyw=
X-Google-Smtp-Source: AGHT+IFuE6XD5lTWOXSNH1CM5vjssmv3cQEWKz8QIIOs4ZSd6cXO1A9SSlaFR0OA4UQ7x1Dn9lJKAZEfBfctdkacNn8=
X-Received: by 2002:a05:6808:4f5f:b0:3fe:aebe:dde7 with SMTP id
 5614622812f47-41e2dcc2f2emr2171185b6e.2.1752754799043; Thu, 17 Jul 2025
 05:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-2-cuiyunhui@bytedance.com> <84bjqik6ch.fsf@jogness.linutronix.de>
In-Reply-To: <84bjqik6ch.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 17 Jul 2025 20:19:48 +0800
X-Gm-Features: Ac12FXzX-8_oUrVkjPDnBHqZHa66JwCymGHzpPdOgfG20sVHt6vV7FE1XJLHuEU
Message-ID: <CAEEQ3wnBJUjArdfs+vgrsfoQaVJPKD3uwD8hwgg963fUBaNGrA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/4] serial: 8250: fix panic due to PSLVERR
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

On Fri, Jun 20, 2025 at 7:20=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2025-06-10, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >
> > In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the serial_port_in(port, UART_RX).
> > This satisfies the PSLVERR trigger condition.
> >
> > When another CPU (e.g., using printk()) is accessing the UART (UART
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
> > dw8250_force_idle().
> >
> > Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->loc=
k
> > to fix this issue.
> >
> > Panic backtrace:
> > [    0.442336] Oops - unknown exception [#1]
> > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > ...
> > [    0.442416] console_on_rootfs+0x26/0x70
> >
> > Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaroun=
d")
> > Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/=
T/
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Cc: stable@vger.kernel.org
>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

In this patchset, patch[4] has been dropped, and patch[2] may still
need discussion. Could you please pick patch[1] and patch[3] first?

Thanks,
Yunhui

