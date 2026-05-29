Return-Path: <stable+bounces-256794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHjGBQIKGmo70wgAu9opvQ
	(envelope-from <stable+bounces-256794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7637960905E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D2483011C58
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5A3644C5;
	Fri, 29 May 2026 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvQdfqfQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F592DCF67;
	Fri, 29 May 2026 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091390; cv=none; b=sV8qqoIrQXh+82RfMw7WfdjiwPpMgbhp4sfTz1zmBzAYvwzZTZ0F7LWOUpdDPgkLbOo9SfgjgaW1y0NtFStkbh7QgIeCP7MPjWxlul1veS2f44GkuFTILXX1iU0kulff4TK9lseCJuwWQj9aiPjE95AoMfO8LUNSo7kIcVABDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091390; c=relaxed/simple;
	bh=URNOtpooOqXzr3FfUfSQGV9GStZCw/uFuf1vF0v3GcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1dTU0yUaL8lk5kydVi5SnAjyZgPckpiYvixwrvWxF1tm2iiIV2qLCzcTNKUZkoAql/gBuB7spVCphNRqRXTKc8jq6BlmfL53mSp5g7sGaddtbZqQLa8kO1ZRpUgSUhUnHGqXRU/ihBBPtLtV4yeHr1/o8VPYSD1IKgcZWlrhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvQdfqfQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF611F00893;
	Fri, 29 May 2026 21:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780091389;
	bh=bXzmPBi77GJmcEfk67MmK2OXKpTMmEh8fQMqQqIJ40I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GvQdfqfQ9J5emQtWmO+Q8OH/51OXJWMzyBtYu34AZ2b2w6M2zK62Ex6B+OmK72Gf+
	 O/M8arwO3k7cR1KLNm8ofPYD1lLRQ9oqLBVGTFf66n2DQpTpY7CrBwN+cIXHPg90K1
	 bSxm4YI/UaUP9QZZQfRgDm0Tgqc81TSg5gZYJrRlzoeoPQKKbYOYmKGo8rbjkk8FMG
	 ndK3ELAcwwCPTT05NOA1Q8/Qn2FR8wnw9Pk33Zexmhp3T3YVz6s+ygF8oee0oezUkT
	 YVR49R8T3UlksnWJ6nzRVahxAkGnCYz+aFkLdhIBPipuJi42/4muyiLE0JEVXOKOWQ
	 EyIHrULSoBs2w==
Date: Fri, 29 May 2026 22:49:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/377] 6.18.34-rc1 review
Message-ID: <f5f0085f-5d20-45d6-94ce-b071c379f71f@sirena.org.uk>
References: <20260528194638.371537336@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8RPCqELbui6Zl196"
Content-Disposition: inline
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
X-Cookie: Equal bytes for women.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256794-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 7637960905E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--8RPCqELbui6Zl196
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2026 at 09:43:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.34 release.
> There are 377 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--8RPCqELbui6Zl196
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoaCfYACgkQJNaLcl1U
h9BOVwf/TmQsRGwd2ocCp9By4ShhvGPKBO8HqPZ+m7JleFEBNdDaTiawM7rYgMgx
MbIa8rx/QEOreKtdEyrX9jgm0zVrvJbKTWRRXM/ZuM2eum7W4eQnqcBNUJriiAlf
qZ8ryNoCRte02ScYy9baaRWV/BEaBXJvi6tnccCRRXuyMWtU3fDnvtjTkaRFPHLL
uRodHxOKQZPvC2LBy1v265YsqrPcHFdmmbGasCoN1fmaspJrDlhDTi310mPYwe5J
r6pZ8RGkE+6S0AkQtaqVRdjePp9q6GREOZqScAXNcxhYjsJeMR/mQFIWo+NUTWQy
eHwZZESLnmJ5drznGtfu7K7a7/u7iA==
=mSwp
-----END PGP SIGNATURE-----

--8RPCqELbui6Zl196--

