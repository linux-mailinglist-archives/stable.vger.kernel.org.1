Return-Path: <stable+bounces-126782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023BBA71DD4
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8701617122B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9A2405E1;
	Wed, 26 Mar 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnS2FyLz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C223E334;
	Wed, 26 Mar 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011896; cv=none; b=Cz2HgaYdW1HqjjZLzemzNRcRMB1YiQW7dbGssCEzQK6jZnH/7FNaIJJ6h23a6wJpbfBoAO8fWoTUFuxv3wJza/VTAlFZ+8ho5wv3YciGoM7NF0WLdk2LcT2YeNnW51n0N1ctIwksMoE8FYbn/ekc4rNCssnNsLqQy0gHAMDjGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011896; c=relaxed/simple;
	bh=qD/cQ41RTo+8BDYdoRt9s5SKovqsdZGdDznd1NSpQ6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQv7oB+8enMWHqvxoKl8OsrYfPmtk3TmNe31Rk1IxF3W+xN/AQMZ78jGvW1R2wQgPpH77+pN80gVMmM9+TVzmokiVxn2r1KWLup0+pbpNrPPrTLKdnHLS9JKJNTlD5HkTrrJU6Vt9ccdNJlGrbeMxXfqCDA9NCJ4z1BxDJOLxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnS2FyLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A90C4CEE2;
	Wed, 26 Mar 2025 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011896;
	bh=qD/cQ41RTo+8BDYdoRt9s5SKovqsdZGdDznd1NSpQ6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnS2FyLz/sd/a9zJ6hmgsKESQg/fH8iDeWVq2tPaA4JXR14WInCiekYIY9X8GYBxv
	 v+2S2s5YrK+EMlc62REZ7YCao5x9cUjTH6z6a0dLif7BvHSQvYq4JMHSxwwTM1aXuS
	 1EtwJmvhlHKjnereQixhR2d5dcJOhjBr3Jn4xpGWAjM3BqKD0FbvbiAQThaoGFlkDd
	 DLZKN7T0R+XMRSD1ZwgxVHqlc54xkVBIdunljgm39zqs7ZJwjDS7xZcGmOITVYfLee
	 zEI19BS2enPqpLIrDi+7FNL2jSpOalh01klMNugAgsXT0+cE407KhXs1hZwu0pUaNS
	 D2VDFkTjl2AGg==
Date: Wed, 26 Mar 2025 17:58:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Matthias Kaehlcke <mka@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Klaus Goger <klaus.goger@theobroma-systems.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: usb: cypress,hx3: Add support for all
 variants
Message-ID: <20250326-fanatic-onion-5f6bf8ec97e3@spud>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
 <20250326-onboard_usb_dev-v1-2-a4b0a5d1b32c@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9k9ZnTZP7lApPE38"
Content-Disposition: inline
In-Reply-To: <20250326-onboard_usb_dev-v1-2-a4b0a5d1b32c@thaumatec.com>


--9k9ZnTZP7lApPE38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 05:22:57PM +0100, Lukasz Czechowski wrote:
> The Cypress HX3 hubs use different default PID value depending
> on the variant. Update compatibles list.
>=20
> Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3=
=2E0 family")
> Cc: stable@vger.kernel.org # 6.6
> Cc: stable@vger.kernel.org # Backport of the patch in this series fixing =
product ID in onboard_dev_id_table and onboard_dev_match in drivers/usb/mis=
c/onboard_usb_dev.{c,h} driver
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>  Documentation/devicetree/bindings/usb/cypress,hx3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Doc=
umentation/devicetree/bindings/usb/cypress,hx3.yaml
> index 1033b7a4b8f9..f0b93002bd02 100644
> --- a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
> +++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
> @@ -15,8 +15,14 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - usb4b4,6500
> +      - usb4b4,6502
> +      - usb4b4,6503
>        - usb4b4,6504
>        - usb4b4,6506
> +      - usb4b4,6507
> +      - usb4b4,6508
> +      - usb4b4,650a

All these devices seem to have the same match data, why is a fallback
not suitable?

> =20
>    reg: true
> =20
>=20
> --=20
> 2.43.0
>=20

--9k9ZnTZP7lApPE38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+RAMwAKCRB4tDGHoIJi
0tRpAQDNS6dW2CGP9zLlr+W7yJhcE2bWiGiO3BKrgWFrmthJsAEAs22eY1Eg/Hrt
9vPFW4oviBxxip0Da3nn9lOjzkpFSQM=
=9XYv
-----END PGP SIGNATURE-----

--9k9ZnTZP7lApPE38--

