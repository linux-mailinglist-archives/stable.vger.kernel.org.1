Return-Path: <stable+bounces-214756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPksGnolh2lJUQQAu9opvQ
	(envelope-from <stable+bounces-214756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 12:43:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD842105C64
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 12:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92F73301CF8B
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E11340A5A;
	Sat,  7 Feb 2026 11:43:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9D331A71;
	Sat,  7 Feb 2026 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770464626; cv=none; b=i7hYXsgMe4EGB0nYFOdil5Vck1ZqxYaDow5KP0e38OrjJxxyRZsU42QHZmD/2oWfe2r3DdAhmiCp8K/7T4Ae2kelhlwrNvKcvjHaGHIXXG/wtKQ/+UjHrBKNmcWnt+oBiaFKfFXtTh9+jSNVokB8I4YxWvSPTwncS1yAIWKkF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770464626; c=relaxed/simple;
	bh=6QoShjV6qd53C5oB9Tf3vfSjqYfwF01ob27R1R+zDME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okX0yZPDcqM5cgA+xoMhi/V793iqVfTCip9CzZwYus9B60mcS2Ip3ZCmL47uGZpE/ei5HNvy9wlOigrrJja+td1tl6e7+AJimGdhIWEXu4PZlGJ1vwN0Hwxq95Cn92IfKzgczfBNUKiDEN7PHntw3GRH/eI7/4Ep37tzIUzIfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vogiu-0048sz-1S;
	Sat, 07 Feb 2026 11:43:35 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vogis-000000021iH-1mWw;
	Sat, 07 Feb 2026 12:43:34 +0100
Message-ID: <f6710a1f44d2b32df1cb9b09cddc6695bf76eec2.camel@decadent.org.uk>
Subject: Re: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler
 optimization induced race
From: Ben Hutchings <ben@decadent.org.uk>
To: David Laight <david.laight.linux@gmail.com>, Gui-Dong Han
	 <hanguidong02@gmail.com>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Date: Sat, 07 Feb 2026 12:43:29 +0100
In-Reply-To: <20260207104308.1bc31102@pumpkin>
References: <20260203121443.5482-1-hanguidong02@gmail.com>
	 <20260207104308.1bc31102@pumpkin>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+DcWWCeRBAOX1jARWoNK"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[roeck-us.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-214756-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[decadent.org.uk];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[decadent.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD842105C64
X-Rspamd-Action: no action


--=-+DcWWCeRBAOX1jARWoNK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-02-07 at 10:43 +0000, David Laight wrote:
> On Tue,  3 Feb 2026 20:14:43 +0800
> Gui-Dong Han <hanguidong02@gmail.com> wrote:
>=20
> > Simply copying shared data to a local variable cannot prevent data
> > races. The compiler is allowed to optimize away the local copy and
> > re-read the shared memory, causing a Time-of-Check Time-of-Use (TOCTOU)
> > issue if the data changes between the check and the usage.
>=20
> While the compiler is allowed to do this, is there any indication
> that either gcc or clang have ever done it?
> ISTR someone saying that they never did - although I thought that
> was the original justification for adding ACCESS_ONCE().

They do it sometimes and it's precisely why these maros were added.  It
makes no sense to me to look at what these compilers currrently do (for
some particular versions, optimisation settings, and targets) and
extrapolate that to the assertion that they will never optimise away a
copy.

> READ_ONCE() also includes barriers to guarantee ordering between cpu.
> These are empty on x86 but add code to architectures where the cpu
> can (IIRC) re-order writes.
> This is worst on alpha but affects arm and probably ppc.

No, READ_ONCE() and WRITE_ONCE() don't include any CPU memory barriers.

> For these cases is it enough to add the compile-time barrier() after
> reading the variable to a local.
> That will also generate better code on x86.
>=20
> The WRITE_ONCE() aren't needed at all, the compilers definitely
> guarantee to do a single memory access for aligned accesses that are
> less than the size of a word.

I think in this case WRITE_ONCE() might not be needed, but it's also
harmless and it's much easier to reason about {READ,WRITE}_ONCE() being
paired up.

> This all stinks of being an AI generated patch.

This is a follow-up to an earlier patch that claimed to fix the TOCTOU
issue.  I objected to that because in the absense of READ_ONCE() it was
not guaranteed to do so.

Ben.

--=20
Ben Hutchings
If more than one person is responsible for a bug, no one is at fault.

--=-+DcWWCeRBAOX1jARWoNK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmHJWEACgkQ57/I7JWG
EQmoKg//exLS0OLNWramvNGGiNkdQ+cWZkRqZ8v2C2dVaH4prmpIdxYI3FbOX4Tz
HKEWz6VZtd4F6tM/os8WM1cGSLk5IiztGfEKaZM6NCrKjmFHZuhw23OATgh3LX66
iwlrw9//raENnA2eCfSmrS2xpaSitRA7+TUgTEkYtQhkG3P9S9LtJ24LZnogjr3E
Tz+xmb3iDdZGzIMuhcV8685OlhJ6G0kmAwke3QQx54VJLTTDvnio/GPYrZQScv79
xxDVVYSYm9PnEM5PufwGo5dScX2cmRJcD6F6JxGRAxTVe7v9WCHXR7GMl964YnoW
9yiKy36wt7d3czEel4VvMgH4AsZJQ0JlWGXMttb3vjQndmgusgPxYf+ecCM7MV/d
CTM0wG0CcjFltLZkfJVLOBRujwZCWfDSdp5fhxuLnei/G+qZk+BhCFSuo23B8UqR
4WUVPhi1zdoi97R3+L71kpKhxVFR01nVH6X0AHtjcgn9EU36HDzlPwAJVe5Sz7DU
ZlVTnVvwPe0bc4qaiTy9XYLHXG6pq+Iitf+EdwNouDrhqovP7GnBmEL8d13u/S/L
LWwvKmPmSFA0d+62z/SuKLLKMNx331X+iTvUyk9V1fjUoFx0uSCB858P8FvL450y
fpDfnMf6GcaDzk6OOwDE90OBCtWSEVHFiQuJY9SX09YLSIfkYls=
=7BoC
-----END PGP SIGNATURE-----

--=-+DcWWCeRBAOX1jARWoNK--

