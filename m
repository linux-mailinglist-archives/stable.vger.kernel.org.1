Return-Path: <stable+bounces-202845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C3FCC82FA
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3924B30E07E2
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353E415ADB4;
	Wed, 17 Dec 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKxOMcq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFA33C190;
	Wed, 17 Dec 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979818; cv=none; b=rA3KROPoul6lqed6URiUFglvqSsLl/aQwyRjMRz5Lk4qiOnbLPd/WdtZUc3BtKtb1NVOLGp4N0Hz3p9AB9n4uxG5t6rHcGA6xvi44svOcaG9FiPNfOK2YjR54E+hjOCdxFPC545BGcqdd9SPKf1CpNczv8rHYWM7X/RE8Upg0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979818; c=relaxed/simple;
	bh=G22sIiiKSA2XXcfZ6KfilrDGAu/xSkPbnLABxe6mfqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDlsg4Y9N4dSs4ST/e0MrSk7JDSNKLabLlCw51D5vBBxqr/NcbKXSuraGAOIdUyqA5bYSM0QqNXEQzd6GXf1CcE4HEO8wya3hbTEieU4o9cptJGCkDqLDPS6aIoqUGNUxYRe0pDCpVc8qRFYxnnjVTgzf9CBVvZILu8c+Kj9BQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKxOMcq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C330C4CEF5;
	Wed, 17 Dec 2025 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765979817;
	bh=G22sIiiKSA2XXcfZ6KfilrDGAu/xSkPbnLABxe6mfqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKxOMcq62Igo8foAGZZi5lh0jE/WCR+cNu6BFJqCaO4Jn6X2EJW6iu1y+nSJVroqS
	 ZmyFCqDo+In4G9OYTspyVfuhllVmv51Ug/WmviY8akYrMDfBS4wMP2nVBZf6mNQUJb
	 VWaLVS6tPIu2FLVBOH+08Krq8Qv5Zk0SwWskGgNGfyF8NSs00wlPlvSy/6ruXL3t6H
	 g7T01Ft3wd6YQRDF5byWxZ+6z5X2UoJzjDoNxDvPWnKdivGAU+nwQOhAvGD2SoIK31
	 2tdXdLXH91Yq7Ek+fadDK2LchL+4sp+1q6TOEDhahvRB8xlj7/2zcCPsowj8mwXThj
	 hLpvtYwmyUKmA==
Date: Wed, 17 Dec 2025 13:56:52 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, lgirdwood@gmail.com,
	linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
	seppo.ingalsuo@linux.intel.com, stable@vger.kernel.org,
	niranjan.hy@ti.com, ckeepax@opensource.cirrus.com,
	sbinding@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <8e2d0294-318c-4776-a02e-f6e6497852db@sirena.org.uk>
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
 <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
 <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
 <9f1d5b88-e638-4b87-bee0-fc963231d20e@opensource.cirrus.com>
 <87c2d498-60fe-4339-83c8-f6d6bc256ea7@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xUs9rGoQPc9ol9px"
Content-Disposition: inline
In-Reply-To: <87c2d498-60fe-4339-83c8-f6d6bc256ea7@linux.intel.com>
X-Cookie: Big book, big bore.


--xUs9rGoQPc9ol9px
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 03:54:43PM +0200, P=E9ter Ujfalusi wrote:

> > rf@debianbox:~/work/kernel/linux$ time ./tools/testing/kunit/kunit.py
> > run --alltests

> well, I don't have kunit test setup, so it fails, but I can build the

What do you mean by "kunit test setup" - that's just a self contained
Python script that drives everything, it has minimal Python
requirements.

--xUs9rGoQPc9ol9px
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCtqMACgkQJNaLcl1U
h9DM3wf/VeIMzYgXB51+ej5Ci2X2ylHzQzf8U2IDBoZcqKhhNRw4jTozH2dN8mRn
lN8U+v1DKwhng1KQhHO72p7TsGIXPplRGZPAypDoLRtELTXtU5JTgxjxtOmSS//p
RVCd775zGysGsVQDNGLtKGvL4fSozv1sTdvW918ZfbSOCGWdXMKXaXf6CdenGKf/
LWZu3mbSsCOcJlTZry3EI+ZNqa1NyO46ZvbsRmRWxwrjrEmiAT290eq8GHJw/dIN
XAiRjMd5xO/+6FYBbPs9XvK0YKAR8vPYpd+/w80/UhZDMaNJ2EZmD7RlNTbz9Cyo
8YFN2I8iXB482mh0bV8O2Vc/W5jYaw==
=RF0b
-----END PGP SIGNATURE-----

--xUs9rGoQPc9ol9px--

