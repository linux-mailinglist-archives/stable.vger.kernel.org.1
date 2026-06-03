Return-Path: <stable+bounces-260010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hfc/Er/zH2qNtAAAu9opvQ
	(envelope-from <stable+bounces-260010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:28:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349C636278
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:28:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b=MraICY41;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260010-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260010-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F643134243
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC303A1D01;
	Wed,  3 Jun 2026 09:23:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033E421EE8
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:22:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478585; cv=none; b=EGC88XVlVKCZMbfYevqekeQMSEP+in4Q3E9rNHrTxMrVx3R9fRoV/Z0gtKFmrGIny7th10AKfpVZ7oeipGmyBCy51QGxE+YV3VS118G5tmih0X4xDw9yv5QPgUXmjPYU72gDgobZztTrryb7vfYCzA7cYDFD/RLMG4uhD3B/fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478585; c=relaxed/simple;
	bh=uxkkZ2PsnRAYAVea7mInodj/ie50m+sZfEqTojMuM28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auSnlZb1mRGFqijWYTT/XmOap+29AKA18xGqkHjuT/KSEsLNkpyWH5xQQXMX7t/SApJGWMV/3GQfD/Z8eiUyuXrwrq18roCbmi8y/9sKM7PyjfKt32IgOjSSslXosQTIfwOTQWHEE+64UiHPAwVEi+1iwqO0vy7dWZ0RjEb1kgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MraICY41; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=oGHf
	1lkKQSF/OrpmlkLEH+QjracHniURhxyC+c0io9U=; b=MraICY414sni/PMMlxyY
	1nhIflhB9vlzYclkFiunyOAnwVsV54pG07gRuM4FbSs1JUnmZwcXlxViUdorqOYL
	SSXfWoApkhYzwc+6ubnE5hqzRPFcLGkpia71hdrZYTHGf7j5Kue6bvFpDj8nJu6d
	WcV3QbEwrHmiBEvHnIHcHO7I/pyHeZf1AKbI0BraCFv5IuOX0Y6tDDcJ/+HLL+Qo
	CrJ72yHaPsb6rCSdkWwgtK7mXoKSh1myKcPgwtTbrf78HSd5L5OxnPOqBD0ywPL9
	Zm2GXwzQ0YVrtVnst7B1gUaogRvMsWfbeM1g1SAzE7kdr6s7Sklzzc3emzIlI6LW
	Nw==
Received: (qmail 3213839 invoked from network); 3 Jun 2026 11:16:14 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 11:16:14 +0200
X-UD-Smtp-Session: l3s3148p1@FfEa4VVTvrYujnsK
Date: Wed, 3 Jun 2026 11:16:14 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH v3 01/10] i2c: core: fix irq domain leak on adapter
 registration failure
Message-ID: <ah_w3jDv5NljHaJb@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cnGjfKB//Jq0VdPU"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-2-johan@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:andi.shyti@kernel.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:bentiss@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[sang-engineering.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260010-lists,stable=lfdr.de,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ninjato:mid,vger.kernel.org:from_smtp,sang-engineering.com:dkim,sang-engineering.com:from_mime,sang-engineering.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0349C636278


--cnGjfKB//Jq0VdPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:06PM +0200, Johan Hovold wrote:
> Make sure to tear down the host notify irq domain on adapter
> registration failure to avoid leaking it.
>=20
> This issue was flagged by Sashiko when reviewing another adapter
> registration fix.
>=20
> Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not a=
lert")
> Cc: stable@vger.kernel.org	# 4.10
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--cnGjfKB//Jq0VdPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmof8N4ACgkQFA3kzBSg
Kbbj6xAAmld0o5WEYz8cN6/Qk94JSxfZNjEX0M9K8trWY10S9UiG7uJuD5B0FUVD
3UiC7zLeOHkVBRTOykWvlAsMcYt/mLN6UFAyW9+YYjiStOoPqHeMILwmjv0Xwr7/
vpfE4rVYE8N6PwczadNmSS9YS8fUHv+376Ql3Ib/QJobX9zXig7uSoyhlAiSQFlF
M5hxaZbiruCWJwQnYhpU2pchVbZFskD0hqZsi9nbFt7PZqgFZlhd+e9ptiMpyzCY
WYGBMVhWZBs+B1Yw5SZVDf53SAu/YSBbFCXykzLsZc8ZMABjYUq1TaCgZPs+nyy2
IrJLDQeM+/PGfManbNoqnIzTG0zgE6+hQDdpF55fD3qJ9ypVcB+n3FTuEv5F9fpk
xUA7RlULJu8uw7mnVwUDXDO2TOna2Dcm7RUj1hPPakg9LtkqMDETVkIGSkXF9Gvl
05+l9VGt9OSIW0Apy1/cRxuyT57aA1K2lvT54ApnrAwOTI6ZTvTLefY//BlabpkW
zeXzrASb/lFgmN9DvaoGb9h1leDsK34X/eUvGrtFr21WQaTrCdU3Yk5iSenpiSWu
CywSnPjSLsQpB6/3s30rMAF+y4dXRSPDSMa3uF0rvtB2OH1nrDYE/WLHEr7rsxYS
K0Acrq0fqA+KtTi74vX1EGjK8j7V/vh4tpRsWKZ5+97e9OL5wGk=
=0DX3
-----END PGP SIGNATURE-----

--cnGjfKB//Jq0VdPU--

