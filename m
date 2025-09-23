Return-Path: <stable+bounces-181444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF19B94E75
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295C53B7781
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828FF2F547E;
	Tue, 23 Sep 2025 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txYkf+EB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275A2DEA79;
	Tue, 23 Sep 2025 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614598; cv=none; b=keAcMKZZMSvHTS0ZXN7GJIRIm2TaxnNBgIq+CQFoYioM+bwArh6JHVoZawbT6J/hW738y109UcUgCkq07VytnPyCNbFE7a/3Zng4H6LP3qRoeyHQt7nrXOhhJFucFtbrRoh/tI4k5Fju3AWxrDmn8RWgYhTSwMFHOd8Uyc4NJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614598; c=relaxed/simple;
	bh=D5uiey4471seattefoOzNwyH5jPWbq+Ym1dnz+bTheg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqa6dHiUaeedzOct3Lgg+2F1GtwVGvMH3wxYviz3Qq7kyLFoNmD4hlzVdqmQr3WMjdNuwf+Y5zBsgz2RMJSnKevcdZaYgJtWQsrJpbJdTUgg6yOL9Mkszs9Ge1/7kfN1H/h116aDXELwH7krH9RLKSQ/EwMNZfdI9zckh0U4HU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txYkf+EB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B300C4CEF5;
	Tue, 23 Sep 2025 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614597;
	bh=D5uiey4471seattefoOzNwyH5jPWbq+Ym1dnz+bTheg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txYkf+EBHpb+z/Ek9O1ldAU2o3rcJZel9hPFPiLbL7qMZF0GRoTvytX6clvt233YM
	 z4IovMoaWdeW2Ks+XDeOeLtlDTdyYzw7HDHb4ugBs2UMYMI0Jk7/koyMgaTkwmLsLk
	 ydnrl9Ye0dxfXNwC6QDzQLr1gStHZ2zjQuXI0A2kJpoS4SGlO1rNrSijKYABOu3+9C
	 unBg9wKsIyLgfSV0lO3qqGAr08wBVdEOwNuWFhflXdd6ay0GvAxjm74Qcb7JuF4HR1
	 rvLx4/duwX07qI5GKHXeuupRRTW09noeH71t/ce0R8EfOSo6bJ+NkuYpYcy/HfEMiD
	 5Hvt1xuVC+0BQ==
Date: Tue, 23 Sep 2025 10:03:12 +0200
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v?] ASoC: mediatek: mt8365: Add check for devm_kcalloc()
 in mt8365_afe_suspend()
Message-ID: <aNJUQE6VncYiRx_w@finisterre.sirena.org.uk>
References: <20250922140555.1776903-1-lgs201920130244@gmail.com>
 <638119fb-4587-48a4-9534-2f19a194ca4e@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+UPYTcPP9yAXiY1I"
Content-Disposition: inline
In-Reply-To: <638119fb-4587-48a4-9534-2f19a194ca4e@web.de>
X-Cookie: Filmed before a live audience.


--+UPYTcPP9yAXiY1I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 05:35:35PM +0200, Markus Elfring wrote:
> =E2=80=A6
> > Add a NULL check and bail out with -ENOMEM, making sure to disable the
> > main clock via the existing error path to keep clock state balanced.
>=20
> How do you think about to increase the application of scope-based resourc=
e management?

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--+UPYTcPP9yAXiY1I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjSVDsACgkQJNaLcl1U
h9CCEAf/QCnhzFI+vp9Z49NAqudJk3wDfrBz+Hv5nquQzGzv/kb6Yc1Fi72Cl+Iq
xEDVMpmBO5q1RUEK6oaDMPsrf9bHQ3pPPXEnUl4hbmeL+KNaUaYZEIio2c8bGBvd
lLdOZKp0KSN0yxXku0zJV5tjg6UnkGbaOldwJxFhACgUhxEbpnSsE+dNsvtGuYik
oCJtKZhTqE3aOz3lqXNYy6eVi/K0THqsqaBVwmkdwrexlxn02VZXnp9CpVl4CLqB
p9iK+FwyxIZ5UvH/kihITAP3klv9+SRjCiCxJNbaDdvV1YVZ+BP/yUUbbiiq62B8
hr36WqAph+oDt0grDiMkmKeHD5Dy5w==
=Pl39
-----END PGP SIGNATURE-----

--+UPYTcPP9yAXiY1I--

