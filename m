Return-Path: <stable+bounces-73106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FFB96C9C3
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF75E286D2B
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C1156F42;
	Wed,  4 Sep 2024 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RdHu6gXl"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517982863
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486676; cv=none; b=VU2ou87wcRUr843JrL/WvhANqOBFWxYSnv5siWnPQGMLph88fE3+e3fXzi0DP6grSBmwBIhYzasdgLQzEAlo6KGlHlQo+jAD+Pa7nFxRYsB6AUqlIFfBTwW6IpR0/JNgmgyA6YURglR488PSbQGDdzL3AGgbAgSQG7HzXzgWop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486676; c=relaxed/simple;
	bh=HVv+636NymRBVBT+daSXGh0y1/tqpXcJ5SYAnkYRAJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUGkwQj7YJuL8DoAw81vcTjJ1HSMMbu7sr0USjVXQ7mlhWQrjmxBTFSXvjC1QYnxHlga6xSzUn4VVzzsVfaBqKsBOmceDO/4zwdh2T0ogkFxGYVbl9IZiHm+bDP5JSWJivs6BzNR42A9OkMn33SrdDImrc+NNaHMvHyYS6CSAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RdHu6gXl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6da395fb97aso406267b3.0
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486672; x=1726091472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgfZmpFq3mNdiXjiUQCUbunCBLyKZQQZN/adM34E+5k=;
        b=RdHu6gXlFffpOSvHrAiUjDvXr+saffs7ATMi88dW2ZGknlK4R1QxfUlaozkA6f6qjw
         RxhFwmUxm+YbLm3w/k3QXzRxpvniSpYSsmqzfIATdVk9BxCZpGEkkz+0LUXoyBBWBDcm
         oMX0ORhcSo+0/6SHTPzp9PkrgHsGBwW/BsGMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486672; x=1726091472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgfZmpFq3mNdiXjiUQCUbunCBLyKZQQZN/adM34E+5k=;
        b=dH7cuHxXun4WHUhvIECegPTr0cJEquO/7DzocRZoIK0oBxH454LHWE+xDGz3T3YLTK
         MebWzN81qXr3uzrEmZlo1NXB22qaLD9fzdfH7femqJ1flK6C5q0u7Ee93+A/TVlBjlxn
         /orZFzHl+lXColS+26i39JNkr4Fb3WeywlCG4zY/BE7/YVYzgdiTby8ojSGCMaJl5UJ3
         uWq5h76N2xE2Z+qDqvFk0RsfPxypXCh1Kpmaf7Vozoq4GaLVaouZ/FjCDM5BKUoZs5Bj
         y1j+vHlx91X9AT5akorofuamKz3HFk/JPM5/7frY7EHGjcxs8X3oYru2eEA1U9m8EwJQ
         Xdpg==
X-Forwarded-Encrypted: i=1; AJvYcCV0mwxn2tAx43Y56T/rUgANyI5jbCMnh8VFz+wBRapkO28+U4Atq/Us27uE1RMFMXSYHqB36Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8ifchh0xcHJmFljKCwZ6ez2ZCaUtgURkVo2UEOl/X1DZ3ova
	+IC/7Jr+n8rjmhjwd/adxwJVpBjZ+sgPRu7FJyAeEN6jLPhZXnXY9uUVHEDwy65+oRP0d+N9B/4
	=
X-Google-Smtp-Source: AGHT+IHcnvH0/2vNXQCf4Ywz9Tem3X58mjjH2tRYaQLI5dXz1eBoTvzvwVekB84QG6rVMsjC2Smqpw==
X-Received: by 2002:a05:690c:6703:b0:6d3:b708:7b19 with SMTP id 00721157ae682-6d40e782513mr194818197b3.27.1725486672431;
        Wed, 04 Sep 2024 14:51:12 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d45bbe2083sm20361047b3.104.2024.09.04.14.51.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:11 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a9463037cso137945276.2
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 14:51:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMdwid9ceSwtnizO1ANyV7lITHkDVGqGJkGfHOTyvUFy5di6O6jVIL5H+JuuIIs4nUfQdyYYM=@vger.kernel.org
X-Received: by 2002:a05:6902:1b11:b0:e1d:13a3:87af with SMTP id
 3f1490d57ef6-e1d13a3892emr2954820276.29.1725486670922; Wed, 04 Sep 2024
 14:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-2-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:50:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WDx69BqK2MmhOMfKdEUtExo1wWFMY_n3edQhSF7RoWzg@mail.gmail.com>
