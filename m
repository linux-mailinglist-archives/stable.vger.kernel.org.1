Return-Path: <stable+bounces-210355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F150DD3AB3A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA815300FBDE
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0370376BCF;
	Mon, 19 Jan 2026 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhM9txJt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77A35CB84
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831528; cv=none; b=Koz5wKBQ/YwqD6pWbAspjWJcYmtd95T6WUMRy3aT+ssoImSzoJmt7/aNHnMOOg5KSjUr3oS87svXobgu4IHXTEOS9gTaRP8A3lo8WnEnzMDJ7jeRdQpFYua7OJrTn893p828SmOa9iiwmDmYe4GrkSHRFX/aqRyXfe9sOGd5ipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831528; c=relaxed/simple;
	bh=Os00fZo/Ep1VtT6RREuGctNZzOne1pfhDWIGSEScn5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPTb3WIWqiciEzuK9DbudM7IpRjFiBl3cgeAgIzYgm24P3Sod+/Pn7dUrDpKZ7r8lvEQZU7ilmqPYyJ/bFuXvdVp24n1AyHPmBE5vJqWGXME0XoY/DNiY8c4Zjp9Y5mduuRp0964EaK1UDa3SXAYhHzMpscl4xcgoEYwjafR2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhM9txJt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c52c1d2a7bso590496385a.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768831525; x=1769436325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hF78wptD7ld1V2LGnCYp+bLK7K2nBtHmiHSnMfpqB8c=;
        b=DhM9txJtqUHEvsP3zJ+/X0cxOtzEOgOtMl6xxSA9F/o7LLCu36de3SL98u6MmCTykl
         RDYAiYBrn/tbLfRvS6FuBPiOl6ErN7OG+ukVX6MM/dBvDDNV03gzPmBHuIPYTq130LWH
         qC9XtY3sG5G3dbr4+eI7XaZTKnmyrsctHvDbEvPBkKQ9LgRGpVYS7R7O498xTyglJfIO
         anw8AseGEXDacKAjINJIRSeFEWaEe6GuNbxTTh3Mw/OLloiUx86Q7n77WWdhNSuhSLz7
         6czXRB9kAgEoGVdN5Yk6yYaiL+HXWRyr7L3eIiopfNjJxbmkmMdvov3AOQUWDWyswjK8
         jnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831525; x=1769436325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hF78wptD7ld1V2LGnCYp+bLK7K2nBtHmiHSnMfpqB8c=;
        b=uvWpbWaQ0cycZVFWp8937BROMRvudYOo5wjiH5ddScntLOfqhv2tRf3uzj8HUQiFFy
         HswAPNewQDkLGn7cbH8eOo+DeTwE0h+lftmQWr9pqSU7Rf1Fk5GpEpjy+a1gjHEnYVmS
         rg84mrYMfYcr+SS0hjLqUVQM5VsjAbF/jNXuPg1eTYA5MttHS79vNo+U+85kJusTKDC7
         VzAkS2DbHQ+DgFcrDiFD/TQYB6tf2frwQyM2ljhu5Trg+niaJqTa9xCCjp3kvUe6nAW/
         0emDWrVoxfzm20BV5oM/9wmXjEdGFgzXNW5HEUjas5NMsmYWv/4PXYdqH02SI4N5R8zz
         AYew==
X-Forwarded-Encrypted: i=1; AJvYcCWEhu9rONMUPrpcORkjQcf1KeFApMo5c4MP/v2NhS11y5RpBabMOrv0k6o9CUPhtPaaJnscmhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVWCzO1Y8vm3tU6EARtgjm8uRM6CN2rcIBKnQCdL7jVnXKxxX
	taf2MlG6lFCkVesczIeuFhO7rBbB8nTF4Jf2+UKLPeDJrt61vbXgcaTjULt4ENd5eAHe/SIy1Fj
	ZhFX5Jv2kcsvABQMAGptMNGML6rGI8Xk=
X-Gm-Gg: AY/fxX5BFqpF+0Kwa5kBmaoNl1iP7g5mxwzyvHCnGuH++ggLB4/6GzMgj/zSxBCPbIy
	vsq9X4qllVYRsKBjrwBFwibeRAtbpJ88NR2DEuia3SVylWGzcUVR4v7qXo93t22NRy///zP2bDL
	XRvirGwLHmrG0jrMWiuzlJHhbEOAlrbnBmeoivWYTSSfJwMJ4fCWTuH/vb+4+3JcTF1ZHVubdAU
	mzyCbUA+mM4uibcRr9Q1R/OofklOhNAvffy00FlR/KjPXHJocxoUrYJcUo3h2fstYR0idY3fStJ
	4iwsimQUoggIOgGrzJq1hfexO1M=
X-Received: by 2002:ac8:7f54:0:b0:4f1:de87:ad90 with SMTP id
 d75a77b69052e-501982dcb8bmr201855631cf.4.1768831524345; Mon, 19 Jan 2026
 06:05:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com> <b0904cb5-3659-41cc-8395-79eec9e82f01@cherry.de>
 <CABjd4YzJud4ZZQ_GrOOSnfEVG7wgHmPSf9w8oQhLVSx6WXgN5A@mail.gmail.com> <d3b5f622-36ec-42ea-90da-3c056e1b6461@cherry.de>
