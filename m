Return-Path: <stable+bounces-109619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A1A17F4B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128AA3A5F34
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375E1F2C47;
	Tue, 21 Jan 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTbmLs6C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B1E57D
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467992; cv=none; b=rKTsYyRReRAQR5Gr38d5cljJ9ARcXpnATn9ifThoseTE8RUdSltuS4i43o0BnYAsz2ywdAGjJE0Z6pOXUlNh8lcnO6pJOBCDOwUoZ/n0u9JKYjJ/oqBJbzP9xWxfnJMKr16HTBVTydXnTzZJ0Xj4YlBr2Y7Z2LUUHd/nNHsQZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467992; c=relaxed/simple;
	bh=h83ZrXfmZQHa94r0K3tTr99WxDdHtoauNb0mXLSzghY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnvz0CupEXtGIB4USFCVIrFU/y75naIMGERFhBidwAn2Tcjj32AMnIc7ylUQxZea9Cb5EAvzZTnyT8YtYDWl4UNn30ViRHyWtIh4er1kM9lnqw2APdbbJzQEYg3sKYdZZW/22oy39k9Q2lUFYPtictMYNKF6BsGcLxWtR6xXWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTbmLs6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33B8C4CEDF;
	Tue, 21 Jan 2025 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737467992;
	bh=h83ZrXfmZQHa94r0K3tTr99WxDdHtoauNb0mXLSzghY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTbmLs6CV+eOiE/CM2BpgwnWA+yeVqWEW1sZaEWC/AJWTW6lSe3jgJKjbavJ+NGzX
	 90Fe/Xc15dcJ/b/9Ric1dIljzkeR+KeEd41TsxOwFX+YQCxOuROPYTITO8LkgGHBz3
	 aLeKY30qcO0CC4LlwEveMTsmrhanS4TVJ/nk19OfcJHPw+3bdrjYT0z8zvVRuqFi3D
	 c44Ucg3jjaA+ruFBw1dXmC7yNt00fiqzUWtmjdWkTisGbXlWIPCwJmvQo92+Bvb+35
	 5xxX2xPggm9yW1C9EUsvWrDQKuMCnyxv8FaVpt1MZR3zEcktR53nmE6OSfkKNFr4g3
	 oVmhPqsZGkFIw==
Date: Tue, 21 Jan 2025 13:59:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH] KVM: arm64/sve: Ensure SVE is trapped after guest exit
Message-ID: <662e4584-d8ca-4336-94de-0c0d6c793df0@sirena.org.uk>
References: <20250121100026.3974971-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HxRUYpQcPqd++QH8"
Content-Disposition: inline
In-Reply-To: <20250121100026.3974971-1-mark.rutland@arm.com>
X-Cookie: <Manoj> I *like* the chicken


--HxRUYpQcPqd++QH8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2025 at 10:00:26AM +0000, Mark Rutland wrote:
> There is a period of time after returning from a KVM_RUN ioctl where
> userspace may use SVE without trapping, but the kernel can unexpectedly
> discard the live SVE state. Eric Auger has observed this causing QEMU
> crashes where SVE is used by memmove():

Reviewed-by: Mark Brown <broonie@kernel.org>

--HxRUYpQcPqd++QH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmePqFIACgkQJNaLcl1U
h9BmLwf9FtC83FfPPp02TX7a44DrOhYttGT5PFnE5bQLbvru4wLLjh6LLftDHiy/
sjJJaJfThO6ojrqRr2w+Um0Li9YYJtyi4oVL3cd6qkjpIOFmiTTW1J2KeqMSHhwo
npicPuSGu9kTv71NO9xLsjhBgadcZfy+wJWn6GcbNNX5ND+qIT9BkiPAHOQTAls1
z16OGZiZQgGgDXAPzuV4x8mtjJMsdqrlZKbsc7x+OkPz+fU63VSzeLs5eri5kRlj
qP9nvlDuoZZdve+Fg38LofW0kp0FpjtEGVLhecTucAWAOKYWqMbcZ+znwf7UWUaq
mSyjvmAfk0cIP8PW9rROYu74S09RDA==
=9RjY
-----END PGP SIGNATURE-----

--HxRUYpQcPqd++QH8--

