Return-Path: <stable+bounces-104043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED469F0D07
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F592283411
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E91DFDBF;
	Fri, 13 Dec 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPDwzIJF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F51B3922;
	Fri, 13 Dec 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095411; cv=none; b=o5P/CBk6gSeEm74Bfq12jEjpMh1EcC9usZarjKv4dzCCiVWmpQ9u6IqQWvYmSk5wVif2oZcekA0+vO7QVkPKgHvJng/C9OAblQfIS4E/52cZqO/ewA3q6cGcI0f2QD4SKEj4N2ZnR9dbA+NyaP/87i9Tu7/BrQJrLHjC3znVSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095411; c=relaxed/simple;
	bh=U6BwHfVIUDcT5Nf5j5pi+oKmf1cI+0Bhd7NjPB5AaCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9gxeQVCkB8fzoCmrBFt6+aiHHd5OOMChhD2B16AlOeLIrxhhtXYmXB0+i9cPDSdpVs4Ljcf4Crak9Z2JlQPvdABtFf/WDLsf5v2RxUbDI/0igNowjT9aBxulWbrOg9nwGzBveCQBkWOkTvkQaR190VU/7TvU7qqsFam0DCsugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPDwzIJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4493CC4CED0;
	Fri, 13 Dec 2024 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734095411;
	bh=U6BwHfVIUDcT5Nf5j5pi+oKmf1cI+0Bhd7NjPB5AaCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPDwzIJFZvrCYF2FH4qFNo+Is1axdfbY+9Ko42nvfcGMCBOuJYOrQkC3VTDMN1NpK
	 rYnITfWbOnyGH+l5kaWSy8veduTc/LQ1bA+0Vl5AGDU47o+UArTl8tIhPsdRS2AcZE
	 8cUsgqvkxVW4v9g9mqpTwmFsQb2gCPE2SDuwxHXB11RjNl9rLt7Ev2KOEZMJSkLts8
	 CJVPkb5o6h06ss/OJ8UUDuQzxmDRBXxBJ9Scdk4FM5DDVR0id9JJpfXwFCMqs4Ubys
	 lD7OD6s9AeRXinxIg6MPLa5SUyItNH3Sj+KVx1O4adpPscyBQqMDlDjXL4w8VqJd6R
	 xSm6YYhhjKVdA==
Date: Fri, 13 Dec 2024 13:10:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org, liam.r.girdwood@intel.com
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: Harden loops for looking up
 ALH copiers
Message-ID: <5b518c79-556e-4ea0-b660-9070b4b5117d@sirena.org.uk>
References: <20241213100146.19224-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbWl8P2/hr0tRaMz"
Content-Disposition: inline
In-Reply-To: <20241213100146.19224-1-peter.ujfalusi@linux.intel.com>
X-Cookie: Not for human consumption.


--fbWl8P2/hr0tRaMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2024 at 12:01:46PM +0200, Peter Ujfalusi wrote:

> Fixes: 0e357b529053 ("ASoC: SOF: ipc4-topology: add SoundWire/ALH aggregation support")

This commit is not in mainline.

--fbWl8P2/hr0tRaMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdcMi0ACgkQJNaLcl1U
h9CjaQf7BhMLye7dSAIQ/ISnmewBmiqgyUKx1nk527iHBi+KZXgNxzopq4mH12r6
NJGzTvj+qmSemiBedx7gJIqiB2zpJHgZxJPV7tcwQXvHS8MPc5PIzLxf5172QSAZ
R8mTGQMS0z50bR04CW0dTUcTCHWbXdmOySAcQjUxWJSXcUhJF5lgYwCekpTtPQKk
NQ7Iyv8FcCoC/kvCDzn7XqsAQk22CFHeLBE/8oIiVPDhm9S+evA+ipC6w1RYpwXP
Ox5p0IJZ+PT4Qz8S0LtENTJgp47lEN8rU1GV2zvN1lC+AhxKqL35ZdXMDW7Q7cCb
hu0a1QzqIjpvbNhvOZoJ8vPVCIwquA==
=/G6g
-----END PGP SIGNATURE-----

--fbWl8P2/hr0tRaMz--

