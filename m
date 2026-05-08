Return-Path: <stable+bounces-244771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MANAN4z1/Wn5lAAAu9opvQ
	(envelope-from <stable+bounces-244771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:39:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9A4F7E1C
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 574E13001CCB
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F43ED5A3;
	Fri,  8 May 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kPZy0xKd"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077513ECBD4;
	Fri,  8 May 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251142; cv=none; b=Mk6tEgTK+JV+pC+JbM7Op305kYlWcvHrb4uEAddT0ShIO0qTnXh2asZNZic+ql4DDZlWqi6bOEMjky5M65aaLlCK6AY0w+j0s4UH3QkM7CPPP0VuPv2n5JLzxB/l1vqwCnebW3ex3creJWfYDzoKiO/D0xzSHlLQ3O+ALW0cBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251142; c=relaxed/simple;
	bh=po7Y0Wv7A9qkA681gOOQ1oyNp94IpHABLnSUFirAZOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NyxurhNsLJKesXh4Y5frSppFK88BnuQ6PddmAUKUTDkt8a2IsCV2hmaX1+0+2lFTLddjf5Dc+TtSLZ4ONE/fbCMLPTWfHHsfRk4ZetuwfN9qn3ijtiYwLcQ/c20jKcWq4mLw/4dJVXWDXN2yMR3MdJd1ITG8n5buIiwDy3gfso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kPZy0xKd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kOnDcXJd7OuK+oq8W4C5tyLeYh4aCCJueY1sFq/m9ZQ=; b=kPZy0xKdh+WcxP8LrcxlxaOHHq
	TjcrlzvzOhfFE0uw2CuwbMZqhGkJztLnd2xv0C80Xq06ujhT0SGkwKrrsJ7MxtZFAx4iyKhOLlsh1
	RaXGZSFFAt7YbF6utu//s3CGSFN5k7KlXPrcvDowMP/eMd9atK9yjwodWQM3UbAWtuaUblGihs80d
	51IpL9m6Qe16MdwIYx5itNI1DOjqU+b4VLayGB8NVHG6Yh1R3+PM1TeUF4KwV0uKxvLWgjXYpuC3h
	11jay7KWLZWdebwVFa6G+M4O1+PgPzkUAxaPuFo/U+/Fz9tY71IXeB9hkWqgfS+KLjza7+OxRIZgE
	DS/IU22g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wLMLr-005DMp-2D;
	Fri, 08 May 2026 14:38:51 +0000
Message-ID: <036ef29e143799f9117792463d640916490fa61a.camel@debian.org>
Subject: Re: Linux 5.15.205
From: Ben Hutchings <benh@debian.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
 Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Cc: Dominik Grzegorzek <dominik.grzegorzek@oracle.com>, 
 "torvalds@linux-foundation.org"
	 <torvalds@linux-foundation.org>, "lwn@lwn.net" <lwn@lwn.net>, 
 "stable@vger.kernel.org"
	 <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	 <akpm@linux-foundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>
Date: Fri, 08 May 2026 16:38:45 +0200
In-Reply-To: <2026050815-length-yummy-f8b6@gregkh>
References: <2026050835-appealing-stallion-a207@gregkh>
	 <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
	 <2026050829-gladiator-displease-57af@gregkh>
	 <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
	 <2026050855-valley-slashed-c382@gregkh>
	 <CALUEkOfBS7qsN-7ERMS+2wcPEixXAGmquREu7uv8ecXn6d7haw@mail.gmail.com>
	 <2026050815-length-yummy-f8b6@gregkh>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-QxxK9vJkk9DNBkej4nLm"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh
X-Rspamd-Queue-Id: A1B9A4F7E1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244771-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action


--=-QxxK9vJkk9DNBkej4nLm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-08 at 16:30 +0200, gregkh@linuxfoundation.org wrote:
> On Fri, May 08, 2026 at 04:07:31PM +0200, Massimiliano Pellizzer wrote:
> > On Fri, May 8, 2026 at 3:50=E2=80=AFPM gregkh@linuxfoundation.org
> > <gregkh@linuxfoundation.org> wrote:
> > >=20
> > > On Fri, May 08, 2026 at 03:13:51PM +0200, Massimiliano Pellizzer wrot=
e:
> > > > On Fri, May 8, 2026 at 2:44=E2=80=AFPM gregkh@linuxfoundation.org
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >=20
> > > > > On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorzek wrot=
e:
> > > > > > Hi,
> > > > > >=20
> > > > > > I may be mistaken, but I think there might be a small typo in t=
his hunk in net/ipv4/ip_output.c:
> > > > > >=20
> > > > > > skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> > > > > >=20
> > > > > > Would this need to be:
> > > > > >=20
> > > > > > skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
> > > > > >=20
> > > > > > My understanding is that SKBFL_SHARED_FRAG is a bit in skb_shar=
ed_info->flags, and skb_has_shared_frag() checks skb_shinfo(skb)->flags.
> > > > >=20
> > > > > Adding Ben who did the 5.10 backport so he can comment on this.
> > > > >=20
> > > > > thanks,
> > > > >=20
> > > > > greg k-h
> > > > >=20
> > > >=20
> > > > Hi,
> > > >=20
> > > > The new released kernel 5.15.205 is still vulnerable to CVE-2026-43=
284.
> > > >=20
> > > > ```
> > > > $ ./run.sh
> > > > =3D=3D=3D Stage 1 =E2=80=94 overwrite 'systemd-timesync' line (89 b=
ytes) with
> > > > 'sick::0:0:<pad>:/:/bin/bash'
> > > > =3D=3D=3D Stage 2 =E2=80=94 verify
> > > > sick::0:0:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXX:/:/bin/bash
> > > > =3D=3D=3D Stage 3 =E2=80=94 su - sick (empty password via PAM nullo=
k)
> > > > [i] state saved to /var/tmp/.cf2.state =E2=80=94 run './run.sh --cl=
ean' to revert
> > > > # uname -r
> > > > 5.15.205
> > > > ```
> > > >=20
> > >=20
> > > Does the patch below fix this up?
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> > >=20
> > > ------------------
> > >=20
> > >=20
> > > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > > index 68509e1f89b5..5d8f8a5901bc 100644
> > > --- a/net/ipv4/ip_output.c
> > > +++ b/net/ipv4/ip_output.c
> > > @@ -1443,7 +1443,7 @@ ssize_t   ip_append_page(struct sock *sk, struc=
t flowi4 *fl4, struct page *page,
> > >                         goto error;
> > >                 }
> > >=20
> > > -               skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> > > +               skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
> > >=20
> > >                 if (skb->ip_summed =3D=3D CHECKSUM_NONE) {
> > >                         __wsum csum;
> >=20
> > Yes, this works.
>=20
> Wait, is this also needed in the 6.1.y backport as well?
>=20
> Ben, I'm guessing you tested the 6.1.y backport, right?

Yes, but on 6.1 the PoC never succeeded for me even without the patch.=20
(On 5.10 and 6.12 it does.)  So unfortunately that testing could not
show whether my attempted fix was correct.

Sorry for screwing this one up.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-QxxK9vJkk9DNBkej4nLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmn99XUACgkQ57/I7JWG
EQnU8BAAuUrm0Qaq9M3esKnukvOfAic0TW1ndnUn8vH5dDtMj+B+FpdsfD/Pon0A
4hmtfWW7kVeGQM9wCb2hMho11mo3ExRj9hx12Kq1PobEs3c2nBeWA+dMkdD4E+fa
3dZKkFR6hAmNAa/tHF9073mA8JbfouCpmZi0D+mXHE3cFOpH7cozqN0vhU3luLz/
D6o5Zex39IYnszhJLRYGT56MxlQW+veDx/3637lJa2K9ZoAV+IMdnAlDNY0qIZsz
Oi5hve5uFi4VCCnlLlUwa4OfY1oO+QkrW16ZTFIVV9ltAqDsaV3DLWDQsl6Hki5c
Ddn3noq9iEBXmVY7BOokaVmXlrAeaxofhhyBmFCwD2265BKSmxdTxjDp9E+RNabr
z/o0d8MwUcqVezqUbCh0fEBh/a3ZoGTRBlxltjrXgZA6oeKETAzx46muPWIOP3uh
d5ymfMNrf9DWNBoXzgTQdq/aEp+J45v1xAwd57pnbOUyytQMsfNEVHbj2IBYY6o8
J5CLSlJK+LIw53kRtKiohaBPjEe3sTdt4fDUnZcHZ8ZntzBxGkQR0TXS5fVrwZfn
rcphj76KcvzDame217QKwyZJmzfJP7fYab7AyNCzfvIystU4qwQTZOfIqTURHKwN
UZL9c/PWFSsks30M8RpYE+E2vLMHrcQ6Yv2BW6tRB9aiwSTd1dQ=
=lImb
-----END PGP SIGNATURE-----

--=-QxxK9vJkk9DNBkej4nLm--

