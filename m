Return-Path: <stable+bounces-110390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2006FA1BB5B
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 18:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC72164EF4
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6B41BF328;
	Fri, 24 Jan 2025 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJTn8sd9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0915CD79;
	Fri, 24 Jan 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739412; cv=none; b=KiiuDJ1Uc7nw3xzWT3ZUv5ff0IYGrgS3Kxh2Ks3zsa9m1YdMPBBpHz4d7GUe7UTk/I+QETOkM1pmp1QIPwHdCaz9RbwqT1LlaDrsyn0Ap2noxU5o3KMF8dosDcqgaDIq6V+5YiVjMu4T4o68ZhrbQTIitZrPEEEYmpCWfzybhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739412; c=relaxed/simple;
	bh=kii8UKXKTCVP4t3hez8R7UOovKtmR1WSs/LMLiby0Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Js8D3N2s5cZr+l4i0ltksSBOy6v9/Ck6XTowoC5A28iGu73njpuseOlJgfFclIlvoMBk+F/ZKRnOp879VYSeZLeqeH/m6HDsXmZFk7vSRl68Js9k/1UtJjTGte/ZS8GY164FFR+KyHTDDWr/JuDIsfsOlptmW1+2yY6Sq4dHjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJTn8sd9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7bcf32a6582so203144585a.1;
        Fri, 24 Jan 2025 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737739409; x=1738344209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4/vzmdSMKeOJ/C1GDf68MF2cf5I1Flzl1PjgFGcdcg=;
        b=FJTn8sd9DIEusmpeEx/5oyFlYJwaMzFnj0LYWKpDRqOMgE16niv803UzjM5OUiOTry
         8SPaXkG8WwtTqyzFVBf+CK7Ae4AAFq/WhTW7WNkFwtmbow6DF4zSovFu3PsBTgZfV1r5
         4MMUn0EgOvjF9r/M3s0BACR87IDZSqW8rBSGJdOYvg0nZEb+KaAvDJmqs/ryucRmwOXw
         sD6YT0wtXLuZuoy8j/GWYdMaFKppn6hvF2Ps6kHmMAdvuLfnniaMN94/TMLxycDT0jZd
         IxFECsDU8NBxPattd8e0i5+a5r984EE6QH3tcAxcOtNmCY0ZIjlt2kBQUeRP8T22MNHr
         N4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737739409; x=1738344209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4/vzmdSMKeOJ/C1GDf68MF2cf5I1Flzl1PjgFGcdcg=;
        b=df/LyDHJAR0JWKoy1Dj8eIaUBT8Mg6fpyIBNXdsqALj4LUFssxT8KIKWGoVIO+/x/O
         /ytY/50Vo6Gwo4yPZiUgbWyaYm2maZODCFM+HV9grcPh9Dwrs4ENDvNBOwJ7zzEstHwc
         71Iis94iNtJySyJjqKuJ1g0BEIKOvrcNWzsdVTqO3FGbFANV9nClCSKEEAOrsrwfXwan
         /53TpRY65xbYZCfEPzJrnaB8lCQDUyCFlannb7cY/c75ZjIXwz+Qd7QBAYH+73w6l8ql
         wiOxnGOxQ8LL/r7Hm9BZT5WZfESEQc0gmlskiZohO7weWM1rRynQ5LH4APovR/9ULmnS
         netw==
X-Forwarded-Encrypted: i=1; AJvYcCUI0w0wXQpVRX0XEBl+cs5sOz4iJDZekJiwYKKEx/Mj6WkZtMDfH5xsmMkXRL5hBOb4S+aXAAgNJDthXgRC@vger.kernel.org, AJvYcCUxbBwY1s72expqVMqOfszkfUQr0/hKimsXZ2UmtjRxj4i8xrwl1UVjsJ6Zgiftr6LaoFhj40kbGHpC@vger.kernel.org, AJvYcCXAA6ceGe2lNK5g39b5KRWFiuakEGbnUKOVzlzw1KV0GHtzRAIRJumC5wE9Wl3taLzBQ6cEWrKv@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnVPyChFsaqO9n4VUybRj80eQVpnbff+FRnEKEk2nhzRGgj8D
	8YA/z4UclcZMO9sxLwvMHJkMJzIsAWWjbtpR12TH2a2t+hupPhAfSdxYIYn7jmTf5MpDRVhgglS
	Xx53B1nAhsMylLtdZZz5wOcuaxzI=
X-Gm-Gg: ASbGncstZGBKol/k2HlXxAvPs/jd/652p9gQYBX73BfgCD5zBCicR5J93HsUmPYvD+J
	tLaskD5UCxeQw3H8sciw/tZhZpJrvuWfiHL82UksJF9t5toPA+of7jDiiTwCmWLZowzurUwco8g
	==
