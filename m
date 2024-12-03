Return-Path: <stable+bounces-98128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE229E2809
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35CD28B613
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FEA1F8AF9;
	Tue,  3 Dec 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJo1JZl2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A611F8927;
	Tue,  3 Dec 2024 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244584; cv=none; b=Tc8jlGPFlbHdpOSJoAhsiS49d8lHEgv7UmpiYnpXUl3hKRdYD03kMXUPedrsYHCrEm595gsK3CK4tAPqBZGNvWayS/tTPHnh2rs5bqFhBVnxk4NUYTh4EhI/qEO9IaLM8Q3/bpJLd24OXP2izlpCibjnFyU7hY+gLChpL9m1D4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244584; c=relaxed/simple;
	bh=1NqLuuLFwHm0v/yK7wKaDo26NhV34tP1XmqEcIsx8to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD9h7UD6u/SVh1n6rpkx+dx7F84ixxARhF848GzDZt4rxj2yHo0wy27BNgliFOsfF2YqBWHAGxsGzuSGfKkzzHsGvccGM0g4XQ/H7xzPG0xINDUYgU3YJtxauA6cGStuoTSvFyNvTlIvGBvwn3Q5r/PVZgEQ9Htlyay+hwPHMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJo1JZl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CEBC4CECF;
	Tue,  3 Dec 2024 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733244583;
	bh=1NqLuuLFwHm0v/yK7wKaDo26NhV34tP1XmqEcIsx8to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJo1JZl25KEUEqfUZcLBB/tMBA0DqTkqNW9sWubx4kv7Y3pfx/lt5a+4iT+XQL0W5
	 Txc43BClWHT6BKKuL7HBYTCMYPXmMS7V/t6cmHshp7VtgQnN9cAbB0LHUZCswVGJdc
	 DKHlIUuRyXVLaOQJbpL0q6rHr6D89fQVmdPLC61hw3lsn1M1x4dlSb+hV5S6sxRry3
	 dSuHczvq1DBSm+SCu7n4Y6K0QiEcqdGQo5ECPrRLkbwAiPNPYrO0tVEOabwTXRvjEs
	 3C1LyxcAoye0/25Q7rKK6tt5+i3LvrKa24QHpz300wIipXPYveiVEftvQvo6EzBScm
	 u870mSPB8nrlg==
Date: Tue, 3 Dec 2024 16:49:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: fsl: cpm_qe: Limit matching to nodes
 with "fsl,qe"
Message-ID: <20241203-egotistic-certainly-116f38bd39b6@spud>
References: <20241202045757.39244-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5+M0C7v+8zXCbXJ/"
Content-Disposition: inline
In-Reply-To: <20241202045757.39244-1-wenst@chromium.org>


--5+M0C7v+8zXCbXJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 12:57:55PM +0800, Chen-Yu Tsai wrote:
> Otherwise the binding matches against random nodes with "simple-bus"
> giving out all kinds of invalid warnings:
>=20
>     $ make CHECK_DTBS=3Dy mediatek/mt8188-evb.dtb
>       SYNC    include/config/auto.conf.cmd
>       UPD     include/config/kernel.release
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       DTC [C] arch/arm64/boot/dts/mediatek/mt8188-evb.dtb
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible:0: 'fsl,=
qe' was expected
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe=
=2Eyaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible: ['simpl=
e-bus'] is too short
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe=
=2Eyaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controlle=
r@c000000:compatible:0: 'fsl,qe-ic' was expected
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe=
=2Eyaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controlle=
r@c000000:reg: [[0, 201326592, 0, 262144], [0, 201588736, 0, 2097152]] is t=
oo long
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe=
=2Eyaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controlle=
r@c000000:#interrupt-cells:0:0: 1 was expected
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe=
=2Eyaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controlle=
r@c000000: '#redistributor-regions', 'ppi-partitions' do not match any of t=
he regexes: 'pinctrl-[0-9]+'
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe=
=2Eyaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'reg' is a required=
 property
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe=
=2Eyaml#
>     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'bus-frequency' is =
a required property
> 	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe=
=2Eyaml#

I'm curious why this is only coming up now, Rob applied this apparently
in July.

>=20
> Fixes: ecbfc6ff94a2 ("dt-bindings: soc: fsl: cpm_qe: convert to yaml form=
at")
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml=
 b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> index 89cdf5e1d0a8..9e07a2c4d05b 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> @@ -21,6 +21,14 @@ description: |
>    The description below applies to the qe of MPC8360 and
>    more nodes and properties would be extended in the future.
> =20
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: fsl,qe
> +  required:
> +    - compatible
> +
>  properties:
>    compatible:
>      items:
> --=20
> 2.47.0.338.g60cca15819-goog
>=20

--5+M0C7v+8zXCbXJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ082owAKCRB4tDGHoIJi
0s0HAQDAWUaDFTMODECrGoMpk/JQ6X3sb4Uok6Yl2lbO7EaJUwEAkJy4Xvisf0FS
fWsESM6zpR0CkagNmMJ9ezdGDBwYAAE=
=ZvIG
-----END PGP SIGNATURE-----

--5+M0C7v+8zXCbXJ/--

