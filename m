Return-Path: <stable+bounces-183393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 147D8BB95A7
	for <lists+stable@lfdr.de>; Sun, 05 Oct 2025 12:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 396B34E3279
	for <lists+stable@lfdr.de>; Sun,  5 Oct 2025 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E24218821;
	Sun,  5 Oct 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH2BspGu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828678F3E
	for <stable@vger.kernel.org>; Sun,  5 Oct 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759661722; cv=none; b=O+VLTXQpqyWkUMlx3e6DIJwcgVhqymxOf2nCYQTGu/L8nye7EqKmW0UyDbS/5TIyGXipOzkvBobvrGGgiFXXvOug25XJBHUvIUPTy8f3ohyF2Y0wUzC3jjucWk5H55yiOBO1meelpE9B954NBTXM3ryeg7Hf2JPRnjOd992L0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759661722; c=relaxed/simple;
	bh=hv0t13XpMCzGMfLrYnuxn0PEco6xD5F90AQBZpOQ2GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUWzcFeA8Mg0SauI3Fzo66dnOiBbhAWkkhk3JLGSIiNKjmYPO5jXk3iXVUmDv1OS5nDvKFQ25nvLMVyX8+n74PX2XRzsYMkeysXDt1SlRFAaRyrC63p1zhPY/DCokTku46YJ6FbiuKIGIjlgj02bX6CWfuxw1H+MVXj+nKMLqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH2BspGu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85a4ceb4c3dso379221485a.3
        for <stable@vger.kernel.org>; Sun, 05 Oct 2025 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759661719; x=1760266519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzLT2VU9AZrprVMKaIriIjeuBSSmoOGolyPhiSrywBQ=;
        b=MH2BspGu5mh4G0qGdA8iIABEEVQl/qEK04KgDFgtRYqOPRGEDLqSVDK29QUjRG+FYO
         RIbOMJ890LqqERR4kCXm9/Xwj+t+97b9oW4mkmfTSOnQY9RFb8/i3PVbPkKpdOQGOy3A
         MAGEV6LFKld5ciksZhYH1/jyuxCWi+hCRo5Wa3bOzHkRx2pLvb8wA5Yy9CK9hWsMMx94
         gS4P2M/nk8BrDFyYO3Pk62KpGVxyMb0KW31Kq9BYfl2VOaWYVzRAbB3c8we+osL3vSiP
         3pWtp8fePeuTeWcLTDnIsBiDLMz638GoYkMKKPpB9ISrhkg/FCIx6NPoF3bbgh+W7QxO
         StvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759661719; x=1760266519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzLT2VU9AZrprVMKaIriIjeuBSSmoOGolyPhiSrywBQ=;
        b=s1WfB4TkkSPTlsPekJ5kgZc49DliPopvKv3PITRxcXtcotzi3kogH2t1bdqUlgV73T
         xzRmtgLrQ2+RXY4YaBZCGH9JYUB+t++tR3iOJ3Pc4mJxtHu7VLwdmpE+UwP3PkHt9n+t
         qDKpcUIu8GeQ5mkmvddFqrBLGsU0dA26ZbBqYtsD3wLm52M8ypMrbIMTUmIpkrF8cqbu
         x5zR/4fbdlYHP2d/FKo2gjgCEA+FIKOXSSZeLf+rty2aVN6qAOYrPOl0dWM3Kf3aCXnP
         h2GbkxqVAy8/w26pty9ddOyGkO8lxmS9NMgIL5G3VpEsGV+I522MEJRpPfzF/0FTk5Nx
         ARWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwfkqdRlKpsrIvRdlzJ77afwU36b66uo7ea+jP79Wu3iMqwqvGldQuXX7mBUpGSXMkmRP0Mtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3clUnw4mqp6VRH32En0jxsjw+mzFbkrFU7nzEgy03htGkmDjI
	xBmHcqlVOT6sBGBXEL1uQSLmgIeBwu8kAIfouga5HVqFjWz0XApM9n1KRabq/ptNehUnS233yoX
	qd4VgiJmHWrq2oG2Ao0szCcVdXWmlXr8=
