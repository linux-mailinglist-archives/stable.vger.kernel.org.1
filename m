Return-Path: <stable+bounces-210352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA4D3AA98
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC9A3084F5A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698CF36BCF1;
	Mon, 19 Jan 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYWUkw90"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272536BCC7
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830201; cv=none; b=rJdD75nTQQRehz81VRcOz39DwUp49bKI5VB6fQyBmYm5iBrET5C26lqIZX33lztPywPV2A3TQwsXAnXFz8qZz+GWVnN6mX3ivijzMBFnypqvq+Rcc44JC8wPdFNVdP6aDkX4hhLwL9j+6afekeKp6rSh8ZoQIVUV8TQ7fn0Xnxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830201; c=relaxed/simple;
	bh=glVc+vYs2e48C7e6a42YdHrlwubv61v062vq1op02/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3gY2tn5Af3GYYruBVA2dM5uLQnpFg5QV5RgQaeJvDz9U5yoHv+y4Uar2iduD4fWzPCrICh7JZJUZAxiWGiU4JxyUrHAcyZ7dOdiJLJgO23Ogo+MEO/vPiKe/muXioNylUlNrL5uTD1h3BbpxcyD8axx1Vb92uAPaykV6gnLGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYWUkw90; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014600ad12so33091731cf.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768830198; x=1769434998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chB5b0rt82JcysgedumeHVaiY8n8X+8y2Qmtz5rmwLo=;
        b=MYWUkw90jR0MXmW9XWTRwA9nAUtxotOM931CR+9Ig6nP68+9k1vdcI/k/rGp7ePHE1
         cA1fP5BWcWKy1a/lKXtdjaFK8vWfpeILzKqyHy6MJzuSThsvWUTjrWGLZMFdZO0Pf9ci
         e2G7uuYAvQbj3zcWIAIJcJYyaL30t8XbIv+Vkwi/ZimJGNutT8tesNhXIAQAroeCipp2
         LdpEAw5RtrPMwEVvAw28lYDHL00iFv/yqT6zEqbOkMYPis2M26lsj+kSUgFw4oP9TkxC
         7p0PXJLDg4ESCbyhqYTuZSG+QgdcABsGHjwBbYcnQzPYksSvkrMlPYdplLg+L4BGuhQj
         Ir0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768830198; x=1769434998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chB5b0rt82JcysgedumeHVaiY8n8X+8y2Qmtz5rmwLo=;
        b=ox4FIDwy1EEsEYG2avmY5aqDWtGvuNk0ynRXz1tQIF6Fvpek/Ff6R42lOd5ynbrTFv
         D47QpMA48wUF2ZViHsPY0hdy+21fFsVnlukyzZ+WKo43q665dkr7ZxfEBU9E0zyJdNsM
         JC0c3ZTl01fKgA8wVVtfGjeD+AiKIG9XLYFbU2Nvo41UZNp/SnsRXGniFp4LTasWsvuF
         FF9OKNL6+4O4tyILhFBX+X8va1VA6G1+12+m+Rv1H5gPkIkMatHcpqzKpzOv3nipUejR
         13QriXQxiwHfkZZM0+y+b6NsWBV+3Pqs1XAcVNketkLdEr7t9uDXXqZ1F0rLEXqPSiBO
         L8BA==
X-Forwarded-Encrypted: i=1; AJvYcCUxkE7EJUG5r8kJ0Dzq25baNDQBae/k3JO4hWgdUfEPlP8aAr9ujokUlqk7fwjSiXV66mns50U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1fjXiTP14EmwGlU/E1HvZhn7RPARZJZVnxH2s4nmW32Zb8yL
	IcQsiDE7Tk2YwGWFKQYsycgTVv/LbgJS5gjPv9h4I/+JqN7Rcno1jAaKDQVrd4JOrqX5rhrsuuS
	MPBdOkC5Ga/L45a8W/oKrcGcN/W0yfoMeeZOw
X-Gm-Gg: AY/fxX4yNmAWHK3MTFM5jPFf9XyYAoD0VrfPT6Vp9mmowa1tzKYz9hA7orL5iLJsxRJ
	nUdDWyn9um4pq+y6/ebBF6bUevHS3+DqMM99e7F7S+LUsDXKE8yidTcUusXJgGQm14zh3TL5axZ
	e+3mPpuyWFcDQoRJlEzicVZT2Eeaxe3W+i2aDO5n2cqVunKRHekWbhAXUNnSRTLwdv88WBGE718
	uDQ3qoZzeDEWjIvZt2ez7RQ9X6DI9lGtxlyuB50W20qGYJITCTdkQb9uLAe7MjyGB7C2cGn6Ez+
	BC6cRahC6RMp+l0ni0zB70A1sZkBsqdDvZiElQ==
