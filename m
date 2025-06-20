Return-Path: <stable+bounces-155118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CFDAE1998
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2DE1BC55DD
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB4280A35;
	Fri, 20 Jun 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="U6rPEzOG"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67B28A1C2
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417682; cv=none; b=o2JuV45lJ5gHYtZqicHfUpm+uIbNIRP8oRBFTX8vbqPAcDk29iEwJZhBTUAkqYrB8Gz4doiWqgRT2Y0loa5zYXvgqN5nNDD/MQfZEHHzNxEvda78bPLPg53AFycgReLsg7qpcquku/09vl7ElC+FsI86S/frwAI75bmW15ETQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417682; c=relaxed/simple;
	bh=e/LpcKInzjsc+hsqF3KQEw/MtzoP6NWEjiySAuIN43I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp1U30nvoW7hp9VFVue+9UPMjZpJmAjJJ5oElqTzpDRQPo759OPS1F+itW9XEfUC9EyqcDJUP5X08rCGCwL51flxI1CPVBSkUssKwkfL6yEYFfQ0mfMxALayWUsdUXhViHt1HKqYj7K5jOxyiZk5CIxu+cRjUer0e3ItVoufR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=U6rPEzOG; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16C7B104884A8;
	Fri, 20 Jun 2025 13:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750417678; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qhgynt/1OYs9DtyajeW1YfTePO+QKg1sd/aVeyWNUoc=;
	b=U6rPEzOGPRkbLLxFcN7EwpiX/B4jw/iBuiGGeL9/jkW7fkfBguCXJBpWZykVG6kPdOcUm0
	3g+y5TdllbJ23JwdPFXYBph8dlzRFLzUqwL7Ghui2F/t4QqIleEVFLuF7CXFX8ZMO4sJw1
	pNNFH+WXjp26LYs/s+XxiZSNrdKPDLRr7yIPoBnY2vSnPs/bRYpGK8QrqiAGUy9q0rP+3M
	orXJRWxjpu5zDNXR6FMCQRVlaXlgOuKzwXQeTLKxlvZ8yOw6DbbAE7+MGQTIQHnZ19YrNE
	ta3JScB7O4w40Bz9SrI8cnZU21deCow2gGojDZs3DyYEzPSmziP+N7sriU7/VQ==
Date: Fri, 20 Jun 2025 13:07:51 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Zhiguo Niu <zhiguo.niu@unisoc.com>, Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 216/512] f2fs: use d_inode(dentry) cleanup
 dentry->d_inode
Message-ID: <aFVBB5s+QMfT/gPM@duo.ucw.cz>
References: <20250617152419.512865572@linuxfoundation.org>
 <20250617152428.386265934@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuME+XZiOcQHZSEo"
Content-Disposition: inline
In-Reply-To: <20250617152428.386265934@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--HuME+XZiOcQHZSEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
>=20
> [ Upstream commit a6c397a31f58a1d577c2c8d04b624e9baa31951c ]
>=20
> no logic changes.

Not needed in -stable.

BR,
							Pavel
						=09
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 57d46e1439ded..f8407a645303b 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -413,7 +413,7 @@ static int f2fs_link(struct dentry *old_dentry, struc=
t inode *dir,
> =20
>  	if (is_inode_flag_set(dir, FI_PROJ_INHERIT) &&
>  			(!projid_eq(F2FS_I(dir)->i_projid,
> -			F2FS_I(old_dentry->d_inode)->i_projid)))
> +			F2FS_I(inode)->i_projid)))
>  		return -EXDEV;
> =20
>  	err =3D f2fs_dquot_initialize(dir);
> @@ -905,7 +905,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struc=
t inode *old_dir,
> =20
>  	if (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
>  			(!projid_eq(F2FS_I(new_dir)->i_projid,
> -			F2FS_I(old_dentry->d_inode)->i_projid)))
> +			F2FS_I(old_inode)->i_projid)))
>  		return -EXDEV;
> =20
>  	/*
> @@ -1098,10 +1098,10 @@ static int f2fs_cross_rename(struct inode *old_di=
r, struct dentry *old_dentry,
> =20
>  	if ((is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
>  			!projid_eq(F2FS_I(new_dir)->i_projid,
> -			F2FS_I(old_dentry->d_inode)->i_projid)) ||
> +			F2FS_I(old_inode)->i_projid)) ||
>  	    (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
>  			!projid_eq(F2FS_I(old_dir)->i_projid,
> -			F2FS_I(new_dentry->d_inode)->i_projid)))
> +			F2FS_I(new_inode)->i_projid)))
>  		return -EXDEV;
> =20
>  	err =3D f2fs_dquot_initialize(old_dir);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 573cc4725e2e8..faa76531246eb 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1862,9 +1862,9 @@ static int f2fs_statfs(struct dentry *dentry, struc=
t kstatfs *buf)
>  	buf->f_fsid    =3D u64_to_fsid(id);
> =20
>  #ifdef CONFIG_QUOTA
> -	if (is_inode_flag_set(dentry->d_inode, FI_PROJ_INHERIT) &&
> +	if (is_inode_flag_set(d_inode(dentry), FI_PROJ_INHERIT) &&
>  			sb_has_quota_limits_enabled(sb, PRJQUOTA)) {
> -		f2fs_statfs_project(sb, F2FS_I(dentry->d_inode)->i_projid, buf);
> +		f2fs_statfs_project(sb, F2FS_I(d_inode(dentry))->i_projid, buf);
>  	}
>  #endif
>  	return 0;

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HuME+XZiOcQHZSEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFVBBwAKCRAw5/Bqldv6
8uLSAKCYZyGRU8yzSnNWf6CP/aODfDg/wQCfXhTzM8ic5+hmrtANI3pwZ3+fJYY=
=jspR
-----END PGP SIGNATURE-----

--HuME+XZiOcQHZSEo--

