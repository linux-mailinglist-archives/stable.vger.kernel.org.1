Return-Path: <stable+bounces-151487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D0ACE961
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 07:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAB87A331A
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C31CB518;
	Thu,  5 Jun 2025 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iJH3iF7Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BEF143748
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102265; cv=none; b=PsE6ee5BV26+ugvP/sO3Vj1/xCWmg/YDqheQetRiCo2j9NPSzfWU20r58/wyt17uKlQc6Y+iHTarWpUiR5sk9wKaxyByByrH1SH+ZCoYAOEpAXpfB7yuBy4rsH9yoFOFS91OJRKA6VHO5N++GLuB5VWNNzxDhSmo2MhPoMLI+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102265; c=relaxed/simple;
	bh=JEKQHf7KTDpSoBNj2JzVwKj3K8revmSMcJuSldVWSt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZxwG6Yk19BuQamPbHSYFPUIUCbxvqY3ag4k3Eo/fjxw05EviNaeJfbrkQ9GMGDh6S0jt79qcmyuwE/yMnVWdyH+HYvD2B60GMtJXa36n2T/Uv/LkrC8L618HQZiucBDls47Rae9lOozp+LhlS2i6DGeMMDiVfbMsw07FQ0aTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iJH3iF7Y; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60410a9c6dcso1145508a12.1
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 22:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749102259; x=1749707059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwKG2zaLaWGtv1XqdWe1XB7aGJk5xejqC05SCDt1e6M=;
        b=iJH3iF7Yvz2XDyTsy7AGGm4WJy3R2OyIkHoXFI79FAJWuCQJCnAU9rNvXvG1qXibfg
         F56vm12wpkqGb23SGtvpCd4oGQAg8QYrXpp42Hs3h0stiFJbFQvRxLFwweLNZceSboJ+
         ajE9OK7gtqfDItvHuVZLbICG93hiwP0h/nvdbg2BySI3C50AoXa+7TkAg3SDJdcex179
         OME+LRb5oReqfJ3JQ3lHWgFLOqzWlzuHNlf1b2RliRbfi58HaO57hA4ofdcUn3dcLap8
         52zWLp1ZWoclWOgxuPmei1RBrSsIipgluyN69oNVFkDPhiVKHOUwykCXPBX4tFUEysZC
         mm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749102259; x=1749707059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwKG2zaLaWGtv1XqdWe1XB7aGJk5xejqC05SCDt1e6M=;
        b=oyi40Tu9DIykENtZnWLH0BS5hO6f2nHqn9JdYSx+QUpRfeL3PPMj3D0hTY92MTX6rx
         xVKgHSAPkk9cY6Pi/Frkbh/aaFccAefehAyG58OuUJKBqpie1oajsFng6lHG5duUCtu9
         eLtHSaUUsIwVgWGHa3VLZRmEe2I6sG0/PpcyQt+ssEIhSN2agxrdSpUaehEhpYBvFHFg
         BeQG7VYiUudQrt0RPgZaifNNtIgamGxOQSdvK81Pr5SofL+Hg2vaLjOEzXczFsudBdUl
         4r46V1j2i66qDe53dESkhChxigFLESVrZ6k4a2cvtavSRAyFTsMSdHCu+FJUrKRmgAGv
         qLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLKsM4j/9xN559aTLYfrSHiJCcC1gpkqs93JWgVElW5IAT4guLaIIFz91sS+/B3Ul9QlUIqXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs3GADB/TTVBOP7aMKuXiXQNdJsIu+7xH+ciHABd4rAofH/yAJ
	jLZVszX/7kNrt7pdjl2I27qV++eMNCuDomgB3fJG9Ud1b3g5USYKdfJBw8k3T0FCf90=
X-Gm-Gg: ASbGncvbrj4QLaNqDufUwPM1/sCNAkEmb2WE/QUyCgBvi1tuAqLEIWwhRVgF3jwKpvx
	HxtLIuaax6kFWZBV258WLeuuKd4MJ2WlOTck12NsTOMBslGiIrfush3RIMx+nvPTmejpAUcL3T9
	7dFojeZKmHnPrXv/NzclbjrLR5e6GJvwxBrlkvzrycTKH+s2r84TCRxVKyXYg4GLDfZyThi+lfO
	GEv/ZzfxINug3GpE80/wJYMOdxfrthifqEK/1Nd4k9BPc1wuZHlVUZsO3j9/R4zKZmdJrkh7ogV
	/CsTve1dc1PznKuACXJ1dv0o4WRI0IwUy8aEzd0G08RdrX2jNLuuzrvz
