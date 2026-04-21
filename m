Return-Path: <stable+bounces-240175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHp2BwGE52m+9gEAu9opvQ
	(envelope-from <stable+bounces-240175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:04:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B58BF43BB9F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03CC230039AD
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280723D7D7C;
	Tue, 21 Apr 2026 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvBeSsyZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563163D75C6;
	Tue, 21 Apr 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780280; cv=none; b=n0hw4ChrvMS2cOqn+CaPClqLP9h4InlLJ9YOESLltjklQs4w3tsXo0+Mjmm1WiaqLsVmYg3PORBVwNQE5GO8iXQ2qJiPPutTfLIO40BqwBCoe53f3Mo4VxJ76jNLM2UxG9l47hl7yVd27uQT5zg2XRxsHVuQP2oCuVYYvA8jW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780280; c=relaxed/simple;
	bh=Dyiuqc/C9bY03ncMuf0GqWO0n+VZ9Bbu4HKBL3cumh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FojVroDXLyMf9nO4R+RDRLMsZ8oqTP7T+rMSf+yjIBLuzdx2184dp86yjfWM7P7G5iq8sptu32OoXK46wcYeRKEtNTnCdYbqnV3Qe6KZv1Xk9SDiUQxwRieEMPKcg7pad8uKgHGENNB2O2WGWyd/suvHF8bLraV4KL52FmJV+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvBeSsyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3226AC2BCB0;
	Tue, 21 Apr 2026 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776780279;
	bh=Dyiuqc/C9bY03ncMuf0GqWO0n+VZ9Bbu4HKBL3cumh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvBeSsyZNmXVWTvaWqb2WuiDeYLiF83JOxU3yahojw5+5RCcvGzQHMXazslXehHZG
	 N2dwKyE1EG83Rd/ZutJZ2U6YtjOqAxiDjl88sb+FtkvhLR6N4lhu9c0bd5MkP51a04
	 e/QdeyD/mwWd8ZTPsDEZ/YBbtKtetQXGs2Z7Zi8oXsVg9KNcbKGLvsnnMzBMRip4kD
	 Az7CIKSK1x0oaLufUxfsPPS4t/sWt8gr6PlYBHjKRnE2ReBFm1OXHTvSnaDxkqdaHt
	 WgKeFoDFWfF4nnD5xZdo3wEnvASxlBmN5E216CRoz3DCuWOTg8nePkRcMnf2KQ8Beg
	 88H9g+rqzgc/w==
Date: Tue, 21 Apr 2026 15:04:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/198] 6.18.24-rc1 review
Message-ID: <67def94b-6ed0-4000-be08-314f30c7a923@sirena.org.uk>
References: <20260420153935.605963767@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PiWz+K6M2ZpPludO"
Content-Disposition: inline
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
X-Cookie: Jenkinson's Law:
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240175-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: B58BF43BB9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--PiWz+K6M2ZpPludO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2026 at 05:39:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.24 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This doesn't build for arm multi_v5_defconfig or bcm2835_defconfig:

In file included from /build/stage/linux/include/linux/srcu.h:59,
                 from /build/stage/linux/include/linux/notifier.h:16,
                 from /build/stage/linux/include/linux/memory_hotplug.h:7,
                 from /build/stage/linux/include/linux/mmzone.h:1538,
                 from /build/stage/linux/include/linux/gfp.h:7,
                 from /build/stage/linux/include/linux/mm.h:7,
                 from /build/stage/linux/arch/arm/kernel/asm-offsets.c:14:
/build/stage/linux/include/linux/srcutiny.h:14:10: fatal error: linux/irq_work_t
ypes.h: No such file or directory
   14 | #include <linux/irq_work_types.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~

--PiWz+K6M2ZpPludO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnng/AACgkQJNaLcl1U
h9AUaAf8DcixXw4lIRltf12kBt4W6WBOMvGjfkt2z8EsthTTZlrTMJNW5Ydj5U8r
PY1kFHDYIpusBL/Juku0wuEPzhzOjr7lNtEJDPZAXCL3SmXkFs6Xfb7xlfv1Tqfd
KN89Ft4q18lmFPsFSnrL6mXaCVExkNfBZccC+71UdUQKwTvUQjMO17dE18Zk7a9M
4AOZSrQwg3FxwtCWgKtD9svNCvAQQo3gQy4B4TUccLfgffZt7HItg7rwlWfzs8I9
fgl3pmQr1RG24SNLbiQV/i6aCGra/PV43CRmve8jncdNLSB4d/QeUmVG3jQFZI9h
THfRgvnFol48VsvNVaLTwhkxJzDKeQ==
=V9kt
-----END PGP SIGNATURE-----

--PiWz+K6M2ZpPludO--

