Return-Path: <stable+bounces-267185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v8aWOYIqNGq2QQYAu9opvQ
	(envelope-from <stable+bounces-267185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 19:27:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 380866A1EF1
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 19:27:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267185-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267185-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3BAE306A16C
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2DA328255;
	Thu, 18 Jun 2026 17:25:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB87283C93;
	Thu, 18 Jun 2026 17:25:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803555; cv=none; b=Q/qCP6GMbP3GBDMIMvQ21DOJjn7MNXNx81HBgNezMvgznY5rU0+pX8eHlQr1mGhywBbmPULFqr1Dq9gY4pyd3sZ1UOqLXuzy3yEafM1gzwQZWYYqwrEziiKt0IwHsPxzxf9W+H9cIvyUHzCUOeKAGyWxuXvs57oVR6UGy3nWJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803555; c=relaxed/simple;
	bh=v8T3Zym2SEvkULN9T+ONcAtVTebKa9yr6zDHNge70yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIeUgcqT0vBVpK1vdGnToGi4gsk9J/WtTJV4yBoj/ubMuBybc67nbfWwS2nQk3Vdeem7hdx1fivSBmc/KYq7Fr6KtbpXGI9LnSS47dSFIOF95vrsdflv8wgOS7tAlC0rH6tIzNDCt+mbcdgctS4mDUngbW5pQcLlGB8lZl1IM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1waGUw-0033bU-1x;
	Thu, 18 Jun 2026 17:25:50 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1waGUu-00000006xgi-3QJG;
	Thu, 18 Jun 2026 19:25:48 +0200
Message-ID: <afe207eb91522718cfae8b77310999ca397c81bf.camel@decadent.org.uk>
Subject: Re: [PATCH 6.1 249/522] r8152: Block future register access if
 register access fails
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, Grant
 Grundler <grundler@chromium.org>, "David S. Miller" <davem@davemloft.net>,
 Sasha Levin	 <sashal@kernel.org>
Date: Thu, 18 Jun 2026 19:25:39 +0200
In-Reply-To: <20260616145137.622836614@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
	 <20260616145137.622836614@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-519SIzhLMuOTzYXSB9te"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267185-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:dianders@chromium.org,m:grundler@chromium.org,m:davem@davemloft.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,chromium.org:email,decadent.org.uk:mid,decadent.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 380866A1EF1


--=-519SIzhLMuOTzYXSB9te
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:26 +0530, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Douglas Anderson <dianders@chromium.org>
>=20
> [ Upstream commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4 ]
[...]

This needs a further fix on top: commit e62adaeecdc6 "r8152: Hold the
rtnl_lock for all of reset".

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC

--=-519SIzhLMuOTzYXSB9te
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmo0KhMACgkQ57/I7JWG
EQmSCRAAn86c1sDSqqzcKB1cmqOVWUQ+1ReuF6kkdGAPdb6B4ARyRDv8+2X035Gt
sOTFHO6eeAn36fKNdZJKx4D+SHQrQjMt5a5J2I1ZUN9RG//1lbbrJMBFPg7v8Xca
8cOg2dRdCqyXLiuqhYHkgjU3fhRK6nbhmVRfv66y5FQf0m/3X3uitPKrdkDbm5r2
DTYo/8z9KkHwqKsmmm2QrWR+ovM95pRs1L+zKkUDmSIzatbHt5U4bPqUBAk5ZuSB
tnTMzSFPphHLBElF3td5bygUxI3qpbvxTS1XQsImSIcXQzuWz72WYoGszDURrrjS
i8Lq8l4ekzt1fSgack0SEZbBENB/AqLZUHdMz54xwosb/DfNbLiUja8ADoS2SdYs
wTkVKLmFE7ujXGZ9ryti8QGaVfeuzz15xHEUPghYOx5tblWAPU/DEBxXItdBu6CR
sFaa64fvT+SvpVjbv10VC7ACJI4lxuJYFDpDkuP2eQQc5ubCMMKt4KPXSb0LG7B2
RElc+6/1dQQPAxzFgd5fhcji8TG9Gyj6tDR/G8onYNw9MoEnftIWBDVA4RL+ZN7f
wf/TmVJiVK7JvXadpHWAwbUr7fk+PDi0xDNN/1O9UET/tmvnQQN1VP2BGiFqz0es
lEWCU5nnaGKIvIlXMdDnez6WWlbGe5wHTeSGYTgmK9o+TIn2HxA=
=w+xM
-----END PGP SIGNATURE-----

--=-519SIzhLMuOTzYXSB9te--

