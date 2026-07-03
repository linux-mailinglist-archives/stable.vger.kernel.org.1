Return-Path: <stable+bounces-271791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5DPeMZHFR2oofAAAu9opvQ
	(envelope-from <stable+bounces-271791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B27035EA
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:22:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hmAql/s/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271791-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271791-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA86300FC53
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F33C1996;
	Fri,  3 Jul 2026 13:56:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C13D8909;
	Fri,  3 Jul 2026 13:56:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086984; cv=none; b=WBO8i3w2yXQnbyYLBaEXHEoMJIpIJ8kr38eDNC9eUM+nZQ8wptzOU6XZG/jcsDA2+z7r9k7xqVdsIUWIE/GcBKjfl2kcvNRNwmMJNBxm5Y+89tUmoFe1bdvKw3I9XK1yKuqddlE9DO7m+o4dF32owKf0VA0VFiimVnx0VKlFnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086984; c=relaxed/simple;
	bh=YPZdfbp1waqnZBrRki+mXPeyVy5JgFIpXYkWpBTYSEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3PRuvzt6LhSGf2DEZDlR4qu+yjLqx+3Woxt7mrB+OQ/uV+U6PldNU+5rvNyIfL59Lr+1jWhx4ZAB+DyxQlbrBg7f7KTvReHHhuBIbU/ylWZZ0qh8BqRF3lHYvHqO8dHtwuW96Lb97SBuUq9SmGGX4WKWBNBK+38QUJM5QlmlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmAql/s/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC591F000E9;
	Fri,  3 Jul 2026 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783086983;
	bh=FTOQ4y0QRMFE9XJVWqlCgNsY3R4ROSrfVmhOoYVofbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hmAql/s/NncF4d805KRl1gDKwXnt9KFSxuW41HF1isp0+SR1+nrK/ESsbuThrB7IA
	 lhPNDR2eROomGuari4CsuCulR1+94j4RxjBJmRgsdFF4YWhcScSgpNnXkfWb/g5qbp
	 +lQHZvau384jsTOWoJWcKa6NgG51IMw7lBalddDWMetURsUr+SULkw7r0d2HaaglHl
	 06uCFz7m1bGN+yhe5EcT0U2ZlEU0BdNhEb3LgZBnnmzx+J17O7SDjdQQ0J6Vl1g+gb
	 4fJyTG6av/Wsdm7HroBwsdmBIDilBSyn96/FT7ZIGEAZVLo5Rw+OJTiiQ/UNxwlZAR
	 edd9mZumeFSQA==
Date: Fri, 3 Jul 2026 14:56:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.15 00/95] 5.15.211-rc1 review
Message-ID: <80a5bfa2-145c-4ca8-ba35-19f9870ef822@sirena.org.uk>
References: <20260702155109.196223802@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lJnslHdZZxGPh8xo"
Content-Disposition: inline
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
X-Cookie: You will contract a rare disease.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271791-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 261B27035EA


--lJnslHdZZxGPh8xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2026 at 06:19:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.211 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--lJnslHdZZxGPh8xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpHv4AACgkQJNaLcl1U
h9Bwpgf/QDlpG6SBv8WTTPUuucaSbYsRxlUJc+Gn/eeBB+yHDh2uS3K0kaaHko+N
4Db8AfV+59aryJZB8I0jfReivQECE8YYVjTjJV4TCEuQKFKkwSMjcDgbUfaFqBP5
nzfkYWLbRp7oFNOM2EU2bnTxw8xN5JnnfdJ64GkRfQ+rVwx5rpO0P7wvPNjNwiiE
elqUP4nx4L46qx2+VPLyLfc2yv/vMpLnVvpO2N0GPqen2qLAomxLESofnuCsUWMm
vhDFIKghYEXUh1tRwi+ilZ+lYfdu8x9BkLxTDquT2i7717PnC0k9l1u/kh0+oyxH
0aGFMp8CMy8bfxOdvSaR5xy7UeMgvw==
=KAyP
-----END PGP SIGNATURE-----

--lJnslHdZZxGPh8xo--

