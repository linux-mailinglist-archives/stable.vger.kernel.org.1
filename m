Return-Path: <stable+bounces-110411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBDCA1BCF2
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182BB161C56
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944D2236F1;
	Fri, 24 Jan 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG7Qqohy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A31BEF9E;
	Fri, 24 Jan 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737747888; cv=none; b=jMFg50DvBfCgo7pMC6YBmVejfjSPXsAvi8dMNFxcBkmQrFKPw5du1/SvMf+vk73KW0c4ar8nkNyjr0oQT7bsC/WV5Mvsnw3WnSdUt38i8IMRdJWnI6XNhKEPHjiVTJc+p1rK7nta8lh7KIzymCxHcr7GBNUvtvTJxdBHWiFOC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737747888; c=relaxed/simple;
	bh=LSs/JB9ZFnTscL+SI1y++GjqRBAyIDDV5bevHheiAEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peXPFBbuwshj/3YLGMpWt2VuPhPUr2aimqmnwQhU2WfGCv6djk9CSSUdmUMpGCtkZDv6KCv7U5D8bZbPyugEzDAr3jsQtYWhQrhQui0bZHW8RhmUKt9Q3maQVApDXBX9Pia5+M2IENPD/ACzQ5l7F+qbt8dOspALSDwDYZL/P/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG7Qqohy; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd420f82e2so30780006d6.1;
        Fri, 24 Jan 2025 11:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737747885; x=1738352685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOD2UfYHJSjZl/pt9FbtcUXEWsxQSEJ9vHhIuaxcBT8=;
        b=gG7Qqohy3TkwTAq2YDpQtTOm30kJvzHY2p9HHTLwSJtsDs5O4RNhAk7jxxIDVonxQw
         Gh6EaQERaKU5KOkcPPEVwf74ASC9B7GY1mJZ1zK83EYkaBpMb7gRqUdcq1oZF/reRik/
         n/vYOEg+fKvxssX1HqUhBh558yVR55Q+P3PHY5+lsJUIjCBbhaNb5Gkcgb9pyegpUhdG
         5ZRFeNmlYUOidgE4PRt0eGehVb23EQjKqlHRX+PZNqsd3fRKHEBfVbYbpo8DchxogoDx
         UIudXh/3I8bfE/GEiFAmS7MbrXekkYgkhDtns3yeF7ZrXYWUzN1zTgM/011RsovRNiis
         qDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737747885; x=1738352685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOD2UfYHJSjZl/pt9FbtcUXEWsxQSEJ9vHhIuaxcBT8=;
        b=sUkHjayCzA7zhBykhIc4sOXnFN5ac8Zadk6RiFyg/6XienyKFi6UDtgG+zbAXFoXfg
         XHtjgx3ntJMAj5ZYcwpLsXsKbvgesVTN2jCQ3Bc1QlAMl5srYaR3v6bEUzlR+ocXF9Ko
         ATGRfcaFzJupXB1Vy5otqDGSS5KO2bOST3CnaUJDydJ7qRs83RQeQfnPtAZmU52Cl/kD
         RCMuGrv6ukC9Z5/T1pCYmwmOq0ZwRkaCUc6ns4dkAzanCB9thUN91CPfIE/wCVvBK1Td
         QsVHL2P+mZhqEDOs9FIA3zQqFblKeTZbh3netxDkV6+S/ANiRpAfq6Og0EgZ4x2s6J1R
         rgFg==
X-Forwarded-Encrypted: i=1; AJvYcCVh12KDFFc6R6jjdLRKUeOCgMuPcjAe8XRXbopm1Z7kcgY1pbMpd/s+pwRWgKfWe2GB2h+Jd6K5sIVA@vger.kernel.org, AJvYcCVl+9f+2zUNCgHaJM1hoelE/SoElnVsMltQjmhigGzk8hkwEpANHJqZxAiKIyAzLCX3Pkm2z0zEQ6czAZNV@vger.kernel.org, AJvYcCXh1P/jbBfe0MOtlW1B/PILx6SHQX6SYv+Pd9ECGdGsbdnJGlbT3fmbEtkPu9Bp4143JvqNaou0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhi6vMMmR0n7nnkG6D6jtpdc9R7coTVse3sLrJC4cdubxWYsd5
	0tjOlFr3gDSABMJXpfhHZuzIqrAZOhsrj7TzanFSjRgkN/lLU3o+z1COKPSlO0rsUXtN3hjD/OT
	5j/IS1U4Yo88XMPysZFwNF8/geXo=
X-Gm-Gg: ASbGnctx5LlP25cXF/zA0SyOOg0mA3HpsvptiPscUbAFdHae4NUFQMa3Fu43z3ckEwl
	rA0ZDsh8UJHZHwyxnigPZI6R+zcIKzdZ723LCwa3eseOdVwdtrhKilEkJQEGaW2c5J+OP+KxvHQ
	==
