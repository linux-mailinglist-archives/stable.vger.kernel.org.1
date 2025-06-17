Return-Path: <stable+bounces-152755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87156ADC299
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 08:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB1172D72
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6C28B400;
	Tue, 17 Jun 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIsFUe3z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406B23A563;
	Tue, 17 Jun 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143269; cv=none; b=gHveYeqeMeDKQqcOim3fGee8XrNmT5gu93tlR4hgBByrwxau7xLMaoFTx1dyQVbCDAxk2J8a0SEectecYwkjN1JNHUpjHYE+34s5wRBvkJudXVA2cUXAjzrum5lF21nkT0KOMboxmXI3xAQafRrH08kFpzhvWGrpnw1IAkrLCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143269; c=relaxed/simple;
	bh=HjahR+5qTN3pIlJ+ylhnwJK5VuFttLOxzMqjt4GhiIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZZpkkOhtUdJMPuV91OKqjG2jLFVX5F0XWC9UWALiUl7pNbdM8q4+wpwrAIPndo5QuVazEvvLeUhO9YJ9Ris64uP6UTPY2XDAeUggDk1EuK/p85SZPP5Vb+qYFJ50KNwiF/+/JOpUpg04S07+yk2gpTKkuXyDdwbX5PaWDFJgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIsFUe3z; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a752944794so16677581cf.3;
        Mon, 16 Jun 2025 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750143267; x=1750748067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvcPLHvTAOguPWHkmBTRclEQDHuwUCTXdi76i3qlbXo=;
        b=RIsFUe3z19ZKw+yZsD/1z0aiMAVPfm3e5OE5JkCbtguQgbrDJlNavh3cuqrZ3y0fGY
         o0VcwAHmqowoCZBEr28X8XxhlQWi4NEjByw60MocKXfl/rTCU3bklXnRsf0zBqnW/bD+
         J1qNIUxJMEdT4TIhS9w59Z53CHQ2eA6fheiNjqPSsY+Yqrrr3zlKH0ns8Fb9WYQRM3zO
         kOY6yLRwIeqhZOMpAYD8tWqoE/vLfwtXoRnP9RS7fwWh8tOvq1fltjRs4/dE5xzDVvTg
         KpIH7ehdyird04YstArZCBtu2gMqhgmKF3isbIkkrjV7DP2G2N7AJgLApJaiFlBZNmFl
         9y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750143267; x=1750748067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvcPLHvTAOguPWHkmBTRclEQDHuwUCTXdi76i3qlbXo=;
        b=ivRC4ocY9B/bpxYAX2vzIxw0uAZOStnaW2tkL+njvi7NHwI6pHDr7zTEZANkL510gx
         Jn50A9XQsN+NIqUSZToVvJfPi/6W6ndrfhk3FNGf1YIbsi8gVPAQ4kQuAQesst/Q//Da
         Esy88MwiRnd7znAus8hWfZ1NloZegb1RmqCkpba2yP4uddx5xhZtnCOkUFSwpwZyxjfR
         zmzBQHc/gA5Q69VwACwLP84iBJAOSdh+09cGmtup0IeSsLjmiEyxVlAJHZiKUc7kSpBj
         399kdf7cuvICxUI6qx8NR9YiBMQYnZQMJvNFPRj5iIX+U4OTgBa3Z+rVPs1wAdBGNNja
         I55g==
X-Forwarded-Encrypted: i=1; AJvYcCU4DLa6uCNiEWfIF7wBYr/GbE65SmrIEKIdy1uz60PdW+MMvOEbRh/ZdRji6Ou036u0rjf9t/No@vger.kernel.org, AJvYcCVHEU5CkdITQSqZcwzZK6cJCCCM19ZUInzoaOCxU+HhYpeY3Zsfj2AlkPj79MqsYPUS7rkKLmhKmp1O@vger.kernel.org, AJvYcCXrCf9CbEwu5lJaVsVnBItvkxlCBpbpEOTfcoTFThWwjfeGroru8SVGbo4/fRkz3nQicZDDo3Y0gwuVGg9A@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4RVhohntBxD0tdRFrtHKbAj2p5bEZo1m4dk82mZIaNrvKphw
	CRb8YoXogbpR6G2eFtQookZfOUkJSXb8wE78Q5VS2uKheg/XwbYaHrO+IXzWtEQrF45H0f75H6T
	dViWGLQgIlRuPUtirVroQEQTbi6UsL5k=
