Return-Path: <stable+bounces-230181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBW2JSiowmmmjwQAu9opvQ
	(envelope-from <stable+bounces-230181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:05:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF93317AC0
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B753308E047
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF33FFAD0;
	Tue, 24 Mar 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp1+oYgv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFC3624BC;
	Tue, 24 Mar 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364309; cv=none; b=N3BYTCmkl+gTHHW6OHIJVUAKwwYw7puKicQfQnVSUvKue+2/mBnwSSOKq56zC96pAlMMeSgKo4eC/SYtMOA7rNuZn0VV9fk7AbHnxQoHphHQfZwQEJ9rCCYKL5svD3s0PIF7Uhxxuk8RWeidhN4pOw7075371BEdDFXpdrteg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364309; c=relaxed/simple;
	bh=HtWVQ8qrI6WKXqF7EGHSfqQK0YyeRApN24xzx0zLCXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2eMCd3ASv8yc12L5t/seFUMAzjb1fQoiEOcPt7MpfTIy9XwbJ6ES1o96+s37DIRAGhWac9PJtHjUYGJ0NBie2zoTO+tNXlt2ni6XBgKtQQx2wciBgvG2RuuYt5yMe7aPwGl/HbukQ5Kcfy3zeMurekHfHgFYlqln7+el+HwEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp1+oYgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE94C2BCB2;
	Tue, 24 Mar 2026 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364308;
	bh=HtWVQ8qrI6WKXqF7EGHSfqQK0YyeRApN24xzx0zLCXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fp1+oYgv6vaQRgxb+7rFxjaPnJx8DhOuZppcjTfdm2ZX1bSJoPMjvEaHtytjUV38x
	 5jAg/ijWvYAXQMKBNstHvLmcNMYYpa1KmfGU7f+71W7awt/EGo3DkOM3l/40yF1tjN
	 JBBkDGYE4WSd57YBnqij/UuJHD7MsA7S/B77q5D9C4cp6Rg0ZtosMyUTOcHIYWl52J
	 At+gOYTFDo3lPWZJoPz52sq/fhmCEA4ZHuPu7D3rk+pSh10D4HexNx2bSamBRyWOvf
	 0x5oU7vW/jwwlMKEOypT8bEk2Enxkd1dCm5CWlFuYOQtp/cBYO3HsHQkDB/Goyayov
	 svzGbzYxZeRqQ==
Date: Tue, 24 Mar 2026 14:58:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
Message-ID: <a52b7d78-42d4-40f8-8225-af5be6bc243d@sirena.org.uk>
References: <20260323134503.770111826@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M3XrHxt39ewKBYUX"
Content-Disposition: inline
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
X-Cookie: Forest fires cause Smokey Bears.
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
	TAGGED_FROM(0.00)[bounces-230181-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 1DF93317AC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--M3XrHxt39ewKBYUX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2026 at 02:43:41PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--M3XrHxt39ewKBYUX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnCpo0ACgkQJNaLcl1U
h9DYwAf+O2z56YcL+bDlR5WKXWGOvFJRP1wbFb2ak2/AIuBPiWj+sq06/A6ZBaVQ
R42vPqu9AkF66aMDajzc+vSH1/lNZ5RvoR/pzo0OetMkj9C/TP3sneHVpV891NCG
Tktw7uhb82tYxS3lnyz+TLMVozwL/UPvIYqmC0/ZddaLpg2cGzAhrI8AEpmD4hz3
79AT82oZBcDL4toyX/8fBStFXfx0HYcQrhfngrlDJQwQboHEb7lvdf1Tzz1xr20Q
yBPIPH0GQi6HHA20J6zHvJBGEh+MM2N9dhm9arnl7mpIelQKVlNh3IFvBDJ4dmzD
BK97kyLCelv4cvauBUOjgi5E8+7qgg==
=yC1X
-----END PGP SIGNATURE-----

--M3XrHxt39ewKBYUX--

