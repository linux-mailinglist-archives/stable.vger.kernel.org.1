Return-Path: <stable+bounces-266765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /nlHA5mkMmp43AUAu9opvQ
	(envelope-from <stable+bounces-266765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:43:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91C69A37A
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:43:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f5BD7lWe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266765-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266765-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1063B31CCC08
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05944102F;
	Wed, 17 Jun 2026 13:39:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73043E4A3;
	Wed, 17 Jun 2026 13:39:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703544; cv=none; b=t+NYVc+BQ2rh9fRR/EkNYa9BnoUoTHP0Utatc+J5U4ybDK/PCxzLX0cAfPKTWBCtF2YdLapA9dKEQfpmNLPEJBRjimRc86nE0FfuZe09YjQ6cakk2ejobwv5nWZQ8ytdUJLfZFgJvdK3H08Ldm42emD+fpYuXFuctBFV+lwuKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703544; c=relaxed/simple;
	bh=7n6uX5sgBP3H7L+JRySvNCAbd/Hhm/4m798Vs02XrLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+BxOV90rQQrG98YiMqQy6bO5GU4PqMqnLB/K4+LaWnlHDxfNByTLI6EMlALgBmBhkZOZ+CYQyil2DKmOUacUlE+chVTOBwn1D8/Qm+IIrvLEQYhaKE28n8eCEAaZigB6J6Dk26R1l+1bvaKqlRAU4AtGDv9E28piVTztYm47e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5BD7lWe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFEC1F000E9;
	Wed, 17 Jun 2026 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703543;
	bh=Cggb5mxx9cT+ADm22ZLbyiG9E5t6gDxXFqSh1qXkGDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f5BD7lWeBnyyok/jmaXeicp3yKSLD3BUqsU2T49MYOF++pKg1uCXM2i+GKkSS6BeD
	 tSXiZstOPlk6X4KYg8ovMo/3OvDO+vOtKmBIyi41L8mGWWUuQDFXE9Wnqw1ZNHhhnD
	 ZZhRnzsRg0hDwAI4KyrUxW0iYPU5dUDygk4+R0ofdxtf06qMCpKQH8cPYF+njMm11T
	 7MlySuWxbpXe5U9ahGctcdWwy6iMGaHH26AqN8W+Jfog+MzeQZo4O+xRvSd4DMZxL3
	 dWCK/N096QXafi9AIUJFwD3325XZLNISYWJarZHJqkVBmil14nic1QvVQBoezoYzeC
	 MwEFV4ubM36CA==
Date: Wed, 17 Jun 2026 14:38:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.1 0/8] 7.1.1-rc1 review
Message-ID: <3512e166-abf0-4721-92eb-e9b9e7f86438@sirena.org.uk>
References: <20260616145523.335696673@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PAWrbe6LmzWMs/UT"
Content-Disposition: inline
In-Reply-To: <20260616145523.335696673@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-266765-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D91C69A37A


--PAWrbe6LmzWMs/UT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 08:28:45PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--PAWrbe6LmzWMs/UT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoyo3AACgkQJNaLcl1U
h9DkEQgAhIo1tZ8EGWo/03WW1o0BpXCXzD+6IpOgh9pZPOhp2X+KS+fOuvqRot/9
w/5GsVCKEeiBN5DakyJVQTwR2V0N43nmbyLnuQE4D4QTVwAuS9ZXpDidWq4hdOHY
GI9q5eztcCysTLWMXhggVj3d5oCnMCDC4qwa5c9FX60SIDttn/RQH6B71+93SZ68
jS8Ln3yN0OmjbjTlWs/Ivz5U52BFveX3Bn7fF8QMBwmQ/L1MieNOKVriy6eOjVyS
D4eMK2RKsvl43tb386fgHDamHWzlci8MnnXMLTkBfX88Gdm4955f0RhgvffLpgJ/
EOVm5asBKNeRY2S9uGl5+hFGwna4iA==
=z50O
-----END PGP SIGNATURE-----

--PAWrbe6LmzWMs/UT--

