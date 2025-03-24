Return-Path: <stable+bounces-125949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A057A6E020
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 17:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72D17A3EE3
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2745E25D1E1;
	Mon, 24 Mar 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="WYA7wOWA"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E4263F49
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834867; cv=none; b=PcaUHJpF2ztfLbnAcjk53afms2uSM946X/tmk6usUWM0QUP9sDO8NBM9heG/LuGKJJEPP1xpK1v3LwIDDU7pcL5soAm5MBAhOMjU9PmGL7ZT2P3Sf6Jb0neRv3GHUqLbFAPIYmIP8PObMGir9wgXlKedPJnc7hq0rqlQOEONZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834867; c=relaxed/simple;
	bh=5sMexviAHegXwMZiPSwF56if3ZRbUht1pGh+3v91Obs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qOMbJBwK+kNWplV21nL1Yitns4YpWxOq6akDtctWchP4PRXfV1xN1csCSH6rTOpbmXUUZNsO1EasozElVzyvxjKDszhTcpfA0BRVCm3Tb+MMvKBjiQpEvIsOyp+S5c3Wi0glgGzj/n4ZOCJ8au4ypyBKMTisyDajA1ZBUHyH43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=WYA7wOWA; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1742834861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3Ap/1r6vyRB8YZFUWUCF30c7ZhrDM3Q284tOy4NWRw=;
	b=WYA7wOWA788flOPaTtysPi0LDhegcma7Wf2aPVAW54bNn4CNP+GR4KOuB9rLCrWccgw9+v
	/lBznSPX77QObPb/z0T3NYZA/BPLaZEToQYNxZe3ls9UKd4c2NKUES0/bd2yWQgA+3w8Yf
	oDktsusj0cv7cEhOH0hsQbJQCbgGcx1YVLDDJUChhn5VeSyd6UvbZKJZNNaQNFOZ3JQHEP
	1SuQEoyEIFwz0G0p/Zr+SkMsKB7FN9GCXCYGyJJFVbmUqBwwADnAG5oC1WCDt6c/jTEAkn
	T4K7lZ2gA1cqRARjnkDV6seOWdc3xJC2tekUr4Q2iCk+djZoC9Ibmkw6SKvtfA==
Content-Type: multipart/signed;
 boundary=d3642077efab1a7c4764f26790c0d6c78463d862e38d6f7d7e0fa3da4865;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 24 Mar 2025 17:47:29 +0100
Message-Id: <D8ONE4WEF7A2.1OE1YY8J34MM3@cknow.org>
Subject: Re: FAILED: patch "[PATCH] arm64: dts: rockchip: Add avdd HDMI
 supplies to RockPro64" failed to apply to 6.12-stable tree
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: <gregkh@linuxfoundation.org>, <dsimic@manjaro.org>, <heiko@sntech.de>
Cc: <stable@vger.kernel.org>
References: <2025032432-catsup-glory-c916@gregkh>
In-Reply-To: <2025032432-catsup-glory-c916@gregkh>
X-Migadu-Flow: FLOW_OUT

--d3642077efab1a7c4764f26790c0d6c78463d862e38d6f7d7e0fa3da4865
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Mar 24, 2025 at 4:30 PM CET, gregkh wrote:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The reason it doesn't apply is because this commit is missing:
5c96e6330197 ("arm64: dts: rockchip: adapt regulator nodenames to preferred=
 form")

And that will likely affect many dts backports now and in the future.
The same issue applies to the other stable kernel failures.
The change is (essentially) a ``regulator-`` prefix on the regulator
node names.

> thanks,
>
> greg k-h

Cheers,
  Diederik
>
> ------------------ original commit in Linus's tree ------------------
>
> From bd1c959f37f384b477f51572331b0dc828bd009a Mon Sep 17 00:00:00 2001
> From: Dragan Simic <dsimic@manjaro.org>
> Date: Sun, 2 Mar 2025 19:48:03 +0100
> Subject: [PATCH] arm64: dts: rockchip: Add avdd HDMI supplies to RockPro6=
4
>  board dtsi
>
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
> Tested-by: Diederik de Haas <didi.debian@cknow.org>
> Link: https://lore.kernel.org/r/df3d7e8fe74ed5e727e085b18c395260537bb5ac.=
1740941097.git.dsimic@manjaro.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
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


--d3642077efab1a7c4764f26790c0d6c78463d862e38d6f7d7e0fa3da4865
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ+GMpgAKCRDXblvOeH7b
bgIqAP44kEY+yutUh+uiNQazaxhIPr2fVt/bbnbigoR4yNfNHAD/Z3NNJu/x9ywz
o/Pyb9enuwSUgwflIS7MMn+x9RwelQQ=
=SQFP
-----END PGP SIGNATURE-----

--d3642077efab1a7c4764f26790c0d6c78463d862e38d6f7d7e0fa3da4865--

