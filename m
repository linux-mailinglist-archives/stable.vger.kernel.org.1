Return-Path: <stable+bounces-256786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P9ZDY4GGmrK0ggAu9opvQ
	(envelope-from <stable+bounces-256786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:35:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48E608EBA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DA823007AC9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6245375AD0;
	Fri, 29 May 2026 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw8Yf/NO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5B1E9919;
	Fri, 29 May 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090504; cv=none; b=nDDY4P47Us/DzqRJgfU+NaNVCP60LaHzZXy/4WWzEgdnvlFU9K2K0Gsq5VdxdNYRZ/IVEhYU4K6uBjee8URBsbI9Yo2Qe4FzAbjpGO8MSrTQCPQVP7bfjBDIhYnI1xZns9tdgInMRJtryDi42c7Vu87EkXDdkNLKJVBbtgzQLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090504; c=relaxed/simple;
	bh=D9OmZFCx0pbSwvU0BEgaNxVrFGLWUrow3siINjCOIeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7LX4focx06wAJolvqsWjT4LnIRhGzE3IgwrkmYgMv0sXUtUl8Q00h4AZLtTariEgupVk/Kj21CevBW4l7LFZVs/l3GLD6n4xJfN/AXL7dw9lqzWt/qSJTpvSRAHdr9qtpfiTRpLaNdGqIHBF8FyrWzi65s1OvLfNrMs7mnQB5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw8Yf/NO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A51C1F00893;
	Fri, 29 May 2026 21:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780090503;
	bh=OITdpyWNvQOP6kfoOVbLAzH+T4HZ1gK7YMIymzdL8k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rw8Yf/NOJ/XBb2vBhWbTJx8STj9uzqvic03UBCiVmtqh2a+Ge4G1JtBCGrU5UOcSn
	 p7+NMe2YoJKUquRFeu7DBEcKZXMmp66iWZrGPCVcwDfUtgQJqmpho7Q/CYxedqA1BM
	 vvAthbglx4gHn2X4gXJ/cEV0LimUAW5nADLrUVKlNcmOaWuSwQLbySHGklDv6F3KgS
	 /tRckHqDJSjIca9gpaOTN7vtClAI8spTEqvmZvkezwGS7Tq2sQJ9OnV4xwGKhiDNY5
	 v93K6MDiUN6ZSnNuud0zGJauG7wD0CSbQ5hsAZDshfUXWd+C7zy+RjIqzxGhxge4om
	 fH+V/ZvcErhPw==
Date: Fri, 29 May 2026 22:34:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
Message-ID: <d35cc0d1-010a-4446-a2c1-a9f7aecb8bb5@sirena.org.uk>
References: <20260528194646.819809818@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MSPXZTi7waUyLV+/"
Content-Disposition: inline
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
X-Cookie: Equal bytes for women.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256786-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F48E608EBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--MSPXZTi7waUyLV+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2026 at 09:42:09PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.11 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--MSPXZTi7waUyLV+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoaBoAACgkQJNaLcl1U
h9Cbwgf/YmYEBM/6nbmjB1XMsu+t9PJgg4OHmQ73LarIBYC73gGLDG7p+a4zF6sa
wE1MJnddzZQ93uHbjyd3USK4k8GRe9tsIw22ADCc4cmUXQewifaoUsx6YVlykgGe
/oZfoB7Epk96HNaf3kyE9b/vNV3F0RE+e1Gt+fMPGrjQxjoKYdL1+TAFSUCnIUwc
Vbxmrbw13/4Z338k+rBd/feB/nhZ4GpizGEEH9goZdiBdwkMquNpDkvSoNKrC0Xx
/8DbrWXk1Yjfm5gLDdHWKR3LpFRp2Jhw9NwTKuuX1WSZwq0DY1z8MFsM7j+n2bHA
MnwCJ8kSTaGW4bv3/6//1JmMYTBSeQ==
=+JjF
-----END PGP SIGNATURE-----

--MSPXZTi7waUyLV+/--

