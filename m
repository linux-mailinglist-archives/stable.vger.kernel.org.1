Return-Path: <stable+bounces-71690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EBE9670C1
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 12:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76492844B3
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D517B401;
	Sat, 31 Aug 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ui2YKOmr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF338170A3E
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099372; cv=none; b=AreRgjiYhewuJATqIMnqXATW4JldO6JJMvjwn9zIrINMy/mfpYl0ROooEZL1+9ynLk7kd/o4/sh5TDitna89xQlCQbhg1PmD8x8xRjErRTV0XImGILIupkWGGgF8rDU2+UcliqeTkqpw9I5v7Wl1PHRuU6QwqdBiwBJA3xV4+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099372; c=relaxed/simple;
	bh=7PxAHyswZLjCEcDDdIaCvCLTaRGZ61BCN7GeRk75FeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sijg+AwLM2Lj0roVnnWEnexZtV9LvXKxjqA+vUfPU/kvg+l+ICG6BmYSiKEveSLEl3HNtBe8V/vAENW18awVf8HQebBEi9KYiUB7d9tDNN4qLWZBWSeK4xHFmHhgJ79tAVGkkaUByZnue+rkrGbXPDKkB4l8wHz581gCpNRVFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Ui2YKOmr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a868d7f92feso304506266b.2
        for <stable@vger.kernel.org>; Sat, 31 Aug 2024 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1725099369; x=1725704169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEegHeLswHgSFD60AbReMGvZ27oxPCuhcc/xuWI/93U=;
        b=Ui2YKOmr9YcN04xEWu9Hwe/UBoUgyWojeatfuyY7cCvlqZ6vEmPGwNCICEhoj7zUzG
         K03yF2CIY7km/595vkJxbVtHvtuVDQyINjh9Jy790JylSlNvS0h/Hl+RVdLjaaD2B15D
         ynhFYKURiHUksMONCAkUH3QZxf7y5bUrbh6Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725099369; x=1725704169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEegHeLswHgSFD60AbReMGvZ27oxPCuhcc/xuWI/93U=;
        b=rjBsfiapRxen5/GpOCTGt6d0HWfSPnHjS8NAp2TCUEAp0hI7FqGMJ/Pm1/CRULA5M0
         2HBsIp5EqxkH5Gjsl9BR11wlwGQ6q51x7CNmBYp/EWp0pi5eZ6u0cVbb3PmMBnI0/IUP
         FNpTgp2mx0Jmt8dl/tRX0bzlrqEKrtB+OWIcTWsFkufYD0Rq+gZUpchjQew2iASsG5/L
         Sf371Hl/dG1EK7BhboCB+7gtzqCbY801Q3+RayBNCMJqIwPrlCD6XNFqVqEqUTvqP1ux
         6JKofBQUlNxkF47pmf3/nJJUXTxe8C54AS6hSvNi7hXvHxmhrWLNTuSpkeQnV5NZN7PN
         CqtA==
X-Forwarded-Encrypted: i=1; AJvYcCWaYCnxa3w8OWmmlD7LO1KfGZAl7A0OBwSmmV5ofixollS1MmnVQ8c+Ypmj+sSon42KILQa6MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yISBrgPKWT3/uBAyidhGKkGXaKmIdG4o5t5cYtxhk5SkF66W
	HgDW6bIHfjOTJTzFmZSHQfGXLMMAaRcJyUnSga1UAmnPH3N/C7VwHorAHzUgJzNJFaTlzFPE1gV
	w6VxtlV6IVeBIGTNGWBIIiUR7cq39P7ZENCQrDQ==
X-Google-Smtp-Source: AGHT+IEljKe8Ivg1opymQ8s5TmiI5igE90nWvac0fE5HAogxs6IEzVOg+qUSFUw6dqnweZ0GuJo22CElxQCvmh+Yss4=
X-Received: by 2002:a17:906:d542:b0:a86:af10:6a47 with SMTP id
 a640c23a62f3a-a897fad60e1mr629129166b.60.1725099368529; Sat, 31 Aug 2024
 03:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 31 Aug 2024 12:15:56 +0200
Message-ID: <CAOf5uwk+40-qQdVYcqkEOKUdmn1UZcL2BCG_Pdd_8rphc94JWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul-geam: fix fsl,pins property in
 tscgrp pinctrl
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Parthiban Nallathambi <parthiban@linumiz.com>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI

On Sat, Aug 31, 2024 at 12:11=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The property is "fsl,pins", not "fsl,pin".  Wrong property means the pin
> configuration was not applied.  Fixes dtbs_check warnings:
>
>   imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pins' is a required prop=
erty
>   imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pin' does not match any =
of the regexes: 'pinctrl-[0-9]+'
>
> Cc: <stable@vger.kernel.org>
> Fixes: a58e4e608bc8 ("ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL =
initial support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dt=
s/nxp/imx/imx6ul-geam.dts
> index cdbb8c435cd6..601d89b904cd 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
> @@ -365,7 +365,7 @@ MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
>         };
>
>         pinctrl_tsc: tscgrp {
> -               fsl,pin =3D <
> +               fsl,pins =3D <
>                         MX6UL_PAD_GPIO1_IO01__GPIO1_IO01        0xb0
>                         MX6UL_PAD_GPIO1_IO02__GPIO1_IO02        0xb0
>                         MX6UL_PAD_GPIO1_IO03__GPIO1_IO03        0xb0
> --
> 2.43.0
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Thank you
Michael

