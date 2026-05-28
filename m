Return-Path: <stable+bounces-254842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MzVMBsiGGocdggAu9opvQ
	(envelope-from <stable+bounces-254842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:08:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C325F10EE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB10300898F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D43CFF5E;
	Thu, 28 May 2026 11:08:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228E3DE442
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966489; cv=none; b=tWb98/+JcGoV2a2Bcy/CckFwQyi0Lxk4FQvR7NI1UMjDgZWvTFDmv21z31u4dByh54wQvNlpIn0iB1KXCEx0+Mg6mGcD0RCqkVrz5IoycKs+WY0l6k+ROGGXmZpZVu32IV4fGZ6iF1ylb6QvN0FZMJChsNzVSF/4ZBVRDq6bNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966489; c=relaxed/simple;
	bh=YH/5RsY27olLK8k9uSicNEH7SJdYxEQoJVRJgXupqvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyDOCEG3wPIf3/L4sTwgW4ITDicNxT/eeTElMru1/BTNrwfRPYs+mCKxx4YhPsgqDmcg4zpeOdgHhsO80YeRZy0u1djka2ewDtNBgoEGPvHsKSNlq27vtbN9JZbbGgyiqPq6ch9hHI1OTG6+DyRmeCvweCGE87EkiJLBGAK5K3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wSYap-002RZx-2Q;
	Thu, 28 May 2026 11:08:02 +0000
Received: from ben by deadeye with local (Exim 4.99.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1wSYan-0000000DIdJ-1zAI;
	Thu, 28 May 2026 13:08:01 +0200
Date: Thu, 28 May 2026 13:08:01 +0200
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 5.15 2/2] RDMA/rxe: Fix double free in rxe_srq_from_init
Message-ID: <ahgiEQNWrqUGH-Oi@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DBnIXyU2C5Czo+E3"
Content-Disposition: inline
In-Reply-To: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-3.46 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254842-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiashengjiangcool@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 66C325F10EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--DBnIXyU2C5Czo+E3
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

--DBnIXyU2C5Czo+E3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYIhEACgkQ57/I7JWG
EQkZFRAAjFIvDmqcP3kYI29eX+4aLT86wb3w+N53Eg3/fiIaxd8I8GtAm7ZzBMKc
H7hILXdz3n4os0TJdCTuRRoOR95+7U8dMK4/QRK17VgBhRRXMLlB8IrTClmPdka6
99qMAE20UBBcgJfa7k4dY2/qssq4VbCTwZ67zMEmpnmbqtnZpDRIfsbDmiZZpa7M
7ic1sUn8hV8ZdLuf0lH9jR5hRs8dbZ2N/uTHRJfqNoXaLdjUdzbHsBFo9EPjV6fg
dKWM3QgLKN+dgmqL+Xg/FwGIxM468bSn5UBVu2Fqex5MBbYy1JfAMAZfidXxzLDc
xJ7DlVJRm5TEsXEft3dYVxdGjeBvADAVra32dmNw1xJD3dKG7a1lt5s0TkuMPnRl
/j7GRHnn3JEc4SPk6+7ZwqMilsL/xdMP7fJd8096PK4WGjXpNSPcsuHCye52Phmj
wOyrv3BQU2LxqWvv7GAxjSEP1B+6b6SW7oIhQOCDIYukT8TooSGPLEg7KDeWwOEu
H+ZMKI+eEd1DVYeFFFC/oSjNuaid1IGiTD4u/FDTiJsOfw7eibKcMV+JKUsuOrUW
L3qgEExxmKmCrEfMq3OnpGX+t2TNQBxqkPwf06V7Bu9m3pfhNy54b5RtvwXZktrc
jWBoOQ6Hnw8vU8x2YhywaKiKYGRq4aQYoaDu0oNIM8WUBemX+mM=
=wMOl
-----END PGP SIGNATURE-----

--DBnIXyU2C5Czo+E3--

