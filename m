Return-Path: <stable+bounces-151436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6716ACE0CF
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C977A7388
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9934290DA5;
	Wed,  4 Jun 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="miWmrfkb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D928F950
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048934; cv=none; b=TkFZoY3GaSFd1fFYElRfx45wIFgY0awpHdd0121TJeFwofD9ncrJmqPyOEWCffpsqxhmkjn982FE4jZmObSFvElFgwRqwpavbRbnP2j46oEXkzNIhZArzU3rYHOv6Gm9Sx8rPa7BS1Fv3ZBZKWw1ZBuuMD57VN2Ck5J+CThMvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048934; c=relaxed/simple;
	bh=PfvKO89pEfzIlLDzONPbGEjVy/n82f47oCu5l669WfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDqCfOCWjrtYRIGI4irTncZTdfOvhWKwVAhKTi7xZHmCO2O4u1lQpiwVOli8OQZPHrjqFx8sLI8qA9y1TJ2JTnKQVHwvApkTI6E+SWyWi2yN88MRoLJbkHlxOjLF+RPSmk+xrrY0c4RouRlizNaVG8fFnNxQ1woMC2Dmm0ZC2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=miWmrfkb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442ea341570so49354215e9.1
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749048928; x=1749653728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFeYFxjl/DBtEkZai5cqMvrzK0TXtdhp23IyffLatWY=;
        b=miWmrfkbb9Pt20EuPckG9fJkk63/YS5lra6qHthVCitTuxkAQAo0b9OUmtQzm6RVMJ
         qwE91sTpCVih4e404b+0GaJy1ZOnWAlQpObE6KfFkdg6j8W5HcgF1tH2UFDvRet3ffXu
         ODpyMF7UzFr5WK5LXU/qn4TqroVwgaz+Mjj2Y+t4AsF/9U2XZc3fpiJMuVOBEeop+inn
         EWAK55xO72snHDZMHzxsKOi2iILU7zZiitxGlJN3u+RTH92w8aSlyis+WWpTJ66WugZT
         bvdrzqXp23AVcPoC9bPxXOW10w3dErrxvgFY9msegT9SD5zVIpU9/O6fPVnOeQ7voxzm
         E7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749048928; x=1749653728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFeYFxjl/DBtEkZai5cqMvrzK0TXtdhp23IyffLatWY=;
        b=O2iLVRq+o82wvwo1OKz/OlErmbRq2D50CUPKn9gIouwMV81ZUHre02T8fL7cTHV/7K
         1kNQY2uzEqxKDizxq5FKZY/d9UQn2cmYXQ5O7Vs4phvdRIKadIv5sQq9SMEL2oLwPSaY
         MREojOUG2sXpXmbEwrDxPkI2w2d7xpIRqBFB1ZkR5/iGG3me7d7zKjAej7Rt2cwx5ZtK
         vik+UfiDsiQFJeIiRamNoUJP4z9Er1bPdib7Pu9lN973sa9CBtWZwBWoMm4IwoeWhtwT
         S20Js5J/zQOCYAoRQrc1Cumo/7B/A7GjdF8lEFgUueaXAWYeTbMpiKZqy4x0mAtgty1v
         Tchw==
X-Forwarded-Encrypted: i=1; AJvYcCWTAfnrpCP+ZCRDYE6UM14GoUjlbZSyVQz5lxubdXqVYhXShZPcSTL4ErymPzwcnQgrWv1P3eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyASKtm4zH9In0nSxpDtYVDzsoAVHMTnQpewzKDmENgdEEwLS//
	pHNFSRfX5yVZAliLRKIJymLyhFEXI8t7NKCBzmYDXA8hbrYzrE43m5mS4JGyf6026uI=
X-Gm-Gg: ASbGncu5Tjw7ycXPvsPg4Ef1xiGkWu0btA+8tTF0xTSOL1OZWF6C6156+LSn17J1pt3
	5jumaWFk4IXERHflhRItiADQgmctbSi+vdtsPQXMCkP/vldY4jPyEwjqCYQoXR2r4tixaZ9CcNM
	6xpsVU8FyGn+oJ0LNs5/Q0jKeEnIJPt7PWy0w9dGMklfTUkafVEbA8hxNMfjNn/P0oLPZkd/5t8
	zxViAx93uHEhxVx6QHs/08nnzcvXzHej6J6UTuacNYov7KycTip0e+24zA0SjBC2lG1Uw67leqh
	xdl4CJYKtwWcuLNYLmQAmFDM/s7fXdDODC6fE6lFb2PVg0cGjB5gZZW2f3D8iTaSj7O7X452oLA
	noEUrLE/PLPVBhiIRbQ==
X-Google-Smtp-Source: AGHT+IHSxvzit4N1aBhjtuAEWmHARXYthRvFMKFDYBEwzs5x1pAkTMnA5Q6rw7l+Tyg1a3QZL/RlSA==
X-Received: by 2002:a05:600c:3b91:b0:450:cfcb:5c83 with SMTP id 5b1f17b1804b1-451f51249ffmr21389665e9.30.1749048928519;
        Wed, 04 Jun 2025 07:55:28 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-451e58c348asm43012505e9.3.2025.06.04.07.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 07:55:27 -0700 (PDT)
