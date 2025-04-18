Return-Path: <stable+bounces-134635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28066A93B9F
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC913B910C
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639A2165EC;
	Fri, 18 Apr 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XBuFwKOt"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1E4CB5B;
	Fri, 18 Apr 2025 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995857; cv=none; b=pOfUgiIEHs19K8gUZZ7y4VX5k48lgmfTptIkwlut4mNe8J/gWCIQyZsMtrJUOL26Fa4mVY3obiHRbMwFdvt9Os9q7k8b6cx7Ru559Dx706MpJ7MzYg/DYqvKz5n8bPebR4wxn/7+choK+PKWD/EQRxG8f984+NZiXYocwzPpJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995857; c=relaxed/simple;
	bh=36FfVh550f4pi9AMieTF+KKoyEqse6YXhakPyRxFQqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv2FH+eONVvcyzv18f0gVI4oRaXNldy2jqPHoravAoOXG+yiRFMgh9nQedj2r54dYF7roIay3fSgSDrq1y1qBRZP3xC75Cc9MJsFD0KUwOEwKhXieB1VxusQ05NJqyGH/WPeKF9P61nVU7w7LyB/ZwmZG2J3Vo8pxFXmVsN3GKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XBuFwKOt; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4A6410273DBF;
	Fri, 18 Apr 2025 19:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744995854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hYbGBShskCwfKxd6E/88E+mo7hPZ9ODOyFnjuvRof78=;
	b=XBuFwKOtM5b1KM663P1iJU5BapOjeTUlUxyrdbartIh7ic+iAo8bRugKVl6dceiPGHnTHs
	TulwaMRfsmo3ryR6m1am+tksFl7+VlYFP85Tu/CyzRF6tpAopX7pkjl5XkF/wPldopSttA
	J8gItMnICEcMoZUP0jgWTwcpKSv39qXR/VRtOZzEWm9y+InOnvj3U0j6ixIRLt71W+b+hy
	AiLCdGdcLTAlZf7NsziESN2MFFc4jDQYq5qj9um/XetQMtkc11OLNtLv23CC083Byo4LTC
	s1QGwZpuHKvEnJSpuD36lUKi9J79hWpvhPJSOJvj4kdSGuabXrFFbxrY3+1QoA==
Date: Fri, 18 Apr 2025 19:04:09 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 26/26] Bluetooth: qca: simplify WCN399x NVM
 loading
Message-ID: <aAKGCb+rzIWJjMBb@duo.ucw.cz>
References: <20250403190745.2677620-1-sashal@kernel.org>
 <20250403190745.2677620-26-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8cxg9z79d2x7/RC+"
Content-Disposition: inline
In-Reply-To: <20250403190745.2677620-26-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--8cxg9z79d2x7/RC+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The WCN399x code has two separate cases for loading the NVM data. In
> preparation to adding support for WCN3950, which also requires similar
> quirk, split the "variant" to be specified explicitly and merge two
> snprintfs into a single one.

This is a cleanup, so we should not need it in -stable.

Best reagrds,
								Pavel
							=09
> +++ b/drivers/bluetooth/btqca.c
> @@ -807,6 +807,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baud=
rate,
>  		   const char *firmware_name)
>  {
>  	struct qca_fw_config config =3D {};
> +	const char *variant =3D "";
>  	int err;
>  	u8 rom_ver =3D 0;
>  	u32 soc_ver;
> @@ -901,13 +902,11 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t ba=
udrate,
>  		case QCA_WCN3990:
>  		case QCA_WCN3991:
>  		case QCA_WCN3998:
> -			if (le32_to_cpu(ver.soc_id) =3D=3D QCA_WCN3991_SOC_ID) {
> -				snprintf(config.fwname, sizeof(config.fwname),
> -					 "qca/crnv%02xu.bin", rom_ver);
> -			} else {
> -				snprintf(config.fwname, sizeof(config.fwname),
> -					 "qca/crnv%02x.bin", rom_ver);
> -			}
> +			if (le32_to_cpu(ver.soc_id) =3D=3D QCA_WCN3991_SOC_ID)
> +				variant =3D "u";
> +
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/crnv%02x%s.bin", rom_ver, variant);
>  			break;
>  		case QCA_WCN3988:
>  			snprintf(config.fwname, sizeof(config.fwname),

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8cxg9z79d2x7/RC+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAKGCQAKCRAw5/Bqldv6
8gOJAJ4ym+QKbXxlQjaBeGlhwjbRIvdZQgCdFSeaCXoXjxRhox9r39yxRQs4b0E=
=ih9a
-----END PGP SIGNATURE-----

--8cxg9z79d2x7/RC+--

