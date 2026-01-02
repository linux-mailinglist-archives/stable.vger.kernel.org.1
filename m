Return-Path: <stable+bounces-204495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E97CEF045
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 18:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2455D30133B6
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBFA52F88;
	Fri,  2 Jan 2026 17:01:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F964C6C
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767373296; cv=none; b=SP0EGq4GIXx8HA6BN1/oUG3qw8+CrzluujFAErXtZtI5Q2N+ludrvcFmy/2q/Ei385Qc1GufyfJjhuKu9A11jcaEa+60tNaDCJZaiiIAT6212fWsIjQlUzm2igr/a6aRsEFh1L8uuF0I9OBymhnfqlUcVM1GATk8ZSmk9qLtgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767373296; c=relaxed/simple;
	bh=0yNbvWagi42fUfGIGOGnq+D2D1aojEC+2y1fyp3Bw08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UjgqNeRAs7XOzDXeQJXDDe//JK/FTWRYQQKUvAxXF8MEPFbYk7PV5wcsiMLS/LO0PME40sHOCGX4HBJSgl9TVKM7s7TZDaJU6JPkq9yeX2//0/I9ftLWFZFj/Lr19fQ/9VqrjaiMDvHJW/RYZkz8Wr9Udd7PRZvtDC84924JZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vbhyx-0040nr-0Z;
	Fri, 02 Jan 2026 16:26:30 +0000
Received: from ben by deadeye with local (Exim 4.99)
	(envelope-from <ben@decadent.org.uk>)
	id 1vbhyv-00000003Ypl-0Xjd;
	Fri, 02 Jan 2026 17:26:29 +0100
Message-ID: <c5a27a57597c78553bf121d09a1b45ed86dc02a8.camel@decadent.org.uk>
Subject: [5.10] regression: virtual consoles 2-12 unusable
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	 <sashal@kernel.org>
Cc: Thorsten Glaser <tg@mirbsd.de>, Helge Deller <deller@kernel.org>, Junjie
 Cao <junjie.cao@intel.com>, Gianluca Renzi <gianlucarenzi@eurek.it>, 
 =?ISO-8859-1?Q?Camale=F3n?=
	 <noelamac@gmail.com>, William Burrow <wbkernel@gmail.com>, 
	1123750@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>, stable
	 <stable@vger.kernel.org>
Date: Fri, 02 Jan 2026 17:26:22 +0100
In-Reply-To: <CAN2UaigCW-BZTifuo-ADCw=uDq85A_KwOHcceyaXDnVo8OQZiQ@mail.gmail.com>
References: <aUeSb_SicXsVpmHn@eldamar.lan>
	 <176626831842.2137.9290349746475307418.reportbug@x61p.mirbsd.org>
	 <Pine.BSM.4.64L.2512211617050.3154@herc.mirbsd.org>
	 <aU68arLtS1_wZiMj@eldamar.lan>
	 <176626831842.2137.9290349746475307418.reportbug@x61p.mirbsd.org>
	 <CAN2UaigCW-BZTifuo-ADCw=uDq85A_KwOHcceyaXDnVo8OQZiQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-XU2CWv3Ah+1yx/3EAEuo"
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


--=-XU2CWv3Ah+1yx/3EAEuo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello stable maintainers,

Several Debian users reported a regression after updating to kernel
version 5.10.247.

Commit f0982400648a ("fbdev: Add bounds checking in bit_putcs to fix
vmalloc-out-of-bounds"), a backport of upstream commit 3637d34b35b2,
depends on vc_data::vc_font.charcount being initialised correctly.

However, before commit a1ac250a82a5 ("fbcon: Avoid using FNTCHARCNT()
and hard-coded built-in font charcount") in 5.11, this member was set
to 256 for VTs initially created with a built-in font and 0 for VTs
initially created with a user font.

Since Debian normally sets a user font before creating VTs 2 and up,
those additional VTs became unusable.  VT 1 also doesn't work correctly
if the user font has > 256 characters, and the bounds check is
ineffective if it has < 256 characters.

This can be fixed by backporting the following commits from 5.11:

7a089ec7d77f console: Delete unused con_font_copy() callback implementation=
s
259a252c1f4e console: Delete dummy con_font_set() and con_font_default() ca=
llback implementations
4ee573086bd8 Fonts: Add charcount field to font_desc
4497364e5f61 parisc/sticore: Avoid hard-coding built-in font charcount
a1ac250a82a5 fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font c=
harcount

These all apply without fuzz and builds cleanly for x86_64 and parisc64.

I tested on x86_64 that:

- VT 2 works again
- bit_putcs_aligned() is setting charcnt =3D 256
- After loading a font with 512 characters, bit_putcs_aligned() sets
  charcnt =3D 512 and is able to display characters at positions >=3D 256

Ben.

--=20
Ben Hutchings
Man invented language to satisfy his deep need to complain.
                                                          - Lily Tomlin

--=-XU2CWv3Ah+1yx/3EAEuo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmlX8a4ACgkQ57/I7JWG
EQkVOBAAubthm7EVxjj9GT4KlGJO+GZAepcDv/Lq11rAec72wFMwWPKxWxjN9yB1
Ep57YYpbq+YwjWzSXK2Z7iLPkCAcVSsQI3VST/kl7cdJaTqDQhojGValWKyi07qa
06k7nI/4h50s6poBphLljm98dmPMibiKoBZQW3dcxdt49nvjNT8+D1WVL2cAjfdd
vOBrFwhzzXBNMvP0wJz68b2eNAUUZA6KcpkW69+qWGmk5vLxzjU7VZumNZROE/RI
DzEsgqCJkWabHgHJRAkM4mAmRWNX5U05620BTRfJG5LZlGWCUFR4nVhLIxg792s5
w6k+WzmilDdokPV8Ep2DhaCRBGr0wGCNiP3iK6YMYP+Dnhbg8cKWnlEg+qTNXSvS
LEoBCxNYEvImsqzcpqN188PWMVYbabI3yjl9/0CUbwBxejvNQABVcCvJaKnuA3Y9
bYRQ6YaWbMW6ArDP81byiOHn0JIlsQMwYOUU1JkwYOdYNQ5W/AmumVAhcYrudnAP
fPD7Z3kgkhyvuU+LsZb8JNa5SuGjIdzg+4SeMDR581YqGb7kZHFaFu10NiBhkpL6
2G/0vMApE/LUINaFy4SyWqxpb33ifmnTiq31rwyNHjcXG5LCKOyTVUP7KVSI9Ew3
GQG5ldD6OFP7o4h3lDyEhqt4BKIPupVsUnejYbKrKaywP9+oZzw=
=gjyh
-----END PGP SIGNATURE-----

--=-XU2CWv3Ah+1yx/3EAEuo--

