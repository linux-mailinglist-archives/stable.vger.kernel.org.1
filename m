Return-Path: <stable+bounces-81307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD8992DEC
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979D1B20D7D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9661D5ABE;
	Mon,  7 Oct 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxcxUGoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A01D54EE;
	Mon,  7 Oct 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309323; cv=none; b=Q/skO1eh5kqKEO6uHF7hxhzKbVsb0J7Hp/emsGhslvhTMLoQv1YHHkdof1uRtNxzURJ0Y/6hEJVCPGw6MlCJDADXjSjC6R8P/zNeuHrfJvC6q3yAPKDrlCdMMoKpIuH8iTK7w2zXIEOxlHVPxTPcBhmiVhUL6J4mhV2HlN7L4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309323; c=relaxed/simple;
	bh=jV7RkNNOAmSp1W66uhPjFkMmdnAxUOyJwhAUXaxvnhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhXNRa2b8AJmLNQDp9pdXEf9nb/yTMi85mCD1MxBWKFKuFGNuALSNiQbTN/mX5g9tY03wmY7/S9RiuWLFD1i5MsW41NcauY7V5krE7ESHJBjB0OEOfXuBb33VXSBLbvXIIQUGIch/FfLhl8+5ScMApXvnuxRs9UVzTM/a+zAVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxcxUGoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B405C4CED7;
	Mon,  7 Oct 2024 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728309323;
	bh=jV7RkNNOAmSp1W66uhPjFkMmdnAxUOyJwhAUXaxvnhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxcxUGoYJ29XLZVgvWMR4vtOIUfu8mmrfjqWCL/LiFMZsUw6XMR3qXSO/6ZYaJCGO
	 oarmLQsFT0/SLMIz84O6myrMHESfLFWmv8WnltmdWAqoovTcqlTolnrZXcNjn4MxFe
	 YhRmxJ4d0DgEvLL3TDvXEFc0Bx6Hop/z7DjZ29Vkja2WmrPaIZ4aslrmVvNXmhNEtx
	 ThT/4+DsKpnfUmQAB+tqdoeWTJGGsbXcKwNhiQjTHM793fJG0aPyEUesJSji+gnTV1
	 OsJomxMg5crABM0v3dISP3g9oCJJbnNglYijylBjA9mX8PhaoiIg+geKCTdEAyRk6p
	 4ULbvv0zSLBGg==
Date: Mon, 7 Oct 2024 14:55:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Benjamin Bara <bbara93@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-sound@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benjamin Bara <benjamin.bara@skidata.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ASoC: tegra: machine: Handle component name
 prefix"
Message-ID: <ZwPoO5hYiB3ev-ml@finisterre.sirena.org.uk>
References: <20241007-tegra-dapm-v1-1-bede7983fa76@skidata.com>
 <32040b21-370f-44af-b1fe-bd625bc3fd9d@linaro.org>
 <CAJpcXm7252KSGdkASJq-GpZPUKnmxL9o3raNJL-QjkL67Pd+OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rfsTlN80Gow+oO9v"
Content-Disposition: inline
In-Reply-To: <CAJpcXm7252KSGdkASJq-GpZPUKnmxL9o3raNJL-QjkL67Pd+OQ@mail.gmail.com>
X-Cookie: Editing is a rewording activity.


--rfsTlN80Gow+oO9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2024 at 03:17:45PM +0200, Benjamin Bara wrote:

> Instead of reverting, we could probably also rewrite
> snd_soc_dapm_widget_name_cmp() to directly use dapm->component, instead
> of using snd_soc_dapm_to_component(). In this case, we can explicitly
> check for a NULL and skip the prefix check - not sure why it currently
> is implemented this way.

> I think fixing snd_soc_dapm_widget_name_cmp() to be able to handle all
> cases might be the better option, what do you think?

Yes, I think that makes sense.

--rfsTlN80Gow+oO9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcD6DoACgkQJNaLcl1U
h9BgUQf/dMB6IM/qORov7dwmlk1NGy30tvrrrgUxwEFMZihx0n5vJ0mZRCNuNS4V
ODVv/lXQ99BrJK5YrVMpM8XK+a83t6Z6vWQKAqvehGJBIZE5GQVWKZsbzDvRfc4M
oSinOs5v5oFx2EVXY6l4Tijg5PoAtq5sjdCrDxDZ5r/y0UQbUjmVTJNiZkeI6h+j
nD1mStsvYmaXLa75AkzDxlFjMp3oGjvrmfeqDb7XJlK3IwefQufItWQY39x2NJDK
dvYGfZJYIP8qADyyVUQBJHYCS7mnSbc0VaCWwszhEC1UZoFqco7dKpT0LY9+365s
hh0z1MhnVvGtKHuaCDRfVUE8I/fhng==
=qsqs
-----END PGP SIGNATURE-----

--rfsTlN80Gow+oO9v--

