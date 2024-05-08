Return-Path: <stable+bounces-43450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D88BFB2C
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 12:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B124A1F2356E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC3481AC8;
	Wed,  8 May 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="mBST9Wei"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689681721;
	Wed,  8 May 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164907; cv=none; b=tOvjTN8MuaqlfhxmH+yH2CpuirpYVyW9Jf8IyFe2AaK3o5OYIEU5tmUHpIrTf38xlXtvlykONkCD1lTjk5NA59MZ2i0xdLxtWycI7alBba5GzMQ1nWLMj5/4ZxqejJBdO7J3hgutLCW2ebfomwczOIT3Pj6AN3/Vyf5+wtKox94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164907; c=relaxed/simple;
	bh=dLuhAUITmu9lMJa3rjR3o7DPxZ8wq1FJLynkLwnAMdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h8kV3Hc1ZT6NYLhUYy/GCxnn3qWPu9mUo9+MZKaQyjCP7GyWTCy5IirrUeyhB/ACO9kvdqpOQ9TcRN9bAVhBKw7SHqZfy+FWAJJ0LtdYpe31udW12/kUjPQ+64W52o33foUq7xOpJQGu6Zw3lDVhv8OR/bA6yJz1naVh1Yufj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=mBST9Wei; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1715164902; x=1715769702; i=christian@heusel.eu;
	bh=ctbrKhfuIZgCSTUk757c5VhZ+bwkTvoO+lZvQCKN7k0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mBST9WeiLrWzCgKvuJarCrI0fCtkRdcUk2TQkHELZ1vzUUv4legRb+tQUGLfRaNX
	 bfkv19JZP3UZxAt73kCo7TjtD3S4p+KbLsvcxYWb7/Re0rT3E1vzetYggxuz2H3QA
	 GLkB5t4GlbecE2hhUhQd2c3mW3FyrSXNZ0sj8S3kfGmJbXNuzkjLFF0SL0iq2Ow9o
	 u0MufcAWT5INN7GWlMvON0skrgEvW033mWBzDYxMZH+qvDLOFSEqa1U+duOwrKkmI
	 TV8GhI1Hf8wLWWghT56DKC/dr8RtLfeFL1sEfsTaQn/9cx8FbJqn9SZjs6VVJzrgr
	 0lSBvKSUkF/GF1SYAQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mf0FY-1sWpk32bL0-00gU7R; Wed, 08
 May 2024 12:36:25 +0200
Date: Wed, 8 May 2024 12:36:24 +0200
From: Christian Heusel <christian@heusel.eu>
To: regressions@lists.linux.dev
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, heftig@archlinux.org
Subject: [bisected]: Games crash with 6.9rc-5+/6.8.9+/6.6.30+ 
Message-ID: <gifkxwcrswqevdig33inrsieahso2lcxbhcawu6d2qprnujoij@eqg53vwjamts>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xqinxhnairj62jik"
Content-Disposition: inline
X-Provags-ID: V03:K1:6LxZyhP0DpvM7+rsPY5R/vNM32tUaZ87PCBXXjLm5P6++9o43pP
 SWjvt/SyazZ6arPSD0DoGpZ0u+nK7l5oR8n869WOlzQPPIyLgYNkgQBHObt0OxP/IO+fSsQ
 SjefCtgo9UdquAsTsR9JLd7EPsmHR9OCJTE92yZJqzS7x6i253B2CKyd0rD3Kgfwkd2kUkZ
 lhYb0eyFGeQqbMO6e0RXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cszq8r0cKxA=;kypwBu4dY1KoZtxhqEkK56m+Mbf
 M+nI9ABjv4KGWXx+W7mDj8aNvjXyN1s9rQ3dV5PU95I17GuG2JNU4DRP6urETPvCimAu+l59e
 x7opSkd0110dnBnliZYrzX7Ob48CNxJPMGEvh7aZgzLeAqr5DvgBpfUm9J5WiXDXnSBWlQrpV
 1n7cTxIgdPO/x8To6oKsRiAe4gW0fXpT8ihNBxwKYI2kdP9nFUF6Lc/5C3YGKpQbjk6A8MJcF
 YBYvE/MXnCtefMMNjjeuT7dUqS4r8Rtgm9rcljXIAAsdFxI/Y21FDnwtQGHIbMpkqZuDsXPlW
 pL1/fRomzYJncL5wh75EE0sTD0dHeIkl/JJYwDRrAVvR4Uncf0Eo0pI98fhopsKuRnW990v2u
 zzZ8r3MDwUhyqXljhSgOHO6qKGyA8MGg4eAZucONhW0AaPITRimkF9WpNPhxwqgXB44rjsroD
 No+DMwWrx6asorotrmmiwRmoS9cf95QsI/H4XJomcvl3vH4O85m77lk+3pYIQouppYDtNj2L5
 VWMIi9yiNJNdHZRvIsBow9hCLOnBLlkZp9MGm4Mdie3HBwlGDgYwWjtpkc1smqdg2TN5p9fXD
 dGNWcywaEdJTMyrSh7sKkOVZ5+8nw6VB/CI0Ksut+5Hnfe8rqLx8YPgvFvKGFhbq9t/k6eTAI
 DcOJl8u8QwQ9isHr71nVqz9PY/0zIUfuzJJEDit4kh64w/0cjFIF5sinkaaOqpGbtiG9++90r
 q2tGbqdJZIh5Lti4ZorqxEDCLfTdAarCg==


