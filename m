Return-Path: <stable+bounces-238089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKEfIeBk32mKSQAAu9opvQ
	(envelope-from <stable+bounces-238089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:13:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F94032E6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A3713026B3C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750A3358A7;
	Wed, 15 Apr 2026 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCQc9NI8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBB345729;
	Wed, 15 Apr 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248025; cv=none; b=YvxicIQOEQ1DD84BLxqGxBzp388awbGWVGBqxJn4yly1ekfwsG4FuBYqz5deWZXgtAYhLm62mBq+4Jh0SojbCirY3oF7vJTtwCxR/bL3bA4T0UH2yxd/EKXePSjSJMLdGOe64fqRONoc0nSduaYZxTVZTTdQKQYz7mbclvxLj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248025; c=relaxed/simple;
	bh=sr6kH3kZgnzmCr+f3dG2PnGoKlW749JGYF4JtYtlq9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFEV+TSVt1VZ84iWWMXW+vHR7reK2s7ZOnibkYpAOJhss/XubOWs4mIexJ0CzAF40olFWdllQgI5c+Exh8+XiXoJbNIKTktdnTLu9t+ZLRoD7fXs4MjvaFSdyMULCDUHm6WGu8TeMlxsa8xGqRkHVSmB+kFnZGdRSgGNgLkddQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCQc9NI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD27C19424;
	Wed, 15 Apr 2026 10:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776248025;
	bh=sr6kH3kZgnzmCr+f3dG2PnGoKlW749JGYF4JtYtlq9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCQc9NI8crbBtqUQOaqXbPOtfhpXc13RWn99gaHAbf7l/f7r7gbMmwsmFmG7R2yqI
	 DisiY/JjfN79nWBWQRhWvX5tnYY4H9FSxbzFSX9beL93lmw3jgX+QrxIySgWotKFxb
	 ItJssMjaiy+Rs4WjBuVW+CTC/sjI1NZo7eSihltdic5YVb4MW+tUvlQQs6WIjCTv9M
	 Iq51LEHFXzBfC7uOUoqiwBzRfCmdJK1amGim/vJaOY40DYSE2ku1E/iTC7GOvsLCse
	 g3FGOmqtDHBQ86BWxIl7zwvSO4mVER69z0j9nb8KgsF/J/38dEyec/RAcu3k0ytXt0
	 0tls9bRmDuhzA==
Date: Wed, 15 Apr 2026 11:13:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
Message-ID: <226c0779-63f7-477e-a158-8bef0763ddf1@sirena.org.uk>
References: <20260413155728.181580293@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YJbJLoJ9xqhBdRz+"
Content-Disposition: inline
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
X-Cookie: Non-sequiturs make me eat lampshades.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238089-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 1E0F94032E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--YJbJLoJ9xqhBdRz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 05:59:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--YJbJLoJ9xqhBdRz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnfZNIACgkQJNaLcl1U
h9DlJwf/dR1o5yBjf+8MkfjT+Oq/hWEGxzNs3kUVlj/uvDRarkgrwF5J3C7GQj/3
OZo8FZvQYbM0vLc240ycxyw3WaqM5/OXnvWCTGKkq9asLToOBhQHGzxsphunkYDD
L24dcC3lsFhXTOC1ih0B8XRlwyZrrOKjC/DJPyXF0cz+T1RpI7xE0O6EhRuYx1vX
8b6LbC5qSqbN6WAGg4WTr0Xh+UQDRm2E6Ect2Oj6+9a9Hx5L5x4sYDDgjPwtqtq3
iYwVfOVRob2w9mYPhiM7qwxblmWF/5ClhTfR7l3QgOfqAOi+5SK8Cvn7OvQhzuKP
v37AHFCx8UtgKvVANrpN/KQB50P5rg==
=NOJn
-----END PGP SIGNATURE-----

--YJbJLoJ9xqhBdRz+--

