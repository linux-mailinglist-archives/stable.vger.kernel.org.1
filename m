Return-Path: <stable+bounces-268909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AHwcKjF+PmrsGwkAu9opvQ
	(envelope-from <stable+bounces-268909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:27:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC266CD6D0
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:27:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WvTm4tyn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268909-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268909-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D67D30098B0
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF7A3F660F;
	Fri, 26 Jun 2026 13:27:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9F3F6610;
	Fri, 26 Jun 2026 13:27:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480430; cv=none; b=ShnCjsCIgjft1lWfsY6ihlx4Kvr6SphvXbBv8CpBb3+daO6yFhbmozVZmxtzjv1KI0mw0CBiwiHYbza7z2WPNC7FyAkDoaA81cz3qg0u8kzt70+TgWYRg9/1E+L8/KhYK1MaluUoOrov5z0pIKWBgAuRriPddtV3R/NXilEZVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480430; c=relaxed/simple;
	bh=ArHm9gCwmJ3kGh2riTesYtLivEt1VqnJ4mJHDW/iaPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1pTqBlB66CkPhm2SoMaxsxnVQ5yJ+vrSg8dUyz3hH7+bLKD/XTmBGnQUVMCn5E/gaRtwIwgwe3a5MiGTqLNMMUrDqQMJYMFoa7g/GRV36WT+bwGcLSGM+FClmnzgtHRueeZ2WC0P5+ROsPuxGjfTAHwyjvqmno91Ye8YoCMZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvTm4tyn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DDA1F00A3A;
	Fri, 26 Jun 2026 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480427;
	bh=84l6LhSsdq+m+63CWLlmgKdSCmNBK0k0rmGZAgwBjoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WvTm4tynnvW5vIWDzIsRIKYFqfCn02TImwcAjnmbg+4+LiPrRPWja6judkkuMyMcc
	 9QK00F4qhUKTockD43SBZyLGHSrNvq4uYtNy8arM74MArc6A2wyu8n2xiDmKuGPSZZ
	 k7Dy+euS0QLD7mylCJok7VaQN9ZqnbCJHdjTYmIKgPhDVgSXxBIwJsCjnH79IceZYq
	 MsnU/QoGQq7KHrqzOpyplFNWdw5oWoqagWYYSm3yzxFkzQUyTa+wL5CGenFrVqmNGe
	 mvJlFcg/tbFxB86vwzqKpFhKkqLJdVukAQtSIcEbQXeWX0H+6XnGqU/fdBeBR1CPAN
	 45aS59lUkXi+A==
Date: Fri, 26 Jun 2026 14:27:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 00/60] 6.18.37-rc1 review
Message-ID: <f5afd75b-0665-4eca-ac21-f309a5cc7070@sirena.org.uk>
References: <20260625125645.554579168@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6RFxW+SZwle6fOY3"
Content-Disposition: inline
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
X-Cookie: A company is known by the men it keeps.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268909-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CC266CD6D0


--6RFxW+SZwle6fOY3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2026 at 02:02:45PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.37 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--6RFxW+SZwle6fOY3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo+fiQACgkQJNaLcl1U
h9Dm0wf/eY0BnQffJK3WWlhYnqaIEkrX8sAE+PVBf+j7SRUJ1uZ+RPwbdPyXyzpq
/VjgNLXak74VRgxxl2YfTdEygFnxTBPFJn8pqF82gcv5FqQJZkd2Ag/WP/nUFlhH
2AWASn0geJRqss5cH+LzdKrhYLgKbgj4qBDrDrecxVdLtjliK/HbbW+rLeIlxwBy
zHwN76gLoQg4BIjrVBys2kTrXUDEvjBuKG29YEztc1KipXKYn53TumS3x/vfrv96
CtOVSxDVFCRLfZr7/7omeP9Q5ofX+VNu3F4yE3UH2BMSlfgq1c9i6945oc6wJJQw
3HV0QNO+oWLj7R6OakixdIOzTTe9Ow==
=Tr07
-----END PGP SIGNATURE-----

--6RFxW+SZwle6fOY3--

