Return-Path: <stable+bounces-271789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kucoNnDFR2okfAAAu9opvQ
	(envelope-from <stable+bounces-271789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:21:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EC47035DA
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:21:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mPzcZaXT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271789-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271789-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13236306CC79
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E493B2FD6;
	Fri,  3 Jul 2026 13:54:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431DF10785;
	Fri,  3 Jul 2026 13:54:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086863; cv=none; b=T9Y/LGz70J3hnSjM1vOu6Ph9R9hJ0lOK8GI6v08CZznK8gMhb1H9WIEC3y2r6NyktEOMKom/h3Vc0sC6JBlT0uFmogEOmiXOFafE9+IA7rlsRDB6Rm5W3cvXjfoK9/HBq+At8jtNjjlPyktUdRSYgHPLd6b8CKp/3w9+rtx8Msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086863; c=relaxed/simple;
	bh=s4Y+xWGXovUNszlPHPMhDDPa4bSPq+nhNP7mtOimbpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRj9wCtBxjepKPNx4U7MxaM5s3YXHIoQ+xkujBmeR/yA5fh7Zb6R1CYcUNkhhYfN8SkyyPElLzOevCS81m/inrIK/FA5I9LIa1zp+XQoKeIcZjQvQJ42S17oh3dWztLueyrT67LCdAwwYh3/JCQAlqcC8EwCIx11AsCrcObXSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPzcZaXT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A021F000E9;
	Fri,  3 Jul 2026 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783086862;
	bh=wOeidbpHNF31VXB+k0TV8+kiqLfnJCfDKIGqTZv7/wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mPzcZaXT2jbbFvBh99qi9hULNZ8Fa14RITBWwTTo/bIR9NJRGtVsrQ8TbvNIlDP42
	 QjBwctfgEjCRVI4gMWAcSm1MOJrBDvEc1q+t+Zh34Rq7Y7JoC/BnRNsX5WsWWS0C+j
	 azaWL09Pr3Fj8A2tWXFbbF4YMjlw9Ec9rK4kGh1IAlJkXqEhvROShB150pT4B3LMci
	 EiRQg2QF/ja8zt0Lc4sldT7ZWQ6/lfXUICgrsJvxJ8EoBMHNq771bIXeOza+ST0sDJ
	 SNACl0WVz/+Rx3AFkZ5mAqpUKBQAdQeszuUj1nOHpC/jiyhHbCRk3dDtiZUNNnVvBg
	 px6Xxi4Dvn1Wg==
Date: Fri, 3 Jul 2026 14:54:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.10 00/96] 5.10.260-rc1 review
Message-ID: <799dd93b-1980-4fec-a8dd-ee6c767eaca5@sirena.org.uk>
References: <20260702155108.949633242@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tMNoZGjb6fHwc7ss"
Content-Disposition: inline
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
X-Cookie: Another megabytes the dust.
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
	TAGGED_FROM(0.00)[bounces-271789-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24EC47035DA


--tMNoZGjb6fHwc7ss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2026 at 06:18:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.260 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--tMNoZGjb6fHwc7ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpHvwcACgkQJNaLcl1U
h9DUZgf5AcY6lBAeVPqewVJTIrhCN7d2s4QahKzpYDxzXCgmqI3wli7KPdzET3CE
b4az/I+al8GJ/HwrwXErhU6b5JX+km3tx4BO3/vSPU3vCvX+At8SlbgsM4ZlHgL8
AmaANnWo/Qqwxr3pI7tUjBo4Xc5omkodfBxPvmkpalUyx+9dS5UQdn2x9k8r1CY0
tG4PwrJbLcUv4Oilrvs0evQHYIAufjb5kCbR3KRAqjhvJ3K4MyxWg1jxJEV/lKuf
gUJ9SrWaqTIxAftjh00O7wV8APgYs4bMlSXCcvgxs3ubcoNGMaGG5MR1p4Q+UGoh
tQoqpAELXFu0ZQcvX1er844JeUGYmw==
=xfCD
-----END PGP SIGNATURE-----

--tMNoZGjb6fHwc7ss--

