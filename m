Return-Path: <stable+bounces-255046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PNLCwNeGGrVjQgAu9opvQ
	(envelope-from <stable+bounces-255046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:23:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AAC5F4552
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26322302D084
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC672E7366;
	Thu, 28 May 2026 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="M+WKW6l3"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3B2E7361
	for <stable@vger.kernel.org>; Thu, 28 May 2026 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981818; cv=none; b=ibSGSTwto/HFk+13CE3llsDzxxktYyPzUqZtYYIxvA8JU2dJzepWGaM8jJ3uvMeWHtdBqZgYtF1ZLe3jPjrn7ikBS9cuLoNJN4i8DhoQ+ZPZd50/y1HB5hvQxn2vd2i/I321/iheV8s7r/Ve/G+lrbmWW/P0rZoKkbOH0CW51FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981818; c=relaxed/simple;
	bh=Fa3TyobCQCrF9VuxbFcQP/K+/+7U4Nk2SYlEa/2byZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XdYax+SXAZ/KecfdzAiDZgwe6YH1MdjPasGUOLvW3hHVkqPLXrSsEuRD7OQaxMR7h4iVRr4jTGDbD4pBIxS5+ZQzr3K9TEuEUO+B+YYYp0fNAuHyeMFibwuyeGb5DH1RQmLotSVSqgoPv8ku/9DKJ5HGF0vj0eGuKeMZtHdOkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=M+WKW6l3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2k4n36Lv4CAmfYLvshPK1LSXNYr6k1IJtWvKgCfv0Fk=; b=M+WKW6l3T+H0CZB48PbVnCdQn5
	Uc2PuzzWCQo3L8AJH+cpBRoHDxEr6dluBGn0z3ZWlxt2X1M1ZHR7pQEMYoZ1I5nrlvemv6/xHV7XS
	Jk8WmxfQy2/wPSvySFwfjwyZB1OJS1jFTnWj7Ua+pK/ec623o0ZC/nTI4xEPCwtrqw6lsnx9H9+W4
	s7sjymnkgzJuhQgVxPp/PWQuDtwAVIGaKoUiFYkY58kCewS4cRRmY8eImrileMQUaaDNfWJFH2Tpr
	O0bmhZr8z+LfYaTXVHdS78X73IvQo2AB/RXO9PWLNJpk+PSvioAGnsmRGWLD2w4odentimbjw8Qs7
	cwfFydCQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSca5-0048vc-2B;
	Thu, 28 May 2026 15:23:34 +0000
Date: Thu, 28 May 2026 17:23:31 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH 5.10-6.1] x86/CPU/AMD: Move the Zen3 BTC_NO detection to the
 Zen3 init function
Message-ID: <ahhd83m8AruYGvOc@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fb+HVBjZn+kboUfl"
Content-Disposition: inline
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
	TAGGED_FROM(0.00)[bounces-255046-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 83AAC5F4552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--fb+HVBjZn+kboUfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Borislav Petkov (AMD) <bp@alien8.de>

commit affc66cb96f865b3763a8e18add52e133d864f04 upstream.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-4-bp@alien8.de
Stable-dep-of: 7c81ad8e8bc2 ("x86/CPU/AMD: Rename init_amd_zn() to init_amd=
_zen_common()")
[bwh: Adjusted to apply after backports of the above commit which actually
 depended on this]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 arch/x86/kernel/cpu/amd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index df6dbeeca556..a61606a614bd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1087,14 +1087,6 @@ static void init_amd_zen1(struct cpuinfo_x86 *c)
 		/* Erratum 1076: CPB feature bit not being set in CPUID. */
 		if (!cpu_has(c, X86_FEATURE_CPB))
 			set_cpu_cap(c, X86_FEATURE_CPB);
-
-		/*
-		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
-		 * Branch Type Confusion, but predate the allocation of the
-		 * BTC_NO bit.
-		 */
-		if (c->x86 =3D=3D 0x19 && !cpu_has(c, X86_FEATURE_BTC_NO))
-			set_cpu_cap(c, X86_FEATURE_BTC_NO);
 	}
=20
 	pr_notice_once("AMD Zen1 FPDSS bug detected, enabling mitigation.\n");
@@ -1154,6 +1146,16 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
 static void init_amd_zen3(struct cpuinfo_x86 *c)
 {
 	init_amd_zen_common();
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
+		/*
+		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
+		 * Branch Type Confusion, but predate the allocation of the
+		 * BTC_NO bit.
+		 */
+		if (!cpu_has(c, X86_FEATURE_BTC_NO))
+			set_cpu_cap(c, X86_FEATURE_BTC_NO);
+	}
 }
=20
 static void init_amd_zen4(struct cpuinfo_x86 *c)

--fb+HVBjZn+kboUfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYXe8ACgkQ57/I7JWG
EQknIg//ZdLoWXMSWRguOhhTqW1JPx1iHoKWI+TV7cUdWL2cGh7rYX2//HLaUhiW
xiObgcT9kNZ9VPIOUW8RJOT0L3aBTzd7M2OTR73CeUKVEGh1qBRP/TyUHWoq0bZX
vVD0b4YwQCOE6KsHnq85ZY6HhBD7v+Z8khn4UZINJtxYo3uLKduYoYJ7UP65yk8p
PlGz4ZK/z5OlJNAmszrLN/6acwP7PMU3TObiKsDZoHtmf8h5TTath0+cPZjOH6vm
pfnjOv/9LtwJIcv0XaZ23tyol3aY0irtfn+fAvXNuAtJl9NJ5dkhsN8A8qZpQNjo
3fze4iKBH76/eHZb6QpY5hgzkN59xgD9olwYJVc23Az5YDWw58iRLRRnSZKTsOQ7
/J1I0I8cfxZtrttLSBF74hr1YzdAcEYBesq1sEsQ9dypwZzoVdyAouIazuEFWJSc
qVJm8I4hlNiRoYp1mhsnVcHhp1i7Z6vN/VygEr2V66ZYk/qxe3Zqm2fHTNZR6Nw4
SwnKAQj8S7Lx4QjH8jtiT2k6Ke6O/yN8+d+mDCew8DUjTSGHB//ksk8JENzNfLjR
B7JxlHgGTHa0c55Sr8NdvuCI0dP717jV3ynvxqiQ0OoWhyjNTlg3gehlCYOz+t8x
sUq1mqpgcKuvDv3N1ChDF0ABRTMvt0Nu5c5dXFPX0pYBK4hWJYI=
=W/jr
-----END PGP SIGNATURE-----

--fb+HVBjZn+kboUfl--

