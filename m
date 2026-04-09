Return-Path: <stable+bounces-235415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMQcNkWx12kORggAu9opvQ
	(envelope-from <stable+bounces-235415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:01:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ACE3CBB47
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F16B300E6B0
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B1363C4B;
	Thu,  9 Apr 2026 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N54qrwfs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C93644D3;
	Thu,  9 Apr 2026 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743277; cv=none; b=jHq5DwTiQe8QYj6AJHhE72ymf6NaibmlHK1bIaAWTVLAo6jHGoff8u5K5mtgddv3NG8pg1ci0gvyk30FGIUG720aAjQk3KpUdbUUQrT0ugxauRo6gxnBT1qElLtPd9ZX57rkhSIz15ljZYx7y6h9jU8Fq4qqq5oDIsliCiYMG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743277; c=relaxed/simple;
	bh=X+xN5Yb8f5mCu2fOsU47f+TWcmuWBXzkAFczu+BTFUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OguWPRkEchSEG0Xy9pDOLCbWeiuGtkz8/zdaM98OHtbZrb8t7QjJxPoO9pTzydjCyM+HQ8OYyHWg6mGzecWDal5cXpSXD/P7euhEUi/E5sL8d8EVLbDiMp2B46RfvnukIIQfsr466dTMXWU9RhAUAhgzi4/ohx8QMMFikDB/G1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N54qrwfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E705C116C6;
	Thu,  9 Apr 2026 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775743276;
	bh=X+xN5Yb8f5mCu2fOsU47f+TWcmuWBXzkAFczu+BTFUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N54qrwfsSnvw8v00Il34AInJiLV1wGovQc3czsJQwuhbwsDRS1mWTGyK1SEdRrRUw
	 vNmZiCCIdjr9/Iwc7Olojy+2iNWpimyJPJFUKsn70/qkwBfGcQ3BIFP/ELNZ6E8WLQ
	 eB+L3SCMo+m1UbALiSNUuyPTKWWmezBt8DK9YUoQlakGicMGW07Q6cRgRk1kr6WxEt
	 4Mc4SACFOy9xILgujDmZ3xElE+/iOjbEllkUNr3ekV9Buana/jQoe2T/nfKzLG+Uhm
	 +qLBfvtrBm12FqMKMgd5OOOoNnSE5YdT5fhycIi8NTawukJqdoAd0dGno6USXpMKu4
	 R8+/nFs7XjsDg==
Date: Thu, 9 Apr 2026 15:01:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/241] 6.12.81-rc2 review
Message-ID: <ad3fc0a6-9d84-49ea-b0d7-e2512eb44306@sirena.org.uk>
References: <20260409091733.126574279@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="67aR4l631m+cCBGx"
Content-Disposition: inline
In-Reply-To: <20260409091733.126574279@linuxfoundation.org>
X-Cookie: Hailing frequencies open, Captain.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235415-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 95ACE3CBB47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--67aR4l631m+cCBGx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2026 at 11:25:21AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--67aR4l631m+cCBGx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnXsSQACgkQJNaLcl1U
h9DlNQf+MTZ+6obHFHOE8bcdPu0lB69b9qn0nMZQrwS5A7qJdqhaATnt+IqE7q8V
OuE+rVk7UgcgdeJW+3UfAoBk+J2XJQmifEY+c3Bq2VU2vrvxzBqgi6B8DjjQeNfZ
VqFPg1wZF8E2hhslWVlJjhaSv7Cs5avG8Q+fDa8+NnbuvuM/FfCtvRKKyhn21Dp8
2ibitVpi6It42jj0dAy78zvgoTT6n58JV42PTap6iffLg4jb1DojwDoEYHzdrF4v
Vn2IpftIXMJlCjvjqHD6eBilYglQReA6TnRTktUkhov/4fG3dQ1sfI39/FkN9Hw6
npZ9snKBoTkpdfsb8Jo4QUsXCTOzfQ==
=3QuR
-----END PGP SIGNATURE-----

--67aR4l631m+cCBGx--

