Return-Path: <stable+bounces-112197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA4CA27838
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A29165185
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359521577F;
	Tue,  4 Feb 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qouqh79D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610472144AD
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689646; cv=none; b=V7kFz5+RF3NZUVQOMlu4sE70JaD2I9CeZJnrCtFRvYrq/TeWasleRSO5tbwP5uGxrAa/w8eRN62wQxWM1xAtumHyxq4FVS03VjDR6lq+6OUdI4VWXtloa3pTyOW+2A3QCwY6pJNv6b2T4Adr+Eq62gALFq8OIZ4PlCkbcWslWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689646; c=relaxed/simple;
	bh=fXCKZvImQuTOesY0OsMLy2+fVLkdqhy5wBhRUWlJGLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rct6w3PcerI1ofYRvSAD1S8UfboIqJjSh/9G66NFlwjuFyBzYyr9tHcn1z5OT6u7PKxCylfXqw/AxQo1GaWKBrffA44Cr5QQ1T8zohPoJyS/dW2WLnBgkeicyNGHqXukXILWlzrGQmB3mpJ6ZHCM0mvlc/LHqJFvqH8Idq45vLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qouqh79D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FB2C4CEDF;
	Tue,  4 Feb 2025 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738689645;
	bh=fXCKZvImQuTOesY0OsMLy2+fVLkdqhy5wBhRUWlJGLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qouqh79DBpvOdtbMgxsL8UoG3JtSlgaiyDYTuryayUfKC6Yl6Sx+yJXuP9uNsskpZ
	 Y8qSpO2I9yChvwWdlNC5judrPT0E3PR75nLQbht5YELjfSKJk156LkoL5iMKA8LSKc
	 CsEUYtqaLD1vSg0/gIl3+2EmT96L8V+Ot8Cgklx5c5lrjmSS+NYT6NM2OvGVon+4y1
	 m/NoCjr9EEHSUmdBsntQxVN9gjhNtodu6tNUo3fFQM13yona3U7sR0oq8wyXDklZ4w
	 ECng3Nd8rPayz9jbjHhNA3GD2P39h1rXFSPhyzKNmGVAd0JffR2ENrnPjBVZaUMm/T
	 Gx5t0kZ5I1vNQ==
Date: Tue, 4 Feb 2025 17:20:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 3/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
Message-ID: <cddb7cc3-9174-4dcf-9eb9-b7f4e2b0d32d@sirena.org.uk>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-4-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BrVcv+yk+NCYE+Ng"
Content-Disposition: inline
In-Reply-To: <20250204152100.705610-4-mark.rutland@arm.com>
X-Cookie: Spelling is a lossed art.


--BrVcv+yk+NCYE+Ng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2025 at 03:20:55PM +0000, Mark Rutland wrote:
> When KVM is in VHE mode, the host kernel tries to save and restore the
> configuration of CPACR_EL1.ZEN (i.e. CPTR_EL2.ZEN when HCR_EL2.E2H=1)
> across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
> configuration may be clobbered by hyp when running a vCPU. This logic is
> currently redundant.

Reviewed-by: Mark Brown <broonie@kernel.org>

--BrVcv+yk+NCYE+Ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeiTGcACgkQJNaLcl1U
h9AbPAf/dozy8yHITbWmaPkiPsGMMbfEJ3jszZbKnbD9/ue8ynsjAX3EvHVtsErE
h+Gr5zCGXbAaQRQz2s3TzAjxwoUXH/P+vuVKbIJpqZswAhUZ26o4F26Wbg9k9LVB
L7XtldS31M+F6pu+7iUhmIp2J79oVtSQwvmvUM3jDVbIH0MXnftwXvJOvvSjhzUC
v4Ee5tsnb6SgpXnu2F3BikSCCLscdDbE2MXE6TE64aQtSwlYWblgfYAP8C9A3whB
oAmYZtwNT2EKrApJOU4m47QFG7GMewZI9UcT3mCuz15bcpWACSlA1OXlVs0J8Iba
5n9qOO50XvUdS4cZx373d+cZlklyxg==
=a8u6
-----END PGP SIGNATURE-----

--BrVcv+yk+NCYE+Ng--

