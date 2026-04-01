Return-Path: <stable+bounces-232837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO7aARZbzWkRcQYAu9opvQ
	(envelope-from <stable+bounces-232837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:51:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1E37ED66
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7524D301EB50
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77294657FA;
	Wed,  1 Apr 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4KnkhNP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67C35E92B;
	Wed,  1 Apr 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065182; cv=none; b=eO4P5ID2J3N+L8QpQottT/4F7r2FGOkhdmdZzflfs/uySM2OiDC4L44CFdDmJW6thN2hE88SneleePOU1OxsvscnfNc6XrjybqW34egXNdmGkhUEsDAhjBtLjng+Z+JGuFz+aasEx+GIEcCsGsTj0ZyVjJ2SYvUdkdcaPnXBS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065182; c=relaxed/simple;
	bh=hQ+vnC7PVgmPpxCJDWhjQgO2Dv+XHSTS8KXUr4R5dpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sszUcHogXWX1YHOLcJ0etvLhe0j9oagxJN/PvBAIMVN18IgyVt/ZvvaYffL+5UCf5QMktiZarQ00jHlsmUJuyPsp6TVFXDHCjTrstHwXB983PRy03ehp+aRGbnX6N8sxGWaXMaXRR1uqImJg6ltWSSyOFJpaBRnf2RgHAvAmTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4KnkhNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784CEC4CEF7;
	Wed,  1 Apr 2026 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775065182;
	bh=hQ+vnC7PVgmPpxCJDWhjQgO2Dv+XHSTS8KXUr4R5dpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4KnkhNPJA7ZP7y5LAy2W4eDmbT2M3BdykXOOw7vEuG/E0cWWBfJy8nnFY1ajIeAb
	 CFcBTOHKecag3E2E5dml0jrqQRKwZZZKvlSBT38/hKEsBw1++yIaNCpvtNVRn65BgB
	 dptUXlD8iHJFjxGAP5kh/x7ChJEfnEdOJ0+UmJhHgCsQPORMktl3i7eIgNVAQZlLy6
	 NdbUNFZ0I2unr0FXDircmqqyeU1/ds0t91hYt+pKiYPNHetHEjj93abQP+FUaxpCPp
	 0Pn96D0/O62+1kjCZE0M3rCszbYERng3PGt7gw1OSMNZPNWVz2eG0gBXRFRCTHFK0h
	 ZFJHab1uGMplQ==
Date: Wed, 1 Apr 2026 18:39:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/244] 6.12.80-rc1 review
Message-ID: <550477df-0be7-439b-ba9b-61d3e18f7d8a@sirena.org.uk>
References: <20260331161741.651718120@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdb2LJeGpWScc9cE"
Content-Disposition: inline
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
X-Cookie: "Yo baby yo baby yo."
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232837-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 1AA1E37ED66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--qdb2LJeGpWScc9cE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2026 at 06:19:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.80 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--qdb2LJeGpWScc9cE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnNWFcACgkQJNaLcl1U
h9CEXgf/Yg0WkgewR2mwrchWTbilV6GAnKycKJx4Yxv5qU5wVEULRQkdgqsXyU9J
v5UXU3+Hl3X5i9EVWVOMrfvUogmCaK9R5O8/o8bJ20YExUXGhzS/2T+WcTCY/EdV
ERmr2tovKW3tuDuKuNQ+E1riCOwnxy1Uoiv93QJf5czKGWU9TGB0ePhzh5O2+7HP
iiXcgL7Fa9vcq3vwd3vMh7D2ydkbKrXNr0YlRjlxViakcdX6tP1WhSgYti3FIxun
0nNFZ+O3yaguNHt24M0UEI4hpA1Wcvc0yG3l406hvsNh0phlFrY7SReCWaD8Xq7X
f836JfA1xBwwC9kcX2s0nkZT1g4KaA==
=IaXX
-----END PGP SIGNATURE-----

--qdb2LJeGpWScc9cE--

