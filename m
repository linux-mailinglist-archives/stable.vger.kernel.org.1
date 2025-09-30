Return-Path: <stable+bounces-182051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D051BBABF8E
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 10:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA25617419C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A89C27A114;
	Tue, 30 Sep 2025 08:14:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AA2F39B4
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220048; cv=none; b=i+pLoom9YU2UtxB3nwKWzwtVb5bd6lb2ScSbrUX7gwI4Ww490iTkmQkNws3D6DJWaWU33z71ck5EHncgTW8+95H6QyhCI+EUf81KiY5lr2eezUrLEHFI5y6Ij+MSwhPLdpUNyRuHlD/zfOkq1k8YN1M51C5PXxHk2fai8NMQ040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220048; c=relaxed/simple;
	bh=MYRwQfM/D/QD/qI8NUujoMHGFl+avNWViKueqXxVRVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ6bQsijuDYNibEGAmVLb5oNhrVpt7ZwkU6PABMI3UJjdeO5cyezBsiF5Vv/Cmz4WJ1bFjr5021P3qWWb7uUEalS+OgtnYUJWH40v1LdkasGLnvZSQhqt79rnYhyJXb7TxDmdwyk2oJFqzqm3l4ObXtWvHgstD9TeiC14c0PCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3VUb-0005bN-0h; Tue, 30 Sep 2025 10:13:49 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3VUY-001DPb-2q;
	Tue, 30 Sep 2025 10:13:46 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8267147CF25;
	Tue, 30 Sep 2025 08:13:46 +0000 (UTC)
Date: Tue, 30 Sep 2025 10:13:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Maximilian Schneider <max@schneidersoft.net>, Henrik Brix Andersen <henrik@brixandersen.dk>, 
	Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Runcheng Lu <runcheng.lu@hpmicro.com>, stable@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v4] net/can/gs_usb: increase max interface to U8_MAX
Message-ID: <20250930-fancy-dodo-of-chemistry-c92515-mkl@pengutronix.de>
References: <20250930-gs-usb-max-if-v4-1-8e163eb583da@coelacanthus.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cykog7jsflt7oxgg"
Content-Disposition: inline
In-Reply-To: <20250930-gs-usb-max-if-v4-1-8e163eb583da@coelacanthus.name>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--cykog7jsflt7oxgg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] net/can/gs_usb: increase max interface to U8_MAX
MIME-Version: 1.0

On 30.09.2025 14:15:47, Celeste Liu wrote:
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 interfaces device to
> test so they write 3 here and wait for future change.
>=20
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel type in gs_host_frame is u8, just
> increase interface number limit to max size of u8 safely.

I really like the new approach you've implemented in this patch, but now
the patch description doesn't match anymore.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cykog7jsflt7oxgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjbkTYACgkQDHRl3/mQ
kZxM2gf/VJUd6lg/E6w2BHLpJ3OHVsxwevaCo6cnUzxANlAkl42PXyY+a4ZEsqlT
uC0KyV/QlIy96Mwp5ZYN3Tel7EKKHl2bQc1dfgFu+xHdMrTsbsXHPle/oPpR0OVB
UrpFTZ+8+5wByk2Glio76aiw8Z82qguYf12mT5MtGs1AwqYmn3xXBBdQY2oUUzik
mpoQGAk2aLcNDdRFv1jDaGIQygRDbFBbTzWz63ytIMScu+DcfcHTjkLGujv6TFnA
qxEeqDt6EkMnlQWSUIu/ErjnCn2AUVasdCWbHl6ZVaz/BdQtZyNNt028D3N0Dk37
WRLHGKoCqGEXZ8EycYL95j431NKbyQ==
=racr
-----END PGP SIGNATURE-----

--cykog7jsflt7oxgg--

