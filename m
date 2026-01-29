Return-Path: <stable+bounces-212805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHUXLdede2nOGAIAu9opvQ
	(envelope-from <stable+bounces-212805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:50:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CF9B3374
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF4823005AA5
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A736C3559E2;
	Thu, 29 Jan 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7vmUR3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB563542C0;
	Thu, 29 Jan 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709013; cv=none; b=kDIBcuZafTPibq1ravJVC9ZgvCbMWHNTUs5uGt0b3YqoqGpNJgDJqSpWAgEUWjZbaiwUHEgfED0iTmnas4U03Cjr/n1UCUFwEayKxT4AV/6exBVsCseEWvqT8cgMHBqU5wLBjbNqMPqhtUujgTjRoDissb0X38CIknoiyNJK01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709013; c=relaxed/simple;
	bh=TcDfY0IaV5J+JVMxRWachBLlsRtCsIdWTSjRoR8piws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo/bdcvebiR8hS2IJeNpudp5AE187BPywLTB81pkc1X4NXJvRwAA9jQAdPxnRked6In5UzQS+rI7uG+ZwV7at+6hglubxvV7Y6BbrKRuNG/zToX3nWex6wUGCJX7XIFTW5el9E97Pl0fFlum7/laoo0VogGgrhSYlwgBzrK+6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7vmUR3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78439C4CEF7;
	Thu, 29 Jan 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769709013;
	bh=TcDfY0IaV5J+JVMxRWachBLlsRtCsIdWTSjRoR8piws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7vmUR3nj4JRhmu71VEt5VPYUJjNc9yJcEvZmVuVgVJd8T9S0HOH8NSKfBQGszzQ+
	 RVURIXtaybxfeC3/2pgpvdrz+sjMYsUGJLm2RqJl70bU8E9qM2LaToUYnz6dLsxoGp
	 gI8DVf8YNw67EV4tBk4ch4t58fYMk7aOxpteSNKwR2897bz5FHknFW1o8hL8krCz1T
	 aBgntK2vp3wOhAcGbB1pB1/9vT5wzOWYY9Up5SuwQsDw5szQtAToQNthXpA5JhbkGm
	 RjEexawCNyA6R2SPJ55kTen7tvEWyiqYNBbSO2xLQh3ggwYwIEH6cEfkAAEjtdUTX2
	 I6nf2ti350hFg==
Date: Thu, 29 Jan 2026 17:50:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/254] 6.6.122-rc1 review
Message-ID: <956ff656-51b5-4ff4-9dc5-3b20c71f2984@sirena.org.uk>
References: <20260128145344.698118637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EMV2XZYJMgHz38Eo"
Content-Disposition: inline
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
X-Cookie: You have taken yourself too seriously.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212805-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52CF9B3374
X-Rspamd-Action: no action


--EMV2XZYJMgHz38Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2026 at 04:19:36PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.122 release.
> There are 254 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--EMV2XZYJMgHz38Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAml7nc0ACgkQJNaLcl1U
h9Clswf3SZTxLEcVLdy0FzrNuVXmDoL6wWRe9TJ9PuP3K6GuuG7xh2t5u9X2b31L
qx4+RS5tdfdYpyRMBvR9Py8ayKxIXC13IX4HIMCnOS6/xDcZ5j8SSEk6h47HGexz
2H5zULKcdqWdaun26RgwZZEgS5scOBZ9ht1LUGKgjVQmQSSLvXdHIcjt7X3VuEC0
vtwSe3LssrqFIyn/nmHouOALmruL2jjRxtCtZnI7z/zT/q6PjPS3D5/WTSZIBd4a
bslpkkYkR/yBeZkU84jd7fakJzPFgc9GhWAP2l5aDLPVnhKmkpriNHzBp0eCXPM0
UtvnFPb7eiqSm1Tv0nwh1OWZ7ruV
=eR3k
-----END PGP SIGNATURE-----

--EMV2XZYJMgHz38Eo--

