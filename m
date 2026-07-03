Return-Path: <stable+bounces-271767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UuOALJm2R2q3dwAAu9opvQ
	(envelope-from <stable+bounces-271767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:18:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B561702C46
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SKt0yjze;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271767-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271767-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7677F300F0DD
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5263D411A;
	Fri,  3 Jul 2026 13:09:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0461E5207;
	Fri,  3 Jul 2026 13:09:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084174; cv=none; b=hxCQqGuLFQ/S1lU/Fl+dh4X370VWwB54qDK40TibvlGBPOKatyytxVRt5HmWvbjR5oGUvQinkAeUfdrAaQSyypbyuQn6J+2qHiMMlGNLyukPU06OIAUl4gzX+ppbafWCsf9bPGOPMtxBzW0semM9FiXhFO/U5gNPu3PpgJ82FCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084174; c=relaxed/simple;
	bh=/e8w6cZgaMPsWK5ro/KNCP7uCNvMWxVzUDUwNnU7c+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAy26cPKXF4dR97r7x2dMbw7yPWHdu7CHv2+5+YP0bucnfxZH8a4Jb3Ouv/X+sgd7i8QTApUQwplGtGqB2kQKZCAwzykxG9Jh0epMI3RNvezWge1pjLYTT9XbmsunnfAX4XQfXgRKvyf9fzYQ0hT2sycQil9VoDxktYTRXqzmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKt0yjze; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C200E1F00A3A;
	Fri,  3 Jul 2026 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084173;
	bh=YV9YM6svHOxPk1GNpkKzQ1mBHZ76sp5xQQt/qTU3zH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SKt0yjzeBTgV0RjNT7eWtmf72ld8ejEQE4y8/NqVgB8+F1z2XTO3/Y04hwl+bEWd1
	 WeKgIVGAIN7Z6NpWq7uNwKrjOcMVQ80zT9DCIKUVBmTB5FShUzpyE+PHsdPAxYDS5u
	 v8Y4xXhXogemU1Lw1BB3iQ1aCgOUMYfEz4BQLYZ1XuQc7HfezRRfYNGprzkluLAm+I
	 s/Q8OISrUyJsJxSrLxZh0fcASYsetbRqlc42OUTKJhWFGuHjFV5bLWAeiQ08dcyoeM
	 DkuXMxt63oyw24wyuv9905CdaFkAVeAaKBedWdWeeyZvD5nCcGQ29fSew9U9Bsbblo
	 Lr6i3yhvVT+gw==
Date: Fri, 3 Jul 2026 14:09:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/109] 6.18.38-rc2 review
Message-ID: <5db38941-c87c-4389-b4fb-971aca010a77@sirena.org.uk>
References: <20260703072816.644513463@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2QJwJura9MucCLR9"
Content-Disposition: inline
In-Reply-To: <20260703072816.644513463@linuxfoundation.org>
X-Cookie: Another megabytes the dust.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271767-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sirena.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B561702C46


--2QJwJura9MucCLR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2026 at 09:36:06AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.38 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--2QJwJura9MucCLR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpHtIYACgkQJNaLcl1U
h9B+TAf+NnGdWj6tcMfqiqIzAuiPpuYVLwLAds5Z93WUJXGukaqHrCGAofFqWmWO
pHUoJ+Sw3ljBiPFiyOhD2o/DOC/EotlctafS2c0WQb56s5SCfEMLhbuRQNlTSuxb
fQXihSd9oB6H5TYdKFubIeul/eAutnjdBUwsn1MN7nnErNhDKyJ7mcf9xxivbBAi
H+DZYhmjgldkMUYRCbsB7JqSZm0INDWStyhGoX04ny2bZwZprQZu+NaGUQO3XnYv
fLLKo6hr4d+XJYLFYxLVH31uLd5laZo7/4wrWve7UF84DUUofgiz0520pZ5H9usM
wj5NwJ7+B77AHmrvXjZSu6lyZ0mslw==
=TE4I
-----END PGP SIGNATURE-----

--2QJwJura9MucCLR9--

