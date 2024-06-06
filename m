Return-Path: <stable+bounces-48276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057A88FE0B0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06701C24922
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D52913C3F6;
	Thu,  6 Jun 2024 08:14:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C813A898;
	Thu,  6 Jun 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661681; cv=none; b=SUmasPxUS+x6XoBoLX8fzPBYj54Yh0DbWXYpp/aMWWke52DrjYWdD9Lit93+0CyvylN3+JY113nGh7GX/p8wsEZg7BtVxMZm7WodHdyE25BS1Whsa5ecjIu0er71pUq02yMjRoL/I0bnV272Hcooep9x7hEhMkMJkBt52b3yQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661681; c=relaxed/simple;
	bh=/+/BknMHLrihbmijqoFbVLzfZtNPqhWBdI3sHAuudyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFSvK7rEVSSc0bQOJ9G/ajvOKSwKoyBGvYhwDcyJvzOo1X8Oo8QTonHAwpnhlRdCrRuZ7Ic/4175lbqwkRhfju1L7a94P1arDnrSCm9OPEGzM2ihrkljhfrIaglBd519l2j8o9N+XZKT5dM/0WWnub6s9aYLh9QLhDR83vnvlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="asc'?scan'208";a="210885326"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Jun 2024 17:14:37 +0900
Received: from [10.226.93.107] (unknown [10.226.93.107])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 72C8C41FD116;
	Thu,  6 Jun 2024 17:14:34 +0900 (JST)
Message-ID: <13e77ad1-7ff0-453b-b8f9-7962d15b49a1@bp.renesas.com>
Date: Thu, 6 Jun 2024 09:14:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: stable-kernel-rules: provide example of
 specifying target series
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 stable@vger.kernel.org, workflows@vger.kernel.org
References: <20240606064311.18678-1-shung-hsi.yu@suse.com>
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240606064311.18678-1-shung-hsi.yu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xI3MkB3bqz4WF3eJ5X8zp2y7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xI3MkB3bqz4WF3eJ5X8zp2y7
Content-Type: multipart/mixed; boundary="------------cuym2VioR9YeBxcmeIilliEz";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 stable@vger.kernel.org, workflows@vger.kernel.org
Message-ID: <13e77ad1-7ff0-453b-b8f9-7962d15b49a1@bp.renesas.com>
Subject: Re: [PATCH 1/2] docs: stable-kernel-rules: provide example of
 specifying target series
References: <20240606064311.18678-1-shung-hsi.yu@suse.com>
In-Reply-To: <20240606064311.18678-1-shung-hsi.yu@suse.com>

--------------cuym2VioR9YeBxcmeIilliEz
Content-Type: multipart/mixed; boundary="------------cwYi1y9yKe2mdo4v6vJz18ui"

--------------cwYi1y9yKe2mdo4v6vJz18ui
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/06/2024 07:43, Shung-Hsi Yu wrote:
> Provide a concrete example of how to specify what stable series should
> be targeted for change inclusion. Looking around on the stable mailing
> list this seems like a common practice already, so let's mention that i=
n
> the documentation as well (but worded so it is not interpreted as the
> only way to do so).
>=20
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  Documentation/process/stable-kernel-rules.rst | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentat=
ion/process/stable-kernel-rules.rst
> index edf90bbe30f4..daa542988095 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -57,10 +57,13 @@ options for cases where a mainlined patch needs adj=
ustments to apply in older
>  series (for example due to API changes).
> =20
>  When using option 2 or 3 you can ask for your change to be included in=
 specific
> -stable series. When doing so, ensure the fix or an equivalent is appli=
cable,
> -submitted, or already present in all newer stable trees still supporte=
d. This is
> -meant to prevent regressions that users might later encounter on updat=
ing, if
> -e.g. a fix merged for 5.19-rc1 would be backported to 5.10.y, but not =
to 5.15.y.
> +stable series, one way to do so is by specifying the target series in =
the
> +subject prefix (e.g. '[PATCH stable 5.15 5.10]' asks that the patch to=
 be

"that the patch is included in..." would be slightly better.

> +included in both 5.10.y and 5.15.y). When doing so, ensure the fix or =
an
> +equivalent is applicable, submitted, or already present in all newer s=
table
> +trees still supported. This is meant to prevent regressions that users=
 might
> +later encounter on updating, if e.g. a fix merged for 5.19-rc1 would b=
e
> +backported to 5.10.y, but not to 5.15.y.
> =20
>  .. _option_1:
> =20

This is a helpful clarification and I like seeing an example. With the
trivial change above:

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--=20
Paul Barker
--------------cwYi1y9yKe2mdo4v6vJz18ui
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------cwYi1y9yKe2mdo4v6vJz18ui--

--------------cuym2VioR9YeBxcmeIilliEz--

--------------xI3MkB3bqz4WF3eJ5X8zp2y7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZmFv6QUDAAAAAAAKCRDbaV4Vf/JGvWU6
AQDSsAO3bvQOfdU4uSNy9JHsga8OyLIF2Rs7Fda7u/NyOAEAq6KIJw4g73ZA4mkNsnOM7kUpXq1+
KcKZU1/hFlLX2wM=
=jN5l
-----END PGP SIGNATURE-----

--------------xI3MkB3bqz4WF3eJ5X8zp2y7--

