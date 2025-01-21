Return-Path: <stable+bounces-109617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778BA17EE4
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7712169368
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DB11F2364;
	Tue, 21 Jan 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5xMJZBW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534E1F131A
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466387; cv=none; b=qeJs5qGrth6HUclOfEg5YvXUKoHsVUb8dXjpLoquoYh99BqnwBIgZBO1oRtHum7ZYKRKQnIfsJiqfXcAVYBbKLR8zu603DgadCZT1rnoONruxjKcSWXw8gbxSmzSMrf0GqNskD/8+nfRgi0bRENpgZ+N8RbznUZ28lLgqSME8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466387; c=relaxed/simple;
	bh=Xk56czmJVwBhrixeLvjBArHXhkCDOSVkd9QDQyRZfSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROBlV33URRQcN/8HKnwK+o/Q6iMRGz0o88ZIBtv+WiJD7t1Z6fQMQS2UwAjIXCUuN8BreyKDJVppJwnSkRbWekAS5M/zWOc4P85oD8sLdphU9jJkyjsdfN+GnkHyw2upJ6CjZWyDclrQFzxEFQUk60ijhVRqbTw6wmZAkufj2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5xMJZBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC92C4CEDF;
	Tue, 21 Jan 2025 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737466387;
	bh=Xk56czmJVwBhrixeLvjBArHXhkCDOSVkd9QDQyRZfSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5xMJZBWzG2m/L3H3qmDGn9EsnFk5GqYLdAoLjsya5FjHHKx4JKVnVEsRBH/QkuBK
	 ZyxC35WL6QVpmZawDTqUpwpUo/viLIetkrp6HgCTj80a5zlSay0WotDqRKSIHaKzgj
	 JLsAM+DeQmzyc7y9tKZkD8Tzd/42dpZR/DIIl1JOpM4JDIxm87ybKADNinMgRTNWgG
	 U76gC+a/4x+5CoG18vhJ8YcBJmC5OYiIQX8SI/UlDroKPjW+qe7bzfq/qnxhulW9VH
	 fWrNaWO0/lpunSLR9IoJrZz0iEhpRq4jIV7WI1yrRzqbUA/1xZsNUoXbsTjCz3oM6P
	 i5TMRgeD2fJGA==
Date: Tue, 21 Jan 2025 13:33:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH] KVM: arm64/sve: Ensure SVE is trapped after guest exit
Message-ID: <59f02239-98d3-4768-8520-a2532e400a8f@sirena.org.uk>
References: <20250121100026.3974971-1-mark.rutland@arm.com>
 <86r04wv2fv.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N27dzkvpr7ZXoSe4"
Content-Disposition: inline
In-Reply-To: <86r04wv2fv.wl-maz@kernel.org>
X-Cookie: <Manoj> I *like* the chicken


--N27dzkvpr7ZXoSe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2025 at 11:20:04AM +0000, Marc Zyngier wrote:
> Mark Rutland <mark.rutland@arm.com> wrote:

> > +		/*
> > +		 * The KVM hyp code doesn't set fp_type when saving the host's
> > +		 * FPSIMD state. Set fp_type here in case the hyp code saves
> > +		 * the host state.

> Should KVM do that? The comment seems to indicate that this is
> papering over yet another bug...

It should, we need to record what format the data we saved was in so
that if the saved state is loaded we load what we actually saved.

> > +		 * If hyp code does not save the host state, then the host
> > +		 * state remains live on the CPU and saved fp_type is
> > +		 * irrelevant until it is overwritten by a later call to
> > +		 * fpsimd_save_user_state().

> I'm not sure I understand this. If fp_type is irrelevant, surely it is
> *forever* irrelevant, not until something else happens. Or am I
> missing something?

The confusion stems from the fact that the setting of fp_type is done
separately to the actual state save since we don't map fp_type to the
hypervisor.  Either we don't save in KVM, in which case any later save
in the host kernel will write both state and fp_type, or we save in KVM
in which case this results in the correct fp_type being set.  In both
cases we have live state in the registers and whatever is currently in
memory should be considered stale and it's not the end of the world if
it's corrupt.  It would be a lot more straightforward if we wrote
fp_type from the hypervisor as part of the save.

I want to rework the way we represent the state so that we don't have
the state spread around like this, avoiding the need to map individual
parts of it separately to the hypervisor.  We need something like that
to sensibly implement in kernel SVE/SME which we will need at some
point.

--N27dzkvpr7ZXoSe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmePogwACgkQJNaLcl1U
h9D19AgAgrJ45489o8TGJ8JMXDL8lZvvna95oXYrXXqodtkC+PMzli9Rc8kMrsWK
pHnwe7xWvLYz3pcEAAb8p9EDnGs6bZqU4cqW+BFXzi7L6sTGKWtR2TkafJdZIDuM
mGG7+67auJDb7kYHQouE3TADsTa+qPz3uoqQ51n2SMB6qJwZni5AEo1jYsrXAebW
qVy0IusFb3ENgNkcXMOg5+CQdvZrxhdFBcPTXTTQWhMinZuS/Rcjp3Inh1S7ypLW
UPq/lPkAcNduYdGhngmECCzNntGwlT4MZ5Z/M+7AuWo1YPT2pp9d76D40KAqOcHK
2d3lB6DgMxJs5JG6LZ7L8pG0GaJDJw==
=f6Ta
-----END PGP SIGNATURE-----

--N27dzkvpr7ZXoSe4--

