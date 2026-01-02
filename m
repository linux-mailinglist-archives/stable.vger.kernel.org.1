Return-Path: <stable+bounces-204505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D8DCEF4BB
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F290B3019898
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAABD2C2343;
	Fri,  2 Jan 2026 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="aPqhpcYz"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62732459C6;
	Fri,  2 Jan 2026 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385134; cv=none; b=fyojiCqx/JlEaqdntEf3+/BPIp/4qBVyFku9VptlsWxyz8diqSZtB+pWobUunWqu6jlmenlsygzYc5o447uEtwc3iP6iK7YmmbLk9QUtdYH6gHVzNV0DRj9Dvl5VEKK9s5g7mjaHWunSeBAcqhalz7NzyzI8UrlPbQe30d2wAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385134; c=relaxed/simple;
	bh=+agCO8qgZzoCTvxk+09fXoc+5YuFE6U+k7GKWMlCFsk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFe3SDlKHL3fYdV6/du3APPYJ4hGW0rUjAkjtvJWsTStUr/9vUgcGvkdj9MlgbAU+vU1SzaTC/sXGOvTMb6kSWGCdBT0eqg+NTvQsQCWAXEp1kSG2HHVbgXClk3yLpm8lXNkXak8G7tSGdHkaT+4RQiLQ9/gGQnaH9wMFkk6XIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aPqhpcYz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QRmCVPeP+RIEBMuUcBbI7kHMTrc6nq0oB8Cnpy0O4B8=; b=aPqhpcYzztDJKxwcg3YQlMqpo6
	vK9a2edoBrl7cVNq8xCxQkas8x+azHFteFeqnv8pxJdPq1UlhCVebzsuJzFRlqz+nH86g1OHUG/Ay
	zMVVkrxdtwb6oDve6WocaiPqEXqQPudX1mzkViAaCyMAmUpBqQj0RdYZtPqiZtU7QmGmDLDiU++cL
	OG3eZ7eRi8zPjXhNymG9887x9uhU4z3XJJ165S7vY4VdwhE4eJBkYAYXGnMIt4erdk/KcAwbsxEZF
	w4KteSo5qRGYgWow1eqzJ7n2HcFhSo2VVlxkqeTB5SRTJmvsWQQPgN+YHmP3LBlqXwNJMcK3tUbL/
	gaxHsCfw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <benh@debian.org>)
	id 1vblbU-00Eir4-JI; Fri, 02 Jan 2026 20:18:32 +0000
Message-ID: <27c249d80c346a258cfbf32f1d131ad4fe64e77c.camel@debian.org>
Subject: Re: [regression 5.10.y] Libvirt can no longer delete macvtap
 devices after backport of a6cec0bcd342 ("net: rtnetlink: add bulk delete
 support flag") to 5.10.y series (Debian 11)
From: Ben Hutchings <benh@debian.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Roland Schwarzkopf	
 <rschwarzkopf@mathematik.uni-marburg.de>, Nikolay Aleksandrov	
 <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, "David S. Miller"	
 <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, 
	debian-kernel@lists.debian.org, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev, 1124549@bugs.debian.org
Date: Fri, 02 Jan 2026 21:18:26 +0100
In-Reply-To: <d4b4a22e-c0cb-4e1f-8125-11e7a4f44562@leemhuis.info>
References: <0b06eb09-b1a9-41f9-8655-67397be72b22@mathematik.uni-marburg.de>
	 <aUMEVm1vb7bdhlcK@eldamar.lan>
	 <e8bcfe99-5522-4430-9826-ed013f529403@mathematik.uni-marburg.de>
	 <176608738558.457059.16166844651150713799@eldamar.lan>
	 <d4b4a22e-c0cb-4e1f-8125-11e7a4f44562@leemhuis.info>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-OII6/htffjAg1Djg2KhL"
User-Agent: Evolution 3.56.2-7 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh


--=-OII6/htffjAg1Djg2KhL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 2025-12-19 at 10:19 +0100, Thorsten Leemhuis wrote:
> On 12/18/25 20:50, Salvatore Bonaccorso wrote:
> >=20
> > Is there soemthing missing?
> >=20
> > Roland I think it would be helpful if you can test as well more recent
> > stable series versions to confirm if the issue is present there as
> > well or not, which might indicate a 5.10.y specific backporting
> > problem.
>=20
> FWIW, it (as usual) would be very important to know if this happens with
> mainline as well, as that determines if it's a general problem or a
> backporting problem
[...]

The bug is this:

- libvirtd wrongly used to use NLM_F_CREATE (0x400) and NLM_F_EXCL
  (0x200) flags on an RTM_DELLINK operation.  These flags are only
  semantically valid for NEW-type operations.

- rtnetlink is rather lax about checking the flags on operations, so
  these unsupported flags had no effect.

- rtnetlink can now support NLM_F_BULK (0x200) on some DEL-type
  operations.  If the flag is used but is not valid for the specific
  operation then the operation now fails with EOPNOTSUPP.  Since
  NLM_F_EXCL =3D=3D NLM_F_BULK and RTM_DELLINK does not support bulk
  operations, libvirtd now hits this error case.

I have not tested with mainline, but in principle the same issue should
occur with any other kernel version that has commit=C2=A0a6cec0bcd342 "net:
rtnetlink: add bulk delete support flag" together with an older version
of libvirt.

This was fixed in libvirt commit 1334002340b, which appears to have gone
into version 7.1.0, but Debian 11 "bullseye" has 7.0.0.

We can certainly fix the libvirt side of this in Debian, but this also
sounds like a case where the kernel should work around known buggy user-
space.  On the other hand, this has been upstream for over 3 years so
maybe it doesn't make sense now.

Please let me know whether I (or anyone) should try to implement a
workaround for this in the kernel.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-OII6/htffjAg1Djg2KhL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmlYKBIACgkQ57/I7JWG
EQnD0A//T7s2mc8lgDzrecnjiCAaxAAnYMYUy/UhgiuFea9wFuXqo76ucc0paWs7
YmvABwnDSiyl9lq4WfN5CGTmai+arF4PMLQLlmRXslato+22hVK/731P62DfzW+6
Mx5pPyDGaVAkFQHe/hOku64F9/NHbC3ZptPXVoxLeQDTTkTPP+y7G7mxZJUp/KOu
YsnMQdDvnqiZsjSyEddi+HDast2K7bxm+iDZ8qJm8crzYux4kXeRo1b+Pug72f1k
XErFYPSw8DtQw1OOdxRtP2id4dMhLaXzkde8VFky6jowAFLk3dwV0YwsYm9OAkEQ
8pdQ+7C/JTKznJFeJQjVz5P9TDevqDK+v4PkGPia+KSQN1rcxVRHX9h7Ci5ongk3
l3gTy4U8nz4Mw+ap0qWAmgidfkqcL2Kp/GY0ck8uPXUjtPYWE288KOtMK/z+R8vk
B7KcU4YmIvqxEAVMPARatHO4ElUhdzNhj0+vRlr00zHumWZb+Cu6Sk5QC9aTCUVJ
gNi/tveeZwcbKWpnyaUr7CdLwgLVXhi7k6KDw+UCMWYrOqMiLsjgFa9QMHqK9bKG
FETqDyYvkGnU0Yb4itsE5hTkh9pqNTp3nkIxn0YI7RUF8kYEstV4DW3jjMVjIMad
PLiW1gtAOxADHaHuFlqcpbCI1SRsS56ID5r0dgZPjaNoUmbJVR0=
=AH7O
-----END PGP SIGNATURE-----

--=-OII6/htffjAg1Djg2KhL--

