Return-Path: <stable+bounces-202805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE87CC78A0
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 388E63019F8C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA8336EE0;
	Wed, 17 Dec 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+lf4zaY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077D341AC6;
	Wed, 17 Dec 2025 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973769; cv=none; b=CgOiSRhzVj/jaMVsWH5mkZdK/hEaaTmIkLp4jGslFp0KTjgR7/e5HK1ey+MGiEM9nrtT2LEo+UGUue+qpzY3Yr5g6N5HGlJcfz6OjODWtd/gaiYtZA25vU+YEowPHDspqvL3loSaDZ8ntEI/OItpli+PUg5CHUvsmE02F+izS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973769; c=relaxed/simple;
	bh=noHwwSpl/AShA1DcmQrgTxII60kTnAFGCPaZVPRuRZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6wd0h+XiR9D0Xh5gvaoaB2hfYdZV40Rc65rbFZLf0KenVczp2SDH6IuGjET/xkezZtF7Z2URwkDWsE45AbuBoK/v4m0quxoBFuNpEvyfCZ1uvxFBm5BXln2BxX4FkE+JEH7TWARjL8KyCOj8Pw8H3I8HOyI8dyEKR4+jrbJA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+lf4zaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E589EC113D0;
	Wed, 17 Dec 2025 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765973769;
	bh=noHwwSpl/AShA1DcmQrgTxII60kTnAFGCPaZVPRuRZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+lf4zaY03jTiH6OfTWiskdstB5shRdU9r6rbsokwHqHQOugaTU60Ox0hPnbdf7ET
	 YsW45u5Mqlb5xERzyjNUYfvBYVBrbWyiMWKqq5tEMY3v5yzcwG1aUhfyc9yMbUnfmV
	 hDyD8xRZ5lZEAqI3gE7rdmLI6xxA6bVQFMMI8ixz/X86PE6c3ZG+8OHvqDlRp8GzsG
	 ZCKNNfMZ5Py4ImwysjY3EvfwLJn1JJCfrSjy/NXDUXZ5FNKeMgSedMxmTK8fSB0l7h
	 RMa7ERC8E5o3Yan56TlelhwXA4QMyRt+Q2cQh8sYBgBy1zxPehwA27ptZk7bsSIzQD
	 +piTKdomuE1+A==
Date: Wed, 17 Dec 2025 12:16:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org, niranjan.hy@ti.com,
	ckeepax@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y+e0Fv7/ZGUo4QCN"
Content-Disposition: inline
In-Reply-To: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
X-Cookie: To err is human, to moo bovine.


--Y+e0Fv7/ZGUo4QCN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
> In 'normal' controls the mc->min is the minimum value the register can
> have, the mc->max is the maximum (the steps between are max - min).

Have you seen:

  https://lore.kernel.org/r/20251216134938.788625-1-sbinding@opensource.cirrus.com

--Y+e0Fv7/ZGUo4QCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCnwQACgkQJNaLcl1U
h9DRaAf/RxawVmbYat1UDdfJHg2z6GvC+41Zl7OJajVe6qeIj2suBo9X6o4cPoa+
tWmuhQJpjElPLhOAtcugAMBjIfFRsBYY9Ypgf7CIYxot4Tlga8eUMRq3OWdRNAGt
cK5lQtfDDqFfOuT/R8c9OeMDjr6mD3GgffowmE3lcUKwpoPU/OCh1LiuAOWzPDDp
iqhph7RqlrN39P8smJze+271PEpgYQJOJtawPdIGSjU4RVvzfxtsmMNn1vvFFadF
a5fymt1znG/C0GA/mg5OFpJoegpS4/ZWXM6ZHPtvLIS4mKjeZ7pNBABB5Hgp8pdm
5byQbP0yhh6y/OQ56AZJE+eMJLk+nA==
=aDGK
-----END PGP SIGNATURE-----

--Y+e0Fv7/ZGUo4QCN--

