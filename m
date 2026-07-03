Return-Path: <stable+bounces-271764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ry4ZO+q2R2rUdwAAu9opvQ
	(envelope-from <stable+bounces-271764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:19:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678D702C78
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:19:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X4x+MK1P;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271764-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271764-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25B903078FBE
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4C3D47DE;
	Fri,  3 Jul 2026 13:01:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0553D34B9;
	Fri,  3 Jul 2026 13:01:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083702; cv=none; b=iC1xbYUHHwnhWO+p6+8oO/H30QTY2IIQI+1B4skP/CUNxKCOxMp/J4Ca95lMQfKp90RCSBNeXf3Jt27rPfB0aLbE0672POBGd1wVLflNQiht+SvlLqNpztf5IviW6EGdQuC/aa24CxG8FnjWgL5OJ+jX596hwtMy7E4/QE9oMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083702; c=relaxed/simple;
	bh=AbzBDH3T+wh4F+diDHMBqWKM8WckEbhLYcjXYqcEh6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H482JGDEjTFDRLrt4m7rjM0S94zUyeXOvUxp9UFWADeoMyo7g57tfQvd05SObYVoG79bXZJbFuW+gNwkEGmUM5yMre51/AvjhQjdm7K1aOLiQT7gbc6Kxtd2S3JeJkmdgaOBfG9CRtPT/ZHO7Q+qPyYW1OEZHR+9q5n5gGpnTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4x+MK1P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB631F000E9;
	Fri,  3 Jul 2026 13:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783083700;
	bh=8BWh3P/p1AtnXbYiaKGUXteMwmA14h7nnMyUaFNgjds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X4x+MK1P9orpK0tchxOID7y/aHuivL3CiPn6/RvGs2bsyBty6EXVwKK6L7mzTea1V
	 XQO9TCs1Vog1B17n+JMiFa5YLH8HAm1Frjyvqjiz4f0cCZBqTtpRBtkOSgkRK5CHAK
	 NPugPbKPzHmTCzyuIhVPuXLnD/ecyMRlT4Fd+IupeTrHH6RioOYeebf6ruAezM9G0S
	 z2c5Ep88R0JenhY2jRzT4O28ZSSp26Qtd0xT6rLjvMAxQgbkqkYxgebNl9YcwxaiHp
	 +/qHKMct6pACjRBNANezru4MOy0S4j0xIRy6MszHKYQMXHcQ2idlrfh1uGouw8y3za
	 Xyxq74I0Kwu4g==
Date: Fri, 3 Jul 2026 14:01:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.1 000/121] 7.1.3-rc2 review
Message-ID: <55a271b7-e62a-4aac-b58d-78607eef3ed8@sirena.org.uk>
References: <20260703072822.817328079@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5x9XtRP3mHTq+OL"
Content-Disposition: inline
In-Reply-To: <20260703072822.817328079@linuxfoundation.org>
X-Cookie: Another megabytes the dust.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271764-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7678D702C78


--k5x9XtRP3mHTq+OL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2026 at 09:35:59AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--k5x9XtRP3mHTq+OL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpHsq0ACgkQJNaLcl1U
h9DZLAf9ElVRlI9ve+3ub8K2BLnTm7HRUNLcAL42Bw8rMpqk1o0pg7ZJjZLioq1Y
1RYxiTgdXDG59wjBJuGfmGoYmZDklwyDqjm4DH9GIt+yUfRnfPkhvIsrGt5bbTvU
7ihI0RsOAg+zLNqkZIZmkxbxeOS/btJITX3Q7jsUU9T/eDun2B8O+U+r/TVqAHOm
uWNDRwf9ZGXX4ZCt9W4onOs9y3eIg5VQAUwxLPEGXF7Fw9SjZF+k+INKztaG44GS
HjMfWZuQI6Y2I7MqqmJJOFV2DrrPytG4DIiQLmMdHHdzqNs9vkFAFc5oEWm0RHUu
L9cN8OcNqXgAbHzhVKKLJalDu2CW6A==
=c+6j
-----END PGP SIGNATURE-----

--k5x9XtRP3mHTq+OL--

