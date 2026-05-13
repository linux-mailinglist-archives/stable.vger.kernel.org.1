Return-Path: <stable+bounces-246896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJCfIIKUBGqrLgIAu9opvQ
	(envelope-from <stable+bounces-246896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:10:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CA535D01
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0D573087CE0
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E5B477E28;
	Wed, 13 May 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fcwc/iNW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDC477E43;
	Wed, 13 May 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684548; cv=none; b=OSVrldGaF5z5A6WzZy0DVuYaM1jIG5yLjBlZhFhX6382A5YdGSBDg+AE5zDhd8nzLcmlZH2lZ6qs+bgcN9/D8zvRdUcVy8l05DV1gS/L6UMPNgNJwTW6KbHRivYMp00xbAmPtBG6rBtgXyWd0lAZw+dKcvP7flWxDBf9APAN9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684548; c=relaxed/simple;
	bh=pbXFGmGlMP0z81DYFYPiQ+tv8M9tZaj5z8F0ElxpQRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMMtq2d8YIXYBX2S1Bxbrm1U7N+Iyr2tZhnletbJKQl0KwiC4M3unUsRJyHEXVSHJXpB0sWd38T33X1BwtbSOuPqpZ+eJcOjkhqVujiZmz6+YE7Rwv9GF1hzYH0lfW5FAQI8HeSYp1SFJVja/MxCkfRw+4XESGhfl0yh6CAX2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fcwc/iNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3024C19425;
	Wed, 13 May 2026 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684548;
	bh=pbXFGmGlMP0z81DYFYPiQ+tv8M9tZaj5z8F0ElxpQRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fcwc/iNWYJH9JEF7ZFNDOxaOzQcDcWlyGdmYoygtlJK0HdJZyH2aNliLvkAe+xMud
	 3eHa5mGBlh+bUy6h5OEgrN4SnqwL/YLa8b0qe3Hm+/fuBKYLW7Cvf7HmxAYEDHqUuf
	 D0q5xp9cIs81tQu+FTZJmKolOdY04z+Xx75Bp4ri+xQ9+29/z35JuOHq/dG7uhCvQv
	 ajtmDmUZlI97Iiz4Lsi+GBs0LCHFQLxSbkCIdqLQy87gQoLNqE5Su/aK5WMZTmlII2
	 pwKzblifPAVvzuRKNbS77bjm7L9+BL/Q7VPjE3/69k1OfmlhuYNf7+CWFsGlt+dtOi
	 WrkBxbegX1UGA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id EE5881AC58CB; Wed, 13 May 2026 16:02:25 +0100 (BST)
Date: Thu, 14 May 2026 00:02:25 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/307] 7.0.7-rc1 review
Message-ID: <agSSgccIChTrbyoj@sirena.co.uk>
References: <20260512173940.117428952@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cqCI9QLB9qV/fNjQ"
Content-Disposition: inline
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
X-Cookie: Truckers welcome.
X-Rspamd-Queue-Id: E82CA535D01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246896-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Action: no action


--cqCI9QLB9qV/fNjQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 07:36:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--cqCI9QLB9qV/fNjQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoEkoEACgkQJNaLcl1U
h9AuEgf/RDCq4iJI3XMDYW2PrUZ/QnUTXt3xdwto7/I4i8e6Z30dr3A+yccmOW8t
ctWOKdqEeuEGOMh92ut5YCxqz3EUDdL14pgSBoTj7b3K/d4Uw0UVtlac4MCxGUOn
jeGEQrfeT79JH1kotmQ99krjV55wHcw5oG05MMlSoLYRAcs/SaNZNu9ShxXbvYZJ
iKzPwUtbAOmOKAiZMqK6dwq8W/4YvF30fsjtc5OUskw4XhhIOKKEmT4SQiixHscz
OrpGkRWJe2hvljfUV0Bpl0/eBCrw5ORyG4QHRood62uJBUqR8xuF343SZculG2+B
rz9NMSqBhxRSiJcpUGpo9I6Lky4wdg==
=DQH6
-----END PGP SIGNATURE-----

--cqCI9QLB9qV/fNjQ--

