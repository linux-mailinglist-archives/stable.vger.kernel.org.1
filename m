Return-Path: <stable+bounces-259814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nGJ9FAPMHmr6VAAAu9opvQ
	(envelope-from <stable+bounces-259814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 14:26:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E4662E05F
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 14:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=lSBGcYcw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259814-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-259814-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37A8830234DF
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC43DC4B8;
	Tue,  2 Jun 2026 12:24:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D653D669D;
	Tue,  2 Jun 2026 12:24:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403069; cv=none; b=eO9MuHHLyoKhlY8IWWgWQaRVmcZ8ZvIlK4/XwbfovCFOwjKn6pNRFKMobjSjZvtf6j6Sadmy6nk5wCdVanMF8dSWhLjzrBT4f2gnR4b4A+rbt24NGhjy1GrxDs4jYpS7DtRHUvYarTmJ53XW5LgAupBuudMheW6ihwjrJiJOrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403069; c=relaxed/simple;
	bh=JlT+cZYsqRG96W04CugaFUAuiXRhWUqpRZ1gwj1v9yQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGsz4HzaDCFq7lSPflpN7JRn4y1eMWTBgE9z2G9oyzqBU/Si1dtlnAAaKIoWG5VDiH+OHiWZxaDP9xPMXdiUVlE+T2dI+MCcJqnsq9ehLpslOVC83JJv1DXPem/MhNCJCqG/6vdVct3REvFQmc53Id5on0I+td/yyrVgiSJqY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lSBGcYcw; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KVqA0dyDMlZqpwtMJ9x40FOgRbN07P0B63/VMtUhQro=; b=lSBGcYcwI1Kbe1cfXa/27rifmo
	scx63GB4xXpDCQloMYUD4NJ8Rv87w6TP1+1Le+SqqmHnKBMV+6NrT9f0Jr5+ViLcLQZOKlS42FT9q
	ydf6rDB3xDcEhZ1DR5STEbOACE4IyA+U9nheEjVC7534M6qCFs4RvcTFHi8g8wgXDE5LpbKPmmRME
	jastH441b9qUFise3AOStU/6SX0yEgO9r7Xzx/yuWP8A+qZFEwjAVNkMNM17RWc0phKa2HtxK9HDa
	6utSlaudiPL0dx/rOyuHHQyTKvNUpebC6y/eNjiSblOD+ZEfJD1JAwSKumGtlFFStiFwRkTYBu52B
	4dd69Y2A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wUOAK-002x2t-2P;
	Tue, 02 Jun 2026 12:24:16 +0000
Message-ID: <d9c2e8ea23b1919fe663e480cc7def260ed0ee24.camel@debian.org>
Subject: Re: [PATCH 5.15 002/570] ip6_tunnel: Fix usage of
 skb_vlan_inet_prepare()
From: Ben Hutchings <benh@debian.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>, Alexandr
 Alexandrov <alexandr.alexandrov@oracle.com>
Date: Tue, 02 Jun 2026 14:24:10 +0200
In-Reply-To: <68ad88bb-958d-4009-8631-284853ffe1b0@oracle.com>
References: <20260413155830.386096114@linuxfoundation.org>
	 <20260413155830.485087556@linuxfoundation.org>
	 <68ad88bb-958d-4009-8631-284853ffe1b0@oracle.com>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GEeodVjEnDPZLD35272B"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harshit.m.mogalapalli@oracle.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:sashal@kernel.org,m:alexandr.alexandrov@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-259814-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[benh@debian.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,decadent.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0E4662E05F


--=-GEeodVjEnDPZLD35272B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-02 at 16:50 +0530, Harshit Mogalapalli wrote:
> Hi Ben, Greg, Sasha,
>=20
> On 13/04/26 21:22, Greg Kroah-Hartman wrote:
> > 5.15-stable review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: Ben Hutchings <ben@decadent.org.uk>
> >=20
> > Backports of commit 81c734dae203 "ip6_tunnel: use
> > skb_vlan_inet_prepare() in __ip6_tnl_rcv()" broke IPv6 tunnelling in
> > stable branches 5.10-6.12 inclusive.  This is because the return value
> > of skb_vlan_inet_prepare() had the opposite sense (0 for error rather
> > than for success) before commit 9990ddf47d416 "net: tunnel: make
> > skb_vlan_inet_prepare() return drop reasons".
> >=20
> > For branches including commit c504e5c2f964 "net: skb: introduce
> > kfree_skb_reason()" etc. (i.e. 6.1 and newer) it was simple to
> > backport commit 9990ddf47d416, but for 5.10 and 5.15 that doesn't seem
> > to be practical.
>=20
> We have seen ltp-net failing after this LTS update on downstream kernel(U=
EK)
>=20
>    mainline            : v5.17-rc1        - c504e5c2f964 net: skb:=20
> introduce kfree_skb_reason()
>    stable-5.15         : v5.15.58         - 5158e18225c0 net: skb:=20
> introduce kfree_skb_reason()
>=20
> So this is not needed for 5.15.y.

I don't know about that test failure, but your analysis is wrong.  The
dependency of the original fix was commit 9990ddf47d416 "net: tunnel:
make skb_vlan_inet_prepare() return drop reasons" which changed the
sense of skb_vlan_inet_prepare()'s return value and has not been
backported to 5.15.  That in turn depended on the commit you are looking
at.

> This needs to be reverted for 5.15.y, looks good for 5.10.y
[...]

I started looking at how to fix the regression in 5.10, which does not
have a backport of commit c504e5c2f964, and did not notice that it had
been backported to 5.15.  So this patch probably could be reverted and
replaced with a backport of commit 9990ddf47d416.  But simply reverting
it would not be correct.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-GEeodVjEnDPZLD35272B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoey2oACgkQ57/I7JWG
EQlkURAAtcN3wwN/IwXVolorxWiAfyc16MmuRFvwqC8TRrus+Nc6t19KRRKBscxV
7bFA7bFHNhXnyM4kj2CJEe2Ft4uLwqV66fGnD9K4Kri2nL8Ogc3nYNRl/W7LR2Zg
Lw4z1Sk7NUdy2uJ2AYtovuoErzvUPwS1iT/KgcAbFNAl6O6ZrQ1lakOGGXiYwTqG
XiBdZL5y3SuT4sEBFf0Pc1lq3Hu7gYVr6gbJybnF264he7dOXTVXYKISFO4icK2J
tAPeBHtWQyJUZSCp5mo2HtWHKcBleR1kW3R/hb3CFS4idXw9Hiy/U0scJz7keyRx
ByMHnqm42Jpb/mHK7mQ1CPutSi4fztS9+u0GWG775WvHxIPdL52Q31ob6el4q/Vx
DypIy3BUDDDZ9t/6zkY8eUk3RYcs+42axPOPoqUTYqkvXOrpusPOy9hySqpIuiZb
bVaN21um2AKJIfZhewjKfAizFBiL9W79lEkyn0e4leCu/Nmv0yPL8ylbRfXF93Jx
ib1r4GmtiAwjI7VIQKhkoGJE/jdssFwhp2kWmR3563OjpLpU0psWQpNkxTjFQ+MQ
YPTpBNquvf8qn42aRWnWE2UGjj0OF+uNAmBrkVl693KO2+cGP/RtgZDd8Ua9hjv5
jnIbPFkKO4GpPj/HubL7Cs6apVdLhCSLI1Mk1koqu1ugYs9ZYJY=
=/TEW
-----END PGP SIGNATURE-----

--=-GEeodVjEnDPZLD35272B--

