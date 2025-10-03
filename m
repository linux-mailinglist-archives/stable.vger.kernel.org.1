Return-Path: <stable+bounces-183235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2A4BB73FE
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B60D4EBA69
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093EF28136E;
	Fri,  3 Oct 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJc8dhdJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13241280337
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503340; cv=none; b=A8PfGHYR1Qhl+dAsI/QaU8gcoI02P/Gl6ovWCcjmioAZNI79hc55dxKutsdiSva+IUuz7P4IwsO7K70W9KBQ9+xRcntiQBzQE0nCKwBIm4RbfVq+P/2hsqWgJnAX4C7u+fZl9FxRMBOhBilWi9m14/48Rt25MJxWwUlM1b366Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503340; c=relaxed/simple;
	bh=XeP2a+lCUm+qyPuVbXkPct3hMgc3ag9OnnqHInKkKJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acXcllyDAQ6fJ3PqGQXqnOMUxgcMUOwM+9/pv0jAMB/Uz45gPLEP4TnMdzZ0W4plid7h6Xvda6BhKUsqTP7//D8mNrLrhCEDb2QkKfPVd9dZqxchn8NUYiDdaP/U/7uNG+re+tEQ6yboOlQr30W0XxJRalTYmsPwOH4zWVPgo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJc8dhdJ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4df0467b510so29567431cf.3
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759503338; x=1760108138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmtbPxqvbUMAwpaMikq93NqcsvnJIS2FgaxENlamB/w=;
        b=hJc8dhdJYEO3UiY1GqGlMFbKtayfcoOj258Wjt0w93k0tN9EPtdagVHODxlzEOmZue
         zgIbsGHTQECLIn9QUqqZRieGnR7ocjFRPf/yGdjlMba+uiVmvFWE3M84Zil0izHQverk
         ZSVqtRUZQj1JKI7noVgJFJvKFGhkNGvbWz4uCXV3vNCY7z+uekuegILUzCqrTbAbpnTt
         hnPDeTMl+0mMmkk9rsridflU+M3JPRMyw1CmMxOMPhQKaDXSgs4gunu8BjfjCgoLYb/O
         Fs8LdZYLXL8oTFo1m05PVLaiiiFUdlSWI2mVFY59RccrJZDaoAAbLpGB/o7uviZQe5Qd
         gwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503338; x=1760108138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmtbPxqvbUMAwpaMikq93NqcsvnJIS2FgaxENlamB/w=;
        b=kGKegjUIjxyR5riq3xIUGKk9YasmR87mKLQnK30yPl0QAvikFPqs49gB2K1NWooVLE
         URfOVN3J3ckcI0Fs3fIilzjWRGpSlbExVlikAuIGIvczAlzwjqviYKzpMvb24FzHdssg
         2YFX3MjTohCTOovdwGM5e9KVIjo/xdas6Vm7AtmxwHLu+nol+pEWZ8Q+hzQfz0t40sl6
         77RIXmC1vk8qzV4ceUhbCGl+7otgxzIC5Ryyq37NLaYjDrTx2td11rXDAi5IkvY9g9KQ
         CmFmguugvt30LPKJ8BoZejkNZNbB3CCyq79dUaHTBEzClsT/kX4aaO+qs1VpQsMPmBBH
         GUlA==
X-Forwarded-Encrypted: i=1; AJvYcCVL8t3CfXaBAL7RHXOcQbPlZayIh5ky+yu4pq//0swzStafMcu4KpynDU690v+MaBP5Tz8CzL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUagoqWORQH2cQ/W4dDKn9vVwYD+XizTnlc1qWtLwrjB+lqX3x
	5wJWWar9muqKSihiTGAgKbNkFxtFRydUb/SbJwz+lh3kcWZ3mkch8qdflnvc3bx7/8HNHVw0G53
	cFhcfr3m62DnGiZeFAsWvDdfisWykHpc=
X-Gm-Gg: ASbGncuQnZQO3ZcpobyK22bViNU0h9RlaJnoYfnVp/zE1riWFANQ4xCOubdALrR6XZb
	ZK1llezkbjaTCWrEE9iM7YHiFagR/5AN7M+mckuyPO/DYEMQpnTuXWr8kdE66nc1R1LnARHhtQA
	ft8eRfl+RE/GRKPh3pL0386pdF2slBeNs+PaoblsWFET5nxIG/hhposWOcRIB9h/dz8bq4lDLiV
	xINYqq2zDEd/+Te9rEnunCIBF+r+jglAT9T1Ddr85xrFEVZVCPywiNN7IhRdgMh
