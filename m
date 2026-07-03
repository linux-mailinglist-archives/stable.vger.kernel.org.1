Return-Path: <stable+bounces-271788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNb/FEHDR2qqewAAu9opvQ
	(envelope-from <stable+bounces-271788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:12:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D87034B0
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:12:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hK8erk0H;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271788-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271788-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43EEC30B6CD2
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79C3D890B;
	Fri,  3 Jul 2026 13:51:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D5282F05;
	Fri,  3 Jul 2026 13:51:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086709; cv=none; b=daaqTmn3Kl3i5E3G1XpDWbbmGjCV9EWoxFzR9KG772ynga8ntt5YWEC4JkcfigOJH0FqUssvLf3saM9meLdcB/oznwib6bTRE1IHc1YJqNU9lUpEyDuT6MMrtRAI/txcdAa7jaoYSaxk0z6tMRrdAKEZY8pi7kMjdzg+aTeQMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086709; c=relaxed/simple;
	bh=19WJ9HODZLJv8Lesukqg37SBrsR/D2pzE8nDAgcn6XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBUudPxhWLIa28Vv+DjfYPmdFZe0zNQGyakIOSkOjg4D3Demiz3Th6D3eQpcAGxa52KfXULVQO0Ia8/gMbnUfYSjFE09MQq8wvv4+RkzNaJkMiFXCBHeg1dJHxmLpEQ0GXq3cWCV0Znjq5Ah5MTq8FFOlmDKuppQoPgdlU44ZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK8erk0H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3352D1F000E9;
	Fri,  3 Jul 2026 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783086708;
	bh=CiVzOy58l8HEeC0f9um7FAFU29Yvpj89dJm+vd6iccM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hK8erk0Hoc93ueRqlDqgn3E7NUHIPm498sY77vEP+rYQz/OpyXCyXgF8R2xycuiGX
	 6aTndm73x8AQ2hhq1FcV9U1xM/Mb4yE34G8cjcsxOW225oeDqDlRC52sMDnz9jJSJ5
	 /EmYqyYZ2EAceVw7B1pud+CzdXmquJKI6TiBaYpdCJ6Z2mppL6iuXECctGpXJzvqet
	 bBzXqRAKW+edEOh1ibVaIu19hRpZO5eKtM9wD4wC72Ps7uQ5ui/AD9iO99Hs1VOmNI
	 EaWt0thSd0Ke/OPSNtH1F9SOk7axq832E8eVpwt+XaiiDwctvnHdbz6CVsbXypNWr4
	 hrED/+otWAJ9g==
Date: Fri, 3 Jul 2026 14:51:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/129] 6.1.177-rc1 review
Message-ID: <e7874ab9-ed1c-4413-a9e7-72f34bf3351b@sirena.org.uk>
References: <20260702155112.163984240@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="//BaLQY0hVQ7IdcP"
Content-Disposition: inline
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
X-Cookie: Another megabytes the dust.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271788-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D2D87034B0


--//BaLQY0hVQ7IdcP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2026 at 06:18:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.177 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--//BaLQY0hVQ7IdcP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpHvm0ACgkQJNaLcl1U
h9AtRgf/QJeKNmHj6UzPtnq9laXfFbbTHrfV5g1W1nkManrVgJ+it8YaXj1tImzy
npHfbIbDtRyMpDvvDdAjqQLy0nVEavwbz/TqJAQwu7JiOSPjdluWFzDpAJLA3ie8
zknkuOVfKZhvcpQFMRg/GgCVjZzDoe0AgI1yn15GmgQ919C4ZpGFH+SeifkBKhdp
AUx+tLgLfvv38N62TAzHWycRypF+RggfZCE6NW8kxksyIiC81JW0/zoUKI93F8MU
mPa1C2PABEdQ+yHTS1bycbKuVzlhbnfGnUCQTY1Hr6bHVtTkfWqBApnQl+cK1sln
hBNwmzFBhcH5lJPv//NLTo+LZJdOBA==
=9Pc0
-----END PGP SIGNATURE-----

--//BaLQY0hVQ7IdcP--

