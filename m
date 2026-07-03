Return-Path: <stable+bounces-271785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNSCMZG/R2qaegAAu9opvQ
	(envelope-from <stable+bounces-271785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:56:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4910703233
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:56:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B05uNDxN;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271785-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271785-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6B58301424C
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A171F3D952E;
	Fri,  3 Jul 2026 13:43:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C43D649A;
	Fri,  3 Jul 2026 13:43:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086222; cv=none; b=lm/1wZOfDDR75VFAwncwXkmmLNKmVlcSOf1YVX9YavemA0TtlbSqwFxioMxtzExElzuaHF8F5C/WmWuSbK5P4BNkFGhbgPyJUTQ79wpm/22SUlr987MY33R3IVL7fX3Mqr84PiLo5n9buiy3QG1G6ROpM/E4xOCekILZLn81EiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086222; c=relaxed/simple;
	bh=iIso7eM5YzbFrTo3iC8P44HQMD19LUhEpkdpF2m/jo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkm/5BEr+VeWPFFBsRK6S05Tgj+WGXhorc9sj5cwKh7pXcKhy2AD6bZDasV7kZMSfLqpS0UD89yzrfTlcPon156MpZE3os2HxoLSu3/06pKRswO64qn9TA6veGt08wgpJnRMQb6yi/9+Mlenf/PU+KAVvoslWtf65EyLPemEKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B05uNDxN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3801F00A3A;
	Fri,  3 Jul 2026 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783086218;
	bh=s38nu67LJp4w1fQqHhtc1zIkXxsdmvH0k9LPs4dIF3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B05uNDxNJzhfGL6Op1IoiTgTZTW1xPrxpHJBdUPXA2PAi4dd5WhrNQv7txr4Rv0l1
	 L3jSBz1oKYKqA6AQo+V8vKPAx0tTK0SzPzBMUYYYr8HiLl1DNhjBbr6UqMfgFCraPZ
	 cuW3nKe+KbFMFKBcwAuGKhbMqOaeM8Y91fkNxKUvRbM3fq/+2fnHcwSfyTPnac46I5
	 MJmb2Ncmlo1vRMvXjxGncLUA8p9IyXfMrgF3pHrOzgG1Y3qHu6tTlEGvCbmsL9MfsW
	 eGGPEYo/f3dFmxHtC2ko6V2EdQAWA0zJFv3klMvWrPrV+UKlfuyCViFtkrsxfVhQFb
	 BVgtDjzaEDHzA==
Date: Fri, 3 Jul 2026 14:43:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/175] 6.6.144-rc1 review
Message-ID: <52b3e867-5915-4ef2-82a8-0caf35131703@sirena.org.uk>
References: <20260702155115.766838875@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0GQLPP5UiXITDZ/t"
Content-Disposition: inline
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
X-Cookie: Another megabytes the dust.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271785-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4910703233


--0GQLPP5UiXITDZ/t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2026 at 06:18:21PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.144 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--0GQLPP5UiXITDZ/t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpHvIMACgkQJNaLcl1U
h9CkoAf/ZyfIfCE6Y0Ju6yK+U+vO3TAFenGzqZVKhm3WDLtW4xuz/oQ0TLA0ZBxQ
ZzJs3rDfnlCNL0MsBo1PhwkL5TXU1v++NpU6ShGkj+2pxKlOEqvv5Wy3EhMZItj/
JWc9obTdkgYtLWnpm/1i2tIq6C6dX0MmzQZwVVtt02FrMr6x2PkC7HnbPMV+tzNU
lI2eo0HTCBDGrnv9yUjBLC62F0dV7SZDkPMsA7vju4jdvD5GUp1gsnzdqvo8hf1T
w0DNHAmOsq2iNzmCgSR7ryEH+dMXEKo6IYlmVm/gIsmTvWUZHaW0IF215NRWSETw
fPvZs6RfW9INyCKMlFb9d6cd9Isamg==
=ldOO
-----END PGP SIGNATURE-----

--0GQLPP5UiXITDZ/t--

