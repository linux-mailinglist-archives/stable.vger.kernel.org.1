Return-Path: <stable+bounces-214558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIeBAXkHhWlW7gMAu9opvQ
	(envelope-from <stable+bounces-214558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:11:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEFFF77DB
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC4F4302B51B
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6D32F774;
	Thu,  5 Feb 2026 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK6hZ0Fg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52631F5858;
	Thu,  5 Feb 2026 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325851; cv=none; b=NCMz/B03MlwpInChUYZDidWbn9FJuDFBQFUjGAJJyw1LgU1sx6vDrFguaAjS9vK0kbFq1bpnX6ryr9Fyh0YGEdIYXJdgMjy51LoUSqTE2pUoeU2n2Vp/leO3vnJ0DY3aH+NKuwzF5LdBoII0MN0cbm614njKNqLgRiKyQI2DrrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325851; c=relaxed/simple;
	bh=kXKcH4bahJQnZUWNPZhTdL6lmJpocQcNevxEV52GB4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op6EYuiwvRLcHWthpmxS+0KB1OpGYA1vizJNjZLWIhXyCl0Yk3qOgLanhWfJD2sU6PpLasieAxOVS15bYKCOwdoKXN8MZgEXvktw4ODl0Ma70oKh6qsNmwxhgqruJBZM2DS3hQyVj8xsuFE2tAFR3WccnYvVfVAUFNru+2PPi9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK6hZ0Fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FC2C4CEF7;
	Thu,  5 Feb 2026 21:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770325851;
	bh=kXKcH4bahJQnZUWNPZhTdL6lmJpocQcNevxEV52GB4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK6hZ0FgO/5gsreJGtXCJhFQI7GJYzvp4tYkCPLae2N8hFYX05lKfZyeqNGBuqY64
	 JoD7j8E1O2XznltcimaW1OoRioJtXodHU2Hf06jQtXIOaX2BddUsuDJNAYu5KJ1fdX
	 RO1DHvfr45/Zz9Cb1NKnZ3KS2Gd/x60T4JBOg7LT+dI7qOd5t5BwyTFPxFaGKc0Mko
	 wRkDkNjTPlKhYFvhE0+4BtgShxvIAdW8IibhyfrQvSoVkqlUOJyIfIksMbRJWZtKt0
	 orWAJIg+vZlFktDREqlUc5ljd4XztlI03fHpV56/O4o2RPJccHFYh3+tJ67VLujSmI
	 YslmaP94CAjLg==
Date: Thu, 5 Feb 2026 21:10:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.15 000/203] 5.15.199-rc2 review
Message-ID: <6b31b42d-c843-46cc-845f-5d3b97264aa7@sirena.org.uk>
References: <20260205143441.536029503@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DotIeRmvr7hia8p8"
Content-Disposition: inline
In-Reply-To: <20260205143441.536029503@linuxfoundation.org>
X-Cookie: Non-sequiturs make me eat lampshades.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214558-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 9CEFFF77DB
X-Rspamd-Action: no action


--DotIeRmvr7hia8p8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2026 at 03:44:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.199 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--DotIeRmvr7hia8p8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmFB1QACgkQJNaLcl1U
h9BokQf9F2Ra4xv3JjbvkKmS86WnapWQ0GFN4qoXqPgTM09uejdmWgVnrUw/bKPr
obm+qjdUuBMTMQtJS3jucEX0xzN/Ce87oGeRETAPSnQa9R4EEr9avwP4JoN9StAy
Xiuvr1p4ooL47BiGN3s8hbjJyxj3aVtogqv0XAzUQrlPiRfbBHaBfeT1Z+EjgPdM
4Qb0n3/s4ni2dxAfesQ7XDWX8LKzMSB0GKh4N2MlwoWJp8Q/cWCK9BVahnnuBT6v
ntv7Qq3WTguRkKCXAqfP7+lRxozlKggj4EJduDK+iTay4LdZpNmwT/c1KGdQhimB
/hA40o1ATVXmlGszvdZellT5KVfK3Q==
=p95k
-----END PGP SIGNATURE-----

--DotIeRmvr7hia8p8--

