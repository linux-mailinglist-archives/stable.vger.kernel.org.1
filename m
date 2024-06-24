Return-Path: <stable+bounces-55108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEEE9158CF
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 23:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21C728120A
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55491A0AFB;
	Mon, 24 Jun 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kDNZt61U"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC651A08DF
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264255; cv=none; b=h5zk4DTGQZpucQAN9Vjk6Kn1lom8+KKvLUScr9Tb15Lo5EvyTzL8Sy8kfsWKLDYUoPCbM+Kxhd/JfRucGN6whoOp1xlOngErG4ZgeGpmSU44I4K0JJau+817ee0sbz+XxzTkiB1sI2TOs5ij6WQQNVA7HQ8AwtKh3kVj0UwbuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264255; c=relaxed/simple;
	bh=IFZr6MV4AR6r14kqmLG6qUlrfX6va9/24Y1lP+Gq/00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jd78v4iANlYYlH2Fbf/2h2tQlFygpPvavW/dkf4Cb8JDoJQdaQO2ujl9jBR0FeffO/ka4FFjSYoW+ttNlBqHCmJ+RLgSiO/0q51vbsS0ox42Qm7l7mSNFhypod8kUwsSAkvweMC5olOnoddRbxwht4d7zN3B8s7XPMZWO3wq9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kDNZt61U; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4421cbba106so33920991cf.2
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719264248; x=1719869048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JOTUT9twe9eD9jXfuDuG0OciOCniJECQvgGWn276Tc=;
        b=kDNZt61UVaPfgB+JV8yoAvwIn6c1tSD91QszRvvzy8GzFti2r9PfhumRND6D7SsDnP
         gnZecWiDFXsNbMikWj2S2WQY2eIhzNRRIHOEnBz7sHtaXJyDNAfFxivDticcmn4CzpG0
         IXYO8c0UqW6upmhfaxGkP04x1vyN9fZPeQIFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719264248; x=1719869048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JOTUT9twe9eD9jXfuDuG0OciOCniJECQvgGWn276Tc=;
        b=ANVxcTI1n+QFHkgc3mfGByDC8etmKcbVUQ/EPl0kM9RmHaCRMu/iNQdRZSX3gnC4hb
         nMhf8X1Ll5T+x3ZxmESFM5jEXnp4MyWiUlJWQRkCyplgK8zS4WQwXtyOjA4MJJmfUnfG
         zPDGjzaeWtk+yASQa/64UGo68f4tr6YsE2BQJR5jRQYSfr4lkJ3WZ3/RTyfJ6S1dVYtr
         Z/+rqvcb7acISM/5UfFIqTYs3nv/S0sxHyuaci6t2sio2Iw+33uN7JWwz3b0uqP8L+Gg
         Wuw0tjxTAO8Jw8J1ueb85Va27AWdj1ZOS/9krAGoR0HaFFxeh1o3XX/Eoz6AGaTtKKbp
         wcuw==
X-Forwarded-Encrypted: i=1; AJvYcCUZVlsGTtFDCNZJh2Ok2xtLIHv8FZLPuN2TVdP6+uOrBCVPU4WGSAj1eE8mbdkhalZP4D2sOzlG2Zmqq3L/7+sUTTMGTwQq
X-Gm-Message-State: AOJu0YxcOuQtd74e/w3UoR5zlggC6zHL6uogchsT8lNkWSmMYNccr6HP
	roxydzW3WhE5p7JROHPjhDy+qsjg3HYpkrCDkAwS0ljJE57fBUJqxhq7Gl2bKgkxZ8YeEfPuSBU
	=
X-Google-Smtp-Source: AGHT+IG2h3S6WsvEQjM0tjNjk4nUyIV4UsPRModU58dO/1Kto3cPvJHtt49y/oOcsXKZtf1MtRGUuw==
X-Received: by 2002:a05:622a:1a86:b0:441:569a:9c67 with SMTP id d75a77b69052e-444d939e813mr62366691cf.56.1719264247772;
        Mon, 24 Jun 2024 14:24:07 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444f3eb260fsm42361cf.85.2024.06.24.14.24.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:24:07 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-443580f290dso30551cf.1
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 14:24:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZU5J5Og7gPhKqXChf8p/sMlj76SOeIChxQJ7CielOgB++VauJ1CrfGfQBZ+8pDksooTGiqjaQmHM7XHD1X3uP6vNtrCu9
X-Received: by 2002:ac8:7fc6:0:b0:444:b755:2aa1 with SMTP id
 d75a77b69052e-444f368e55amr295621cf.17.1719264244099; Mon, 24 Jun 2024
 14:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org> <20240624133135.7445-3-johan+linaro@kernel.org>
