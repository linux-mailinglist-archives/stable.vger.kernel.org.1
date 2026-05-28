Return-Path: <stable+bounces-255050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILcJBpllGGrcjggAu9opvQ
	(envelope-from <stable+bounces-255050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:56:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 882795F4B00
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E8EF3105A9E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C83E63AA;
	Thu, 28 May 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BgBfDVDG"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67219F11B
	for <stable@vger.kernel.org>; Thu, 28 May 2026 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982563; cv=none; b=u0pErTjkXJOQi8EGZXyzV2EmdGon0cDsQiSj0p4pBot9+kJQ1sp/moZXCaL4JbJ33bj9/uJMilDSIJbTPBGO2vpa7O/oPCwTf+UjWcdj/jmTlZF1Xe1BMqCVknOs/BlAP7j/Sy6D1IQLH+w/2HofZDTEt6A4rgRZX5aH19A+WkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982563; c=relaxed/simple;
	bh=O73grEsROQFHCroG+9IfLx3gx8PZ8ywUCLL47P1HEg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3LHMYHayye+vd9CmZhnHpudXhTstcFpTVXupcQyxMOJxdIdOoKn8VTnzF6oLMi8bCyCs+3kFOt8G6qMkQzx9mqdlwXmDUSS9E52JaCWwH50KrIIak3ZonI9Cqkiqmxk+LjS8kDKGJQrwKRZ5xoR4ARRGBZNPpyEkt/hTUeEaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BgBfDVDG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p7e+DoApvFI/6e2qCYafvgZKQ8krT+0xTVgzIYTZLj8=; b=BgBfDVDGU6ZjbEM9ogUNfgT8am
	XMuqCLH/y0e6Vh8qjcVaDXMld46dRGGOfFC356S+cYoFAujA4YSnYKCL/elySDNdxFXqWloLd0HAI
	8cCYu7SvE0Zj4gNZTNyCW1UB5m+lylES6aKHl5fM1qxfHuspGKCJqJqxdI6RCB3t0usqtX6LLq3Ff
	TyjnQ3RLbvmwwFCpHbccMx9CnzvEBqrd1nXaC0mdAwm/Iwy9CDmnR1nJ/MmkUa/xFM0fb52sGHx2e
	XxeXi18tLH1FXK0kTtwOokRcZNVxUUw+SCSj+A3ftu59OPH5gWH7Oqj4w38UhvMxcm4f/aMqGKG3L
	IJPmvoJw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wScm5-0049Lu-36;
	Thu, 28 May 2026 15:35:58 +0000
Message-ID: <1d128ddf72c7c42d47e1348b9dc74f7f829621fd.camel@debian.org>
Subject: [6.6] x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init
 function
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>, 
	stable@vger.kernel.org
Date: Thu, 28 May 2026 17:35:50 +0200
In-Reply-To: <ahhd83m8AruYGvOc@decadent.org.uk>
References: <ahhd83m8AruYGvOc@decadent.org.uk>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gXxG8eK2la8kLGk9+S1+"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-255050-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 882795F4B00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-gXxG8eK2la8kLGk9+S1+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For 6.6, please cherry-pick commit affc66cb96f8 "x86/CPU/AMD: Move the
Zen3 BTC_NO detection to the Zen3 init function" as stable dependency of
commit 0da91912fc15 ("x86/CPU/AMD: Move erratum 1076 fix into the Zen1
init function").  This seems to be applicable without changes.

It seems like 6.6 should also get backports of:

cfbf4f992bfc x86/CPU/AMD: Call the spectral chicken in the Zen2 init functi=
on
7c81ad8e8bc2 x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()

which have already been applied to the older branches.  But these don't
apply cleanly.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-gXxG8eK2la8kLGk9+S1+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYYNYACgkQ57/I7JWG
EQlO8xAAuBYHh6eHZ4ecwhEbYv5AXSMcmyV3aSOJUpJ3N2FL+9Q7xobnvSwY0Qxj
wP1Ln8VCVacRhDH+wkg1ROVRzUOay849MLANf91AyJ/rLaARSVdmapW9NN2Yqv8W
AbTrqj+p4soCOtednO0ocDjDl9zQ6sdUHeoiN5mOZ9M0t83iuB/0OwjMxvrQ0eM5
uu2M6Pg6nhE+l34dLtvy2fX/uJsb+a5UJre0qhuOCSJAe0dh05egmqQgIDJl4ajl
QhXGdep9onwVYaHsLbSK7jjnGmFX3LvpzIT3BI3XdWPJREf6ByvK1I+YMlpxzotw
Xaez5Aw+tqRdYCy78DlnI2DPv3xnoGiOn2h1nDjexoYeTRZ4mI0xvD5Y4NSfgHt2
DDX7HoOd0prZ3nLDfPKHNxrKUQ30esBqR0bzlN0uzrIVI530MrYa6EwQkI8b7InS
D6qqWDEj3Nz5dcEHju1McjhbrlPXHg7/Rqm5BSCDpepomgDpPWJLaQhThCT8ONdY
VUaLyrJvQ3Nk2Wq3R4tLYtXzMkJG4O8mp2VMiDSnyYeHUGuaTVszj2B/h9TpgDBe
xBqvWQu2zHcOwaaa34PDUzV48zPn6ZM7lFw4PMm3rdpx2ByIGvQ8GR2Oc8qTieHB
cOUM58dIrM6yafYNns1ZgKotlSWZ8FVIiKyUDDCc/cvtuN8Yvyc=
=k79b
-----END PGP SIGNATURE-----

--=-gXxG8eK2la8kLGk9+S1+--

