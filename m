Return-Path: <stable+bounces-196880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B3DC84807
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9223A6748
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FEA30F80D;
	Tue, 25 Nov 2025 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uYNvcXXD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA32F39B1
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066734; cv=none; b=TcnYdbb2k/X8/vYdPasVrY+p26imez1UqrcJ2dwfs4JK5bmA7QkR+wfHMfnsFhPIedb4nNji2i+YuHS1ftG/KzC5tgOkeORZRdrooGjEbtwggQoDPYUfcx+MWsmmrZ2BcaQlMxA2X0JQbonKw5JkpsCIFECJw+q3U9VFro8jdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066734; c=relaxed/simple;
	bh=CHVSZit9SUMun8fGEW0adw9nKXYVZ+SL6ZnGxBteZVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnNGotYR2Cn6Uiv5pi8X0G8Hq44WGeKtSxJbKkKn1g2rUkNB8hdl7ZwpkQIZ7QzWwhjcCs2a8Pdv5/IlOo9K/DQYWGdmGe3TQgdDasTcepuXq/Ruo8Fw81f+rgG9ZTteglAbM9r2aBU1KBfisN3OaG1iSydG6Sb1Q5mNF914LFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uYNvcXXD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so14496031fa.0
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764066729; x=1764671529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zehYaNAnUSl426pZXagIpMUwtpRwJK7xk4vMutwtYD8=;
        b=uYNvcXXD7MvDFG6p5+nLzfLou1iXcMGeXsDZX4BmGi8dAIKPNpKY8zvh2KjCrDhKi2
         DjeLDeaSEa0Np5rSL8YANg+zAeNlMqh7oG6D4yuKIiuAQDU32L4kKZn5OQhCGhTCbrf2
         DMIf7eSCCvqPp0UYvznuhquXQH7E2/WBTpaYNBNMk+gNiDATepwo9k4CRsayikWZmxfB
         BJLrNLf/5r7rLtzMgaW+UhoUaLuM6j1d2VbhQ7GjXiSve8I+1A2HYzJifLUJDNDOjXa3
         qwSbjogOvm0sfFW7jKkMeYW5i6Kj9mULZRE3ANoYQn5xiPCCSQfX0Bzt0t0ftUmXQDIO
         2U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066729; x=1764671529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zehYaNAnUSl426pZXagIpMUwtpRwJK7xk4vMutwtYD8=;
        b=EkoPl9+LXMfAIfuegtzwFYRsnhVU72xegcaOKHclgvodmbpEVa2xua03WMkYcncBI+
         zq77m9KPl0zWt5gRoiqjhE6I0tGgmDBByFeS+IfUS7sBu5TcSIb3gJ1X71Y/WqPrCtfW
         LVgU5Cq24CPNEqRImXZ8HjRs5/RbbNEX9uPyqypwfwPnYL+YZAo+mJsdz5Q3g7tL9ebL
         +gfsEc3SjN1tD3NVUfxjlxF4K/wF0LSgeiMkdbKLKzPROh0P6gHj/xQE3OzM3ryHvM+U
         W3JTu5ZRqr2/8o1MW3g9Va6Jp3iLVPqqNIN+unMvoQ1I/cntCm3ECamFqoKokXivMMOR
         AsQw==
X-Gm-Message-State: AOJu0Yxq71vRFMyUmzgZ9BnvB5UXf3gECXWetskc16UnYiTkF3hMEVzN
	uEcIipK6MnGpEFlw0caPitZ74WFiZIbdXqolTUO4Vbsoj/EO1lqBPh0hjGnTYVuieAowFsc0Y94
	vhfCCPbrWyEBxncNhuSlCV/DvY6fEz79Sg0bm1JsiFQ==
X-Gm-Gg: ASbGnctCymTDvsBResGflnjsI+szct4F3273S0J4oM0LUuDhPumggDuOKm9VVChvzfW
	V+JHW/i4i9Rbl5KQDx2amJI5Q2JOqD23o9G4lgLjn1xisDCvzXKKxwimDLqtZ97ikd/sjCUYOQa
	G61PkhabbIvN74hbzFoIRj53zBViQgHV/nNqe+Dk6NMBuWXA80ZbU5eq13e6SsncSJjp2hKpbau
	/asDqiqm+oKh5u5DN+vKCq4yHkPZEgVLuv6CBcoAvnN+dt+4qwDkpDFs6HRG9JIWQtAAZFOUlpg
	o2gykdkh+s0sT5WcWEgTAGkAfPo=
X-Google-Smtp-Source: AGHT+IHxwwtlOP+Szny8/rr8JsPkVBhPh1CctPN/t2JWJcU0swSHGXRPjQqKrbk+Rb5Tlz5LWvca7f/QA7qfs72lwt8=
X-Received: by 2002:a2e:9094:0:b0:37b:9a34:176b with SMTP id
 38308e7fff4ca-37cd9243776mr33410721fa.30.1764066728892; Tue, 25 Nov 2025
 02:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Nov 2025 11:31:56 +0100
X-Gm-Features: AWmQ_bkMwJ2DpdbKJktFl-k3-FNaee5-nmxwuFacAbGbSGDtOYgEL02a8wt8B64
Message-ID: <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: stable@vger.kernel.org, linus.walleij@linaro.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 11:29=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.
>
> This software node change doesn't actually fix any current issues
> with the kernel, it is an improvement to the lookup process rather
> than fixing a live bug. It also causes a couple of regressions with
> shipping laptops, which relied on the label based lookup.
>
> There is a fix for the regressions in mainline, the first 5 patches
> of [1]. However, those patches are fairly substantial changes and
> given the patch causing the regression doesn't actually fix a bug
> it seems better to just revert it in stable.
>
> CC: stable@vger.kernel.org # 6.12, 6.17
> Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7=
-0-a100493a0f4b@linaro.org/ [1]
> Closes: https://github.com/thesofproject/linux/issues/5599
> Closes: https://github.com/thesofproject/linux/issues/5603
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> I wasn't exactly sure of the proceedure for reverting a patch that was
> cherry-picked to stable, so apologies if I have made any mistakes here
> but happy to update if necessary.
>

Yes, I'd like to stress the fact that this MUST NOT be reverted in
mainline, only in v6.12 and v6.17 stable branches.

Thanks,
Bartosz

> Thanks,
> Charles
>
>  drivers/gpio/gpiolib-swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.=
c
> index e3806db1c0e07..f21dbc28cf2c8 100644
> --- a/drivers/gpio/gpiolib-swnode.c
> +++ b/drivers/gpio/gpiolib-swnode.c
> @@ -41,7 +41,7 @@ static struct gpio_device *swnode_get_gpio_device(struc=
t fwnode_handle *fwnode)
>             !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
>                 return ERR_PTR(-ENOENT);
>
> -       gdev =3D gpio_device_find_by_fwnode(fwnode);
> +       gdev =3D gpio_device_find_by_label(gdev_node->name);
>         return gdev ?: ERR_PTR(-EPROBE_DEFER);
>  }
>
> --
> 2.47.3
>

