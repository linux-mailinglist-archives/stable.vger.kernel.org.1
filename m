Return-Path: <stable+bounces-248974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPXADwsRCGoAXgMAu9opvQ
	(envelope-from <stable+bounces-248974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 08:39:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C655A7FE
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 08:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9966330069A0
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0A0305672;
	Sat, 16 May 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRao/ZFd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23728A3FA;
	Sat, 16 May 2026 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778913541; cv=none; b=PzIkk5RoFtDou9PncfAzUA3134nzU3GaSrwezgbgSzCUrY1GN/2SKq1KP1tGp3LI8KoNX2T+hIH3m9RfrEnsfF2VqmpBYige94A49WhhWYz7I6l6sT5kC/SEezj1aI4C88a9t179HseP60x3HaDAFiJCt7N5ujXQzIZl0KMva48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778913541; c=relaxed/simple;
	bh=tLqmnZFsIgSVZR7xBazzqnkBete7dpjlNf7CnhwheqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK3QoC7xD3xip6dT2vv0GDMK0jEBXiyZzOgn/scaPNGEyg9Ay80aIkOf9c55ORCqH9k/9Y9alrYvfOEQJ1ElssJggDk6M6Ah/hAvDpOer2ElmM8mKsFzgPihn8oAKxU/Oc2CzRqCrz5fwKoMyEZGkVeBRmP+CqlTkMlUNkjil+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRao/ZFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868B8C19425;
	Sat, 16 May 2026 06:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778913540;
	bh=tLqmnZFsIgSVZR7xBazzqnkBete7dpjlNf7CnhwheqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRao/ZFd2dB/O8m6QnF/ItQUkP0ZPXsqx/lz4o/GM5BlBtgqDtf8+SaGeTPFEnWx3
	 +LD2utB33TtUwr+jzQOALqe782TgjAvEKdaoYHtX2UWZdW03GoPmQ0GcNt5qdIRWQl
	 rrDQBcX8A9E7cT2cyEjmCAkxqMayzh9USbCC12h/lR39BEignPjVbLX88/bCa1bKG8
	 BxeLp/GDp5nXZHjlQApgWY5ewi6VBhY609nQIFbqG4iP0LoVprJUclcfN51QBHpXEr
	 AyX4bq74cZSCrXSRB4h3yH0eoLgldPxRgc5hslKJFLQZnqoX5WnqJlJOLTTs7YoUaI
	 fgcN2+O3qFCGQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id D17B91AC5A48; Sat, 16 May 2026 07:38:56 +0100 (BST)
Date: Sat, 16 May 2026 07:38:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/474] 6.6.140-rc1 review
Message-ID: <aggRAGBU0GzrutMz@sirena.co.uk>
References: <20260515154715.053014143@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xWCWisOncyUVpFIS"
Content-Disposition: inline
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
X-Cookie: Truckers welcome.
X-Rspamd-Queue-Id: 2F5C655A7FE
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
	TAGGED_FROM(0.00)[bounces-248974-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.co.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--xWCWisOncyUVpFIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2026 at 05:41:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.140 release.
> There are 474 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--xWCWisOncyUVpFIS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoIEP8ACgkQJNaLcl1U
h9B5ngf/fXo5eL80PrWwlpNJRPCzAAz6LzqgCq4SRDc9M7oi5OFte7n7D4fwPlSb
pZGnd0/cOiXOv3kpn3IvG7RhteJOaFGsdrA+Qg9xrFEAw+5mvuReWzF9fej4QL7g
p3Q4F1F3A3FhyKmUQkZwrBg7FpUpOoM42+Vr4IAWKwO/LVuxHAW/yId4nRQbM4cw
jhDySFo75IlchDBPRFoiHTwTE4isv5NGuXhx7bMJFWhd9LLJXQb1kEJBKpnMsENL
lmsFNXCRHbcAcgbZAHxjvy0L3GXduy5r/nJMly1LfPjV2W6E52Saiv+JpG5foQfG
VPmDId/JLe8/qxa3gHp1uPFilDulig==
=ptzT
-----END PGP SIGNATURE-----

--xWCWisOncyUVpFIS--

