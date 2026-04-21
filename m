Return-Path: <stable+bounces-240233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPDIHcHZ52kBBwIAu9opvQ
	(envelope-from <stable+bounces-240233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:10:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FD943F4DE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE61301D693
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC023DD509;
	Tue, 21 Apr 2026 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zue+wSUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE2A374E7A;
	Tue, 21 Apr 2026 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801888; cv=none; b=JdLQfwONlNVPkwredbQmsUXxJPX9GPIIMC/vYQkUQUbcE2cudcObPztaxjYwkIa6coCs0p/jU9xQ/gJXm841F3YA0bJMJM7kOgrMohVY5QhxzkOxiGO8DB5WfDBnavFyaO2OIGlZKIqV5Lf0RYhnq02SQfYFZHLJDqbzjrrPUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801888; c=relaxed/simple;
	bh=WybtY0lMzqcCEbRto++JM6GkPDutZ76eh+c7Eurl0Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUnk6WxwRDmIEPrKD/6phqqyDKyTCEBn2bQYf2JOnJG6oMdOfX0DidHTh7KVMNn+syQRdi0MKF/GeFBUTQ7e6xd+Qot7fK6hwiJAgGmiV3aBet3YmlGprEuCr7pQYBbmKMLItbZs3R/KiXpqmJ2QTguAncOg88tp4DtRwdTfmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zue+wSUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42246C2BCB0;
	Tue, 21 Apr 2026 20:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776801888;
	bh=WybtY0lMzqcCEbRto++JM6GkPDutZ76eh+c7Eurl0Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zue+wSUSTuF/0CUel5mRMOUVaJAKnbWSgbFYbRJjRK0k7fx4iHJK7p3LkLvbIJGL9
	 tRTMmoU+yD0Q4TOiD5SvRSByD1VF/hapHwliduk8g9h+KPDWjptZrtpRgrp/Ha3Jf5
	 s8oDrGjQLcAOEiynplJARmyzExpQJ9VzjSgs0IRFXeiUldXLKcmyXypD70821FMAct
	 v1s/VRcdqEzuEhD0jgaLv2oZn3oQGx3R4nwkao7FDNP85KoEP4fLsIxlM/MOndg2xA
	 AX7AtPQGWA4kClLwaZAmz41aMBy5dk711/JCanBbbHdYupoCN9enkKwVdL9RyBhXef
	 g4kYzLJmkR19g==
Date: Tue, 21 Apr 2026 21:04:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 00/76] 7.0.1-rc1 review
Message-ID: <7dc1dbe7-a030-4d5b-8c9a-e32d8fb1bff0@sirena.org.uk>
References: <20260420153910.810034134@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozitZSXaFsarPyAx"
Content-Disposition: inline
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
X-Cookie: Jenkinson's Law:
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240233-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: D1FD943F4DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ozitZSXaFsarPyAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2026 at 05:41:11PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.1 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--ozitZSXaFsarPyAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnn2FgACgkQJNaLcl1U
h9AhDwf/RKJavycvuzoK7ERmzKaBXhoKRBeB6xObNMhTcZjCIbTSQNLRxkrnrDGd
8Gsm5nuFScHxLEYGOHMCROVZsOVtRzUhHHXmCbGeqmDlmoxqh4UWh9dGuApwdyIl
2b0n9EIyAOrhGCQqzqm20Q3TPEqmuVggXmhCstLv3hkgiC8pqdRCZyrrwfHKsi2J
eDTkJFummK7TyU7/RBKeWEgWjYemtZXF1WDlfhzifU4gaMq050aDMmI+ENcgAKzr
srRxTLetcMuQvjBMT+EqEnBfT+L0zRREmO0MKYJnfHwCWcRa17P/WcSKR49we8j8
t4NEjX4W9hZd+DsQ5LnYk8tK57BLPA==
=WcpM
-----END PGP SIGNATURE-----

--ozitZSXaFsarPyAx--

