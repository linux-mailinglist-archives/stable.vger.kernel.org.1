Return-Path: <stable+bounces-214447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPKGIZGDhGl/3AMAu9opvQ
	(envelope-from <stable+bounces-214447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 12:48:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FAF20C9
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 12:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EEB6303C03F
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E03ACEF1;
	Thu,  5 Feb 2026 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIQz61a+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CADB3A7F41;
	Thu,  5 Feb 2026 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292033; cv=none; b=K1i0GP8BDqGyVQ2aMGqrueoywC4Mn6oHZdeLNFlD6FF6OBtx+tAWmVbndzLny//8HnN3kWys7Za1VkE/ECnkUwdyLHwcQceRffdbdSAzbKib4439Vx2FI66sszqjg6fgWTj5/0DQHBU1+OFOgbVvvSdhX7x+8VeAwUtB+8WklGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292033; c=relaxed/simple;
	bh=hs8kLSGS3PwA6/jnjtWyjHzz4nIfmL8O9/NjihE8PIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoldeAl1goamttgOfuH5r1VuveFJDZvY2t2CMzWkqh2MH71wS/5LfLj34bWG/+kt1weVUGNcvN9xm2VNaOSJNmDrWvvrId8Yryr9UsvAhoSDT1uUfMikUxzqEVzQePhaDU0WqeAFCUJ9kKhokNoQuvZKOBUoXIGkIuQWNkD29RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIQz61a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD50C4CEF7;
	Thu,  5 Feb 2026 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770292032;
	bh=hs8kLSGS3PwA6/jnjtWyjHzz4nIfmL8O9/NjihE8PIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BIQz61a+VVmJEJoArs5tro3MAhjVNs9oDTYyCpLCQElgbdV66PqCtswFafVmmLE/j
	 XdHFJJm5QB6FV+SkkonUXHRkeexaVTwrxn03/9XgSfDiLr2He29gQqZx1oc6WHpMSd
	 61Sm3STFALsTPga0pzPDaMHNx/flMf9dRDr9/97ZfSRDKeJjNnvPmSt6rY2aacmecg
	 GDZOMpuS/J3ZQd/X96YA96UwpNgwOWQJGOIkUGIa+MjpRCsQqzvCKnHKSEQioMBf0v
	 pJYzxpgeALcxcdJItrIgfRIA82yIo+YdFW868j4qmfkB2A6TMtWL/KAxhM6c6RglZK
	 QyyM4xs4czoUA==
Date: Thu, 5 Feb 2026 11:47:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
Message-ID: <113faaa7-91ae-4903-a3a7-2e93176f68b8@sirena.org.uk>
References: <20260204143851.857060534@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E1ofbk94bSHCjB4t"
Content-Disposition: inline
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
X-Cookie: Non-sequiturs make me eat lampshades.
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-214447-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
X-Rspamd-Queue-Id: D74FAF20C9
X-Rspamd-Action: no action


--E1ofbk94bSHCjB4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 03:39:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--E1ofbk94bSHCjB4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmEgzkACgkQJNaLcl1U
h9DfjQf9HSWOThNPgda12Mbe32mgTY1rPFEPsfWjNPriMyPPcPQciDIyjRZOKOOQ
agpRaCucWQFIjweTEOc661JSdxIn5ONx+bAUKJ22GYamxMq7sBfJ+MvjHNTm70a8
h7XwmXpAHDYN4CI7cc6ayaak2FvSuWO9wWJNmW6tRWJhOKOVPcHZJTRN2HTdnXmx
SNvO/9XwifBuYujt+OZD4YAykE7txofFF9aXYSmwYW+/c3Ps2QH8zFeZECCyg083
d0pRwKOtulfpDSt0cixk7SFd2PNpARAfOn+H9bjDwsMDqF4EKryXvZtQwGU4C74b
XB46zx78XZjC2LLJe+xmqSl87m7c2Q==
=6hLr
-----END PGP SIGNATURE-----

--E1ofbk94bSHCjB4t--

