Return-Path: <stable+bounces-106618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A609FF152
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 19:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8FC3A2FD4
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1D1ACEB8;
	Tue, 31 Dec 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPk6JNZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A0182D9;
	Tue, 31 Dec 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735670492; cv=none; b=lG5Uy0xu8/G8ifBSHncwIjvgyN5CRhHgkvtGITUSNMIOT2u0SzzfivycwK5DGfhE61UXbFk0jvY4byZrR8vCfND5vc9ZU03rqHIvDo4Prvr0+cHP3bNI/5OvxVK0EimnnI5cg7bdecrShTwN2GKbu1Fs3G9Llx7ahckbjSjcr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735670492; c=relaxed/simple;
	bh=cQ7GGZlstkkYgmj258hdtKYfW8+a8BalT65IE1aQ6eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEJDRb/wxkS7PtE+ViDJR8f/lE001WPSDklneGaimn8zpYkqG4h6eG4Rjb43H0+TIVhgM38kV9NcooGARg4J8yZhDuqDXPcbvycSt6cmZWC5B06C4O7bLJVCDBOkn4gSCnZ8uP/ZbIKFulzKxHuz60KUmc8dg/4p2jk3BLyQ0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPk6JNZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55A0C4CED2;
	Tue, 31 Dec 2024 18:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735670491;
	bh=cQ7GGZlstkkYgmj258hdtKYfW8+a8BalT65IE1aQ6eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPk6JNZxswwIho2gO88OSrGxt+zFDu0T55yug7kLeMInRRDSH+g96mLOZHNGkQJGU
	 uvExdCCncXKyQgG+sK+AJM7FFHOvkqODXaovrvynch5uBbf2Fv3l4X/lofoLHkZ/Gu
	 k6gf4cLg/3DnnNGGkD2yEtpehSycLM9z51/ygFWQGBfkXbRNmNG/1samdHm8oWsN1N
	 Ro2IcAK2F3ugKw0WDOLsE1yCsGa/xH2Z9wXkOP0NwZsi7KcrJ8/JvuDXP20ooFVP71
	 G9m92NF/z4G8LBrFIHXcRoVDoY6dYyS3o8YyQ51+tKILbPNpXgdXcuDebV0g9gHxc6
	 Epui/VYxcYloA==
Date: Tue, 31 Dec 2024 18:41:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Z qiang <qiang.zhang1211@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz, rcu <rcu@vger.kernel.org>
Subject: Re: Linux 6.1.120
Message-ID: <20241231-talisman-drone-77262b2af4a9@spud>
References: <2024121411-multiple-activist-51a1@gregkh>
 <20241216-comic-handling-3bcf108cc465@wendy>
 <CALm+0cVd=yhCTXm4j+OcqiBQwwC=bf2ja7iQ87ypBb7KD2qbjA@mail.gmail.com>
 <2024121703-bobbed-paced-99a5@gregkh>
 <20241218-erupt-gratitude-1718d36bd1ac@spud>
 <2024123014-snout-shed-fb50@gregkh>
 <2024123018-lend-deflate-94d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aJjoDFGnXC+wgkRW"
Content-Disposition: inline
In-Reply-To: <2024123018-lend-deflate-94d0@gregkh>


--aJjoDFGnXC+wgkRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 03:47:26PM +0100, Greg Kroah-Hartman wrote:

> > > > > For v6.1.x kernels, the cblist_init_generic() is invoke in init t=
ask context,
> > > > > rtp->rtpcp_array is allocated use GFP_KERENL and in the critical =
section
> > > > > holding rcu_tasks.cbs_gbl_lock spinlock.  so might_resched() trig=
ger warnings.
> > > > > You should perform the operation of allocating rtpcp_array memory=
 outside
> > > > > the spinlock.
> > > > > Are you willing to resend the patch?
> > > >=20
> > > > So should I revert this, or do you have a fixup patch somewhere?
> > >=20
> > > Is it too soon to push for a revert? It's interfering with my CIs
> > > attempts to test the 121-rc.
> >=20
> > Sure, can someone send me a revert?
>=20
> Nevermind, I will just do it...

 That'd be great, at least from where I'm sitting, since I'm still AFK
 for Christmas :)

--aJjoDFGnXC+wgkRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ3Q60wAKCRB4tDGHoIJi
0uEXAQCu4spx8d1Btgr+pRt25EfuVooNOu9xzpj+L8F38HPS0AD+O9Lntdi3id+S
MX5u9JoxvXJdqEVBZBk7rHlini3JOA8=
=1pbW
-----END PGP SIGNATURE-----

--aJjoDFGnXC+wgkRW--

