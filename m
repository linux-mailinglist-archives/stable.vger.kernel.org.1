Return-Path: <stable+bounces-183232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C580BBB7238
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E9219E51F5
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429B52222D2;
	Fri,  3 Oct 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+71hOz/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704121ABB1
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500834; cv=none; b=DKnUaGiXkSJpq4vA3RcEKsh55YTxA43RiUhe17M0rCwTxfN7pL69xnUSxynBJ6wlm/AhSOfBJ0IfO03R4GRLRIOieuXzQSmFieE4DL8OQpC6nHVEROcvh3aqxF4Ng2bvkAnB8oYSmRZrAGfxuEOyiR8puziqwoFs7y18DdMPgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500834; c=relaxed/simple;
	bh=kduyRQqmJomIISeCztwIy/b6RkbOKuS2RUCJOxYEgeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxaKhNJRouHCSbmdpR8IqLc1vcdtMD/koJ+ETaBVSOqUpa8eWLuzBKk4OuIRuzLzY62HgHvoJjhRioPmTSWlygsZGxMHh3f1v7kiiXZhHbTWTDcZ6iejR2EgooU+Bh8ModDaQ651OSEBXan1nN170H0Ri7ezds+kwgdAPJkylt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+71hOz/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-85b94fe19e2so225838485a.3
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759500831; x=1760105631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eiR0rgb8eb14UCK8OF6nqxlziRjDbGGmUvvYEGUxVw=;
        b=Y+71hOz/OVBO+NS+65+YWle0yg3yHsBFbZuNkEkfjImEnyG4WdThEq361TNQrSNKj+
         PQcGaOnDrQvg6P9ie2qF8e2LqFSF4+aJWz7dxnrkgbXQZmWbhAvsF9D7yt+D8l4S2l3t
         xJWSP1J6WVMAWq58Zwav5BgFdWA19UE758MFj37Lkv0ie3nBOfaCgBlKi6SnvmcTWhox
         IPRkKX7hzDJ+DIFk6hwgOQXQRsVaa53uiG4ssmy9p9wPKOEGMgxI8fuDmiL0N/mobQzJ
         FfHn5Fds0By4w9ayvFMpmkoMXLpy019cANyPSVl4Yxm8URWttvRzJnXipixyBwWI7usO
         t3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500831; x=1760105631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eiR0rgb8eb14UCK8OF6nqxlziRjDbGGmUvvYEGUxVw=;
        b=uLsCXOQb5Z4Uv/sRkyRA8ThGzKY1e0UwkLx6ZhdXftqWDyGDRlYXYu/IDDfhcVSoJl
         ziMG/xzS/TgKzurEu0uihxDlf+nTzUXdwY9oRsSPRzcB4MMw+uEYg6sQb8c/PqRDdVhc
         f60eJrrSOD65YnrII1zje1CSlCJRFwMjYhxHOn4q/n/r07ARecj73B8s3xFJOYB/AxSc
         Bvk8glX6jqdb1x/h3I2rXXpIsO7SFAt68M//Wa0aYFKsoehimqV/Hd8PcoWRNL6n8HG6
         Ea+jDT/i7AG1mIwnyfsjFJ0NWJ0Lmc58AAiDziKYy9JKGtJS3rEsS0RDEza1OFtBTyzn
         rNvA==
X-Forwarded-Encrypted: i=1; AJvYcCUJo7Wvq8KwdCSfCiU7tcDsM7Rsp0lzhdUFQQUufLaqi2gZLE/xZdBwwb4b2EkyEQ96vHCINTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWzBO21GsMwvTRdxumLN6lZwk+k/zuWMyP5+mZ1CyD9yYStuQ
	JDTwOdqeS2csctZ5AxbsHyaNvYqCllaCpAb/AvfeDQYdYSLgGvDNcEptfcAqx4WV2JEV+AigQgC
	1n/OCBWJNrIdLSO4Rs2+pfVRu/H0bA9I=
