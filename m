Return-Path: <stable+bounces-67371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B9994F5F2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AE31C20FF2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE754184540;
	Mon, 12 Aug 2024 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="AAPz6e+F"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC813A3F2;
	Mon, 12 Aug 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484475; cv=none; b=jjuBXQM6x2e7g73N1K3D38hiTa1jx4heKeN0P0xTl3qIZRllQFPJXwNYDUbZHaNPg3FA0cJvoHsG3MizOUtXdqUPkunn3RI0r+KASftaPZY95rqgJr1vuSFte4GApBMB+EzafcrEtpv4nUS+g+8PF07t5Pzllz0MXVaT+mWyuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484475; c=relaxed/simple;
	bh=VakPXC2M+vociIzuEJDlY2TRNwMRMDXnlBvDoQY/Ah4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezjsja6ksjrOHEBPhddl97sw4jduUZ+3KdmTKZ5JOHpNQdoUuStJhV8YsiuTe2UZlkq0SKXqlzPBE2qGF91MwLzR33J6duMmfeAUpQfzMWtCVoCuKCPKyI3/4UwkGzR3sWxbU3aHyLE2WFNEQSQvkzg7vN7E4euZk42Y23kuggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=AAPz6e+F; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723484442; x=1724089242; i=christian@heusel.eu;
	bh=VakPXC2M+vociIzuEJDlY2TRNwMRMDXnlBvDoQY/Ah4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AAPz6e+Fxp6UBdJ8wQysLBuzhBKyprpcyNtDJIoGln6tmRWDPpj5GnOXszI9Gb28
	 NIJa18LVQt129fO9aVYr8URgXLuBlsWjiSveCDdbjiNJHzI+HogV+tGIV2dmmzfj9
	 10BEa7MuSKbUur4KTNKVlJLqE9sd/eli5DfoJs9t242ymCboS5u4etWRmFria3R9y
	 1Nif7B/RBljgRWMjyCImux+Sr3ujaufwhpctpF8afQ0t0NdDBUB08FzMzQBo3U5kB
	 aBl/aSUv3UjNBJm9xxBMehxMHtXqiYoL1vZaVsS/8aKvRufypANGkyRUPsQSVA6np
	 4XGnsiSmhMcaM4IW0w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([84.170.80.33]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTiHb-1slV0p0Dc5-00YOIC; Mon, 12 Aug 2024 19:40:42 +0200
Date: Mon, 12 Aug 2024 19:40:40 +0200
From: Christian Heusel <christian@heusel.eu>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Igor Pylypiv <ipylypiv@google.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	stable@vger.kernel.org, Stephan Eisvogel <eisvogel@seitics.de>, 
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Return sense data in descriptor format
 by default
Message-ID: <e87e8463-acd8-4cbd-af87-3d65a179ee7f@heusel.eu>
References: <20240812151517.1162241-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="coeursx6zvw2qoic"
Content-Disposition: inline
In-Reply-To: <20240812151517.1162241-2-cassel@kernel.org>
X-Provags-ID: V03:K1:SN7P2BJzN5ENTj0f8ZH4NNOxyMy9tv4E2gH61LKnPY6QLjKOu3P
 O16mZAuAl7uyrKZ49x9Jkv2annr8GHzWc+fWPRCck8l1U4A4uUAicUUC2gjG4zfPbxdXGWm
 xXX0Yxqs5suol/75nFpYhJ0llMVwq57nk/5YRC41R26q85bm59OLNairJ+5dhREjh2kViIi
 itzMDs6Tqbuy4Kd+gqJ4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lxiJOM4Bl7U=;HiCloJ2PmtYqdS0IBF2qTBaxYXM
 mp/Wz/rbGaiwgNYDRCKKM+IcC/I34EhAAsjgBb/8Wi8v0kFTBbEv8NByO5Kb1AP4Esy4WiSn1
 dQifKqn9Mj1x58DtehQ3lfzL23DUSVrnGMnzGOR/1d8xuIoAaN7k2hDoE/NB222X4bVT2B4Uf
 K4TdMrkSLNZTlyUKgG0c6HklK7fH73cbQAVC/KG4ZmftpNYyGqx3deVICKlvsQOkO57xkS4PG
 k2Jn7B94orFqeT4Y5pvuj+9xUtmDgUQppsyI8+nR3BmoU25E1AC/RH+F1Tp4TrDYNxBI7Q/Ei
 b8BGcMlDTUiAMsTbMs2ClyFcygLN53zvqNMyHONgAthbFKhlI4BqVqoAo5If0wN9R6+XM2asn
 c/SgeoZ+UGJLoR7+Iqo1L37mxoKvXql/ry93HAFxlfFOAGZgC1n8N9/LC1ARGEGltESypM0hC
 ZKrE9eOFPxhyOsALx9EU+HX7Q/hWn9/SL85rLjn2Fp2NXSXYd0UAPkAEVPNsU00/YBsSRJ4WE
 a3b+8Mds9Z9WbI7MKHtxUfoaRwIHclAXh5dYKZcxIE1jpx5TZU+blYP378zfNZmEZZdmhbEQI
 m3sJl9X8I3oPryyz4HY0qv79rK7iA4JxF7X1bnlUyxsQ/dRA7b8jt+Ha9X5lRqZni7IdKANU9
 MYCQsyo2ghcPknOTtyIyC9XCttfYo0iwMngKDiUVu9jrLDe29evnbX4FEvbgWT3k0FRDjoQW+
 U2ybzG/dZjLc/yXoqbqPBi9wHvRxMZG7g==


--coeursx6zvw2qoic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/12 05:15PM, Niklas Cassel wrote:
> Sense data can be in either fixed format or descriptor format.
>=20
> SAT-6 revision 1, 10.4.6 Control mode page, says that if the D_SENSE bit
> is set to zero (i.e., fixed format sense data), then the SATL should
> return fixed format sense data for ATA PASS-THROUGH commands.
>=20
> A lot of user space programs incorrectly assume that the sense data is in
> descriptor format, without checking the RESPONSE CODE field of the
> returned sense data (to see which format the sense data is in).
>=20

Tested-by: Christian Heusel <christian@heusel.eu>

--coeursx6zvw2qoic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma6SQ0ACgkQwEfU8yi1
JYX5cQ/+NhGdxHEqx4Ga2VuNPVXIQvICXOEUKRQl3mjvWFgyT6EUSsi0oAi/wDDG
P6+G9BWP0x5XAQGSO7ZcImDdDoy4LG/Y+PvyAj9CWB1fPViyG1PsnlUUfaUwU9kC
qPgehvPDYYgh3PlEJEC1kqJ3/VV2S8/zFPEhmfz0bZAyoul2o88BHpwZrfCS7jJy
n5HWI3iEUb1MGWy/2ov6vGjR3S0PyprLgA6LeqKg7D2S/7UUS1NcFEcoKkcmd5Wx
Ln1YtbuOepIfnw449yMGEs3fiCTrdCzdkSjoVtLtX1Yl/cJuaG+3dDpgQ58g+t6P
mRjbSuR4d2BgM/JE3sYS5fRg3iphNBT4hKkzaoGUM2OEB/wSX7f38rSTjdUGStI6
+hb5ytRofPvg95acu1M3bC7MPix4XytOR9akoYxgFc6I2zgkzfpVJTi/I1uUCXCF
JLFDtfdy3pSnM3LHuab5LbJtf3BBP3qlg/1K7k83lyOO8AncHRkNA894UAYwneQa
Hc1aydKC6nQxjVQfCemDtUYstsrfKTYcBS81kaWyFTBqXKKABdLLC4JN/NHwyULo
D/In/Yzo8QnAJjShtW/zBBnOr2mMzZPq6IvUYboX8h9L8maX1un0xGLrVAsS2zYk
W3umhFfyOoeff+pD9BZq8OlHcGMnYSc/vqbpYpTInKko8CRUe68=
=xqEI
-----END PGP SIGNATURE-----

--coeursx6zvw2qoic--

