Return-Path: <stable+bounces-80683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D798F7E8
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3190F282A88
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE431AD418;
	Thu,  3 Oct 2024 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H6eWEv5p"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3117BA3
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986271; cv=none; b=NkldPL16kdNWKHVwabtSg++RphI4qh1jY5WtB4jUD9euGvJqRfzbjtqiLiEgPnfhsijIXpmF3CLg8qesfHbLxSHlUUCUiOlVV5f/O2h3BDslYaW1gGaUEBV9tnZa0IbJVuuktkfZK+xSmk4jmoQcsYXI9uHwnNM0Uk44/VsFLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986271; c=relaxed/simple;
	bh=mFfQYJY4Gj/y2j2eWGpy+miI5FqUx4eMg4Hz/3GPObU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8f1stnymuKqACGJ5scN9xOR2SXlxytKv4VNQd8Zfvcz4K1MlwBdy6rvZ90IiDE9kLDflL4g6kJHMnDEHjJiOmRwsz2ypsNueFnzgaQXp7p1OpC3ip7oxfHc59u6tsvKB1+/VRiPRQJfWAHJpXzZI0BHcc5bVMhGPwg/Yeyh9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H6eWEv5p; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac5eb10ceso13758901fa.1
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727986266; x=1728591066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ4SQGwcH2xs9+ZoWZiOyyo2Nn/MvzkFL6Ok3JvG8Eg=;
        b=H6eWEv5pMzlVC/12cV5ri1ylRpij7rKubQ2nHiuzYeBo2qVBG6RyK9wXEgEI4sGl5g
         jrRQZrBPSNwV9AoGFNB/4WpF96IwAYXvqQ321Nlog4pZleV58E+4sTRKjuwoF/MTvOG2
         rjuziZUpcuhOKyXzGcKexvhgLKV9CbkVxOZQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986266; x=1728591066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJ4SQGwcH2xs9+ZoWZiOyyo2Nn/MvzkFL6Ok3JvG8Eg=;
        b=OUdh39Y7AhXRSuu2uQhOVXtmY2SMMwucmccMrQivXEGneZYtmX4SSeBoZj3d3LJ2yX
         mNkgDAANBtRyf82t11KLkuECJ9ncKABwD2753/nnMKb1TLdloa9UIbd1jf2QSyY2tjV6
         tYC7dSuVCtnPp2e7vJIj5W5zkjb187oKI07pZxWzI51QzkufEdSbdQ0RUXEjTkB4wLLN
         Bo/eUYQ+LyFiNjXgUjmng+GRHkLrrr04H4pQptCud6lpiSQjpzoql4AJTVIcJ0CVEBxs
         EiC54/iiXvCHpm74jBiuGUGbxkj3uWvPBKOZwLYpkKDoMmCo70WPIQWiaZ5y6thszIt5
         8Hgw==
X-Forwarded-Encrypted: i=1; AJvYcCVzqk/z9PKkpZKEHYfQyUglrcCfckd4Q7KSPnpQCJwuGf1ygSR/JfkJsywj5WVOgxK5i4Fi0TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/F7pHTCL1XlfCGtQdh4df+4rJyKOHoABvl+gpogEuctiFMvz
	UpOvt9T+Xf9bfOwqix1w+rPSKowX1P+eYh4ZxHe/x1rtWmuTyCGwYN4VTSznE2hKUARcD0nZZNA
	Zhw==
X-Google-Smtp-Source: AGHT+IEHNkgDCBV4EUY26pkrPnnxIoaXBvuHpZlqojC1/yvwrPlONdE5iQp4jGBuOeFr+EBlysNIoA==
X-Received: by 2002:a2e:9a11:0:b0:2f7:6664:f272 with SMTP id 38308e7fff4ca-2faea1db6f5mr15506871fa.6.1727986265900;
        Thu, 03 Oct 2024 13:11:05 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecbf6875sm2943781fa.20.2024.10.03.13.11.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:11:04 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fac5eb10ceso13758491fa.1
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 13:11:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDZt5P3Zn6Ts5jQFFOP6JKvrc9nk/F+HthG212m3lxhlakHBo8wgT9Ga42i76lVKfEoFcTTVA=@vger.kernel.org
X-Received: by 2002:a2e:b894:0:b0:2fa:cc50:e6c1 with SMTP id
 38308e7fff4ca-2faea26773bmr14843331fa.22.1727986264213; Thu, 03 Oct 2024
 13:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-5-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-5-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 13:10:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vwmb8Miyca4kE1sdjMCx7LVCYqaXhLmPPqsojUHdEk-g@mail.gmail.com>
Message-ID: <CAD=FV=Vwmb8Miyca4kE1sdjMCx7LVCYqaXhLmPPqsojUHdEk-g@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] serial: qcom-geni: fix receiver enable
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The receiver should be enabled in the startup() callback and there is no
> need to stop it on every termios update.
>
> Since commit 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during
> console writes") the calls to manipulate the secondary interrupts, which
> were done without holding the port lock, can lead to the receiver being
> left disabled when set_termios() races with the console code (e.g. when
> init opens the tty during boot).
>
> The calls to stop and start rx in set_termios() can similarly race with
> DMA completion and, for example, cause the DMA buffer to be unmapped
> twice or the mapping to be leaked.
>
> Fixes: 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during consol=
e writes")
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for seri=
al engine DMA")
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index dea688db0d7c..5b6c5388efee 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1179,6 +1179,11 @@ static int qcom_geni_serial_startup(struct uart_po=
rt *uport)
>                 if (ret)
>                         return ret;
>         }
> +
> +       uart_port_lock_irq(uport);
> +       qcom_geni_serial_start_rx(uport);
> +       uart_port_unlock_irq(uport);

I _think_ you don't need the locking here. The documentation for the
"startup" callback say:

 * Interrupts: globally disabled.

Other than that, this looks reasonable to me. I seem to recall
previous discussions where _someone_ was relying on the
qcom_geni_serial_start_rx() at the end of termios for some reason
(which always felt like a bad design), but I can't find those old
discussions. I suspect that the fact that you've added the start_rx in
startup() is what we needed.

