Return-Path: <stable+bounces-222459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA5jIistpGnZZgUAu9opvQ
	(envelope-from <stable+bounces-222459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 13:12:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6881CF8E9
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 13:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7513010D81
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD6320CD3;
	Sun,  1 Mar 2026 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acFbncSt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B5318EFA;
	Sun,  1 Mar 2026 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772367141; cv=none; b=WFq2kp0Js91wDeZy7VWkj0ATSNwgxHG5WOiCdDlp+Zlwgibn1++2HJMc2aXteGD95oZhavXQwW2rD8wyxZLdIjpq/GV0wxmCUmyDjEsxbFCAXuhZs4EQYtMgLqoK/1kfOSRFhRaZ8P+B76DZLjWdbJLUARt6jtuocz6RkSiP7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772367141; c=relaxed/simple;
	bh=aeMPdRse2FWp1KY1tcxQwisEblau3mmljHUlMFyaaBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU/LKQ8pt3kZ7quMLdG5puTPRsKkGDtT4vsck+gVB2J1zvwtSkkdwx/nAsMsGjsl5vcf8WK5CTftXV24QMslcPY/5d1TUhtkEwgIIhBFRuI+r3WbMoF28IlHH1Xpr3A8QHGdpbcDkGKhzlTzMaN5H0ZCdw1ZdGlfG8fttLbW92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acFbncSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CB1C116C6;
	Sun,  1 Mar 2026 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772367141;
	bh=aeMPdRse2FWp1KY1tcxQwisEblau3mmljHUlMFyaaBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acFbncStLJf99IfBqcMWA2H6SV7r2YXwM7Q3j4RV/l6r2j8wGtWtK7a7iSywUy9o9
	 mCFGu2pUKdRdosNEWDGNdiyBcZaV8HcE5ChMefyw4/6Cy7TuHI1Qj7Ey+WjKR5m93h
	 NRjleDbKYQXFz/hXpGrHaPCyfyrCTmF9+RhU44jeXmf10XaN2Cswc5YuMYwGouoUEO
	 egj8mp9MEfMWfKobHPowF8GTno/ELz6LfiXVZRbZMkD5SlkodbAX28hxpnIJlekfzf
	 yocn7bNkk3LpjlR4w6clUPnINWMU2Zw1IC6Gqyf5hmaoTwMlDnzOWvjo/+xKyZqHqu
	 DknQZzfR/vdnQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id DF86B1AC58DB; Sun, 01 Mar 2026 12:12:17 +0000 (GMT)
Date: Sun, 1 Mar 2026 12:12:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.10 000/147] 5.10.252-rc1 review
Message-ID: <aaQtIZGru_q8D6LL@sirena.co.uk>
References: <20260228181731.1605473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3UA88mlBsxUNF+/E"
Content-Disposition: inline
In-Reply-To: <20260228181731.1605473-1-sashal@kernel.org>
X-Cookie: Think big.  Pollute the Mississippi.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222459-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.co.uk:mid]
X-Rspamd-Queue-Id: CE6881CF8E9
X-Rspamd-Action: no action


--3UA88mlBsxUNF+/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 28, 2026 at 01:17:31PM -0500, Sasha Levin wrote:

> This is the start of the stable review cycle for the 5.10.252 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--3UA88mlBsxUNF+/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmkLSEACgkQJNaLcl1U
h9Cjvwf/RzesrE3rcxCac2r9kg4rnDMO39zD7tLCm0wLcwx6QpGniuCR0fo8N8g3
DyR/g72eNGAe/iJ+hWMkNt7FTtJT+J8IfUMRQeOx0y9uEKyjuzNaOcDu3jMqKyDq
RrHu7HewrRuWX6sopLLu8MRGJrT2eGQNG/3tV2DUrxfW2T8O3kDfsCICXTILLACb
XCqvRKAWEnBWKBIkN9rrrWE2MxdmECVKjdQm3Dwn/JyKTIhRNsq5Q7Dwe0waJGav
XY/MaIZCrqt5gzO8qN15jSlTYTKG0SReyMP5p58mYbfYN+UYNHVbV4gYXs/xO7nu
q67bycwUMLbsIAUU3leqM+unt0xI5g==
=tVf+
-----END PGP SIGNATURE-----

--3UA88mlBsxUNF+/E--