X-Gm-Gg: ASbGncsKgahFW2KpMIg8gm5myAPn02mOnEUxD45iqVzL5tpeIMSayY+eqjIUTMPAmJ/
	KPGbKEC54ERj/VTar/IRg2ppxWlt34ofCbO8U2K9yk2IoTLYW2h9zjlk4sFAwSOwGPh7H584mBc
	FKj1143gQZ7/+EZTUf/P9A1mFACEyP3+8lXD9yJxHkf5zUVFxM7gyhG1dr5OllDnm7ylEuNyOgu
	O7WQZhxPWWJkXzuIv1L8xVz8GIN6YO1fosbPoLpsqtWCvDtdPq6Tvs=
X-Google-Smtp-Source: AGHT+IFCrj2Udm0U0cWFhFJiQLU1ddUKbzdouHN8/JOmQqz2+KfbPT/k9liTJOs+57MzVtTZ8JhEfUehhe7xAfv7PN8=
X-Received: by 2002:a05:620a:29c8:b0:85e:5fef:8710 with SMTP id
 af79cd13be357-87a377dd5e1mr1187717885a.47.1759661718455; Sun, 05 Oct 2025
 03:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a76f315f023a3f8f5435e0681119b4eb@manjaro.org> <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org> <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
 <20251003133304.GA21023@pendragon.ideasonboard.com> <CABjd4YxbyUWghd1ya8UayFkAE-VWQSd5-J2QD0sV7WmS8AXkCg@mail.gmail.com>
 <CABjd4YwtwUYFX4bX5vy=AFi=Dn1r6nxWtMvmeKBSjkvriNJtsQ@mail.gmail.com>
 <20251003232856.GC1492@pendragon.ideasonboard.com> <CABjd4Yx9rt2W=MhCSyO5vaxndD1jvGHNWsz7J=HnvnJcgOvQHw@mail.gmail.com>
 <20251004220326.GC20317@pendragon.ideasonboard.com>
In-Reply-To: <20251004220326.GC20317@pendragon.ideasonboard.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Sun, 5 Oct 2025 14:55:07 +0400
X-Gm-Features: AS18NWCuY7b2iQ0RZGkQTZdghFPEhu9IsvjzDeHFMK_prX2xIp0MyG4PQ_3f7Y0
Message-ID: <CABjd4YwLQ_kr3tA=XnzR4_zmQ0CQs4TuQr-2OWbiOWQfDhP4xw@mail.gmail.com>
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

On Sun, Oct 5, 2025 at 2:03=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Sat, Oct 04, 2025 at 03:41:41PM +0400, Alexey Charkov wrote:
> > On Sat, Oct 4, 2025 at 3:29=E2=80=AFAM Laurent Pinchart wrote:
> > > On Fri, Oct 03, 2025 at 06:55:26PM +0400, Alexey Charkov wrote:
> > > > On Fri, Oct 3, 2025 at 6:13=E2=80=AFPM Alexey Charkov wrote:
> > > > > On Fri, Oct 3, 2025 at 5:33=E2=80=AFPM Laurent Pinchart wrote:
> > > > > > On Fri, Jan 24, 2025 at 11:44:34PM +0400, Alexey Charkov wrote:
> > > > > > > On Fri, Jan 24, 2025 at 9:23=E2=80=AFPM Alexey Charkov wrote:
> > > > > > > > On Fri, Jan 24, 2025 at 2:37=E2=80=AFPM Dragan Simic wrote:
> > > > > > > > > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > > > > > > > > On Fri, Jan 24, 2025 at 2:06=E2=80=AFPM Dragan Simic wr=
ote:
> > > > > > > > > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > > > > > > > > >> > On Fri, Jan 24, 2025 at 9:26=E2=80=AFAM Alexander Sh=
iyan wrote:
> > > > > > > > > >> >>
> > > > > > > > > >> >> There is no pinctrl "gpio" and "otpout" (probably d=
esigned as
> > > > > > > > > >> >> "output")
> > > > > > > > > >> >> handling in the tsadc driver.
> > > > > > > > > >> >> Let's use proper binding "default" and "sleep".
> > > > > > > > > >> >
> > > > > > > > > >> > This looks reasonable, however I've tried it on my R=
adxa Rock 5C and
> > > > > > > > > >> > the driver still doesn't claim GPIO0 RK_PA1 even wit=
h this change. As
> > > > > > > > > >> > a result, a simulated thermal runaway condition (I'v=
e changed the
> > > > > > > > > >> > tshut temperature to 65000 and tshut mode to 1) does=
n't trigger a PMIC
> > > > > > > > > >> > reset, even though a direct `gpioset 0 1=3D0` does.
> > > > > > > > > >> >
> > > > > > > > > >> > Are any additional changes needed to the driver itse=
lf?
> > > > > > > > > >>
> > > > > > > > > >> I've been digging through this patch the whole TSADC/O=
TP thing in the
> > > > > > > > > >> last couple of hours, and AFAIK some parts of the upst=
ream driver are
> > > > > > > > > >> still missing, in comparison with the downstream drive=
r.
> > > > > > > > > >>
> > > > > > > > > >> I've got some small suggestions for the patch itself, =
but the issue
> > > > > > > > > >> you observed is obviously of higher priority, and I've=
 singled it out