Message-ID: <CAD=FV=WDx69BqK2MmhOMfKdEUtExo1wWFMY_n3edQhSF7RoWzg@mail.gmail.com>
Subject: Re: [PATCH 1/8] serial: qcom-geni: fix fifo polling timeout
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The qcom_geni_serial_poll_bit() can be used to wait for events like
> command completion and is supposed to wait for the time it takes to
> clear a full fifo before timing out.
>
> As noted by Doug, the current implementation does not account for start,
> stop and parity bits when determining the timeout. The helper also does
> not currently account for the shift register and the two-word
> intermediate transfer register.
>
> Instead of determining the fifo timeout on every call, store the timeout
> when updating it in set_termios() and wait for up to 19/16 the time it
> takes to clear the 16 word fifo to account for the shift and
> intermediate registers. Note that serial core has already added a 20 ms
> margin to the fifo timeout.
>
> Also note that the current uart_fifo_timeout() interface does
> unnecessary calculations on every call and also did not exists in
> earlier kernels so only store its result once. This also facilitates
> backports as earlier kernels can derive the timeout from uport->timeout,
> which has since been removed.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 69a632fefc41..e1926124339d 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -124,7 +124,7 @@ struct qcom_geni_serial_port {
>         dma_addr_t tx_dma_addr;
>         dma_addr_t rx_dma_addr;
>         bool setup;
> -       unsigned int baud;
> +       unsigned long fifo_timeout_us;
>         unsigned long clk_rate;
>         void *rx_buf;
>         u32 loopback;
> @@ -270,22 +270,21 @@ static bool qcom_geni_serial_poll_bit(struct uart_p=
ort *uport,
>  {
>         u32 reg;
>         struct qcom_geni_serial_port *port;
> -       unsigned int baud;
> -       unsigned int fifo_bits;
>         unsigned long timeout_us =3D 20000;
>         struct qcom_geni_private_data *private_data =3D uport->private_da=
ta;
>
>         if (private_data->drv) {
>                 port =3D to_dev_port(uport);
> -               baud =3D port->baud;
> -               if (!baud)
> -                       baud =3D 115200;
> -               fifo_bits =3D port->tx_fifo_depth * port->tx_fifo_width;
> +
>                 /*
> -                * Total polling iterations based on FIFO worth of bytes =
to be
> -                * sent at current baud. Add a little fluff to the wait.
> +                * Wait up to 19/16 the time it would take to clear a ful=
l
> +                * FIFO, which accounts for the three words in the shift =
and
> +                * intermediate registers.
> +                *
> +                * Note that fifo_timeout_us already has a 20 ms margin.
>                  */
> -               timeout_us =3D ((fifo_bits * USEC_PER_SEC) / baud) + 500;
> +               if (port->fifo_timeout_us)
> +                       timeout_us =3D 19 * port->fifo_timeout_us / 16;

It made me giggle a bit that part of the justification for caching
"fifo_timeout_us" was to avoid calculations each time through the
function. ...but then the code does the "19/16" math here instead of
just including it in the cache. ;-) ;-) ;-)

That being said, I'm not really a fan of the "19 / 16" anyway. The 16
value is calculated elsewhere in the code as:

port->tx_fifo_depth =3D geni_se_get_tx_fifo_depth(&port->se);
port->tx_fifo_width =3D geni_se_get_tx_fifo_width(&port->se);
port->rx_fifo_depth =3D geni_se_get_rx_fifo_depth(&port->se);
uport->fifosize =3D
  (port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;

...and here you're just hardcoding it to 16. Then there's also the
fact that the "19 / 16" will also multiply the 20 ms "slop" added by
uart_fifo_timeout() which doesn't seem ideal.

How about this: we just change "uport->fifosize" to account for the 3
extra words? So it can be:

((port->tx_fifo_depth + 3) * port->tx_fifo_width) / BITS_PER_BYTE;

...then the cache will be correct and everything will work out. What
do you think?

-Doug