--xqinxhnairj62jik
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I am reporting this to the regressions mailing list since it has popped
up in the [Arch Linux Bugtracker][0]. It was also [already reported][1]
to the relevant DRM subsystem, but is not tracked here yet.

The issue has been bisected to the following commit by someone on
Gitlab:

    a6ff969fe9cb ("drm/amdgpu: fix visible VRAM handling during faults")

The DRM maintainers have said that this could be something that just
worked by chance in the past:

[Comment 1][2]

> Christian K=C3=B6nig (@ckoenig)
> Mhm, no idea of hand. But it could be that this is actually an
> intended result.
>
> Previously we didn't correctly checked if the requirements of an
> application regarding CPU accessible VRAM were meet. Now we return an
> error if things potentially won't work instead of crashing later on.
>
> Can you provide the output of 'sudo cat
> /sys/kernel/debug/dri/0/amdgpu_vram_mm' just before running the game?

[Comment 2][3]
> Damian Marcin Szyma=C5=84ski (@AngryPenguinPL):
> @superm1 @ckoenig If you can't fix it before stable 6.9 can we get it
> reverted for now?
>
> Christian K=C3=B6nig (@ckoenig):
> @AngryPenguinPL no, this is an important bug fix which even needs to
> be backported to older kernels.

All in all this seems to be a rather tricky situation (especially
judging if this is actually a regression or not), so maybe getting some
input from the stable or regression team on how to handle this well
would be good!

(I'll add that I can give no direct input on the issue itself, see this
as a forward / cc type of Email.)

Cheers,
Chris

[0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/47
[1]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
[2]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343#note_2389471
[3]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343#note_2400933

#regzbot introduced: a6ff969fe9cb
#regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
#regzbot title: drm/amdgpu: Games crash if above 4g decoding/resize bar is =
disabled or not supported

--xqinxhnairj62jik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmY7VagACgkQwEfU8yi1
JYVCSQ/+OwqhXHQ9w+17JgXnGR+0DgIE0eKNzTc85XVk9A28pHnCH93tWsR4Nrwr
Snx6dvu8f0HSnUUuk8vnWLUrBux6W5hHMu0YKBoXHz03SRgj8SbQmidfl1uf+2PC
3SzNfI28yy4VZO/wyTq8LiDikGzpPrdj59eb9kxQQgaTk9YSu9DkmzaQ8GmqS/R6
dCUb5rl0zFSty+wl/H5NxvfPxPvMh0ilrSJ3iSjJRPjWRzLEVI5iBnQdfwnCnwdY
fPm0eyEVy1WjsgrkDSp9OdSiikkpr1IbHHlvylm1oqSKtp5Lx0Y4W8Xx1Qrc5gJK
ZSj+5kr+PulnphcWkSH9GTJsKXpR98uZbSZ5WDlHu0fFmZiPnluer1Yi8BKkhKYR
ocIsC/yRvuC46Q0ieKYGi6JBS70pEXRfJNLYnf0mqpGOTRBYMcmM4HpN8Afqo/qT
a3iDdMgEyFA6gcW4RSH1qLgeqkZNPuotXk91kZTpi4o2/DR/tCOYxSEvx2WPL8/8
EcWgUic7wA+r/xAVTH3jMCHXaDU9uqZnWdUWqxSjqa024O8LwGS7M8Ip20T/EVBB
juhPJU1UqrBIH279Qy4uam0AL+4lWV2kAMV2daD02LMrtcRpcUX/dCj+pbJQx963
Mh8KkvZWfR/QV1KPlrbeMvUYZ4PsVDbUd+X3L70x1yk/QtBfSno=
=XCM/
-----END PGP SIGNATURE-----

--xqinxhnairj62jik--

