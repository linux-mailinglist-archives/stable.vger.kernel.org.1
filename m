Return-Path: <stable+bounces-124143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1781A5DB97
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F176177995
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E218D620;
	Wed, 12 Mar 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUXOkLmN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D94125B9
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779081; cv=none; b=XV4esVeUk5A0i+/38OQYXJAj5eJQaTNyZlhLFnwk+VYR+V+txf0abrMbNsq3GRUgIObvQVgjbYe5gtk6tS0V3aIhjZvGpXyj38Bbb6l9TFI3/Eqf3mBAY6QOxh+RVmVArPTJ4928NbM/3I/rhbpcF29EEsuLnsPM0BIcTA8fvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779081; c=relaxed/simple;
	bh=LamZ1dekJFD1CplIqMFq82A+Hivmj1FNR9Ba1K2yv3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vqbo/p5D8yCZmj9XSFXDgdyUPHm7So4XaOBGpWWrL4RRN4PuVqm2dsR/TVlGfm/uggt3Jbez3PbyBc/6Fik26tTeZMqaK9gAiffDM3j8dIhO0stXtol0hT5MrLSA58+MqVSj7bBrNbky3qEsjo6KK8vnVgEkLbFIt+rSvAaDgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUXOkLmN; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72b0626c785so2833158a34.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 04:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741779078; x=1742383878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UdPvnPkDYszULhre/XOAdt2THz5zT2TlDbP/t1A4yE=;
        b=bUXOkLmN9a33mGpf9s4rT1BooLhOYIPBOVmm6ayBsCc0+1CAqb+WjfNank8ls8vxMb
         WaFR5mI8j+j8hvhAlCrUt9qBwj8rIXWzd9yEOLErhbwHgJAQTJ0qZvLOwWtnFdO/WgZ5
         gt5PGqyE557M3IXeC3q/H9M4ATmk3ee5PMbMeZPBSQJ7wsIFLRtQjkN6X5SXcEY12wq7
         +X5C9RXZama5wC8l8XpriL5Eshd/BvLONvohndp54syjOn/mykX+nCPBHgag44g3xdE2
         45JWE3zGYbDWURwuKt//aam8PcCTiRaLFp05Ksht27kN4XF0d71BxWF92mtex7zS8+Ki
         TC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779078; x=1742383878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UdPvnPkDYszULhre/XOAdt2THz5zT2TlDbP/t1A4yE=;
        b=PF8AwmitBQZp0O1nfMHzYwj5x9sELo2ypq7XN9bU0mX1lWVM1CqPuT1p0E4IoMQHS6
         BVaXDx11+9SEshOwP+qWfv85KEnzHvOBGMFErcoMUM31ViiJOhyRF5TqBV4hzoTQWRKO
         L+TrjsLto4t08yV34qknA1Ast+LaRQRZVqCxEpLWSSQ4hGpRSEILEEgPcdjWIxxVtnyM
         7CqwzwLmOIoAcsGiDczWsUNX//wQx3VQNgw27umWBfyX2i0CrqnbVW9RFx3ZCgUg9cuH
         c/YbTeacb8eJMRhDo08waGfOJI6G2WmMphAoNdPTb3GC8XQ9RDjLNYDE/qFwVxErEbZJ
         7WVg==
X-Forwarded-Encrypted: i=1; AJvYcCVL8pPF1fTS2p4n1vgQLFHImFEvvUVBchK7gIkhCrYMWzzkgABs12wsiJTZwpUUT1nbvYU4Q9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZ3zNza0IS1SQQPQ1hijyzAl1ZQeXqEMiN+kWQRdgNRP6fMO9
	Kir8VsEwZtHGJbR/AIV5VNqM6ECMsQ1WtUaK3It2LVx0mHSM0mT753qRkrXJ4AtOyADzfXTs77L
	dedBgvTTwKpcZkW6I19ypugMmgLGZOB/g9wz4tQ==
X-Gm-Gg: ASbGncuUf1DxpYByrKEy+tYylpRhZT8F8SyXqwtf1rXgaJKpxvCZqnfSLedULaOulJc
	swqC5gKEHrMe/vV38KzbyhG4TFx+h9UDkNoZ3ZAUGnNl6HJ0+flr5PlxDbOui4iNSOcyMiYIz2j
	rsYdspdw8qJjPne3sT8c59y+P3qeB2
