Return-Path: <stable+bounces-55112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7981915958
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 23:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DA028141D
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E33C19E837;
	Mon, 24 Jun 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BhQycbr5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50526135A4B
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266340; cv=none; b=VWBPxkumOqKpwZojHF8Px2gOuwE7OJuSIiaMl6QdYTc7TiNJdFSXc5svW57hx574FY/l3nx4ifY2oO8t6ZMkp6grIeHkk3QTikI9ihh453mNkIgXYqi9iyooCXdy7A4ibNjmbV7mNQNngUiaxtGoTssF4RxU+ikUo+75K+quLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266340; c=relaxed/simple;
	bh=VLdhJLIwaxQ8wxTJQNH+te/BcT//2ZP5Bbh7eH2t22E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AH3up3NtMUfunJBbrFcNt+xzjcJOCxjhl7ltClED1poUE41Q1Ih9NIst5R21iKPDLRXE8HIJHiZTCZ4FMjBmx0sbXRxUcE1zXO/TFFENWFrsz3ye5ybMpGrDaXsC3jNoOejiLOrGv+DxGvFAVJYAsQZGLSQLKgCLzJmNFapbnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BhQycbr5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-444cd0ee46aso14486471cf.3
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719266335; x=1719871135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PykbmAe7/RecVGDwZZ/IKDsll6JeakGvoiBa3T2dozg=;
        b=BhQycbr5Gv+j5mUT5pcLolID+cPjQxl9s9QpOZmIvpIWpPVXQmMytFaWd0o705JEdT
         gvwr7rAl6YDjKf3j5N3XcoGWgte+ncksUnzLWh9+4V71DMv9v84nnYlRPeW7FQC3hQwX
         eFqN7f+Hk503dGmVfgHE1M7PXUHBv925IHSqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266335; x=1719871135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PykbmAe7/RecVGDwZZ/IKDsll6JeakGvoiBa3T2dozg=;
        b=TZ660M4TKiGpidWUCK1zS3Di7ki66dl6uiylDPYtijWM7qoruYl7Di861fGWn3krIs
         YcKouTMk3fWOg7/MOnifpZQTYLYMG/eEpEmpCCRmmqksx00P9/gS77qvMS0hJzEEEVdS
         sK43OrfeWYlbZxYfPwqwcARrcY/bTsH85TnjnBBDEKvAGYcHV5SbMAVYiGRvGVEVfOno
         Mu3tA/VMD7Q3hKWgT9kAfNbW6gBD48SlFIAUPmTy118/D+BD7DEs6gw0JHAnsgJD/b5e
         CdMYtlAi0Ro9FG18JlAcAdZfvfZ0+hghFbsNgc9l+gJQ1riP79iQFy8rzY5Fe0vbpMiO
         rK8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWG5aaNq9/ARP3iJfDjosS9V9Y79F2zABXLVPrHX0NLLhITH4EQFcR7yLuaZniUTC86N9TFLvaKk5dlh8suzDj6/nY7+Lxg
X-Gm-Message-State: AOJu0YymUq1U25NmssnzJZmXWH2h8bUXG8CCKN5JBnWHL5qWpGAtiDDA
	WtGim1oAXpmMzbcRpa8tZIbkUeBhSZrc4YywEA4PJptvCkQv6wklqXXOXXbwJArDB8HqVuAjZOk
	=
X-Google-Smtp-Source: AGHT+IGKJlMY308wqnVYHh5kqbt9/PZ1qHZeb/sKyhFFRECZRIt1Lpx/rjVTS00+Z6DvBo/SVV8d6w==
X-Received: by 2002:a05:622a:4fcc:b0:444:f0b5:8a5e with SMTP id d75a77b69052e-444f0b58da0mr15213351cf.32.1719266335496;
        Mon, 24 Jun 2024 14:58:55 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2cac5acsm46745101cf.97.2024.06.24.14.58.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:58:54 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-443586c2091so55571cf.0
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 14:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2e5zOIPnpj9NbfYIgsbhRhgXY15oOZPNrMD/vfQwVnucEDdi2VsLmt8kWeAfaDkro7A3JF6ClZl8Dmhaw/2If48Tuqqqv
X-Received: by 2002:ac8:59d0:0:b0:444:ba78:c32c with SMTP id
 d75a77b69052e-444f36a7810mr388891cf.11.1719266334099; Mon, 24 Jun 2024
 14:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org>
 <20240624133135.7445-3-johan+linaro@kernel.org> <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
