Return-Path: <stable+bounces-47926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D008FB444
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55A11C21BFB
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139098F45;
	Tue,  4 Jun 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIZQHIFy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91403D7A
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508912; cv=none; b=BhPrdh7dMm/1A+LLuNpiEVGYkeg0ru8bHennPGOjF2lLezshnGX2g5sYRJw8Ypl80CmOw8mqIxR7TOfckMuQw6G69Yt3eb2VItqTJdM1hoBQ+FxoCg5HhBfRiEyyG6YoPYZ9OoAw0579fsNUQpS1VlBj/y50KPpczpbSanjNMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508912; c=relaxed/simple;
	bh=kt4zIU4T3asrouZYydDBqBFYoLxVlembWzB0nYZhz3U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GnXD32XH4YroYSNNf2mBTcpKBPaF+ySCKEmm9cassQbE8fAvzHRywA9i4jlWMRFAtQM4VZKXD5WNmZBaN3aud83dxkGGSu5eJmHawjsFrWA4YQ1bEdMWd2AoSLHGE2bK+KCfbxHoepNSyddaMv1FHHvzxdG2olhiOpm63xHKLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIZQHIFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EA3C2BBFC;
	Tue,  4 Jun 2024 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717508912;
	bh=kt4zIU4T3asrouZYydDBqBFYoLxVlembWzB0nYZhz3U=;
	h=Date:From:To:Cc:Subject:From;
	b=fIZQHIFy7fXwJrjO5QmijyN6pZfwbOPtexKIRLECCkgdO8b0CBE2NalRtfKH/aoAr
	 ZmjdfAoer4Ru6GlxAmWtJiI2XvSzb9ku9sX/NX91NEJDVwO8EMKrgumlkkr2mlIZhk
	 VZW47lfMhS+gx7seblLzDAN9bRG1NXhKCjob15jSYKF9mOlUqr1y9VRPE/y48CFhn9
	 G85Mca4vu83GByFKjNSoG914ZcR3XjHgYj7jLAoga+1ySmuhG/7por8/LpaIM+QV9A
	 8/UbE+PW1vT1BJ+nKlRFJd54/q840r6HO3YphGAYWRlbsMAffUYOFBb3BEdklamC4n
	 9nNUqETnL+SJQ==
Date: Tue, 4 Jun 2024 14:48:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Widespread breakage in v6.9.4-rc1
Message-ID: <dc0c4e9d-e37c-442d-8b75-72f0e2927802@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zUjbg6elxfCnzsDp"
Content-Disposition: inline
X-Cookie: Is it clean in other dimensions?


--zUjbg6elxfCnzsDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm not seeing a test mail for v6.9.4-rc1 but it's in the stable-rc git
and I'm seeing extensive breakage on many platforms with it due to the
backporting of c0e0f139354 ("drm: Make drivers depends on DRM_DW_HDMI")
which was reverted upstream in commit 8f7f115596d3dcced ("Revert "drm:
Make drivers depends on DRM_DW_HDMI"") for a combination of the reasons
outlined in that revert and the extensive breakage that it cause in
-next.

--zUjbg6elxfCnzsDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZfGyoACgkQJNaLcl1U
h9B8ZAf/fPxy0VD7R8X2SgpUZ/UhrabuzWq1bZIuLVwxceVhl2SXr9BhXpKf1I0U
K0ZJcxCwu9z7rNh3c5Xee+8TiJ4qG2h3DhKrijgCICVdqUAAQZcjLuLEnebPjOhJ
LjsJOK45p+VcrqEZCtr+U07psWAYPaOJ2n7ZMysMyJmen5y/vUFhZJMbXlpee81C
Rc9S6xcCSsLOLhytJMKmEgsbhJX4kMD4S0lQS7vdil3jXu+zNJf/xWMZJoxnek04
/WfNzWHpzpoSDJuQ1YvLpHcX2D2ue3Wz4D3lryPa3AWkk+R/eGKZ3iGJKzhG7a+N
i9ncbbQJHjIvJWHrK30hzVPSQyHrEg==
=HToz
-----END PGP SIGNATURE-----

--zUjbg6elxfCnzsDp--

