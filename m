Return-Path: <stable+bounces-255045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF3YItpgGGpEjggAu9opvQ
	(envelope-from <stable+bounces-255045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:35:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C1E5F47ED
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CB20300FB28
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2AE3B9604;
	Thu, 28 May 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sT0eQDld"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21A3BB680
	for <stable@vger.kernel.org>; Thu, 28 May 2026 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981419; cv=none; b=GPamwHHFTj+T/5/opNKI75IB8MlmtytzuKKLhjBo6Qlp2Rh6/lMk9JolwbRBHUNFemaYC+8rE7KmnTPjfodublOZ66FM3XvorFYMFMLO/+h+Gua3yEy8Tx/Wmf1A+pEUS1OaOHV+p5TXiyDuAckOsH0sa6ZIzADL5bv3zDK9GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981419; c=relaxed/simple;
	bh=Y+ZrqF4jlghxv1kEmhsiZNO2fIh3Sh3bEwrxBwTlA1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qrB4DhYyk62YnIoZtAnZrUkZrx6K/Sbt23tbFeZSEOYZxajXsWeU+VdTWGthfj0yJU7W8E5GqY25yvVVwllNV25tFXp+P8dVvxBenVT1ec2Z5wov5IUIEaq4h7bev5Q399CE2v+AxwVsl75E7UFouHDpoRdn9Vi0JML3Eo8lM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sT0eQDld; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=2MMDARkYOJ8pxTFH9YiHgIZYqti2X+NzKlhdsQuLVHY=; b=sT0eQDld8eSTQhvCyjaO//+Qbo
	k9UkDbhk/GUvxXx4Z9ZnvuigIsIl1gFY8tKcpBmWqpCML6rdBFo98aMjGIJwFoyktYaMUgOqZc4AL
	k87DfCeFCGOVknEojOhI8gS3UpL1lv1YQW9EzjmjwPweSYvaEotqXBK8Nb4n2Hh2E/gDP5CDJVqnf
	ZUz7L3PwiyIcw/TUjSR3TvybPFfhkJpkijhfmxog8BDf9qJeYMkNvJDkZB8OKRG41ZDjJZOpBHbIq
	wkIIo1pRkIJqPoHT5bhjTlP/ygtauQkefroTPIXs2s1oZXAdpW3tE4rEP7VoW+K10eT5Z2PTAPfz3
	evBZjKTw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wScTb-0048cB-2T;
	Thu, 28 May 2026 15:16:51 +0000
Date: Thu, 28 May 2026 17:16:49 +0200
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
Subject: [PATCH 6.1] apparmor: validate default DFA states are in bounds
Message-ID: <ahhcYci93VUlA_f2@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K8NO7Okks4caA+gb"
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
	TAGGED_FROM(0.00)[bounces-255045-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[decadent.org.uk:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 92C1E5F47ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--K8NO7Okks4caA+gb
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

Fixes: 5443c027ec16 ("apparmor: validate DFA start states are in bounds in =
unpack_pdb")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 security/apparmor/policy_unpack.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_u=
npack.c
index f0c5560e74cb..636fa078f00e 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -829,6 +829,8 @@ static struct aa_profile *unpack_profile(struct aa_ext =
*e, char **ns_name)
 	}
=20
 	if (aa_unpack_nameX(e, AA_STRUCT, "policydb")) {
+		size_t state_count;
+
 		/* generic policy dfa - optional and may be NULL */
 		info =3D "failed to unpack policydb";
 		profile->policy.dfa =3D unpack_dfa(e);
@@ -843,13 +845,12 @@ static struct aa_profile *unpack_profile(struct aa_ex=
t *e, char **ns_name)
 		if (!aa_unpack_u32(e, &profile->policy.start[0], "start")) {
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
@@ -872,16 +873,18 @@ static struct aa_profile *unpack_profile(struct aa_ex=
t *e, char **ns_name)
 		info =3D "failed to unpack profile file rules";
 		goto fail;
 	} else if (profile->file.dfa) {
+		size_t state_count;
+
 		if (!aa_unpack_u32(e, &profile->file.start, "dfa_start")) {
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

--K8NO7Okks4caA+gb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYXGEACgkQ57/I7JWG
EQk9ixAAzjINcwFk2ETd2d2DeXk9gRqodk9RbMGVgHlup3LUu1R9rhblQiDENdou
ZjKwOXgzcGhwzI1iNtvbN7aQ1k7QqGfsWX0wJk67p+0ko6mtAIDEzcFzxldaVJ5z
KC3OxYrwae/0e9Q2Ha6sD3XTVKPkuk0R6b/k+WJCupCB2H1ob/X9nBEhp8A45Tro
lckHSi0XVmXbRsim/LpcfxfpA3Xy7ZpaU/TlpBPP1AOxPI+gBSqhYNyseU3ExE9+
yVdYvHfiD+25KSmOFgbfU21EoJjzvVdlNaeMnuwCV4kjTfERoCNK7xMKahxWDT3C
tbGJRG0KhEk4DerDkn+hBrB1z7MqDy4duVWZS/7Gg3oR3FDXCgCvuMbyw2VdLaWl
+DEY4SYSIDNNK4VT4+OkLfPQl6lvIm7VFHnYQCKB+lROQ7lwHLAH5CHZv+gctipS
ruU2ffvWhsG4UsDOkeaxSXfsHGUmbPfhGJZtvZPkVKpise3f0GtlCcJY4dfQAru6
iFyUEWGqjZ8Ffdeqqwkk9jWIsIz/YRCSZhvYfyJkIYIebxYysApn+y5v7r+okFJw
/Ifmf6Yd/XHfm3uNWcWsAm/QqZxkKaV640wADgwM6JgxMfKsyR5uqrPVAR106tm0
tcSjQiZRmwNqRbBo8g9wpiALguW/KLAShTlDH+ymKH/ek9gjUTM=
=U9ek
-----END PGP SIGNATURE-----

--K8NO7Okks4caA+gb--

