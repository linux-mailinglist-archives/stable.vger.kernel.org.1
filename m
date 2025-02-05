Return-Path: <stable+bounces-113992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DACA29C21
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E30A166D8C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157CA21506E;
	Wed,  5 Feb 2025 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKP836gG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE67215061
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792236; cv=none; b=bG0IUQIliCH1uEpsGX0FxeqjBYI7rOm5pZhvsoOz5/qojndTSXKReKfsxBAjQzvkuHJxFXchKcc6qatZzMXLx1PE4xOcW/CK8F70qMHxQD/A7pM+E3ExNBF7JfHgRnKVvvtnlPYPZTI0+NrZX/QQXKv5x294GngTo5S/ESdzFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792236; c=relaxed/simple;
	bh=ya/fBoSYVVIdgK88dQ9518oSzqK7Eic5Fomq5f/2f/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYkETp6yxJxQ0y5Sk8D8SiAnCZuNGrV6PGvdYM+ncnGPm3Z6/paPrjGxxl5xLqEmH9fyBzmr939oZ87uzwQIasRaFu5SUpZtecgL/MmNp1gnyW7MRrddW/BgF/Iy1niKfSwyCSfSRCoWcyitX7X6GCxYaOZutZ8XIJnAVfa8ank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKP836gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F77C4CED1;
	Wed,  5 Feb 2025 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738792236;
	bh=ya/fBoSYVVIdgK88dQ9518oSzqK7Eic5Fomq5f/2f/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKP836gGBxwnbSube4hNPNDiesXHon+kI/BC/VYc2CvG5L3aoqZSetkfIkEcbIsPF
	 3PTuLtMED9HyHr86BJ6LC5ZfnC0r50gHWrpE8d8WEmLRUbUv9QHL6tdxSIuxqt/NV4
	 IRQmF8XfTOr2cdLE6fOTbccHFOqi2ePhd0F+tOiwosWHYVZ+8EXwwlmJt5czRUkwIH
	 KVCAw4eZk0fkDHGht8VyMRuplPEeBoMHHsnbqWgSz2wHO0VXIknfqiP+ZnxAJRrgmA
	 +e10JnrOHTgWgPUkc7XfFwxnrXACk9bPfzh1uOW3pcPjmi5bSidfLPxhde26ORiPeb
	 o5sCu6PZdRPfw==
Date: Wed, 5 Feb 2025 21:50:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 7/8] KVM: arm64: Mark some header functions as inline
Message-ID: <b76803b7-c1b3-426b-a375-0c01b98142c9@sirena.org.uk>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-8-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FmYGv0xfUtEYpWvS"
Content-Disposition: inline
In-Reply-To: <20250204152100.705610-8-mark.rutland@arm.com>
X-Cookie: Earth is a beta site.


--FmYGv0xfUtEYpWvS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2025 at 03:20:59PM +0000, Mark Rutland wrote:
> The shared hyp swtich header has a number of static functions which
> might not be used by all files that include the header, and when unused
> they will provoke compiler warnings, e.g.

With at least LLVM 18 we still have some issues with unused statics
arising from the aliased function definitions:

In file included from arch/arm64/kvm/hyp/nvhe/hyp-main.c:8:
./arch/arm64/kvm/hyp/include/hyp/switch.h:699:13: warning: unused function 'kvm_hyp_handle_iabt_low' [-Wunused-function]
  699 | static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
      |             ^~~~~~~~~~~~~~~~~~~~~~~
./arch/arm64/kvm/hyp/include/hyp/switch.h:701:13: warning: unused function 'kvm_hyp_handle_watchpt_low' [-Wunused-function]
  701 | static bool kvm_hyp_handle_watchpt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~

The simplest thing would be to expand the alises into simple wrapper
functions but that doesn't feel amazing, I don't know what people's
taste is there?

--FmYGv0xfUtEYpWvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmej3SUACgkQJNaLcl1U
h9D8jAf+OsR7N7gv1mtd/NUw3staLjxx4em5B3XybTHjif1nB4OWEjvZoOxJIn4M
Vct+xOc16qwqpSBqpNZ5J7vnqF4g0TAmHkNTQBpSg6rMFoivkllESV4ET1GfKYXS
+K+qlRXgZLfIyk7rEvb674aEyWBhEfjDiSorQOZ+4xFP9QU+FVmycLl7gwLtQaig
Zj5OZaGC+K2gotK5VDhMzEj7CrsIMM5wlylchlOyGdQHM1gAOOL4/ca6qcnjbqpl
+dnJuXJnBW98ssuchtaWDIGkFup6orSyfddsfHrRZOnqDCb94NQWvbDV7TapiOnz
PIWeEgcDvS4x1xHHAVbzmPKqx15/iw==
=cnFK
-----END PGP SIGNATURE-----

--FmYGv0xfUtEYpWvS--

