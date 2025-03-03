Return-Path: <stable+bounces-120184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645C0A4CD92
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A2017192B
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319BB230277;
	Mon,  3 Mar 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="FKPHvcH7"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45321E9B3D
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037813; cv=none; b=muPTxuNRrIiWnJj/QVk5UEqCEwmwkvj5/tij2DDvU1b10J823egb/QPHp40n0AlhJLl2SvtDRbvJfurkkGnCw9LMop6MSpeXEY8CGZOl4lb8k12QlvsOmeYIg8sbtLFw6gd1E62vBcbxShmRr3eltXSQgO2yIpg/ocbllP3HljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037813; c=relaxed/simple;
	bh=Dc+8vGrV4CJpWZL/5rLgVOBvtbTZ7UQ4jMSoEWXbxko=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LweOPh/6seaj7Iji2wZUDXG5+IwiY/uw4oCLsNzH0u1AdVGkv/pJwMe+SAxozOI+0B2AuSaVRqj/Eyo2CWM8WYrzdiszvvtG8awyZukagx5E3IEdE0e3g9KX4HSX6i6CQ7gh6UQv5IqgNgAB8FXcrJI2EQwsUrpTx31MJL7FPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=FKPHvcH7; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1741037799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPR0yHTL9G5UObQ+1ZLwbXfpYibvfRkKqDO5ejFcj7c=;
	b=FKPHvcH7c9zqAD2wESgcTCiEHMa1t179PF75OD/gBjZUlW35GuneHgQh3HWsNZMX0pOnbi
	+6RkoPQH9w6R5bz9uQHkHfTFpwYR0WulMu3vkJDuVzl8DOFABTBxXR1TQBYqrHEpFdhebd
	9VdLQKQUsz67EHvE8Mai5BwzwVmn0P7sqW6bTZ/H5kwcyrfjsxxifLMp2+72CRfE8fvwJU
	ucj94m+EDxHS5Yw9ACbnRbsfw7RB1uMUBMEXG3Voi5ce9rEWlXJVXCY13HQg46uiB5HpZA
	aaNnQuUSoe16F5dTA5w+uR+1mqMYFUtVFYI6EREYjbqJlr7nDvw3cnNOKCpUPQ==
Content-Type: multipart/signed;
 boundary=d8a90991c87105546b1f1cba4bc2dbbd19c5ea33d56cd1a4d2b8bf3508e6;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 03 Mar 2025 22:36:23 +0100
Message-Id: <D86YDVZLWWA0.33WM5O2EZIAI6@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>
Cc: <heiko@sntech.de>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <chris@z9.de>, <stable@vger.kernel.org>, "Marek Kraus" <gamiee@pine64.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add avdd HDMI supplies to
 RockPro64 board dtsi
References: <cover.1740941097.git.dsimic@manjaro.org>
 <df3d7e8fe74ed5e727e085b18c395260537bb5ac.1740941097.git.dsimic@manjaro.org>
In-Reply-To: <df3d7e8fe74ed5e727e085b18c395260537bb5ac.1740941097.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--d8a90991c87105546b1f1cba4bc2dbbd19c5ea33d56cd1a4d2b8bf3508e6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dragan,

On Sun Mar 2, 2025 at 7:48 PM CET, Dragan Simic wrote:
> Add missing "avdd-0v9-supply" and "avdd-1v8-supply" properties to the "hd=
mi"
> node in the Pine64 RockPro64 board dtsi file.  To achieve this, also add =
the
> associated "vcca_0v9" regulator that produces the 0.9 V supply, [1][2] wh=
ich
> hasn't been defined previously in the board dtsi file.
>
> This also eliminates the following warnings from the kernel log:
>
>   dwhdmi-rockchip ff940000.hdmi: supply avdd-0v9 not found, using dummy r=
egulator
>   dwhdmi-rockchip ff940000.hdmi: supply avdd-1v8 not found, using dummy r=
egulator

Also thanks for this patch :-)

I've now also confirmed for myself that without this patch I see the
above warnings and I don't see them with this patch applied.

When booting up I saw an U-Boot logo (hadn't seen that one before) and
not longer after that I saw the various boot messages come by on the
monitor I had connected to the HDMI port. This is only a *very*
barebones install (yet), so I couldn't do 'deeper' tests, but HDMI
appears to work. So feel free to include:

Tested-by: Diederik de Haas <didi.debian@cknow.org>

Cheers,
  Diederik
>
> There are no functional changes to the way board works with these additio=
ns,
> because the "vcc1v8_dvp" and "vcca_0v9" regulators are always enabled, [1=
][2]
> but these additions improve the accuracy of hardware description.
>
> These changes apply to the both supported hardware revisions of the Pine6=
4
> RockPro64, i.e. to the production-run revisions 2.0 and 2.1. [1][2]
>
> [1] https://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> [2] https://files.pine64.org/doc/rockpro64/rockpro64_v20-SCH.pdf
>
> Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for R=
ockpro64")
> Cc: stable@vger.kernel.org
> Suggested-by: Diederik de Haas <didi.debian@cknow.org>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 69a9d6170649..47dc198706c8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -227,6 +227,16 @@ vcc5v0_usb: regulator-vcc5v0-usb {
>  		vin-supply =3D <&vcc12v_dcin>;
>  	};
> =20
> +	vcca_0v9: regulator-vcca-0v9 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcca_0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <900000>;
> +		regulator-max-microvolt =3D <900000>;
> +		vin-supply =3D <&vcc3v3_sys>;
> +	};
> +
>  	vdd_log: regulator-vdd-log {
>  		compatible =3D "pwm-regulator";
>  		pwms =3D <&pwm2 0 25000 1>;
> @@ -312,6 +322,8 @@ &gmac {
>  };
> =20
>  &hdmi {
> +	avdd-0v9-supply =3D <&vcca_0v9>;
> +	avdd-1v8-supply =3D <&vcc1v8_dvp>;
>  	ddc-i2c-bus =3D <&i2c3>;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&hdmi_cec>;


--d8a90991c87105546b1f1cba4bc2dbbd19c5ea33d56cd1a4d2b8bf3508e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ8Yg3QAKCRDXblvOeH7b
bq9wAQCusrEFMAJXQYDLkDEx+x1dIC0qmK207Wx9wyGlJYC3XgD/awM9hupSqNWO
O0yXgcsLM0uoj1NxWs+YlE7lnWbdIAs=
=ukKr
-----END PGP SIGNATURE-----

--d8a90991c87105546b1f1cba4bc2dbbd19c5ea33d56cd1a4d2b8bf3508e6--

