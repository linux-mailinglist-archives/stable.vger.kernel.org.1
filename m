Return-Path: <stable+bounces-226028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJAnHE1luWkyDgIAu9opvQ
	(envelope-from <stable+bounces-226028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:29:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC842ABF28
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1574A3223F3E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346E3E559D;
	Tue, 17 Mar 2026 14:17:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07A3E5585;
	Tue, 17 Mar 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757022; cv=none; b=hrSfN4t9yBfAdiLbvByLNgech8X7yLWom3dct7VdX0xCXXwxNgKivC3r56IVbtWmTXXWndKCkbwpWNo6E9cOKd71xbi5ZwWyiIUaJGX6z7C/CYR9Cymhc/zftAg1R9UuHgOSA+AMHCPkhek8LXxh4V53AbjtD49nXuRO2osMmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757022; c=relaxed/simple;
	bh=HdgxiQETgmelAq4Jhv8FecGx2yGDLN3jwqCRKLAKKjk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Isfwny5ysuG11ektDY1/s8ny6NnbFEVzcBHecg5UNTxlOwCzwLVQVnC4jWOGrnp3hv17dLg3wSTg+gYAtyMNAnEA4L3Am7z6h9779duUT4ESstWrDa+4u+PgGHircERN6N7r+UTAukp061qE6leyUmqfCB/CilD2JZAUuFpFhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1w2VEC-000Yhb-09;
	Tue, 17 Mar 2026 14:16:58 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1w2VE9-00000000zJl-04di;
	Tue, 17 Mar 2026 15:16:57 +0100
Message-ID: <c48bc87973a165e0a944f7a7665338626187b4fd.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 022/147] s390/cio: Fix device lifecycle handling in
 css_alloc_subchannel()
From: Ben Hutchings <ben@decadent.org.uk>
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev
Cc: Salah Triki <salah.triki@gmail.com>, Vineeth Vijayan
 <vneethv@linux.ibm.com>,  Heiko Carstens <hca@linux.ibm.com>, stable
 <stable@vger.kernel.org>
Date: Tue, 17 Mar 2026 15:16:52 +0100
In-Reply-To: <20260228181736.1605592-22-sashal@kernel.org>
References: <20260228181736.1605592-1-sashal@kernel.org>
	 <20260228181736.1605592-22-sashal@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8bEuozMnVTlth3+s30s+"
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226028-lists,stable=lfdr.de];
	DMARC_NA(0.00)[decadent.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.886];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFC842ABF28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-8bEuozMnVTlth3+s30s+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-02-28 at 13:15 -0500, Sasha Levin wrote:
> From: Salah Triki <salah.triki@gmail.com>
>=20
> [ Upstream commit f65c75b0b9b5a390bc3beadcde0a6fbc3ad118f7 ]
>=20
> `css_alloc_subchannel()` calls `device_initialize()` before setting up
> the DMA masks. If `dma_set_coherent_mask()` or `dma_set_mask()` fails,
> the error path frees the subchannel structure directly, bypassing
> the device model reference counting.
>=20
> Once `device_initialize()` has been called, the embedded struct device
> must be released via `put_device()`, allowing the release callback to
> free the container structure.

But in 5.10, the error path is only used *before* device_initialize()
has been called.  So it is absolutely wrong to call put_device().

> Fix the error path by dropping the initial device reference with
> `put_device()` instead of calling `kfree()` directly.
>=20
> This ensures correct device lifetime handling and avoids potential
> use-after-free or double-free issues.
>=20
> Fixes: e5dcf0025d7af ("s390/css: move subchannel lock allocation")
[...]

The bug actually seems to have been introduced in 5.12 by commit
4520a91a976e "s390/cio: use dma helpers for setting masks".

So please revert this for 5.10.

Ben.

--=20
Ben Hutchings
For every complex problem
there is a solution that is simple, neat, and wrong.

--=-8bEuozMnVTlth3+s30s+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmm5YlQACgkQ57/I7JWG
EQnWiQ//Z9ep/04sPT9rG8nqEdHiBpSfNrLp5uulsJrEVNck+mWhzjSMKsPSMaTH
w0CSeFigTwBZjmfFSsVHmTYF7z0eAipnxj4yiMrOqG6AgTCuF3xtR3co+B8bPlba
7kKKkntieHQQ690wWwthayuvTLjv/OoDK+cWkBBLzm0I6FZs01YGv+URYWxl7mSJ
STiTnm02MYzeEPnkwuIkcIFZxiqOzBmWmc24OYhAynSR94t7h17siQN0KQ87Ua8k
AyhWAU4DfKaKpJzuY2Wl/ZM7yf8nSvct47H1sHz1J2sk8DdLtE0eVVCs6JoLfuji
Hac6yYF3CQ1lPLt4FirriB0PKZFqfAIRH1Q88esbbtHzE7t/Nrsuy9p6uSiXbrwb
qe2MzeTEalY/l7n56cQKnQ3Hf/m/WNMkfFNl5t3sFtPuA7L79uYOHq/M7oJX4Ruh
R4GZMV9HgFsiXaHxdizepLfkR/y3WcvKC0r/RBsjzpaYCgY/rD3DMHumhNAuamel
kC40Aa0C5pTb98YkGS1sbLLgl72VG6UlbHQsgNMsOVeZjOVbrp5QW0fAudy//ub5
iMEfrgNiVevkf20Z5jKIKchOZZe+h9B4LUDU7Uyv34qYWQASjzImkXNIMei2HfPc
4PfimObXdy+AXTj/aLB6bQyXxdpJWa8rwJGus2b1Be55OJFtKc0=
=pt4Q
-----END PGP SIGNATURE-----

--=-8bEuozMnVTlth3+s30s+--

