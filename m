Return-Path: <stable+bounces-104335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860E9F3086
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124E11884F34
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C3204598;
	Mon, 16 Dec 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaTV6TNf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC23A48;
	Mon, 16 Dec 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352228; cv=none; b=jA1BHUU6PYufyPo3LHtTtgqDd1Wz9bwuOGpH8D0JZcugHFId/zoduzo1Q2uCBHlHQjLJi/xW+phjSnl+LSJrv83bsvak1j2Pp7lP2reOT0uQ0ELVcw3E7iF6Wv2CTNsNM8FXfoeX7y/DOuVSWAfZH3b1wFHbmrSxd/682J6/fa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352228; c=relaxed/simple;
	bh=A1C0At4Oiotm/yCMHmHhdhIhCKiYDb3s50VMiteOvAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIwVOiMWu7kv/04dVvjZAfB75gNcNpG2smN+Lhk+PpJvzqBMLsrW4RzNvO5046Bopqt11rQZCwUecLy3kn05C+Tm1Q17ZA0CB2HesMHpbeTKHJ3rEhRB9ADHHAJEMiEL6ARpZ21VnJHZYYmRXXXinY4bsW8SsTF+RoETz769RrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaTV6TNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34FCC4CED0;
	Mon, 16 Dec 2024 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734352227;
	bh=A1C0At4Oiotm/yCMHmHhdhIhCKiYDb3s50VMiteOvAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CaTV6TNfEwIbvVdE5Se79w2UEbp8N64S/8Zr3L/tj5x1DfaYhB4Hf/jL1GWNFtBOI
	 kUDn4L/BEVDU6xb4YIOdyIc804YQCt6rVlBPaZS1NKnFPLZe5Y9RVu3hdSrB9F65Fp
	 tTyjbAPJS8iM+Mu0kcMZfUX23nbKOxaHM9DPigCnjB5NkHwrfkMZGWRhhXqTkGePXd
	 RK21UnEIdqyj/ZApnfB6RUZAutmutLYWsR0jCxrbPPmcT0aEbC0nBVGwHVTkRS2yF+
	 tVd4+lycOxWTm8dWyTOy+CXr+v+FqluSgBxK7SVUp4x33OcvR4VWkTbStL1r7rOnIZ
	 hdBQ/QNlKNIsg==
Date: Mon, 16 Dec 2024 12:30:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org, cujomalainey@chromium.org,
	daniel.baluta@nxp.com
Subject: Re: [PATCH 1/2] ASoC: SOF: stream-ipc: Check for cstream nullity in
 sof_ipc_msg_data()
Message-ID: <2954b9b5-5264-4fc2-92aa-0eb3e7002a29@sirena.org.uk>
References: <20241213131318.19481-1-peter.ujfalusi@linux.intel.com>
 <20241213131318.19481-2-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YVXMs2uj6/3eSm9g"
Content-Disposition: inline
In-Reply-To: <20241213131318.19481-2-peter.ujfalusi@linux.intel.com>
X-Cookie: The time is right to make new friends.


--YVXMs2uj6/3eSm9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2024 at 03:13:17PM +0200, Peter Ujfalusi wrote:

> Fixes: ef8ba9f79953 ("ASoC: SOF: Add support for compress API for stream data/offset")
> Cc: stable@vger.kernel.org

This commit doesn't exist.

--YVXMs2uj6/3eSm9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdgHV4ACgkQJNaLcl1U
h9CfeQf9FEYx5I3PvjtP6Rm7kRrNk1lRKc0CpAwNanJ4LSl3jwagPlBnDJCOCvFM
os6cG6M6qN/S0+z8doZWlMv8I9LdFKs5WVoUZRYTlf2xrfC91j3ZqnItMFit92qO
QPZwWbguu95zq24KYMmGtorOIUU18vitU8QaS+3aJokvjVFABJpMZW0SVD439qhA
WSHtLCRSE/Cglezra2XfEDS+JijmQ7iKVugDJCzJnWxyudFrGxR5CQ4wFfv579Pe
lTYnyFSooJ9uCNLsRLRj4pD0FRNtTUacD0wuSA2TAUoYE6E5iQdmetQWUmPZw/uG
bU0YfjxCrXqX1f4tmVEuFj11HWT1fQ==
=WJo7
-----END PGP SIGNATURE-----

--YVXMs2uj6/3eSm9g--

