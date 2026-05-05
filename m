Return-Path: <stable+bounces-244117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHJ+Cprb+WkmEwMAu9opvQ
	(envelope-from <stable+bounces-244117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:59:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6554CD1F8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEA25300B75E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433139A803;
	Tue,  5 May 2026 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VATPlcyK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659237CD5E;
	Tue,  5 May 2026 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982340; cv=none; b=PSJW2YMG4OIsV5NhaWli5fHF2zbKn0AkCgj84mN5w8HeJC285+3KHzT3EplYACjBedu5+QakM1g9Naga7DfAFwjJ2bcmHxNrMMhqoE3fDC3fX5Dr+ExS/1HTUgOXwaXGyiAX7EE1RwtyXUmPqc0FRu7jjFU0oFfTb+vFCKXi3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982340; c=relaxed/simple;
	bh=TjfTnidfflrxMf3b6EDtfmJYplXxIam76T/lXVeSZ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6jfAKrvhE6NLDk6VPGtn90xQ7K4FnA/XKFT+RVMMAUH82HJkX8ore75h8lKpBdevOKQQHwgw/zlkou+oI7zlJ+yoFz5ou5NJbeB675X0D6KqzpYbrKGug0dnd1ecbk0lbODZCqKG3S77fgN+6U9Nr7Ze8lE1kkanFtC0MdxrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VATPlcyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25506C2BCB4;
	Tue,  5 May 2026 11:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777982340;
	bh=TjfTnidfflrxMf3b6EDtfmJYplXxIam76T/lXVeSZ4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VATPlcyKanjQg4Ws8pge+ie7G6uEc+P61Ot9CPfOilIROk78F6+txIwnsQ1LcMTeW
	 yGQ5RXYMrexhy2ZrFylfznazOvZNdoFR+7e9HW1aqLQRMja+8lbNhcaO9YQCA3gpKN
	 FcV4j2AS6X0yuROI/5oPgbf6dlVGZEEUCvB6jxRVJj2Jp+SdcH6wDeJkMYGY9E+RPS
	 cp9eJHODcxz9rm0xQUPtmUDlohUsUGnH/R8GckbN7M2JCtap6xnFcC5OByeoeacYDr
	 jMWG3f3stCPahBSYu2xcq4avZJ8B7hN3MDM4Es099dndaB7kGL+HzSX4VU9fNXQye8
	 xmoIyQVRhpKAQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 86F0E1AC5871; Tue, 05 May 2026 12:58:57 +0100 (BST)
Date: Tue, 5 May 2026 20:58:57 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
Message-ID: <afnbgXNTLSkVcRq-@sirena.co.uk>
References: <20260504135142.814938198@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oxxqey9RoXKa+PnH"
Content-Disposition: inline
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
X-Cookie: Alex Haley was adopted!
X-Rspamd-Queue-Id: 8F6554CD1F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244117-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sirena.co.uk:mid]


--Oxxqey9RoXKa+PnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2026 at 03:48:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.4 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--Oxxqey9RoXKa+PnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn524AACgkQJNaLcl1U
h9AwWgf+OiT1CCRJcCI4BA5dAYeU1MJiBa5R7FnEdcLm9dbCvNHhcRWJyxtNor/s
gmSN0zKt9PAtXhT8HHTiUXvKDfO7J1u6B5OP2G7Lue7bG5vWBwhy1G4FPIgdYjJh
PpNU7bj8gaDmXpjO1BH8VACS0GqvHApLsHjQgMPAr1Oh0dRMH76UHTvdGjdrclc4
aTQVpjtPw2TVV3mwntzG7YE9H5zWdQ9xhlsm6VhHXyx9PRSyno2CrT7sSLkDOeKd
B0V85BgB85D9A9vkjsl6snTAGlRJa+LUWo/KmRivhjOvUSGh/jeixz1pa4+dffBG
KXUPdivX7IwRrQyBt6UooJirnf19Qw==
=IH3L
-----END PGP SIGNATURE-----

--Oxxqey9RoXKa+PnH--

