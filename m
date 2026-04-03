Return-Path: <stable+bounces-233172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO34NIWZz2nmxQYAu9opvQ
	(envelope-from <stable+bounces-233172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:42:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 258723935F3
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E9D3008D25
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5990137F8DB;
	Fri,  3 Apr 2026 10:41:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6D17A30A
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212882; cv=none; b=rKmYw5TBq6/jZCO2Q9QIFig+Cophl6MVeiPHz8wZcTJ2FtD3HtSwtZPiPJo/qh62z2BosoJyYbvzuMjepTY8o5AowzZDN/6iXHdBd6LGP58eWajq6FQCdFV2Q9iLBNAf+WVHYd6+xIgeSzYnEh31K89nl6QguiZEu1UOxaFgZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212882; c=relaxed/simple;
	bh=Kz7WJ+/+/baXengwQU/uSiLdel+R/yWrbYT0KjI0pp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ahJ3COkmW16XNdAAQQhb6eR4405PSjEgH3BRMSUJKr8oNMe6tMddg1UH0ERyB5PcWMawe4TfSzpXboTdh+DoFxaApnUK/TDX0DT4h8wOncaM7QKLl8G7OIXECI1ZlhupgQ889rjSSXwnmv5OklfMTZJ4ARXIm0JYSDb5d5xwqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1w8bxg-00320O-36;
	Fri, 03 Apr 2026 10:41:12 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1w8bxe-00000001Epm-24GU;
	Fri, 03 Apr 2026 12:41:10 +0200
Message-ID: <20fe79e3624386fe646e703e7a178fde899886eb.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10.y] x86/cpu: Enable FSGSBASE early in
 cpu_init_exception_handling()
From: Ben Hutchings <ben@decadent.org.uk>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
 Sohil Mehta <sohil.mehta@intel.com>, stable@kernel.org
Date: Fri, 03 Apr 2026 12:41:05 +0200
In-Reply-To: <20260331142533.2463086-1-sashal@kernel.org>
References: <2026033008-surfboard-squirt-5661@gregkh>
	 <20260331142533.2463086-1-sashal@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0Yy9UR+Ah+HoV7O+CF/A"
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
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233172-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[decadent.org.uk];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 258723935F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-0Yy9UR+Ah+HoV7O+CF/A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-03-31 at 10:25 -0400, Sasha Levin wrote:
> From: Nikunj A Dadhania <nikunj@amd.com>
>=20
> [ Upstream commit 05243d490bb7852a8acca7b5b5658019c7797a52 ]
>=20
> Move FSGSBASE enablement from identify_cpu() to cpu_init_exception_handli=
ng()
> to ensure it is enabled before any exceptions can occur on both boot and
> secondary CPUs.

[...]
> Upcoming changes to CR pinning
> behavior will break the implicit dependency, causing secondary CPUs to
> generate #UD.
[...]

Unless those "changs to CR pinning behavior" also need to be backported
to fix a bug, it doesn't seem like this is needed in stable.

Ben.

--=20
Ben Hutchings
Nothing is ever a complete failure;
it can always serve as a bad example.

--=-0Yy9UR+Ah+HoV7O+CF/A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmnPmUEACgkQ57/I7JWG
EQloRQ//aPaz7g5IN6fOO6V9Xygh9JwKmYt5zEkO9hMQka8snn2Tx/zmpKpOZzF1
U99tQ3nysAVQRpIVVSKrchpa5OaWYDSonE8QywJcJQttZOLNHuFYOgdtggQbL9ex
VYhCycihRyXaKOMdHSvEXpR0O2Qh7oQA1OMGlNtSdaS33JSLPmKpgep71YeX2w2I
gnV4gDiNkkHgKu3FBciBzNGZaIGTgmQikrjJQaIk0lZXSk+UhGB2nQd3r+FOcWKF
8Js8tEqejdsiozrAUnxA/Yetxpe/sh8jR4icULrBzm6khcsTNH7MZJAjvOg14Hhz
0O6JDVL9fd8uZVsmNHDdqhn1X2+s5SGMNFdGx1qnwzC+kcoboDHWmfYj5eZG0Nvy
LlyCNCZ1oFAe/3WOyKrAxQaqPOTcWRd6dA0hgGOHZJXG86bYvsDwI8wdSkLVpVaD
5qY5CevTRBVoiyK/bvTIqXTUHSXz+YpCn9DrCv4M52KygKmbX5u6/2YmMf/tL3Ub
hBCl4Dp0Iiexo6wK3pBVFwyHJJrSq5zY0Ip3dnK8vt6H6uk7kbGJ82KGFOxXh9M3
OWfCoc7txiGSgPI2UrjSgN1VdA8/X5iZUVXNzItHCNVIXJmD3bhTrAFtYtn5Gcpr
zZM4bVb381vXnXQbkcAgIDTiy6QFmXc+ylE9Nkvl5dfMeisuSBY=
=LdtF
-----END PGP SIGNATURE-----

--=-0Yy9UR+Ah+HoV7O+CF/A--

