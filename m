Return-Path: <stable+bounces-110375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFFA1B371
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 11:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88C3188BF3E
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218721A456;
	Fri, 24 Jan 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK6VcNC5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D921A438;
	Fri, 24 Jan 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714340; cv=none; b=LXJvVFdPt6KE7y1NDD+xFKcl8Palk6vJFxfhYk0QuatOf/lSWJL5F03Wa0t6LFOQNzWKG8lEtPwPNQNs9s3NqbhKsBlFXT3lEM7QdSKvQIQZlFCQBDNSIEVU7sc0Qi4uT7+ABfYKyGGHz06G1kJN1VZaprLVI+K+4LTHi9Gz3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714340; c=relaxed/simple;
	bh=Pn1VHnC8upceAvBXekXvza/HH2xUUC9O+30xJBhaWrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECOGwBB4hNuxggTsoz2bLfql+OxRikYmdwVYRVFqBDPHuHPYlVRH2Vme96YdvHmDIcRFfto1JcTZ3njXPJwA6Jy0Xe7phNYaveGkuPwkEIf/67LDtyy1lSXBNJhTck0WopRx1RfbLIvjcC4bkvlRAc4mhya1VrRIM+zAUonb1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK6VcNC5; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4679fc9b5f1so17044591cf.1;
        Fri, 24 Jan 2025 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737714337; x=1738319137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVSfEDxnvDA5rGvCvnbh0Gb+paH+zzrZtcmrNCp+8Yc=;
        b=ZK6VcNC5KJyfnSMrek/DCf5MWRnpb6KLyE7pWlp5bBrvns1ZHBtBbl7vC6wxmPGF+T
         PV7cVxfwFm1HZEX7qwVbF+Oxg7fZYY6qlN9++0mERZOM/QnVqTyb7agDN/s0gBRHcpdW
         MdS4sz3BCdV9jSwFuzyh47/2HI5U+eDqv0t5qNH161a2cfwonN5T8ZkOClcY4uCym3Wa
         QTfOGMLrpgWlhu4J+TtRvd+nP7JW5PReAlTK2NsjfxzvgW4RbEI8bcRFzwdj7vO1dBOg
         rH5d0+zB2LlBW6Y4SHWY/8Z3srONA1g0rWYcfpX6e0FqE29zPz4+fwLbzCy1DnRgtSYB
         AVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737714337; x=1738319137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVSfEDxnvDA5rGvCvnbh0Gb+paH+zzrZtcmrNCp+8Yc=;
        b=XGkjaVLNbS7OFgfIw64X2saAvmHfAzDD0m/eTq6lB8+uT8Uz97/3qooQ/XC9AD9gOc
         mZdi6VRdTIBDz4M+Ad7lqX0XsM/4xybbdSm5t03OuJuxGQhD2sIk2SLqpXR8QXD1LCcs
         PWZ/LpHv5DVxkVuRaCAac6+G7McfB2Sxra9qsBjo6G5GN63BYg0nIYT2O8FrIke3eirZ
         62r8zg+yLtdw1ZouuN5Lv2WCjtKJeeRJsZo2zr6Tffi+GeZIJm2hDVb++XH9AGWPd6Ww
         /Ge7kpvFxF+ts7fKUy2ffqbviBqjx1HX08cPF165tDc4GgrIcsAFCvfzSkjb/X++EgQz
         0TKw==
X-Forwarded-Encrypted: i=1; AJvYcCU3+LVoGjbAwKqRs4GGV2FMRig/fTafoTcmpjAmHp5EG1YJbnfUEmSxhTalez1YZhy5LkLIbUB2@vger.kernel.org, AJvYcCW+UtySwyho6W9jxSf2oTXLgxO5DixM4ubZjJIwOGbUDz6WBep/HEUau4JGnK62BqU6tRenWjAg7iDgJqvi@vger.kernel.org, AJvYcCWTMMeGhJEKAIGAH5jyk40ie6m7dQj02XuiaOhN3raDcMSKdXC/UuVAX75c0J9f2iFmF2EpLsBQ/o0S@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZmFr6apqnYF2Jhvhdwpl3xVKDPHjY9d7mt7UuaFvWH02JUCi
	oxB+cWbrEWjToeF/MvKevblqvUpLXc9zpedRvAYO7AI3mLCcykuxEmoIKUKq8HBvZgi8SurueXb
	cJCc+Q7o7H/m+iXvZbs3ytb08E/ovupGnVGTBduBW
