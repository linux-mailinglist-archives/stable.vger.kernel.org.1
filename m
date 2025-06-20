Return-Path: <stable+bounces-155072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8925AE181F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FBD1BC22EE
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01972283FD4;
	Fri, 20 Jun 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KMDWqK2Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D301D54F7
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412888; cv=none; b=hiGx84KxdYwDCs9k3o6Od6qa5KtZHwbG9tiva8mUpBEHZOGjAEGe91VEFwUwgrbvMDTSrquiWOc5zHxkyGrN6ZrKgGftbaLGaTABB31E8Cy1Z+IQOFHqJnPUxexINkD6ewjpKdsdqlWS/JxsrKHn0adNnzBMQofW7PbiblpOrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412888; c=relaxed/simple;
	bh=SxrOlg0qpUKLz/Z0L+o7RWOgxEt0cDuUCf/HaCJzkNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L258vPwXHlpzpDh7CkHgDd3nClzr6oFjC4FJN+tT7uVoMRphzJZn0p5FrOrHPItPbxlY6suxKy2tdP9OVAM9JMgviKeT/0gwT4lLWNTp/sHd2hTwPw6eTY5fKlVzXGl/q1VZaTxQ65YIxTO91HQWFeoB6z8Fsimhp1bBG3kKIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KMDWqK2Q; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a36748920cso1361657f8f.2
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750412883; x=1751017683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yv3qJdLc6eiPUjiU7hglwuzXEOH35/Jx3j5Wzop4tAM=;
        b=KMDWqK2QDsZ9eBiJ2RagnlePq1S2UbBy96KUqibGL0dt7kYK5OvpfAbwLZR1tQ6wlO
         YTh+OWesd4Efw3LmWg8vJoikMcxwGMEFEn7ZZvv6PjR6tl8i6x6YQU8tg1nS6RjlDBgg
         RYpcm7/5P0Zkd9jjw2rDk4LKss5yRskwIp4UwpmjqtMEyIiiQhq3whY8cfXYiMVyPqHH
         fUS8JgVAZnNiYVuJfW1dGEXt18gUmbPOwMsSHF1Le+eiDwhLqeRUbd92kpJ4sH974boX
         t8UB1Vemg/SGghglNgYUXBWfJFwfniqFkvwrje9SmnQ1kaKzpDzW2XRis/PKCyhBJ/G1
         9MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412883; x=1751017683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yv3qJdLc6eiPUjiU7hglwuzXEOH35/Jx3j5Wzop4tAM=;
        b=G1YrPZyuPKCicfbZVu9lw/UsKJHQDxDhK98ih0xDd3HCzoaCIZVV+joFyQAzQ0RKcA
         sHNgvrnOU2hdurNQwuchHJu7JnS8MmknzbnFBwMOww4eCDORkS57zcocCan43xsoePxK
         6J0ll3Z97PKQFiDqAlX9NSHO3vtv0jEM0jj75ZGZCy0Q2whQOYmwKAETI649rK7O/I5x
         4/uG2poayE8n01zp4xSDxuzGxTGzFlAW/58UubZVS093jAkuTWwPITtEvSQlNtKyzYy6
         ogm96p26oVl2BSbpl4c1SXBQtodfKQXUAbOzuQnUwzWruQocL8/yLhZBN907AzDPQbhX
         /j+g==
X-Forwarded-Encrypted: i=1; AJvYcCXmVfCnAUHC3gjQiiudo5rDNURaUa/oLZ0XMa2Bqph128pG3Tg4K0f4KOLE6T6/KwhTLjsU5qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjV2C3csty4zveKCw7q/zcb6JkHJoWkph/HnJQZOjGBhlKS7n
	lo41fB6c+wu3jAO01LyPFt6WKN1xJlcBc2DHwbDS/PXlNaYggDR3LcSSpDokgdGJL3qYbQKctAL
	51zDG