X-Google-Smtp-Source: AGHT+IHOhP2w7u1LXSjaR40qUhkYGZTvuTeSGU2G/FbiS9E+6lboX63zdbOiA/eozyPJRwe/mJG6lA==
X-Received: by 2002:a05:6402:268c:b0:5e0:82a0:50dd with SMTP id 4fb4d7f45d1cf-606ea17da03mr5713402a12.27.1749102259398;
        Wed, 04 Jun 2025 22:44:19 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ada5e2bf045sm1218359566b.108.2025.06.04.22.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 22:44:18 -0700 (PDT)
Date: Thu, 5 Jun 2025 07:44:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
Message-ID: <ziq6dniodo5zgnf427btbyafaxdx3kt6rym2gupuiymvpwnmcy@fh76ssxyirmw>
References: <20250530200918.391912-1-aurabindo.pillai@amd.com>
 <CADnq5_P1Wf+QmV7Xivk7j-0uSsZHD3VcoROUoSoRa2oYmcO2jw@mail.gmail.com>
 <jn3rvqffhemwjltd6z5ssa2lfpszsw4w7c4kjmkqqbum6zqvmi@pv6x2rkbeys6>
 <CADnq5_PHv+yxYqH8QxjMorn=PBpLekmLkW4XNNYaCN0iMLjZQw@mail.gmail.com>
 <2025060410-skinning-unguided-a3de@gregkh>
 <od2jpxazsa6ee6fqom7owcgh53lz3wjjjk4scoe2mxjzrytl7f@jwwwxfuo4pkj>
 <CADnq5_OdFQhokdysSHdeBca=UViCcqKWmfbedMAadWFWBiNE=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cl2buqzcwapchshu"
Content-Disposition: inline
In-Reply-To: <CADnq5_OdFQhokdysSHdeBca=UViCcqKWmfbedMAadWFWBiNE=Q@mail.gmail.com>


--cl2buqzcwapchshu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
MIME-Version: 1.0

On Wed, Jun 04, 2025 at 11:09:15AM -0400, Alex Deucher wrote:
> On Wed, Jun 4, 2025 at 10:55=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Hello Alex,
> >
> > On Wed, Jun 04, 2025 at 03:29:58PM +0200, Greg KH wrote:
> > > On Wed, Jun 04, 2025 at 09:15:14AM -0400, Alex Deucher wrote:
> > > > On Wed, Jun 4, 2025 at 5:40=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > > On Fri, May 30, 2025 at 04:14:09PM -0400, Alex Deucher wrote:
> > > > > > Already included in my -fixes PR for this week:
> > > > > > https://lists.freedesktop.org/archives/amd-gfx/2025-May/125350.=
html
> > > > >
> > > > > Note the way this was done isn't maximally friendly to our stable
> > > > > maintainers though.
> > > > >
> > > > > The commit in your tree (1b824eef269db44d068bbc0de74c94a8e8f9ce02=
) is a
> > > > > tad better than the patch that Aurabindo sent as it has:
> > > > >
> > > > >         This reverts commit cfb2d41831ee5647a4ae0ea7c24971a92d5df=
a0d ...
> > > > >
> > > > > which at least is a known commit and has Cc: stable.
> > > > >
> > > > > However this is still a bit confusing as commit cfb2d41831ee has =
no Cc:
> > > > > stable, but a duplicate in mainline: f1c6be3999d2 that has Cc: st=
able.
> > > > >
> > > > > So f1c6be3999d2 was backported to 6.14.7 (commit
> > > > > 4ec308a4104bc71a431c75cc9babf49303645617), 6.12.29 (commit
> > > > > 468034a06a6e8043c5b50f9cd0cac730a6e497b5) and 6.6.91 (commit
> > > > > c8a91debb020298c74bba0b9b6ed720fa98dc4a9). But it might not be ob=
vious
> > > > > that 1b824eef269db44d068bbc0de74c94a8e8f9ce02 needs backporting t=
o trees
> > > > > that don't contain cfb2d41831ee (or a backport of it).
> > > > >
> > > > > Please keep an eye on that change that it gets properly backporte=
d.
> >
> > I'm not sure if my mail was already enough to ensure that
> > 1b824eef269db44d068bbc0de74c94a8e8f9ce02 will be backported to stable,
> > so that request still stands.
> >
> > > > DRM patches land in -next first since that is where the developers
> > > > work and then bug fixes get cherry-picked to -fixes.  When a patch =
is
> > > > cherry-picked to -fixes, we use cherry-pick -x to keep the reference
> > > > to the original commit and then add stable CC's as needed.  See this
> > > > thread for background:
> > > > https://lore.kernel.org/dri-devel/871px5iwbx.fsf@intel.com/T/#t
> >
> > Yeah I thought so. The problem isn't per se that there are duplicates,
> > but that they are not handled with the needed care. I don't know about
> > Greg's tooling, but my confusion would have been greatly reduced if you
> > reverted f1c6be3999d2 instead of cfb2d41831ee. That is the older commit
> > (with POV =3D mainline) and the one that has the relevant information (=
Cc:
> > stable and the link to cfb2d41831ee).
>=20
> The revert cc'd stable so it should go to stable.  You can check the
> cherry-picked commits to see what patches they were cherry-picked from
> to see if you need to apply them to stable kernels.

