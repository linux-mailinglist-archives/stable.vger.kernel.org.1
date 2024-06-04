Return-Path: <stable+bounces-47925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF078FB3E3
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35921F21F53
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE936146A9B;
	Tue,  4 Jun 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evkMYfOA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A16146A8C
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508124; cv=none; b=YBeU7G4muzhidx/9wGF1Wbo+J45pKwTnJ0YBAtJztnDyFsd2y6Sq3mXljP192nfkmhli6upxWAVFBukt0j6PAaKPLVHrqa4DabuEkA0iSAp/gAsWzq41jb5JjtNu59YzRU3KpUXSRcEYv5kFmz2fg71KC+jEuGmh/QDSf8EcNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508124; c=relaxed/simple;
	bh=FzoCYb2iqvrKxZMbSfXrxVvk0i6Jjxy5z12/qgWBa/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LPWokADsRfoYmeN4434k871DaFHlhZ235GSfTupCxtDV0dslo0303FgBQ0ilg2dGWYD8vQ7nKdPrik+XKTMTLwHPLnfvkcO/lNScHGppsiqeBiYsY2HDCZWb3FjMJcrJVOszVPSo3bahKFbc78ywBtD8SIPk0bQfBgfdJ/8ypj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evkMYfOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358A0C2BBFC;
	Tue,  4 Jun 2024 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717508124;
	bh=FzoCYb2iqvrKxZMbSfXrxVvk0i6Jjxy5z12/qgWBa/Q=;
	h=Date:From:To:Cc:Subject:From;
	b=evkMYfOA8maObVQakjQYiVz2vo0LSMWuyzrN+EVvBBqLLFZHsHHPFZtMLz1N5ei7s
	 oW3Bj/O8aD9UZrbrw3bW8VSfMPAz+HJRCxucNnpKE40psBwkCE5Q/VxF0Uc5FanxzI
	 pHeUR13Td3uXUTmwAWr+KbGvOHFXxMvdkjS3VzOMFBXoKeH/1FvjRHE3QIymVzCJbA
	 j64lzI32REDeRpVF7v7GlxOVt0bu8gwIOTk5Oa4pnSxbELKEJ2awGHv57LfJIpIvd1
	 QqwViDkIlym6UxlQiFBH5to1CQKA1nI0RFJVsNl4dFiCfjjhRcLEa9cQMyk3Sbc0yK
	 tboCdDLjaQo/w==
Date: Tue, 4 Jun 2024 14:35:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>
Subject: v6.6.33-rc1 build failure
Message-ID: <b4cc4d63-3c68-46ba-8803-d072aad11793@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XWaQFzthChRsCvXj"
Content-Disposition: inline
X-Cookie: Is it clean in other dimensions?


--XWaQFzthChRsCvXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm not seeing a test mail for v6.6.33-rc1 but it's in the stable-rc git
and I'm seeing build failures in the KVM selftests for arm64 with it:

/usr/bin/ld: /build/stage/build-work/kselftest/kvm/aarch64/vgic_init.o: in funct
ion `test_v2_uaccess_cpuif_no_vcpus':
/build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:388:(.text+0x
1234): undefined reference to `FIELD_PREP'
/usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
388:(.text+0x1244): undefined reference to `FIELD_PREP'
/usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
393:(.text+0x12a4): undefined reference to `FIELD_PREP'
/usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
393:(.text+0x12b4): undefined reference to `FIELD_PREP'
/usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
398:(.text+0x1308): undefined reference to `FIELD_PREP'

due to 12237178b318fb3 ("KVM: selftests: Add test for uaccesses to
non-existent vgic-v2 CPUIF") which was backported from
160933e330f4c5a13931d725a4d952a4b9aefa71.

--XWaQFzthChRsCvXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZfGBcACgkQJNaLcl1U
h9A6Vgf9HiXe9MWugcUGBMYE+pEZrkuFToVdSYLn9hr8ArGr//5748YNwNGE6YSZ
kAT7XHP5uYzJgmHDnZd2LxciCR5Cp0nJIJbWuytKW6Rsba67jek2TXkdlVEenV14
vAGtOrlhegMJFTe6YZVDvxBphcK7UVa/6OtUOvwL1y/0JTwe/uGMZcTRkxkuiUDE
84Z0iwKG6kt2yLzlGeSubKj6oo7cHWPqVRX6S/h3qk0aJFDGIFuZWv5bSf9TrqIh
KG8vn9XaFXOJAgXoJSsJuZxfMC8+hUTulnnZlJllU2b/Al9+ESpHme8nvaFdbxpD
tmAUkMK7auQU8ZagkQXkw/XeObwuzA==
=NVfB
-----END PGP SIGNATURE-----

--XWaQFzthChRsCvXj--