> > > > > > > > > >> as well while digging through the code.
> > > > > > > > > >>
> > > > > > > > > >> Could you, please, try the patch below quickly, to see=
 is it going to
> > > > > > > > > >> fix the issue you observed?  I've got some "IRL stuff"=
 to take care of
> > > > > > > > > >> today, so I can't test it myself, and it would be grea=
t to know is it
> > > > > > > > > >> the right path to the proper fix.
> > > > > > > > > >>
> > > > > > > > > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > > > > > > > > >> w/drivers/thermal/rockchip_thermal.c
> > > > > > > > > >> index f551df48eef9..62f0e14a8d98 100644
> > > > > > > > > >> --- i/drivers/thermal/rockchip_thermal.c
> > > > > > > > > >> +++ w/drivers/thermal/rockchip_thermal.c
> > > > > > > > > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_pro=
be(struct
> > > > > > > > > >> platform_device *pdev)
> > > > > > > > > >>          thermal->chip->initialize(thermal->grf, therm=
al->regs,
> > > > > > > > > >>                                    thermal->tshut_pola=
rity);
> > > > > > > > > >>
> > > > > > > > > >> +       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO=
)
> > > > > > > > > >> +               pinctrl_select_default_state(dev);
> > > > > > > > > >> +       else
> > > > > > > > > >> +               pinctrl_select_sleep_state(dev);
> > > > > > > > > >
> > > > > > > > > > I believe no 'else' block is needed here, because if ts=
hut_mode is not
> > > > > > > > > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at =
all, so there's
> > > > > > > > > > no reason for the driver to mess with its pinctrl state=
. I'd rather
> > > > > > > > > > put a mirroring block to put the pin back to its 'sleep=
' state in the
> > > > > > > > > > removal function for the TSHUT_MODE_GPIO case.
> > > > > > > > >
> > > > > > > > > You're right, but the "else block" is what the downstream=
 driver does,
> > > > > > > >
> > > > > > > > Does it though? It only handles the TSHUT_MODE_GPIO case as=
 far as I