Yes, and I'd expect that the scripts used by stable maintainers looking
at 1b824eef269d will apply that to all stable branches that contain
cfb2d41831ee or a backport of it.
Given that that cfb2d41831ee wasn't backported to any stable kernel and
the commit itself will only be in 6.16-rc1 the set of kernels to
backport the revert to, will be the empty set.

(In git commands:

	$ git log --oneline --source stable/linux-{5.{4,10,15},6.{6,12,14,15}}.y ^=
1b824eef269db44d068bbc0de74c94a8e8f9ce02 --grep=3D"commit cfb2d41831ee5647a=
4ae0ea7c24971a92d5dfa0d upstream"
	<void>
=09
If however you look for cfb2d41831ee's twin, there is:

	$ git log --oneline --source stable/linux-{5.{4,10,15},6.{6,12,14,15}}.y ^=
1b824eef269db44d068bbc0de74c94a8e8f9ce02 --grep=3D"commit f1c6be3999d2be267=
3a51a9be0caf9348e254e52 upstream"
	4ec308a4104b    stable/linux-6.14.y drm/amd/display: more liberal vmin/vma=
x update for freesync
	468034a06a6e    stable/linux-6.12.y drm/amd/display: more liberal vmin/vma=
x update for freesync
	c8a91debb020    stable/linux-6.6.y drm/amd/display: more liberal vmin/vmax=
 update for freesync

Having said that, I don't know how the stable scripts work, *maybe*
having mentioned cfb2d41831ee in f1c6be3999d2 is indeed good enough.)

So if you had reverted f1c6be3999d2 instead of cfb2d41831ee I
wouldn't have wailed and I guess Greg would be moderately happy, too.

> > Getting this wrong is just a big waste of time and patience (or if the
> > backport is missed results in systems breaking for problems that are
> > already known and fixed).
>=20
> Tons of patches end up getting cherry-picked to stable without anyone
> even asking for them via Sasha's scripts.  Won't this cause the same
> problem?

No, the problem only arises if a patch is in mainline twice and one
variant is backported to stable and later the other one is reverted (or
otherwise fixed). Patches that get backported without Cc: stable are not
a problem.

Best regards
Uwe

--cl2buqzcwapchshu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhBLq0ACgkQj4D7WH0S
/k5/cgf9GRyzBWy/2vgCw4gzWNjwd6MJ6Em3i3VoQDQdPrkgB6I+0aLBWV8Iu57/
kAdBIIblSXunciAOSWJ/ZSLw46ePyMM37rCfDPG5ehE3e+2ByNvUBWVBHTr2gQ1P
KLVXN/AMU2IzeQsVyL1Uw3tG6vN48ra1SFaR4Fg2p2S/BUKTcerD71PhskOb0GmS
IWUSie+DP2lOy0fKp6JElSHySWfwSdEAN/jBqsutBrFEKt+HcEKFi8gJPt3N0psa
+sZY7cif4W/ETaMTANTBF2U+ca+sgSeyU8tqYUYF3PMpJ4Q5wUiR7vsHsI5lEAcZ
dNEkrSI9/yUCp9U1zporeoIc4qNS+g==
=xP3d
-----END PGP SIGNATURE-----

--cl2buqzcwapchshu--

