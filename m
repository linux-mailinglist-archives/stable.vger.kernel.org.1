Return-Path: <stable+bounces-215660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKwxGqwxi2kFRgAAu9opvQ
	(envelope-from <stable+bounces-215660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:25:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3811B303
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AE833010605
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615E328B61;
	Tue, 10 Feb 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsCqmWbn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D95207A32;
	Tue, 10 Feb 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729894; cv=none; b=jE3NbpTsiRd6609krqVJ7LpWv7QNq1HSJuF+ziJYfam7ZCUL4nM142YBnvgGg1nmr3OivyKU+BXGFB3CK7jf9tYF/Su3HmLtypIfmcM6O3UhHeLxgC3UAcoF5mxv4NxK4nYAqmlyiU4dG+VPwbgeRviW06pcDUABm4GEb8L4uXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729894; c=relaxed/simple;
	bh=0+Htddb+on7k/hP4fue552UhbwXmrCEeEUEKhtH5BNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjRdH2RYdIxGSlNUV6ehn05me3b06yNJg+41KzUCKoarbKdTxxDem/ZNnoS/NjV9kJNOw6tXfPQp7UUtkAE1QlrUs9urn92M+dAhBA3H5erki+XSO0Bq7svE7s473LxPLy5uKukIBkOZZ/+e7fGM/foVF3ze2XV3qqGTL5R27sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsCqmWbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D30C116C6;
	Tue, 10 Feb 2026 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770729894;
	bh=0+Htddb+on7k/hP4fue552UhbwXmrCEeEUEKhtH5BNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsCqmWbnQJ0T9LUucJ5KAYKzgunr549viHi73OEHXOkWjruSaPXgpZDja9rTxZEwY
	 CYllvYEQRU/pSFhwZpjoyGuYcZWv1N9xzOghgIpPiWed5HVtoAZyNQvJ6JSJCGR0k5
	 Q86WA5DrWWf8Gn8JCQ5VBjad5oP7FiSAvy/2cGML74nyhmgDz70vXjw6vlk0furPcb
	 6PDFy4aIrGkX8kPXTNE//f7455DwZ39iXUdbt08fkZpRCzv/uxtLO2UVuYXi1bRGXN
	 90tPRssVDs4iyf8pdd4r/pvpIefIXIDTN00Nurnj8fjlwakjOv9hFsy9H40ffTnp8X
	 xd2nAlV5gC3sQ==
Date: Tue, 10 Feb 2026 13:24:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.15 00/75] 5.15.200-rc1 review
Message-ID: <4ce99d33-da6d-4976-ab30-c429a07b7f3c@sirena.org.uk>
References: <20260209142301.830618238@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LOHyQZ7ReWa+sY/6"
Content-Disposition: inline
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
X-Cookie: Spelling is a lossed art.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215660-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: F0B3811B303
X-Rspamd-Action: no action


--LOHyQZ7ReWa+sY/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2026 at 03:23:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.200 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--LOHyQZ7ReWa+sY/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmLMZ8ACgkQJNaLcl1U
h9Dp4wf+NFD7M5KpH3p4Q4lNS7Gz3F/Zr1oXYQJbZCxlRLucYzp4yZ/nlLTVeUlN
xQ674CsglUL0ekXPJsDnYoS9y9KwmDRjGLVg70IcV5GV+7AEmLVmv+tpTOyzS+jp
6tjJSkUsgI9E4EVKvgIi0psZO2jwbSH/jIACFbwm2M4NKxHx392iDKIHWQWFabbU
4tMFgRsGBKsMr67ExZhD5akN6Z1uQcLUjT0g2yR58/j0vAQUEV4rNg2EHR9gnvO3
A4R1C58PEkpWLZLJ71lh5C1wq7mRz77YPCqh4u+uHGksiYZwKYNSaixMCdvDF4xi
q00g7wtm3CDkquxYsB9EHFMFLbod2w==
=yAPV
-----END PGP SIGNATURE-----

--LOHyQZ7ReWa+sY/6--

