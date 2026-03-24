Return-Path: <stable+bounces-230176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEL/OQyfwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:26:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DEC30A1B9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC58830B20D9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322143FE658;
	Tue, 24 Mar 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM4XY3+V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91083264EF;
	Tue, 24 Mar 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362218; cv=none; b=myuZth0qsAetFUhQeWAK5URykY2/YFxMLjxBMS6eNs2DgcHg3EZGPAoVKZN34szPFMC5hQtH+Uh+GwfWLZE2CLvY6OGtWaRaWc1pn5ISfzYYuGX2WEbjWnULefJk2nI43m7VMv6h8SKO9hPwZaXS+qqNEPnQRxLhooxedd67zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362218; c=relaxed/simple;
	bh=9Z7GaYs4fyCj9d0eSk8XQ6gvnDwH88gapww8q0oEjMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqCutYeiinj86OL9pooPUq8DX19QLl9VcTHP/hmUkHzx3KJW+Wy1ynGRZISL4U6oG5aVgGNMWvdq+HQ40c4imTM9P0lT/vEsGoOn7ejGr4GUkMiDZ/yNxx6AcinIkRscuBsD6M94ixUHi1dnGVtGCVV6Ieh3LUuZim6/2SN1YcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM4XY3+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51744C19424;
	Tue, 24 Mar 2026 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774362217;
	bh=9Z7GaYs4fyCj9d0eSk8XQ6gvnDwH88gapww8q0oEjMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cM4XY3+VRCOB6GnN+juDD+RK1p0RSFlTP78a7gWpOf/uPC9Bo3g4XkwnQegUFaTf8
	 +lkDb7TaMRhq6DDWA9flOWzmtDkty1nV/0lJYVdK22eO6d5hLqsUdMweuD/Y3rUP4x
	 1gtv2BTi2nonsJpR9juY1La+wS57IAC8XdwqRsp06dGrEtAG/8SPiU1jBORXAaKxOQ
	 S08Hq8mNSoblxEAlU2z56Zri5X37JzFQ57vL6qWBP4SEzqQgx7/g26I7SuiNWeuF7W
	 /32fKpXbTPI2xrNaHLgiS2gwpsQsbXM7ATv9uAhS0omGii4R8/BUkzVbur5nt5+GdE
	 59soqPQcBt8Ug==
Date: Tue, 24 Mar 2026 14:23:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
Message-ID: <8c15779d-e694-445e-aa95-bb1fa5f634d7@sirena.org.uk>
References: <20260323134504.575022936@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4kWViM3Svr/eY1P/"
Content-Disposition: inline
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
X-Cookie: Forest fires cause Smokey Bears.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230176-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44DEC30A1B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--4kWViM3Svr/eY1P/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2026 at 02:42:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--4kWViM3Svr/eY1P/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnCnmIACgkQJNaLcl1U
h9Dw+wf/WWHObsFpH47lFL0ZXakvPwI92D19zu/DDuAsgbnnHM5+tu/7LJx912Oo
ixMTsyz+IJQhJLKdpjb1i4UKfjhfJN68WPHNLEXDBI/C7FnH9pP2q0a4NywoNLIm
4A3kB19WK9Ihcb+MBvWousUKH5uxpeQ83dP/IZb4jg8o1RiiYNaOQo/XME3ZEfvd
1m0kYOcKCypguVdAMvN5TiEZGAFVn2tPqB0ONm4EcfoB8F9TjGApz2mh/S/rfQ1M
MrwF1QeG8KiKdewBYXsQerhrgoELx1G2qq3Y6Xx9SQyHKGRY6+swEImLbkts6yrW
R/Dyl06iRGWwtEv6Rezz4kxBHAPV2g==
=Bqem
-----END PGP SIGNATURE-----

--4kWViM3Svr/eY1P/--

