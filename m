Return-Path: <stable+bounces-47651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A28D3C5C
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 18:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD439282F7D
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D61836E3;
	Wed, 29 May 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZUiuJ77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA31836FB;
	Wed, 29 May 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000045; cv=none; b=tsnOtn6vYwdxzf3mdRL+ARM2+V1zlFqSXnOHyOK4oFX8YTEEAyDKIoqcs+AwEXpzh5u1E8Ohe9WVm8mSAjvM0fxtVI6gAlD/Okdw0ZCPn1zEPZA6GfypkjMsv+QvZ9F3LV4srPDO1Y0eYWv3tkvAQSCIow5+9cUmUlfYrjX+FvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000045; c=relaxed/simple;
	bh=6pJy8GSeOsoQfIf1fWQ8Q5hijGi2n3wCqP9jsUD7W+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN8kygvCSf7bkX1wuSCVUnZlvdjptFw1/StTOG/MPsWJEZ/zOqxh/McC9VRerRIVP98ZBulNybGyjAwjbe8pVQMddVV1FqZi35hMjzTvWmjv0PXBaBut801lxaDhNzutpNYa/9K2Ns8atbXB57bvA05+XMyQYcC1rjxFkjt4kmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZUiuJ77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6CEC4AF08;
	Wed, 29 May 2024 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000044;
	bh=6pJy8GSeOsoQfIf1fWQ8Q5hijGi2n3wCqP9jsUD7W+Y=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=LZUiuJ77zrGPdcr7609yv9hPBsSd+NGCfWRuEkGeG3WCdH5Ncd4VpsgkA2R/EXbhn
	 cabvYkzRFq2feRjmpFBdEDc5VVhIfTFyCZDZuHVPlrRwnuKFUswVPwvbEaj2UMx0Pc
	 ZKaUYn/m/P4e7nuCBm6woINUuRNNKkt6y6nzM8nSni3OyeMQ/ne/1RejJas+xu1xoX
	 FNCFr0xl7DuaXiTQNUgTD84vW46e7qqNawNEkj3/jYr/tLNqeHDbbKZgFgEkTOd+aA
	 3+jwfxeh40AnJQva0e16sch+Qpj+va1xZLszQ7PyXImuIp69Z1+b2iZdsB0/h9P50K
	 o9U0eYcIpx+xw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e716e302bdso25139681fa.1;
        Wed, 29 May 2024 09:27:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL/9EuI51soBeCYq7iHi5fBPds0fqFil0qDw+zW80tE0uKmPbMpiCW3eY9yWzm1Oj/Qiq/5BdauNT2HwHpiYVjHe6GhsSv04zP5MrqIbyJqartUvfGUq9W4ByhvNmsfeGTm+bSv4GhWxqS+lzBeI0iIpvxxA3LMuVSnJDUaE3f5A==
X-Gm-Message-State: AOJu0Ywkdpa7DEG5M7bse8vBtuTT36EPiKyUMWnNB6Ysm3iGH6do9zcS
	K7JDiKpRj3/Og0VBKxRN3WVQse9VjbtI1JZaqZswXueEUWmJIW25SnFBfFV041hRGqzqeKXIbWR
	Ij3ZuqClJukU+5VLfMcSn5F+kfhw=
X-Google-Smtp-Source: AGHT+IHrj3c2UqSisziC7+QIH9F4CAvMm95FPN4uKjeYMhxBFdWT7Y6xzMv02ZF8u55DDKqqW8M6ZQJBMCYW9FyIySs=
X-Received: by 2002:a2e:b385:0:b0:2e1:cb22:a4d with SMTP id
 38308e7fff4ca-2e95b25679dmr98428051fa.36.1717000042779; Wed, 29 May 2024
 09:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
In-Reply-To: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 30 May 2024 00:27:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v66DPvvRcq+98vF2mCF8URW_qys1+B_FM9kcm6ppuPvyeg@mail.gmail.com>
Message-ID: <CAGb2v66DPvvRcq+98vF2mCF8URW_qys1+B_FM9kcm6ppuPvyeg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage
 on Quartz64 Model B
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Diederik de Haas <didi.debian@cknow.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:20=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Correct the specified regulator-min-microvolt value for the buck DCDC_REG=
2
> regulator, which is part of the Rockchip RK809 PMIC, in the Pine64 Quartz=
64
> Model B board dts.  According to the RK809 datasheet, version 1.01, this
> regulator is capable of producing voltages as low as 0.5 V on its output,
> instead of going down to 0.9 V only, which is additionally confirmed by t=
he
> regulator-min-microvolt values found in the board dts files for the other
> supported boards that use the same RK809 PMIC.
>
> This allows the DVFS to clock the GPU on the Quartz64 Model B below 700 M=
Hz,
> all the way down to 200 MHz, which saves some power and reduces the amoun=
t of
> generated heat a bit, improving the thermal headroom and possibly improvi=
ng
> the bursty CPU and GPU performance on this board.
>
> This also eliminates the following warnings in the kernel log:
>
>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, no=
t supported by regulator
>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators (20000=
0000)
>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, no=
t supported by regulator
>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators (30000=
0000)
>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, no=
t supported by regulator
>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators (40000=
0000)
>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, no=
t supported by regulator
>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators (60000=
0000)
>
> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B device =
tree")
> Cc: stable@vger.kernel.org
> Reported-By: Diederik de Haas <didi.debian@cknow.org>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/ar=
m64/boot/dts/rockchip/rk3566-quartz64-b.dts
> index 26322a358d91..b908ce006c26 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -289,7 +289,7 @@ vdd_gpu: DCDC_REG2 {
>                                 regulator-name =3D "vdd_gpu";
>                                 regulator-always-on;
>                                 regulator-boot-on;
> -                               regulator-min-microvolt =3D <900000>;
> +                               regulator-min-microvolt =3D <500000>;

The constraints here are supposed to be the constraints of the consumer,
not the provider. The latter is already known by the implementation.

So if the GPU can go down to 0.825V or 0.81V even (based on the datasheet),
this should say the corresponding value. Surely the GPU can't go down to
0.5V?

Can you send another fix for it?


ChenYu

>                                 regulator-max-microvolt =3D <1350000>;
>                                 regulator-ramp-delay =3D <6001>;
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

