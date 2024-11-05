Return-Path: <stable+bounces-89851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C19BD128
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8361C227ED
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405C14E2D8;
	Tue,  5 Nov 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3ium1tQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7113D881;
	Tue,  5 Nov 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822117; cv=none; b=X+E0uwGE599KGHI2LdbU8w58kK+oK4LzoYrWAPAEr+U4QS6BR2rRaFg0wdQwGMZm50rpSdbU5Ou1lOzhDfPrtaqMJeudOxUrAiE3uMx/O7qqiMyXT5E3M+ZUQKoH253AfAIssBdzLitJ1s0IZQTGaCIbq//44SsuuD7nP2vjmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822117; c=relaxed/simple;
	bh=geNXIOmFhjUV44xeJJLj1CXb6YjQiBsxZnVw4EaQ3a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud3L51ZJOfiRmwBy2OjV9kGpk1K1DRBfoDh7OWh+SVDcAeTd1amC5c1KZpuauuBri8qQWMa0NdXQSDFboYxi0zK3jEciYjklTuXrngnYLUMiiSEFlZum1bou8LpHT2ky0MJ9IJAivnYcm4tm5E8oquLrXZrwKQWAmxPXgYlOERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3ium1tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57E7C4CECF;
	Tue,  5 Nov 2024 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730822117;
	bh=geNXIOmFhjUV44xeJJLj1CXb6YjQiBsxZnVw4EaQ3a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3ium1tQ4OrYGX9cs8sebcV86pFTUpuEmi/xq06tAxwG44Wf4fBqNl/2ZXimzpeTl
	 E5hzBuZTXpgsXtnnXbZKQQZDd/7D+ICbBiB/Q7gYRY6BbGWub0pAgIgxPIem/7QIPF
	 L8BvpGd11hjGXcfZsIryiQsmQkgDp2FaogxZ7aLLrVBFzLNJRvko+tlmgmnmidW+8s
	 qDZISKEGjxk9P7qF+2z/rY7Rg3RKbGytVKH+wrAv/7m8Jiu5U84V/n4W4a/1wVtecc
	 6rm25ErH7hceThPKadvYvo/Hap/GfVLAUoHFZOuIgXSVCb/gclVS01MzCVfpwct17H
	 OlQ8zlYbkD/bw==
Date: Tue, 5 Nov 2024 15:55:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Message-ID: <709b6a9a-dcf1-46b9-ac81-e5093a9740f2@sirena.org.uk>
References: <20241030-arm64-fp-sme-sigentry-v2-1-43ce805d1b20@kernel.org>
 <Zyo3QU8aBGmtbTRo@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Y56n/3XFNEIyBPu"
Content-Disposition: inline
In-Reply-To: <Zyo3QU8aBGmtbTRo@J2N7QTR9R3.cambridge.arm.com>
X-Cookie: Don't get mad, get interest.


--/Y56n/3XFNEIyBPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 03:18:33PM +0000, Mark Rutland wrote:

> I don't think that the foreign / non-foreign cases are equivalent. In
> the foreign case we clear the entire fpsimd_state structure, i.e. all
> of:

You're right, they're not - thanks for spotting this.

> AFAICT either:

> (a) Our intended ABI is that signal handlers are entered as-if an SMSTOP
>     is executed to exit streaming mode and disable ZA storage.
>=20
>     In this case we'll need a more elaborate sequence here to simulate
>     that effect.

That's the intention, so we do need to just clear the vregs instead of
the whole user_fpsimd_state and add clearing of FPMR.

> ... the description of FPMR (which is not in the latest ARM ARM) says:

> | On entry to or exit from Streaming SVE mode, FPMR is set to 0.

> ... so we'd need code to clobber that.

Right, that was missed with the addition of FPMR support.  We'll have
the same thing in ptrace streaming mode enter/exits, FPCR and FPSR
should be better there as in most cases register state is provided when
changing mode.

> Our documentation in Documentation/arch/arm64/sme.rst says:

> | Signal handlers are invoked with streaming mode and ZA disabled.

> ... and doesn't mention FPCR/FPMR/FPSR, so we could go either way,
> though I suspect we intended case (a) ?

Yes.  The the intended goal is literally just that, but if we accomplish
it by issuing a SMSTOP in the live registers case (which is the only
reasonable implementation) then we should obviously behave the same in
the live memory case.  I'll add a patch which makes this explicit in the
documentation.

--/Y56n/3XFNEIyBPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcqP+AACgkQJNaLcl1U
h9AqDgf+PqN4Wj9YWUYWWu0trOvH3yqf++dzHWOidz87KPWWpOIWvLF3uL4rSYow
fKMgrPnIVlv/pHdP4MiNSkWHmiUeodUcuaSTq4V7OqO2p8KXeTKvpb6AfnfB1IkI
XQaeeclkboOBKyH4pP7SIpkB6PvsLU3cRxYHV5/ZbQesUZqIRgmzSBDRAxp9rKDV
PcY5uFeqhFW8eXr7SS79bLYUiN2nfiTabXhPGBXapzoUsTctEVpzoD9C2GSuRmbv
uoBgsv3bbABjRfA3tuA5HbUEARNNUw0Anq5KOyl75Rcb8RVE4rkF5GCy9sTtHsnT
S/S2hG3y7xqCOFZleI5hBmrRtHu3OA==
=ITo3
-----END PGP SIGNATURE-----

--/Y56n/3XFNEIyBPu--

