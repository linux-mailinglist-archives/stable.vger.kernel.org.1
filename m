Return-Path: <stable+bounces-196900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA716C8527D
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6CB3AEEF2
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A984B3242CD;
	Tue, 25 Nov 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Xs7rU1SA"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA13246ED;
	Tue, 25 Nov 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076844; cv=none; b=BoIAepqsVSGMKjfAXgImiSrAtTJ+dcYRGwwHi9dje2yzieSg6OgwSeGl/n4cVUMirAZajXoyo2QTIF6YP7uNHKN0n2AMGRPjmVlycoYuAcuJqNlRRrCl2swPuyjp28iRiIVdGE1IyqE57cH6W0YqDUMDqrRqeylhcT3s56RaEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076844; c=relaxed/simple;
	bh=twqlslUrYoCmY+2WtlEMXXaqRmdbRmVpNIa/L4qkL68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kilN8IVcDrEfk8UPl6ebGZsucgIIEg72cXEeK2k4gYZUsLwDn6OF2Kias9PGWnGQf9vhN94UsSUZY3oaq5KZlTqM1UqjkCu7/b7iQ7QM7pIveyKA14mfWTwk+eTigQg22kxNmfTFWO+EjjHh5cFwpoopBYzrwkIv00zotwnDzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Xs7rU1SA; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27098103D145C;
	Tue, 25 Nov 2025 14:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764076839; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WgSUZ1unwTielDIi2BbroLxSn72iCkBtktFczi48oKE=;
	b=Xs7rU1SAnxUnLSJcrRvYZmtNfsTQeKbB7ixPkRm5S7cjK3XoVWLEQ/HJ80KGdDKm5YqDGP
	pbTaewuSkLvdtNgjgQIliB8ewdyibGE4CoiZP4HhW6fYOr3d9okzIqa25+uEa3qazyJYRu
	NpN0+bkf1vbBjW8uQWsxXethTgRHUeDsDrpJZ52pT3orPzlY/aLZ67akiuEml79dcVywXj
	nqQZOXU5XXioVfQRYi0tqjEQ4Pk3z5EK02n9ZVglaWjyOASNAfImnEuoVcMelmfrfrj/TW
	teEFYg3zLRPRSW8FCtNQ3E7j7LfvQoBVj+iDKO1k2EABq5PbHH5tzoIiCsyTGQ==
Date: Tue, 25 Nov 2025 14:20:31 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tiwai@suse.de
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/185] 6.12.59-rc1 review
Message-ID: <aSWtH0AZH5+aeb+a@duo.ucw.cz>
References: <20251121130143.857798067@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yPwJKJgdeFw8ZpS5"
Content-Disposition: inline
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--yPwJKJgdeFw8ZpS5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2025-11-21 14:10:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.59 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


> Takashi Iwai <tiwai@suse.de>
>     ALSA: usb-audio: Fix potential overflow of PCM transfer buffer

This one is wrong for at least 6.12 and older.

+       if (ep->packsize[1] > ep->maxpacksize) {
+               usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u /=
 pps %u\n",
+                             ep->maxpacksize, ep->cur_rate, ep->pps);
+               return -EINVAL;
+       }
=20
Needs to be err =3D -EINVAL; goto unlock;.

(Or cherry pick guard() handling from newer kernels).

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yPwJKJgdeFw8ZpS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSWtHwAKCRAw5/Bqldv6
8k9TAJ9XP7IRiEY3Z+bpDrR6TLOMXU8GcwCffZnmx3ER2uW6Rg0fmaGTwboVeRc=
=EnLy
-----END PGP SIGNATURE-----

--yPwJKJgdeFw8ZpS5--

