Return-Path: <stable+bounces-189866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0CC0ACDF
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B1C18A0641
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C0222575;
	Sun, 26 Oct 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxxPjn8Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019327713
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493325; cv=none; b=o0dZFrbQfXhWeEU2U+WTGlnM9Dc6ZdFFIgrAWjV+zNN6xAkbZ1TUqm3c+Nx6f2BdX/L4HNmEZOCaMINMiQYpbBlprtGDY1r4x2A6FyBuEOm48L/fG1icfb+e6Xpv1rGa9a3b5/hWaQH854niTdys8k8N5C8oEEbvI+/WaLG2MW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493325; c=relaxed/simple;
	bh=F2p8WzjOy+iH1uiJAkloS7IdMrZcLiGtKBNhmNZ5vxY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXh23A3+wnYfxaFkK9RXmHVdeYUpluvZ5QVDKRZmgmf7RK7RCEJm3BU1lkctgabM5QxkbYvr99+ho8E++Wzr9hK0H95XtxmHlOf8wseR7hvvPnfhNfGIqA/oVHNmNtRy/q/Yx5WwZJhzH8bjRW67CYSRLlfv9o3cWYO5lutBoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxxPjn8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE3C4CEE7;
	Sun, 26 Oct 2025 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761493324;
	bh=F2p8WzjOy+iH1uiJAkloS7IdMrZcLiGtKBNhmNZ5vxY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=JxxPjn8QlXiQwD4WVG/2eE8YIFjQAlYJ2rcyEC0OOftMDo+uJGZdSZ6UANi0QeuKA
	 2yVhZaIYViUZTA6N6oYxkQCF+IcTIejSg4K9pjldeAF7Ht2dZdqeM/f4nRe5c/pJWt
	 Za5lODk/4uhiAcSQ7Kqem2hm7bAmldkikUPhEYB/LIw+F9wkeWoiubIehQRtsTGjXs
	 JHsMLejYuDaSh3j8tS17I5BAQ7gjLB+FPJ4Pm4oYO5uQqGcjf0XwTvIHe+eZ4T9LF8
	 oZ3e/ARuLMRt4tnXAGWSEuNCPU7Z9qaN5u7aFSOZSInNtwH3Tf9Lc8ijLfsg7D8RnZ
	 ieikp1Xrgddsw==
Date: Mon, 27 Oct 2025 00:42:00 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 6.6.y] gpio: idio-16: Define fixed direction of the GPIO
 lines
Message-ID: <aP5BSHnMw3Bn10vD@emerald>
References: <2025102619-plaster-sitting-ed2e@gregkh>
 <N8Hj-zRacZQc6SSWrj2lLT1upcInj9PrAH81Xc2M4mozVsSUj92ofp9fJOsPqS22yl_CdmdkM1Phj5z86hNpdg==@protonmail.internalid>
 <20251026152950.44505-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WuZxbwSFlSIHlS5x"
Content-Disposition: inline
In-Reply-To: <20251026152950.44505-1-wbg@kernel.org>


--WuZxbwSFlSIHlS5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:29:43AM +0900, William Breathitt Gray wrote:
> The direction of the IDIO-16 GPIO lines is fixed with the first 16 lines
> as output and the remaining 16 lines as input. Set the gpio_config
> fixed_direction_output member to represent the fixed direction of the
> GPIO lines.
>=20
> Fixes: db02247827ef ("gpio: idio-16: Migrate to the regmap API")
> Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nu=
tanix.com
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fixed_d=
irection_output configuration parameter
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/r/20251020-fix-gpio-idio-16-regmap-v2-3-ebe=
b50e93c33@kernel.org
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> (cherry picked from commit 2ba5772e530f73eb847fb96ce6c4017894869552)
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>

Sorry, I didn't mean to send this. I don't think this will compile
without backporting the dependencies.

William Breathitt Gray

--WuZxbwSFlSIHlS5x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaP5BSAAKCRC1SFbKvhIj
K/4JAQCPk7xw1LCyvU71WmmNQvcRFmEvMUljRsc3RuaLbHK0UAEA2UIGslFpbcKq
t+WJm4sJKPt8UrewAaTJnHBkTJ2sPwM=
=oj8M
-----END PGP SIGNATURE-----

--WuZxbwSFlSIHlS5x--

