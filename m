Return-Path: <stable+bounces-244122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO5hN73d+WlPEwMAu9opvQ
	(envelope-from <stable+bounces-244122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:08:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5704CD3B0
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3A703004078
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B741B41B366;
	Tue,  5 May 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT6oL5tj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F3359A91;
	Tue,  5 May 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982902; cv=none; b=kw5Z3HTloDzAjjann8IoKOq4V80qwQgcg2OW5vjiNDhEz46/4htytaTiO5yOuoqH6wOIsBM2d4whpNySzZofXyuAktvz4eYxTco1XEOAcEL+tb9TGu+7amvnG3sWFAMEht4D2azHlvgRqQuKR+ArOQvgjYnf8lCeHujlLaC4GDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982902; c=relaxed/simple;
	bh=hJpbio2BGay5/lozyLXXheiKHnWdisBgdjDFk7WvqT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KivZGeKJ95iGEuZczomSm58a1egPBS8Rt6451gaOR8ldc3XiSmp9WONktaoVeAAg2xnTnxSqH4TTH/mPwGqHBFWyHRHkSg7+Bj6PCIVgAzexZMiLq6teqe75wrR3nzFrC+bsSkZha69wsl3rC25pFly/fHFp7ZQ0iw6s+TFiJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT6oL5tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE460C2BCB4;
	Tue,  5 May 2026 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777982902;
	bh=hJpbio2BGay5/lozyLXXheiKHnWdisBgdjDFk7WvqT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nT6oL5tjEZAUij3NqNxthSVzuf8X45gLm0bLaJ9OY0WJYF+ioBcxvJVNb2AkfYKVV
	 MkvXKga6U/blRI+pRgNBJUNvSaE9pubaRuzo3f2ympZlzcrX51WE5ny+BdOtZV307u
	 QcuPPoFII5VPM0DQUrPIjpeoy7qn5rvQjPceKH8MaFL2AfEOSk3dLm5dzwLVZWK1dV
	 wPachB219/sY/dnpki2JU2GPGPp2KSkMLMalNFP6JsGNKYhvr7D/2bhM5yMUGFfmP7
	 8hi85Rs0Xff2PDeOuawmmTUBB7kP69NKkE0ckVq6Y/qxybXnDCwM55T7e3sl0aKpVH
	 uB49D4cZAqYCg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id CC6AD1AC5871; Tue, 05 May 2026 13:08:18 +0100 (BST)
Date: Tue, 5 May 2026 21:08:18 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/275] 6.18.27-rc1 review
Message-ID: <afndstwca9pMPhnX@sirena.co.uk>
References: <20260504135142.929052779@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sbFfvD3S7eKZshjt"
Content-Disposition: inline
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
X-Cookie: Alex Haley was adopted!
X-Rspamd-Queue-Id: DE5704CD3B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244122-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.co.uk:mid]


--sbFfvD3S7eKZshjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2026 at 03:49:00PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.27 release.
> There are 275 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--sbFfvD3S7eKZshjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn53bEACgkQJNaLcl1U
h9CjPwgAgnOTfoo0H4+xsuOEF77U14jmnfah+FHnDacv7y1VXbLIgj8HJlgso+xE
t/Qypdn2sWjhQ4dHNq+5h0liimZ200CjAma6JiAjnaZpGuJdOpz4vIXNLE12i4z3
GIIlDwyfGtXx49drmGIO74riUUifNHkmrnhV+nO8AzPGrC+4a8MiET6VZj685Vi1
EGDpnms8//cVp2NrZI61NYniyEuEpyDiuIydJVj7aBYSjWy+Z/zymWd6M88bMfln
Y6aEOytK1p7vstlbR8urkCRiH3Y//+B+zxZM1WT/+WYVOjZ9QApD5Ka7aqZiQk53
3ofUnAmo7s1fvBlXEFxqwY4NULDIHw==
=BMBj
-----END PGP SIGNATURE-----

--sbFfvD3S7eKZshjt--

