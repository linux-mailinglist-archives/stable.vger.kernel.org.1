Return-Path: <stable+bounces-217654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fxgmBGEgmml6YwMAu9opvQ
	(envelope-from <stable+bounces-217654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 22:15:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071516DE3D
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 22:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B3FB301C6C5
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 21:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB4303A12;
	Sat, 21 Feb 2026 21:15:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D330CD80
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771708508; cv=none; b=FvbIYzdxRqZZDYCkj6IXLB6+i3lTxMocu5j7Jl0bsaGST9TS6kZJAdmViK47corAdTodQhIea/lGHgZ2xvMzsHDRZzafVsJ1kUZiKQ1/+WniT1P9N4NC+snHXZdYMyNaWOhBD7sfcZ4Dq4Px50QoPAPjPmXSjaYclSLGONDWvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771708508; c=relaxed/simple;
	bh=IziBIQixsljy2B4i1STJotk6XzjlUmd02vx7D9K2JOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b5/uyGAr9RmcG37uk4BDwlNgDGoGgzYUSU9uyUoOCdTDqAeauSo8qUTQK2JV2JcSPcjadRYhBySoVGAAMtYJ3uFTbFTqL4ww1grLxK7mUVgsqVtGgTSkgtOUpkAiNv4YqJcLaBAylIHE676l7LXPqf5BKTiy35w5TwbrbzW/uUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vtuJa-0020CH-28;
	Sat, 21 Feb 2026 21:15:01 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vtuJY-00000000hRf-0IA1;
	Sat, 21 Feb 2026 22:15:00 +0100
Message-ID: <781f4e83b6a111cfd3c8a331ea75824d9238fe0f.camel@decadent.org.uk>
Subject: Re: Please apply commit 9990ddf47d41 ("net: tunnel: make
 skb_vlan_inet_prepare() return drop reasons") down to 6.1.y at least
From: Ben Hutchings <ben@decadent.org.uk>
To: Sasha Levin <sashal@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hostinger NOC	
 <noc@hostinger.com>, stable <stable@vger.kernel.org>, Menglong Dong	
 <menglong8.dong@gmail.com>, Simon Horman <horms@kernel.org>, "David S.
 Miller"	 <davem@davemloft.net>
Date: Sat, 21 Feb 2026 22:14:43 +0100
In-Reply-To: <aZS30CAA7rPhx7h-@laps>
References: <177132401902.2893171.1371685164011289024@eldamar.lan>
	 <2026021740-mom-remix-8103@gregkh> <aZSzfA3yFQxzj-N4@eldamar.lan>
	 <aZS30CAA7rPhx7h-@laps>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-DaEt1w2stIRijWu6BPKJ"
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,hostinger.com,vger.kernel.org,gmail.com,kernel.org,davemloft.net];
	TAGGED_FROM(0.00)[bounces-217654-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[decadent.org.uk];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 5071516DE3D
X-Rspamd-Action: no action


--=-DaEt1w2stIRijWu6BPKJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-02-17 at 13:47 -0500, Sasha Levin wrote:
> On Tue, Feb 17, 2026 at 07:29:16PM +0100, Salvatore Bonaccorso wrote:
> > Hi Greg,
> >=20
> > I'm sorry having wasted your time, I relayed the testing result, let
> > me loop in the user which tested the fix:
> >=20
> > On Tue, Feb 17, 2026 at 11:57:25AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 17, 2026 at 11:28:20AM +0100, Salvatore Bonaccorso wrote:
> > > > Hi stable maintainers,
> > > >=20
> > > > 9990ddf47d41 ("net: tunnel: make skb_vlan_inet_prepare() return dro=
p
> > > > reasons") was alrady backported as well to 6.12.71 to address a
> > > > regression when backporting 81c734dae203 ("ip6_tunnel: use
> > > > skb_vlan_inet_prepare() in __ip6_tnl_rcv()") (this one was backport=
ed
> > > > without the prequisite commit to 6.12.67, 6.6.122, 6.1.162, 5.15.19=
9
> > > > and 5.10.249).
> > > >=20
> > > > Can you pick please as well 9990ddf47d41 for the other stable serie=
s
> > > > as needed? I can only give a confirmation that it works as exepcted
> > > > for the 6.1.y series as per https://bugs.debian.org/1127823#36 .
> > >=20
> > > it does not apply to any of those older kernels, which is probably wh=
y
> > > it didn't get added there.  I tried to do the backport myself, but th=
e
> > > changes to drivers/net/vxlan/vxlan_core.c doesn't make sense to me, s=
o I
> > > can't do it, sorry.
> > >=20
> > > Do you have a working backport anywhere?
> >=20
> > "Hostinger NOC" team, can you followup to the above? Can you provide a
> > working backport down to the 6.1.y series to Greg?
>=20
> I've queued up backports for 6.6 and 6.1. If you need anything older, ple=
ase
> send a backport :)

Your backport to 6.1 can also be applied to 5.10 and 5.15.  I haven't
tested the result, but it does fix up all the places
skb_vlan_inet_prepare() is used on those branches.

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC

--=-DaEt1w2stIRijWu6BPKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmaIEMACgkQ57/I7JWG
EQk89g/+JrhAZG1noeexIIRt+o+cHBZL8dbEXGEezdZGBklFoeL/7qqqgBBDJyg2
79zQP6U8v0Y+zqHifNAdAMnT189Snq3SZsE2QXrGtOVAtSzg0Bsm1FJqlJmUAm/D
NgL1U1WVeYPNZUVFrH47Fd70WwZCchQsfKkh4wozIFFF/6Y6OeG1fCttcymQ4ze+
PqouhVIlkpUHHl50q8rVvF/9wW18aQi058JclU+Bx66EBGQ6zjfLbpERkv4Ud4FB
RbBEaOYpHLFRC7+S7Lorwr+Vis/pRWu5S3m9hKZ/4oUS9dWu64WfUhFiQKHl3yxn
6grbIYTddGrLbZiSIqImCZTSuXEX7OAd3xItSiHPViRBJYQLVzFLeAOfIGd2w9IV
FIAUAJTekSlr83TLpC41fkxeGziy857GD25tVEBhy/jKuTdHx+9L4rmolxE1jOQY
zdMHTxKhH76+n3KBFzBi9mPrAJ8Ln8embTGQ5MjvKAuboo9zNtWm0m9NA0stqYS1
DSG7iGRm7wEXyFCAsOQr6lXTrxwahqXum32fHht6tqWRu2tPe4qupkTbLmetDCUD
Qxff6GBRzf33iPsG5F/BmX6ERclTNZz7+6M8WPThzPA4EUDfEfDTlxmtpPRyxYup
mbwZN/apfkugysBXDxM/jtY5yROygFE4amPWa7dEtJZ4UzL5h34=
=UUAc
-----END PGP SIGNATURE-----

--=-DaEt1w2stIRijWu6BPKJ--