X-Google-Smtp-Source: AGHT+IEwdcGyIv8lm858FpPS9WNGZiSmay44cu0Hl9ikO4VKi94V+TJkWI5vKNLFcYt7f/0KTwOHH8wB/TpJhS5EnOk=
X-Received: by 2002:a05:6214:3b81:b0:6dd:13b0:1008 with SMTP id
 6a1803df08f44-6e1b220a25emr426812666d6.30.1737747885315; Fri, 24 Jan 2025
 11:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org> <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org> <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
In-Reply-To: <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 24 Jan 2025 23:44:34 +0400
X-Gm-Features: AWEUYZm_EiKPNGxbgHDs4gZQ4CmxiOcxC-PdiZ0tcOXrYDeOTA-NItxJz0l0e0g
Message-ID: <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
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

On Fri, Jan 24, 2025 at 9:23=E2=80=AFPM Alexey Charkov <alchark@gmail.com> =
wrote:
>
> On Fri, Jan 24, 2025 at 2:37=E2=80=AFPM Dragan Simic <dsimic@manjaro.org>=
 wrote:
> >
> > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > On Fri, Jan 24, 2025 at 2:06=E2=80=AFPM Dragan Simic <dsimic@manjaro.=
org>
> > > wrote:
> > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > >> > On Fri, Jan 24, 2025 at 9:26=E2=80=AFAM Alexander Shiyan
> > >> > <eagle.alexander923@gmail.com> wrote:
> > >> >>
> > >> >> There is no pinctrl "gpio" and "otpout" (probably designed as
> > >> >> "output")
> > >> >> handling in the tsadc driver.
> > >> >> Let's use proper binding "default" and "sleep".
> > >> >
> > >> > This looks reasonable, however I've tried it on my Radxa Rock 5C a=
nd
> > >> > the driver still doesn't claim GPIO0 RK_PA1 even with this change.=
 As
> > >> > a result, a simulated thermal runaway condition (I've changed the
> > >> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a =
PMIC
> > >> > reset, even though a direct `gpioset 0 1=3D0` does.
> > >> >
> > >> > Are any additional changes needed to the driver itself?
> > >>
> > >> I've been digging through this patch the whole TSADC/OTP thing in th=
e
> > >> last couple of hours, and AFAIK some parts of the upstream driver ar=
e
> > >> still missing, in comparison with the downstream driver.
> > >>
> > >> I've got some small suggestions for the patch itself, but the issue
> > >> you observed is obviously of higher priority, and I've singled it ou=
t
> > >> as well while digging through the code.
> > >>
> > >> Could you, please, try the patch below quickly, to see is it going t=
o
> > >> fix the issue you observed?  I've got some "IRL stuff" to take care =
of
> > >> today, so I can't test it myself, and it would be great to know is i=
t
> > >> the right path to the proper fix.
> > >>
> > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > >> w/drivers/thermal/rockchip_thermal.c
> > >> index f551df48eef9..62f0e14a8d98 100644
> > >> --- i/drivers/thermal/rockchip_thermal.c
> > >> +++ w/drivers/thermal/rockchip_thermal.c
> > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
> > >> platform_device *pdev)
> > >>          thermal->chip->initialize(thermal->grf, thermal->regs,
> > >>                                    thermal->tshut_polarity);
> > >>
> > >> +       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
> > >> +               pinctrl_select_default_state(dev);
> > >> +       else
> > >> +               pinctrl_select_sleep_state(dev);
> > >
> > > I believe no 'else' block is needed here, because if tshut_mode is no=
t
> > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there'=
s
> > > no reason for the driver to mess with its pinctrl state. I'd rather
> > > put a mirroring block to put the pin back to its 'sleep' state in the
> > > removal function for the TSHUT_MODE_GPIO case.
> >
> > You're right, but the "else block" is what the downstream driver does,
>
> Does it though? It only handles the TSHUT_MODE_GPIO case as far as I
> can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
>
> [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d391c57=
4735fca1/drivers/thermal/rockchip_thermal.c#L2564
>
> > so I think it's better to simply stay on the safe side and follow that
> > logic in the upstream driver.  Is it really needed?  Perhaps not, but
> > it also shouldn't hurt.
> >
> > > Will try and revert.
> >
> > Awesome, thanks!
> >
> > > P.S. Just looked at the downstream driver, and it actually calls
> > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
> > > not a typo in the first place. So maybe the right approach here is no=
t
> > > to change the device tree but rather fix the "gpio" / "otpout" pinctr=
l
> > > state handling in the driver.
> >
> > Indeed, "otpout" wasn't a typo, and I've already addressed that in my
> > comments to Alexander's patch.  Will send that response a bit later.
> >
> > I think it's actually better to accept the approach in Alexander's
> > patch, because the whole thing applies to other Rockchip SoCs as well,
> > not just to the RK3588(S).
>
> Anyway, I've just tried it after including the changes below, and
> while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> pinctrls under tsadc, the driver still doesn't seem to be triggering a
> PMIC reset. Weird. Any thoughts welcome.

I found the culprit. "otpout" (or "default" if we follow Alexander's
suggested approach) pinctrl state should refer to the &tsadc_shut_org
config instead of &tsadc_shut - then the PMIC reset works.

Best,
Alexey