X-Gm-Gg: ASbGncs5WiKjAJZjAhKey4P/s4o0CzLsmycgPRgY73p8ssv8BB7ielDF4a/mVdwiZWo
	HEpZnzNbL3y+XYaPKMWLORmOtvnoGuzvs2s7Q0/9mUo08sas295gCc8snITY4W3PZG4OI0/zoRe
	QWdwRV8x+RqI3RQG/fEs3861/tBKLo7RhgvJMYJOr8ENaoACfEaVpiT9jPpTNtmL5PWNLLiMCB6
	ufc1CUSgkAGxI0ReMLIiX2TRENl/CtpmupkVL5OA/oTZQtHqEoZahCVVgKH/ZDD/t2XfVPm0lWC
	4GFq3h+gIQ==
X-Google-Smtp-Source: AGHT+IF1x6d1SXgWlIOwQSzb64vcGY7LmH9kcXNKvkdLjUNWf0fEfHQbonCQLlSRkqLoUgYilLGKYu0omGuSD7gRJpw=
X-Received: by 2002:a05:620a:2a0d:b0:866:a24e:2eb1 with SMTP id
 af79cd13be357-87a378d2e60mr519951485a.40.1759500831038; Fri, 03 Oct 2025
 07:13:51 -0700 (PDT)
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
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com> <20251003133304.GA21023@pendragon.ideasonboard.com>
In-Reply-To: <20251003133304.GA21023@pendragon.ideasonboard.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 3 Oct 2025 18:13:39 +0400
X-Gm-Features: AS18NWBIZkivEeoQjAejLL_ZipTHn0V26YdQouI-n9UYPc0VVnN7Wrl6g590H6Y
Message-ID: <CABjd4YxbyUWghd1ya8UayFkAE-VWQSd5-J2QD0sV7WmS8AXkCg@mail.gmail.com>
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

Hi Laurent,

On Fri, Oct 3, 2025 at 5:33=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Jan 24, 2025 at 11:44:34PM +0400, Alexey Charkov wrote:
> > On Fri, Jan 24, 2025 at 9:23=E2=80=AFPM Alexey Charkov <alchark@gmail.c=
om> wrote:
> > > On Fri, Jan 24, 2025 at 2:37=E2=80=AFPM Dragan Simic <dsimic@manjaro.=
org> wrote:
> > > > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > > > On Fri, Jan 24, 2025 at 2:06=E2=80=AFPM Dragan Simic <dsimic@manj=
aro.org>
> > > > > wrote:
> > > > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > > > >> > On Fri, Jan 24, 2025 at 9:26=E2=80=AFAM Alexander Shiyan
> > > > >> > <eagle.alexander923@gmail.com> wrote:
> > > > >> >>
> > > > >> >> There is no pinctrl "gpio" and "otpout" (probably designed as
> > > > >> >> "output")
> > > > >> >> handling in the tsadc driver.
> > > > >> >> Let's use proper binding "default" and "sleep".
> > > > >> >
> > > > >> > This looks reasonable, however I've tried it on my Radxa Rock =
5C and
> > > > >> > the driver still doesn't claim GPIO0 RK_PA1 even with this cha=
nge. As
> > > > >> > a result, a simulated thermal runaway condition (I've changed =
the
> > > > >> > tshut temperature to 65000 and tshut mode to 1) doesn't trigge=
r a PMIC
> > > > >> > reset, even though a direct `gpioset 0 1=3D0` does.
> > > > >> >
> > > > >> > Are any additional changes needed to the driver itself?
> > > > >>
> > > > >> I've been digging through this patch the whole TSADC/OTP thing i=
n the
> > > > >> last couple of hours, and AFAIK some parts of the upstream drive=
r are
> > > > >> still missing, in comparison with the downstream driver.
> > > > >>
> > > > >> I've got some small suggestions for the patch itself, but the is=
sue
> > > > >> you observed is obviously of higher priority, and I've singled i=
t out
> > > > >> as well while digging through the code.
> > > > >>
> > > > >> Could you, please, try the patch below quickly, to see is it goi=
ng to
> > > > >> fix the issue you observed?  I've got some "IRL stuff" to take c=
are of
> > > > >> today, so I can't test it myself, and it would be great to know =
is it
> > > > >> the right path to the proper fix.
> > > > >>
> > > > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > > > >> w/drivers/thermal/rockchip_thermal.c
> > > > >> index f551df48eef9..62f0e14a8d98 100644
> > > > >> --- i/drivers/thermal/rockchip_thermal.c
> > > > >> +++ w/drivers/thermal/rockchip_thermal.c
> > > > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
> > > > >> platform_device *pdev)
> > > > >>          thermal->chip->initialize(thermal->grf, thermal->regs,
> > > > >>                                    thermal->tshut_polarity);
> > > > >>
> > > > >> +       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
> > > > >> +               pinctrl_select_default_state(dev);
> > > > >> +       else
> > > > >> +               pinctrl_select_sleep_state(dev);
> > > > >
> > > > > I believe no 'else' block is needed here, because if tshut_mode i=
s not
> > > > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so th=
ere's
> > > > > no reason for the driver to mess with its pinctrl state. I'd rath=
er
> > > > > put a mirroring block to put the pin back to its 'sleep' state in=
 the
