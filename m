Return-Path: <stable+bounces-155112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2A7AE1985
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779483B9694
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD7B28A3E4;
	Fri, 20 Jun 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="PEb/6lKP"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78C289E1F
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417322; cv=none; b=KwxogO5aVTXmO+CULVyh0T50qd5CaNBA/3Ave2mrysr4/ESSFjhq8BMFj2IByIaKiP3vzAjxlm+HrStpI00W5Eq7zeiFX/oOay2Bryo+3XWh3dorHej0ZUo5BicQfk1fbCz+l0jN+f34OCCX1TzKRwz7vNld7F9w4weUTcCZ0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417322; c=relaxed/simple;
	bh=PBmxfMK4dYXvPj2DdPUsVBmsmy60mem5FXuBIcJAXpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYYW+t8zxDwvq+wyXuoOe2j6j5G3XiXA9aHlqjPt978kGj9tIpwAdItCKAwi7ELt1+xnXMzU0+L+2WR22UwhbP96/SR/BThduJqUysfTyYaw0RCrALsG5E6pXoJ9pOxC9L7rEYVew7UukEYSkBDMUAsmGkg26rt/kIATUkZ3A5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=PEb/6lKP; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36C0C10244BF5;
	Fri, 20 Jun 2025 13:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750417318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aC3nCUAqv215nzROazMLwF6Moh+EDFp/FZHVnK63/Uk=;
	b=PEb/6lKPSaSRqSho03KXVbEY7hpzJ7xjuHVbifV0Bn4OpnXjEnyoUqEH2CIuKJ4Ca7z29Z
	e8S9TpMUcMLw0FTZUQq/8dH5WPzZwnSxEZRKirLKv9ZIKZGKCo1jZ/TpSa9Db0LLtShwAW
	7I3+gE4H2ZhxPMGSfC28SgfEhazEohd+Pkm9009cTp5XW9bvRVYfrTB+NbIeYtcUc9Nvyz
	jq51b12/z7N5LociUnUUKVJ5yAMrq60VUY/uNtN+N4/lU72YxUXqFfOwAzW4E+e2fGskdX
	Jb2HqBlcIclPTojdfIpX12LaeHEtCmWySItr6/xgQLjaNGFjtCZ3incgWaCjew==
Date: Fri, 20 Jun 2025 13:01:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 118/512] f2fs: clean up unnecessary indentation
Message-ID: <aFU/oqkl8sswxCag@duo.ucw.cz>
References: <20250617152419.512865572@linuxfoundation.org>
 <20250617152424.365601993@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9osGMlcebEkrNgNa"
Content-Disposition: inline
In-Reply-To: <20250617152424.365601993@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--9osGMlcebEkrNgNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 05d3273ad03fa5ea1177b4f3dfeeb6de4899b504 ]
>=20
> No functional change.

Exactly. Stable rules say we don't take cleanups. Bad bot.

BR,
							Pavel

>=20
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/f2fs/segment.h | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 0c004dd5595b9..25d3cda9bd5a3 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -431,7 +431,6 @@ static inline void __set_free(struct f2fs_sb_info *sb=
i, unsigned int segno)
>  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
>  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
>  	unsigned int next;
> -	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi);
> =20
>  	spin_lock(&free_i->segmap_lock);
>  	clear_bit(segno, free_i->free_segmap);
> @@ -439,7 +438,7 @@ static inline void __set_free(struct f2fs_sb_info *sb=
i, unsigned int segno)
> =20
>  	next =3D find_next_bit(free_i->free_segmap,
>  			start_segno + SEGS_PER_SEC(sbi), start_segno);
> -	if (next >=3D start_segno + usable_segs) {
> +	if (next >=3D start_segno + f2fs_usable_segs_in_sec(sbi)) {
>  		clear_bit(secno, free_i->free_secmap);
>  		free_i->free_sections++;
>  	}
> @@ -465,22 +464,31 @@ static inline void __set_test_and_free(struct f2fs_=
sb_info *sbi,
>  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
>  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
>  	unsigned int next;
> -	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi);
> +	bool ret;
> =20
>  	spin_lock(&free_i->segmap_lock);
> -	if (test_and_clear_bit(segno, free_i->free_segmap)) {
> -		free_i->free_segments++;
> -
> -		if (!inmem && IS_CURSEC(sbi, secno))
> -			goto skip_free;
> -		next =3D find_next_bit(free_i->free_segmap,
> -				start_segno + SEGS_PER_SEC(sbi), start_segno);
> -		if (next >=3D start_segno + usable_segs) {
> -			if (test_and_clear_bit(secno, free_i->free_secmap))
> -				free_i->free_sections++;
> -		}
> -	}
> -skip_free:
> +	ret =3D test_and_clear_bit(segno, free_i->free_segmap);
> +	if (!ret)
> +		goto unlock_out;
> +
> +	free_i->free_segments++;
> +
> +	if (!inmem && IS_CURSEC(sbi, secno))
> +		goto unlock_out;
> +
> +	/* check large section */
> +	next =3D find_next_bit(free_i->free_segmap,
> +			     start_segno + SEGS_PER_SEC(sbi), start_segno);
> +	if (next < start_segno + f2fs_usable_segs_in_sec(sbi))
> +		goto unlock_out;
> +
> +	ret =3D test_and_clear_bit(secno, free_i->free_secmap);
> +	if (!ret)
> +		goto unlock_out;
> +
> +	free_i->free_sections++;
> +
> +unlock_out:
>  	spin_unlock(&free_i->segmap_lock);
>  }
> =20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9osGMlcebEkrNgNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFU/ogAKCRAw5/Bqldv6
8kJRAKC8/gKs7My17bhtS2z2fYWZG442ywCfUw7LPYvou3tkDPDv9cjgDKlU7rw=
=jZa+
-----END PGP SIGNATURE-----

--9osGMlcebEkrNgNa--

