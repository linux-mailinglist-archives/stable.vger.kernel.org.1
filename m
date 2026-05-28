Return-Path: <stable+bounces-254840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AO2EF8jGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:13:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E115F11CF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C2C31944AC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489B3DDDD4;
	Thu, 28 May 2026 11:07:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570D3D25A2
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966441; cv=none; b=sOy/vJ7YhGcb9vpWfjkzrbSVt0tetKe3yJTTMw4CKDalIPVKwAYSpWk91z6fVOIU+81qq5x7fptnTf4ODP6aA6PcGeYjJj8+gIkwGJ4kkmXzgDq8x02gHDLria/wBjWkQzn8P/KKMdoe5QQEK+FdW5b10et8zxKv58kNOKkGQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966441; c=relaxed/simple;
	bh=gIOe21u0uGvpG9IP6DDR6pvC2gZ5qaGa8jsv2s4or+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXJwsBoitF2U4M2hcTnaM+NdZcvIheah1ybyM1cadS8O8JdfDgkvh/Xf8JsCzmiXhv8N2jzPYBmvHA3VJ6Qoy4BQa5Gu71Nl5qGkyEMoMhEs3CRlOyYc71PRJa1eYhQvFnCCGyi1wivZbDX6KEdDoqZvtNhUW+PEDK2qO8MNWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wSYZq-002RZj-31;
	Thu, 28 May 2026 11:07:01 +0000
Received: from ben by deadeye with local (Exim 4.99.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1wSYZo-0000000DIbd-1dkM;
	Thu, 28 May 2026 13:07:00 +0200
Date: Thu, 28 May 2026 13:07:00 +0200
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 5.10 2/2] RDMA/rxe: Fix double free in rxe_srq_from_init
Message-ID: <ahgh1NzAqpY53SzJ@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vVCEpMqSuMyEdbJW"
Content-Disposition: inline
In-Reply-To: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-3.46 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254840-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiashengjiangcool@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,decadent.org.uk:mid,linux.dev:email]
X-Rspamd-Queue-Id: 99E115F11CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--vVCEpMqSuMyEdbJW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

--vVCEpMqSuMyEdbJW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYIdQACgkQ57/I7JWG
EQk/sRAAhNi5U3MUPnoLTUQLDzygt5e93IfFOuyD2DQ7I31WQBmFd1VQu5jiBhsa
zmGIcR449DE8WkMnpcq0MRxutZk8M39TBzw+khdrNj2SPcSwBvZ05ONhrmIRjNwm
zcux5/epwJgZ0lggTRSr0en/hdIeCiBSRF05Za55FbSGyS46PbtMPca8DRbu3yaA
kDuJ7yT0B7oLBKAko/8irtVOJqRBnTq7DPqfzYeYcnMDoDiEBl2aHmq3GxOEnZiq
08VBi23v6+Jm8hS9vPzPYa1fiH2mzzMKlqCfdY/YdomKUde25cV+Z3PXqz/Eu2s6
cUqlohLlkenkglzwVh4G5qy7k9iP8Y6PncwsdUh5rgqSocW22tSee/l/Ug+O+2zg
LoBnpMG1yJMybAg1ykxzriPawzwMSE+8ZbO4cZdljeZt8H0Ybk4Fr79vZQ4hZEWx
4j9oGfUfb/SFOIy54lSa/byvUHanKwm+Y/PE33OzZ6Mpv8kZDxRGhVaGDVpemw8w
f9hRM8X+DbW6eefyDzusQqN1E2gIKq+yNVc93h7vSpWRrClSYsNN+gahExPvn60/
7lntSHWlUzjfKzuNnEOSr/er7Obtn5zJhHklHjaEBpA7XZ/kowmk1gQCCaRv4sa6
dfGC8YyVLPrzoMjoHaw6sa39lmfpGC1siuoV/VhJK3Qp1/iKJCI=
=X2n+
-----END PGP SIGNATURE-----

--vVCEpMqSuMyEdbJW--

