Return-Path: <stable+bounces-183044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC1BB3FBC
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D41924104
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F73112D1;
	Thu,  2 Oct 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjod9zaE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7629ACC5;
	Thu,  2 Oct 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410508; cv=none; b=J88R1D35ad7EwfY7gXLsxVQUHjQdNatT7tvGyIvrHzLjxuPkmL6r9YFk/xvH0DQTjHMVqXv0hIu0wAochrr/5uVSFIRVii8N5RNZmRwB3hC0DIfPQMxnXbMTyYbpqhKelwfzNkhmXinRt5l7pSiEGgmoQgP1f9yDLDVOSnrTu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410508; c=relaxed/simple;
	bh=nFup604wJ6ctYtX8WMeuHk5l/OZtf4clDP1sLB+YL2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYYOgm/awldJEIucq86Z2jXtt44xdjZhKXbYz1x7wfUbx3zwHA7O0MYivTtDTspGDO5SapNZFJwXX1SO/toT5qyW/mmnHVnLZk5ewe3JJC3roCY80a5mLkDIOXYH1FlN2czYg5k1slH8G8SmCrBPyWLwVAMGHTzGZ8RS1/yiNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tjod9zaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8914CC4CEF4;
	Thu,  2 Oct 2025 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759410508;
	bh=nFup604wJ6ctYtX8WMeuHk5l/OZtf4clDP1sLB+YL2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tjod9zaERYbbrHX55qzPCTeLR2BuK7d9etthX1A+urbKAhJQGaAR1wJcHuzj1XmG9
	 +lQs6hZWuLT9x8JlTyNq+ZcmtR0VF5BUJNnv+8sCd1ApR47AnCHLmJJjJeFC9ulCzu
	 P0pmQdxVKLNglMe4Hp0Oy5/SlsQ2n8XoUh3dOgsxsR5wKIQ/97bh64x03erevV5+oc
	 klhMPm3AuysS3iUk/OVc3MeYpsJo8QH7pmXB1H4oC2gxHm511SwQBEafldH0y4lAyF
	 lDWYn9iMgZTjNv2AAhgLEtMLTIjENCqYT01GYIZEy6ZTRg3lOt0uuJ4FffXD4QRjgc
	 IY7SkEOztA4NQ==
Date: Thu, 2 Oct 2025 14:08:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer
 constraint
Message-ID: <03e9d232-a0b3-4ed0-9832-d07068003553@sirena.org.uk>
References: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="38A+ot4msbnqlJ69"
Content-Disposition: inline
In-Reply-To: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
X-Cookie: idleness, n.:


--38A+ot4msbnqlJ69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 02, 2025 at 03:53:19PM +0300, Peter Ujfalusi wrote:

> Changes since v1:
> - SHAs for Fixes tag corrected (sorry)

Still some issues:

Commit: 7cea6ea9f99c ("ASoC: SOF: Intel: hda-pcm: Place the constraint on period time instead of buffer time")
	Fixes tag: Fixes: 842bb8b62cc6 ("ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint")
	Has these problem(s):
		- Subject does not match target commit subject
		  Just use
			git log -1 --format='Fixes: %h ("%s")'

--38A+ot4msbnqlJ69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjeeUYACgkQJNaLcl1U
h9An7Qf9GaVg75va89unD4vsNunmKtTjyig6w/GAF5ao1ooEabhIGHBO46aV5vZh
h368NNwOgCvnT3npkwJ7o1Ovui66KNH+yr5NqxhKt9IYG0EXIQD1uB3aY8xwc6qc
WszLnuYWXT4r272b5NcW2HpCP7GfCxfPUqskg6Bgr6R2FrSllpv6gxzbJE4u30MW
GNMUw0JprZpPh6CTLWrWu9EoeNqP8+35lF8pjn2ZMyINl9lTd9qRmqWtX+Ufsu3z
Dcy6L4M84CJxBWfgMuITtCNP91fIbnqQ0FpJbzmS/Hwv32IAZa1hvdwJbR4vxTDx
TbkzRWh2ZmBhYHoXrFNq9EPtpdmNkQ==
=mTLp
-----END PGP SIGNATURE-----

--38A+ot4msbnqlJ69--

