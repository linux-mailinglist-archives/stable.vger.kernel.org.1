Return-Path: <stable+bounces-112194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662ABA277A5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DD5163C7F
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AA166F32;
	Tue,  4 Feb 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHCggAoa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ADE215776
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688132; cv=none; b=k74QZKqbKDOIQtSR6r0SU3dXiqvDQvbbfIUYkuDQHjPtURqem6HsS43sDcZQOC7hUnCGC2wKifDps7uV8Rb9nBW/Driy5r8prEhH+IwK4FAoUE6pBCfbkrLGNX8LapTn/+kVmMwD3CRaYMPfXil6P93xu9QZyq+1sgbIllr6jNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688132; c=relaxed/simple;
	bh=+IZ5ILpGRBsDj5oJCPxqFJPFHhgGPlUJEftTjsM3xKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT45KjrJvCg+pnIUhjZyjnZAiWwvGjR/VdGStLshEPvnv2zyEgCzNldGD2M7XTETPjauAtvBDa9xtiN9k2Cp0Ar7i6EHM76D/oQ6YOxYo+LcAuhJ0cFWEd9jaYKrtUwYcoFBv9DQRF5MWYkIXeBambmE2Qn2zisVbFZRb1zP9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHCggAoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47928C4CEDF;
	Tue,  4 Feb 2025 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738688130;
	bh=+IZ5ILpGRBsDj5oJCPxqFJPFHhgGPlUJEftTjsM3xKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHCggAoatFK270bAwhFVX/cQQftzRRjZ9mCL4gZe5PJ9exnwBSrtYn3+e/2nDp51Q
	 uexv3UJZyRm5Coklgwlqe6+P1ekffCGjheIFblQ/c5mnje3sUEJi2jLq+gqnaIiqB7
	 3UUP7JRsoUEKwMKcTsQ8JYupsBo1ZYJHYEzoR4oFrvv6IVARPOhWbEjnLNyvwlQI5C
	 Nn77+jrRyw+ClW7uRLkIzWVnopuXZ6yjEwwz7CpiMIrhLIYVRLcS7/ilmSLCrk4vhc
	 oWTHriUaURWDkkB2CPGPnzHf+1H9uO3Ku0xD0YXaRDXMRTuip61uwHazBMmY8KcLCU
	 /wCJ+PxDP83jw==
Date: Tue, 4 Feb 2025 16:55:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 2/8] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Message-ID: <90bd1207-412d-4993-afdd-86825a403556@sirena.org.uk>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-3-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ntDzS8pK/eHu8oGr"
Content-Disposition: inline
In-Reply-To: <20250204152100.705610-3-mark.rutland@arm.com>
X-Cookie: Spelling is a lossed art.


--ntDzS8pK/eHu8oGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2025 at 03:20:54PM +0000, Mark Rutland wrote:
> Now that the host eagerly saves its own FPSIMD/SVE/SME state,
> non-protected KVM never needs to save the host FPSIMD/SVE/SME state,
> and the code to do this is never used. Protected KVM still needs to
> save/restore the host FPSIMD/SVE state to avoid leaking guest state to
> the host (and to avoid revealing to the host whether the guest used
> FPSIMD/SVE/SME), and that code needs to be retained.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ntDzS8pK/eHu8oGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeiRnwACgkQJNaLcl1U
h9C1dwf/ZRB7oQPMQLHdxH2d4u2U0lOBXESvm5fXMDMnVSQcpYNoKkXLacer8HYn
KjSvrHL9QuM9S8dJksmzgydPxgI2R2XGgLIxqm3QYMk1nOEzjerMYC0SLgoCcVta
4cRuj177Jrk4qo1jOP6yCpW583lEh080hH396BjkMev2UQ2QncRJFgwAdapGv3/o
vkVAEeP2eCglOq+600Yvjg5jbqwcZe0Mo1vxv0g+0NykYb8ZqLcSBaxUggXciLZ5
XCfa8P1IJgb0Xjh+fn5OPvRa6EH+RnGKocztPdMWZ9cag/el09pblbKyGoYeRxHp
YtZW7gosUcwfw8Nap9p8U0GO+YwW5w==
=E0UD
-----END PGP SIGNATURE-----

--ntDzS8pK/eHu8oGr--

