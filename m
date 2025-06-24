Return-Path: <stable+bounces-158462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A5EAE7243
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 00:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D69A179134
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 22:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28728256C8D;
	Tue, 24 Jun 2025 22:26:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5D3074AE
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750803988; cv=none; b=RRA5q5FUYpvCN2OF+EPNrDPFZX/UBWLvx3nCz4EXQiCYTZC+YLiFhljw/oYnsePGBb4BUrOBeCAmhz3QNTaTjzouiFC2itdeOy+lvzX/T5/x8YCM9jR1YXsjPZzAGEzQJxpkWq372AGoFNyCdIsZ6qZHGhLG7+o5yiV+FxpcuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750803988; c=relaxed/simple;
	bh=MeDzIh5GkNPFeln1unPaj6YAAPet9ycl5IHJEY4pvjY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lv+p4zM+pmDFZmr/Uu5439b76YYDzrRdXWyzkd5Wevw2ojjDgYikcjbHWospBkxMtMANrTwLt/b8qHACbE6i22fsbVFQQtIO6qr1ZPWhivvBpCwiTuJiE3jtQo4BXDFELKQpLufQe/NXWI81GTERlUIPJwsCyNsUfpBWYcSWocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uUC5w-003DFm-2b;
	Tue, 24 Jun 2025 22:26:24 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uUC5v-00000003CY8-0gAM;
	Wed, 25 Jun 2025 00:26:23 +0200
Message-ID: <38359c8a4f1edce6a44ea55f9f946b4adb39e92f.camel@decadent.org.uk>
Subject: Re: [stable 6.12+] x86/pkeys: Simplify PKRU update in signal frame
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, "Chang S. Bae"
 <chang.seok.bae@intel.com>,  Ingo Molnar <mingo@kernel.org>, Larry Wei
 <larryw3i@yeah.net>, 1103397@bugs.debian.org
Date: Wed, 25 Jun 2025 00:26:17 +0200
In-Reply-To: <2025062025-requisite-calcium-ebfa@gregkh>
References: <103664a92055a889a08cfc7bbe30084c6cb96eda.camel@decadent.org.uk>
	 <2025062022-upchuck-headless-0475@gregkh>
	 <2025062025-requisite-calcium-ebfa@gregkh>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-5WEddUScVRsef1rqd7gJ"
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


--=-5WEddUScVRsef1rqd7gJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-06-20 at 18:11 +0200, Greg KH wrote:
> On Fri, Jun 20, 2025 at 05:56:29PM +0200, Greg KH wrote:
> > On Sun, Jun 15, 2025 at 09:25:57PM +0200, Ben Hutchings wrote:
> > > Hi stable maintainers,
> > >=20
> > > Please apply commit d1e420772cd1 ("x86/pkeys: Simplify PKRU update in
> > > signal frame") to the stable branches for 6.12 and later.
> > >=20
> > > This fixes a regression introduced in 6.13 by commit ae6012d72fa6
> > > ("x86/pkeys: Ensure updated PKRU value is XRSTOR'd"), which was also
> > > backported in 6.12.5.
> >=20
> > Now queued up, thanks.
>=20
> Nope, this broke the build on 6.12.y and 6.15.y, so now dropped.  How
> did you test this?

Sorry, I forgot to say this depends on the preceding commit 64e54461ab6e
("x86/fpu: Refactor xfeature bitmask update code for sigframe XSAVE").

Ben.

--=20
Ben Hutchings
The most exhausting thing in life is being insincere.
                                                 - Anne Morrow Lindberg

--=-5WEddUScVRsef1rqd7gJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhbJgoACgkQ57/I7JWG
EQmSTA//UogBe1OcAvtahfsWKZ6/BFYx02oSX5Z+TIPuOETuy66vnj1TkCYlL4fg
dqAojUQL7100V6RL7L7tXQ+FqzUv13g87i11En4/W39DzJvT6SWke/ZQIc/u/FaJ
tvr1txKNAg06zoa3XHuo0fYh/4+YjlzRmqR5lC3dfmH9vU5lBOlE1CZXJ1ASxhkf
QuDNWWHkeMIjY6J8cqEjvilJbjK1bzTDjiiZJhK9GwXxRZRl5qybeLbrK4AuP90J
I1YxJJWyOkHcpm4DyA59uUHEi6V5aLI2I2bpMoaZgzJp10ENpqShYIbuCCd8uoXo
mPvliWUgzajEw7UUlQ9RisL6FBwXKzlSpnDsyfF/1pEIkDeDFR0wtQ41SLOoaHkN
hW6/BY0FFtTRc0A647FkYPiJKz3uTeaShjoB9sk6H3Rpm+QLhQWDIYogUxcAnMnH
I4rINE5HVT8LGZ0VJ7a4xq08gb4rlR6AzUGkDGMdHm7CkyoGhkUG2SxROqcsEqK9
OFxGAwbq/vVCRqa9djXg+M+cvZn0wsbyA1h55hoMiUD4A4NFoB/yowS9q9XQaBKG
igf/Fhs9xh9WpQu+P2nbHRZP4MWZ2HgB9S4O+VMGByAtpwKhidCket3UzBAtNx8A
h2MVeGM1Ha/HhPSUywZrGelSqZlgy4Nbk6/QGmFh+1qoBN3Y6mU=
=y51a
-----END PGP SIGNATURE-----

--=-5WEddUScVRsef1rqd7gJ--

