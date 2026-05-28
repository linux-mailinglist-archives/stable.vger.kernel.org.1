Return-Path: <stable+bounces-254839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMOtK0cjGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:13:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A455F11B9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5EC33178429
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D373E023E;
	Thu, 28 May 2026 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gooNg2fF"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2043E0250
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966416; cv=none; b=hgX47TtoqrIEyJkHbbesY7qzM73SR0lKZZt9BdETN4kw5Sw1qecuz7CVJytU1pFSS272qaO3hTx722cS8CzZBOc/khRbS4apLcJQDXFha0W0Fgx3zW6DTLvvNUMXWHPWNCr4DAuPoNfW7NnNVN+D71PkPmrsUWk7sBjZhAKhhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966416; c=relaxed/simple;
	bh=LyBLU1WpilfCdQIa613QV/Ne4PrUUyJ9scKn7Vhx0qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/YF0FD0ww9pP47DPe03rz4XqIm7+dPKaAhcorFLbVWakPpRVFA8H5wV6yBDA3mTcddsRgPR8ZgXrBhgOZA82CU/Jbmsg+G+dfsIKr5cyetV2qemed6i0be/tVLMvw2ywX/5kB36XyYYZlmariRl/Ce9+K20aPlqtNOnpN+tqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gooNg2fF; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UEBytgZRkICHp2ORpNI8gDl2JqkGxoPRspbRMFpDgM4=; b=gooNg2fFt7YES0REvg/uFPQ8sv
	2TrgKJf8vDF/z5iEmLQlZhjoiIlvp9e5dpvFZ0tfnLUpdQGul+1TBtbU6wFXHs6UJWPvduPDCsc4p
	gDDOA0UESPYou1TDiveeNaDiv/FZ5ymvX04kksr5C7VDo2Q9/KClsr1OcUc5WOSvfs2ciwHI/Aj6t
	09pNOKg2PvaNW4Ld7+0hItl8JLWbuidLP2RwOcKj+BIVtTjYP7+47Fsd/82iyzChhuTum0L0vVB7+
	nQVm0sAP6vbLlNPfYLSTs9ZXoBrqgBEXEViCZzIyK69eayALsTZuXHHgh5qV2iLj9aFio/xqtLJNr
	jPNd4nTA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYZb-003zCu-0O;
	Thu, 28 May 2026 11:06:47 +0000
Date: Thu, 28 May 2026 13:06:43 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 5.10 1/2] Revert "RDMA/rxe: Fix double free in
 rxe_srq_from_init"
Message-ID: <ahghwxSf9me8PHM4@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1z4NcQnMIZFlwO3V"
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
	TAGGED_FROM(0.00)[bounces-254839-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 27A455F11B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--1z4NcQnMIZFlwO3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This reverts commit 22b8c23a3b92d023614bb00896fe364b2c1a31d3, which
was commit 0beefd0e15d962f497aad750b2d5e9c3570b66d1 upstream.  The
backported version did not move but duplicated the problematic
assignment, so it did not fix the bug.  A proper backport will follow.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rx=
e/rxe_srq.c
index 9d9baca26949..41b0d1e11baf 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -116,9 +116,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_s=
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


--1z4NcQnMIZFlwO3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYIb4ACgkQ57/I7JWG
EQlgFxAAuGiiBgEX0iWh1MK7vNLuTb2bFfrnOqbMZJdnwl69gWxtIV7hFt9RVSMi
FYwRWC6kfcOGLmsjJFIv4QeWBGvdpXm0EA53JexWPbLDxfOsLMlbqkrTYKgH9i9/
00UY5ZghCi/r8zBldnH5gzoT/Sx81DXjBHmVb3jk4pARTh11bbXtNcM1punNbULv
+seDxJiTGjY20uU3t505g+zF8DPvfBjShmXW5Q2CxalDpIHsCVdYbAL3gWBd3DPC
BQK670IQSsEKhc1SyfCbzZtwt/d6ApA1sMzXXY4eUuAf6SvDA3iCl3dmP/NqOvNs
/dcKQcKjqVmzPRVPTFM3yIf4OPyV/QaUeeDHakyhGcUf+y2mLjzRJ+PSl8fshu6j
RP7lUUoRBp+vrQwF+sXP7MD/r+6Rx0ATK4gyCiOR1Nk5jwvJ9/Pd7T8/t0/+Kgg7
2h8Kz3VgcfP3zy4vnu1YJBjvPdbg0TWSO3suUrAoO2o6I1/mE9ZG7xWslVd+9mdv
MQ7AWQnPlW/4cV1f/dzwAHphWC9Rq+7AddDIjujGfeamu/uKZgQS+cU2erGBDWvp
daNoptEKeJsuOLlwTF56U+k3jyxypYUbtmYyg2WDj9csmLL1gKM8aVJERzs/sbeh
AE1QUpD29O61j+QGhIaW/B+ELdYoDfpyBd878utHr4ZVWKBwcWE=
=ITrQ
-----END PGP SIGNATURE-----

--1z4NcQnMIZFlwO3V--