X-Gm-Gg: ASbGncs/+gU40urST8U7IPTEYtCKjMxxRpJumC3o+wQkvtEP1ZerIE/6QGqFv3GT11S
	MkOvd4pB37qgX2nfb1JltvRcpyDuSNfesDfVKe+IfJ8kcWKqr2qlql6QwrZ8rULUpg3EH3l/jyv
	2zZ5I0K9Jq4NuNHdfDDGMAfrhio9ScKNJ/rTqWFpGFsmh6/SPRf5QZb6c0fZ327bGlJ5F8hoyS5
	xob
X-Google-Smtp-Source: AGHT+IEY4uyjlHP9FOiSFmYJPvurc+MojB54rhkqFuWHs7MtM0Di6VF2exh4ISQVMKgesJnXEjcVknPDPnIWM5OS4pU=
X-Received: by 2002:a05:622a:1356:b0:494:acf1:bd0f with SMTP id
 d75a77b69052e-4a73c5a524emr168864261cf.42.1750143266713; Mon, 16 Jun 2025
 23:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com> <175011005578.2433766.276755788637993361.robh@kernel.org>
In-Reply-To: <175011005578.2433766.276755788637993361.robh@kernel.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 17 Jun 2025 10:54:18 +0400
X-Gm-Features: AX0GCFshodACsqaeamV1VCoCbFUaWw8rwzunXBPUulAI9_Ms6YTcbd6QpZ5J0AE
Message-ID: <CABjd4YzjCBnc77AGAsEv_eq1+UwMFiuDBjENBrxJ8t4S-89UeQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: rockchip: enable further peripherals
 on ArmSoM Sige5
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Detlev Casanova <detlev.casanova@collabora.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:46=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Sat, 14 Jun 2025 22:14:32 +0400, Alexey Charkov wrote:
> > Link up the CPU regulators for DVFS, enable WiFi and Bluetooth.
> >
> > Different board versions use different incompatible WiFi/Bluetooth modu=
les
> > so split the version-specific bits out into an overlay. Basic WiFi
> > functionality works even without an overlay, but OOB interrupts and
> > all Bluetooth stuff requires one.
> >
> > My board is v1.2, so the overlay is only provided for it.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > Changes in v2:
> > - Expand the commit message for the patch linking CPU regulators and ad=
d
> >   tags for stable (thanks Nicolas)
> > - Fix the ordering of cpu_b* nodes vs. combphy0_ps (thanks Diederik)
> > - Drop the USB patch, as Nicolas has already posted a more comprehensiv=
e
> >   series including also the Type-C stuff (thanks Nicolas)
> > - Pick up Nicolas' tags
> > - Split out board version specific WiFi/Bluetooth stuff into an overlay
> > - Link to v1: https://lore.kernel.org/r/20250603-sige5-updates-v1-0-717=
e8ce4ab77@gmail.com
> >
> > ---
> > Alexey Charkov (4):
> >       arm64: dts: rockchip: list all CPU supplies on ArmSoM Sige5
> >       arm64: dts: rockchip: add SDIO controller on RK3576
> >       arm64: dts: rockchip: add version-independent WiFi/BT nodes on Si=
ge5
> >       arm64: dts: rockchip: add overlay for the WiFi/BT module on Sige5=
 v1.2
> >
> >  arch/arm64/boot/dts/rockchip/Makefile              |  5 ++
> >  .../rockchip/rk3576-armsom-sige5-v1.2-wifibt.dtso  | 49 +++++++++++++
> >  .../boot/dts/rockchip/rk3576-armsom-sige5.dts      | 85 ++++++++++++++=
++++++++
> >  arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 16 ++++
> >  4 files changed, 155 insertions(+)
> > ---
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> > change-id: 20250602-sige5-updates-a162b501a1b1
> >
> > Best regards,
> > --
> > Alexey Charkov <alchark@gmail.com>
> >
> >
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> This patch series was applied (using b4) to base:
>  Base: using specified base-commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94
>
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm64/boot/dts/rockchi=
p/' for 20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com:
>
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm0:pwm0m1-ch1:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m1-ch1:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m1-ch0:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m0-ch4:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m1-ch2:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m0-ch2:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m0-ch3:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m1-ch3:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m1-ch5:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm2:pwm2m1-ch6:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): i3c1_sda:i3c1_sdam1-pu:rockchip,pins:0:2: 14 is greater tha=
n the maximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): pwm1:pwm1m1-ch5:rockchip,pins:0:2: 14 is greater than the m=
aximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): i3c1:i3c1m1-xfer:rockchip,pins:0:2: 14 is greater than the =
maximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#
> arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,r=
k3576-pinctrl): i3c1:i3c1m1-xfer:rockchip,pins:1:2: 14 is greater than the =
maximum of 13
>         from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,p=
inctrl.yaml#

N.B.: these are unrelated to my series, and fixed by Nicolas' patch at
[1], already in -next.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D86491c2b99e5adbb56d76286d6668effb36d3c90

