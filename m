Return-Path: <stable+bounces-262031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K36RNQTBJmoOkAIAu9opvQ
	(envelope-from <stable+bounces-262031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 15:17:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61638656881
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 15:17:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Np9gHYeC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262031-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262031-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8CDA3009CE9
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0243559F8;
	Mon,  8 Jun 2026 13:17:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075524677F;
	Mon,  8 Jun 2026 13:17:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924674; cv=none; b=piqt4B0a5xSzOUPrE8HzqIaIOSMB7O0nIWjjinYrd8otIeBhRYYkzuo9HNC6QJJF/xdjIVGconLK/DLzRqtkFS+z2IzKzSPPPp5AQH/OKIpQG5e2ojoUVGDQEoOMIaOzZ1KU01TI/eDaoXlKuVN0t58EFZwtqg1Y5kI8bO9ptP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924674; c=relaxed/simple;
	bh=5ZcfMxYgH2fNJAZKgfcOmyHmc0WQu6D9ZE/mtecMdUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXfyxRUKN+4+Eqav1xXxzCUYBzEmHG/qEoQfNwQq+T+ykPmPOF4Q1k5wdpSrqQCg86yo6yz/4utL6/u+2N29v7XqPHn+QKlf2a5a8dAn2z6wy2UcitB/9GToZ7M2bzDCTOEQrkZweJKpjuiOS9YVilIzVXMeYIaJAESElW1N8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np9gHYeC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731CF1F00893;
	Mon,  8 Jun 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924673;
	bh=veTckQvpbSMiuy9BuWTYv1iAVwX/M+n2YemNsN3Jzbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Np9gHYeCXpS7hiRiJhxyUqlUqEfL5Q+2CToVfyagUKDLzRN09ZwHd0tBQGPb14+hF
	 +1cRd5DKA6Qi9Bq0TpdHWdrYt3EYrbfYKsadBEmk2dmTCMSWuTrOpZxza5h2KmY4Y/
	 BO06WN/3+o8ngZbXrh5396/N2a55am3SKtzdGJAlYmkK3eRAowzp7cfwcnACD6BHbu
	 yLKIXbL3n82fIQG+FHojzl6uRZQx05LtpatougcNpZ8GkjqbgBOtxSltqgxtGRAmzq
	 ouFFoNuo9iOBWiaH1n0ShB/UOKd8G7u7BMzFqCr07biImdQXuErhN8Q6ze51/f3mNX
	 zGCjVRCbL3gfw==
Date: Mon, 8 Jun 2026 14:17:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
Message-ID: <dfba6789-e4a1-4c2e-9db2-bc014defb8ab@sirena.org.uk>
References: <20260607095728.031258202@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8PFp40QOkA+wbZat"
Content-Disposition: inline
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
X-Cookie: We've upped our standards, so up yours!
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262031-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received,100.90.174.1:received,172.232.135.74:from];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.103.45.18:received,100.90.174.1:received];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61638656881


--8PFp40QOkA+wbZat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 07, 2026 at 11:56:09AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.12 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--8PFp40QOkA+wbZat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmomwPoACgkQJNaLcl1U
h9DW0ggAgqo2ru3yNz5cVAfwC846aEoPE4ZAuoFHTJ+iPy/eXIfYP8ZjNTdaSoFC
NABqWvyT1hFVUV2y1udsjltnCxw4nTkAdQxiFmOXRQdKIN43P2HG7+SYny4Lerul
7A5UagUjsnl3tuOraijsT/pNuHkPVv2yEDe4TxuiO48OMDV4FvF5UAf7cgFjIEH5
x+aH8kMGVyiCx1gB94eYdGpcU1M9pyDd9Mh6sCJJwGKneqCiz4Wh0HiCvebtenH8
get7SW5hiNBq2yk4LgSxfNZSiRUO7wAMWxy0ZyGzJSkgAkEakxDZ4d/Fh/iS0AbG
qBuONddj1SjdSUx9y/iOI3FHs9R/HQ==
=IrZI
-----END PGP SIGNATURE-----

--8PFp40QOkA+wbZat--