Date: Wed, 4 Jun 2025 16:55:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
Message-ID: <od2jpxazsa6ee6fqom7owcgh53lz3wjjjk4scoe2mxjzrytl7f@jwwwxfuo4pkj>
References: <20250530200918.391912-1-aurabindo.pillai@amd.com>
 <CADnq5_P1Wf+QmV7Xivk7j-0uSsZHD3VcoROUoSoRa2oYmcO2jw@mail.gmail.com>
 <jn3rvqffhemwjltd6z5ssa2lfpszsw4w7c4kjmkqqbum6zqvmi@pv6x2rkbeys6>
 <CADnq5_PHv+yxYqH8QxjMorn=PBpLekmLkW4XNNYaCN0iMLjZQw@mail.gmail.com>
 <2025060410-skinning-unguided-a3de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4676vzu23k66bjlv"
Content-Disposition: inline
In-Reply-To: <2025060410-skinning-unguided-a3de@gregkh>


--4676vzu23k66bjlv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
MIME-Version: 1.0

Hello Alex,

On Wed, Jun 04, 2025 at 03:29:58PM +0200, Greg KH wrote:
> On Wed, Jun 04, 2025 at 09:15:14AM -0400, Alex Deucher wrote:
> > On Wed, Jun 4, 2025 at 5:40=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > > On Fri, May 30, 2025 at 04:14:09PM -0400, Alex Deucher wrote:
> > > > Already included in my -fixes PR for this week:
> > > > https://lists.freedesktop.org/archives/amd-gfx/2025-May/125350.html
> > >
> > > Note the way this was done isn't maximally friendly to our stable
> > > maintainers though.
> > >
> > > The commit in your tree (1b824eef269db44d068bbc0de74c94a8e8f9ce02) is=
 a
> > > tad better than the patch that Aurabindo sent as it has:
> > >
> > >         This reverts commit cfb2d41831ee5647a4ae0ea7c24971a92d5dfa0d =
=2E..
> > >
> > > which at least is a known commit and has Cc: stable.
> > >
> > > However this is still a bit confusing as commit cfb2d41831ee has no C=
c:
> > > stable, but a duplicate in mainline: f1c6be3999d2 that has Cc: stable.
> > >
> > > So f1c6be3999d2 was backported to 6.14.7 (commit
> > > 4ec308a4104bc71a431c75cc9babf49303645617), 6.12.29 (commit
> > > 468034a06a6e8043c5b50f9cd0cac730a6e497b5) and 6.6.91 (commit
> > > c8a91debb020298c74bba0b9b6ed720fa98dc4a9). But it might not be obvious
> > > that 1b824eef269db44d068bbc0de74c94a8e8f9ce02 needs backporting to tr=
ees
> > > that don't contain cfb2d41831ee (or a backport of it).
> > >
> > > Please keep an eye on that change that it gets properly backported.

I'm not sure if my mail was already enough to ensure that
1b824eef269db44d068bbc0de74c94a8e8f9ce02 will be backported to stable,
so that request still stands.

> > DRM patches land in -next first since that is where the developers
> > work and then bug fixes get cherry-picked to -fixes.  When a patch is
> > cherry-picked to -fixes, we use cherry-pick -x to keep the reference
> > to the original commit and then add stable CC's as needed.  See this
> > thread for background:
> > https://lore.kernel.org/dri-devel/871px5iwbx.fsf@intel.com/T/#t

Yeah I thought so. The problem isn't per se that there are duplicates,
but that they are not handled with the needed care. I don't know about
Greg's tooling, but my confusion would have been greatly reduced if you
reverted f1c6be3999d2 instead of cfb2d41831ee. That is the older commit
(with POV =3D mainline) and the one that has the relevant information (Cc:
stable and the link to cfb2d41831ee).

Getting this wrong is just a big waste of time and patience (or if the
backport is missed results in systems breaking for problems that are
already known and fixed).

Best regards
Uwe

--4676vzu23k66bjlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhAXlsACgkQj4D7WH0S
/k5tSgf+IT+JU+iWWruPiKMIZvDjrGgIiyUzCYKZ4zhwS6OiRR+0Ct7BNHmvfyz3
BQGIVanJELGBUIJ7vT2wIXTaO5NSoZPD74vA3CZwf96QCehGEMsdj3TPTNPQdp2J
cJn0EFo0GpoAQHM4NRycogPsKTNSRhLUqmBqeqq6j8jA0z5eefctPMdf3gtU27+n
7guSJwQ8bbOl3BT36Oa+0ZcGrtNncIMovoYnGZY+9jI3dA4SZtT6rnf8i502K+eT
odcn+CgkEVBY805MDH+LM2G3h2WHAVFWBKe9u9to0lfSmw6XMcJj+t/h1ZFFpfEE
UPHXmTn9BePLuYCI/JXa+aGWx56BYA==
=OblD
-----END PGP SIGNATURE-----

--4676vzu23k66bjlv--

