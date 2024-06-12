Return-Path: <stable+bounces-50302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E6E905890
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193EF1F21E4D
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79626180A72;
	Wed, 12 Jun 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onwfcia5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AE1D55D;
	Wed, 12 Jun 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209110; cv=none; b=khBB0vQQu56jdPXJeedOQIo2wK+/+N15GWK6avafWwppEvQmQxDYKsI4DaR0/pjnrKrOE2or0a3/W/46rjvWywliILNO0eBj8qieF6NlOxPoik0KTBw8EdSzEzPVOzyX3KjQ4dQCXvpUCzV1oO4lnUs2/tQTYuPEDz9wZbkrx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209110; c=relaxed/simple;
	bh=mrAtLefxv0thjdim3MyV19oF1GLyA84RC7ijpbytDEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIxVC9m7WbP0n6IPb+YM4N3Z+V9kh1fgPo78a3SsFugE2K7IYgXj1FIMb2EYaDc1Qq76CFeZxZskKh2aqNVJETeys05ukqsvYyhm7xYZnlGGOeuTlJeVgNqZwRxmqC6qXW+VkF9Tr1/hcRqWMAEjAMXDVkFym3WozOPc1s+Ryuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onwfcia5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB0CC116B1;
	Wed, 12 Jun 2024 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718209109;
	bh=mrAtLefxv0thjdim3MyV19oF1GLyA84RC7ijpbytDEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onwfcia5tZxlbotmy2KGSRsYmaPaB7lrhHe+mlX83R7AZ8ZDeoHmgVs63qFed1Sjl
	 KEfDFE4XdpGBK7lTX/MHY/xTO7NOYNfyGOJsHFjGkba34hEPoLfxAG8DSd+qYvjL2c
	 Hv2EyXyFqPB6u87YvJOx6gy6cIPCyaY4RegWn+R9mqybpoSIZ8eSvjWnfRxOA40V2e
	 yoEx/aUjfpNt040SOAtEz/wYrFdkij/Kobq3T0Qjlly1cr7RwuMCUYg25GWxeGY3+L
	 kTPoI1OY2+XhHXfRAajpY/jjFu1lAnooRtLmBKbY0Axtir/afPn8jAUTIKSBMx6yMi
	 gU5eMWR9gSq/g==
Date: Wed, 12 Jun 2024 17:18:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: kernel@esmil.dk, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, william.qiu@starfivetech.com,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: starfive: Set EMMC vqmmc maximum voltage
 to 3.3V on JH7110 boards
Message-ID: <20240612-various-verbose-8c1a5db7d25a@spud>
References: <TY3P286MB261189B5D946BDE69398EE3A98C02@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xi1bAWiRrsUVmPLp"
Content-Disposition: inline
In-Reply-To: <TY3P286MB261189B5D946BDE69398EE3A98C02@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>


--Xi1bAWiRrsUVmPLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 06:33:31PM +0800, Shengyu Qu wrote:
> Currently, for JH7110 boards with EMMC slot, vqmmc voltage for EMMC is
> fixed to 1.8V, while the spec needs it to be 3.3V on low speed mode and
> should support switching to 1.8V when using higher speed mode. Since
> there are no other peripherals using the same voltage source of EMMC's
> vqmmc(ALDO4) on every board currently supported by mainline kernel,

I should've asked last time around, does the star64 also support 3.3
volts?

> regulator-max-microvolt of ALDO4 should be set to 3.3V.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> Fixes: 7dafcfa79cc9 ("riscv: dts: starfive: enable DCDC1&ALDO4 node in ax=
p15060")
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
> 2.39.2
>=20

--Xi1bAWiRrsUVmPLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnKUQAKCRB4tDGHoIJi
0qGWAP9hFPT8FJ7ViNXuiJzrGnuM6DWyDGEUokl7LP4eNgEE0QD+IX8bMeyax6R+
t7D7uPpBVm1HKna+WWxbTfeoycsirwA=
=VCME
-----END PGP SIGNATURE-----

--Xi1bAWiRrsUVmPLp--