X-Gm-Gg: ASbGncs0KFgYsRh/j9dNq0HrBfT/01odsBb6OmHOGtn8D4VKWXnnPfcvoK6tFvMCAr/
	2xvkohkMo0DqifVfiuQI5qdzpHvB0kX+x6VG0kNvr13s/H/Q6q7zxbcf1QisT7o36EpsLl1o9MW
	kQ/2gd41pIisswqLEhG1FqirFSNobetGsvRsW+l6+tplaH2ABvuD6ron2c4YYQc9ONsrQtyiKbm
	4GkkXhmWtZzGCdEkH0E3yFZD8v0M0GZOewYYPQb6cmBe+zORmCJ1Bu/n80A/VcPTeeEEJVm0b4L
	bfWqL9LggX7ad1hoR0EkRU3vu/taQx0JRbBaSalxGPbT9+f0VbNAgcD3GJ2gca+lYWyZRR8l1ds
	b1o/aL25A8g8Rp2QUCiZlJxwS9bWQ
X-Google-Smtp-Source: AGHT+IEi/eQAc+jPAGUmY6NshIYofesxFiYoxjwNbPHfeOyMnse341s37kI5SpI1B28seCiCJSd7mw==
X-Received: by 2002:a05:6000:25ca:b0:3a3:6e85:a529 with SMTP id ffacd0b85a97d-3a6d1325e94mr1827752f8f.51.1750412883088;
        Fri, 20 Jun 2025 02:48:03 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453646dc66fsm19404005e9.18.2025.06.20.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 02:48:02 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:48:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg KH <gregkh@linuxfoundation.org>, 
	Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>, stable@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
Message-ID: <kegij3u3ehv7b6kapbxfqnfhvqpzzhoaemhfiedjkqmnv2ejx5@y6pwl35l7wns>
References: <20250530200918.391912-1-aurabindo.pillai@amd.com>
 <CADnq5_P1Wf+QmV7Xivk7j-0uSsZHD3VcoROUoSoRa2oYmcO2jw@mail.gmail.com>
 <jn3rvqffhemwjltd6z5ssa2lfpszsw4w7c4kjmkqqbum6zqvmi@pv6x2rkbeys6>
 <CADnq5_PHv+yxYqH8QxjMorn=PBpLekmLkW4XNNYaCN0iMLjZQw@mail.gmail.com>
 <2025060410-skinning-unguided-a3de@gregkh>
 <od2jpxazsa6ee6fqom7owcgh53lz3wjjjk4scoe2mxjzrytl7f@jwwwxfuo4pkj>
 <CADnq5_OdFQhokdysSHdeBca=UViCcqKWmfbedMAadWFWBiNE=Q@mail.gmail.com>
 <ziq6dniodo5zgnf427btbyafaxdx3kt6rym2gupuiymvpwnmcy@fh76ssxyirmw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ptu5vnlv7n7jd633"
Content-Disposition: inline
In-Reply-To: <ziq6dniodo5zgnf427btbyafaxdx3kt6rym2gupuiymvpwnmcy@fh76ssxyirmw>


--ptu5vnlv7n7jd633
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
MIME-Version: 1.0

Hello,

