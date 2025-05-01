Return-Path: <stable+bounces-139253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55531AA586B
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 00:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1C47B8CCF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 22:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9B226D0E;
	Wed, 30 Apr 2025 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvOZlYlO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DC34545;
	Wed, 30 Apr 2025 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053935; cv=none; b=ksoll7oFfURhOxSyQIf0Yr/TLpYt/hkxvcznz+7TRWgVYqHbz1l/p8JFQFDOn7EKFx+cfTNNKGHN5rQLQdRnkZkUj9Uj4mYGJ9IDhENIvFpMfzF2IrXB5sKlL0S9MvY/CWWqJCnDtAVzrtsVP7pIFtE1e1jzclMTAJpwMQ2MsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053935; c=relaxed/simple;
	bh=wiInPDhsaRQhzyjCvueGftRayfrzomVv/gP9R4/ohjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSdq5hAT+7HoduWxM67EiGJ0ehZqkjjH/pCZ1a9zIZN6fPyApRSV2DQpvFFoxLl3Mqc1mfvyLpO24CMTmer6OFD+LsmLUtFyVKG7kk5Pypd3tj2iC1Ch9VLE67XK2yOHjj6sTG7J16cdXyBdDXvkYU1SrFBHvgFj7z/98EQj+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvOZlYlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E04C4CEE7;
	Wed, 30 Apr 2025 22:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746053934;
	bh=wiInPDhsaRQhzyjCvueGftRayfrzomVv/gP9R4/ohjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvOZlYlOvx9FfiJWIxuWbBIFwPGJpc2hLl9EgmwstajH6zalh1O9gRhQKcM4gpcJm
	 ex9kSULKUrzRrCkEzXWG95pfFatFpXTNpSFsaCSRxki27WPZA6VqSY4XbUWzPrwxUK
	 qw810+1JLAWGPiCuYmIh8oo0R1aA03D/jP8s5unzgi/0yu30qLAf80D8KUxGYf5Q13
	 NKjxyychXjrd30YE1+bMEvLwj4hV/0VmXDiUOL6p8/ZpzvM6xS2xqzXDfYzSe7O1ju
	 mLnjXO5pL4al47OBlzs5QZqdrcK8iQKPGjhiNaabJSM09yInXE9mj/SpVXw0JlEhuP
	 en+ScX72hvAaw==
Date: Thu, 1 May 2025 07:58:50 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.1 000/167] 6.1.136-rc1 review
Message-ID: <aBKrKvYpCKWcoOGI@finisterre.sirena.org.uk>
References: <20250429161051.743239894@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O4i/hNuYEfmFpkoL"
Content-Disposition: inline
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
X-Cookie: Well begun is half done.


--O4i/hNuYEfmFpkoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 29, 2025 at 06:41:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This breaks NFS boot on the Raspberry Pi 3+, the same issue appears in
5.15.  We don't appear to get any incoming traffic:

  Begin: Waiting up to 180 secs for any network device to become available ... done.
  IP-Config: enxb827eb57f534 hardware address b8:27:eb:57:f5:34 mt[   16.127316] lan78xx 1-1.1.1:1.0 enxb827eb57f534: Link is Down
  u 1500 DHCP
  [   16.840932] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50
  IP-Config: no response after 2 secs - giving up
  IP-Config: enxb827eb57f534 hardware address b8:27:eb:57:f5:34 mtu 1500 DHCP

There was a similar issue in mainline last release, I can't remember the
exact fix though.

A bisect identifies "net: phy: microchip: force IRQ polling mode for
lan88xx" as the problematic commit.

