Return-Path: <stable+bounces-217656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MK8FMw0mmmgZgMAu9opvQ
	(envelope-from <stable+bounces-217656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 23:42:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D19C16E269
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 23:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A8BE3024A58
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB72F531F;
	Sat, 21 Feb 2026 22:42:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB988286881
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771713737; cv=none; b=bV/sQRKX0HbELi/hx/VdNjnr1ECGh1q5YD9VpgoSKJ0qzaiHWDGXoBff6upl4EZ6KvkjhP70/eshzYv1SCrzxm1IqXfDA8nZcDPr2oGpINGfyruto0Goi/ABepgY7Lr0nQyRR4Iz8DXUM1f/Tv6O90HbvVPBIK8n+Mgz6B0VwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771713737; c=relaxed/simple;
	bh=pzCHYHID+rOHTF1rtGcEolwdycUSw6mB2viWNBUWlMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ob61+yc3dFcRE+zc7mnUkD5Qbl4+yDucOerYqI+UaSlbozpcunIDRsOd2ONPhLn+4BenjZI/JkWtUXVySDfThu9154ERBXLFYEIEIVemn9yiVI0FyvERC311xSDK8u5sUTvzC7d3jeAKZvifxX0Gk7261MYz12xYx86qmALPayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vtvfv-0020eW-37;
	Sat, 21 Feb 2026 22:42:11 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vtvfu-00000000oMn-17zT;
	Sat, 21 Feb 2026 23:42:10 +0100
Message-ID: <3befd6850f29aa5bb8a42f4e45df4a195dc6694c.camel@decadent.org.uk>
Subject: Re: Please apply commit 9990ddf47d41 ("net: tunnel: make
 skb_vlan_inet_prepare() return drop reasons") down to 6.1.y at least
From: Ben Hutchings <ben@decadent.org.uk>
To: Sasha Levin <sashal@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hostinger NOC	
 <noc@hostinger.com>, stable <stable@vger.kernel.org>, Menglong Dong	
 <menglong8.dong@gmail.com>, Simon Horman <horms@kernel.org>, "David S.
 Miller"	 <davem@davemloft.net>
Date: Sat, 21 Feb 2026 23:42:05 +0100
In-Reply-To: <781f4e83b6a111cfd3c8a331ea75824d9238fe0f.camel@decadent.org.uk>
References: <177132401902.2893171.1371685164011289024@eldamar.lan>
		 <2026021740-mom-remix-8103@gregkh> <aZSzfA3yFQxzj-N4@eldamar.lan>
		 <aZS30CAA7rPhx7h-@laps>
	 <781f4e83b6a111cfd3c8a331ea75824d9238fe0f.camel@decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-D7OiYXI5pRy0YR4WNuli"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,hostinger.com,vger.kernel.org,gmail.com,kernel.org,davemloft.net];
	TAGGED_FROM(0.00)[bounces-217656-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[decadent.org.uk];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 9D19C16E269
X-Rspamd-Action: no action


--=-D7OiYXI5pRy0YR4WNuli
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-02-21 at 22:14 +0100, Ben Hutchings wrote:
> On Tue, 2026-02-17 at 13:47 -0500, Sasha Levin wrote:
> > On Tue, Feb 17, 2026 at 07:29:16PM +0100, Salvatore Bonaccorso wrote:
> > > Hi Greg,
> > >=20
> > > I'm sorry having wasted your time, I relayed the testing result, let
> > > me loop in the user which tested the fix:
> > >=20
> > > On Tue, Feb 17, 2026 at 11:57:25AM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Feb 17, 2026 at 11:28:20AM +0100, Salvatore Bonaccorso wrot=
e:
> > > > > Hi stable maintainers,
> > > > >=20
> > > > > 9990ddf47d41 ("net: tunnel: make skb_vlan_inet_prepare() return d=
rop
> > > > > reasons") was alrady backported as well to 6.12.71 to address a
> > > > > regression when backporting 81c734dae203 ("ip6_tunnel: use
> > > > > skb_vlan_inet_prepare() in __ip6_tnl_rcv()") (this one was backpo=
rted
> > > > > without the prequisite commit to 6.12.67, 6.6.122, 6.1.162, 5.15.=
199
> > > > > and 5.10.249).
> > > > >=20
> > > > > Can you pick please as well 9990ddf47d41 for the other stable ser=
ies
> > > > > as needed? I can only give a confirmation that it works as exepct=
ed
> > > > > for the 6.1.y series as per https://bugs.debian.org/1127823#36 .
> > > >=20
> > > > it does not apply to any of those older kernels, which is probably =
why
> > > > it didn't get added there.  I tried to do the backport myself, but =
the
> > > > changes to drivers/net/vxlan/vxlan_core.c doesn't make sense to me,=
 so I
> > > > can't do it, sorry.
> > > >=20
> > > > Do you have a working backport anywhere?
> > >=20
> > > "Hostinger NOC" team, can you followup to the above? Can you provide =
a
> > > working backport down to the 6.1.y series to Greg?
> >=20
> > I've queued up backports for 6.6 and 6.1. If you need anything older, p=
lease
> > send a backport :)
>=20
> Your backport to 6.1 can also be applied to 5.10 and 5.15.  I haven't
> tested the result, but it does fix up all the places
> skb_vlan_inet_prepare() is used on those branches.

Oh, but we don't even have enum skb_drop_reason in these branches, so
the result doesn't build (as you presumably already found).

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC

--=-D7OiYXI5pRy0YR4WNuli
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmaNL4ACgkQ57/I7JWG
EQmpWQ/9EWIwshDrixs52ujHM7TH25tnKvrsog7VSboaDQOSGOv9CjkbTe/Y0uBp
1qO6O8hvT7Uo/ZaAmpj7V0DHasQPtAwdLL5PAMzaqz2Z4J8bC1J2W8O6zlZzn0wy
ru7f3KegyOnFHvI4uPuXuIly5fgOj9vDUYjpRodux1QEZ9lIPJPy1/Jbhy13S2rP
UKRQ/H2tuh2IKHdMreMeh3bccKZQeiEzkFc/JkM2/wtb8EmGc9/SNdMKnOoq8lQl
D4FCiuu16cl1Q0E4o0GddkDHBmdOt2kkxrgzWYFPatLbUbnDSsOwEaiMu84Thobx
ZncZLjaZK1yriFep1LMDvZZ0J8HzwIKmOmlpiDn4bIFmvCVFUjY2K9uMamOkN9/G
6mobKQIKzo6Mc5N2jne2Byp8TM2TX7dQQd/gM2jb1dzAUnlw3WF5MS1w+BSXNqRX
isL/6e28DbMAYJglXNW8alWqeqZZyG4AUn84ku9rgH0h9BkEO0h4rKVYOL3g+x08
j5qqlHHyyVL4AyTJp6RRklUfD5UiqIDrTlWrXfDohommCa8wIMcd/K6qN/nTkUFA
QSG1nq9Jd9/BWjHA9HWqzW9F+GN7Lf4MjeJKXHe1P5d02U2yh4iyxDiWZ7HAh3s+
Dey/IA49owZbW/nTAALhclCPPITEGmxCsFE2kRAux5xFiig3DBk=
=lVDr
-----END PGP SIGNATURE-----

--=-D7OiYXI5pRy0YR4WNuli--

