Return-Path: <stable+bounces-152677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB793ADA32A
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 21:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB93AFC99
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0082C60;
	Sun, 15 Jun 2025 19:26:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3418C00
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750015579; cv=none; b=n50W3olNkLC+5++9Wff3Lrrq5KYNOmgTHcm90+3RLasKpuXsUim5SR8+QlK1eEUHCUz0xGiMzpJYJB2T9E2d3buK7uZH6oXty96AFUWjySLFiX23SOx3KUkpd06cRYV/3snTL1+vdiG0ZOMglu53IeSzmbTQw9R2K8SHhJ7s8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750015579; c=relaxed/simple;
	bh=96DVk5Pn7Df4EeS+mR3oWmxNriG3CFv6F9HZkqsnL+k=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=D/cFE414LtgBkrSczrc7Lyur+C6pdEbSgBF/G87jEcQ3FKTBhPWRGjeoMMfX2/D5bhM2Clkt7D1lrVw15kB8Munj6ABeNRajChTumMHFV9F2fmYKq8TCHjvd4HyG8EUi/ILcGRGwjTg+a9bNFUeosXE0vthEJ7Vm4QEz3yQ6RrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQszW-001obS-2X;
	Sun, 15 Jun 2025 19:26:06 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQszU-000000013TM-2DpK;
	Sun, 15 Jun 2025 21:26:04 +0200
Message-ID: <103664a92055a889a08cfc7bbe30084c6cb96eda.camel@decadent.org.uk>
Subject: [stable 6.12+] x86/pkeys: Simplify PKRU update in signal frame
From: Ben Hutchings <ben@decadent.org.uk>
To: stable <stable@vger.kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar
 <mingo@kernel.org>,  Larry Wei <larryw3i@yeah.net>, 1103397@bugs.debian.org
Date: Sun, 15 Jun 2025 21:25:57 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4XrHGKaN8de0ET6NRgmj"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-4XrHGKaN8de0ET6NRgmj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi stable maintainers,

Please apply commit d1e420772cd1 ("x86/pkeys: Simplify PKRU update in
signal frame") to the stable branches for 6.12 and later.

This fixes a regression introduced in 6.13 by commit ae6012d72fa6
("x86/pkeys: Ensure updated PKRU value is XRSTOR'd"), which was also
backported in 6.12.5.

Ben.

--=20
Ben Hutchings
73.46% of all statistics are made up.

--=-4XrHGKaN8de0ET6NRgmj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhPHkUACgkQ57/I7JWG
EQl39BAAt3fd7BLX9f2U5wkNKQfDDBO9vLuGiINv37P+eP9bKoLcJjXbkntVM0Ha
eqi4ytR1mgm7DZx9My1v1f/zpDXlKXWYzD/0Yyn8+HLuFZITID38YUqix+K0jh1/
C/cndKPdPkcyURgBeQJxnbDzrnNUbATZcE1Lk04uo/Fo0PRDxnSi9uzcbBIVTSjo
nMnbkCsKOyJz73W5IrewhcSZ1qt1rPF6T72kTIjAnF3ApSqGuR9Tu3AW7sznqSV7
dLnE8KMwMCAOxm1myzzARtiAi/VjktU6ydYF3foTd9XaCO7KSZ8I8mN1yt9Vw3Rt
9njmSIWQzPhqsZCZ2T8Mw+6h09KbFi/9DrQSBkxXtliZhEC9jrH9mbyT7V2zTmdm
p5o+lVUsjkmKAE7NJLxeUvgncVlRa/lsEpVl0E1XPOW0ZvQ76N+7Q0iCoVKVrX8s
yoJ2rirVQgQ1uOeoJq/hQvexLsJRYLsZiB8GDHIKmjiwkYvC2kWcQRswZvUzGMqu
GkF7bNJgJ/RFJ4q75u/mWFFETTSSCqUFzwOczux7pBW8D4zP4V5a0Zs0eTlB+XH4
9F6hJnVpKAanexyRK1i31+4lqMmAJVyYAHtgyR6UsVi6DiXoYUg8ZnDX82XmhIli
Zy9e3vY8U4S3+BaXjBokcTBqQeaTVHtBK97zVYadVNE5+62WPg0=
=HSr0
-----END PGP SIGNATURE-----

--=-4XrHGKaN8de0ET6NRgmj--

