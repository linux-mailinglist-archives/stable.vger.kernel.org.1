Return-Path: <stable+bounces-246899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GnnBTieBGr3LwIAu9opvQ
	(envelope-from <stable+bounces-246899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:52:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711EC53685A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59F9533DD80E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2317315D53;
	Wed, 13 May 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP80ApjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631373446AF;
	Wed, 13 May 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684844; cv=none; b=WGreV14Ymzxfq6UlJ1+p5ssXEY0vmPsZ+h7RD2bqNfmWgMGVTnzXRaiSQ5BrAIYtsxYbP8OKYIeNN/2B9fWDVGWu/PToIVjt6x+LOQQ6TfMNSCp/hZrHHgnExwF4sy8XWNYcNJT8Ti7zsDg8eROScKFZNDttMyjan/1DkIUgRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684844; c=relaxed/simple;
	bh=gl+CEg/yrehATBlUWyOI0JKsU69HIcJgzFq4mPuIPOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogchW0J1Y6KnEVpEcroC8/WUw2n3Ls8Ad9QphNxDELLvmDkIC4E6WbYrsBqx5bE45vY0OCMue+z47xawOKY5PuG6Ddrp0h7241kNOfL2U9laA+OZZq6fZrd9KI409+PwvAJ9Z6dwLXovFiLL7GbZO3rhdg0T8+hunDJkDgkVwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP80ApjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6F8C19425;
	Wed, 13 May 2026 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684844;
	bh=gl+CEg/yrehATBlUWyOI0JKsU69HIcJgzFq4mPuIPOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bP80ApjU3uu0AWwYGlg2Y9K0SZsPXUQQBJhOB8B0ItYhNoBkrIt5t28y20I3/hvzB
	 mdcE7eMnQw9ESP8TKpP0LUOTuZFxJbbvP0dg8mTIUE71IH/nu+5+1IIrRI8STbxWE3
	 JDS94y79PHTXGSKqof/pFj9dHJEtJYWNwjcDdvU0uV1wR5lWxvN6VCvil39Dn6ONRp
	 VY4q8sYt9atLI6IVUuIUu1VovEBnjhlo5qgz/Oo6bBXIjjjJSHaV9UOMQbo4tEMziE
	 mZt0JFYCjnhaT/VSHhdXpBe1sgsJ/+Q5T8nIglbgshU9hNZWCpbNq1j/RBbLUbj4IJ
	 GPQfBjtphGmUQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 8100F1AC58CB; Wed, 13 May 2026 16:07:21 +0100 (BST)
Date: Thu, 14 May 2026 00:07:21 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/206] 6.12.88-rc1 review
Message-ID: <agSTqYwkGQgoOapu@sirena.co.uk>
References: <20260512173932.810559588@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="384gAKQyt3KAniaW"
Content-Disposition: inline
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
X-Cookie: Truckers welcome.
X-Rspamd-Queue-Id: 711EC53685A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246899-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.co.uk:mid]
X-Rspamd-Action: no action


--384gAKQyt3KAniaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 07:37:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.88 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kerenl.org>

--384gAKQyt3KAniaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoEk6gACgkQJNaLcl1U
h9DViAf9G+O2MfQ836fOqD2n37mDe+XytQ/aoINf8dAkzvQMxo/L0RspVo1Tzdqz
ItoQN8vK74lb/AIiys2c69tuz4u9tnaASvz++3Fo02JQ5AiUi7rzLYVlYqIylxyM
cm2WH9YMhpocW/p48omy3LGghIqiEW0MMP4H/UDlLv0P5Xz3c9mU3yD1idaXxN53
5BKkn/uzyHNmmkblSe2K6ndEdUekVUI8Jt5Fv3jJtXvG/XsigvP+yZC1NdxswjEn
WIVLwIDFTJqcmYrPNlj6ls4O9c+xPAiom+iMDxqerZKX1herhfqjrt73gob6zh+0
mZi76RWQ5tCcLLf78hTkpdG4Vmo9Wg==
=vjLb
-----END PGP SIGNATURE-----

--384gAKQyt3KAniaW--

