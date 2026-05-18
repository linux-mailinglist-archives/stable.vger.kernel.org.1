Return-Path: <stable+bounces-249209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BMMHmvDCmoI7gQAu9opvQ
	(envelope-from <stable+bounces-249209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:44:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8A5568070
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1E29300E14E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF33B52E2;
	Mon, 18 May 2026 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU1kM3Ug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DD2EBB9E;
	Mon, 18 May 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089870; cv=none; b=djBk+GRTH4WXfcSKuDui+/xTUGh86kDxlPqXUGLMuR0aKd3g+b8N+whOw/BIEfduiWk488cDkOOrUjoO/ONj4A7dm6mZTYVS7OxPQMsDHXY7xNW+V1GZN5ip8FIbCEpj5aljkHV7L+AEaXZmPTtedaTJT5yQd6BLyBdO7gl4ZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089870; c=relaxed/simple;
	bh=7kqhO4Pu44sVWjxvRxm+t9ukq2zL3816xcgPAE7R2E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmPNxies0uhtkIQEk+ElhmbwWl1OhXOz4PuLjp5HSLl+oEuaNyOfaxWH5PcYos6XxX6UjSTIdl1D/xSoj8sgV7s8z2mkE7vY/fD132MnEtk/ugXnK9H1i5KL0oW1L4NVe3ixlJSpgzYnDolAViNvrFVLm/9qpioKLHzDO+LZcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU1kM3Ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E7CC2BCB7;
	Mon, 18 May 2026 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779089869;
	bh=7kqhO4Pu44sVWjxvRxm+t9ukq2zL3816xcgPAE7R2E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jU1kM3UgZqNrsFcaRuAgVMVQmVNGAznHUv4nFiD6DY5wqQYoFRTnP1Z0+FuVxihmO
	 OWJsJIl3b9jdIR61AvYv9h2d1uCJ43uzz4XTnSi6kk+DiEM3kSmIzjTNBykF87Tx74
	 2zSRQaOgTgJaM1y/ZhViBdhlCrNToey1KJ3w2iu/IOK7GyQ0L3qU6/pmCLpXIhghir
	 IDFHuLQ/1hKuteFNa2tR2dvUdVQdVtJTzITtexUj9MJaT5cfH4dngkbThMdUoF1Rlf
	 OPtmCPrFALPHZ63x0ckpwU9fdiEbixS0UXq6k/1cIm67Tsh5LRndtORikf/v7wbmmx
	 FcH4l6uF7jQAg==
Date: Mon, 18 May 2026 08:37:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/201] 7.0.9-rc1 review
Message-ID: <403bd472-1e0d-4189-819b-76e6b6635392@sirena.org.uk>
References: <20260515154658.538039039@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bQFFMTZVOn4os8l5"
Content-Disposition: inline
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
X-Cookie: She sells cshs by the cshore.
X-Rspamd-Queue-Id: 3A8A5568070
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
	TAGGED_FROM(0.00)[bounces-249209-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Action: no action


--bQFFMTZVOn4os8l5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2026 at 05:46:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.9 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--bQFFMTZVOn4os8l5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoKwcYACgkQJNaLcl1U
h9BS4gf4wFrz8vM2+lKaOWzYc86tEC2I5yKzoVvjPXHObxQE5RIx8AjMT1lCF7nn
MlpkhsfwSAtzgk/HcpPhsrharAOgxQEkMnJbgW4nihty5EC56D5PzvFSusZ/Vx3i
Sz60qgmAdaS58GLhEomwKpb4ATP9w2PAN3cAAJpQSmwQuufllAMpTYuo3Iv8UHt+
cPq7Egb19SZTlZ3TzK5Pf2QZECFO1JUu/j1SdEeQo9RYwYkZH9zBOg0jQ4VcA7vK
a/kpwrabhZQMYeRwXQ3e75NmP7ap76Y+BF5c8+JIZyJ70T3MRRxSu+QKXXQdj7vi
JZh+D7RpFmVek7QpXw148cBtNif1
=sZyB
-----END PGP SIGNATURE-----

--bQFFMTZVOn4os8l5--

