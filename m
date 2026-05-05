Return-Path: <stable+bounces-244128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFpRJ6Lk+WnqEwMAu9opvQ
	(envelope-from <stable+bounces-244128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:37:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D4B4CDAA8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62EBE305B2A0
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438C429811;
	Tue,  5 May 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTbxRqsS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672251FC0EA;
	Tue,  5 May 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984401; cv=none; b=luB73nPM6GLES58b7MVQzTTV+kOurqUYyKmbQqZmJhWxYkkqJnJRIqgRYO6ZCDJRKMhWB+hgaCvpjGRTlTYPWejXEA2El+pC70Qe7HOnapRD0rph2dOSaKOKGdkQjWgMfv6+Zlj7S1gYyxWlgf3icW9cWReJ1BFLT4tvHryhfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984401; c=relaxed/simple;
	bh=6BdUriHZ4/yg9LHc34KiSRgJ3KeH8EG8OoHaNDhmaao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiWy2WlS1NkxoMz5wT+R4ciN8sP4A3/3WfGl3fiXT5lI7477ep1PNCmbsSJ8uz2UjgJQQjk4SRBFaB67XJJpZbpWQ/3MS4nhs1hzzVBSIYIYvUrsUJCGSFtx6XRALkJ7Bl2VwZx4V87N3H4mCDcAnYKXYEnNc/CX7I3/iyQUZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTbxRqsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DCCC2BCB4;
	Tue,  5 May 2026 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984400;
	bh=6BdUriHZ4/yg9LHc34KiSRgJ3KeH8EG8OoHaNDhmaao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTbxRqsStb9YUKS6jLPo5RGyQ9aWEaCGrnP43sDAoFnFs6beOKbUr9HsUiLYLlySk
	 Ep8VKD3I4xjRPbnY7zy0aTM7aswYBR04F5/Q9vlkY/0rF6o5xy4aYJFVHU7/kv2ISc
	 AdQOmjw/oKKff3EmkV66osSOJ0Vk9HyU7HUYKT7bgQHre3b28bNgVdCuZV3G/reYFU
	 /+IMbZi1lTwhCWW9H+4+4WikY0AVFeyTYE6ckB5mAquU8P74qAyBPXqDqJXtNwWNdU
	 KuV1o9HPm+ymrWzzcEE6ELjMSE6a0/mKCk7KnxJQJdHhtr/Rno8gb+myi1SYOz+CRE
	 MqXvTtkEbxwnA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id AC7F61AC5875; Tue, 05 May 2026 13:33:18 +0100 (BST)
Date: Tue, 5 May 2026 21:33:18 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/215] 6.12.86-rc1 review
Message-ID: <afnjjoMrbcNxdBo8@sirena.co.uk>
References: <20260504135130.169210693@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rgV6SPO41Ka03Ul7"
Content-Disposition: inline
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
X-Cookie: Alex Haley was adopted!
X-Rspamd-Queue-Id: 38D4B4CDAA8
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-244128-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--rgV6SPO41Ka03Ul7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2026 at 03:50:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.86 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--rgV6SPO41Ka03Ul7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn5440ACgkQJNaLcl1U
h9A9Mgf/XXJpWOB4C8NZ31SIluZwTB5pvR066L4cRJFO0YnaUUtJz8W7RtV8aLR6
v3c2tm0Xk7RxcRsZjRtpd2XSey9q9auUUqQc1qwgH2dZ//3gWHKKtSlLfItFBv85
FoGPJVLXK/Y8+21Aamq9oDYcxh3Yqyt6hPtTKwpFrYZov6dWvMiBzMksGiuWTK3O
bavoUO2GfpH1WDF9DGO3UjSd4aktqIIfCyeLEjP9yh4WetwHr4h0D2y+fYumgzmw
65eHqfHTrmE0V3BmFDEeEO7zd/u7FIempDzE3aI+8M4zjxyAWwaqra9aPKVer60z
Fee76tgLce9ZazZLOvwCglno5EKoig==
=Hl+8
-----END PGP SIGNATURE-----

--rgV6SPO41Ka03Ul7--

