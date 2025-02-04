Return-Path: <stable+bounces-112199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53FBA2783B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490E63A34CF
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D862163A3;
	Tue,  4 Feb 2025 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB17wYsZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C58216399
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689796; cv=none; b=Jqv36E/FedpbAXgg2PdBW5dGaFVadnNdgo5T9c0ZCtZv9JV7drtmG4MYVK8zme1NHckfsdtoqzIQLpaZzKE7FQbkhH1IsD1T6h1onkU9+jGN5XnnHyYMOwAvnCKObS7n/sg2H0wGeWsickXm1iwZlCMqfTE9CME8qUkkmcmf/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689796; c=relaxed/simple;
	bh=NNgAUVXXhIdnR++Vsod+JavMfDup78D694pT7zIrODc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKfgYcOVETsD8FqlJCCm2Q6h9g1AHr6cx8VxfkBUOTmMGcpc2jqEyo2qJKMVRUfFCCEh+LEI7598mg5q0DNq6XqSNXoOxAIxzwLWUFOML1JPEBxz1Kz5cEKq9fl4BJ98Flr7XLGhiSeP2QCZxGH2beqqsjVPdGZKvnbXiYddMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB17wYsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63064C4CEDF;
	Tue,  4 Feb 2025 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738689795;
	bh=NNgAUVXXhIdnR++Vsod+JavMfDup78D694pT7zIrODc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IB17wYsZv6+yEre7xIg5FslQ7E2eOLrz5v0yogrmTmtl2JtMSqn8F1I5NjO8OIqI5
	 Ep5IUordkAWbWkyZ8FkWFVyMUaCzhmyfSc8gUN2aNt6y85jECF763uqJqKcF5sClEx
	 l60jN167ybBtBbZjZ+SiSVvLeYXSnNH+xLci2d0vwJaOtY/um7+mPcJXGiFs4Dpacy
	 KzzXLTxTBbc9EPjnIbZaga8Nq5XQbJuAe7eH+HyWc5W9mLKsecjCZwWjuis05d5WM0
	 N4VRxCUJZ0Bkm1Vko//aZFG5grNWlfUj1C36DL8C6+hCzAsOjeXig7Q+k7xRhMLgfw
	 HTkUN1v67fILw==
Date: Tue, 4 Feb 2025 17:23:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 4/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
Message-ID: <58e56e6d-2eec-49fb-89e4-1a5c10bfa121@sirena.org.uk>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-5-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qiBGpraq5W+X9KJu"
Content-Disposition: inline
In-Reply-To: <20250204152100.705610-5-mark.rutland@arm.com>
X-Cookie: Spelling is a lossed art.


--qiBGpraq5W+X9KJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2025 at 03:20:56PM +0000, Mark Rutland wrote:
> When KVM is in VHE mode, the host kernel tries to save and restore the
> configuration of CPACR_EL1.SMEN (i.e. CPTR_EL2.SMEN when HCR_EL2.E2H=1)
> across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
> configuration may be clobbered by hyp when running a vCPU. This logic
> has historically been broken, and is currently redundant.

Reviewed-by: Mark Brown <broonie@kernel.org>

--qiBGpraq5W+X9KJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeiTPwACgkQJNaLcl1U
h9BIXgf8Cf4mi03nwy2+qlBtq2eohiCV6ypAD6QEzQPa4o4jAOECNyNKPDhpSBv+
uGqnWIf85+TuIMG4MYEo4bjSLH0WzeDaV14FO22GHwpTMy/W977Z8Zh9aRmKUGe+
C/EC09lcM8qUEsrEpvBbd3zy1P7qKL939eKvay2M6SktW4XZb6e0gy0hYrkL1X7i
3UbRvknWwRJd5Ko9ivIQM4Mrpkv7IThCgVLNXZ+ltDxqCEeF3De7zKOxO5fOKIAL
Y/aGEEbx4n3F8FChNwazv++1BytDkJlxtcn7l4ek6w14+P+o5S+L2kMippZB0NNl
Mdqu7d2RGfH+JUlA0rqGXr6KfeY/HQ==
=Ig6n
-----END PGP SIGNATURE-----

--qiBGpraq5W+X9KJu--

