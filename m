Return-Path: <stable+bounces-254848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP/lKZYkGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:18:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1335F12D7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E4F33147CB4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D910E38B148;
	Thu, 28 May 2026 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qJLVdgXP"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF033C3C00
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966826; cv=none; b=NwmLZd2rbftK7+4T65KUl0b0TcoJhTKvKBztPIbpCzVU8wSxY2RBgql2s8D0WoL+9NqTb/MbfE3hs7AWSjlRKt+5iWQZX8+kXG+rkZgvkY+J0YNpmbKTH1nvx7/uhw2sVTn3tktH0G58MXqJsO9/+WjDQkKX5Vv4G1RvVCjD74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966826; c=relaxed/simple;
	bh=rJeHzWYw+xMTE9jPe1B0iYwYdwW+VBvawzgRgrIwq/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce0/NCJcBrx/6BOZPUaK7FkkYprvul4S4jZ5LJzItIfpP8/a/3EEVVuyfBporS2QXrAXcAmFf3I+52otFUBzhBJm3VzitrA6R1sewl6HVzlKfWw8sEEQABhs0LZaw4SEkWDOa1Nh79sHP7wmT9GOv3lS4Tunun1rGaDDilcDlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qJLVdgXP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DBpQCtIHhcNzbDeeZaXjMEPjhZpOpGNsEnNwcRtJyIA=; b=qJLVdgXPQK8oqeOH0I9cLpQ97Q
	/eNPBwGn/X86iZkjsZpxSXEqt8D1P705W+Jj3+5vHFgYr8vWxMxrDpre1n7ARFonMmLcQAge48coj
	AZRhCo/pUkQRry3zRkvwDGtnNtgVZK1COwsCy4sNeZ41cMS7Ba18Kpiv07iMZNQmOuJJGpr5IWoQ+
	7Tga7oY0HAsRlUBFewchmwiaI0VUQnImdGm7k0vxS7FRAhg/696oN3EesRhyfGXcxAj0TOPFiI+zf
	5SjHlcBWX71jF49XbDgDM0TVBb9ZqB7sjjHcDxTWe/e+Nrp+DzbjwOgT30kLiRl/yrIsy22bL90/S
	amOs5EFA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYgG-003zRl-2G;
	Thu, 28 May 2026 11:13:41 +0000
Date: Thu, 28 May 2026 13:13:39 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 6.1 2/2] RDMA/rxe: Fix double free in rxe_srq_from_init
Message-ID: <ahgjYxBbXlUjlFUz@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A0mG4lIf2iCcV23E"
Content-Disposition: inline
In-Reply-To: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254848-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,decadent.org.uk:mid,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F1335F12D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--A0mG4lIf2iCcV23E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Jiasheng Jiang <jiashengjiangcool@gmail.com>

commit 0beefd0e15d962f497aad750b2d5e9c3570b66d1 upstream.

In rxe_srq_from_init(), the queue pointer 'q' is assigned to
'srq->rq.queue' before copying the SRQ number to user space.
If copy_to_user() fails, the function calls rxe_queue_cleanup()
to free the queue, but leaves the now-invalid pointer in
'srq->rq.queue'.

The caller of rxe_srq_from_init() (rxe_create_srq) eventually
calls rxe_srq_cleanup() upon receiving the error, which triggers
a second rxe_queue_cleanup() on the same memory, leading to a
double free.

The call trace looks like this:
   kmem_cache_free+0x.../0x...
   rxe_queue_cleanup+0x1a/0x30 [rdma_rxe]
   rxe_srq_cleanup+0x42/0x60 [rdma_rxe]
   rxe_elem_release+0x31/0x70 [rdma_rxe]
   rxe_create_srq+0x12b/0x1a0 [rdma_rxe]
   ib_create_srq_user+0x9a/0x150 [ib_core]

Fix this by moving 'srq->rq.queue =3D q' after copy_to_user.

Fixes: aae0484e15f0 ("IB/rxe: avoid srq memory leak")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Link: https://patch.msgid.link/20260112015412.29458-1-jiashengjiangcool@gma=
il.com
Reviewed-by: Zhu Yanjun <yanjun.Zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[bwh: Backported to 6.1: There was no assignment to init->attr.max_wr
 here; don't add it]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rx=
e/rxe_srq.c
index 02b39498c370..038a9cd55413 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -69,8 +69,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq=
 *srq,
 		return -ENOMEM;
 	}
=20
-	srq->rq.queue =3D q;
-
 	err =3D do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
 			   q->buf_size, &q->ip);
 	if (err) {
@@ -87,6 +85,8 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq=
 *srq,
 		}
 	}
=20
+	srq->rq.queue =3D q;
+
 	return 0;
 }
=20

--A0mG4lIf2iCcV23E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYI2IACgkQ57/I7JWG
EQmQwxAApmTQ7i0Xc4RRXlWc14S3sAePq8r2Z/+MiUO42BWuxW5lr1QjQEEuzNrP
xWOGBw7NEq4eFkshT/9WUQg0rXubMiBXD8DyAx9tPfMQUQqZXia4YoPs4Met3jJ2
/hNkTTKEJguMDV6EmNQsWPllbbyUahn+aKFC6iq0upZ72+GaLNAJkU2jpNM9sJIc
4/x9bVNFPMKjIKTvK/uO9aHHAf4HckK0ktB6kXa3xPwBA/MKaOhaFpgl8lwurFQk
MGR8gTfGnxqgx4Fcuu/4oDUptdhqFtmeu0zP8CcNEJoLE3V8zK6FSbPT+Vgx1xbX
mBh40CK82UxThyhGBzHNt0t0Huu1tx8c7XdPoC0dJ4xf/T+khJc/HIod0unm2S2C
A7HcKiX4cClk3qE3f0lDX5ONep3kXG+jNCzPoCKTuwVQhCHtXw6LNB6cOC1JH/yp
xeNteIOFnmToOPsMdTBopSGNuEo3cDK/d7QUC2Z+oOMEw9iMMl7mpB//p7PFLb+f
44hN2FJLQ7rxuOJebDs0PK6Zz27momU5uNfD3OY7pFW4XJFDYSOXbfN9ZNWmi4ls
RRzqPqQQc2UA0MxCLyXp9UY3Ut451aIVqhqpTpl9dMqP3BOat0fVf+yk6jrJfNGV
qQiz9vi5zcyGT596dYbW6gL6hlxszyhJdrRqqUgQmgEOLgt3W9Q=
=ARY6
-----END PGP SIGNATURE-----

--A0mG4lIf2iCcV23E--

