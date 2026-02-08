Return-Path: <stable+bounces-214871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HoBM1UPiWnG1wQAu9opvQ
	(envelope-from <stable+bounces-214871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 23:33:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9C10A757
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 23:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E5303006F0C
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E8637B40E;
	Sun,  8 Feb 2026 22:33:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FE35E53E;
	Sun,  8 Feb 2026 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770590031; cv=none; b=fNFpBAj+sPeA3jkNgH9CG43V3T7tkwitifqGv5uIyzpaYgd2TdaKvSZ2/R1jqKklAqC+PcVPxOqer0d74xzZhAQ71N6TItLvVy0tLWxCOzqWBrQMEbh/QPObpcopAGLHM5pUq/mH6+G3Ae/zHBBe36u5hRATGqkjN2O+5FLaMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770590031; c=relaxed/simple;
	bh=7Gb11f8llqiP05vAm+jWPcekzAsPkdq+KZWUGyCutCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZcCS6GjR9OKwewnepG66FE/hdmxiHCTvFQAu6eES8tIG2HkiGrIcHLHxAfnOQsYKnLO8ZLkDIgFbDFeT1t0tEd0MjvJy7AekWydpOVbltQr00T2Q7wYmxSgEto9MBAk+ZoEyEh+7AiE+qvyUpzJdQ+EEewy4WLtHwG9V1yZad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vpDLa-004NSB-2g;
	Sun, 08 Feb 2026 22:33:42 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vpDLY-00000002AqZ-2mCU;
	Sun, 08 Feb 2026 23:33:40 +0100
Message-ID: <000915fc444a6e1f840f3d4ed6493058aefe850f.camel@decadent.org.uk>
Subject: Re: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler
 optimization induced race
From: Ben Hutchings <ben@decadent.org.uk>
To: David Laight <david.laight.linux@gmail.com>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, linux@roeck-us.net, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org
Date: Sun, 08 Feb 2026 23:33:31 +0100
In-Reply-To: <20260208114810.3709364b@pumpkin>
References: <20260203121443.5482-1-hanguidong02@gmail.com>
		<20260207104308.1bc31102@pumpkin>
		<f6710a1f44d2b32df1cb9b09cddc6695bf76eec2.camel@decadent.org.uk>
	 <20260208114810.3709364b@pumpkin>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-T+M+QQxxbnHCUy53ilaP"
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,roeck-us.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-214871-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[decadent.org.uk];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CB9C10A757
X-Rspamd-Action: no action


--=-T+M+QQxxbnHCUy53ilaP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-02-08 at 11:48 +0000, David Laight wrote:
> On Sat, 07 Feb 2026 12:43:29 +0100
> Ben Hutchings <ben@decadent.org.uk> wrote:
>=20
> > On Sat, 2026-02-07 at 10:43 +0000, David Laight wrote:
> > > On Tue,  3 Feb 2026 20:14:43 +0800
> > > Gui-Dong Han <hanguidong02@gmail.com> wrote:
> > >  =20
> > > > Simply copying shared data to a local variable cannot prevent data
> > > > races. The compiler is allowed to optimize away the local copy and
> > > > re-read the shared memory, causing a Time-of-Check Time-of-Use (TOC=
TOU)
> > > > issue if the data changes between the check and the usage. =20
> > >=20
> > > While the compiler is allowed to do this, is there any indication
> > > that either gcc or clang have ever done it?
> > > ISTR someone saying that they never did - although I thought that
> > > was the original justification for adding ACCESS_ONCE(). =20
> >=20
> > They do it sometimes and it's precisely why these maros were added.  It
> > makes no sense to me to look at what these compilers currrently do (for
> > some particular versions, optimisation settings, and targets) and
> > extrapolate that to the assertion that they will never optimise away a
> > copy.
> >=20
> > > READ_ONCE() also includes barriers to guarantee ordering between cpu.
> > > These are empty on x86 but add code to architectures where the cpu
> > > can (IIRC) re-order writes.
> > > This is worst on alpha but affects arm and probably ppc. =20
> >=20
> > No, READ_ONCE() and WRITE_ONCE() don't include any CPU memory barriers.
>=20
> Look at the alpha version and the arm64 LTO code.
> The latter changes the reads to have 'acquire' semantics to stop re-order=
ing.
> Needed for LTO, but the thought is it might be needed in other cases.
[...]

Oh, so they do.  Sorry for "correcting" you based on my old information.

Ben.

--=20
Ben Hutchings
This sentence contradicts itself - no actually it doesn't.

--=-T+M+QQxxbnHCUy53ilaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmJDzsACgkQ57/I7JWG
EQkDDA//VjOtiDarG6iSTBQzccStbeO6FPXbLc0PywIXmS6jDEkhZIaT8FlMMH7g
kQWLHz/e/ZfpeWjeXZUAk4mm41gfkTRwkLTf7qm17FNTHNovRTm9EhXPNDawyH0U
+i3YkQLafNtBzMfg1WI33bOutpvozuaXLOSu7ApT0jMWsnAnjYBf7+c6GJHc8sO7
7K6t2cRupC1lwxL7lhbulvPYV85p7pEghhgkRRpmdQJuiAf4ieb4sD04ULMa6sLk
pEntCRFoBVP5C6q8pBx3mdd6Iuo47Mhea+O4LQ1Xb6pKG3udCQyxFzTOs8bFQ9Aa
897ckPbgok98sZZCd+l8IyKDJnWxn6OEN+0CYjUr9b/J9+kjY6bMY8IxohcvKFCz
xWZBePuAe2NJPfdm8xzT5yX9EEwr2EYfPwLPATKoNcZPtAcvNc++UWszpDkba7FP
sCrgGlLsQ2hkqCnv/kMlqOWJXJGtDehiguoRHk/MOd6JZCJuTUq/TCPxRcPq+bFt
YaFlNn5kFJAFNkgm9EEzzJvF/4K3iqEu9vR2xhKSlJjR7SCH7rsLZpGQJ2sHC5zu
NrMdB98P/CvQxon72XWx1oSELbDT/mtanH9ps4g1ns9iPlU6BufL9RHVPh7p/qfH
NQLRCVRtCLZh4tUk8iWp5C/NrGNEMvsBJ2ZZsPgRcy9QZA0pxvM=
=QMwg
-----END PGP SIGNATURE-----

--=-T+M+QQxxbnHCUy53ilaP--