X-Google-Smtp-Source: AGHT+IEHvSFx6aJopaLDBwFD78bU4fYMz9BJ0/a1hly+2/OCzn4OzJ5AVyA758ZdUYVd33wzD/pBPUkH88IUn5weYpQ=
X-Received: by 2002:a05:622a:53cb:b0:4d9:c572:f9b6 with SMTP id
 d75a77b69052e-4e576b06d58mr45151801cf.55.1759503337482; Fri, 03 Oct 2025
 07:55:37 -0700 (PDT)
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
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
 <20251003133304.GA21023@pendragon.ideasonboard.com> <CABjd4YxbyUWghd1ya8UayFkAE-VWQSd5-J2QD0sV7WmS8AXkCg@mail.gmail.com>
In-Reply-To: <CABjd4YxbyUWghd1ya8UayFkAE-VWQSd5-J2QD0sV7WmS8AXkCg@mail.gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 3 Oct 2025 18:55:26 +0400
X-Gm-Features: AS18NWAkfyiM21fDkrQMRVecEChPCYc2oBEI6uCtjM6V0760dRy7eaYuH27unlo
Message-ID: <CABjd4YwtwUYFX4bX5vy=AFi=Dn1r6nxWtMvmeKBSjkvriNJtsQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Alexander Shiyan <eagle.alexander923@gmail.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	devicetree@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 6:13=E2=80=AFPM Alexey Charkov <alchark@gmail.com> w=
rote:
>
> Hi Laurent,
>
> On Fri, Oct 3, 2025 at 5:33=E2=80=AFPM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Fri, Jan 24, 2025 at 11:44:34PM +0400, Alexey Charkov wrote:
> > > On Fri, Jan 24, 2025 at 9:23=E2=80=AFPM Alexey Charkov <alchark@gmail=
.com> wrote:
> > > > On Fri, Jan 24, 2025 at 2:37=E2=80=AFPM Dragan Simic <dsimic@manjar=
o.org> wrote:
> > > > > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > > > > On Fri, Jan 24, 2025 at 2:06=E2=80=AFPM Dragan Simic <dsimic@ma=
njaro.org>
> > > > > > wrote:
> > > > > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > > > > >> > On Fri, Jan 24, 2025 at 9:26=E2=80=AFAM Alexander Shiyan
> > > > > >> > <eagle.alexander923@gmail.com> wrote:
> > > > > >> >>
> > > > > >> >> There is no pinctrl "gpio" and "otpout" (probably designed =
as
> > > > > >> >> "output")
> > > > > >> >> handling in the tsadc driver.
> > > > > >> >> Let's use proper binding "default" and "sleep".
> > > > > >> >
> > > > > >> > This looks reasonable, however I've tried it on my Radxa Roc=
k 5C and
> > > > > >> > the driver still doesn't claim GPIO0 RK_PA1 even with this c=
hange. As
> > > > > >> > a result, a simulated thermal runaway condition (I've change=
d the
> > > > > >> > tshut temperature to 65000 and tshut mode to 1) doesn't trig=
ger a PMIC
> > > > > >> > reset, even though a direct `gpioset 0 1=3D0` does.
> > > > > >> >
> > > > > >> > Are any additional changes needed to the driver itself?
> > > > > >>
> > > > > >> I've been digging through this patch the whole TSADC/OTP thing=
 in the
> > > > > >> last couple of hours, and AFAIK some parts of the upstream dri=
ver are
> > > > > >> still missing, in comparison with the downstream driver.
> > > > > >>
> > > > > >> I've got some small suggestions for the patch itself, but the =
issue
> > > > > >> you observed is obviously of higher priority, and I've singled=
 it out
> > > > > >> as well while digging through the code.
> > > > > >>
> > > > > >> Could you, please, try the patch below quickly, to see is it g=
oing to
> > > > > >> fix the issue you observed?  I've got some "IRL stuff" to take=
 care of