X-Google-Smtp-Source: AGHT+IHpN3V115z284qmxaOdgGA4PwV3v/6Lpfa9pDfmxTKlcBbQ43+xR982OzrJIgzm+w3NL49THbQiezCdr3Q3kYQ=
X-Received: by 2002:a05:6830:91f:b0:727:2f79:ce33 with SMTP id
 46e09a7af769-72a37c6a7damr12652067a34.28.1741779078312; Wed, 12 Mar 2025
 04:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org>
 <20250307-pinctrl-fltcon-suspend-v4-3-2d775e486036@linaro.org> <59a1a6eb-d719-49bd-a4b5-bfb9c2817f08@kernel.org>
In-Reply-To: <59a1a6eb-d719-49bd-a4b5-bfb9c2817f08@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Mar 2025 11:31:07 +0000
X-Gm-Features: AQ5f1Jq8qDRuo8RWVbqyC-4s6dvJ3zqh5v94onY3xAq0EKJNYhbmQXeDH_scC5U
Message-ID: <CADrjBPqYoHckqr43y1z8UtthZ9DOG15TJWSv_707Jbyf1yforw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] pinctrl: samsung: add gs101 specific eint
 suspend/resume callbacks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, jaewon02.kim@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for the review feedback.

On Tue, 11 Mar 2025 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 07/03/2025 11:29, Peter Griffin wrote:
> > gs101 differs to other SoCs in that fltcon1 register doesn't
> > always exist. Additionally the offset of fltcon0 is not fixed
> > and needs to use the newly added eint_fltcon_offset variable.
> >
> > Fixes: 4a8be01a1a7a ("pinctrl: samsung: Add gs101 SoC pinctrl configura=
tion")
> > Cc: stable@vger.kernel.org
>
> It looks this depends on previous commit, right?

Yes that's right, it depends on the refactoring in the previous patch.
To fix the bug (which is an Serror on suspend for gs101), we need the
dedicated gs101 callback so it can have the knowledge that fltcon1
doesn't always exist and it's varying offset.

> That's really not
> optimal, although I understand that if you re-order patches this code
> would be soon changed, just like you changed other suspend/resume
> callbacks in patch #2?

Originally it was just one patch, but the previous review feedback was
to split the refactor into a dedicated patch, and then add gs101
specific parts separately. The refactoring was done primarily so we
can fix this bug without affecting the other platforms, so I don't
re-ordering the patches will help.

Thanks,

Peter
>
>
> > Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> > Changes since v2:
> > * make it clear exynos_set_wakeup(bank) is conditional on bank type (An=
dre)
> > * align style where the '+' is placed (Andre)
> > * remove unnecessary braces (Andre)
> > ---
>
> ...
>
> > +void gs101_pinctrl_suspend(struct samsung_pin_bank *bank)
> > +{
> > +     struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> > +     const void __iomem *regs =3D bank->eint_base;
> > +
> > +     if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > +             save->eint_con =3D readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > +                                    + bank->eint_offset);
> > +
> > +             save->eint_fltcon0 =3D readl(regs + EXYNOS_GPIO_EFLTCON_O=
FFSET
> > +                                        + bank->eint_fltcon_offset);
> > +
> > +             /* fltcon1 register only exists for pins 4-7 */
> > +             if (bank->nr_pins > 4)
> > +                     save->eint_fltcon1 =3D readl(regs +
> > +                                             EXYNOS_GPIO_EFLTCON_OFFSE=
T
> > +                                             + bank->eint_fltcon_offse=
t + 4);
> > +
> > +             save->eint_mask =3D readl(regs + bank->irq_chip->eint_mas=
k
> > +                                     + bank->eint_offset);
> > +
> > +             pr_debug("%s: save     con %#010x\n",
> > +                      bank->name, save->eint_con);
> > +             pr_debug("%s: save fltcon0 %#010x\n",
> > +                      bank->name, save->eint_fltcon0);
> > +             if (bank->nr_pins > 4)
> > +                     pr_debug("%s: save fltcon1 %#010x\n",
> > +                              bank->name, save->eint_fltcon1);
> > +             pr_debug("%s: save    mask %#010x\n",
> > +                      bank->name, save->eint_mask);
> > +     } else if (bank->eint_type =3D=3D EINT_TYPE_WKUP)
> > +             exynos_set_wakeup(bank);
>
> Missing {}. Run checkpatch --strict.
>
>
> Best regards,
> Krzysztof