> > > > > > > > can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
> > > > > > > >
> > > > > > > > [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6=
f4185d6d391c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
> > > > > > > >
> > > > > > > > > so I think it's better to simply stay on the safe side an=
d follow that
> > > > > > > > > logic in the upstream driver.  Is it really needed?  Perh=
aps not, but
> > > > > > > > > it also shouldn't hurt.
> > > > > > > > >
> > > > > > > > > > Will try and revert.
> > > > > > > > >
> > > > > > > > > Awesome, thanks!
> > > > > > > > >
> > > > > > > > > > P.S. Just looked at the downstream driver, and it actua=
lly calls
> > > > > > > > > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems tha=
t "otpout" was
> > > > > > > > > > not a typo in the first place. So maybe the right appro=
ach here is not
> > > > > > > > > > to change the device tree but rather fix the "gpio" / "=
otpout" pinctrl
> > > > > > > > > > state handling in the driver.
> > > > > > > > >
> > > > > > > > > Indeed, "otpout" wasn't a typo, and I've already addresse=
d that in my
> > > > > > > > > comments to Alexander's patch.  Will send that response a=
 bit later.
> > > > > > > > >
> > > > > > > > > I think it's actually better to accept the approach in Al=
exander's
> > > > > > > > > patch, because the whole thing applies to other Rockchip =
SoCs as well,
> > > > > > > > > not just to the RK3588(S).
> > > > > > > >
> > > > > > > > Anyway, I've just tried it after including the changes belo=
w, and
> > > > > > > > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the e=
xpected
> > > > > > > > pinctrls under tsadc, the driver still doesn't seem to be t=
riggering a
> > > > > > > > PMIC reset. Weird. Any thoughts welcome.
> > > > > > >
> > > > > > > I found the culprit. "otpout" (or "default" if we follow Alex=
ander's
> > > > > > > suggested approach) pinctrl state should refer to the &tsadc_=
shut_org
> > > > > > > config instead of &tsadc_shut - then the PMIC reset works.
> > > > > >
> > > > > > I've recently brought up an RK3588S-based Orange Pi CM5 Base bo=
ard, made
> > > > > > of a compute module (CM5, see [1]) and a carrier board (Base, s=
ee [2]).
> > > > > > The carrier board has a reset button which pulls the PMIC_RESET=
_L signal
> > > > > > of the CM5 to GND (see page 3 of the schematics in [3]).
> > > > > >
> > > > > > With &tsadc_shut_org the reset button has absolutely no effect.=
 With
> > > > > > &tsadc_shut it resets the board as expected.
> > > > >
> > > > > Interesting. The TSADC shouldn't affect the physical button opera=
tion
> > > > > at all, if it's really wired to the PMIC as the signal name impli=
es.
> > > > > There isn't even any default pull value associated with the TSHUT=
 pin
> > > > > config.
> > > >
> > > > On a second thought, I've got another hypothesis. Your baseboard on=
ly
> > > > pulls the reset line through  a 100 Ohm resistor when the button is
> > > > pressed. So if the TSHUT pin is in its default push-pull mode and
> > > > stays high when no thermal runaway reset is requested, the reset
> > > > button won't pull the line fully to zero, as the TSHUT line pulls i=
t
> > > > high at the same time.
> > >
> > > That's the most likely cause, I agree.
> > >
> > > > If you switch it from &tsadc_shut_org to &tsadc_shut, then it stops
> > > > working properly as the thermal protection reset, and GPIO0_A1 rema=
ins
> > > > high-impendance, thus allowing the reset button to function even
> > > > though its pull is too weak.
> > >
> > > By the way, what is the difference between tsadc_shut_org and tsadc_s=
hut
> > > ? I haven't seen it being clearly documented in the TRM.
> >
> > No idea frankly. Looks like a half-finished design change to me, which
> > left the non-"org" version unconnected internally.
>
> :-/
>
> > > > So maybe change the pin configuration of &tsadc_shut_org in
> > > > rk3588-base-pinctrl.dtsi to open drain and retry?
> > >
> > > That's a good idea, but... how ? The pinctrl-rockchip driver doesn't
> > > seem to support generic open-drain configuration.
> >
> > I thought I saw open-drain configurations here, but after reviewing
> > the TRM, bindings and the driver it turns out I must have been
> > daydreaming :( Sorry.
> >
> > Looks like the best we can try is a lower drive strength while keeping
> > the push-pull mode, but I'm afraid this 100 Ohm pulldown is too weak,
> > because the lowest TSHUT drive strength Rockchip offers is 100 Ohm,
> > while the PMIC would only count anything below 30% reference voltage
> > as logical low. Maybe adding a pulldown to the pin config can help,
> > but most likely this board will require switching the pin to GPIO
> > input for high-z, and switching the TSHUT mode to CRU.
>
> I agree with you, going through the CRU seems the best solution for this
> board. This is actually the default mode in
> arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:
>
>         rockchip,hw-tshut-mode =3D <0>; /* tshut mode 0:CRU 1:GPIO */
>         rockchip,hw-tshut-polarity =3D <0>; /* tshut polarity 0:LOW 1:HIG=
H */
>         pinctrl-0 =3D <&tsadc_shut_org>;
>         pinctrl-1 =3D <&tsadc_gpio_func>;
>
> If hw-tshut-mode defaults to 0, why do we need to setup the GPIO0_A1 pin
> to output the TSADC_SHUT signal ?

I believe the thinking was along the lines of "it can't hurt, so let's
provide a default that's likely to work both for the boards where
TSHUT is routed to the PMIC and those where it's not, with an added
benefit of hogging the pin to prevent anyone from accidentally
triggering it to a low level from user space thus suddenly resetting
the board".

But this case of "TSHUT is routed, but with a deviation from the
reference schematic which makes it impossible to use as designed" was
likely never envisaged.

Technically, there is no reason to switch the pin to tsadc_shut_org
when CRU mode is used, and the boottime default for this pin is
high-impedance.

Heiko, shall we remove the pinctrl properties from the common .dtsi
and move them to board specific .dts for those boards that use
PMIC-assisted thermal resets? Happy to produce a patch to that effect.

Best regards,
Alexey