On Thu, Jun 05, 2025 at 07:44:19AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Jun 04, 2025 at 11:09:15AM -0400, Alex Deucher wrote:
> > On Wed, Jun 4, 2025 at 10:55=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > Hello Alex,
> > >
> > > On Wed, Jun 04, 2025 at 03:29:58PM +0200, Greg KH wrote:
> > > > On Wed, Jun 04, 2025 at 09:15:14AM -0400, Alex Deucher wrote:
> > > > > On Wed, Jun 4, 2025 at 5:40=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > > > On Fri, May 30, 2025 at 04:14:09PM -0400, Alex Deucher wrote:
> > > > > > > Already included in my -fixes PR for this week:
> > > > > > > https://lists.freedesktop.org/archives/amd-gfx/2025-May/12535=
0.html
> > > > > >
> > > > > > Note the way this was done isn't maximally friendly to our stab=
le
> > > > > > maintainers though.
> > > > > >
> > > > > > The commit in your tree (1b824eef269db44d068bbc0de74c94a8e8f9ce=
02) is a
> > > > > > tad better than the patch that Aurabindo sent as it has:
> > > > > >
> > > > > >         This reverts commit cfb2d41831ee5647a4ae0ea7c24971a92d5=
dfa0d ...
> > > > > >
> > > > > > which at least is a known commit and has Cc: stable.
> > > > > >
> > > > > > However this is still a bit confusing as commit cfb2d41831ee ha=
s no Cc:
> > > > > > stable, but a duplicate in mainline: f1c6be3999d2 that has Cc: =
stable.
> > > > > >
> > > > > > So f1c6be3999d2 was backported to 6.14.7 (commit
> > > > > > 4ec308a4104bc71a431c75cc9babf49303645617), 6.12.29 (commit
> > > > > > 468034a06a6e8043c5b50f9cd0cac730a6e497b5) and 6.6.91 (commit
> > > > > > c8a91debb020298c74bba0b9b6ed720fa98dc4a9). But it might not be =
obvious
> > > > > > that 1b824eef269db44d068bbc0de74c94a8e8f9ce02 needs backporting=
 to trees