In-Reply-To: <d3b5f622-36ec-42ea-90da-3c056e1b6461@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 19 Jan 2026 18:05:16 +0400
X-Gm-Features: AZwV_QjYhPBrmB-HzyDxfoEaeqoxWE1URl6xYqQ4XwLXLh3YQ3UlufJql0dky0Q
Message-ID: <CABjd4YympEqbiN9-Kwv40YtaCh6bu=3PBQPyvvGgKCQbLeZmZw@mail.gmail.com>
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

On Mon, Jan 19, 2026 at 5:58=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 1/19/26 2:43 PM, Alexey Charkov wrote:
> > Hi Quentin,
> >
> > On Mon, Jan 19, 2026 at 3:08=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 1/19/26 10:22 AM, Alexey Charkov wrote:
> >>> Rockchip RK3576 UFS controller uses a dedicated pin to reset the conn=
ected
> >>> UFS device, which can operate either in a hardware controlled mode or=
 as a
> >>> GPIO pin.
> >>>
> >>> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> >>> hardware controlled mode if it uses UFS to load the next boot stage.
> >>>
> >>> Given that existing bindings (and rk3576.dtsi) expect a GPIO-controll=
ed
> >>> device reset, request the required pin config explicitly.
> >>>
> >>> This doesn't appear to affect Linux, but it does affect U-boot:
> >>>
> >>> Before:
> >>> =3D> md.l 0x2604b398
> >>> 2604b398: 00000011 00000000 00000000 00000000  ................
> >>> < ... snip ... >
> >>> =3D> ufs init
> >>> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], =
pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> >>> =3D> md.l 0x2604b398
> >>> 2604b398: 00000011 00000000 00000000 00000000  ................
> >>>
> >>> After:
> >>> =3D> md.l 0x2604b398
> >>> 2604b398: 00000011 00000000 00000000 00000000  ................
> >>> < ... snip ...>
> >>> =3D> ufs init
> >>> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], =
pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> >>> =3D> md.l 0x2604b398
> >>> 2604b398: 00000010 00000000 00000000 00000000  ................
> >>>
> >>> (0x2604b398 is the respective pin mux register, with its BIT0 driving=
 the
> >>> mode of UFS_RST: unset =3D GPIO, set =3D hardware controlled UFS_RST)
> >>>
> >>> This helps ensure that GPIO-driven device reset actually fires when t=
he
> >>> system requests it, not when whatever black box magic inside the UFSH=
C
> >>> decides to reset the flash chip.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for=
 RK3576 SoC")
> >>> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >>> ---
> >>> This has originally surfaced during the review of UFS patches for U-b=
oot
> >>> at [1], where it was found that the UFS reset line is not requested t=
o be
> >>> configured as GPIO but used as such. This leads in some cases to the =
UFS
> >>> driver appearing to control device resets, while in fact it is the
> >>> internal controller logic that drives the reset line (perhaps in
> >>> unexpected ways).
> >>>
> >>> Thanks Quentin Schulz for spotting this issue.
> >>>
> >>> [1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f20813=
35@cherry.de/
> >>> ---
> >>>    arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
> >>>    arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
> >>>    2 files changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/=
arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> >>> index 0b0851a7e4ea..20cfd3393a75 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> >>> @@ -5228,6 +5228,13 @@ ufs_rst: ufs-rst {
> >>>                                /* ufs_rstn */
> >>>                                <4 RK_PD0 1 &pcfg_pull_none>;
> >>>                };
> >>> +
> >>> +             /omit-if-no-ref/
> >>> +             ufs_rst_gpio: ufs-rst-gpio {
> >>> +                     rockchip,pins =3D
> >>> +                             /* ufs_rstn */
> >>> +                             <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>=
;
> >>
> >> The SoC default is pull-down according to the TRM. Can you check pleas=
e?
> >> For example, the Rock 4D doesn't seem to have a hardware pull-up or
> >> pull-down on the line and the UFS module only seems to have a debounce=
r
> >> (capacitor between the line and ground). So except if the chip itself
> >> has a PU/PD, this may be an issue?
> >
> > The SoC default is indeed pull-down (as stated both in the TRM and in
> > the reference schematic from RK3576 EVB1). Which I believe means that
> > the attached device should be held in a reset state until the driver
> > takes over the control of the GPIO line (which, in turn, is consistent
> > with the observed behavior when reset handling is not enabled in the
> > driver but the reset pin is in GPIO mode).
> >
> > Are you concerned that the chip might unintentionally go in or out of
> > reset between the moment the pinctrl subsystem claims the pin and the
> > moment the driver starts outputting a state it desires? This hasn't
>
> Exactly that.
>
> Imagine for some reason the driver EPROBE_DEFER, there can be a lot of
> time between the original pinconf/pinmux and the time the GPIO is
> actually driven.
>
> At the same time.. I guess it may not matter much if the UFS chip gets
> out of reset temporarily as (I assume) when the UFS controller probes
> properly, it'll do a full reset of the UFS chip via the reset GPIO.
> Don't know anything about UFS, so maybe there could be damage if the UFS
> chip gets out of reset if its supplies or IO lines are in an illegal stat=
e?
>
> > caused any observable issues in my testing, but I guess we could
> > explicitly set it to &pcfg_pull_down for more predictable behavior in
> > line with what's printed on the schematic.
> >
>
> s/schematics/TRM/
>
> I'll let Heiko decide but I would personally go for a PD to match the
> default state of the SoC according to the TRM.

Happy to make a v2 with an explicit pull-down. Will wait a bit for any
other potential feedback though.

Thanks a lot,
Alexey

