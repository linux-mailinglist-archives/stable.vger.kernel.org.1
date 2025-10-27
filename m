Return-Path: <stable+bounces-189915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFDCC0BFD9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A953B8992
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D621A436;
	Mon, 27 Oct 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohwOfMqd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462F1BC5C
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547735; cv=none; b=ku7dsO8cvEgBsaDwXoNoLIkLNqPzJGDpc/6xMXBJ7UEq3i8Yrx2RvLR1JxVxIiY8iUuuiHQnzbmhxF5V7ltBlqwmdz70zu2LHsqMD4yI6jRC7zLxBNAYmx6Cls5I73fmO6WNkKK3ePSB+0jpCcKfdIDbgscuMyyBF1ze+hWky4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547735; c=relaxed/simple;
	bh=NLLsjx1OCCetT3hR87FOnG408Jn6EFeueUQOq7qNNoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMyemcbiynONccAiQbCg93S7yJtiXCWMrq1FhOJhJOHt4nVBSZh2fkIb3svsEmEwpOWdWIN6rcikJPhsx5t0kzBNoyv8Dap0YNM13mtbBaL5QVgVneP/8U9wJT0+Oix8bwZr8Uf52UysnfDSlt1ZIuJmm2qmD9fJT2zFwqzHE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohwOfMqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB530C4CEF1;
	Mon, 27 Oct 2025 06:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761547735;
	bh=NLLsjx1OCCetT3hR87FOnG408Jn6EFeueUQOq7qNNoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohwOfMqdogP4LIkEtZaJbtoUQtYiGi/qUEoEJU780gCDwGtjl2Diy9Ak0BKMhdHvZ
	 iIsQdezqPLboxqUe3NmuLqhhL/KqPj7RyEttMYb3lp7rcGsL2NAWe3Qb5Zcdjcm51R
	 Pv5QO4gEMh8bRdV+in/JDswWOoyJHpADtfMb0x4Nmwgivzc1sQrn/j5UeqIT6eH3EK
	 HKmHopmuRIQsYu+k8435urR1OeiJSluADWmVM6PP93Ny8UzlQ+yWafkwXJ065aM25s
	 TFc485CmyFp51dI+mCCORC49/6iC2Xe2khiIm9aXakhgMt9XSlO79PAip3FQ+leUkA
	 EIWkDsLZuLdGA==
Date: Mon, 27 Oct 2025 15:48:51 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 6.12.y] gpio: idio-16: Define fixed direction of the GPIO
 lines
Message-ID: <aP8V0_cilsbqV5NB@emerald>
References: <2025102619-shortage-tabby-5157@gregkh>
 <y6CbxD9XMYi3hIoSOmL92fq5cqnS3I7Wy_HKKw6PEQt95s8fqFYkeIuUGOlQ0bnyTgf7LcHL3BwrW5CnbdLQvg==@protonmail.internalid>
 <20251026225104.272662-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iBSPh862bDNDhsqJ"
Content-Disposition: inline
In-Reply-To: <20251026225104.272662-1-sashal@kernel.org>


--iBSPh862bDNDhsqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 06:51:03PM -0400, Sasha Levin wrote:
> From: William Breathitt Gray <wbg@kernel.org>
>=20
> [ Upstream commit 2ba5772e530f73eb847fb96ce6c4017894869552 ]
>=20
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

The sha1 is incorrect for this prerequisite. It should be upstream
commit 00aaae60faf554c27c95e93d47f200a93ff266ef.

William Breathitt Gray

--iBSPh862bDNDhsqJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaP8V0wAKCRC1SFbKvhIj
KyyPAQDG7zoZmTvAKOHF+U3X6t3P3Kv0bF/UXa5ZdBOsMNNaDAD9H6kgqxHh9G7x
2jfw3GY7I2uy6u7sFhzEO2+Rhj0zaw0=
=hzKV
-----END PGP SIGNATURE-----

--iBSPh862bDNDhsqJ--

