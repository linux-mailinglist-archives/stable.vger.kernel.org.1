Return-Path: <stable+bounces-112198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFABA27839
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A191649A3
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0067921577F;
	Tue,  4 Feb 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4AlSJeR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7B175A5
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689793; cv=none; b=JZv2yAmH1+cXiKihRBtXOCJhuJuAb3HGzHHBUQgw9m7mOV769vizybhossofv3I28GL/+p0DgL4vRm2Evgl9mD57iXzzuvEmAGMSu7jg+8f7U77YmU8iu494KWSmOqOdRl9QenjgtyNSqxPpQerDReohKevW3+VgvoYpFB47HxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689793; c=relaxed/simple;
	bh=+Mc8NydDU1OM/dB7ToFbrdv1mQz3p3QgEZwtAF6rsQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT71Lw7XzNxnu+MeV/TiayTYfuUdBCSx201MYfUOZhOsZyHtnG9wE0Fveu8oJj3ZUbsH+lo3Mi0RWuGebEDlvDQq/Xjli2knMcc2nSWzWONthQ0CEImaSkgAAw/w26xvBvaNClhbOOdbF/MXEAGN1K6poQk1la705W5QjQFUMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k4AlSJeR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-543e49a10f5so6040390e87.1
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738689789; x=1739294589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5BBuYTzTxCxHlA89cur3oiUM9mGTbCPIm1uiSGbWU0=;
        b=k4AlSJeR2dphoTGgUNpeB1fA5uvgIAnc4y9wHikTtOEnP2htCv/3NHN2OLfILBNcJX
         kgCwcDdDmOchaWEGmoQ+mAlN9s/jc4oyitMBR2ml/n1hyjGwR12/fzkQusLZEY4UprTO
         s1+PBIDDJ3HirQzoiIs6URRvvletUQuPpDywQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738689789; x=1739294589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5BBuYTzTxCxHlA89cur3oiUM9mGTbCPIm1uiSGbWU0=;
        b=hH7k8Pa0LiqEL9Rsl5yZpwPMEWv66rzhTjlHn5LJhmKID0xO48NMHzwYQGAB67RZ4j
         D/9HnIP1/aZK+e/OdficLg0i7Tnezpnk3kJW+FFJ4Q/oUGKOCth/J5kMmNNtHvQjlyjA
         qvtDqF2bn3JBQgirnOWZdijE0YSC/90uR6oFlJeSarP0GYpbyCrJ0Xea7cHKH15GD3wm
         izBY9YFaaDzYXwzNzWHSzqAQRx59xptTc5IhqO6tmyzl+LOmdKdh8hJCL86QSgpKyP1w
         4DFjIytRZ3VYKWiBaSjgAy4Jhyv9WvRxgwtpf00+O4lrCnrjKiR6jH55Fz0oH96p4vNy
         CYhw==
X-Forwarded-Encrypted: i=1; AJvYcCWS5h0NteP0kC8AsX/H8zbjv0Q5DyVEeM+rdzJyAzbCWQGg3kQmy3dI7w0gBY8cx5XmCbDpWKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6UphqQ2v+GdrR9Q1iUoID3KPiEizT07TutlHzbGHtkt6vB2le
	6NaABiW8N0O1gagohREwGmNQCmi4Bc054rVw0urrWXbMqqeHmNARR8VSg/mWirGPdewD9nA6uQa
	nKw==
X-Gm-Gg: ASbGncuj1aKL0fs41LOpEDD8THrKmnJpND4wCj91nrQ0rShF5NksIJTATmWJP6kKKMW
	PH/jbsP+9GcfBkSKqgWplwuwU/yBBrQsFSTyx/O4BwBZo/ZO5Y7PtY2RrJuOtHdTeZtB2ECMjf7
	G0QdPMG9Wd3S3YoVV+PRs61Hmo48G8UrJOD8q7TD6yKziDAKzjshv1ggT4P6eGo3gT4E2/Zb5zo
	Lsrq4hESPPS6wFyN1ZIqZEgzFnunTGunjR6uRygNXdR9lNQgGOUXz10/mbx5pCe65eDT9Lwx+7M
	YHYSYsAPwDVmiCbzBTCYzXmBgZ8BZkHflFWpydwH/g1bCyK4/bmEpo8=
X-Google-Smtp-Source: AGHT+IHK/BjqSX4IaE89jy1G7FLrLeyHvbZWckLooencjp4vNfuZQ9I4WJq9uNhlmXxp+S4JX/4k9Q==
X-Received: by 2002:a05:6512:b8f:b0:542:2e04:edb4 with SMTP id 2adb3069b0e04-543e4be9c42mr7398907e87.13.1738689788810;
        Tue, 04 Feb 2025 09:23:08 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb073dsm1632790e87.153.2025.02.04.09.23.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 09:23:07 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54024ecc33dso6009130e87.0
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 09:23:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtwRzUuf76kw0ZJ58mIQoe4GQye7ufHMPMwlY7V0sPNOCmJUPjHrKraCz0B7pHlTDF6UdgNzY=@vger.kernel.org
X-Received: by 2002:ac2:5211:0:b0:53e:3a22:7a2e with SMTP id
 2adb3069b0e04-543e4c3fcf9mr7317073e87.47.1738689787581; Tue, 04 Feb 2025
 09:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org>
In-Reply-To: <20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 4 Feb 2025 09:22:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XDUmo=OEFtoOt6vkpCVQ628QK2xX8+PBnqJVvj0y7pug@mail.gmail.com>
X-Gm-Features: AWEUYZnrPiry48nd_-swhnr9bFmRqR2dsreF7sUVpPQTg7S8Rc3CqXimX23DP7c
Message-ID: <CAD=FV=XDUmo=OEFtoOt6vkpCVQ628QK2xX8+PBnqJVvj0y7pug@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix deferred probing error
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 29, 2025 at 4:40=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
> have not yet been probed. This return code should be propagated to the
> caller of uvc_probe() to ensure that probing is retried when the required
> GPIOs become available.
>
> Currently, this error code is incorrectly converted to -ENODEV,
> causing some internal cameras to be ignored.
>
> This commit fixes this issue by propagating the -EPROBE_DEFER error.
>
> Cc: stable@vger.kernel.org
> Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index a10d4f4d9f95..73a7f23b616c 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2253,9 +2253,10 @@ static int uvc_probe(struct usb_interface *intf,
>         }
>
>         /* Parse the associated GPIOs. */
> -       if (uvc_gpio_parse(dev) < 0) {
> +       ret =3D uvc_gpio_parse(dev);
> +       if (ret < 0) {
>                 uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
> -               goto error;
> +               goto error_retcode;

FWIW, since you're specifically considering the -EPROBE_DEFER case,
it's probably worthwhile to make sure that dev_err_probe() is called.
That eventually calls device_set_deferred_probe_reason() which can be
helpful for tracking down problems.

It looks like uvc_gpio_parse() already calls this if gpiod_to_irq()
returns an error code probably you also want to make sure that
dev_err_probe() also gets called in the case where
devm_gpiod_get_optional() returns -EPROBE_DEFER. In that case,
potentially one could also get rid of the uvc_dbg() above.

In any case, IMO even without those changes your patch is still worth
landing. ...and maybe my suggestion should be in a separate follow-on
patch anyway. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

