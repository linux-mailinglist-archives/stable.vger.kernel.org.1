Return-Path: <stable+bounces-50171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F6390412F
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63261F25926
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE17F7E3;
	Tue, 11 Jun 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAd5OW5H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89143AAE;
	Tue, 11 Jun 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122989; cv=none; b=PfPF3eQJrU5zmdVVdNXH7YkhkZbYYfjna8/bV+UATCCde/Iya4WgsDuxhmogFznh9raDPIsYFaDBikCjt6qRIgpLBur5z6q3mDhnslMS7nRT0qrEp4pXYMfRqW9W3LEVVgXZO4WVwNSlYhpWt8sNpVD5wLoXx4+lNlZAEi/SlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122989; c=relaxed/simple;
	bh=yEpTP94eDr5A3s9VgS5dBduy8ufIp19ilct/d2eDhsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LndVmy8s6edFa5v/xeZF67rjIJSZoqvGvqav4gBoX9mQ3XMOtTayQU9Ci9tsuZr+7Hj0RquNVdFGtvWiqQFCD86Bx7WV5hUWOo1nhuGSGFjUiM6l5CUmKQJ9+DHq0sEyf/k/oQpcF+ODi+voNeXzA5+OfVwt99GYunq35Zb8ZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAd5OW5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55621C2BD10;
	Tue, 11 Jun 2024 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718122988;
	bh=yEpTP94eDr5A3s9VgS5dBduy8ufIp19ilct/d2eDhsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAd5OW5HPNWu95j/Nh5a6vrZrlRAA4jImqvTUch1p5+DD8kOrtJHaHonbYOXoyqJG
	 uat5emaBVryTRAqWHV9CDqTjgodJqo/gD+PL0AkQxTj8W1w8ZJsw7lvmTyElXICI/3
	 MUlGVHy4YbkxHsU3TGNmQIEoIJttsxnk+P11wRUnGfqGno0g/44uzWMKflQRXudg2q
	 A3H5P/GJSbNd/Ufj6BMgB4PlunQXccK0tzOz0BHVg46KQJJUQc89AQZty/tDjE1M/s
	 qaXfei4mU3+FCTZeLBhbCwDIHdNCrg9r3YomMosOoK7a38ogkOx8GFqLGabTy51w2z
	 r/WyyfsOBBXwQ==
Date: Tue, 11 Jun 2024 17:23:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: kernel@esmil.dk, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, jszhang@kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: Set EMMC vqmmc maximum voltage to
 3.3V on JH7110 boards
Message-ID: <20240611-entourage-churn-8b69966848fc@spud>
References: <TY3P286MB2611936BD43C24D34B442E6D98C72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5qjNIfeTE8upxu8l"
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611936BD43C24D34B442E6D98C72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>


--5qjNIfeTE8upxu8l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:56:41PM +0800, Shengyu Qu wrote:
> Currently, for JH7110 boards with EMMC slot, vqmmc voltage for EMMC is
> fixed to 1.8V, while the spec needs it to be 3.3V on low speed mode and
> should support switching to 1.8V when using higher speed mode. Since
> there are no other peripherals using the same voltage source of EMMC's
> vqmmc(ALDO4) on every board currently supported by mainline kernel,
> regulator-max-microvolt of ALDO4 should be set to 3.3V.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> Fixes: ac9a37e2d6b6 ("riscv: dts: starfive: introduce a common board dtsi=
 for jh7110 based boards")

I don't think this fixes tag is correct, it just moved in that commit.
It has been there since commit 7dafcfa79cc9 ("riscv: dts: starfive: enable
DCDC1&ALDO4 node in axp15060").

Thanks,
Conor.

> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 37b4c294ffcc..c7a549ec7452 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -244,7 +244,7 @@ emmc_vdd: aldo4 {
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <3300000>;
>  				regulator-name =3D "emmc_vdd";
>  			};
>  		};
> --=20
> 2.34.1
>=20

--5qjNIfeTE8upxu8l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmh56AAKCRB4tDGHoIJi
0r8qAP4x+AYwI1YvlFyfOl2OTqSjrgW71fGQWfNwAfKUONuP3gEAxPVa2gMI5JtD
zE/H/i7djgXlxQmv+nrgtuqcARn3Cww=
=mz3Z
-----END PGP SIGNATURE-----

--5qjNIfeTE8upxu8l--

