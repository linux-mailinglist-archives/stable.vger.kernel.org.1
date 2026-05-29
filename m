Return-Path: <stable+bounces-256795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJUcAyMKGmo70wgAu9opvQ
	(envelope-from <stable+bounces-256795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:50:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442D60906C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8482030125C2
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316537702C;
	Fri, 29 May 2026 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDEuUUgU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2932B11E;
	Fri, 29 May 2026 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091420; cv=none; b=ZZH1y6iW6SwUagdZ5cUOvV1uFVaxKI7BFcVu6YyJ07P4TFPbhHy/xVgC+pZGHctviiajIC/IMgY57PCft1fiArqA8JQtK8RduCpD5aLkUFt3+gs8VXz4NnXy6Ty36mnR3+B+ALcrePq1U8tCwBCe9eAjdPSWwCW3L20Inmht63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091420; c=relaxed/simple;
	bh=NtuuMyhRBVEPRHOP2TJ072S7OdPS5S5eBxyid5eCFTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blvV/wFzrakRvtEM5SRAN5+lLdsw1IUMntxjLyDakB8UKKG6LkwP5lfuX4daDLERpgivZ+3yiQLQKomUTTTsiwDXzPyXb6oB5UCa1I4UK+ZYq9gSlh+VodOEHNSdzVd1vu6LMmtnANfhfckdxEx+xjPmP9j21KrgizkjJa52Ejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDEuUUgU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1CA1F00893;
	Fri, 29 May 2026 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780091419;
	bh=6jw+3NK1yqHS40bZkJkTizxOGiTPGzO4EtkJUu7a07Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VDEuUUgUaRyhfF4aeCTuZ5IHR2+RpvhaDmTMZ0V6aP+3vVJFvNtQMyBoYcoA4v3Fq
	 iJBb3TJurt4ewCQMaYRYfs10p7SI3Y0BKzuEA6n9YR83TKmsESM4jeHb1kRuRrQ2xu
	 137MGdJgd6hS94k5N2k74OZZz/kZH/8Wb3j3d0iQKgqDiST+4wrqrhtUnXRFrbkpJK
	 S5AC7RIiG+OncSZUGNgx0ROyvXn7TrQEuAzirkmXssqmZmZIT4dQKUotb3AVVj8ku/
	 yttpaLPhncjIAhcxL+FFu5/BHGdLTHcUG63qgAfduTBFy3/Lw1c9xGGzbG+1Z9T935
	 2mKkNhUT6Vdgg==
Date: Fri, 29 May 2026 22:50:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/272] 6.12.92-rc1 review
Message-ID: <87b47c30-e7d3-489f-aa50-fcadbb1f90db@sirena.org.uk>
References: <20260528194629.379955525@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F8A0S8tdifKikvPv"
Content-Disposition: inline
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-256795-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6442D60906C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--F8A0S8tdifKikvPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2026 at 09:46:14PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.92 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--F8A0S8tdifKikvPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoaChQACgkQJNaLcl1U
h9BqxAf/X7BO6hovbxkVZiH7BMSo4wukrJY6mSEuTj5Qyt/I0loQSKDpaA4dL4OU
t/opyqUbyak8B/UXqA9XMo0g3TSk1ZqeXuUoEzmLX8gRfEPkltMb1tmKn7oKFb3e
AiIwOcRGAjZ6IuyhjQdGWygaeBZMqa7tRO7Ev0gHnIdxfi8KTtlm71/ks9sfEjXG
foqfz+OkaX+HwX+ZHXBA7iA+QKTPzac/rbdb/t/e1+qvUXujNA1z+hPSfPH2djFh
rUdPrfD2oZ5QqYWPrbREI+ZXUDZNxFwl1VfA1NiTm6d2c739eixvv5YPCxe87mat
mLJnnhbgSlxpuZZjLF6V2R2fxecd2A==
=8drb
-----END PGP SIGNATURE-----

--F8A0S8tdifKikvPv--

