Return-Path: <stable+bounces-253502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HemFCbfDmoVCwYAu9opvQ
	(envelope-from <stable+bounces-253502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:32:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD76F5A3584
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4FB7305E896
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275BB39F16D;
	Thu, 21 May 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfMsqReW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F937E30C;
	Thu, 21 May 2026 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359242; cv=none; b=Kc9uPb8+6PG/5JCKpVT+kXO2WWg5DwTN/b5yCcRC9JphKq3s2ho/xPZwhowx/wBHI9d/KjRsTKFfbaaeLR0qI3LdNUmZUB6EceVQ8Rd2/PW7ScRmgRIgkRiZtigI+35Ru7FAe1nfwaevTqqWTwPeCd9vZd1T8hMgCJB5arIOaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359242; c=relaxed/simple;
	bh=95yaYxzEN2qYl8YJG95q9eA42uG/fJUE5YhOqF6ToBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hei/Phw02cU8izfbRn8dknB7JSiRCC22aWIddTaVIroD26UBqyeYmUen50LwRc1KujfnQojKESNGxMxtfpuFuIzjrAeJehjCe2E1vySXjWUAcMttslgCPqZ1eIPexvSe2SMfsdup4NwhDHfyhO9OSYQEnup+sqe/kSvXetBUAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfMsqReW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A687C1F00A3C;
	Thu, 21 May 2026 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779359241;
	bh=5o4IK7UqbXpRXtOrKOQfU3sShLys4cYSKYVV0xA8om0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QfMsqReWBncn8DU7LlgLsnNUM8JPGZtrl145mT8bPZY7kq1944PQX+4rscRmYdrB4
	 noMsZISY/q+MJ596qA8IUos2AES/vWjKFcU7Fp6v0VzUhbi/nFDh1d0PyPP3O4DDVD
	 ylbfKPeQod434VV/Gxczv0z+scsT4jWMkka9iDYDmVmM904lU2eSqthMpbYgprJTlU
	 e8OgMx8VJcuS7vGIttn0GmtGymBa2NB7moe2/F8y3aBm/sqLYhvKNsvgPD1CNmHQ88
	 wg2egSNeGPkBH6L+degiwVFDrK+vvLSxdY/8MCqCxRoQnm+D6TerHHDDLBSAKBmU07
	 KJjSCbHpYROsg==
Date: Thu, 21 May 2026 11:27:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 0000/1146] 7.0.10-rc1 review
Message-ID: <0d2538cb-2039-404e-8f9c-cdebf34b74fd@sirena.org.uk>
References: <20260520162148.390695140@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t6uLpRJ74/S6+aAR"
Content-Disposition: inline
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
X-Cookie: No shirt, no shoes, no service.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253502-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Queue-Id: BD76F5A3584
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--t6uLpRJ74/S6+aAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2026 at 06:04:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.10 release.
> There are 1146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--t6uLpRJ74/S6+aAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoO3gIACgkQJNaLcl1U
h9D56Qf8DbnvVwnJFwA9E2acVEVZI5EeT9RxBRhckLPqNjc6XNJ3zjW+F0Kkp+ie
dWPnUqxD8FaLAj0t4208FVN19VPB1RqxT8I88erPo9FE0dc8fUCunsYcXC0YG6NT
sKAt/PCkpzONe8MUnJlm1vLqhHJuKyduMrcIQ3AYlwfnfr7iOPoBo+l1d4YHM8k5
Zr3McsFMQAyk+fEtRIDHdSuU0lFLT6g1eZ4UHdIYojxfF22L4MnKRlrBvYZUy83r
e1wtBnmbeMFKVuJ+ADOHtx6E2JY6sq/uq6gezWuYF/Mdi1W4il3oWQV6+XML22g7
60qljI+9g+3VPtZs3dt+4IqHWc6EaQ==
=jOkS
-----END PGP SIGNATURE-----

--t6uLpRJ74/S6+aAR--

