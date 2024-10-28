Return-Path: <stable+bounces-89062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A089B2FE5
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205F2B23AD6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517401D86ED;
	Mon, 28 Oct 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTA10aeL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2A1D86DC;
	Mon, 28 Oct 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117524; cv=none; b=CpTSqwPCAIwx+9aUvdjzZtkOrapSZDnZv7Opbu2Fu9svJSPfhOOCkrM5pm9JqkDSjmfC3z2xAjq+IUeM1fnKbpGaVNrss44dVLGS6Qgz+qmr0ETiCpcFLxq3Xi+DAjKF8jhb1bJTcyfllsn9W9kXHTnJUUwL90GIyWkvAqPkQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117524; c=relaxed/simple;
	bh=NAZkhhTeYWBcCRnnAZH+eZCWBsmCMSLDc9mRceexjgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVLUDhNxgnBNhi4mfDSH4lu4yX3XaRxbcv5O6KqJZdXCF99aUlO2BnAwfKLx7opD5EZCAj0d7slPmo7IbYI/rfckl4ScAPs+BMk/N/5+GrTZfPGbI5uBDLcnTYS6pV4NN7wYQe/AjSCfBaF3r0/Ro5aJ+azRArYDv1Llb3bqVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTA10aeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB9FC4CEC3;
	Mon, 28 Oct 2024 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730117523;
	bh=NAZkhhTeYWBcCRnnAZH+eZCWBsmCMSLDc9mRceexjgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTA10aeL4xtGd63PUIPx4KhhP7HDf7HveJCfWaAvK3qMB3bC8jLKkEhFESanGKbGf
	 uhuDju3v8m3q6ieocv7/yEBPF18Cm83bCKgYPTn2qye5/6F6nwYL+lAxM0hDQ1du8V
	 Dh/ZPyGjrWiPXyKtiTxIol4e2/k0WxJX+/8AtT6n40dTRWQ6cmbQyboWn5RSmZglPA
	 IbMxrtYqDvMPSdSB2BvEZtP6NHs/n63XsT/dRKP97i6mPmFZuEeHcDLhqQx9yYFICM
	 PkHz47nn0gx8oL6zQVXRROwud3Sjg/7pm75NIrx5uhJzzS+wGzJ9liRCwrMSQ+e+/y
	 8X53OSDt6bqxw==
Date: Mon, 28 Oct 2024 12:11:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH AUTOSEL 6.11 05/32] ASoC: fsl_esai: change dev_warn to
 dev_dbg in irq handler
Message-ID: <1ad8216d-c24d-4d35-9562-4106e2aafa34@sirena.org.uk>
References: <20241028105050.3559169-1-sashal@kernel.org>
 <20241028105050.3559169-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jw04mRIq6Tcvx3ro"
Content-Disposition: inline
In-Reply-To: <20241028105050.3559169-5-sashal@kernel.org>
X-Cookie: Remember the... the... uhh.....


--Jw04mRIq6Tcvx3ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 06:49:47AM -0400, Sasha Levin wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> [ Upstream commit 54c805c1eb264c839fa3027d0073bb7f323b0722 ]
>=20
> Irq handler need to be executed as fast as possible, so
> the log in irq handler is better to use dev_dbg which needs
> to be enabled when debugging.

This is very marginal for stable material.

--Jw04mRIq6Tcvx3ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcff40ACgkQJNaLcl1U
h9CXwAf/dKgisn32gugwOj7kv0kcdBJdUWmANJAOcx1EOHgkOSaJivv+5thFldfv
7oqPwtMJ7fY3dgB+F9mBaeEme5UEhSHLoawxHLf4C5paoOTr4z3YcXrdwYgwrF3Q
n+sGIw5qXOgLhuHyOaGLyaMsGaHuI4yB4PfFi/muoWK98SQex0M6iC3+WbAY41D+
0ghy0A9fIIAy/xK9Q309x9hV6dwfUE4Sg4+DHC2kH9E5JBD9sY4EaGmkdZ7azV2A
tqwaPUgw34Hip+veM7UMb4m/G3jM6BwAUJporndNYVBmo3O06bDGvZulrRDsUkEi
7PvclJ+x+hhfc90E9zZn2mCpDj9trg==
=yJsI
-----END PGP SIGNATURE-----

--Jw04mRIq6Tcvx3ro--

