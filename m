Return-Path: <stable+bounces-232834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EbRDSpazWkRcQYAu9opvQ
	(envelope-from <stable+bounces-232834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:47:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058A37ECA9
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57AE83053253
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EFE47DD6F;
	Wed,  1 Apr 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZz4uJNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A447A0C7;
	Wed,  1 Apr 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064936; cv=none; b=DX9y5cXgn5wIsfx9EANlw1dWUM+90pCOjf+nDBye7bEH3Q5UyWbk0tS2wB9pCeNA9UlJhpq5TO4iPcBCbDoWCSmZsssaWG/fdGFeKxoa7tAaz3cg2jkgevITE/aoGyBkIfEBQ/XDDeFWQFwg/xyfQzJyU6cMoMf4QuaMLhGWzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064936; c=relaxed/simple;
	bh=eJ0x/yjGUFs7SoiSaugbZkLoeTbJO8LEMk2Xkxi8hdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz+HzLfIAOOpk9QVM0HqE6qW3BP+edd7QgYcI63zx74hI84TQhzCMLj9T/csbrYELKgAO+vMHYgAE9UL4SmmARarBuwytym9z86B7QQWqTGhotUddaPkX+1tEOdmi1yz1uG7Y7aiOeqY6oKhgCgo9Q7ISOh4gkV9xnuL6Xe/3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZz4uJNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BF1C4CEF7;
	Wed,  1 Apr 2026 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775064935;
	bh=eJ0x/yjGUFs7SoiSaugbZkLoeTbJO8LEMk2Xkxi8hdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZz4uJNMDNhMRo8yw5LEpM25knw7AFALb7kkhgU6cYiO8dT7u0Vq8d/byCB12UGfg
	 Lcud9YNXRz/Eanjo0wGZf32NXuNUMQja8G0h/kownOnbgmHMWaT5nEQIPvdjcNML9j
	 m6yc8Opz/Ivor1KPXiq0tyoypiv1qDJu9CRAfe4CAdXNdxzaifW/7v76FTDFBxzzp0
	 fxpvc5Cn9NmaCORVK4VLrg79bE/NX0rUSVjajgBEV5LJl2oDnYtkEi92xBVst+Ephn
	 LpwLM05mRpW/yl3J/1pJVFRJK7knsJV3nPicnDgD+dHiRLUlaKCpRlT2LI6wjCCSL8
	 xeWDq8a4ZiohA==
Date: Wed, 1 Apr 2026 18:35:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
Message-ID: <6270c719-4cc8-4cd7-8ee7-63998164c602@sirena.org.uk>
References: <20260331161758.909578033@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w92HDxmjcDofvops"
Content-Disposition: inline
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
X-Cookie: "Yo baby yo baby yo."
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232834-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 4058A37ECA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--w92HDxmjcDofvops
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2026 at 06:17:13PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--w92HDxmjcDofvops
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnNV2AACgkQJNaLcl1U
h9BeYAf+KVG0thO4fzoC/z45RQiHsnj0roqNYCqyRaxUT1EVSwob4ZNqzuowzfpI
GUOQFoYuwjhbhZvxhVQmuwuN8c+qWxobbHofgYp1gZOuil51gHbrlmiBffim922a
RuZCLXAxYOho20uAvlf18r6xLrifvo3G9N+DEzW+Yc+bOXK4aSpiml72acU1Rp7A
JmLrfxRRPLiH02xb+QnEbzWw2QuUy92K6dM0FODLgZX21Hfc9HinhitMP2dx1Ldm
82TrbLcohPCpJROV9xWcNFb18ZP2jhwMoMSN0UlvS1HXcY0M0Jn4j1tk0ZwkKOg2
MHmwLdNEwtzbeRC0kBxOkj9cZi0B8g==
=Nxtw
-----END PGP SIGNATURE-----

--w92HDxmjcDofvops--

