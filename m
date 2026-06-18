Return-Path: <stable+bounces-267152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sPQpCeQBNGqcKwYAu9opvQ
	(envelope-from <stable+bounces-267152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 16:34:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE0C6A0F2D
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 16:34:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267152-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267152-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 348EE301AB5C
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE8330171A;
	Thu, 18 Jun 2026 14:34:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61D2222D0;
	Thu, 18 Jun 2026 14:34:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793246; cv=none; b=KYpaZrYnLCTp07XJfoC5U2W5ZBpA9Jq81xy71+LeSQt3lh3X4IJRg8Jy9YlihbooH1G/e8M/AIdpP35z8Hj5chZlGFqUQmfVNacSwUY3IQ2PNtypfJI0YBTKJOTtukW7maH2VXlmb4cEJ9Nu9otHbAS/kpfs0avGofqP5w5qmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793246; c=relaxed/simple;
	bh=DNDV0+pikas6MP5wUk44x8Onr0t42in3cpi45mdoaSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RA4ud9B//kfAEiMoYRsxxCy0axRYZWKqpWFDuGaSDULtX5RHhi/NrXP+BMwuZRv2IjdxNQaOhBUrs+jg5JwNDlCWBsxOc8m0+oW7DFdEw5kTjNrfsEYVkfZmf+BvPQzV9wPXqSrwtWkcHqYmnXZJXP8Jq5jIoTNfU6cSQO8a0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1waDob-0032nG-0k;
	Thu, 18 Jun 2026 14:33:57 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1waDoa-00000006s7y-2WC1;
	Thu, 18 Jun 2026 16:33:56 +0200
Message-ID: <6f805abf1f8b058c1b1241e8568d7539185145df.camel@decadent.org.uk>
Subject: Re: [PATCH 6.1 208/522] net: Annotate sk->sk_write_space() for UDP
 SOCKMAP.
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>, Jakub
 Sitnicki <jakub@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>, Sasha
 Levin <sashal@kernel.org>
Date: Thu, 18 Jun 2026 16:33:49 +0200
In-Reply-To: <20260616145135.793184452@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
	 <20260616145135.793184452@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-vhT3ChXx/CtIV4msNMEW"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267152-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:kuniyu@google.com,m:jakub@cloudflare.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,decadent.org.uk:mid,decadent.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AE0C6A0F2D


--=-vhT3ChXx/CtIV4msNMEW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:25 +0530, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Kuniyuki Iwashima <kuniyu@google.com>
>=20
> [ Upstream commit b748765019fe9e9234660327090fc1a9665cdbdd ]
>=20
> UDP TX skb->destructor() is sock_wfree(), and UDP holds lock_sock()
> only for UDP_CORK / MSG_MORE sendmsg().
>=20
> Otherwise, sk->sk_write_space() may be read locklessly while SOCKMAP
> rewrites sk->sk_write_space().
>=20
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
>=20
> Note that the write side is annotated by commit 2ef2b20cf4e0
> ("net: annotate data-races around sk->sk_{data_ready,write_space}").
[...]

That other commit hasn't yet been backported to 6.1, so this is not a
complete fix.

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC

--=-vhT3ChXx/CtIV4msNMEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmo0Ac0ACgkQ57/I7JWG
EQlBVhAAiC5o2JO/kE0+kpsrCP2CGS+Vk1+Fl5a9ioFz1yOP/juwX3syyW7dzaAW
2ItWMnImXHc2WltBCjFE6kQLtfZ5WeHkaC7zoe39JR0UwlTvWJ5NJIZojuIQIa5j
43DzPO597TthVHZRee4OYVjVBCKBWfdjCd4XCVuFa8jWuAqXqZ4VNr2f81wRexQZ
x1S7fB250q9S8XZ2FNK+IzoI8DjDLiStJKozumJBi/eP3RwKcRq0Htq37rI9bNOg
64swjL+bD6kK3OIL71aL6/i0HRCIY6hsy9jhn652Jtio3Dap6+FtII7dhWJosNRz
OpugxRXBHV7sUvXFOuJPvR6RWP02wUmG4riXAZNBL3AbyBnNFv6iPnZnwdp8FvRR
tC4h+tKnz+8JXHfHCWn6xJJs2Hbznx1SuZGadPnJFKtPfMm0sQKO2PD9HjjHvgUV
ksRletx8g00374htQVC+lllBWZzHVQiwk0IFdHzB6RtfUNSPJM9LgskM9qMid3Vk
3/Nf62bRWPJSp7ESuIljvPsKTQakc0YwygO65TOqL6bmrIK+MVeRjCl9BK4yvPJ2
GoD0VKLVyN2M0WGUoVrIqx1PaxitL+iQYs0w0CwcSbexGZ595wIxZ2EQsLUB5DfG
yydf/0wulzDlYcom7a05qkxG27Ea3eFNXCh1MDH8YcNfGFL1zZ0=
=4IcO
-----END PGP SIGNATURE-----

--=-vhT3ChXx/CtIV4msNMEW--

