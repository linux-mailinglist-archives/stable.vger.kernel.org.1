Return-Path: <stable+bounces-100158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D79E92EF
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A6718865BD
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E7227B91;
	Mon,  9 Dec 2024 11:53:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419922757D;
	Mon,  9 Dec 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745197; cv=none; b=Kx4j9RR6JNBhkqtYE10Zg2YGcvNa3hIjW75k8lr/nDq0MIP/Rj7ENpDR3VI+CBpksAfsAOak2V9QGOLL4VyDKg0B4YLBZFIVqbeP0NaqCwaYl6Y2yng/Bkp+ab0qvhkC4XazTBQQUQRfHlfbkMqJH6bwq6AbHzu7A1FrbZxEC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745197; c=relaxed/simple;
	bh=HMFoCHFlUxHuAAULmlbCXo8BxY9yulNK5Rex9pcPLFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4xEHqQuwKwZ1SnS5aWzl2eEGki6XcZ2c2aJu/6AyzlJrpN2qbSFACVKvrsSNnlhICgpheGpjtZQ6I2KgZBVt5hTcUOkumYVf8dBUTILElWFCIqEmgjsADLeK56hgcXUPiQxuoo4W6UlqI8l0o5qhrDUtyHUweidcS5rPDmK+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B090D1C00A0; Mon,  9 Dec 2024 12:43:24 +0100 (CET)
Date: Mon, 9 Dec 2024 12:43:24 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, uli@fpond.eu,
	jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 4.19.325
Message-ID: <Z1bX3HioMftPtien@duo.ucw.cz>
References: <2024120520-mashing-facing-6776@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mMxAulXiocCaVAwr"
Content-Disposition: inline
In-Reply-To: <2024120520-mashing-facing-6776@gregkh>


--mMxAulXiocCaVAwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm announcing the release of the 4.19.325 kernel.
>=20
> It's the last 4.19.y release, please move off to a newer kernel version.
> This one is finished, it is end-of-life as of right now.

We (as in CIP project) will keep this one maintained for few more
years, in a similar way we already maintain 4.4 tree.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/tree/linux-4.4.y-st?r=
ef_type=3Dheads

There are -st trees, which is simply continued maintainence of 4.4 and
4.19 stable trees. Plus we have -cip trees, which include that and
support for boards CIP project cares about. We'll also maintain -rt
variants of those trees.

More information is at

https://wiki.linuxfoundation.org/civilinfrastructureplatform/start

=2E

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mMxAulXiocCaVAwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1bX3AAKCRAw5/Bqldv6
8jF2AJ9/LfcdamjKuxS63PT+ct2vuNegOACeO2HRoVTi19PpS6wewwQuvzzoXLA=
=8ezi
-----END PGP SIGNATURE-----

--mMxAulXiocCaVAwr--

