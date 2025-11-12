Return-Path: <stable+bounces-194640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF703C54396
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 20:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66C474E3B20
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FC34E767;
	Wed, 12 Nov 2025 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnJV2MTF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331A212F98;
	Wed, 12 Nov 2025 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976038; cv=none; b=JRjvcFcGjVuXM6AQ1SMvQX5bkOjGfKlKecm8AxUb30lBaPFLY6BPe4td2YNsXWZsZcjKM1V1ewVAnnpQO0d5dAhtY4QVLcO0PnUPJsSZegs3V4wt9PV8PPvq8BLy203P6ZepeQ6VoTzGIlpw7tv7+jYEujpP+dT+72/s1oPsbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976038; c=relaxed/simple;
	bh=C7vuxaqtheFQFxDyOcPPsOTDus84iPIK3Y9zdk9Dslc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjgnsEWtIU6378OOOda3tQ79cuG4WrS3061TxUaRHbKUbFD4/TWhlXNPm8GMm88pLTHvxMka9xqg+dVc8WCfzwFN15V40Fk0cVLIvCryHifYBRVJ9ool65Y5lVbnSaLULA5tVj68xl2zA1wHgT7PTkBPDoN4QKIeK7HhTJ2VGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnJV2MTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E81C4CEF1;
	Wed, 12 Nov 2025 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762976038;
	bh=C7vuxaqtheFQFxDyOcPPsOTDus84iPIK3Y9zdk9Dslc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnJV2MTFjpc19JLHMdi4Xeu8IOkfRgbR+l58cjLhBli7oNf4O2MRG7/KMHZIWpN5Y
	 3+J0ETmRhPfrYWOi4wMmHgciJbYtkQ41p8YjRQQlAsvu4CQJWoyQsF9jph8IJblmP2
	 AfbLfZsFXosun9QRFTdgMND2iMExB5fQu+sKTPdmzoCbQeDL+ORnLAQVg9sxUnCqVG
	 wGCj2gAVW/piItjXT2foBu/ghVIKjMD/od2g724zKOFJELzskXNHLKwSe+MmT5x/pe
	 9mVRSVL+PHcvAZ34GKC4QRL7Qd6DMO92NJQSy6InonYs9wp3CHEDFjFL/mUZRcLP1Z
	 Ic8T8kFAMl3og==
Date: Wed, 12 Nov 2025 19:33:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: hariconscious@gmail.com, cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev,
	perex@perex.cz, tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
	sakari.ailus@linux.intel.com, khalid@kernel.org, shuah@kernel.org,
	david.hunter.linux@gmail.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: avs: Fix potential buffer overflow by
 snprintf()
Message-ID: <18bac943-6420-439c-91dc-643277850f69@sirena.org.uk>
References: <20251112181851.13450-1-hariconscious@gmail.com>
 <2025111239-sturdily-entire-d281@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="szL9mxUDJpsiHgL+"
Content-Disposition: inline
In-Reply-To: <2025111239-sturdily-entire-d281@gregkh>
X-Cookie: "The Computer made me do it."


--szL9mxUDJpsiHgL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2025 at 02:20:19PM -0500, Greg KH wrote:

> Also please do not wrap lines of fixes tags.

Someone probably ought to teach checkpatch about that one, it moans
about long lines without checking for Fixes: IIRC.

--szL9mxUDJpsiHgL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkU4R4ACgkQJNaLcl1U
h9BUjAf+I0Pva6nKIkon3XNueyt44je32pc6oTtm/79WhjXL6ZqNi5e+GQU7ZUim
wRonCWwRj0mkDA3d7pGqgeiXIXXA+uQxIwB81sU5hMU+yrMn38WH4mu45O0tXfrT
dfKjK3PxEhbUYVZa1LSFomQaMQAH9sSrVFrz6Wbl2VcTmDtoS6DY4Bv6FyMKuX05
Ms9Yt63ou8m7jnxZ8yR0N7gNSFJFO8Ln5DlR1utCqPgkOr4DHfqNmt/221ucYPIW
dgkvspFbJGcBMWuqxZvYp/fqt8+PeDPQfrr2y9NfkuRh8YHuLmAtqAvaqc4cS34N
2PM0Gd+UrM0OO3HsAPclUoN3IE8iRQ==
=qqSY
-----END PGP SIGNATURE-----

--szL9mxUDJpsiHgL+--

