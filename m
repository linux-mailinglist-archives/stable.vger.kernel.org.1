Return-Path: <stable+bounces-52387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FADF90B0AD
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364D5B2D713
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D6198A3C;
	Mon, 17 Jun 2024 13:18:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5A198A34;
	Mon, 17 Jun 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630300; cv=none; b=hCBxsn5MIX94uVpwtBgMvMCAGwjmJMKTgARnKOQmgq9ic/EIWR07HFKc5w9bf0D+m7eOxW2nrojyD37SBiLaUPCbSxOyeJmeE98nogogw+0XdknzPaQwxcaU6rCQlVU/i56pjxelibGiFbfWGJ7luS/zpAQKgOkqlYTtbr20wlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630300; c=relaxed/simple;
	bh=nus8EXCQy5Vw9MTP03RIYqf7FT1L5evjEegx9BPrpLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0ckLTIPDJDln1A4aB0Ex2k9Jf5mugGulXA2r/+Qr2vbOEljgC9DHdWOgPUJ3Kll07BA3YGta8k+/dk9f2ajxER083x0hvpm0ejvWuGBT6jarZ58xu1pSw2MqhVzK0IAXHFghXnR7q6Fjo1yiBEUL50jr8Cwg/JP08flioFI46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.08,244,1712588400"; 
   d="asc'?scan'208";a="212215763"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Jun 2024 22:18:09 +0900
Received: from [10.226.92.92] (unknown [10.226.92.92])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 54DF54338F32;
	Mon, 17 Jun 2024 22:18:07 +0900 (JST)
Message-ID: <c20a8d7c-a732-4425-ad8c-c5998ed8977e@bp.renesas.com>
Date: Mon, 17 Jun 2024 14:18:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs: stable-kernel-rules: remind reader about DCO
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 stable@vger.kernel.org, workflows@vger.kernel.org
References: <20240615020356.5595-1-shung-hsi.yu@suse.com>
 <20240615020356.5595-2-shung-hsi.yu@suse.com>
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240615020356.5595-2-shung-hsi.yu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wrt1c4Pp6096Reih5PhcYvrU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wrt1c4Pp6096Reih5PhcYvrU
Content-Type: multipart/mixed; boundary="------------hLlHwquRiT6tFl0rMb6UZ0t7";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 stable@vger.kernel.org, workflows@vger.kernel.org
Message-ID: <c20a8d7c-a732-4425-ad8c-c5998ed8977e@bp.renesas.com>
Subject: Re: [PATCH v2 2/2] docs: stable-kernel-rules: remind reader about DCO
References: <20240615020356.5595-1-shung-hsi.yu@suse.com>
 <20240615020356.5595-2-shung-hsi.yu@suse.com>
In-Reply-To: <20240615020356.5595-2-shung-hsi.yu@suse.com>

--------------hLlHwquRiT6tFl0rMb6UZ0t7
Content-Type: multipart/mixed; boundary="------------2RF19yJwrgg8NR7h44Hz0qtc"

--------------2RF19yJwrgg8NR7h44Hz0qtc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/06/2024 03:03, Shung-Hsi Yu wrote:
> When sending patch authored by someone else to stable, it is quite easy=
 for the
> sender to forget adding the Developer's Certification of Origin (DCO, i=
=2Ee.
> Signed-off-by). An example of such can be seen in the link below. Menti=
on DCO
> explicitly so senders are less likely to forget to do so and cause anot=
her
> round-trip.
>=20
> Add a label in submitting-patches.rst so we can directly link to the DC=
O
> section.
>=20
> Link: https://lore.kernel.org/stable/2024051500-underage-unfixed-5d28@g=
regkh/
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> Change from v1:
> - explicitly refer to the link as an example in the 1st paragraph (Paul=
)
> - commit message typo fix s/explicilty/explicitly/ (Paul)
> ---
>  Documentation/process/stable-kernel-rules.rst | 4 ++++
>  Documentation/process/submitting-patches.rst  | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentat=
ion/process/stable-kernel-rules.rst
> index d22aa2280f6e..85a91fd40da9 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -168,6 +168,10 @@ If the submitted patch deviates from the original =
upstream patch (for example
>  because it had to be adjusted for the older API), this must be very cl=
early
>  documented and justified in the patch description.
> =20
> +Be sure to also include a :ref:`Developer's Certificate of Origin
> +<sign_your_work>` (i.e. ``Signed-off-by``) when sending patches that y=
ou did
> +not author yourself.
> +
> =20
>  Following the submission
>  ------------------------
> diff --git a/Documentation/process/submitting-patches.rst b/Documentati=
on/process/submitting-patches.rst
> index 66029999b587..98f1c8d8b429 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -394,6 +394,7 @@ e-mail discussions.
> =20
>  ``git send-email`` will do this for you automatically.
> =20
> +.. _sign_your_work:
> =20
>  Sign your work - the Developer's Certificate of Origin
>  ------------------------------------------------------

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--=20
Paul Barker
--------------2RF19yJwrgg8NR7h44Hz0qtc
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------2RF19yJwrgg8NR7h44Hz0qtc--

--------------hLlHwquRiT6tFl0rMb6UZ0t7--

--------------wrt1c4Pp6096Reih5PhcYvrU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZnA3jQUDAAAAAAAKCRDbaV4Vf/JGvajf
AP9BjqgSsCcLfEq6gPcMjJUWEMjAyPxdRpSt7FVAxyfBSgD/YvnS80VR5FnJ+FVdZ5sUBEXXiZj5
4NCO9opfgYanzwQ=
=JyRj
-----END PGP SIGNATURE-----

--------------wrt1c4Pp6096Reih5PhcYvrU--