In-Reply-To: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 14:58:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPKqjMcWhqk4OKxSOPgDKh-VM4J4oMEdQtgpFBw8WSXA@mail.gmail.com>
Message-ID: <CAD=FV=XPKqjMcWhqk4OKxSOPgDKh-VM4J4oMEdQtgpFBw8WSXA@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: qcom-geni: fix soft lockup on sw flow control
 and suspend
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 2:23=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel=
.org> wrote:
> >
> > The stop_tx() callback is used to implement software flow control and
> > must not discard data as the Qualcomm GENI driver is currently doing
> > when there is an active TX command.
> >
> > Cancelling an active command can also leave data in the hardware FIFO,
> > which prevents the watermark interrupt from being enabled when TX is
> > later restarted. This results in a soft lockup and is easily triggered
> > by stopping TX using software flow control in a serial console but this
> > can also happen after suspend.
> >
> > Fix this by only stopping any active command, and effectively clearing
> > the hardware fifo, when shutting down the port. Make sure to temporaril=
y
> > raise the watermark level so that the interrupt fires when TX is
> > restarted.
>
> Nice! I did quite a few experiments, but it sounds like you found
> something that I wasn't able to find. Specifically once I cancelled an
> ongoing command I could never manage to get it started back up, but it
> must have just been that data was still in the FIFO and thus the
> watermark never fired again.
>
> When I was experimenting, I also swore that there were cases where
> geni would sometimes fully drop bytes when I tried to "cancel" a
> command, but maybe I was mistaken. Everything I figured out was
> essentially by running experiments and I could easily have had a bug
> in my experiment.
>
>
> > Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver s=
upport for GENI based QUP")
> > Cc: stable@vger.kernel.org      # 4.17
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial=
/qcom_geni_serial.c
> > index 1d5d6045879a..72addeb9f461 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -651,13 +651,8 @@ static void qcom_geni_serial_start_tx_fifo(struct =
uart_port *uport)
> >  {
> >         u32 irq_en;
> >
> > -       if (qcom_geni_serial_main_active(uport) ||
> > -           !qcom_geni_serial_tx_empty(uport))
> > -               return;
> > -
> >         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> >         irq_en |=3D M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
> > -
> >         writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
> >         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> >  }
> > @@ -665,16 +660,28 @@ static void qcom_geni_serial_start_tx_fifo(struct=
 uart_port *uport)
> >  static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
> >  {
> >         u32 irq_en;
> > -       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> >
> >         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> >         irq_en &=3D ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
> >         writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
> >         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> > -       /* Possible stop tx is called multiple times. */
>
> If qcom_geni_serial_stop_tx_fifo() is supposed to be used for UART
> flow control and you have a way to stop the transfer immediately
> without losing data (by using geni_se_cancel_m_cmd), maybe we should
> do that? If the other side wants us to stop transferring data and we
> can stop it right away that would be ideal...
>
>
> > +}
> > +
> > +static void qcom_geni_serial_clear_tx_fifo(struct uart_port *uport)
> > +{
> > +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > +
> >         if (!qcom_geni_serial_main_active(uport))
> >                 return;
> >
> > +       /*
> > +        * Increase watermark level so that TX can be restarted and wai=
t for
> > +        * sequencer to start to prevent lockups.
> > +        */
> > +       writel(port->tx_fifo_depth, uport->membase + SE_GENI_TX_WATERMA=
RK_REG);
> > +       qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > +                                       M_TX_FIFO_WATERMARK_EN, true);
>
> Oh, maybe this "wait for sequencer to start to prevent lockups." is
> the part that I was missing? Can you explain more about what's going
> on here? Why does waiting for the watermark interrupt to fire prevent
> lockups? I would have imagined that the watermark interrupt would be
> part of the geni hardware and have nothing to do with the firmware
> running on the other end, so I'm not sure why it firing somehow would
> prevent a lockup. Was this just by trial and error?

Actually, the more I look at it the more confused I am about your
qcom_geni_serial_clear_tx_fifo(). Can you explain and maybe add some
inline comments in the function since it's not obvious? Specifically,
things I'm confused about with your patch:

1. The function is named qcom_geni_serial_clear_tx_fifo() which
implies that when it finishes that the hardware FIFO will have nothing
in it. ...but how does your code ensure this?

2. If the function is really clearing the FIFOs then why do we need to
adjust the watermark level? The fact that you need to adjust the
watermark levels implies (to me) that there are things stuck in the
FIFO still. ...but then what happens to those characters? When are
they sent?

3. On my hardware you're setting the FIFO level to 16 here. The docs I
have say that if the FIFO level is "less than" the value you set here
then the interrupt will go off and further clarifies that if you set
the register to 1 here then you'll get interrupted when the FIFO is
empty. So what happens with your solution if the FIFO is completely
full? In that case you'd have to set this to 17, right? ...but then I
could believe that might confuse the interrupt handler which would get
told to start transmitting when there is no room for anything.


Maybe something is missing in my mental model here and testing your
patch and hitting Ctrl-C seems to work, but I don't really understand
why so hopefully you can clarify! :-)

-Doug

