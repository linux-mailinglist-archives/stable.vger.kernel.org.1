Return-Path: <stable+bounces-249636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAN4DdmNDGo3jAUAu9opvQ
	(envelope-from <stable+bounces-249636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:20:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C46D35822D0
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 279B830A4703
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69F30566E;
	Tue, 19 May 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MuRv7sY5"
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB834040E
	for <stable@vger.kernel.org>; Tue, 19 May 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206998; cv=none; b=O3Ndzb+u0W4+pIEY4zPJ2+hYwBhS4rNO5YRqTGVvf904l3tT2qR7tZkK7sUfE7bmG9ok9MYg3WYCp7HAL9kFFT7PLlEOSmyjmH28nV8ZoCvE/knrxh9olDh7gCFlQRbJcWbLm/+bp9dS+p4KHwa+ro4XtaMW4NI9iX/3PYCnsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206998; c=relaxed/simple;
	bh=7uyGLvJw6AtWUK1RVg4o/7eEXEFkAcv1E67M7hUayfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei/UO6w6WLGIBuWD3ptC2g1FhXiHC/tlZLVCnUl+nNa4muS30bPSVPRH5TzXodguQUXYpCW7lv1VGmsiBvaQiBDLY59XwG6a2PGPSVGcPxsqzgKSK3sxuqpKiMI6cMJ5rzeyiXhKNKY2OodOvUDyvyPZtqWmjWFm/FrN4+mdL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MuRv7sY5; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=7uyG
	LvJw6AtWUK1RVg4o/7eEXEFkAcv1E67M7hUayfc=; b=MuRv7sY5uY78LvPUOjdE
	51YjpmhWhS4B7RJUsR3aUN9A8dy8wLzcG69iaBcZ5FJNDdQgBBmKCc4duOCFerMo
	UoC1wItxgdTc4fsDRfkiRiJ5wMpumLubYwbDwsFp7skn/aoXRRcIjm+om80soK7h
	r/clQX31wdZF+UtBe/YfEp+PVpB5qZXx1mryZsQ51b7a0F8Umc7TdcEPC/qdQSmG
	9zRo/r8ZTdhU9TZC0oEhKzw5+No4wbUdipx3FsPh5AvUXdW9QxPpkCMs0siHrhll
	1MCfZBYK99Z2gtA6v0dyE430IacpcQYE+8RrNvTVykP+FPcweZ+Jop1J1A8q34Gw
	DQ==
Received: (qmail 333552 invoked from network); 19 May 2026 18:09:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 18:09:51 +0200
X-UD-Smtp-Session: l3s3148p1@yBSx6C1SoNEujnsJ
Date: Tue, 19 May 2026 18:09:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
Message-ID: <agyLTlaWHEYH6NY1@shikoro>
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6oZYoyatC5FFSgIj"
Content-Disposition: inline
In-Reply-To: <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-249636-lists,stable=lfdr.de,renesas];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,vger.kernel.org,bp.renesas.com,renesas.com];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sang-engineering.com:email,sang-engineering.com:dkim]
X-Rspamd-Queue-Id: C46D35822D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--6oZYoyatC5FFSgIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 02:53:40PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The RZ/G2H (R8A774E1) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
> requires the specific quirks and configuration defined in
> `of_r8a7795_compatible` rather than the generic Gen3 data.
>=20
> Add the explicit "renesas,sdhi-r8a774e1" match entry to map it correctly.
> Note that the DT binding file renesas,sdhi.yaml does not need an update
> as the entry for this SoC is already present.
>=20
> Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you, Geert, for the review of v1!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--6oZYoyatC5FFSgIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoMi0sACgkQFA3kzBSg
KbYWBBAAgotHuGeXexs5uDsfBlxdZD1hYaCjV8R1vDciX99iNJWoKy4anpmPfHHo
p00fJL/0NzuHGsnbqYiXxBgRNSRiQwHCojM535Kg8DoJbJJdW3bjZTt/pjWPueCI
WRzy17IihcoXnoGEjoyq+bSOuQOAJslEfclXzses4/QRTr0Pg5ly2eF8XEMwY164
nJZjxVubFl0MgEY3K+BsRGNDc+pKhpy1OXgOVXOIvN0gT5zbaUNhLMU8g8/5YbIp
Op1t/Fd5p0fpspMa4mmVuzu+wETyzcEdxgdg19DcSQLtX7WIsHTByFwyDSSjYnFi
rFFYGjO92JH+Vuaj5jMeVneQxXXUCjpDAGgt5D3T7KhLIpwrDyMTYG/sQ6z01/Op
6ZRgnPqmTkkQtt7gwD+NBRh8FskDji74AD/KN+WXQ3XAJ0JtO76N4qqwfxdbvU1g
zXXJlXLxw45H3LfurtyufbkTx8eLZr7ozk7UiWbqjE+R9vN/Y2bKQN3vMv9u4NPy
C/FwqRANbGXvBQGgDgxC1KEkLQihInxEqfrsi7ASPVmcqZMV20MhLCkkb7ri7gm2
KRTjgoU4i7jh1jageUiDzXZpN7zWDlGZgFWfSzE49alh7A/6j1vnqgPr1FeuuXUL
wEDkbVt5IAaEFUuyFH6bUkU2Fe5rDfC9riX4ewVcQ3u2GfDWQMc=
=29Dp
-----END PGP SIGNATURE-----

--6oZYoyatC5FFSgIj--