X-Google-Smtp-Source: AGHT+IH/71bIsSUVZkYzfhIAkpahFedbMg/3ni3li/QddagsY09U7X5KUjEEkPxHsPsosORBWWQCWIZ/khOf2K+Bq2k=
X-Received: by 2002:a05:620a:17aa:b0:7b6:c92e:2e6d with SMTP id
 af79cd13be357-7be63288b8dmr4180692485a.52.1737739409330; Fri, 24 Jan 2025
 09:23:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org> <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
In-Reply-To: <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 24 Jan 2025 21:23:18 +0400
X-Gm-Features: AWEUYZmMc0C1SJlBvPcDZ7qyIIVJLWYZo934vdGbx4qMERT8_Fj27hNjzrjhk2A
Message-ID: <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
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

On Fri, Jan 24, 2025 at 2:37=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2025-01-24 11:25, Alexey Charkov wrote:
> > On Fri, Jan 24, 2025 at 2:06=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >> On 2025-01-24 09:33, Alexey Charkov wrote:
> >> > On Fri, Jan 24, 2025 at 9:26=E2=80=AFAM Alexander Shiyan
> >> > <eagle.alexander923@gmail.com> wrote:
> >> >>
> >> >> There is no pinctrl "gpio" and "otpout" (probably designed as
> >> >> "output")
> >> >> handling in the tsadc driver.
> >> >> Let's use proper binding "default" and "sleep".
> >> >
> >> > This looks reasonable, however I've tried it on my Radxa Rock 5C and
> >> > the driver still doesn't claim GPIO0 RK_PA1 even with this change. A=
s
> >> > a result, a simulated thermal runaway condition (I've changed the
> >> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PM=
IC
> >> > reset, even though a direct `gpioset 0 1=3D0` does.
> >> >
> >> > Are any additional changes needed to the driver itself?
> >>
> >> I've been digging through this patch the whole TSADC/OTP thing in the
> >> last couple of hours, and AFAIK some parts of the upstream driver are
> >> still missing, in comparison with the downstream driver.
> >>
> >> I've got some small suggestions for the patch itself, but the issue
> >> you observed is obviously of higher priority, and I've singled it out
> >> as well while digging through the code.
> >>
> >> Could you, please, try the patch below quickly, to see is it going to
> >> fix the issue you observed?  I've got some "IRL stuff" to take care of
> >> today, so I can't test it myself, and it would be great to know is it
> >> the right path to the proper fix.
> >>
> >> diff --git i/drivers/thermal/rockchip_thermal.c
> >> w/drivers/thermal/rockchip_thermal.c
> >> index f551df48eef9..62f0e14a8d98 100644
> >> --- i/drivers/thermal/rockchip_thermal.c
> >> +++ w/drivers/thermal/rockchip_thermal.c
> >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
> >> platform_device *pdev)
> >>          thermal->chip->initialize(thermal->grf, thermal->regs,
> >>                                    thermal->tshut_polarity);
> >>
> >> +       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
> >> +               pinctrl_select_default_state(dev);
> >> +       else
> >> +               pinctrl_select_sleep_state(dev);
> >
> > I believe no 'else' block is needed here, because if tshut_mode is not
> > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there's
> > no reason for the driver to mess with its pinctrl state. I'd rather
> > put a mirroring block to put the pin back to its 'sleep' state in the
> > removal function for the TSHUT_MODE_GPIO case.
>
> You're right, but the "else block" is what the downstream driver does,

Does it though? It only handles the TSHUT_MODE_GPIO case as far as I
can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]