X-Gm-Gg: ASbGncvHB8gDfo57mW3ZajCqEO2rTDnX6KZD+yTjDPRU74s7/z0hiTOo+vu5lOQY3AM
	goP4rzI/2fVu48Tn4siyKizjqLu5ojh+0T8KUGlZefdK/i5chWV9d6L0/Za+Kfdqe8LaiEmNC8i
	aK/0JNWODHwRe58+XjQfQ=
X-Google-Smtp-Source: AGHT+IG19zMkzxnogxqTUpCFFCWHU7lU6d2GX59oTfrT4bEh/Qp/+jBldUiAWHgLhmBH9A6JXxMmUJ7olZ5BQkuj30g=
X-Received: by 2002:a05:622a:d4:b0:467:8703:a737 with SMTP id
 d75a77b69052e-46e12a9a34bmr447365691cf.29.1737714337203; Fri, 24 Jan 2025
 02:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com> <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
In-Reply-To: <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 24 Jan 2025 14:25:27 +0400
X-Gm-Features: AWEUYZkJo1DrsP2L7lNkxItCPiQqRHHFgNLzNRHQsNokpADbfabjg0z5a8nFqdE
Message-ID: <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:06=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Alexey,
>
> On 2025-01-24 09:33, Alexey Charkov wrote:
> > On Fri, Jan 24, 2025 at 9:26=E2=80=AFAM Alexander Shiyan
> > <eagle.alexander923@gmail.com> wrote:
> >>
> >> There is no pinctrl "gpio" and "otpout" (probably designed as
> >> "output")
> >> handling in the tsadc driver.
> >> Let's use proper binding "default" and "sleep".
> >
> > This looks reasonable, however I've tried it on my Radxa Rock 5C and
> > the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
> > a result, a simulated thermal runaway condition (I've changed the
> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
> > reset, even though a direct `gpioset 0 1=3D0` does.
> >
> > Are any additional changes needed to the driver itself?
>
> I've been digging through this patch the whole TSADC/OTP thing in the
> last couple of hours, and AFAIK some parts of the upstream driver are
> still missing, in comparison with the downstream driver.
>
> I've got some small suggestions for the patch itself, but the issue
> you observed is obviously of higher priority, and I've singled it out
> as well while digging through the code.
>
> Could you, please, try the patch below quickly, to see is it going to
> fix the issue you observed?  I've got some "IRL stuff" to take care of
> today, so I can't test it myself, and it would be great to know is it
> the right path to the proper fix.
>
> diff --git i/drivers/thermal/rockchip_thermal.c
> w/drivers/thermal/rockchip_thermal.c
> index f551df48eef9..62f0e14a8d98 100644
> --- i/drivers/thermal/rockchip_thermal.c
> +++ w/drivers/thermal/rockchip_thermal.c
> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
> platform_device *pdev)
>          thermal->chip->initialize(thermal->grf, thermal->regs,
>                                    thermal->tshut_polarity);
>
> +       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
> +               pinctrl_select_default_state(dev);
> +       else
> +               pinctrl_select_sleep_state(dev);

I believe no 'else' block is needed here, because if tshut_mode is not
TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there's
no reason for the driver to mess with its pinctrl state. I'd rather
put a mirroring block to put the pin back to its 'sleep' state in the
removal function for the TSHUT_MODE_GPIO case.

Will try and revert.

P.S. Just looked at the downstream driver, and it actually calls
TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
not a typo in the first place. So maybe the right approach here is not
to change the device tree but rather fix the "gpio" / "otpout" pinctrl
state handling in the driver.

Best,
Alexey

