Return-Path: <stable+bounces-179613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2A8B57880
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 13:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB45F1A253F0
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70D302CC9;
	Mon, 15 Sep 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enjxnp3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E820C463;
	Mon, 15 Sep 2025 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935870; cv=none; b=TU/cPRT4zSCHSn93119iqr53hPCca2uEG6kBOtfq+lhdKYfYGX9TtJOTcMtHpySdGkmpgK5ElODOzmg7rxcxSI8pD/gWwecvLEjKBrm67ZXVyrElrqyxcaXMHTzX5g1KoFcVEm9r9kjvpSasCLUVGnCu7noJ9vIQEHNKQme3BIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935870; c=relaxed/simple;
	bh=QzcC5e9vACLhf+imSTtVn3GQfBZaWBylU9DXjf8uhe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ1lhz0E1UQrvCmVzZVH9UlKxRcLn/vL6O/qDy3cZGf6ofdCyoSsSO4XOMcV/U6qnw+BCqAmbkXCyFPfjvhwkV6BfSM4Aae+WEkr5tcmPblDD3kuk652b2Yu8NY1TCfWL4A8Fp8F772HtciEDnYJuigeK8Cjam3P6gODQGXvso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enjxnp3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EF8C4CEF1;
	Mon, 15 Sep 2025 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757935869;
	bh=QzcC5e9vACLhf+imSTtVn3GQfBZaWBylU9DXjf8uhe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enjxnp3T3aa2QbtFVaP77F8qnVNwGsHTah35oipbcDYffDLh7ydf/fZl9SFH9FoH7
	 qmtBB+yThdTeYbe23Hkgch3Rqy3AR5Cj8RReccwYfUtowRhbgQ617wNAjiXGmdOkF+
	 ogGgbQZ5RAMhS0PFoPIuZwjHYQ72RVN83k+2x4F9zlDLbNw2wYmdY34/oy7fD7AzT2
	 GgFpUX/TS/4YGKXoYq2ALA5XqKvq78fXljCYXCpU1EPuo1Pr5FhIx+ek5D4ZJKb+qo
	 Jtc3HAWKZWElsqTo8VHNYVeCzNuM9E/y90g6fKVwjUllCtslykGNkvOxcMCRQOE5A3
	 8nIESYL7wX3rw==
Date: Mon, 15 Sep 2025 13:30:56 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: PRS isn't usable if PDS isn't supported
Message-ID: <zkgvbw42g25a47nyydehxismaup6eh4kygqbdw7fk54kxze7j3@lrczardwx2ma>
References: <20250915062946.120196-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkfaowbxmqkhdxqk"
Content-Disposition: inline
In-Reply-To: <20250915062946.120196-1-baolu.lu@linux.intel.com>


--xkfaowbxmqkhdxqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 02:29:46PM +0800, Lu Baolu wrote:
> The specification, Section 7.10, "Software Steps to Drain Page Requests &
> Responses," requires software to submit an Invalidation Wait Descriptor
> (inv_wait_dsc) with the Page-request Drain (PD=3D1) flag set, along with
> the Invalidation Wait Completion Status Write flag (SW=3D1). It then waits
> for the Invalidation Wait Descriptor's completion.
>=20
> However, the PD field in the Invalidation Wait Descriptor is optional, as
> stated in Section 6.5.2.9, "Invalidation Wait Descriptor":
>=20
> "Page-request Drain (PD): Remapping hardware implementations reporting
>  Page-request draining as not supported (PDS =3D 0 in ECAP_REG) treat this
>  field as reserved."
>=20
> This implies that if the IOMMU doesn't support the PDS capability, softwa=
re
> can't drain page requests and group responses as expected.
>=20
> Do not enable PCI/PRI if the IOMMU doesn't support PDS.

After giving the spec another look, this is probably the way to go.
However the PDS also mentions that DT must be set. Should we check
ecap_dev_iotlb_support(iommu->ecap)  as well?
>=20
> Reported-by: Joel Granados <joel.granados@kernel.org>
> Closes: https://lore.kernel.org/r/20250909-jag-pds-v1-1-ad8cba0e494e@kern=
el.org
> Fixes: 66ac4db36f4c ("iommu/vt-d: Add page request draining support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9c3ab9d9f69a..92759a8f8330 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3812,7 +3812,7 @@ static struct iommu_device *intel_iommu_probe_devic=
e(struct device *dev)
>  			}
> =20
>  			if (info->ats_supported && ecap_prs(iommu->ecap) &&
> -			    pci_pri_supported(pdev))
> +			    ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
Should this be
 +			    ecap_dev_iotlb_support(iommu->ecap) && ecap_pds(iommu->ecap) && pc=
i_pri_supported(pdev))

???

best
--=20

Joel Granados

--xkfaowbxmqkhdxqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmjH+OYACgkQupfNUreW
QU8tWAv/WKbKPjcF8wb32eYKjaM0GTbR11XC8V8fp8NWN0LqGna0s3PluSa1d5WH
koUSQteUJLTzYvw6FLcLEzQzWhArehDJnVLfLTyWJimcalAmMoUvJk5lhe4mNKx6
jhOr5wg0On1IRpn6wyfs1TNOFHRrG0FDKc99g1kr2G6bx68B/FGHgc9uvyTo3RTz
JTcDqAzScropRwNM0ttHig7k7IvOBVmdH5zlJJns5XUMizxbsZpPLxEtWWRl8rPk
IgkzWV/fRJgeVT8vdGJDlrlr51RjeyUNEHD1q5QNfNsOUHbIgYfMU9Pe6mSrm4li
O3sdNGF4Dc3Utvc4oMslsX1YIUuXr6lo8I5J2SQ5XY7Pqak9VA3zoRVL2IEu1poE
60AOIEkGQxlpbFcHYmbpC7YZXTVlXlrTSIlaeftQFTLi9ZAmPYmLpk+buFpEn13o
sqC74xU/LpbQ9abKojD1hH46MsAKqy55qhsA+edMuORW1X6zTNYJce2NO1P5GIMt
oM9UKjvw
=xqSR
-----END PGP SIGNATURE-----

--xkfaowbxmqkhdxqk--

