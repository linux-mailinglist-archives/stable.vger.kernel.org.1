Return-Path: <stable+bounces-200074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB6CA56C1
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 22:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DECEB31DC808
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954D132E73E;
	Thu,  4 Dec 2025 20:55:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9D3271F3;
	Thu,  4 Dec 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881720; cv=none; b=pEaS0MpKLc7QWLUPUIDA+0B/r9XS2Hrt/GvS4iiUW7OWbaS0VtGfUIsB943o0GuM53/rQLsCzPHOmUFLcPK23oNPgz2Cjtn8qDRjg+sYECyy91e3y7U2oEbN/A/alSwJscA2z39XEH4VKIKZCi3WOOrbjkIYsbOdUPaUFkRRSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881720; c=relaxed/simple;
	bh=GEQHM14SaJhAAur3GE1kFbIfR3pP29zfn9NpZB9Rtgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dERBlsIhQ/7i3ozimOH4daZw7OFmZOd9iiPCbtEpoA3WCIiwE9gooRJK5r7WgkokrDtGeTKg56KcXYpRaNfib1VtNZn/OYjPpY03hjcW23WNES+IlGJkykOt2/Ru0bHxUgL9GPTYRjFe+FUAHIk1IaY+hoxsbkO8dTKMv5iOi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vRFym-006E05-2r;
	Thu, 04 Dec 2025 20:31:08 +0000
Received: from ben by deadeye with local (Exim 4.99)
	(envelope-from <ben@decadent.org.uk>)
	id 1vRFyl-000000002nT-3YVr;
	Thu, 04 Dec 2025 21:31:07 +0100
Message-ID: <aeb3a4d70bbd882d7930b25d17e464c0d2e01010.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 003/300] btrfs: always drop log root tree reference
 in btrfs_replay_log()
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
  Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>, David Sterba
	 <dsterba@suse.com>
Date: Thu, 04 Dec 2025 21:31:02 +0100
In-Reply-To: <20251203152400.584563083@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
	 <20251203152400.584563083@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-VaG03amT7jEQp2aQ6MHt"
User-Agent: Evolution 3.56.2-7 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-VaG03amT7jEQp2aQ6MHt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-12-03 at 16:23 +0100, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Filipe Manana <fdmanana@suse.com>
>=20
> [ Upstream commit 2f5b8095ea47b142c56c09755a8b1e14145a2d30 ]
>=20
> Currently we have this odd behaviour:
>=20
> 1) At btrfs_replay_log() we drop the reference of the log root tree if
>    the call to btrfs_recover_log_trees() failed;
>=20
> 2) But if the call to btrfs_recover_log_trees() did not fail, we don't
>    drop the reference in btrfs_replay_log() - we expect that
>    btrfs_recover_log_trees() does it in case it returns success.
>=20
> Let's simplify this and make btrfs_replay_log() always drop the reference
> on the log root tree, not only this simplifies code as it's what makes
> sense since it's btrfs_replay_log() who grabbed the reference in the firs=
t
> place.
[...]

This looks like cleanup rather than a bug fix, and I don't see any other
patches in the series that depend on it.

Ben.

--=20
Ben Hutchings
It is easier to change the specification to fit the program
than vice versa.

--=-VaG03amT7jEQp2aQ6MHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmkx74YACgkQ57/I7JWG
EQlRChAAt/I1Gv7+z47bAlfpg5epaxHM1sb3xa1KFylQR0ILePKV++CnTyivEDav
fJWPK6GbDDA/Y/zTK+cEINbmqp0qzCezmUZqrFumRh3JUXoWAln1JgYrhVrtztEr
OIm7y9gIsLTpBRNGBSTBzA1fxtAQ6EqJ3taf4myHNA+aE1JRGTfU4pyPAjukGWtk
ZvNraQ1S4F4vELWSSrfLLxK8yNifnTUr9DKiebq7TUY14nDEl1IRlsdHN89bpeH2
jdb8IjTKrkmlII6spAflG4QiF3pyjUTmD044oppB+vRo72ZN7h7itS2tupEA/SM/
7maBgFnWiwfuZptut+4++iFpIadjePpHFQmWT20vMwCq/F/ESvV9g6nYAmUMLFkm
IZWW6jpq4JwKwxxWlsYvVkOkMfUBUccIgYZlj99o2layL3gimlaA32ZoPY+J0Usu
0ueSVU9TOcelo9PCYeJHbimYeJTi3SMsk6RB/GHnjLrVNtycGoa34IynnAqUVrIc
UjGyV106cFtb4ycy2yrZJT3hpCDlbrah6EFaIfFlb3Xjg/JRay376cIS3N1pDOgB
2U2nqWg3IFlsVsiT5ZU3R2H4McpnP2pCXci3zaPmD0avt53c3Rl3eFki8ifJhk0m
YoUdopafRXAxIOODB16ZtTN7ppjpKhpr3zdqGOFQkVN8gn1Cvyw=
=cdX9
-----END PGP SIGNATURE-----

--=-VaG03amT7jEQp2aQ6MHt--

