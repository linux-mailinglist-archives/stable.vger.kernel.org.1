Return-Path: <stable+bounces-106575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A50E9FEA92
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 21:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC227161940
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E419995E;
	Mon, 30 Dec 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="yYWmNzXp";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="dLeoFxgx"
X-Original-To: stable@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F92190468;
	Mon, 30 Dec 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735590031; cv=fail; b=U8+ahr3tBvzubRgBirEP6XrGwWMNMzwMYyyyzgkKr6qyvyH/1GWChJUhUTTslmdwF6CUeCI7nup3n9Ecz1wnihpZIGbeYsiKkEBE7fPr8RMgc23HmCnutLdSzvBWtlNAW/KleTRgbUW771KYl7v2cSyJkQwEEej3ILTXj16rveI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735590031; c=relaxed/simple;
	bh=SvCx+7R9rYkay2Q5K4WSBPo4OaXJrzadmTeo1eER2WQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqdAGTx2b/kNg/Pf5FMxpQ2FFd1+KWKNL/dkAsE3zoQZjwtPvR9LPfAN+DETdVLB9Se5jK+hmE7aMGBHixq6UMhGraAAkiws2MP+TDPR9JjSz8S9fXanS1cTZL2qXoU0XEYLPDz0UenGWcW92zkVB8T8gxPAVIwJ+LWE8VAmNdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=yYWmNzXp; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=dLeoFxgx; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id BF159480A13;
	Mon, 30 Dec 2024 15:20:27 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1735590027;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=oIknQAiHp510znlThOjLTj2QgFtPpRlgcZvUAviehRw=;
 b=yYWmNzXpAhZny+af6EIKUUbnmxtt21cHiXKj3PVwxbmleZdYap26eSLhIRVaPx4ALRXfu
 Yjr4vVuluzsLQwvBQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1735590027;
	cv=none; b=mQggUNtyrdQu8MqUfXSuxuoxOuY4hpiG5oC9DbeNM3Q9oa3c0py3cRQzXSMVsByq81R/wjtaj9GfHb5Ovv97QOG8SwnTToAI5KJy7MzxUpMzsisqYuyYfi8MfAegUQHFXs03hFSMwxdS/wVdmUPvqv6fVCQLLap+VQATOP9QMHzcwut0989/KpoNv0/Ewbw2Hkd1NnF9hDL4CKTwbyhyXZVBy0/5Nsd6eEDL1Hyx0/UGPu3jDaQREs42dHyuvJeRTt8IdQ8g5Ty6VFVpgC5vn36xCx+SY+YIQx4OheZPWYRoyb7tetho5Tp4pQC9fbj9pL+CBjDdBsrOGQOWc7D1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1735590027; c=relaxed/simple;
	bh=SvCx+7R9rYkay2Q5K4WSBPo4OaXJrzadmTeo1eER2WQ=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=WOymqLW9SS/EmrX6IQNX5Dac3JrD7NisIPKiCQ/onwizFxqpUn//OE/n38M358IeGnVft0YcpEQUINzRSuK5IMq2N9sAusRrKJvaU8GlYYpmFESeayEgo46X6eKxKz0moDqW2L5NKvULKf0ZIu/HxoYHZwuKmvGWAAsc9dwksJSkPEOBPjojIRcMKyZ8vYpm8reyvAkDrFBKdYdTbFYp8v34ESKXujPVW+hEYeH8KL2O00ed/RRyF3019W7RMTp8/FpIum31ES8Ku5iZvZyupd48m21qQHLnH7zKeTGKwH+ZlykViO6mHpvzeMvf3ZQrmwV1ENfMMWB+/xKc+gwhVA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1735590027;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=oIknQAiHp510znlThOjLTj2QgFtPpRlgcZvUAviehRw=;
 b=dLeoFxgxOwmgLEthXLwBWTMzO8AkGThixKkJ4mUObOPi3nyyUFqbxT0/u2e2kstX1iqgl
 swiDsmlSeBePoyMToEayyq64w4Noof2XUmuNC0E9xMT/s0Nck5fxkvZazni0SLLcWDnygrX
 lpX1OXI3SEtwxJ82ED2ZTLZsxRIp4pv5m8TKxkbkCZG/5NW6jbbVJH3pU81rBseRHow38Rc
 dOl7dbhpsxsm9ZqYgUyR0iTYN3YZYXgyYUJIIxFHwHnyHg32o5dxaWw/w2q6Jv/bv/DcYxb
 qtqzs2OOE0D6kE/a68kh0gCJk6sEG/+hShgh8F5os2Nw0/+FI03T2jM5dQ+w==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 8A90128001A;
	Mon, 30 Dec 2024 15:20:27 -0500 (EST)
Message-ID: <dca3999b16e5d7db2caf0e15afdf7691bd710712.camel@sapience.com>
Subject: Re: [REGRESSION][BISECTED] Re: 6.12.7 stable new error: event
 xe_bo_move has unsafe dereference of argument 4
From: Genes Lists <lists@sapience.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, stable@vger.kernel.org, 
	regressions@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Dec 2024 15:20:27 -0500
In-Reply-To: <20241230145002.3cc11717@gandalf.local.home>
References: <2e9332ab19c44918dbaacecd8c039fb0bbe6e1db.camel@sapience.com>
		<9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com>
		<20241230141329.5f698715@batman.local.home>
	 <20241230145002.3cc11717@gandalf.local.home>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-64adjAoOgIXyp0c6xHQa"
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-64adjAoOgIXyp0c6xHQa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-12-30 at 14:50 -0500, Steven Rostedt wrote:
> On Mon, 30 Dec 2024 14:13:29 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> > I guess the "fix" would be to have the check code ignore pointer to
> > arrays, assuming they are "ok".
>=20
> Can you try this patch?

Yep will do.  Will report back shortly.


--=20
Gene


--=-64adjAoOgIXyp0c6xHQa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZ3MAiwAKCRA5BdB0L6Ze
29J4AP4/m7BpvosAsJ3qpfXYgYMBoG9llosfmMcF4GH9xbBBeAEAv2cNmrr/deFn
uMs4d0uJFszByJuE3BNT2YgpU+dUdgU=
=wRfC
-----END PGP SIGNATURE-----

--=-64adjAoOgIXyp0c6xHQa--