[1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d391c5747=
35fca1/drivers/thermal/rockchip_thermal.c#L2564

> so I think it's better to simply stay on the safe side and follow that
> logic in the upstream driver.  Is it really needed?  Perhaps not, but
> it also shouldn't hurt.
>
> > Will try and revert.
>
> Awesome, thanks!
>
> > P.S. Just looked at the downstream driver, and it actually calls
> > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
> > not a typo in the first place. So maybe the right approach here is not
> > to change the device tree but rather fix the "gpio" / "otpout" pinctrl
> > state handling in the driver.
>
> Indeed, "otpout" wasn't a typo, and I've already addressed that in my
> comments to Alexander's patch.  Will send that response a bit later.
>
> I think it's actually better to accept the approach in Alexander's
> patch, because the whole thing applies to other Rockchip SoCs as well,
> not just to the RK3588(S).

Anyway, I've just tried it after including the changes below, and
while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
pinctrls under tsadc, the driver still doesn't seem to be triggering a
PMIC reset. Weird. Any thoughts welcome.

Best regards,
Alexey

rock-5c ~ # cat /sys/kernel/debug/pinctrl/pinctrl-handles
Requested pin control handlers their pinmux maps:
[...]
device: fec00000.tsadc current state: default
 state: default
   type: MUX_GROUP controller rockchip-pinctrl group: tsadc-shut (84)
function: tsadc (84)
   type: CONFIGS_PIN controller rockchip-pinctrl pin gpio0-1 (1)config 0000=
0001
 state: sleep
   type: MUX_GROUP controller rockchip-pinctrl group: tsadc-gpio-func
(95) function: gpio-func (97)
   type: CONFIGS_PIN controller rockchip-pinctrl pin gpio0-1 (1)config 0000=
0001
[...]

rock-5c ~ # gpioinfo 0
gpiochip0 - 32 lines:
       line   0:      unnamed "regulator-vdd-3v3" output active-high [used]
       line   1:      unnamed       unused   input  active-high
       line   2:      unnamed       unused   input  active-high
       line   3:      unnamed       unused   input  active-high
       line   4:      unnamed       unused   input  active-high
       line   5:      unnamed       unused   input  active-high
       line   6:      unnamed       unused   input  active-high
       line   7:      unnamed       unused   input  active-high
       line   8:      unnamed       unused   input  active-high
       line   9:      unnamed       unused   input  active-high
       line  10:      unnamed       unused   input  active-high
       line  11:      unnamed       unused   input  active-high
       line  12:      unnamed       unused   input  active-high
       line  13:      unnamed       unused   input  active-high
       line  14:      unnamed       unused   input  active-high
       line  15:      unnamed       unused   input  active-high
       line  16:      unnamed       unused   input  active-high
       line  17:      unnamed       unused   input  active-high
       line  18:      unnamed       unused   input  active-high
       line  19:      unnamed       unused   input  active-high
       line  20:      unnamed       unused   input  active-high
       line  21:      unnamed "regulator-pcie2x1l2-3v3" output
active-high [used]
       line  22:      unnamed       unused   input  active-high
       line  23:      unnamed       unused   input  active-high
       line  24:      unnamed       unused   input  active-high
       line  25:      unnamed       unused   input  active-high
       line  26:      unnamed       unused   input  active-high
       line  27:      unnamed       unused   input  active-high
       line  28:      unnamed "regulator-vcc5v0-usb-otg0" output
active-high [used]
       line  29:      unnamed       unused   input  active-high
       line  30:      unnamed       unused   input  active-high
       line  31:      unnamed       unused   input  active-high

(note line 1: unused above)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
index 6e56d7704cbe..e8c4d9b3f828 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
@@ -873,6 +873,9 @@ regulator-state-mem {
};

&tsadc {
+       rockchip,hw-tshut-temp =3D <65000>;
+       rockchip,hw-tshut-mode =3D <1>; /* tshut mode 0:CRU 1:GPIO */
+       rockchip,hw-tshut-polarity =3D <0>; /* tshut polarity 0:LOW 1:HIGH =
*/
       status =3D "okay";
};

diff --git a/drivers/thermal/rockchip_thermal.c
b/drivers/thermal/rockchip_thermal.c
index f551df48eef9..4f474906b2b0 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1568,6 +1568,9 @@ static int rockchip_thermal_probe(struct
platform_device *pdev)
       thermal->chip->initialize(thermal->grf, thermal->regs,
                                 thermal->tshut_polarity);

+       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
+               pinctrl_select_default_state(&pdev->dev);
+
       for (i =3D 0; i < thermal->chip->chn_num; i++) {
               error =3D rockchip_thermal_register_sensor(pdev, thermal,
                                               &thermal->sensors[i],
@@ -1614,6 +1617,9 @@ static void rockchip_thermal_remove(struct
platform_device *pdev)
       }

       thermal->chip->control(thermal->regs, false);
+
+       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
+               pinctrl_pm_select_sleep_state(&pdev->dev);
}

static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
@@ -1629,7 +1635,8 @@ static int __maybe_unused
rockchip_thermal_suspend(struct device *dev)
       clk_disable(thermal->pclk);
       clk_disable(thermal->clk);

-       pinctrl_pm_select_sleep_state(dev);
+       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
+               pinctrl_pm_select_sleep_state(dev);

       return 0;
}
@@ -1674,7 +1681,8 @@ static int __maybe_unused
rockchip_thermal_resume(struct device *dev)
       for (i =3D 0; i < thermal->chip->chn_num; i++)
               rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);

-       pinctrl_pm_select_default_state(dev);
+       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
+               pinctrl_pm_select_default_state(dev);

       return 0;
}

