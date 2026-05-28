Return-Path: <stable+bounces-254847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Gy3M2IjGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:13:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE245F11D6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B544030312FF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50223D4103;
	Thu, 28 May 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bIRa8j9H"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC638D41E
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966804; cv=none; b=MZ3HFL18JNjhqCgLYfdca3TSxJbXiX2+NINcuy119i8mBsIxytTNfL4i1e/oZIfOtlY9qpaUCHIeFXq1F3S+gTzfQM3oOy2UvzSFTrMyj5zjy4k4QiOrvKq0tfqSbGJUjZ5q8RxTVl1GgyMLY6NWLdngizOmVed0zqWbpc/aZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966804; c=relaxed/simple;
	bh=QOiGbaE5e4Oilgl4riZ3uOhshIziV9C8yzTAlB5OR5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQFP/sh3GlXXTomWbmvKMTXjzmVG4HOD00FOnL+ySjFXUv1C/RTBmHyQhpDjDv3H70LuZrfceTij7haqKrPyQig+o1g6vi0qh5W8SwVXhp6yzzsupUnubzdaHsHUlFhn50TrZZsEHgM7GfIH6QY2SdKQg2QjGxhpnlUwAoZMoBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bIRa8j9H; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RJ1R6QFvu+f3ZSIooTJgEUkRpCF7pHFNalYZ2D3/VP4=; b=bIRa8j9HZ/ah9V4ALH8iwwXtgZ
	hxBs0pgNnAgUudcDR/TqnukKKR3P1ob51Npv6uKJYHGOcQujkS/HOVg20vLauDa1n70Y8pmLd2ZGW
	2pDor3g8eaiCJyw30bQHsPc1WkJLTn0zKIgActLncO1STERNs3LAeG2TCDHg1Ng8hZ0x7civlESWc
	66CuUAz4+PQiACjFjAA0Dn4CpIKImNpUJcJxAxPGC3Xc7ibLv7V4538SAt6LjF278Oznp87JuCi0K
	BmLmCyJnJ7fMfB+1l7Goq5+8iSpXQOX5pEmVvIb/yfMIvukR2/dALe+r0UM81+xv2HRkpId/YTzku
	7kRgGwfg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYfv-003zRM-1O;
	Thu, 28 May 2026 11:13:19 +0000
Date: Thu, 28 May 2026 13:13:17 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 6.1 1/2] Revert "RDMA/rxe: Fix double free in
 rxe_srq_from_init"
Message-ID: <ahgjTfDry_UjKgYs@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gtn8jZEI8/C8+7My"
Content-Disposition: inline
In-Reply-To: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254847-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[decadent.org.uk:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DAE245F11D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Gtn8jZEI8/C8+7My
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This reverts commit d286f0d4e3ad3caf5f0e673cdad7bf89bf37d947, which
was commit 0beefd0e15d962f497aad750b2d5e9c3570b66d1 upstream.  The
backported version did not move but duplicated the problematic
assignment, so it did not fix the bug.  A proper backport will follow.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rx=
e/rxe_srq.c
index 115ff5428f6c..02b39498c370 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -87,9 +87,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq=
 *srq,
 		}
 	}
=20
-	srq->rq.queue =3D q;
-	init->attr.max_wr =3D srq->rq.max_wr;
-
 	return 0;
 }
=20


--Gtn8jZEI8/C8+7My
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYI00ACgkQ57/I7JWG
EQlIShAAnZY6iJkb31Ctv5kU0sYZVSryXQ87t3GewcOnjbuIaEFGBvw4BqIOVsGI
ELniehLJ3eX0ws5A6aX7OW6i4Bd+8OfjIBR1Yw9on7Wzt7rnrwmVeb3wzuBcATZm
DGWAtxh8Xa7W+uDVNWNqz18ocDL0zssu2WFAd1WFtZ8m+k7qtNDfKJa7MGXHVrsm
Vci76K9ILNVHQpV/p6kJ1VEbSLX391UJ2x7PJFRI5nSWzBsQJt7n0y7dlSIe/4q6
sLWKTH5wPk3LOPYCj3YPCbYgNuBcdPI7mqXvLjHvV75VS6GAqwDGGajR0yz5cRZC
RMNO6busIsP+FMLp7NM3uyYHS8++oY8vpMT7wofJVMTGhfnvj9HtGNuMIoV7V37i
XEXuc3w8fGEgxHocV5yKWDT21LAFbjOokX44UJ9ZCJfUmFvqDyVGa8bC39C7AABa
EpEqry4QAMIznboxInhNDKkFA6iYdLFVDokR1FGQjTHxth3n6N5p6QjsRg9g5t0E
QAxek78OEFrIsdL25Dzvutl9uXhTsndn87P1ACAwL5w+bgZO/PrUZAv/vDESNJ9a
48RawODeag4N4zQvplsy25ljSfx/+oyzo4Zi/RlKgDgoVPIYxFyFE1m+C2UQ4ANY
7PAPIUwrd6lpW5uBbYfMOM0pCc/Kt4jwwwSDZyGXfFHPBEsBqNs=
=k9tF
-----END PGP SIGNATURE-----

--Gtn8jZEI8/C8+7My--

