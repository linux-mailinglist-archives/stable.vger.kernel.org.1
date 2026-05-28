Return-Path: <stable+bounces-254846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOjoISEjGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:12:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6B5F119C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DA42300ACAE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936483D16F7;
	Thu, 28 May 2026 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="e8TJktpG"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B03DEADD
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966749; cv=none; b=lGfrOWLWy70IbZ4uD9JDAqvcY8mr67m3LW2vK7im+pIz+jULmwk3GkX+65rNOgrGUNw3E3uTHOYW4/iQiWbJA9nCTzvArbLfJd7KiPkSDVjAWzmdgPBa1JpL8MvHaL3lDRU92PnVVuo1UvOADJHgK7/IiHoI9iXPhL2oTGpErHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966749; c=relaxed/simple;
	bh=ovvWK4OuPTZRTkgRrTnw58ZXmFJmf9DFp7GcS9QRqUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXIYlUUeVh8+jFAgwX8lp80/oyRbMsZD8GHcHQ+Ah5eHBtwUWKJ9FNk3Y1xe90IduKL1WzP3HB2I7QaMNQoBG/noKHLjCIg3lvGhTmH+YAP6cR26mpEDDX3/M/Ol6lI3zQUJeG3b6cMZfKAJf7fxO3Itr4514sRDDQ+l+cirt9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=e8TJktpG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IOdWohr1POHBR7VPD8y6Os1ROQBFR3R0iD0eDyaqDos=; b=e8TJktpGKICk3fqu7pfjteT9gr
	90QzS+9LA8qwqsx2qz1PVzfK12N0JOjPmmlXMmm/OSeGSBjnHaog8flotTDEgcZE8/zPeWKSW5Lve
	OdaWtwAHzrGauGSgV27icFYVj8k6mC7qE4d/So5yXArQNEqiQLmLrNpNLwQ/Q/K0necwkHaUVRnOq
	fB02ECrTF3lOKrPXCalej3owHjOsrll+C/MU0roJOi4i4vyrCJtz6ogRuq3l+Z4ibpB0jSbE060Tp
	aRg+f4CkuvGTS+J8HYICjUM7cx3ZBVibbCVU/07/mYeH8LLXLdhGQZrK+n/mEtl3GzAGY1Ue5pvPu
	+UF0+7qA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYf1-003zPb-0i;
	Thu, 28 May 2026 11:12:24 +0000
Date: Thu, 28 May 2026 13:12:21 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 5.15 2/2] RDMA/rxe: Fix double free in rxe_srq_from_init
Message-ID: <ahgjFad4eiurr6KR@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ACcJvqRJn57UKUmQ"
Content-Disposition: inline
In-Reply-To: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254846-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 29C6B5F119C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ACcJvqRJn57UKUmQ
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
[bwh: Backported to 5.15: There was no assignment to init->attr.max_wr
 here; don't add it]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rx=
e/rxe_srq.c
index eb1c4c3b3a78..595d4e7b91d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -100,8 +100,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_s=
rq *srq,
 		return -ENOMEM;
 	}
=20
-	srq->rq.queue =3D q;
-
 	err =3D do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
 			   q->buf_size, &q->ip);
 	if (err) {
@@ -118,6 +116,8 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_s=
rq *srq,
 		}
 	}
=20
+	srq->rq.queue =3D q;
+
 	return 0;
 }
=20

--ACcJvqRJn57UKUmQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYIxAACgkQ57/I7JWG
EQnRRA//S7ISL+2XWUIE3Yu0xxH6CRfS+yBjejBuqHc4Lv/xEoAQDEIn8OpWg7lo
8WgQri2caUlp8KY8fovHPg2c2BW4NOTBgY6jTjp48GnDxLb2iH9UsimjsDe44JPZ
OHYuDBYRiyBUmtYCZa96wepu/txtqqxgHyHioywIbV/Kl8W+x2RPVCZVlkRCChlu
LMRA6ba2a7DQru/wyVaXFWJaLMHsH8p3hqHQup4JvLEyYdVm5vnOVbeLtzOEN+NH
pPYiuJa4+eHznv3NmbTqyf7nnjhzCcilz2tswTZgqTaZTGHUNqKR/2VkMRO7v+Cf
EvT/htPLO1Kzt6zrZvvk4UbYQF6zTQWV/cDO3TFFEymrNCkYLSIF427dYpXYgk0T
nFwJ0NbKxOa+pYDp6/6RAouy43DBHUcyzSJwEL+S3XukX4N5Y2BF3af2JkXRw+9C
gPobWCONS7ghaYE8+SP1rMAIGwU8qRc4PadRs6TXeDFz6H/VlT8zRhpRo3YVHBZR
VsCv9PP2oFZdDwH+yMtO/OS5TuhUJR7KQPgD2TKwPSV/F9mOFsM22Ek6Hh1GqgJE
9v9ERgI5tM6vCUk5lfYbJvTW12yYPKBHOUn8ZJuvnD+RpUDoM3rFuJGaNEFsIP2C
vAQAMnkMLyCGDYuMEH3+fkfRhIAhkMYBY66TTd+2toSx+TA1oIE=
=bIzN
-----END PGP SIGNATURE-----

--ACcJvqRJn57UKUmQ--