In-Reply-To: <20240624133135.7445-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 14:23:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
Message-ID: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
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

On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The stop_tx() callback is used to implement software flow control and
> must not discard data as the Qualcomm GENI driver is currently doing
> when there is an active TX command.
>
> Cancelling an active command can also leave data in the hardware FIFO,
> which prevents the watermark interrupt from being enabled when TX is
> later restarted. This results in a soft lockup and is easily triggered
> by stopping TX using software flow control in a serial console but this
> can also happen after suspend.
>
> Fix this by only stopping any active command, and effectively clearing
> the hardware fifo, when shutting down the port. Make sure to temporarily
> raise the watermark level so that the interrupt fires when TX is
> restarted.

Nice! I did quite a few experiments, but it sounds like you found
something that I wasn't able to find. Specifically once I cancelled an
ongoing command I could never manage to get it started back up, but it
must have just been that data was still in the FIFO and thus the
watermark never fired again.

When I was experimenting, I also swore that there were cases where
geni would sometimes fully drop bytes when I tried to "cancel" a
command, but maybe I was mistaken. Everything I figured out was
essentially by running experiments and I could easily have had a bug
in my experiment.


> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 1d5d6045879a..72addeb9f461 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -651,13 +651,8 @@ static void qcom_geni_serial_start_tx_fifo(struct ua=
rt_port *uport)
>  {
>         u32 irq_en;
>
> -       if (qcom_geni_serial_main_active(uport) ||
> -           !qcom_geni_serial_tx_empty(uport))
> -               return;
> -
>         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en |=3D M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
> -
>         writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  }
> @@ -665,16 +660,28 @@ static void qcom_geni_serial_start_tx_fifo(struct u=
art_port *uport)
>  static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
>  {
>         u32 irq_en;
> -       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
>
>         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en &=3D ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
>         writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       /* Possible stop tx is called multiple times. */

If qcom_geni_serial_stop_tx_fifo() is supposed to be used for UART
flow control and you have a way to stop the transfer immediately
without losing data (by using geni_se_cancel_m_cmd), maybe we should
do that? If the other side wants us to stop transferring data and we
can stop it right away that would be ideal...


> +}
> +
> +static void qcom_geni_serial_clear_tx_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
>         if (!qcom_geni_serial_main_active(uport))
>                 return;
>
> +       /*
> +        * Increase watermark level so that TX can be restarted and wait =
for
> +        * sequencer to start to prevent lockups.
> +        */
> +       writel(port->tx_fifo_depth, uport->membase + SE_GENI_TX_WATERMARK=
_REG);
> +       qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> +                                       M_TX_FIFO_WATERMARK_EN, true);

Oh, maybe this "wait for sequencer to start to prevent lockups." is
the part that I was missing? Can you explain more about what's going
on here? Why does waiting for the watermark interrupt to fire prevent
lockups? I would have imagined that the watermark interrupt would be
part of the geni hardware and have nothing to do with the firmware
running on the other end, so I'm not sure why it firing somehow would
prevent a lockup. Was this just by trial and error?


> @@ -684,6 +691,8 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart=
_port *uport)
>                 writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLE=
AR);
>         }
>         writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +
> +       port->tx_remaining =3D 0;
>  }
>
>  static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, boo=
l drop)
> @@ -1069,11 +1078,10 @@ static void qcom_geni_serial_shutdown(struct uart=
_port *uport)
>  {
>         disable_irq(uport->irq);
>
> -       if (uart_console(uport))
> -               return;

Can you explain this part of the patch? I'm not saying it's wrong to
remove this special case since this driver seems to have lots of
needless special cases that are already handled by the core or by
other parts of the driver, but this change seems unrelated to the rest
of the patch. Could it be a separate patch?

