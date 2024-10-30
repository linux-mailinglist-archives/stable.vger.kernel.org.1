Return-Path: <stable+bounces-89356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D9D9B6BDF
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 19:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4E71F2243D
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712B214424;
	Wed, 30 Oct 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZFKIJMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6121213137;
	Wed, 30 Oct 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311833; cv=none; b=TRb9sA3SRdE7d8N9V1piyUgjPKssYtv5N8M83n8f/88SLBGNbqfYKg85eujDuFEJYoT23akxFYNJGeE3rne0cefTtKUrqIp4GFNG1lGIjmqARUozKmvS9RL8fFvLEmjRspH+VfzafgwI+mLiCwfPn6+txjXBpLplOyWtx7sbSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311833; c=relaxed/simple;
	bh=PUSWypS9RPlliztjPuKrypjSxl4XFZNOoSoJofJ+sX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUnHIOhJdudfOFo+4lF8K0Kt7XiBt/ILHZ/n9Hxzm9+9JU5ZHgRsPm/SqAT5x+87JQZ1kG9FtFoqAKuzN4xQXQ+I2a7QurAs6mDWgU9hSLMw/4BOA+wszcuATUn41TjXmWoN/5wnpvUHY+kI3Ql0Hdx296iZ7BQ2VEg5hP2DVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZFKIJMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10ABC4CED1;
	Wed, 30 Oct 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730311833;
	bh=PUSWypS9RPlliztjPuKrypjSxl4XFZNOoSoJofJ+sX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZFKIJMnYVyNIvUEnvLYifNu+y+jzl1Wz0YI1ofnDId92z1griWtJC43eteIaDLVd
	 maGJzQud9s7pIMOyLHkWMJWebPOlHO8TVSbKBIv9Wm4LUHy+JHMeBcDwruRzJzPZor
	 OrEJ2wIdc7W2NJ1zxf6TQycLUvScYtXwMrUzxK3SBi+GZV//1iWVjzECrK9C46xoDK
	 /yaamwjW+q0JnuCZU9YbYLoJzZdBueCTrN3FGhPVHDSDNMfZ9zB3yPSA8xnw1xw5yr
	 iYvtoh0fpbEKrCqLF1SRBRD5FcrUl5eYP0VHLmw4935aPBOE3RH+juVn4iDuQt1FTp
	 7hu8QbRH1Lhxg==
Date: Wed, 30 Oct 2024 18:10:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andre.Przywara@arm.com
Subject: Re: [PATCH] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Message-ID: <618074b8-c685-40bb-b7d3-f309b30cd25a@sirena.org.uk>
References: <20241023-arm64-fp-sme-sigentry-v1-1-249ff7ec3ad0@kernel.org>
 <ZyJuEBC1wFPrTLAS@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tzY2Rc5DUyHGb0DA"
Content-Disposition: inline
In-Reply-To: <ZyJuEBC1wFPrTLAS@J2N7QTR9R3>
X-Cookie: I feel partially hydrogenated!


--tzY2Rc5DUyHGb0DA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 05:34:16PM +0000, Mark Rutland wrote:

> I originally just had a few comments on the commit message, but I
> believe I've found a logic issue in this patch, and more general issue
> throughout our FPSIMD/SVE/SME manipulation -- more details below.

I'm fairly sure there's at least one other issue lurking somewhere with
TIF_SVE tearing, yes.  I've not been able to get that to reproduce, and
I've probably stared at this code too much to see it by pure inspection
however it looks like you might've spotted the issue here.

> On Wed, Oct 23, 2024 at 10:31:24PM +0100, Mark Brown wrote:

> It would be nice to have the signature of the failure as well, e.g.

> | This is intermittently detected by the fp-stress test, which
> | intermittently reports "ZA-VL-*-*: Bad SVCR: 0".

That's a common one for timing reasons, but it does also manifest with
other outputs (eg, if we turn off ZA while trying to execute
instructions that access ZA).

> I don't think this is correct in the TIF_FOREIGN_FPSTATE case. We don't
> unbind the saved state from another CPU it might still be resident on,
> and so IIUC there's a race whereby the updates to the saved state can
> end up discarded:

=2E..

> ... and either:

> * A subsequent return to userspace will see TIF_FOREIGN_FPSTATE is
>   clear and not restore the in-memory state.

> * A subsequent context-switch will see TIF_FOREIGN_FPSTATE is clear an=20
>   save the (stale) HW state again.

> It looks like we have a similar pattern all over the place, e.g.  in
> do_sve_acc():

Yes, indeed - I think that's a separate bug caused by the recalcuation
of TIF_FOREIGN_FPSTATE.

> This is going to need a careful audit and a proper series of
> fixes that can be backported to stable.

It feels like a separate thing at any rate.  We can do a simple and
robust but performance impacting fix by having fpsimd_thread_switch()
only ever set TIF_FOREIGN_FPSTATE, never clear it.  That'd cause extra
reloads in the case where we switch to a thread but stay in kernel mode
which probably happens often enough to be palatable.

Otherwise I'm not sure it's *too* hard, TIF_FOREIGN_FPSTATE is a bit of
a giveaway for places that could have issues.

--tzY2Rc5DUyHGb0DA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcidpQACgkQJNaLcl1U
h9DgCQf/aKq9znkcNdaaX99tyQKmAGH0Ab+cyf8R0/hXJzUa13y5F+gTf+/NDjYO
Z94a5ttBE5fllSBD/GpqF3OOGXqKlfW4BBVLEU1LCgpprvXfb9TtUna6gIxIQKwE
78yNEk7yd08AKgvUbAoUsUsG/L+0tSB4PMcAE9KisCueQAsikV/zMenetiwOQ4MS
XdsJ0VYLpFarFB2wie+UTaMeuwtNCWlWzrkO9oL0YTbiUB8OWXgSuzhsRXNY+aKq
b1hHEifXqMThHgXH8napkaDP95yRHV+97X+pgZjPyOnZnvBXs9cxepoKbFo+ZLJ0
JMf0C4jXPRlsMcyLz238xdpuE1XJow==
=mZzF
-----END PGP SIGNATURE-----

--tzY2Rc5DUyHGb0DA--

