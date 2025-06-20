Return-Path: <stable+bounces-155114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D330FAE198B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EECB3B2BDF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95D289E1C;
	Fri, 20 Jun 2025 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZlyTbrFp"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F728A703
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417403; cv=none; b=puA7Ee4UfnEjr+sdT8w75pwY3aZVqCV40QoqN04TLYy+/RmzgN2QrFhKWByPBXueCxL5fy4di4SsQ6nwPTPaU36aG5amy93wWeWjMr+fI1v3UyGMmejKDV2UoeIBh81NtryLvhXRTGXNdjNXRt8jyCqgnKf4jao4+AmgseKVurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417403; c=relaxed/simple;
	bh=ow9pmBGoOWDd2bUZiXrTq/Ixw5bb6fPeBsL557mCQ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLJ4WSltWHP1W5uF/o3wSNYAGDwzlDl1ks9vHw4Dopt8owQW5NqlGlQhqRyR6VvBwC9PVw59FC8G4PuL4tpt5qn+ZJ/L3gFudM/WHvXotRwbFrdjJMeOgrb3L9CP2tNQTXNQw7fI2wpbPtRz97bM/vgW1ynbQW/162WIavKX7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZlyTbrFp; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41B12104884A8;
	Fri, 20 Jun 2025 13:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750417398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=H83VpY+EaGjGzuA1F89Ga9UMsJ8CojiDiLGi6caqOcE=;
	b=ZlyTbrFpJRrGIz2kyL0yPAZ4hZq/ok5wtMU192PehHzlp+L07729xYQkssjsL3lDUGIWNG
	MNdte9I2gsKM9HKj2mVTYUD70QKYwHZ744gRG9l+5AWEzXCb79b51qKL8qgTtjdHzNRUHJ
	5OCseZ1VGgGNqppf6i4i7CuaSur5jSK+JKjKn2UV4YjPtHKAdqk4W1z0DI/h97MLYL/OZ7
	Lu8LEbon3KiBywXfzsqxXmP9NbH5DjO2SKpWJ0Zfslx0AF+0QsWkhMiXV4H+rCKQOfFipr
	GmclK6YpcGZi0gbXndidxcyqeJucnL/Zj4g035inpLQ9pEebT1ar/rXsF05n6w==
Date: Fri, 20 Jun 2025 13:03:14 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 417/512] serial: sh-sci: Move runtime PM enable to
 sci_probe_single()
Message-ID: <aFU/8ioRP6x1LqTk@duo.ucw.cz>
References: <20250617152419.512865572@linuxfoundation.org>
 <20250617152436.474113766@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IIaTlm/Ug1U37WZl"
Content-Disposition: inline
In-Reply-To: <20250617152436.474113766@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--IIaTlm/Ug1U37WZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> [ Upstream commit 239f11209e5f282e16f5241b99256e25dd0614b6 ]
>=20
> Relocate the runtime PM enable operation to sci_probe_single(). This chan=
ge
> prepares the codebase for upcoming fixes.

Preparation. We don't need it in -stable.

BR,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IIaTlm/Ug1U37WZl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFU/8gAKCRAw5/Bqldv6
8s2rAJ9x2zF36xxZGy3bmbATSUfjyiQsswCbBDKyzvZGXOvg7cWivAvIUXjxEhg=
=EPG+
-----END PGP SIGNATURE-----

--IIaTlm/Ug1U37WZl--

