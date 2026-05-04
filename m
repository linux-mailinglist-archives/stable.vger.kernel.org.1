Return-Path: <stable+bounces-242963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BZVMXFk+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:18:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880394BAD4B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8372300617A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF3370D5E;
	Mon,  4 May 2026 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="bF720TPi"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127D37649E
	for <stable@vger.kernel.org>; Mon,  4 May 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886317; cv=none; b=WXNiFsZKvktHjUQAVlLD5tW4d3YSrFBe6z7xGL7G+Mwolj5BbJrYS1tAt7iw9T7UcUa4h9PHwQN4xWzj6499yqZr3T0Uo91/CQ7uzqxGRF3zmsrLvHvqRiuhdgurgivTrDx0DLfJUwcnEdNqFkb0S4omB64QJiEWCn2VPFCO7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886317; c=relaxed/simple;
	bh=yHDXP7PBwwxgcJZDDpsXuNVoO9SdGFanBy4+AvMOmmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klWfxd/jPFDKyqxda+D2UgltrUQbZpracth9sCH/UHgzsTdp0+qrvQFcmbwc79Im7L+PnzxCRIj5Wwy+wOIUtdx5ohf0SLfYDBhDms2X7YGlQL9PZGCi2QzO+R+/bu452T/5rWoerHFDiXjYe6nkkDT0rY6zh3r/U1+8HN63YFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=bF720TPi; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4303711426A;
	Mon,  4 May 2026 11:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777886306;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EWzjCbGffhKpQQGGO7RHBcQDFi+9fTq6QMSzUfh7CkA=;
	b=bF720TPiVfn7yUJQuHcBAj29URLvqdZLfLH646OKfskT8eH0UmQtCqObENIy537xjDAj5k
	QxHXbsW7xLxNx/tAWUW5nJ98CwSRvHKDk5YCW8dshWSkDU0iyxDCLm60QUUq3Ht3iS+4HF
	T66sRXWvi8RhBSkdoXwbO985J0voaQreeletDXO6qsE+v8whNr5nHmzAw3RpSbg9BZeFsP
	GPFPQ1JcDsEUPh4ojtsveLronCRZuAKw9w4JofAEHArOGQPlnzsTBeN1y8dJjHThOwEtVs
	x7076H3pBgXR/siz/C4UsgiS3Fm6cu1AB/uajNQJwMsIoLo9MkaMJKd1L2eJmw==
Date: Mon, 4 May 2026 11:18:23 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
	cip-dev@lists.cip-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
Message-ID: <afhkX2Ys2BG1gnqy@duo.ucw.cz>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEaLSnFnVzGAR+pM"
Content-Disposition: inline
In-Reply-To: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 880394BAD4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-242963-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nabladev.com:dkim,nigauri.org:email]


--DEaLSnFnVzGAR+pM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>=20
> This fixes an issue caused by the use of msleep during spinlock.
> In the original commit, msleep was changed to mdelay, but this fix was not
> carried over during the backport to 5.10.y tree.

Doing this as a quick fix is probably okay, but this should not be
final version.

You are right that msleep inside spinlock will blow up immediately:

> ```
> [   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
> [   62.683957] Modules linked in:

But mdelay for 20 msec inside irqsave spinlock is borderline
unacceptable, too.

I believe we'll need Renesas to analyze/fix this properly after the
CVE emergency is done.

This fix is good for now, but better fix is needed.

Claudiu, are you right person for this, or should we cc someone else?

Best regards,
								Pavel


> index 5166a115879ea..90f2a0e5b2aa0 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -386,7 +386,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan =
*ch)
>  	val =3D readl(usb2_base + USB2_ADPCTRL);
>  	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
> =20
> -	msleep(20);
> +	mdelay(20);
> =20
>  	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
>  	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);


--=20

--DEaLSnFnVzGAR+pM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafhkXwAKCRAw5/Bqldv6
8l4DAJwLQ6N1oT4KVzwMek0jrXCS58qXjQCgvcp3cNkn9ABnuvmSjiZwaWyOiwE=
=iTXT
-----END PGP SIGNATURE-----

--DEaLSnFnVzGAR+pM--

