Return-Path: <stable+bounces-217271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI1PMCaqlWkxTQIAu9opvQ
	(envelope-from <stable+bounces-217271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:01:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F74156324
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A87030156E2
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140872FF147;
	Wed, 18 Feb 2026 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+aUn7+d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AF2DC323;
	Wed, 18 Feb 2026 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416098; cv=none; b=h9o0zFGYzYOkUxvg4Okx62oiZ7Gb/vXjYT36NKEAWJ7L9f+FzTe8IYdYzetSVD1dqfvIFXMRw6b6l13kzZENVzJIpVJkOMR45dmfcMf4Q8JdtOe09UL1CXo0GNTKLM5Gv9/AgVYtgRstEbFTZh07gGmE/pURHx8xG2IAeaCEADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416098; c=relaxed/simple;
	bh=6yDMTQQ0G4nUBFs251+YdcQVgtsYLGuSCddSbxN/IAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJqsxz03qSFXeJhn+pmh0fmmIc7M03gHHdsJ3VEjuOJPSrhkPk3Pxb6wyY5ge65PiOQm/byrVJJbs4p5vgnTMGqyLu00UVmc+/Xm0NczGbFiwX8H9YYk3lERmgS3wasEnK4HC/hhCdRRBjPPZiwDwT5rehmiKRKCo7WusR8ADVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+aUn7+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287B2C19421;
	Wed, 18 Feb 2026 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771416098;
	bh=6yDMTQQ0G4nUBFs251+YdcQVgtsYLGuSCddSbxN/IAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+aUn7+d+YMsiGFNRZs0MBj0yu/zBaXt8erPX6dhdOgc2eBmWdiuJwX9IyOW+S7YV
	 LXoXk+OlTtvGn5EZVNKzztYh4hqqpd0NNkT4bjbiDOLKzARa46AZA18dyzv97IdjMZ
	 dNPxnlG9vTe2TNPAXkAzCzgQUvGsi48bnUWLKf3kWO7HlfmRFMqpYc613D9jJNRk7P
	 orDIaciIYbBGhxUopjneksZNAh1poZUSDEew+WroZ+q6cUWZ7AtPet7Nn4GEnt9yhF
	 gFTErq9dAbSrUFosMXPh+6Q8xmSieHiCPLFK/CRmBp0jM+RFdjlNABJqfwSMyIT4KZ
	 2uQ107QE9+PeA==
Date: Wed, 18 Feb 2026 12:01:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.10 00/24] 5.10.251-rc1 review
Message-ID: <8c2bf56a-6620-4b35-a5a7-e66039d9be91@sirena.org.uk>
References: <20260217200000.708219618@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V5kgY3GlfpRdVhOp"
Content-Disposition: inline
In-Reply-To: <20260217200000.708219618@linuxfoundation.org>
X-Cookie: They just buzzed and buzzed...buzzed.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217271-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94F74156324
X-Rspamd-Action: no action


--V5kgY3GlfpRdVhOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 17, 2026 at 09:31:13PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.251 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--V5kgY3GlfpRdVhOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmVqhsACgkQJNaLcl1U
h9Daqgf/SFUCvd/zFr1jvrqrkCrlCrEMShd8iHWcp5MivOPKA0XUSc6xF12GTt7Q
P+ZNKcrId0lXtnsy4iKRIG+Bhdw/7yzT772VeNXAAeDB1sgNBE6X6eOxClloOwNk
2QOkiiIh4GFgsB/AthUX32gSiVeBZtJP5zDPzAFENcR2ZFgh+BqLf4fAO1grW4F8
T28ttQClSc1A1NzFaSWYRbNnKbZHFRacgMWC18VYUK1yICzW1SqHCO+EGXgSgY/A
m5EGbDpLpUxtHkwT6KysgWqNqdu22qB+/8KZz5SpwipiZN57DjqIid5mQIvT74kV
uv3fnPyR3kcvHstDfYQFlIY3dzOxZg==
=PCmg
-----END PGP SIGNATURE-----

--V5kgY3GlfpRdVhOp--

