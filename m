Return-Path: <stable+bounces-52646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0CA90C6E0
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9035C1C222E4
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A8B149C60;
	Tue, 18 Jun 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI5uDg89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B613AA37;
	Tue, 18 Jun 2024 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698430; cv=none; b=XUINKJu9VNdZ4rFjoMxk+ZHWhTcPqekPk5GBoH8Q4tXrwEWtGAO2eLWVwcwqHgGNa7u7kJ8/qbgm9rqpNCBO7GP4hurod9SJaCyDXaPXw/w7r7Plor17iUDc2ePX/LJWzsXXpDkpiLA9RKr8IWNcA4j4xmJNGHU/SSGzx8Ri0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698430; c=relaxed/simple;
	bh=t0kXkFe+Uc+4GyW6huB1OnZkTwf/7K7wQ3TQ7GFxz8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA+8vp9JLAHQYPseTKRs9qM5z+elp15WEHcIT6ofJu8NuYkuasDxLCtOila+nWGerlV+jxtMXQ2UTXvx471kftYOVnuekViOvjTa7HgWXalLBuFAYOWAQ54GBKJrofJMvxxtreu9YRhNEsA8WlPyl6YezQcJyzPR7V8YA/jhkUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI5uDg89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E995CC3277B;
	Tue, 18 Jun 2024 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718698430;
	bh=t0kXkFe+Uc+4GyW6huB1OnZkTwf/7K7wQ3TQ7GFxz8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gI5uDg89tWwDrb9mh+iOh94c41ap2tYpemNO3yEoQ2j4LfGyNwWn4v3d0hobbgdIv
	 YX+9fmakY/HMJuZK0mO+Yz8BtC6vGEQZqEWztJYNrNCA4mD7/cSSFGMcsqB7Dv7HN4
	 vXZpH15jlt23tsVcZflLYr6V/gh7xNSAjYpoumxoceDQXF6/638FBliUuB+0MxqukH
	 KuMHaVNnqPXZ+hXDpu0jTN8/SbPFKCzkNLY2aIfsJf1sRRnSHH0MNDIQi4zCwjBO5C
	 K45OVEPZD3xxQPjzrMCBnAU4qw9IfVyhti6kWnevfZeuuv6x5X6uFRu2ph6olaECdz
	 G+FSvNWPgLiYg==
Date: Tue, 18 Jun 2024 10:13:47 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Qiang Yu <yuq825@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org, 
	Philip Muller <philm@manjaro.org>, Oliver Smith <ollieparanoid@postmarketos.org>, 
	Daniel Smith <danct12@disroot.org>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
Message-ID: <20240618-great-hissing-skink-b7950e@houat>
References: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
 <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
 <CAKGbVbsM4rCprWdp+aGXE-pvCkb6N7weUyG2z4nXqFpv+y=LrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vdvduvkbze4vvc46"
Content-Disposition: inline
In-Reply-To: <CAKGbVbsM4rCprWdp+aGXE-pvCkb6N7weUyG2z4nXqFpv+y=LrA@mail.gmail.com>


--vdvduvkbze4vvc46
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 04:01:26PM GMT, Qiang Yu wrote:
> On Tue, Jun 18, 2024 at 12:33=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrot=
e:
> >
> > I see the problem that initramfs need to build a module dependency chai=
n,
> > but lima does not call any symbol from simpleondemand governor module.
> >
> > softdep module seems to be optional while our dependency is hard one,
> > can we just add MODULE_INFO(depends, _depends), or create a new
> > macro called MODULE_DEPENDS()?
> >
> This doesn't work on my side because depmod generates modules.dep
> by symbol lookup instead of modinfo section. So softdep may be our only
> choice to add module dependency manually. I can accept the softdep
> first, then make PM optional later.

It's still super fragile, and depends on the user not changing the
policy. It should be solved in some other, more robust way.

Maxime

--vdvduvkbze4vvc46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnFBugAKCRDj7w1vZxhR
xV4WAQDox5ZaFopBrVQDS59ucBA0YRDGyi9gKRYE808rydy9pAD+LJeN/tR71dDU
hC6/d8te9teLVZ8K4fkmbqxOwOu/HwU=
=uQvC
-----END PGP SIGNATURE-----

--vdvduvkbze4vvc46--

