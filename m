Return-Path: <stable+bounces-266782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DcVuGZSuMmpH3gUAu9opvQ
	(envelope-from <stable+bounces-266782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:26:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF3369A847
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J4ZGvepd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266782-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266782-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA5DD3028142
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756B449ED6;
	Wed, 17 Jun 2026 14:26:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A73F58D1;
	Wed, 17 Jun 2026 14:26:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706385; cv=none; b=UCijoIc9Np3DSRuihTEnan/VHRieUg9193die2k8K3u2YKzo8mU4bfb7hi0QUGBd4HfIXITVccldZBQzdu4oEGLdO8f9VX/3iZNod8YaDMgwlko8rViR68kRJPdau16wLMVg1mvJivnmYHVOFipgMJv4umf6cd+lclflxcEZaMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706385; c=relaxed/simple;
	bh=piWZjWgpY6i97lZ7IrOOepD5NazW4NIySKzMMZOf3L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+3zWEVa7NWQVUUitUBGy5RElZEG9Uq53p6aXNKz+AlBdTcS0abqxd6SJ2o2t9LIYHeXiuhrj2d3nVVj1wWZKYBqak1d8p4INnJt43s8XKIthSHn6OlIx69yxHyjJoyeYwGB+W4tVPB3Lx9SoQsEJcNXzG5vXNpxWht1pfI9sn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4ZGvepd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCE01F00A3A;
	Wed, 17 Jun 2026 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706384;
	bh=cyfcgLixjIJ/ZNlakykDFftx+mwdMiYzFjxXOqLJVTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J4ZGvepdX7KfkIpO65JtGyM0MQn/jAJ/90zWXZr8lKJqcLA7aHu/6PrQLVLTKDx3E
	 X92s7E+EwnhOhAZuH1Omrscj/Ia4lqXFYB6AsmO0O6P84rK7MuejoeLheAPDBZ5pOl
	 OsZ3MdvdNedbSf7YH12mEaU+x+5f7sR+g9pSajP60drIMZInnaJ6BOnl92YK7V1EQw
	 nlqS4n35wEE32g4f8KUa8ufHdRw5ziUvNCathRn7UyK+kREOamQDh+yPI5lzLNzFCy
	 w2AgkKDaglTEb1LojrIcTp5mf7IyDPt9macYSHjBAd0R4SZQ3EHC8vY4Jb3PNyCNZD
	 tjdlpqV/bUKRg==
Date: Wed, 17 Jun 2026 15:26:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/522] 6.1.176-rc1 review
Message-ID: <89b84c07-9e6a-410f-a279-321a8085d167@sirena.org.uk>
References: <20260616145125.307082728@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QoVnGzZQg5ZjXRwR"
Content-Disposition: inline
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
X-Cookie: Absence makes the heart go wander.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266782-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEF3369A847


--QoVnGzZQg5ZjXRwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 08:22:27PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.176 release.
> There are 522 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--QoVnGzZQg5ZjXRwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoyrokACgkQJNaLcl1U
h9Dwhgf/bDevMaXuBDwdT9jacbcZaEBGkn+FyQDM4e+a+SDqXPHk4gRkAxB8XBcI
qJUOgdzBkRzQh5VLPMS4ieUxnIK8ttopMqlolouemwphG3SsZ2RYLJtI4b3d4xw4
X8rHG1z5OJZl1D6t1QjvkH57x0OxnC0TTo9B5pSOC7SyjzjVCphCE4BAYQuzB6ru
l/Pi6JjCJ3ot7kZs06AoPaOGQbXARWo6XsN/l9/DjwdAEwGTbfRRQ6Bm/wL9Y9jY
Cj7Ca+2I5p4K0G4byKj27om/nes6EF/RtgUD0I0lkNLt/dK9CQYqnVO8R78wFex9
7PDoHISig0enmM1p9L772uWrspY13w==
=qvu4
-----END PGP SIGNATURE-----

--QoVnGzZQg5ZjXRwR--