X-Received: by 2002:ac8:5a93:0:b0:4ee:1f22:3613 with SMTP id
 d75a77b69052e-502a179b7d7mr149743011cf.62.1768830197715; Mon, 19 Jan 2026
 05:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com> <b0904cb5-3659-41cc-8395-79eec9e82f01@cherry.de>
In-Reply-To: <b0904cb5-3659-41cc-8395-79eec9e82f01@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 19 Jan 2026 17:43:09 +0400
X-Gm-Features: AZwV_Qg3fDBDn37sLa59WhlzNgabNqw_H45Z3ujw8yrw_76pBFKSvwfPEz_39iE
Message-ID: <CABjd4YzJud4ZZQ_GrOOSnfEVG7wgHmPSf9w8oQhLVSx6WXgN5A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

On Mon, Jan 19, 2026 at 3:08=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 1/19/26 10:22 AM, Alexey Charkov wrote:
> > Rockchip RK3576 UFS controller uses a dedicated pin to reset the connec=
ted
> > UFS device, which can operate either in a hardware controlled mode or a=
s a
> > GPIO pin.
> >
> > Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> > hardware controlled mode if it uses UFS to load the next boot stage.
> >
> > Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> > device reset, request the required pin config explicitly.
> >
> > This doesn't appear to affect Linux, but it does affect U-boot:
> >
> > Before:
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> > < ... snip ... >
> > =3D> ufs init
> > ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], pw=
r[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> >
> > After:
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> > < ... snip ...>
> > =3D> ufs init
> > ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], pw=
r[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> > =3D> md.l 0x2604b398
> > 2604b398: 00000010 00000000 00000000 00000000  ................
> >
> > (0x2604b398 is the respective pin mux register, with its BIT0 driving t=
he
> > mode of UFS_RST: unset =3D GPIO, set =3D hardware controlled UFS_RST)
> >
> > This helps ensure that GPIO-driven device reset actually fires when the
> > system requests it, not when whatever black box magic inside the UFSHC
> > decides to reset the flash chip.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for R=
K3576 SoC")
> > Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > This has originally surfaced during the review of UFS patches for U-boo=
t
> > at [1], where it was found that the UFS reset line is not requested to =
be
> > configured as GPIO but used as such. This leads in some cases to the UF=
S
> > driver appearing to control device resets, while in fact it is the
> > internal controller logic that drives the reset line (perhaps in
> > unexpected ways).
> >
> > Thanks Quentin Schulz for spotting this issue.
> >
> > [1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f2081335=
@cherry.de/
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
> >   arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
> >   2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> > index 0b0851a7e4ea..20cfd3393a75 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> > @@ -5228,6 +5228,13 @@ ufs_rst: ufs-rst {
> >                               /* ufs_rstn */
> >                               <4 RK_PD0 1 &pcfg_pull_none>;
> >               };
> > +
> > +             /omit-if-no-ref/
> > +             ufs_rst_gpio: ufs-rst-gpio {
> > +                     rockchip,pins =3D
> > +                             /* ufs_rstn */
> > +                             <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
>
> The SoC default is pull-down according to the TRM. Can you check please?
> For example, the Rock 4D doesn't seem to have a hardware pull-up or
> pull-down on the line and the UFS module only seems to have a debouncer
> (capacitor between the line and ground). So except if the chip itself
> has a PU/PD, this may be an issue?

The SoC default is indeed pull-down (as stated both in the TRM and in
the reference schematic from RK3576 EVB1). Which I believe means that
the attached device should be held in a reset state until the driver
takes over the control of the GPIO line (which, in turn, is consistent
with the observed behavior when reset handling is not enabled in the
driver but the reset pin is in GPIO mode).

Are you concerned that the chip might unintentionally go in or out of
reset between the moment the pinctrl subsystem claims the pin and the
moment the driver starts outputting a state it desires? This hasn't
caused any observable issues in my testing, but I guess we could
explicitly set it to &pcfg_pull_down for more predictable behavior in
line with what's printed on the schematic.

Best regards,
Alexey

