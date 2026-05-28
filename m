Return-Path: <stable+bounces-254844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ManMRAkGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:16:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 337945F125B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 513373034560
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D13C76BD;
	Thu, 28 May 2026 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZsFexYRo"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8183E0240
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966705; cv=none; b=YfhZFIf/PH0YNOuDofINiLSedb52/XaRgPxx1n6WowhQFXMlyGxp0mg1aD0rXiPpx4ayyWu4Gvom1YnAoGI8I5jCVrFsotMeKSzhn/qd1pvhtCH2Vv6xGy15q+OAjEVYxfmPNXg/aDs4k+LZrgkKvHMj4rX65KL3MFdrwhQdUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966705; c=relaxed/simple;
	bh=vwvLdWdHl7dnzBbUGBczZfVb6yW+bdf9tnbs/O4KVb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GofaMZVxgGj8ALghutcgi0TWZW/3QdRONzerde2C3V52b2+c6KGl5Pez8xLQ7yWl2MQ6COHAwnvxEps+++Zb/+OgD+KkQMSaG8KqX8oZyT1BnztI2JDHschCkdpwUX2/FE9gzRqW49SD3UOz/cEqL3yZFcZodem13DlXX0E1Zmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZsFexYRo; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K1qC8cD3lU7xCgYde/EmMwNJQrhbibIlQm+dbEB48DE=; b=ZsFexYRog4JMRiG3/oXMygy9oC
	o8zsuK2Rqz1S08ZYmMJc5JHyIJoiL8Eo8NiIV9auDTI/boa+BaWZdh9bc4ugz1EOF+wbtF0jWpzXE
	p5hRJtO6jeaHRUxOzoBxXBO3YSUWEkxFjNXSU4uJ2r13j5Ze5d/E7d3TEg17wQTUcHgh2iAYMXU9t
	sp+5GVucm4xu03oo/a6tVJScrs81pxJtpVh7fQVrWRub47e0oat0E1Ig2oBqjP26dmEAZgFL8apW3
	blIXspRBHtisEqKTtuGTC6nnMpjbP7D5IMrm27q7o7Mn8tT6+H1SjI84svmmaU5WbJMkLZkc+c0j0
	YchWTx+g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYeI-003zO4-28;
	Thu, 28 May 2026 11:11:39 +0000
Date: Thu, 28 May 2026 13:11:37 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 5.10 2/2] RDMA/rxe: Fix double free in rxe_srq_from_init
Message-ID: <ahgi6UOiIZRpCbgZ@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HIuXv6g5v0+WaXxt"
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
	TAGGED_FROM(0.00)[bounces-254844-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linux.dev:email,decadent.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 337945F125B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--HIuXv6g5v0+WaXxt
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
[bwh: Backported to 5.10: There was no assignment to init->attr.max_wr
 here; don't add it]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rx=
e/rxe_srq.c
index 41b0d1e11baf..4e523d91e7dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -98,8 +98,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq=
 *srq,
 		return -ENOMEM;
 	}
=20
-	srq->rq.queue =3D q;
-
 	err =3D do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
 			   q->buf_size, &q->ip);
 	if (err) {
@@ -116,6 +114,8 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_s=
rq *srq,
 		}
 	}
=20
+	srq->rq.queue =3D q;
+
 	return 0;
 }
=20

--HIuXv6g5v0+WaXxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYIukACgkQ57/I7JWG
EQlLrhAA0tuwUIKgvLCoynK26EJEFcHT2Jl5GhzzAaq2LLYO5govQo5oPvqN8XO8
ktVzrDOXY5+/nr1gmN/HwjuJvec7yfzQCxKVddFLHSo7V2nmInjBfFwpyfCntx9c
9V4tBIhOlp1MPCsf02p38MosGH2Uc8LbdjCsRck3TWyf0AJ7YDH6NkwGurPonBnR
8vPdrQy7wsVy3YL7fwIHnd8auOT15LqlZlgGjWPsLaVVWtsxbj4oDtEPdyJisNZb
1S4CYZ/1cBpz8PkgrEsiQMYg1rzWGexzcoidrPftLYNZEcPhvEL9Gn/Ds3eqvcIk
frLVLcpQNadTdcB/GB/M935hcb2TOD7x1wNWiUw1KathjpFKS9SAdsL9IU5Y33Bn
vJA4eSMYxP89QFKjm/28T79CybCmQU+Avr9bVrzPKhsJjO3XMxRpmLA1/A/Fqsk0
O7KkcjoUBOilLP+/YPklivYWKrk6ODOWsOFqAB3LJHzYQHjc/48kc6C1nEbBToly
MRZcR/GdrbA0EAYnr+4//xNzMEi7kf6dQeVmC6xyGQ5shM1GcO9IxLhzEJdMNPpF
n6zyQRAcKrsAWFmPQOdOX9hB1WmH/DGX/A0XpsFX3R50l1l8IkJKo35qmR1kzPwG
zLQdeY7eXHoOmdJGVau4yif1+HCCq9KNiVPLYaJlHR4vFCX6ttg=
=V+Ag
-----END PGP SIGNATURE-----

--HIuXv6g5v0+WaXxt--

