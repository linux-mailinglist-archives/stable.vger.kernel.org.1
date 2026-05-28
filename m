Return-Path: <stable+bounces-255052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO8GI0RrGGrcjggAu9opvQ
	(envelope-from <stable+bounces-255052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:20:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37F5F4E6D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C42430742FB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAE83FBED0;
	Thu, 28 May 2026 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Wv3J1dTI"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781573FAE19
	for <stable@vger.kernel.org>; Thu, 28 May 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983365; cv=none; b=NKxIyHX6W9EugNKMeR20KTuDax6p6ZgEfqXWpzVqv782MJ/4jFZiLi0BRm+Rk7a83EZB9P70cKUGCMal9Mo8w2N2A/36n5/KejNmaj5AGDkg8AgNwKvO90cTQsHwb17dc8pe5qOHUHJvskG5hsZmNzHRtzAuZK47+LMESwzt/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983365; c=relaxed/simple;
	bh=IOtV9GdBxqFTpv4U3qYwazeaLaFnsJ1SCmUBVyC6Pdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Iz45U5G+/6Xz7I8pSStDAWwmP+Y8qZku6y/5quzm4GHDNL2wYsyNINzeKeJPSGdI3LCMyb2pJuHzMwCy/+FMPdP8cLtHrCdn2ct4FQVZwnFpQTt9eDibxJLJ9D5UmKgHKXR3eVzwTVUcVGGjztKWWePz9+jx7/A8gQNoaFmeYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Wv3J1dTI; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=aakyUP9s6nupwKJv1LWEKLxPtM7yD7/9IJyNovWQBwI=; b=Wv3J1dTITZyiH7bp14J67/h6JQ
	v2fbpt4czfmpbMr026kRXTkW5LYbTxYqF5zMSTSbCx9H4HlnhgD5d9d5ie27JqoqyZTRkXM+JrmFG
	0STxH0/6jFfY38MXL5fwuZdMqnR4HPUBAn8MeLEPAtAk84CPZufP/GC8iwipv/Y5jXBkwqmz05Qha
	DM868fZJWDxrVcsdfIFZkLI95ZKBIDPuuBEhjVwMC2r4M90tlkM7Uyq6mzEa0YWKtLpUY7SdhL+Pf
	nvxgFLq/K247/mDnJ8ArFzpkseXwphsejret6ZaB/snW17RqLi25QGlNTQg9avCBrp/9slrXartqf
	a4wcT0pg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wScSI-0048as-1X;
	Thu, 28 May 2026 15:15:30 +0000
Date: Thu, 28 May 2026 17:15:26 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Johansen <john.johansen@canonical.com>,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH 5.10-5.15] apparmor: validate default DFA states are in bounds
Message-ID: <ahhcDsPMJ3Cu3J-E@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y7SVfPArE7+/jxAc"
Content-Disposition: inline
In-Reply-To: <0d3747dc57d7bfa3c53efcf4d133021ead5bef9d.camel@decadent.org.uk>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255052-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 8E37F5F4E6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--y7SVfPArE7+/jxAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some backports of commit 9063d7e2615f ("apparmor: validate DFA start
states are in bounds in unpack_pdb") limited the bounds checks on DFA
start states to the case where the start state was explicit in the
policy.  However, the default DFA start state (DFA_START =3D 1) could
also be out-of-bounds.

Move these checks out of the else-branches so that they are applied
regardless of how the start state was initialised.

Fixes: f43eea8ae010 ("apparmor: validate DFA start states are in bounds in =
unpack_pdb")
Fixes: 5487871b2b56 ("apparmor: validate DFA start states are in bounds in =
unpack_pdb")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 security/apparmor/policy_unpack.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_u=
npack.c
index c670b25235a4..4d720ff060a7 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -846,6 +846,8 @@ static struct aa_profile *unpack_profile(struct aa_ext =
*e, char **ns_name)
 	}
=20
 	if (unpack_nameX(e, AA_STRUCT, "policydb")) {
+		size_t state_count;
+
 		/* generic policy dfa - optional and may be NULL */
 		info =3D "failed to unpack policydb";
 		profile->policy.dfa =3D unpack_dfa(e);
@@ -860,13 +862,12 @@ static struct aa_profile *unpack_profile(struct aa_ex=
t *e, char **ns_name)
 		if (!unpack_u32(e, &profile->policy.start[0], "start")) {
 			/* default start state */
 			profile->policy.start[0] =3D DFA_START;
-		} else {
-			size_t state_count =3D profile->policy.dfa->tables[YYTD_ID_BASE]->td_lo=
len;
+		}
=20
-			if (profile->policy.start[0] >=3D state_count) {
-				info =3D "invalid dfa start state";
-				goto fail;
-			}
+		state_count =3D profile->policy.dfa->tables[YYTD_ID_BASE]->td_lolen;
+		if (profile->policy.start[0] >=3D state_count) {
+			info =3D "invalid dfa start state";
+			goto fail;
 		}
=20
 		/* setup class index */
@@ -889,16 +890,18 @@ static struct aa_profile *unpack_profile(struct aa_ex=
t *e, char **ns_name)
 		info =3D "failed to unpack profile file rules";
 		goto fail;
 	} else if (profile->file.dfa) {
+		size_t state_count;
+
 		if (!unpack_u32(e, &profile->file.start, "dfa_start")) {
 			/* default start state */
 			profile->file.start =3D DFA_START;
-		} else {
-			size_t state_count =3D profile->file.dfa->tables[YYTD_ID_BASE]->td_lole=
n;
+		}
=20
-			if (profile->file.start >=3D state_count) {
-				info =3D "invalid dfa start state";
-				goto fail;
-			}
+		state_count =3D profile->file.dfa->tables[YYTD_ID_BASE]->td_lolen;
+
+		if (profile->file.start >=3D state_count) {
+			info =3D "invalid dfa start state";
+			goto fail;
 		}
 	} else if (profile->policy.dfa &&
 		   profile->policy.start[AA_CLASS_FILE]) {

--y7SVfPArE7+/jxAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYXAkACgkQ57/I7JWG
EQlyFBAAxsKP/zN9WX/ypbDTStJsDqkdf53tjz031FLBxZzRsUIahcY4twxxtdT+
9gtR58oxr2QE94bIW+23SxILtzrUIb8on5WlL0N9UcMeZmqOvMbPgTVzlrfejSUB
zJD6UvZQ1PYpIm1RMRnIcT44P0uUxtYzqq0nO6Lj9TPmRhLqh/1TJt+xtDuCqvMs
kyySA/YYPa2AjVfX5givIX1mlSBJflZaPDgClji847VDPE5FNqazY1QyGu3lp6BV
az7y8QarabpUTnDU8vVPSXTsU2syeVGPjGyESaCy5qR0/aXouxSiyDXVMQ1MiUPn
e8yc31KRswCrAs+D5oHKE1KnuFWyS3u7jHwCEMZLTPTc/JU5GRCiZmAv/W1veMNs
38yQBZncQJ8++8QvrWJHw4AhcIA1QgvJXusSkr/vNzz2rU7vyKQgI2suTCb5oLaf
qKccSUzcHeu37HL44KHNIWmoKLyXqBt4yPAqZRsjKXPX29J5YjaoTMyu3Veu5g+g
837PkWCElC4IJ/J3nOdWeQWFBlBIVC8UU9e+hXyLlRhxLZtMtod4zaJLBi9pgriw
Mm4x4+18ZNkJEvvZ2GfvNlTpm0mlAfCzuGK8+qo28RVrBOwPBBQ52WJWfFpEep2i
yAqGSTHV2QR1EkxrZjQRfDPzN6XEsWmvDN69vKM/j8ok4x+nBgk=
=5kAs
-----END PGP SIGNATURE-----

--y7SVfPArE7+/jxAc--