# bad: [c77e7bf5aa741c165e37394b3adb82bcb3cd9918] Linux 5.15.181-rc1
# good: [f7347f4005727f3155551c0550f4deb9c40b56c2] Linux 5.15.180
git bisect start 'c77e7bf5aa741c165e37394b3adb82bcb3cd9918' 'f7347f4005727f3155551c0550f4deb9c40b56c2'
# test job: [c77e7bf5aa741c165e37394b3adb82bcb3cd9918] https://lava.sirena.org.uk/scheduler/job/1340356
# bad: [c77e7bf5aa741c165e37394b3adb82bcb3cd9918] Linux 5.15.181-rc1
git bisect bad c77e7bf5aa741c165e37394b3adb82bcb3cd9918
# test job: [9599afaa6d1a303c39918a477f76fe8cc9534115] https://lava.sirena.org.uk/scheduler/job/1340569
# good: [9599afaa6d1a303c39918a477f76fe8cc9534115] KVM: arm64: Always start with clearing SVE flag on load
git bisect good 9599afaa6d1a303c39918a477f76fe8cc9534115
# test job: [714307f60a32bfc44a0767e9b0fc66a841d2b8f6] https://lava.sirena.org.uk/scheduler/job/1340691
# good: [714307f60a32bfc44a0767e9b0fc66a841d2b8f6] kmsan: disable strscpy() optimization under KMSAN
git bisect good 714307f60a32bfc44a0767e9b0fc66a841d2b8f6
# test job: [db8fb490436bd100da815da4e775b51b01e42df2] https://lava.sirena.org.uk/scheduler/job/1341008
# bad: [db8fb490436bd100da815da4e775b51b01e42df2] s390/sclp: Add check for get_zeroed_page()
git bisect bad db8fb490436bd100da815da4e775b51b01e42df2
# test job: [4757e8122001124752d7854bec726a61c60ae36a] https://lava.sirena.org.uk/scheduler/job/1341258
# bad: [4757e8122001124752d7854bec726a61c60ae36a] USB: storage: quirk for ADATA Portable HDD CH94
git bisect bad 4757e8122001124752d7854bec726a61c60ae36a
# test job: [1f079f1c5fcf13295fc1b583268cc53c80492cfb] https://lava.sirena.org.uk/scheduler/job/1341360
# good: [1f079f1c5fcf13295fc1b583268cc53c80492cfb] tipc: fix NULL pointer dereference in tipc_mon_reinit_self()
git bisect good 1f079f1c5fcf13295fc1b583268cc53c80492cfb
# test job: [cee5176a98accc550585680213f71d1d307a2e9a] https://lava.sirena.org.uk/scheduler/job/1341449
# good: [cee5176a98accc550585680213f71d1d307a2e9a] virtio_console: fix missing byte order handling for cols and rows
git bisect good cee5176a98accc550585680213f71d1d307a2e9a
# test job: [5e9fff164f2e60ade9282ee30ad3293eb6312f0e] https://lava.sirena.org.uk/scheduler/job/1341692
# bad: [5e9fff164f2e60ade9282ee30ad3293eb6312f0e] drm/amd/display: Fix gpu reset in multidisplay config
git bisect bad 5e9fff164f2e60ade9282ee30ad3293eb6312f0e
# test job: [ecc30d7f041daf7de7d0d554ebeeaec1a0870e53] https://lava.sirena.org.uk/scheduler/job/1341795
# bad: [ecc30d7f041daf7de7d0d554ebeeaec1a0870e53] net: phy: microchip: force IRQ polling mode for lan88xx
git bisect bad ecc30d7f041daf7de7d0d554ebeeaec1a0870e53
# test job: [40dc7515d0b13057d576610a8dd23ccb42d4259f] https://lava.sirena.org.uk/scheduler/job/1341924
# good: [40dc7515d0b13057d576610a8dd23ccb42d4259f] net: selftests: initialize TCP header and skb payload with zero
git bisect good 40dc7515d0b13057d576610a8dd23ccb42d4259f
# first bad commit: [ecc30d7f041daf7de7d0d554ebeeaec1a0870e53] net: phy: microchip: force IRQ polling mode for lan88xx

--O4i/hNuYEfmFpkoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgSqycACgkQJNaLcl1U
h9D5Bwf9EeXIvXszO1tBDS/6cWnKGy4O2RYhYlouW/pMJCgi74GrRcTl1zHpdPoW
jVRZcDg9d+y43v47B4i+PYE3vKqZV0VSFIGudhEirrHHoSySuHBjqrZWbGRAoR9S
Z6vYCJgMK2VAbwnbKbKNSf+GLmbu/gJliqtFAKsN9PKmkzeaIE/wMDaP+sqV/ZVU
2Bha9utW7nHI4txcGLSH/uTUvxojGPqxxh5C/WpOgV8UkaB8yO4LsAZtgCgSGGNV
PwbjSclnlBqJfY7F01SyhDMHOBe8VlAO0BaupEoJcgJ9krMGmn7HADuX+VHdIR3T
gbZo6A/82+EV1R8HNnVICtnZDtv5mQ==
=57/T
-----END PGP SIGNATURE-----

--O4i/hNuYEfmFpkoL--

