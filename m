Return-Path: <stable+bounces-119844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F445A47FA5
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 14:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABE6170C72
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC022FE0A;
	Thu, 27 Feb 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="OY+wDi8m"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5222FDE6;
	Thu, 27 Feb 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663622; cv=none; b=Sifr6DlpBCfbC2QVtYLpHMfoTxJOl/CAtz/ymtPGTCqAnEwOAawkFaEMCrm1Qk7E6NCZdqG2bitJQkdTxgoYOGc6+oUJGu4mB7F49EVM5QC9TRQsGIv53wu4faiO5yj28TQFAy2g5sqU4IJ7zcs2l9UtzXxu/VXUe0n6c33Cwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663622; c=relaxed/simple;
	bh=yu3I1sO/i0c9jmjryoQXFMF6uACIg8nN2pvKPs7EzGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCioFoQwblTOEyn4VHFwUW/GD48OL/00in74VYGxL+UqBJCwcT2di6P9xXCtxeM0s1KS/yrm937kKp2U/S0Ai6h57BG3fLGSL8zWqQUYfkb2W2OoaNAn33LIsh8BeNJkEGE9AygGlVcOi8Gpqqy09ZGiIBMPsVMvkqWYdGG5k0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=OY+wDi8m; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1740663605; x=1741268405; i=christian@heusel.eu;
	bh=yu3I1sO/i0c9jmjryoQXFMF6uACIg8nN2pvKPs7EzGs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OY+wDi8mQsCJM7BfpOZ6s7aaD4w2VKkx97L/4ZDf+zzfiyUhT6RPPz4yGzgZ2UA/
	 MWE4YBx21KHIVOUNcXC9vCmlkTqhc9dwMYewxgZCN9RNuVlAhiZNyhps9g3MDfCuH
	 Dbu0sSAziL7qAPxFM68M1k13eEir+dg4mF2moGMVWw7ZpyomKnrNPF85kxZROL8ph
	 SjBpN+0Gb7/YKMxznZwY2kQ7S7gO9pjaxiVznJ6aFnqLcun2VxoelgAvJDNa8AkMg
	 L+fnu1t+Nv/2QcNeAuTLWpD3GTsDh2YlaglMkaYxiOL1Hbi/yvCtZ6R/WHXW4GRFj
	 62hZcwa9xKYEY4VLDg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M7KKA-1tvMHh2URg-004FeR; Thu, 27
 Feb 2025 14:40:05 +0100
Date: Thu, 27 Feb 2025 14:40:04 +0100
From: Christian Heusel <christian@heusel.eu>
To: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Rhodes <sean@starlabs.systems>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, qf <quintafeira@tutanota.com>
Subject: Re: [PATCH] Revert "drivers/card_reader/rtsx_usb: Restore interrupt
 based detection"
Message-ID: <0944ac33-c460-4d3b-9ec8-db70d11ee9c1@heusel.eu>
References: <20250224-revert-sdcard-patch-v1-1-d1a457fbb796@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fagmpuwyw6jacfay"
Content-Disposition: inline
In-Reply-To: <20250224-revert-sdcard-patch-v1-1-d1a457fbb796@heusel.eu>
X-Provags-ID: V03:K1:UAoKiThL18eaMR16lOypH0tDL6v31SyTTnwORVvuURDpSv3GNWP
 CyFsrTNUAWbByqOo7I//b5NbcH9NlkrI+NTlJg7igchBazkXrtLBzM8zb7N7aynuHMHS4O4
 Sf8/vJ/yJh34LY8NxzZDflq3VLAx2lMVwpHuLx8gg1hsqGpNz4rp3CMxJX1sUWgXueenOMW
 hJj4LE/nFr6Gm22AT6p0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sh1JRP672aE=;zh6hCt48hOPk3M/wMoIQdNLk4V4
 p7M8SivExwrxQRYvOg3F5ENawAfgyVf4YEUTP457EnkxV1Vh49AS5uuwplqo03qvrqUui9vc/
 S1Zs0goECjwuaj+9FBxrFhUHpc28lBi0KXIVa2j8kODfIVvTjwnjJjCDuidB+kWWmDA1ES8CR
 mdot8h1ouK/XGciXpfJoZdviYX6nAlc1nQ5QeozgC46C1+zMktVUB5Ajh4Ac0QgqkjgSG4o2Y
 3QSeS0sYTj3LKZT4GV6q2aiI6Y3Jfn18eVNplccnzbnr9sLRYRGtx1cC2ZVaA39xPsa3QyFgI
 NdBPcXC5OSURFNrjwJD+yTJw9eOGNwoIdf3MCX31snPThKmvkoK4NlLGaXt8P1gNEfJEdwT2W
 Gi7xd6G+ZC+XcCrhAitvnHSujP10SUpkax2kNAJvXJVjYevMLwr97/b93WqYWR0KyNWxpvtyy
 gIFNLRpVKR7i4ZZ2j73ktNJHULxLB7MlsmznevxPbi2PcxYv0iVotgSosL9o6CDEiF4wV8hC7
 XqPijSvrmm+40ULLKhGreMeHXejktwGR9uWdVFYkFz+Ot2wp7H1Zzcxm+70c6zXW2bxwg3tUA
 Twi14Znio7gkSG2kTDqpgMvq6vAhj4eeCrbnqJlrI/KQ3VQcQbgiwbTNgQoc34GgPJbPC+cu9
 hcFlafSTCpYlDiec2WtOpKhdNMMipdZlQsyVUZwZmySSekEI94RoFyAMlB0JIBiht1iD683h4
 yWV+8KAa6g/ofOGyykZywvyKEOaqKg53INpah4oUrkpH5Zoc9AwTA2ZIaKO7KiwMMUI36ixVj
 YTEFnrCcnhclWlLwt+KS00ZgutdkjUdbNa3u3GiEzgcVdJxUEppD3aq4hp9LCZ8XoKWkssMRA
 8pYckXilyvImBQ09z2k7WYus+WoFOmb8HQypeMStgRxSxX7iKQVC9GSpNw47srEPZWKDpfur+
 9pEui2NCcLMHUD/mqy/qFnxbqxfgunbJnFii34GEVoakDOeNBsVQv4QcF52nT+u0BP1CE+0T5
 0+RMmieRjyIeEdnhXsCUFrZgZSVcoYAvxL7L5ggRB5DUJhMU/NGAtFCPdbgONRj/UKSfMUA0y
 PcS687+UwlRvONfHoGA80cVr79AGZJx9vX8F42XT+DWLfZNBZMS8UMA/R8slWhvnj5Ky+GWhQ
 MCbVydaSrHJ4/2C4EAQ1tWuwp/genq95+T5wP0IwrAEl/0DbQFpZtMa4l8uQlNV5Cwar7xVRc
 4wp5b7tDI+augzxNJmXvmgN0i2miEECNOtl0wwvcnxWzs8D3UrL9aJ+6gzRY59kRdcn6Qg9bO
 HMWurPfwvwBJoPYzlM09pPFGkPCRUGkPJUmoqNaVvXytdyzY1EEFS39eI7oMCW5f1YoCPGLOk
 XTterFyNGX1GmW3Q==


