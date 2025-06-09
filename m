Return-Path: <stable+bounces-152021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31055AD1E9F
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F517A1F80
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E283258CE9;
	Mon,  9 Jun 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X1gdliuB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36C1A23AF
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475096; cv=none; b=AXVCa8duLPIPcaZ1gBigXDqGQMNQBmwa7Zq5CRcgIeFHfZx1olV/KhlXXgBtSTy/bjsmApIQnWRRtv5GKbEvkNM+25qs6VPD6Y//CyCe+FKtA5u3TSw8zqzt3YGlGqiwJHQxdhCRstTpoteUxJsiqv/wI16haIDSoKe1zHPTg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475096; c=relaxed/simple;
	bh=e0q6T0QkTmeXc+vAS5F97W8/LNcSjIH6NHd7gh+89lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjARhyo+sHk568wTOaHTNrzVb/aJ9dSVr0onSQaGZWMXE5lhEQXc0vszuiXpWRa61Ohj+Fyv+5ul16e3ekfF3SR51avuu9lH9m71CI6NGPFMX0bUNgoXoK2FSDBmsS+/ZFNTs0eL9K4Jk6uGPxTopOULq1EmtK7zhYU595+jAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X1gdliuB; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-404e580bf09so926740b6e.1
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749475093; x=1750079893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv0owSPwU0jkBHLRXq8flwNs9bitEruDQmiiy552H28=;
        b=X1gdliuBHmHFdMA1qA8VZOSozeqa8vubtpsoM3RKcPNJJipKIoRe6Gx+z2aEzGi1Pj
         fZD/g5OsO4qAfMTKn3gtkQ/v2fNsJGl1fvDBTIWulHQprgMoBspZJ2ky0J5YQK8z3aoB
         93d6gsJxiNCyynSbiINKc3yyWwLxg3GRNAexuTkD6kYlo7q81IwguESDBqeRAIQYGxDn
         EdGTPNbNx4ilmmIeT+8/7lT51cKl2yaBrqub+TCKMDaYMUai/bqpzZVdglu5t4xC6uJL
         Lipk8erf8Fk0eFR6dUEV6uaochZn/fMGfmLFGj5JfNnPDyXudAf5Ttya1z69tZv3hORZ
         tLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749475093; x=1750079893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv0owSPwU0jkBHLRXq8flwNs9bitEruDQmiiy552H28=;
        b=T8Gi6EQdWz9NEe2l4gG1TMmbqIerFdwVcBnyCaDvzNye5z7P5rFzh74E4FbVDUJxnZ
         X4HRpwJfhIAbz4sNEinKA8z6rFN++DAx9f/oO7G9AwYrDsPRFUJY3pJ8fsqjSSVI/sHc
         31mvtPgDSDqH2u167zKKofIiDfwjF+7LHcTdvWZVFHY8e6LxkboJbYYpKgd0sIzB+e8D
         yAm1isAGfw19k8SQ93cm4bEnvj/hnhIoGD1fpCbYvaUzhDojBv+yQCiDoPFTavQ3m+30
         Q8diSqaGNbU3uFRX+su7EIPSlLFhB1upqYTCisNenMsP4em3bVG20luKBeuV/R7NXqBd
         +gNg==
X-Forwarded-Encrypted: i=1; AJvYcCWyAfqsNn4JTORlmYnbze4bt11Uk44ovaNloYCfikN5/8wEZCQOCNhvvUPL4Qxt58tQ50eAdDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JodBl5ikAgGS4Fv95uTs0ybdTq/1z+bWmgc2QOhteIrtMq4n
	YYJhCgh1dDwuwdZXthad9HhfJJms8nVAtgaggPKKkTo39dab2qxhIuXRsiVt96TK4wvPvuaTndm
	hEoo8Q244kCo8XhPqNpsn8zzKZmnzrUq6E1CH3OW4bQ==
X-Gm-Gg: ASbGncsTnWvSvq5P3+GabbamIMv86ZENYG6eZVyyeHuKtyQPIGY+e893hfbIR2t2cFx
	faD7reD8ccd379TB75tdsz72YAt5Y7hhzfZ30mKPeTJJG5798S0qv+NaoVAcM6OcTHG/9Pq+yPT
	TjFndjOkqeuqB8xTmkOZGcZOXKgiW8/6IHLA2N6JMXyw3W6Q==
X-Google-Smtp-Source: AGHT+IF0KOMyJZ6Vv91d/Z//v27FuUU/3hsPVN/MSlwF4F2JnhJZzleGAcCuAZkISqlZvJcoudRUbxeC4l1TDqzZFNI=
X-Received: by 2002:a05:6870:328f:b0:29e:43ce:a172 with SMTP id
 586e51a60fabf-2ea012f0b9dmr7698264fac.28.1749475093002; Mon, 09 Jun 2025
 06:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609074348.54899-1-cuiyunhui@bytedance.com> <2025060913-suave-riveter-66d0@gregkh>
In-Reply-To: <2025060913-suave-riveter-66d0@gregkh>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 9 Jun 2025 21:18:02 +0800
X-Gm-Features: AX0GCFuD_Ncyifb6hxmcNxLcNfN0XY3J_XS8dc3_tcj7hBcJ0mwvbtYo_IujCWA
Message-ID: <CAEEQ3wmaiwd4TZfTa0YrLcKui9fSNJT0fR3j1=H1EK0T3npfyw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 1/4] serial: 8250: fix panic due to PSLVERR
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, heikki.krogerus@linux.intel.com, 
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, Jun 9, 2025 at 6:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Jun 09, 2025 at 03:43:45PM +0800, Yunhui Cui wrote:
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
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 6d7b8c4667c9c..07fe818dffa34 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port=
)
> >       /*
> >        * Now, initialize the UART
> >        */
> > -     serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> >
> >       uart_port_lock_irqsave(port, &flags);
> > +     serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > +
> >       if (up->port.flags & UPF_FOURPORT) {
> >               if (!up->port.irq)
> >                       up->port.mctrl |=3D TIOCM_OUT1;
> > --
> > 2.39.5
> >
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.

Can this issue reported by the bot be ignored?

>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

Thanks,
Yunhui

