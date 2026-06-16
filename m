Return-Path: <stable+bounces-266576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DW1dAFfFMWrBpwUAu9opvQ
	(envelope-from <stable+bounces-266576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 23:51:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BDF6957B7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 23:51:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266576-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266576-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F33C304BCFA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297AB38F947;
	Tue, 16 Jun 2026 21:51:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560F331EA5;
	Tue, 16 Jun 2026 21:51:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646672; cv=none; b=G61gv+bDtsrFjiO/Qwj+xIEIr6I1J6DR2Lv49JZHqEXHWS8QIKAuez5CcIbqLARdY0kUfWgN7IKQxGTtYDHL69BDPIpRFNp/Zntp15NgOky5+qfM2o7Y1i1v3Zyo0iUu0ErpPoBLEpwKpeGHDJTlyZmjoNdI3eF0vhFZZ5XrXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646672; c=relaxed/simple;
	bh=J6L2JqZOEO4VGS8RMRp8G7XSv26WMiGleJNndBZ67j8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClddRDY6saYZzkghQ2tyH6cK/ArUdq68tkc1J0QIdAIRdFRGNlZ6SqjIuZbE9m4BFNHGwaH4oR1y4RsIsxDPIHd8r9mE4KmyLuKAC8KfNMzQWFaessvonfHLScmCm6WEjYpR+i8unqsuRHyMdBGGP/sdYf6H1xmz+z+Q6W/IQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wZazo-002r0l-00;
	Tue, 16 Jun 2026 21:06:56 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wZazm-00000006Vwl-2AId;
	Tue, 16 Jun 2026 23:06:54 +0200
Message-ID: <9125d5976feb09ef919f2a287b079843c7671325.camel@decadent.org.uk>
Subject: Re: [PATCH 6.1 011/522] tools/bootconfig: Cleanup bootconfig footer
 size calculations
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,  Sasha Levin <sashal@kernel.org>
Date: Tue, 16 Jun 2026 23:06:49 +0200
In-Reply-To: <20260616145125.946340231@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
	 <20260616145125.946340231@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lCR5RCChjejQim0VI15B"
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[decadent.org.uk];
	TAGGED_FROM(0.00)[bounces-266576-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:mhiramat@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58BDF6957B7


--=-lCR5RCChjejQim0VI15B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:22 +0530, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> [ Upstream commit 26dda57695090e05c1a99c3e8f802f862d1ac474 ]
>=20
> There are many same pattern of 8 + BOOTCONFIG_MAGIC_LEN for calculating
> the size of bootconfig footer. Use BOOTCONFIG_FOOTER_SIZE macro to
> clean up those magic numbers.
[...]

This causes a regression in some configurations, fixed by commit
729dc340a4ed "bootconfig: Fix negative seeks on 32-bit with LFS
enabled".

Ben.

--=20
Ben Hutchings
For every complex problem
there is a solution that is simple, neat, and wrong.

--=-lCR5RCChjejQim0VI15B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoxuukACgkQ57/I7JWG
EQl4+A//TuIeXRd0kdF3l5DYV417IjO2eo3WiKdbBGVJnHV1Odw9fVb9ETGQ+fiD
IB3j/0FAjx7ejLy8jpq/eikH05+5lzjZ4/zbPw7EiTh6JkeG5bAoyGqlitJ7vCdQ
AitMdv0ihF5yD6HczapV3S3jsowMp/4TFKKeYw2IVZ1RL2yCGKffQPuuBXYBcleK
Qk3veEdGvAD57bwluFE9jaJpI+Av5/bHlVZUfxDAxDfF4evEIjt1GOPp8Oln/LqN
D7b/MWI6o7RLkZPidPTcFu/ananuQyYaRVmn1N1vuqLBhH03VSsqN4xhNIA1uhrt
sDdg/RC8Is0QGFa1xOWTgJqB7LXgnrie6lDZJ5DQHkV4hcyZzAO6wb8BrHj7oxFR
CwFr8lenCWI9j7gcx7aYIssDKb48ErxaUTCO3BC7gLRjcRJJW/H2jO1M06gGNTsR
g+S0daMXwSrDr8cKnlXbdFAKTKX+bPFc4n1NIstbaAnpbR6vv1S4bMyEhtJ0FNoo
o0hdhU9F/VLM+wE8EYf/FvjzBkikPCMtkwwUqRk/d4pPZY5ZhaP/UVpbdjE+S4/9
Z071Ee4kYylCeqHf/91AxqEpHBavJBjB+bOYvDahhdWUQGo0bS0T3JZcbgVH4Z1I
F02FSix7y5KpbutIvI/ywuPMA9pSsmQVRXbjuCYB/LTls/t1fTc=
=NR/Z
-----END PGP SIGNATURE-----

--=-lCR5RCChjejQim0VI15B--

