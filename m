Return-Path: <stable+bounces-242799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL5YExpj92mZgwIAu9opvQ
	(envelope-from <stable+bounces-242799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 17:00:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52304B6258
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D638A3008D0A
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C01F5821;
	Sun,  3 May 2026 15:00:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80DE18E025
	for <stable@vger.kernel.org>; Sun,  3 May 2026 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777820438; cv=none; b=T8DgnrxOPyJ4KdmADMXUeIRkC8QJBRKoxFr73+/XuGCZN0yvDBafafRUxqoh3cmgj/nw+g/7iqPbPrdPbbJamRliLbpQq97bMhm4k08SDPtjSLo6AKGjO6MrfFf4M/0ouzfVY+mJgGObK+7d1UtfU7hZCnkyTBOafDHqz5beTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777820438; c=relaxed/simple;
	bh=a0Z7KXVODp296+pWq99esyY1twmr/U9ZhqDuD7O6KAs=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Ukkp02qbYkRGovt3+w4fLUZTpUKw7HZ82ieSYMcCPjHqZMyFf2XKYg7JlUJiipZuQVUXDzMeL/CQnpyB905Rla7h38Ve5Qr3WaELBRio75Iz5sKQURYwomvi+tEXShh1a8nyoWa2/vUY5/PC0xS3lVg9QjGtTdJ1o77u6G3OOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wJYJ3-000Iwu-1T
	for stable@vger.kernel.org;
	Sun, 03 May 2026 15:00:28 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1wJYJ1-0000000AYFM-2I6M
	for stable@vger.kernel.org;
	Sun, 03 May 2026 17:00:27 +0200
Message-ID: <f84e935e26fdb239b473443efeb925bbfbd5b182.camel@decadent.org.uk>
Subject: [7.0] perf loongarch: Fix build failure with
 CONFIG_LIBDW_DWARF_UNWIND
From: Ben Hutchings <ben@decadent.org.uk>
To: stable <stable@vger.kernel.org>
Date: Sun, 03 May 2026 17:00:20 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GgaC80eJ6Br4VeNdO0Zs"
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
X-Rspamd-Queue-Id: A52304B6258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242799-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[decadent.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.890];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,decadent.org.uk:mid]


--=-GgaC80eJ6Br4VeNdO0Zs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please pick commit 841dbf4871c5 "perf loongarch: Fix build failure with
CONFIG_LIBDW_DWARF_UNWIND" for 7.0, to fix a build regression.

Ben.

--=20
Ben Hutchings
Time is nature's way of making sure that
everything doesn't happen at once.

--=-GgaC80eJ6Br4VeNdO0Zs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmn3YwQACgkQ57/I7JWG
EQntsQ/+LvwCRVg1qVRwivctrEKU9CUjtDCtr5r/mYzJohjlJStrPe9ro+x5Ld5E
LbCA1cK7YIeFZfIweqSLnk6EybTfliRT33qp+EL1z26YR9IjFZV7LMitN3sqjdyR
zkPAunzrlKMaTetUrb+BksWuNGfB9O7nU64jHgW7t1CZyua8vKN9d6Abd1vUweSl
OUUkkc6J2UF+Rv+I272mf3DLn2zk0d4U3IJ+OX9LIgq+wmDRFVQcijRwY2Umzulk
jHE7qE8dnS/X7uVAYgr8opRoztFBbZYhK/qaeccat5Db8iZjdjh98Ft5Lm/T9SCg
2PPG9SW5K+3BffW+Hr4fS3RxTORcwFm0Fx4VeeY93WY40CMZwVCJDqOuxNHf+wRc
eUkF4pGkydsLkWWPRaVGaE7NQ9bLma8ls1fBhBI9L6xBkbkgyKX2y8xkPfo8rKkS
slb5YWz2do8A73z7DPcnqYHjjiu3eSL9xAZwD3tgfBgNU+9QkWqgL4FRqFU33cWv
MPBK58sTvEt4LBUfdgGtSXR5ImVm7Gilpp/QSE2y4p3s+fRUasyt9SKeen484Npd
0LLh3R/XkGy/pEKggonx3QsEBCyWwvZZPs8O1QMm6ZGj51XC4hkn6dNZIRd5JR+r
cm3eQ3ZmD7c2DsAq8dJRp5E2wyZucjlrDsgyy3UoEKbCFsnnjMo=
=TqCY
-----END PGP SIGNATURE-----

--=-GgaC80eJ6Br4VeNdO0Zs--

