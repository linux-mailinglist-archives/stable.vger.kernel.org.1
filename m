Return-Path: <stable+bounces-241060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHuZEPLl62nNSgAAu9opvQ
	(envelope-from <stable+bounces-241060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:51:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A341B463946
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A01C43018596
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3D533FE0F;
	Fri, 24 Apr 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfQiwHO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE4274B2B;
	Fri, 24 Apr 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067503; cv=none; b=CjNF4qlmki9sWP94QzEXfZij/G8kjMZalzahwdoUWQdgeGCEqp9R3iJvkFmml7YdR7E1ia1O1tvxpryycwTt9O/I8O+4b46fisnRiyRUN73yx1VR9uc2rWZrp4q7HgXbZimF0jPWQSYmtUaqjlejRM40eyBusihXCRumoYHoBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067503; c=relaxed/simple;
	bh=TZF7+rdSxIYKKQoCmgaM1jARCCcQZdPZtWqdEagDiGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJnteE2PiK56YE1ksT8hqssTkKIjbwU1/JvATMzQF2dEShmNaTtz337gOSC76b7BycxKZO172o1e2nvySJaBFQ5y2ID4PhYqLHEkHA03obdWbkcN+efKdY1eyDSvIMPEX550m1f5qrmHvZvEU9dkzUP1l3wkSV86fQtsjveb33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfQiwHO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2697C19425;
	Fri, 24 Apr 2026 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777067503;
	bh=TZF7+rdSxIYKKQoCmgaM1jARCCcQZdPZtWqdEagDiGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfQiwHO12wYFO+NkZP6c3ra76JX8JgqpK25Lkef+J6AHf9sEsPYoAUFPJ8TVU0Mzv
	 7ecLwaXYJd8Jp6LJER+oQuzl1XhdZ0A4o3HVw2uyLTpmx2OhGhw2vPk53tqWBzFznH
	 cS2EyWNJDqElZ6vUA6DzKgMB2mUv0q4hxxDrEm9pY0J6tG8jv1N8TZu27zrRyj5cbG
	 MN2l09OontjCjqiY14d7W+/48G4j4zdN8q+fmG49n2ce87/varPtnU3B4/9ngB5JfM
	 vL/Ou3kkNIkAtHVuHEMBOa6U8tA0olCHsCahyDGZhN7JJd0YcNXurV4v6nxE43C24P
	 vj0eesYWhR+FQ==
Date: Fri, 24 Apr 2026 22:51:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 00/55] 6.18.25-rc1 review
Message-ID: <2f14b31c-ab0d-417e-bf91-866264c293ed@sirena.org.uk>
References: <20260424132430.006424517@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G2n2+xxaUyxMc8ID"
Content-Disposition: inline
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
X-Cookie: 1 bulls, 3 cows.
X-Rspamd-Queue-Id: A341B463946
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]


--G2n2+xxaUyxMc8ID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2026 at 03:30:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.25 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--G2n2+xxaUyxMc8ID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnr5egACgkQJNaLcl1U
h9BpQwf+NJRRD2d8nEeGDw/t4qxlyka+DKBHZVU0V4uOFFY9t9/hlUYEzmQiHf9U
I9wvTGQbJOawHRSH2WH4gMf5uU5XaEGKIeaSx01Wz/uzsu4Ly6MStl+pvS/r6xlN
4226KgixoHLiS9LNKXcfmvGWqhFNM15gzewVlQJb8FHRR4sh7QgYlMj/psVtxZBd
qqLdsXwGBkiOGB57mwykszMpXAAcgf7cVTMgS1g9gnjg/ErDsSWfoUNpVYuEMQyy
28ZZN3oxtbL/6wGuf4zU7MFabjhuSjwK0Szm/GaJ/HkOS70Zv7ry/P//RQhpUJZ6
gzzFJJRm8ylab1d6ApK6BvZBHk4TOg==
=B5NN
-----END PGP SIGNATURE-----

--G2n2+xxaUyxMc8ID--

