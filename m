Return-Path: <stable+bounces-247086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B9TiAEwpBWpUTAIAu9opvQ
	(envelope-from <stable+bounces-247086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:45:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16E53CD3C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 851CD3016CA9
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7F2EB5B8;
	Thu, 14 May 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZBkIJUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38F3F413A;
	Thu, 14 May 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723137; cv=none; b=Rgpvx7XHTVgVsmeNO4qkMT/IdL0pNxuFrJnSu1Ien5st3Gs13aLBYj92uyH4x95+XRAaOiZEiwg/hraJzJ97aaptuFcAv9zpGpXKYA5WANNhtnHwZSSigGLxKCmltXJ49ekHw9otfoYELInJjYwbC/aN+LcUxpZ/VhPrRpnkFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723137; c=relaxed/simple;
	bh=dxBcxxITvhijt5ZHP/U//u+5Nw1Jusa0LShIzKMZp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ1cwAgiXp1OiWqWieiud9V41TKI31tQeywDTiXVzkZduaQZvuKliW4QL2GlHR89Li23dyvc3mH8dITfAY+rhkxAKwstzjnKE04gkz1xEdSZmUD2O17LjUC6OhSvW9/6kJRON1et5Nqd+c5hawfz/Lqa6aZb8YIvtCf/BgkeLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZBkIJUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D626C19425;
	Thu, 14 May 2026 01:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723137;
	bh=dxBcxxITvhijt5ZHP/U//u+5Nw1Jusa0LShIzKMZp80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZBkIJUtIc6bsJHX/qEJhMZhw3Yn0olGT8kF8PXyXUFp4aWGe+X7rz4+zF1fXPNOa
	 GL8wscUwOcLKZfPHlssVeMzwwa+NyIjaOP131VRHP+MZSAjGAYESEOMmndYRdhMW8s
	 Bibg5IO7ySkL1jWpvuWF7AXGGOtiP1jv/ik5IkxNL9pbjoZCSxWTHdbkIpJ4ik9yNJ
	 X1QTgrDc1fq+SPvWeyIz9UALdAftuWRXwcCvxmOERp49Doso1uLt7INiHQ0gEg8vKq
	 BQd8HVR/jRwdzEN8dq+MGZ+ZPM8e6BzKMU3byLbMpRVXe90RJBb4nNxPUrklpCTaF/
	 N+MBdpQIDYDRw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 203581AC58CE; Thu, 14 May 2026 02:45:35 +0100 (BST)
Date: Thu, 14 May 2026 10:45:35 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/202] 6.12.88-rc2 review
Message-ID: <agUpP2znM63xEtvZ@sirena.co.uk>
References: <20260513153743.326058350@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uTwJHE8UJ/2gMKc0"
Content-Disposition: inline
In-Reply-To: <20260513153743.326058350@linuxfoundation.org>
X-Cookie: Truckers welcome.
X-Rspamd-Queue-Id: 8C16E53CD3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247086-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.co.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--uTwJHE8UJ/2gMKc0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2026 at 06:17:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.88 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--uTwJHE8UJ/2gMKc0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoFKT4ACgkQJNaLcl1U
h9BpVQf+K2vjfVtE5bAVTbXc8QiV+gF1nC2cpkVjj/gOMuM0GhdgXP7CuPA418M3
lmyKCNz1DVDZuYGNL8JT1sJvahI+ch4KZt19EWAgJjqdSmmKOi3NReRIddL2tJDM
b6AzPTpu9OehwZUdcRcpj4wAnleulp+w5I1KpDDef9O4vfWbT5OY+gWinIoxDAeI
Ma98sJsb4B0y/cgKGsIfqH2OSrZFwvfIZdvczYiLyErENloPDRJil9q3D9XY4KBK
F2go/wsykBkeG8NeZBz/nn1jJTn/ctY2xQ5orDpLkpCrxpaSSqoQWe0DUOxRXG3y
9B/FVvTir5x+JWfVhosQIHaFsBheQA==
=GCS0
-----END PGP SIGNATURE-----

--uTwJHE8UJ/2gMKc0--

