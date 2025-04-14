Return-Path: <stable+bounces-132399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B8A87834
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1E03B1B58
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81A45C18;
	Mon, 14 Apr 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hs90We8a"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD91B0421
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613412; cv=none; b=F92/ef3AMSd7xnke65pKlQcokwWTQyMT7iFUcroSNTPnewEvwi3JfoOHhdXWZk5Du5zoFf/9UHNQvEH8H9AO9X0emzv6UuKpMBKICb7PL4oUp1Lf7HnAIkGlqkDTbpz/pmm2tDo/XjARxt4KG99JHbDcytbrZusOvHV5YduY+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613412; c=relaxed/simple;
	bh=eJuQ6K53iIE7H+B7T4xrEmRXHvyysdEcji4rNeYft9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzZnPOwvEajdw/SFpWaBRviEXHtHPQSlCNAbxQ1anhzbeuXpCEnyj0kCRFZt4AJir0btVWh8aAJ28i3ay5k88iiiYq9w+fa2J1j1/Q1Tn1jSiG1rpGZqMCrlSTTzujiGAHpdoXo3zpw5wFlQq3YdrCTnzreI/R7h3lkJ7pproMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hs90We8a; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Apr 2025 12:20:02 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744613408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bV+9Q8YkIlG7twmYcn7d/G5ce4v53eG6zFWycuhqVrs=;
	b=Hs90We8aRLict0baKvkhSRRp1/cGjYc9CvEirjeMvg41VRzkOt2j8aNUX7SVNla60+rToL
	JUbxUHbR15EJu1nc1qrJijPyXKdy34ht7L4U/aFpjKVDyV1bkRkEdJ0k9uZ3m6Uf6af5d3
	kNIiGLjcretrOI8sl+KbK8pt4P0Nqhw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jai Luthra <jai.luthra@linux.dev>
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vaishnav.a@ti.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: ti: k3-am62x: Rename I2C switch to
 I2C mux in OV5640 overlay
Message-ID: <bc5ocuam2ghevg6ory35leuebfka7amllfqr5xggiori7qt2xh@mevrrqj74lmd>
X-PGP-Key: http://jailuthra.in/files/public-key.asc
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-8-y-abhilashchandra@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dg2ofw3wo72v6frl"
Content-Disposition: inline
In-Reply-To: <20250409134128.2098195-8-y-abhilashchandra@ti.com>
X-Migadu-Flow: FLOW_OUT


--dg2ofw3wo72v6frl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/7] arm64: dts: ti: k3-am62x: Rename I2C switch to
 I2C mux in OV5640 overlay
MIME-Version: 1.0

On Wed, Apr 09, 2025 at 07:11:28PM +0530, Yemike Abhilash Chandra wrote:
> The OV5640 device tree overlay incorrectly defined an I2C switch instead
> of an I2C mux. According to the DT bindings, the correct terminology and
> node definition should use "i2c-mux" instead of "i2c-switch". Hence,
> update the same to avoid dtbs_check warnings.
>=20
> Fixes: 635ed9715194 ("arm64: dts: ti: k3-am62x: Add overlays for OV5640")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>

Reviewed-by: Jai Luthra <jai.luthra@linux.dev>

> ---
>  arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso      | 2 +-
>  arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso b/arch/a=
rm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> index ccc7f5e43184..7fc7c95f5cd5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> @@ -22,7 +22,7 @@ &main_i2c2 {
>  	#size-cells =3D <0>;
>  	status =3D "okay";
> =20
> -	i2c-switch@71 {
> +	i2c-mux@71 {
>  		compatible =3D "nxp,pca9543";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso b/a=
rch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> index 4eaf9d757dd0..b6bfdfbbdd98 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> @@ -22,7 +22,7 @@ &main_i2c2 {
>  	#size-cells =3D <0>;
>  	status =3D "okay";
> =20
> -	i2c-switch@71 {
> +	i2c-mux@71 {
>  		compatible =3D "nxp,pca9543";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> --=20
> 2.34.1
>=20

--dg2ofw3wo72v6frl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmf8sBoACgkQQ96R+SSa
cUUy0BAA0gb0YY99MVaqw2qUY9WJWfMvUk7dMWK89JmtKgTTWnm/y2O0me2oWrnv
o3j3FrXIZip5yr8iyzcscWpsFpCR/XiyyprLC0vIajZqs5Wf2HsthGfWZkNRCGX9
rCrttkk5lj4KX/mNHiUdkTbUTtxzogU/QMHu+wQ8OwX0BtiCw4zzkuhhl2wXqlW/
eh7UFQ1ntmdx91GHqa6kHXulxt76PHB8/PHgSLzqlGHX8TCdpBwYCUCKyeK8ckT1
/+jnmnTa9HIRUxsbU50R119Rvj5HZ5X2ZAzY/qw8Q+fHozAAHk3iC6sAj/o53rwu
9dkMkqUBOZnuSFCRaDhhmgQpV5OLl03Tc6TpMUJJCkJ10TJ5DcIrANitCM7s4z1/
Eo5o2+SMMza9pFo94f7uJzn5JTUkhaZYu7cc5I++L5HFQzI1v68ieBdV4dfL/QdB
W9niWHSpLZD6EGDfki/mGdvM4OqKgVAzszW/n4gH3ljMx39Yuc9uXP5wqnbQT87w
sIqDTJpRuG3UYpXaJk40/fQ0/d6gYCkibCRIYY7Z9H4eu91ei8syeazveEr/dQ/w
iIThXVfBUaK5Zs9oH4ETcq3z0XLsQ3XAjqLYHv4p18kGdnmq856vFPplFoUy4m9a
trre856gV5bh32+mxX5M3DYALa2JA1wbs0rulf6Y2pgMLjq9MzM=
=HJ8g
-----END PGP SIGNATURE-----

--dg2ofw3wo72v6frl--

