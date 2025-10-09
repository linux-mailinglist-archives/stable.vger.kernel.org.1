Return-Path: <stable+bounces-183671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A105BC80B5
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CF188AE8A
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB62C026B;
	Thu,  9 Oct 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdA+a5pI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014E253356;
	Thu,  9 Oct 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998478; cv=none; b=iGUZOj4zv1llAD0xbKX58Jm6U5eSiyArfn4o19wsJeaTH95FmYX0vwvKlFaXzY3DccJlUMThceOAXztKot6IcpfLBHbytqiG8WWgDV8phDIEhhOMiwnyuq+WYhgv0uZsLDMi4Tc5BQamoppTKRDU495s99vhnOZ3J2/ebWcnAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998478; c=relaxed/simple;
	bh=rZSSjMlfyp1/DY/FUZFefqXE1tJXo2iaAfShYMGP5t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrJeTmpHyeqJDfAzXGP53NtETLsncx27008gnGP2FCbPy+U2mfqC1NfM0+wjrPqMCEAjMLyuW/rQqaF55jrdGuS+gvDVSN6kQuEsW/gqLhP1pBBa/buQIvE4n8f4qryhTFENodI9gSZoYX7JJF0Pyn4ASAel+SzTVPnFCipx9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdA+a5pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6564FC4CEE7;
	Thu,  9 Oct 2025 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759998477;
	bh=rZSSjMlfyp1/DY/FUZFefqXE1tJXo2iaAfShYMGP5t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdA+a5pIqIR7UM7ITP9VqMbrQ/uGA1V12t1LNQDOuPyrLQEoJKE5WKh2NSlGCFcFH
	 uGV+H0pwp2yawTthgjn/F2Z0S6P2suSREhU47mceABhSQ+lsz4NACjbsay/R1WY6xl
	 63eVDxL1HjTFsgs/K4KbrMpb8/bYp4irws9z33gqhrlUwxHverez29c2Tz9ErOzkD4
	 lI3+p6SBzsx9lFVrFr5mtC7WR+54NC05PADE4DaHpGWvtVsMpKmDKEi7ct0qWmaPC0
	 Ke7yKxdzEgNBLhs2Eb1NQka8ViQMV9K4MiwFR6XhqnCVW6ZTKG2vr0HUAKxlQ2nSl/
	 qu7Zcvd+NNQBA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v6m0B-000000001lE-3wvQ;
	Thu, 09 Oct 2025 10:27:55 +0200
Date: Thu, 9 Oct 2025 10:27:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>, Krishna Reddy <vdumpa@nvidia.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
	Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH v2 14/14] iommu/tegra: fix device leak on probe_device()
Message-ID: <aOdyC1toHHIeE4i5@hovoldconsulting.com>
References: <20251007094327.11734-1-johan@kernel.org>
 <20251007094327.11734-15-johan@kernel.org>
 <rp2yiradenf3twznebagx7tgsruwh66exiikal37c4fwo75t4t@4breto65stqt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KFWfMBBEp9y0HjZa"
Content-Disposition: inline
In-Reply-To: <rp2yiradenf3twznebagx7tgsruwh66exiikal37c4fwo75t4t@4breto65stqt>


--KFWfMBBEp9y0HjZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 09:56:18AM +0200, Thierry Reding wrote:
> On Tue, Oct 07, 2025 at 11:43:27AM +0200, Johan Hovold wrote:

> > @@ -830,10 +830,9 @@ static struct tegra_smmu *tegra_smmu_find(struct d=
evice_node *np)
> >  		return NULL;
> > =20
> >  	mc =3D platform_get_drvdata(pdev);
> > -	if (!mc) {
> > -		put_device(&pdev->dev);
> > +	put_device(&pdev->dev);
> > +	if (!mc)
> >  		return NULL;
> > -	}
> > =20
> >  	return mc->smmu;
>=20
> pdev->dev is what's backing mc, so if we use put_device() here, then the
> MC could go away at any time, right?

Holding a reference to a device does not prevent its driver data from
going away so there is no point in keeping the reference.

But from what I can tell, you don't need to worry about that anyway
since it's the memory controller driver that registers the iommu (and
the driver can't be unbound).

Johan

--KFWfMBBEp9y0HjZa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCaOdyBwAKCRALxc3C7H1l
CEs2AP0RtypMzHwKSdgb+1LkzszK9dEi+yrUUVVJnU4HXJHGcQD/W3QAlXRFlmAR
1c8Lq3vdjCx4jKS7G127MmgisGSECgw=
=inx4
-----END PGP SIGNATURE-----

--KFWfMBBEp9y0HjZa--

