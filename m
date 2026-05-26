Return-Path: <stable+bounces-254290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLJDCwBwFWpbVAcAu9opvQ
	(envelope-from <stable+bounces-254290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641E5D3E20
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00833035D7E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D43D79FD;
	Tue, 26 May 2026 09:52:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF99346AC1
	for <stable@vger.kernel.org>; Tue, 26 May 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789153; cv=none; b=KZ/y61II6Jso6hs+7hCRdQavdoRu5qCylj4HVsMZ7C5OLo7DkSt9JWf+ZpjplTYrEnqMxruDSatLVNq+f/wvrrHBAtbFeDT9ZyLF+t+ffbDNEBPLuybBftLCHTepvkFpAB0D463dmdcvGxBWxClZ1BmrHxzTXJBFaJV2ZSYPn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789153; c=relaxed/simple;
	bh=3DGt8l9WkVXOJ6Fu0nOlF6mq5b8udPy9wslQHAs56gE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=pkD5TMohnjipEsZ89RxxJZ5IErjgwu6cBecfrBbC1qDBH64gjSIR2ZSVu32Z5bss1+IrWOWsjMR0ey4vlZvrRuo1q5mw1T42U7C5YkPCtxUDC2a+M+4mNxAZQGIimhScXSE0CxB8V+Ly/jU/yXIwYl3fP228jRbnZI/7cpPon1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wRoSU-002B5I-2A;
	Tue, 26 May 2026 09:52:21 +0000
Received: from ben by deadeye with local (Exim 4.99.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1wRoSS-00000005Lkd-2FeG;
	Tue, 26 May 2026 11:52:20 +0200
Message-ID: <14797eaf17672917e7c62a679de22f3d1e25edf5.camel@decadent.org.uk>
Subject: [5.10,5.15] i3c: fix uninitialized variable use in i2c setup
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	 <sashal@kernel.org>
Cc: stable <stable@vger.kernel.org>, Jamie Iles <quic_jiles@quicinc.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 26 May 2026 11:52:16 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-piwiRbyng76hw+Hrvh7T"
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
	TAGGED_FROM(0.00)[bounces-254290-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 8641E5D3E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-piwiRbyng76hw+Hrvh7T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit 31b9887c7258 ("i3c: remove i2c board info from i2c_dev_desc")
introduced a regression which was quickly fixed upstream by commit
6cbf8b38dfe3 ("i3c: fix uninitialized variable use in i2c setup").

Recent stable updates to 5.10 and 5.15 added a backport of the first
commit, so they also need a backport of the second commit.

Ben.

--=20
Ben Hutchings
Kids!  Bringing about Armageddon can be dangerous.  Do not attempt it
in your own home. - Terry Pratchett and Neil Gaiman, `Good Omens'

--=-piwiRbyng76hw+Hrvh7T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoVbVAACgkQ57/I7JWG
EQnTBA/+PGvWJLsOR9184QpMxWM4JawQz+ST4AUA3j8Xp4PSK4pskRXMvEjFtOmJ
g1NEB6zje+W///2llHAoS3LA6c1fF2wl38mLY5MFu9tFZs+fwAaXOW6fvtt7CFnn
YOS7aqzO41DO7JBRLmaSvyGSvixn/K2ooB2tOvuGgsHZ3HmfF28DVMACJ8tRLM/q
jIEEx0hnmv630n85K+xo5ckBFs2Y82JyP1wlOSYQ0/1gt6f4e2HLJIXmMwcFCllB
2LJUtGh+BdRQm6ZmQ3JWxjyx9HcXikD4G3fnqI/2+jM83mrOUcAIEKNvCMiTCDGj
GMr2K5nFKVHHc7cvsAtVw0IPtNtFrkpzo5w3FJzCUPEgfdWlh0i4XAcKO78ak7xK
xKXnBPmEQMp7/tn4lg3oRb7XbPJTwdpMm0Y3efwglFW3NCPuDF2dywU09gYT9aBS
u3eqsomGiDiVYsDlZlK82JQYSwo6UJNKVbzqvfKy2yBkwM4UpQQF3s9/WbCztXxl
JV6s3RoZG6uJWOLaoBrHC7al38FbN7xcfPCvD5J3Surlheh2MLZN04FV8F16VtMQ
Wbydv7tUySokD//CpiPTCuXWcnSRGW7hfUYVGB7KFszI+CpJUecbKlQZexE2g6s9
EtessVK0syMSGsvKntF1l/Kpfh1Dwxh1OG1wlvFnmocznEEtUwY=
=UxW+
-----END PGP SIGNATURE-----

--=-piwiRbyng76hw+Hrvh7T--

