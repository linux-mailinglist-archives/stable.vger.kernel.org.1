Return-Path: <stable+bounces-266775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vhHuLdiqMmq83QUAu9opvQ
	(envelope-from <stable+bounces-266775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:10:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF569A6D8
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:10:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ch3HY+OY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266775-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266775-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219D4302E902
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B846436356;
	Wed, 17 Jun 2026 14:07:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE31E32D6;
	Wed, 17 Jun 2026 14:07:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705256; cv=none; b=RV429CsEZB+WewiC7VON5qi3mlHJvUJA1w178ueje+0K9lXcrcyEQ5dEaVRZ19u6PW1BtJVRYZQGpHSr9Il/rFiJ3HMci6QeWV+2Z0nFzI06YsdndUQaHcGWk7aY7B34T1WcNa5Zs4GX0N/h3PUM2AzfZfcaxFi+oR2qupNoq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705256; c=relaxed/simple;
	bh=yvf+aVJD+/Ptq2rqsTYX2x9P09IW5EDooHhtopwJkk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFoCVpCbUjjJQ50ai9sEYceJx95XkmNc5RDsd0KW0/A2QnIqdVwMYODtBrFJ+YHqw6WQPQhDFsLaJB0ZL4qUxTE7EitAyV0FVS5X8QC52H0mblUM7GNsSy+qgjiCnwU7xG9PcJxTI/cibH8bGCmXS5v1PSFgrydEfsZMsr6FBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch3HY+OY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99151F000E9;
	Wed, 17 Jun 2026 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705255;
	bh=Iz3+qRjVW2r1uJNGxLHFf5ovKeC4xDqW7ujO9LN4qAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ch3HY+OYJVrBOWvADnfOcduZvXa+Uv3J26MIzsu4JAtdpDL8+BjdjBtmos22JPX0F
	 bzJuCVaMDjSL+Nadb5x0I3m2pZByDTusnTW7EzIaYlUEHOl8HJZ+h+qmput5l8TjcU
	 nLO9pqHqhfj1/sPmGjwGEefcB1L+RgSoAUSbS/MkwFzjwrRDE3zbBTgagDtxBnJ5Zz
	 cb4pkorJI/hZf5l3ZaRzo7pLupo2WGsk12YBAVuhjFPpwm4oSZqBhcgBqPdaxi8sDd
	 0PkSMBnv8vlK1JC1u7o4bHQXhGuIHsZ+yoiLtNV5lk0fUKJtxnioIGTbUzWRlTC4SF
	 qhYxclA/zZ6aw==
Date: Wed, 17 Jun 2026 15:07:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/325] 6.18.36-rc1 review
Message-ID: <85832846-cd99-4a13-ad95-2272ef08b941@sirena.org.uk>
References: <20260616145057.827196531@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wLXcK03wNx25UkZe"
Content-Disposition: inline
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
X-Cookie: Absence makes the heart go wander.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266775-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3EF569A6D8


--wLXcK03wNx25UkZe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 08:26:36PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.36 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--wLXcK03wNx25UkZe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoyqiAACgkQJNaLcl1U
h9Akywf/cwyYCsRUzczN+FtLllobfMbjRVr98UM0GdZXYlJ5nv3opA5z93bMNBNz
xGY5vBwOyyjrWxkRjxEAdvVLKxZG55Cj3IUKUPh6CtyRgIE+KMpVhmeMhKBWK0Rq
Yo4at6VuG5OG7y6c5sADoUWoch9RE8rSqJ4FerW1N3s2giDpJbya+UE1fdwo5VTq
7SWNJIjooAn1859gvhH4a/ovxUju1Vo0rAlA8E3ZNblr9Vuia5JYTZsTNIKKizzW
YvI2PbW57LQPY/a7hc1IlSSLPH+7GCEp6rfJ8SbFIfqcnBaK2ZbgF8HhSc1bbDRE
yAT6VGnTXY9cgWgUVVT9MfNRNlpnvg==
=18aZ
-----END PGP SIGNATURE-----

--wLXcK03wNx25UkZe--

