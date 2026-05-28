Return-Path: <stable+bounces-254841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGUnE3EjGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:13:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7315F11E5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B847312D94D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74793D25A2;
	Thu, 28 May 2026 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dWWrmFwZ"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23F23909F
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966475; cv=none; b=aVcWxrFkZ17Dw6i+ixAg5Aiq11T1qKJo0J2aImNZqIDvFcjSsTwKHSVIEfgFA+JOdgeR6Ej1PxtZdnHjwZVdgz9e1dE7NWL+DXu8vv+TckAxZ0Cwlvl2J8uJFioAmgGRlegVEcAtMcvlqdbtQn1j/BEfiSWJPFahTqwfG5s+ZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966475; c=relaxed/simple;
	bh=2V7fRNCOQmQ1RuoRhgqBtfhR4UuB2c9cMwKbPKmzBmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnb+XzdtAAG+/x0Tikafxfp2YTgzLHZtHSFpxEAtU1E5gx+i4zXsTqDYaCZtRO2vjkt+08bcYbUCNBXRw/lPjxt83b7wdFXR3XagR3hx9GXSNNAgDQgXmK3TNtZNfNVU5jRjs6hNuItZg3iAvO6Uep8Vn7QQKr8BuLXcpjBD/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dWWrmFwZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kBuAdCmQAYb45DSAZDj9h8lWnEj4bX+DOS6N+uBxw+A=; b=dWWrmFwZKEiqs/eGRNbWgxII0t
	qHw4DZqR8TyKYwqJqrV7wKYmcNAYzqcAoNcsarA9nWwloMGRAadJg3WCdF6vZEjkYdlRWxXrpKpO4
	omXnszRn/YHSr7zSYVD3vRwQmm7QutJ8U09Vdfi5MUN2p+TnTGJFaYGMVFmSaR33NJ66+2Ozh7QtL
	mj/cAdvG3/P3iXZ3MiVVE/sQEYUfng7aZm2rFO7798jSxBYyFjbVGdcjl6WdM5P077MHoZJu8XDl1
	r5PfWfhKWUgncTVeiUEIDq3swqpQffKYgA2wVSN6taZ+qAP4cDy5tOmUmOBFlQnfN59ZnlL7QDiEk
	qwa0mngg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYac-003zEg-0y;
	Thu, 28 May 2026 11:07:50 +0000
Date: Thu, 28 May 2026 13:07:48 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 5.15 1/2] Revert "RDMA/rxe: Fix double free in
 rxe_srq_from_init"
Message-ID: <ahgiBNbwo7FudH9r@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mwxf682WMd8WdaYY"
Content-Disposition: inline
In-Reply-To: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254841-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[decadent.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DD7315F11E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Mwxf682WMd8WdaYY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This reverts commit af5956243018918130d52c9f671efdb40bab3366, which
was commit 0beefd0e15d962f497aad750b2d5e9c3570b66d1 upstream.  The
backported version did not move but duplicated the problematic
assignment, so it did not fix the bug.  A proper backport will follow.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rx=
e/rxe_srq.c
index 05ae3d183b21..eb1c4c3b3a78 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -118,9 +118,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_s=
rq *srq,
 		}
 	}
=20
-	srq->rq.queue =3D q;
-	init->attr.max_wr =3D srq->rq.max_wr;
-
 	return 0;
 }
=20


--Mwxf682WMd8WdaYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYIgQACgkQ57/I7JWG
EQme0g//cQ2xE0ZFTFqckZQn1GzfNSwp5h1EHy3IEFR/KSj3ALfrvMHpg55T3ZMM
F3SBybwSt5JUS/xP8d/eC6uj1bO1xy8QmvMWrOzhnaX5aQOr0jpP5ceLG5BpFcG+
O2IGQ2yxoItzt7PTRMco67sunBF38usCwWJO8Yf5GQ5Xoa2NdmhWgDBUcjqULKzf
icIG29miBcLUH0b6u5xMJWJwnciWaZKgJaP8iKEpA2zWDO1GDcraMh1N5MTn90wQ
v/9Z0JVDZUhlsw55PXMjg2w8NCIsg0zTvAG6Ws1CXN7nmpOaIZai6NMZe6qkIzDs
+zxRU7KLm9D8yQsk5beTqAWgEThxUUOO5n8Cf5Wfi5xQHrmQC5iAmr+jKGx7JMTY
ddoOSdi2jfqMpT6WqyLnOKd0jbhe+FMxjZWHtiRW5obFhyEmbiPaBxgd/ReW5ivj
5MFspPTfvhnKkrY2CeMsgCeY8PRrF7IpInw+UK7Omz69qIAPxM06bu/hVcgB6Emi
FqVMyhvK6EuUhj3eHkMAJfwf8fhIujrEwdiRVbai1RndYtduqIDyjF7bjoG6qh93
obM/CKMcSo1vUIK5NNsmb+65jL3PJkidgndn65ETqFH9NIVSigtrsFa2fnioD1tO
Y+BhG+rTMpFzTV9GovG2rMw7lUiKLDESvm1fOyZvviG9XKaze/w=
=JDJa
-----END PGP SIGNATURE-----

--Mwxf682WMd8WdaYY--

