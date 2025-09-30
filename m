Return-Path: <stable+bounces-182842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA716BADF12
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6D21C8245
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A33081C0;
	Tue, 30 Sep 2025 15:41:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274D308F2E
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246864; cv=none; b=j+6mag9dZnx9y820dxTFRHu+z7hP/+iD/CfAgL11c2r+7WEM2pwfVDVfeB//OoFMxK3U4BOJipcNmvGLKUBMwNjdFdXXBW3Jk/vhrcNRJ11D7e7f1MRtCTBHDXqqs7vjViKOevvpo9IC9z+wG2dTiqzyMa41J7FVrdtR/FLvx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246864; c=relaxed/simple;
	bh=LabcR7YF5ECsGRiXgerHKl3LKlbLePSylAl5VBiL0y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5p06Cl1KwhTtkVuZkiv93ewN3GESaAv/uS4rvx1b1pte1BEb+ESyij9Bpi1qkCDhrNNEBQaBW+xxORvTvEJU+bO7GcmeHkHJoLlYu6nQM14lxL+amieFgaF3szpI/OLk40BmybdZw3yOGJndhGlv48n6PgLeEse1wmhGyZ+3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3cT8-0004hF-Kd; Tue, 30 Sep 2025 17:40:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3cT6-001Gr0-2z;
	Tue, 30 Sep 2025 17:40:44 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9CCF947D522;
	Tue, 30 Sep 2025 15:40:44 +0000 (UTC)
Date: Tue, 30 Sep 2025 17:40:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Maximilian Schneider <max@schneidersoft.net>, Henrik Brix Andersen <henrik@brixandersen.dk>, 
	Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Runcheng Lu <runcheng.lu@hpmicro.com>, stable@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v5] net/can/gs_usb: increase max interface to U8_MAX
Message-ID: <20250930-translucent-tested-sheep-347fb2-mkl@pengutronix.de>
References: <20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vpd4l2s3wnfawl53"
Content-Disposition: inline
In-Reply-To: <20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--vpd4l2s3wnfawl53
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] net/can/gs_usb: increase max interface to U8_MAX
MIME-Version: 1.0

On 30.09.2025 19:34:28, Celeste Liu wrote:
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 interfaces device to
> test so they write 3 here and wait for future change.
>=20
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel index type in gs_host_frame is u8, just
> make canch[] become a flexible array with a u8 index, so it naturally
> constraint by U8_MAX and avoid statically allocate 256 pointer for
> every gs_usb device.
>=20
> [1]: https://github.com/cherry-embedded/HSCanT-hardware
>=20
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devic=
es")
> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vpd4l2s3wnfawl53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjb+fkACgkQDHRl3/mQ
kZw3rgf8Ds99h2c+Gxkp6eFeXpgydDTPs+fsnZrndfaKnk1smRJAsvhb8pziyMlM
MFJyl1DjEkz9SJrbgDZLmu0iPkcgBdmIrdT0yn7cMmiVHBQWwTRsWsWm/lLKO68A
xMftNo6VkjWokey7tLqVwDqjfpYkV1XmQ4FlbMqeqOOLRPGScI9N7x70fUK7I5Y0
qDZPJ5cViDGL3eEIdHt1YZa5dtvVG0umFdH4Yv8snNHJPyxwVOF9Q/ewe3VjC2FF
hnu7HAiaGxSnMj31AIKIV4++OhnakLssMTTCKJAesy0mDbxl+BkPy3SdDzFEdnRe
Jxwct12vgpSVV6C4JDHKae9YHMmAxw==
=JDxv
-----END PGP SIGNATURE-----

--vpd4l2s3wnfawl53--

