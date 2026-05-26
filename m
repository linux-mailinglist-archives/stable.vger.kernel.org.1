Return-Path: <stable+bounces-254291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJXgKEtwFWpbVAcAu9opvQ
	(envelope-from <stable+bounces-254291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:04:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF3D5D3E6A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB1E0303638F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9063CF97E;
	Tue, 26 May 2026 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vCmq3YZv"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1723D79FD
	for <stable@vger.kernel.org>; Tue, 26 May 2026 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789370; cv=none; b=ZgAo5Y2GBdMWmbdH/2N+71tCaGTYIcjUegGpi9UTeXPwLsdqldedHnmZNV/iT2N4jx3NLKfa8Uj5sFk6x5ect5m4ukPflYtICBseLaMAFejtgvm6TjS5wyUDWh8q8RCTypb9q9demnfIUitHwgYCwLT0dFbCoSftRnCo17ojvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789370; c=relaxed/simple;
	bh=KGu+WmiAEmAJwbSJsN4UByAQ53FUOpeLR3rhYB3tYfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KCHcvco3jL+USA0rXzB0dSTdsgmQVypJRsN1/NQ8BJxZLKwn+f+gkKHUzhwXtLAy311gu3ZTZrQv8BNRmphXR/5wjuB6KkH2b+wxOY7EPJEettOSBhRyj+RrM+AYWUIRvS90ubfWnmoK7GI06dOtjMi37CPL5k3E3Z73qqxAn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vCmq3YZv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jPNox5a5ruY5VNEazXmCw5KM6HSuHJHDWad1Y0rh87U=; b=vCmq3YZvic4/aAtnxZtYWWVevw
	i6oHmQPoLhL1imSnE5QrE2H8AKaj2CJrYC5HK7GFt2GrZT0ANLAP47pU4oUBCyn3aD5auJxvpI4QT
	wm6ppRt7UzuSArMRxzMssdv3ZGksCsI3FHTPNBRL9szXNelBP44tLPBg7BgaenHGjLjGnL+M38JvR
	tynMBAsABtCl+BvCB8VMPFCulFvwam8p3B8yZBkaDAsJPf5XP/WkF6ltUK8K8d+zWEBL8663by5qm
	yprCny2z3VAmq4BrSqeViswHd//25OWyRDTaB1KyZWCEVk8dqfwFdNzXXwnSDDjW2fjX01CARmLlA
	UKKyyr/Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wRoW4-002GTQ-1b;
	Tue, 26 May 2026 09:56:04 +0000
Date: Tue, 26 May 2026 11:56:02 +0200
From: Ben Hutchings <benh@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable <stable@vger.kernel.org>, Salah Triki <salah.triki@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: [PATCH 5.10] Revert "s390/cio: Fix device lifecycle handling in
 css_alloc_subchannel()"
Message-ID: <ahVuMv5SLjHVUbkt@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X1cFRxuetyL6g6l0"
Content-Disposition: inline
X-Debian-User: benh
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254291-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,decadent.org.uk:mid]
X-Rspamd-Queue-Id: EFF3D5D3E6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--X1cFRxuetyL6g6l0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This reverts commit 2b2ad7ad4a28ffdb9f94e6d979b88a5b12b71681, which
was commit f65c75b0b9b5a390bc3beadcde0a6fbc3ad118f7 upstream.  The
order of initialisation and error paths in this function are
substantially different in 5.10 and this backport did not take that
into account.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/s390/cio/css.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index e5e20ea850aa..cf2c3c4c590f 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -241,7 +241,7 @@ struct subchannel *css_alloc_subchannel(struct subchann=
el_id schid,
 	return sch;
=20
 err:
-	put_device(&sch->dev);
+	kfree(sch);
 	return ERR_PTR(ret);
 }
=20

--X1cFRxuetyL6g6l0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoVbjIACgkQ57/I7JWG
EQkMUQ//SOoOjQaxq+KEekm7suQnN/+wYNHVYE/EoEDAHRLPI94/i3j7SvD4IMNv
yR7YsEgkoZft+p5ECsUpqbV5syjlAtUpS4r2zlKluMzoRPTTtKY+Kmq/2z40x4uV
eTgYL4Z1IdavOcMtKKZ6lOx67NSwJBFujjRYAPI6otyeyEYHmGpnijl1YqtfcCua
RDDMU9CQCAC1On2THOkJA5YnFeibeofQ4djk7qNSgyHrKFbWc1z8OXREfv206bJw
ph7cuiHdEduyEXfLSciX8NL9QaX3T9XjBwcdWQM6G5FpH2unQXk72iEHazUgKooc
ztnEfVff6bL1lwRhQrSix5tAnqxErkv9ma7UTgt0PJ5WVkHTHlU711P/3vPrjru2
T6N5B/sNlRPblbGl29YnVs2vAf1GpPG5VkqzzA1UHDxioRl6aXBdOBpAW+uwK7YY
hmHpRNECq2OpiLWAgg2rsrlCRfcUNapVeXcEzToJgcq+oEL0vcLU1QhipR3mHe7T
t3/A8QuSkdH6Dq/4VU430jvCaT9Q8s82hTUoVD49uVZQE45cLq4wM6SXB8DNzdIg
VdWdUQ9Pq/ew2ELwrJx/LXpIQmijeEI6ZEDpqMJjjqAUxM9SlHslq/x/uIV18tC2
U+kB9jpQTIbc1D3ti0LoPCQU88+RJjMk+oy+bjCj1DUwcjujuKk=
=455W
-----END PGP SIGNATURE-----

--X1cFRxuetyL6g6l0--