> > > > > > that don't contain cfb2d41831ee (or a backport of it).
> > > > > >
> > > > > > Please keep an eye on that change that it gets properly backpor=
ted.
> > >
> > > I'm not sure if my mail was already enough to ensure that
> > > 1b824eef269db44d068bbc0de74c94a8e8f9ce02 will be backported to stable,
> > > so that request still stands.
> > >
> > > > > DRM patches land in -next first since that is where the developers
> > > > > work and then bug fixes get cherry-picked to -fixes.  When a patc=
h is
> > > > > cherry-picked to -fixes, we use cherry-pick -x to keep the refere=
nce
> > > > > to the original commit and then add stable CC's as needed.  See t=
his
> > > > > thread for background:
> > > > > https://lore.kernel.org/dri-devel/871px5iwbx.fsf@intel.com/T/#t
> > >
> > > Yeah I thought so. The problem isn't per se that there are duplicates,
> > > but that they are not handled with the needed care. I don't know about
> > > Greg's tooling, but my confusion would have been greatly reduced if y=
ou
> > > reverted f1c6be3999d2 instead of cfb2d41831ee. That is the older comm=
it
> > > (with POV =3D mainline) and the one that has the relevant information=
 (Cc:
> > > stable and the link to cfb2d41831ee).
> >=20
> > The revert cc'd stable so it should go to stable.  You can check the
> > cherry-picked commits to see what patches they were cherry-picked from
> > to see if you need to apply them to stable kernels.
>=20
> Yes, and I'd expect that the scripts used by stable maintainers looking
> at 1b824eef269d will apply that to all stable branches that contain
> cfb2d41831ee or a backport of it.
> Given that that cfb2d41831ee wasn't backported to any stable kernel and
> the commit itself will only be in 6.16-rc1 the set of kernels to
> backport the revert to, will be the empty set.
>=20
> (In git commands:
>=20
> 	$ git log --oneline --source stable/linux-{5.{4,10,15},6.{6,12,14,15}}.y=
 ^1b824eef269db44d068bbc0de74c94a8e8f9ce02 --grep=3D"commit cfb2d41831ee564=
7a4ae0ea7c24971a92d5dfa0d upstream"
> 	<void>
> =09
> If however you look for cfb2d41831ee's twin, there is:
>=20
> 	$ git log --oneline --source stable/linux-{5.{4,10,15},6.{6,12,14,15}}.y=
 ^1b824eef269db44d068bbc0de74c94a8e8f9ce02 --grep=3D"commit f1c6be3999d2be2=
673a51a9be0caf9348e254e52 upstream"
> 	4ec308a4104b    stable/linux-6.14.y drm/amd/display: more liberal vmin/v=
max update for freesync
> 	468034a06a6e    stable/linux-6.12.y drm/amd/display: more liberal vmin/v=
max update for freesync
> 	c8a91debb020    stable/linux-6.6.y drm/amd/display: more liberal vmin/vm=
ax update for freesync

TL;DR; These backports are cared for, this thread can be considered
done.

Update to the situation:

The patch to be reverted wasn't added to further stable branches since
last time we looked:
=09
	$ git log --oneline --source stable/linux-{5.{4,10,15},6.{6,12,14,15}}.y ^=
1b824eef269db44d068bbc0de74c94a8e8f9ce02 --grep=3D"commit cfb2d41831ee5647a=
4ae0ea7c24971a92d5dfa0d upstream"
	$ git log --oneline --source stable/linux-{5.{4,10,15},6.{6,12,14,15}}.y ^=
1b824eef269db44d068bbc0de74c94a8e8f9ce02 --grep=3D"commit f1c6be3999d2be267=
3a51a9be0caf9348e254e52 upstream"
	4ec308a4104b    stable/linux-6.14.y drm/amd/display: more liberal vmin/vma=
x update for freesync
	468034a06a6e    stable/linux-6.12.y drm/amd/display: more liberal vmin/vma=
x update for freesync
	c8a91debb020    stable/linux-6.6.y drm/amd/display: more liberal vmin/vmax=
 update for freesync

So 6.6.y, 6.12.y and 6.14.y need a fix, as do all releases that contain
f1c6be3999d2be2673a51a9be0caf9348e254e52 or
cfb2d41831ee5647a4ae0ea7c24971a92d5dfa0d but not the revert
1b824eef269db44d068bbc0de74c94a8e8f9ce02. That would be v6.15.

The revert was backported to the following branches:

	$ git log --oneline --source stable/linux-6.{6,12,14,15}.y ^1b824eef269db4=
4d068bbc0de74c94a8e8f9ce02 --grep=3D"commit 1b824eef269db44d068bbc0de74c94a=
8e8f9ce02 upstream"
	e9019e2214fa    stable/linux-6.6.y Revert "drm/amd/display: more liberal v=
min/vmax update for freesync"
	c1c52720bb0f    stable/linux-6.15.y Revert "drm/amd/display: more liberal =
vmin/vmax update for freesync"
	dc86041f8d31    stable/linux-6.14.y Revert "drm/amd/display: more liberal =
vmin/vmax update for freesync"
	80fe1ebc1fbc    stable/linux-6.12.y Revert "drm/amd/display: more liberal =
vmin/vmax update for freesync"

So all four affected branches are fixed now.

So there is nothing further to be done (unless
cfb2d41831ee5647a4ae0ea7c24971a92d5dfa0d or it's twin gets backported to
older versions).

Best regards
Uwe

--ptu5vnlv7n7jd633
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhVLk4ACgkQj4D7WH0S
/k7Xowf/VND1yijnXCsxJV0FBbglFEg/vadFRssmykO8ApfU6rTwaHP8xI88dx09
lEJYbovG23EzQrwO+jA+TNSijefhHQfqvToSAbz1EfjZkO78z+hoQVSe+hOhyoZ+
x25Egybn2apbhxECkHzAMJigDDAwqbkUOng2HyUobwf9XPwJJ1SzaYRXn287Qe50
kCt+kjwnRHP1/7eBIAFGUGb+6Ltluxt0KFCExcwi1YswLAB6HKtQjWAnrB/+lqbH
69Ay9dXio6fYX3y2Qkxl+Kt6jzaNrATdhdDirRy1xqo92xtDFFevUNnUz2xR5DtK
LyNmTLa4gJX6StIykEp+axAnwwnpIA==
=ti2w
-----END PGP SIGNATURE-----

--ptu5vnlv7n7jd633--

