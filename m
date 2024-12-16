Return-Path: <stable+bounces-104336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E669F3087
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA831884FDD
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC420458F;
	Mon, 16 Dec 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8W6dTX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3FA48;
	Mon, 16 Dec 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352246; cv=none; b=NZguWEfN4ZVklXlVPOQ8NeX3bcJT22UVnGGEZGqJDE+Ge+3IlLkhIBtq6Op6aiqEQANlWhzXPjMKf1ENLFFd+UFGfoL7ZfCUqD4+kVwyzIhI+uTjzZm2YR96KTfqypqO0UivagEphbSEToSQewvTLOWupJYjP5m0fartKEfMSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352246; c=relaxed/simple;
	bh=yenvbT4cDd1gDCQkr27bcH7hYxZfbk9GjJC9ICkF2lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfeEmzlzIjmjqZ97EO9cTgPEJarcmHYFuKeB7guS9tRKTrbgB4YRfFfDQfgbDVytiCZZczP19qUEyMSHqMJHJEDF2a0ORB5hTSol6fxmqNGsbkQMLkOnabvoi9O610WM9uqIlRAjFsmwryzrwefe0sNvBOvdv5XgJVsMi+GxpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8W6dTX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE88C4CED0;
	Mon, 16 Dec 2024 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734352246;
	bh=yenvbT4cDd1gDCQkr27bcH7hYxZfbk9GjJC9ICkF2lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8W6dTX1oMpD2DKmxHCQZedZLmA3yVcfv/CufcE4+ILGEzEEWCMzHu+2hHfKQ5atm
	 uEx6G3QNYI96ngqTDLVdOVzpmxqpU2K3S9UOY3Q9IJ4MfTcn9nhiPTFXSr9DstpVW8
	 VAEHTcDYkaKO+RJvs+M1dhFS3bIJcrHGDn2IOR9IwNluE3viRukQClrGtP6RLATYdn
	 WaIJm8QH4FImIR8U8pe52LSjNN0yW2dEmgN41++l3GaQNBhi4issJlmDB6DkOOmxuD
	 tAuJs3P/JxvVYijlSQVlUD+sz22wHL4fcCb3mHVEtEpEKkqOs3w2qg4aauzImbdygb
	 DHLwyNapHeT4A==
Date: Mon, 16 Dec 2024 12:30:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org, cujomalainey@chromium.org,
	daniel.baluta@nxp.com
Subject: Re: [PATCH 2/2] ASoC: SOF: pcm: Clear the susbstream pointer to NULL
 on close
Message-ID: <fcba714e-7450-40b2-a681-81a214ac3c5d@sirena.org.uk>
References: <20241213131318.19481-1-peter.ujfalusi@linux.intel.com>
 <20241213131318.19481-3-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NtZsY+wPFqvUjoRU"
Content-Disposition: inline
In-Reply-To: <20241213131318.19481-3-peter.ujfalusi@linux.intel.com>
X-Cookie: The time is right to make new friends.


--NtZsY+wPFqvUjoRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2024 at 03:13:18PM +0200, Peter Ujfalusi wrote:

> Fixes: ef8ba9f79953 ("ASoC: SOF: Add support for compress API for stream data/offset")
> Cc: stable@vger.kernel.org

This commit doesn't exist.

--NtZsY+wPFqvUjoRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdgHXAACgkQJNaLcl1U
h9CTPQf+JLT+GKaH7iFOMhvkY3cHH3KsV5iVyu54F1tsO39/6gBf44B4OtkbWq2V
Y+++wkhZmCs3s4S0uRIYQ6B2Ki/A8yBOcRKsksR7kNNu9QN/sQcwfJzNodjgwdU2
/mZJMks8h3Br0kWNpwWunLdZkuykVlztJFAUUZcu8q/eHZjlay+SfKKwI8bfEDt2
zN7zgbLEh3+NBbMNEV/Xm7nZvlSwVE1CWpSMhxTvKfTtyY8ds8dpoZYJ865EDRb8
0E2lDD94nX3QuqbK7JOptMxiEyzjvC3t8461xOt4/yDR4o8vGmPNbvK/KClWb5No
1ddlZBJe7hGIpoRXDwKAtN9Y7jKgYA==
=rVxh
-----END PGP SIGNATURE-----

--NtZsY+wPFqvUjoRU--