--fagmpuwyw6jacfay
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "drivers/card_reader/rtsx_usb: Restore interrupt
 based detection"
MIME-Version: 1.0

On 25/02/24 09:32AM, Christian Heusel wrote:
> This reverts commit 235b630eda072d7e7b102ab346d6b8a2c028a772.
>=20
> This commit was found responsible for issues with SD card recognition,
> as users had to re-insert their cards in the readers and wait for a
> while. As for some people the SD card was involved in the boot process
> it also caused boot failures.
>=20
> Cc: stable@vger.kernel.org
> Link: https://bbs.archlinux.org/viewtopic.php?id=3D303321
> Fixes: 235b630eda07 ("drivers/card_reader/rtsx_usb: Restore interrupt bas=
ed detection")
> Reported-by: qf <quintafeira@tutanota.com>
> Closes: https://lore.kernel.org/all/1de87dfa-1e81-45b7-8dcb-ad86c21d5352@=
heusel.eu
> Signed-off-by: Christian Heusel <christian@heusel.eu>

Hey Arnd, hey greg,

could one of you pick this up? Sean said in the other thread that going
with the revert for now seems like the best option and that he'll
revisit this once he has time...

Cheers,
chris

--fagmpuwyw6jacfay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmfAazQACgkQwEfU8yi1
JYWglg/+OCt/KmHtOczd6opE+8TuRU/+flDmltOsMsoryY6v6s0fMeawT5ShG7bm
bLhIzQuYD/WIFvXbG9J7ss6fIez8MmvvyMA6SKKkdoSwZWcXFepoqak7yWQ08nDn
tsDYtHLpNpZMIb81fbrZznWtIeZCqM10pegOvZ0k3Q39V4E1O/+IrMfYRtb2ipOV
2qliIL+eAzuj6uq8W1JTOGmEmzBn81JNEocjZ1hLpv5NOd+cgQ4U18xQGzCJ/q7Y
vZUS/RKAG4874+RJJu/ecOO2NAD3j/tUb31Un3OqJ08x0FP+XWv2ZLXR7lnVWHJX
zWphOztxwRxl4Ay3fqFFUN2693YnJeXQwqURK2nk9k9APpKyUqq16mCEHbEjI+Eu
i+KlJ6vUz3k7EfFoLzZJjTXOymGqaT+0W1Co4S3c6Z0rxZnlL1uo/PMtZjLvyRts
rcVUA6msIZ4xy+oAP/9+FeI7QjhH1Au27ruUdhU8rxmLhqJq1+HxwAUFz2eUIt/r
aCg4tfSGZ3vKJkuKWo0VORFy0r4E7JG4tyyFOYruCKi6HYduHgf95alfA9l9LV8G
EE1D6SoYlRBwuwTMI6MtLJWxVkpvjWNPwtoedxVLgymv6LWHs7z70QoqNW+l19hG
SI7IDY8GHkD7K0nk1g6j7LzjxN8iwUVFzBAspmPpCQhMGyCf/cM=
=OZ9j
-----END PGP SIGNATURE-----

--fagmpuwyw6jacfay--