> > > > > >> today, so I can't test it myself, and it would be great to kno=
w is it
> > > > > >> the right path to the proper fix.
> > > > > >>
> > > > > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > > > > >> w/drivers/thermal/rockchip_thermal.c
> > > > > >> index f551df48eef9..62f0e14a8d98 100644
> > > > > >> --- i/drivers/thermal/rockchip_thermal.c
> > > > > >> +++ w/drivers/thermal/rockchip_thermal.c
> > > > > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struc=
t
> > > > > >> platform_device *pdev)
> > > > > >>          thermal->chip->initialize(thermal->grf, thermal->regs=
,
> > > > > >>                                    thermal->tshut_polarity);
> > > > > >>
> > > > > >> +       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
> > > > > >> +               pinctrl_select_default_state(dev);
> > > > > >> +       else
> > > > > >> +               pinctrl_select_sleep_state(dev);
> > > > > >
> > > > > > I believe no 'else' block is needed here, because if tshut_mode=
 is not
> > > > > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so =
there's
> > > > > > no reason for the driver to mess with its pinctrl state. I'd ra=
ther
> > > > > > put a mirroring block to put the pin back to its 'sleep' state =
in the
> > > > > > removal function for the TSHUT_MODE_GPIO case.
> > > > >
> > > > > You're right, but the "else block" is what the downstream driver =
does,
> > > >
> > > > Does it though? It only handles the TSHUT_MODE_GPIO case as far as =
I
> > > > can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
> > > >
> > > > [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d=
391c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
> > > >
> > > > > so I think it's better to simply stay on the safe side and follow=
 that
> > > > > logic in the upstream driver.  Is it really needed?  Perhaps not,=
 but
> > > > > it also shouldn't hurt.
> > > > >
> > > > > > Will try and revert.
> > > > >
> > > > > Awesome, thanks!
> > > > >
> > > > > > P.S. Just looked at the downstream driver, and it actually call=
s
> > > > > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpou=
t" was
> > > > > > not a typo in the first place. So maybe the right approach here=
 is not
> > > > > > to change the device tree but rather fix the "gpio" / "otpout" =
pinctrl
> > > > > > state handling in the driver.
> > > > >
> > > > > Indeed, "otpout" wasn't a typo, and I've already addressed that i=
n my
> > > > > comments to Alexander's patch.  Will send that response a bit lat=
er.
> > > > >
> > > > > I think it's actually better to accept the approach in Alexander'=
s
> > > > > patch, because the whole thing applies to other Rockchip SoCs as =
well,
> > > > > not just to the RK3588(S).
> > > >
> > > > Anyway, I've just tried it after including the changes below, and
> > > > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> > > > pinctrls under tsadc, the driver still doesn't seem to be triggerin=
g a
> > > > PMIC reset. Weird. Any thoughts welcome.
> > >
> > > I found the culprit. "otpout" (or "default" if we follow Alexander's
> > > suggested approach) pinctrl state should refer to the &tsadc_shut_org
> > > config instead of &tsadc_shut - then the PMIC reset works.
> >
> > I've recently brought up an RK3588S-based Orange Pi CM5 Base board, mad=
e
> > of a compute module (CM5, see [1]) and a carrier board (Base, see [2]).
> > The carrier board has a reset button which pulls the PMIC_RESET_L signa=
l
> > of the CM5 to GND (see page 3 of the schematics in [3]).
> >
> > With &tsadc_shut_org the reset button has absolutely no effect. With
> > &tsadc_shut it resets the board as expected.
>
> Interesting. The TSADC shouldn't affect the physical button operation
> at all, if it's really wired to the PMIC as the signal name implies.
> There isn't even any default pull value associated with the TSHUT pin
> config.

On a second thought, I've got another hypothesis. Your baseboard only
pulls the reset line through  a 100 Ohm resistor when the button is
pressed. So if the TSHUT pin is in its default push-pull mode and
stays high when no thermal runaway reset is requested, the reset
button won't pull the line fully to zero, as the TSHUT line pulls it
high at the same time.

If you switch it from &tsadc_shut_org to &tsadc_shut, then it stops
working properly as the thermal protection reset, and GPIO0_A1 remains
high-impendance, thus allowing the reset button to function even
though its pull is too weak.

So maybe change the pin configuration of &tsadc_shut_org in
rk3588-base-pinctrl.dtsi to open drain and retry?

Best regards,
Alexey

