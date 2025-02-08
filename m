Return-Path: <stable+bounces-114352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB92A2D21A
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 01:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266AF163166
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 00:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6014F90;
	Sat,  8 Feb 2025 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcgXwlcj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AA2941C
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974457; cv=none; b=jYHje2KS4k8bJNBgc9Ng/7/rfhZIj7OON1OKriOnju0/5KfZxNRJHdNKF52r+uqYKv+cKhH0xGTgSkAAaZwbXb5x6OncXyq4609FezT6nbtTqpzjBswjyFAd9h/b3JsqOt79PoJ4ROXdNTrwbOTlTvNKfgAj3DTiZcxt3Nb0kww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974457; c=relaxed/simple;
	bh=Pd6p828bSrgUBsLYHLO0l6fA2GCvXk45GZXKWpT9RT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRbfT/1xsWPneH4hL5z01f8mfZ4AC/7boUwtpEfhLvOAqFfgNE/7Cv9LzlNW17pmwwcNFPwV1f6Od5o0i/lB04FIX5Y2u/ECP3daxVt+hxA5KJyeORAVkKkN6XV+gfoxUFCwwTwn60sWahUMCB/9lUT7dItcMoQo6wmx2Q0d5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcgXwlcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DAFC4CED1;
	Sat,  8 Feb 2025 00:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738974457;
	bh=Pd6p828bSrgUBsLYHLO0l6fA2GCvXk45GZXKWpT9RT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcgXwlcjSLAoTetHiGu3YHKqCGNe9hr7v7zg9qpCCjJEjyf8Pv3IiU+XkFGdOj+F/
	 gNX+zeDaTWK3Cs3jN+Qsscme6uVtXbKeZzBfNt7bzS0D8gR+tdVWViekpimeG91WF9
	 YUWLZ5BjcCxFmevyklNxObuUMzTe8uwViOFvxoFWAmNtNj0mzBADW0a1nsPCaoq2rL
	 imkHwdVy2UG7nAjkeS72zCPqa1ohKxAVCbaWGksPObtuSLIpJRqK//5cnpAnmph/NW
	 xbFZRRQDUPOgP7WpwT3Y5xtN0f+TpRHGfdVwYTD3CkHCiTrrqEc/KY6Bsz7xnryfOp
	 31rE8PbWbUG3g==
Date: Sat, 8 Feb 2025 00:27:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, eric.auger@redhat.com, fweimer@redhat.com,
	jeremy.linton@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	pbonzini@redhat.com, stable@vger.kernel.org, tabba@google.com,
	wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH v2 0/8] KVM: arm64: FPSIMD/SVE/SME fixes
Message-ID: <86bbd845-88ca-45b8-afab-ba9cdb5c4251@sirena.org.uk>
References: <20250206141102.954688-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vz9haEtBNxzRquF/"
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-1-mark.rutland@arm.com>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--vz9haEtBNxzRquF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2025 at 02:10:54PM +0000, Mark Rutland wrote:
> These patches fix some issues with the way KVM manages FPSIMD/SVE/SME
> state. The series supersedes my earlier attempt at fixing the host SVE
> state corruption issue:

...

> Patch 8 addresses some mismanagement of ZCR_EL{1,2} which can result in
> the host VMM unexpectedly receiving a SIGKILL. To fix this, we eagerly
> switch ZCR_EL{1,2} at guest<->host transitions, as discussed on another
> series:

>   https://lore.kernel.org/linux-arm-kernel/Z4pAMaEYvdLpmbg2@J2N7QTR9R3/
>   https://lore.kernel.org/linux-arm-kernel/86o6zzukwr.wl-maz@kernel.org/
>   https://lore.kernel.org/linux-arm-kernel/Z5Dc-WMu2azhTuMn@J2N7QTR9R3/

> The end result is that KVM loses ~100 lines of code, and becomes a bit
> simpler to reason about.

Quite a bit, and much more clearly too which makes the whole thing more
managable and discoverable.

Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>

although I'm not sure I was actually testing anything you weren't.

--vz9haEtBNxzRquF/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmempPMACgkQJNaLcl1U
h9DUhwf6A1DeWBTOC1O2eefDkj8XCv2tCHQrKzXs1jeJkv4IQkF+v4/yWxV6G+3y
ADDI126dh6Dd70D1eURA3BwGTe6l9Fdh6YI4IA0BVLuKYYE8eOuJtjgrey+GjVti
BXy6LIQMJ3X087tssrHifs0tfqPXZd4EI5mnfJMxEAvyoNCulJvygBXWN2OGQsQY
xfrBA+vBuRlaJqZGJThf1+bDFZ63MwbsF4pB5Q2Ohfa3nI0RMXSgXDN5vlqrjOKJ
ETfg4YJ5JAt7+yrDgdXNX5Yu2UiSOppNaa9O2KABQ/l/Q6cu/knzx6isGINn3XDq
OlUrX9z5c85lZonDi8bKt1BpIHRg9A==
=d+qy
-----END PGP SIGNATURE-----

--vz9haEtBNxzRquF/--

