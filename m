Return-Path: <stable+bounces-180605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA5B881FA
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 09:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998353AF35E
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 07:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDD92C08AA;
	Fri, 19 Sep 2025 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by6V6Zm5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091B277C95;
	Fri, 19 Sep 2025 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266003; cv=none; b=Q6kaZdkxZE5laYkVfeMHUZ1XX2joOOteBY7+QomUXEOFdj1Dtc84YfhuqDqpVl+g39spIbWYlsZTw71ZPBuvJD+s0HXdN/XgaCTkCYOJBM9uL/Guh25wshRi10/F+Q5x8GrXmyaeklpYYW15PD1Hpbvjv27vxetY4j0l9INUsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266003; c=relaxed/simple;
	bh=1t5vWZ8iEbnpsW4relA0572VxAhet0HxabKQsq73kfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp1/TAsOOdbMA8hjv++Z5ONAmkkjIhiW57o7+k5233A0Cxvokd/gwHROZ39DXsaissvgdbuOM+Hubl248GbHnepkU74WHioK+I8hHQzBLrTx0cwFXMdpGlwQcT95xoNf2VgQWkJggOYmmMFROpce86fCoaKX+p/evBdOG21kJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by6V6Zm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54532C4CEF0;
	Fri, 19 Sep 2025 07:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758266001;
	bh=1t5vWZ8iEbnpsW4relA0572VxAhet0HxabKQsq73kfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=by6V6Zm5lbZKY3r4zH0m9zFGT412JeEerfDGTUnFTWzJ2j8Yow/MmkTCiERx/bAXN
	 MPnOPSylLLWa+Dw1CwRm5FQZ7Zv9UfOLKxd5rG/30WGwYolJJbilI/cTLig/DR5K0x
	 bw513GyxaY4BRwpJE8Z6x3CKLB1ChyoXmbjkb/Y0HzYz3SL/hMDJh4qjWd8aRKzqTI
	 WP6urLss1YVOTSKBRgH8eh9giOgWY4k4vnVNukzCHE99mL1ZEbplegLkDeVmeewObW
	 MIvMW5oc48l+/WPgyleK16UN3gIdKGS4M6HIDyId6GUG/X3XXG7UPh45ftgrIsx8BT
	 Is2tetSE3DKFA==
Date: Fri, 19 Sep 2025 09:13:16 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: PRS isn't usable if PDS isn't supported
Message-ID: <t5ier7jfq7f6sedqq2vholm4x7myolk7tanhi7cjcd6xkrk72d@luay37lq7ipu>
References: <20250915062946.120196-1-baolu.lu@linux.intel.com>
 <zkgvbw42g25a47nyydehxismaup6eh4kygqbdw7fk54kxze7j3@lrczardwx2ma>
 <3d633e85-04fd-4077-9bf8-92fb487f89fb@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xq7uv7x2yy5bq7s"
Content-Disposition: inline
In-Reply-To: <3d633e85-04fd-4077-9bf8-92fb487f89fb@linux.intel.com>


--3xq7uv7x2yy5bq7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 09:58:14AM +0800, Baolu Lu wrote:
> On 9/15/25 19:30, Joel Granados wrote:
> > On Mon, Sep 15, 2025 at 02:29:46PM +0800, Lu Baolu wrote:
> > > The specification, Section 7.10, "Software Steps to Drain Page Reques=
ts &
> > > Responses," requires software to submit an Invalidation Wait Descript=
or
> > > (inv_wait_dsc) with the Page-request Drain (PD=3D1) flag set, along w=
ith
> > > the Invalidation Wait Completion Status Write flag (SW=3D1). It then =
waits
> > > for the Invalidation Wait Descriptor's completion.
> > >=20
> > > However, the PD field in the Invalidation Wait Descriptor is optional=
, as
> > > stated in Section 6.5.2.9, "Invalidation Wait Descriptor":
> > >=20
> > > "Page-request Drain (PD): Remapping hardware implementations reporting
> > >   Page-request draining as not supported (PDS =3D 0 in ECAP_REG) trea=
t this
> > >   field as reserved."
> > >=20
> > > This implies that if the IOMMU doesn't support the PDS capability, so=
ftware
> > > can't drain page requests and group responses as expected.
> > >=20
> > > Do not enable PCI/PRI if the IOMMU doesn't support PDS.
> >=20
> > After giving the spec another look, this is probably the way to go.
> > However the PDS also mentions that DT must be set. Should we check
> > ecap_dev_iotlb_support(iommu->ecap)  as well?
>=20
> It has already been checked.
Yes. In intel_iommu_probe_device. Thx for the clarification.

Best

--=20

Joel Granados

--3xq7uv7x2yy5bq7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmjNAoMACgkQupfNUreW
QU//8Qv9HdMlipScLuChqDoQOMybUKTj0nBOjYcagRoZ3qeZfkLooPPQqt7LSXq2
TaTzY/ZUMhyeeMhxUpBfvsEzjIE14QtwQt3I1hQq/xMf+BMKYQRdS1WLRxkGN4/U
q4+wt4NacUMmIDR+Yhz37vw76E/Ljsg1E3RnpICU6BRJtROMiO6IuB83sOyUhhvy
bf7BobCK3TFGOymBaT0fNzgyssYIuF5VCiNkQTPmJ340CZOt2MYYi/TxNT6GLBSQ
gmw42mYtAmXJ8C20SsJ5NaUWqep8cexa67CQzkRUstSuiaQ29Nlim0B3wdgbBlcs
2G+Dr6qEzeSOZuWQgGuv0ICx2sAmGtglQn5vvyEektqbWdfqZVpFZnZd0udpxaqG
u3HBTt9WkiCZ0SvnaYIUsOIBKcHsnAb0LfFzw+CfgjFVCFEc4r+IK+peK6xffEfc
zZkWFEd7P0JSBLaz0xiELqhgH2zpnyDQ6h2OT0kaAQpAt0jGwDMT0ERe4YhBRpTb
SsNZCFdG
=IWaY
-----END PGP SIGNATURE-----

--3xq7uv7x2yy5bq7s--

