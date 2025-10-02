Return-Path: <stable+bounces-183037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 214C5BB3E22
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 14:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0676167B1C
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177653101B2;
	Thu,  2 Oct 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhzIqWMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AED201017;
	Thu,  2 Oct 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407959; cv=none; b=Dn48b7ieMF9khu1xrzBUicF65SfvM70GxeFQga9Eku6F9EFFVn99q77i3QE3v9qKBA4IrfOYrywsMPmuydf1g12wurZMgIsLBsN2hwLfyRaiAKLoa9Ru0DKiRPkinZQNFgGfbcSpuflQBGwh7j1OgKWJetFCifpNyC6hpE5ivbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407959; c=relaxed/simple;
	bh=9sajPscbz8ZBS4AzQGnOr3vIfx4eJe4QIOsQjVBClV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9HNqLD8U9Zaq4usXSWDPIwJoGVToFxk/kBO5lfSl11oZ+Gj6hPHGP6heLnSTJx2BAFgQ8xZEKoiuJ8bdbtNuwRn3UjqV4sLxDlEjq8VszmKD78pgCu3ZQPJllZfiUbitP+glPTu8qi2zogiqnVpD6ZbvxFqn49bKj7iTJpJccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhzIqWMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1867C4CEF4;
	Thu,  2 Oct 2025 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759407959;
	bh=9sajPscbz8ZBS4AzQGnOr3vIfx4eJe4QIOsQjVBClV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhzIqWMYRk9jmDxxuMxaCzS29te+kFqIk1rvUnXRLQz2aZ7BZ8v8slCeBQ5yhOc1H
	 Rbpl27stMvzJz/Rg5AYjBObjLrSNF5O5rMdwBDcfGrgk2mBmbQatAttgM8e0jI/FbR
	 Eyjc75erPxTx1a5owsu61wuNobJntVO1OlQ5fDXvH3ElgQRtEvHDMc6SbdZsgHGVzu
	 Bx7vSEhACGPD5uk74puDnB+DieFB6YMw1M87gGHLk2wo33oPSyZos3BRHetKn/b9Jq
	 zZuXN2PvCShjES1iqHA59CASuovQSDap94jKz+5QsaBxtLDpdE+AZ4bgaGueEAxtjY
	 alEYlG0K/TdkA==
Date: Thu, 2 Oct 2025 13:25:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer constraint
Message-ID: <88555c06-ccf5-4639-b13f-892149b5faa3@sirena.org.uk>
References: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B3CqB1180WvJ/2Up"
Content-Disposition: inline
In-Reply-To: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
X-Cookie: idleness, n.:


--B3CqB1180WvJ/2Up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 11:05:35AM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> The size of the DSP host buffer was incorrectly defined as 2ms while
> it is 4ms and the ChainDMA PCMs are using 5ms as host facing buffer.

None of the fixes tags in this series point to commits in my tree.

--B3CqB1180WvJ/2Up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjeb1IACgkQJNaLcl1U
h9B02Qf7B+Lbf/iLdUV4QhKVvh4Mfr9FQMyscbWHKCVqOvfAUuw4mwIMqSpv3U1o
Co/TKrK04+PWO/BVBixohBOOUbmGdGoMCi9LJxisD/Y5dC2fuxmZrx0oHQB0u3NH
GwIvDbiNsP9hkqwUcNfwZgEcjSMkge0Ef0Y3IBQ4BBgawyK4znSSd+9cKgFfvkMi
pPAg32/hqJ8MTZ42KL5bQS69iifO0WORmMF8h6mYeN2NqstKIEZwh5q4grKvc3A6
gx3UdtAl3hZPU69RiQSk1KuxowlyY/O5Mc86phh42ZFX7icmZmckOcPXEIpyiyXw
EwIxsFRswn8TeVvLoo/BCacylPAtzA==
=iTeW
-----END PGP SIGNATURE-----

--B3CqB1180WvJ/2Up--