> > > > > removal function for the TSHUT_MODE_GPIO case.
> > > >
> > > > You're right, but the "else block" is what the downstream driver do=
es,
> > >
> > > Does it though? It only handles the TSHUT_MODE_GPIO case as far as I
> > > can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
> > >
> > > [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d39=
1c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
> > >
> > > > so I think it's better to simply stay on the safe side and follow t=
hat
> > > > logic in the upstream driver.  Is it really needed?  Perhaps not, b=
ut
> > > > it also shouldn't hurt.
> > > >
> > > > > Will try and revert.
> > > >
> > > > Awesome, thanks!
> > > >
> > > > > P.S. Just looked at the downstream driver, and it actually calls
> > > > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout"=
 was
> > > > > not a typo in the first place. So maybe the right approach here i=
s not
> > > > > to change the device tree but rather fix the "gpio" / "otpout" pi=
nctrl
> > > > > state handling in the driver.
> > > >
> > > > Indeed, "otpout" wasn't a typo, and I've already addressed that in =
my
> > > > comments to Alexander's patch.  Will send that response a bit later=
.
> > > >
> > > > I think it's actually better to accept the approach in Alexander's
> > > > patch, because the whole thing applies to other Rockchip SoCs as we=
ll,
> > > > not just to the RK3588(S).
> > >
> > > Anyway, I've just tried it after including the changes below, and
> > > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> > > pinctrls under tsadc, the driver still doesn't seem to be triggering =
a
> > > PMIC reset. Weird. Any thoughts welcome.
> >
> > I found the culprit. "otpout" (or "default" if we follow Alexander's
> > suggested approach) pinctrl state should refer to the &tsadc_shut_org
> > config instead of &tsadc_shut - then the PMIC reset works.
>
> I've recently brought up an RK3588S-based Orange Pi CM5 Base board, made
> of a compute module (CM5, see [1]) and a carrier board (Base, see [2]).
> The carrier board has a reset button which pulls the PMIC_RESET_L signal
> of the CM5 to GND (see page 3 of the schematics in [3]).
>
> With &tsadc_shut_org the reset button has absolutely no effect. With
> &tsadc_shut it resets the board as expected.

Interesting. The TSADC shouldn't affect the physical button operation
at all, if it's really wired to the PMIC as the signal name implies.
There isn't even any default pull value associated with the TSHUT pin
config.

What if you switch the GPIO0_A1 pin to GPIO output mode with no pull?
Does the button work then? Does the board reset if you toggle the GPIO
value with `gpioset`?

Best regards,
Alexey

