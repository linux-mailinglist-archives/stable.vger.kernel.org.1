Return-Path: <stable+bounces-146049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C249CAC06E7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 10:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C64F18938B1
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B22620CE;
	Thu, 22 May 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgx9RXJZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E117A2E1
	for <stable@vger.kernel.org>; Thu, 22 May 2025 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902109; cv=none; b=MtCLrtDepgmprctQgpZsjPhNd0zHG5+o482NTRKEDp/oXarsUGpiig5Nip+jODDlXiUxRmzoNw/osiw1tZp660u3DnG9HVJi++5l0Fj+bKYfm+k7ZsS4qpeRh/0O5nDJzciNz9obfRyT/I3XFMD7ZjkYsJX47OThPkZL23BbDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902109; c=relaxed/simple;
	bh=VqOCPkWUr9CZnMaCodKIveASZIVnzNQmiel7M9LF6tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keOBDo8Ckq0BDtIiTs2pjQ1LiPXLYg0N5o+sBinqV43AgwdMCqpLSXT5AeUg7BDtbDgJ59hKuwg1Zo5vns9WpZyr3GjEl0JrwPzbig9CcPzNbbMtjfpp0lQMiJYUwdBCpv0wEQN7+w2AVQuG6fLwgJ54ZG3CAtOxla3nq30aeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgx9RXJZ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32934448e8bso19787051fa.3
        for <stable@vger.kernel.org>; Thu, 22 May 2025 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747902106; x=1748506906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW+uhUhcGi/qFjEIYz1RUaPA9UVbNHNQ6EqB73r6lsU=;
        b=zgx9RXJZI1d3FlZ2KYrhi/F0k5D3jJLrkx2ICqEflj4T6/IriMv5lo3UKLjRDQdUZt
         fM9n1oUyZUeAlClkx0qGJDU9JdYnBWyd+U9NF1zeW4ypFCuKFPEMfB3gLEkQj0rlgdpB
         rNPAhW/iLL1hduej8xykxfyBEG/X80YAA5WHLjjIjcgyV4mngZax+je2sK3z56PwBtND
         Y3P50F4vRswVfHx9DzfXpDwvxPb2rKogfl2EKHubuY6mx9fKLZ8lagFh4qg0cH5TZP2D
         LSePS8P/mYtPvnL0nYJWUI5BB8ezE2Uh8F+3LABuDcwB5nWsMiQS4WtynPjtScv/wHgg
         cPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747902106; x=1748506906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW+uhUhcGi/qFjEIYz1RUaPA9UVbNHNQ6EqB73r6lsU=;
        b=PdkWCwX4D13yuO6QpeooLu+LgRN8bnS7ah8NbKrVjjEu4IQmhRDG96IIk476FbGFtF
         33nSbAAusi07KPnirK22X0ZKDWRH5yHo+eWI0KNNt+slHu9ZegQyO4jKWUl8PdDpvdpY
         3wyAnViTGemb3WriCqzdlyHb5RAhe5BDdNxBXTW09FYYI/TdTgNsiW51w5nbnpGgDiaP
         Nn1oL2TY3QI5pRYTVtRdZuvf29HaKVD5jx2vAlYj607VWhGHRzeKO9+6PzBn879pxMom
         SNg8VDJCHG+e1YpuR8/eSIBJrZ6YOXitxO34nD9rZp4jVQoJDY9eVilOyI1Vv9O6wk8T
         VWJw==
X-Forwarded-Encrypted: i=1; AJvYcCXI7PSeNd3zKVjWSJYLH8A7lz+0i7Mt408Fk91bjLhzy+YyONSXyESyP6Y+uZDymR8LBoAxgq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpaqBPKWjzQWOUWHFRV6UyjFhX3uSwJiK1p/7t+A/SAe2b1cLe
	mXT5O7TaD58niWukZXZv1ya0HoT9U3HS3qjJdeDxSRE1ixRViU3G9vZl17i5dXQcpaqo+DVdQpU
	iYSvryeSpb3vKZJHK9GGEqm94+Lj0gGB/AbNBauoNGajJ9RVmAGxeAxU=
X-Gm-Gg: ASbGnctNCCVdNjCIxNw7L5KrTjcO0H7ntuFEoh+pPyvH+NIEPxL0SssYeak0dWAPoFB
	+hyhy8zy9IrBRsGao+4aEhj0F/ZFj9kWggnlvdUMb8QsXfX7thmiLeWnF4UrT/5AIP273BjK3Jl
	uFlzfMt3aEiztloZfLDh1hClEZBCeTCAj6
X-Google-Smtp-Source: AGHT+IFuVWqRIf+xf4DijNOl0IDx8Qgv/jtCzf68FUzLuSbdLNyij11XpLfpriSkG3Sjekzh/okS+B8fvY52d+Rfu1M=
X-Received: by 2002:a05:651c:2214:b0:30c:518e:452 with SMTP id
 38308e7fff4ca-3280771e0c9mr84948681fa.13.1747902105732; Thu, 22 May 2025
 01:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <8d249485-61f6-4081-82e0-63ae280c98c1@heusel.eu> <3352738d-9c0e-4c23-aa9a-61e1d3d67a50@hotmail.com>
 <AM7P189MB10092C41B59EF58CBCB290A2E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <60a9ea8a-edb1-4426-ae0e-385f46888b3b@heusel.eu> <AM7P189MB1009A8754E90E4DE198DAC32E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <AM7P189MB100943AF796568B45AB7099AE399A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <AM7P189MB100943AF796568B45AB7099AE399A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 May 2025 10:21:34 +0200
X-Gm-Features: AX0GCFts_N2nJIo0yBksSJy-pd69zxVe0kQhRD0A3krKVPkQ2gCk7ftDFl_F9N8
Message-ID: <CACRpkdaG5NNbfPhBMgCRUXqy_j5f=KaT75r9iQMg1HAyrAipoQ@mail.gmail.com>
Subject: Re: Panic with a lis2dw12 accelerometer
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: Christian Heusel <christian@heusel.eu>, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 9:15=E2=80=AFAM Maud Spierings
<maud_spierings@hotmail.com> wrote:

> I have found a fix but I don't know if it is correct to do. This deals
> with the deferred probe correctly, no longer panics and registers the
> device properly. This is the patch I have come up with:
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c
> b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 1b4287991d00a..494206f8de5b0 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -231,7 +231,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev=
)
>                                               ARRAY_SIZE(regulator_names)=
,
>                                               regulator_names);
>          if (err)
> -               return dev_err_probe(&indio_dev->dev, err,
> +               return dev_err_probe(parent, err,
>                                       "unable to enable supplies\n");
>
>          return 0;

It's the right fix.

If you look in drivers/iio/accel/st_accel_i2c.c clearly the driver enables
the power before calling st_accel_common_probe() which is where
devm_iio_device_register() is finally called and the IIO struct
device get initialized.

And that's not all: st_sensors_init_sensor is also called before the
iio device is present, so this:

        } else
                dev_info(&indio_dev->dev, "Full-scale not possible\n");

and this:

                dev_info(&indio_dev->dev,
                         "set interrupt line to open drain mode on pin %d\n=
",
                         sdata->drdy_int_pin);

is also unacceptable.

I hope there are not more...

They also need to use indio_dev->dev.parent, or a local copy of
that struct device *, so please fix them too in the same patch.

I tried to chase down a Fixes: candidate but this misunderstanding
goes way back and such prints were introduced several times.

I would just tag on
Cc: stable@vger.kernel.org
and be done with it.

Thanks for drilling into this!

Yours,
Linus Walleij

