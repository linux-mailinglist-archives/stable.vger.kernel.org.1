Return-Path: <stable+bounces-132397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF8A87826
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 08:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170503B1D07
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9291BC07B;
	Mon, 14 Apr 2025 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mP0VR8Ne"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631661ACEA5
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613319; cv=none; b=nbWWORnY9ZU0C0YPsik3ffZrp9RvKcc7PkwxsSw+w6aE/pre1g2EVlGWDegrK+CSijiNz0wem3mwJICuyDPoFXk2xVRLsGjxXA72bzXV/Fou5b5PhdOBDEQE6o70SdT1cuTVzad28LMpWpv0vZJ8A0FfCzAfHYGuoxfzmaV3ztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613319; c=relaxed/simple;
	bh=Lw2KXpWu8jDdtPhTEqm4VVhJ0ttQl0BjqJFnfi/RPI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR7kpwQtN6C/0M73NnkqqguEyL7X/fzgUH4RzfR+xjdT1S4++CdXv25pACq75OFOKSjD+f+aYTLicwfu2T+zxV6hzZo0Eo7u8klxKVmib4F2zBTjdRgmsDZPQi5mJaPKxNnw8ss7SJNO27aUtSnK65bNt/oRE1vGzggskmhekXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mP0VR8Ne; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Apr 2025 12:18:18 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744613305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaBBYXHfLF++cExY9hjSu3QHr8Mvyrqh9+FHlLk33ro=;
	b=mP0VR8NeyztZF6hFVhgFhodcSN3xqJXCf+sxhThfbf+3vD4UsKkMYQ+TOj7bGCKMz+YypF
	RIwGyf88gDMgqqjy+yBfuvhM7ikDNifrSIWS6g/nc/4St2JbZAGHCTuZ+1c6De+eQAwIR+
	zCUD3IJWTTbjQXv86+Zabg8xkDGJApU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jai Luthra <jai.luthra@linux.dev>
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vaishnav.a@ti.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/7] arm64: dts: ti: k3-am62x: Remove clock-names
 property from IMX219 overlay
Message-ID: <tosg63tki3b7xqr4kiioav3pjq3hwmj5vygb4d4ju46o7eyyfz@yowubjrrnsvh>
X-PGP-Key: http://jailuthra.in/files/public-key.asc
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-6-y-abhilashchandra@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="udmjswxldcpwpkxo"
Content-Disposition: inline
In-Reply-To: <20250409134128.2098195-6-y-abhilashchandra@ti.com>
X-Migadu-Flow: FLOW_OUT


--udmjswxldcpwpkxo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/7] arm64: dts: ti: k3-am62x: Remove clock-names
 property from IMX219 overlay
MIME-Version: 1.0

Thanks for the fix,

On Wed, Apr 09, 2025 at 07:11:26PM +0530, Yemike Abhilash Chandra wrote:
> The IMX219 sensor device tree bindings do not include a clock-names
> property. Remove the incorrectly added clock-names entry to avoid
> dtbs_check warnings.
>=20
> Fixes: 4111db03dc05 ("arm64: dts: ti: k3-am62x: Add overlay for IMX219")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>

Reviewed-by: Jai Luthra <jai.luthra@linux.dev>

> ---
>  arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso b/arch/a=
rm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> index 76ca02127f95..7a0d35eb04d3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> @@ -39,7 +39,6 @@ ov5640: camera@10 {
>  				reg =3D <0x10>;
> =20
>  				clocks =3D <&clk_imx219_fixed>;
> -				clock-names =3D "xclk";
> =20
>  				reset-gpios =3D <&exp1 13 GPIO_ACTIVE_HIGH>;
> =20
> --=20
> 2.34.1
>=20

--udmjswxldcpwpkxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmf8r7IACgkQQ96R+SSa
cUUWUw/9EANMG5P9O57SqaT7wfQ/VnxxlUUfXTqeHoYXuwDgLK/gIxA2AxlJzf1z
PjUvXjnwdn/2xnJzUlOJihlLkvqoG9oAaKKG3LUUx2AV5TA5jpX38M3ifvTjn5WK
8tIBq0EtGH8sC3vbx2RT7L3Lu1nA021oUXj8IK9IGtcCh4afVB2bGCDQmghY12WO
2P4XKVrMg11LUfm7Xpmo2JB6Nlc2P+lleh8UVr4kXhDtKp5MAJAJhEw+n7rfTUYU
FBpZOPNIwzxQNRhSVGY9n70A6vCzM6Z2zVPIwXHOX0IOAqBFywqrlF9iV+znyWoK
2wngiE5gcOxcsCjXuZSVCCtXz03yKvt4ELHGqy5t/N7Z6n3pL1ZY+WNcpqrGokMV
8EOYQKV+Wmon965m9T/HntHHxzAdnD2KF6bcM8Un7HK+Zit1SwMAmq5Ffml0IrMl
u8m9rNUL3enJgPrgy9JE3ZvqaMtbgQAxYUOuA7Gcx8uD3MvoR5KrIZZge0uWF9OI
w8QASdBjVSuucWJKathj5CSE6fBHBj4QY2Fqy1Kd2qCopbCwVZ4gPuEDoyoe5GwV
TlRR2aPcINRH/ehtZMUN77r8Szl0YasXgskYQu42XRNSwcYE2J/Vf+B8SmaBVCsF
4t1aDcsGWZY3efzRSv4pdimo83qz96p8R468u5ngKyiPuo8QU5Y=
=tCJn
-----END PGP SIGNATURE-----

--udmjswxldcpwpkxo--

