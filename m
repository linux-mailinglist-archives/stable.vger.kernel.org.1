Return-Path: <stable+bounces-12173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FCA831894
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 12:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E1C1F255A8
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65172241FF;
	Thu, 18 Jan 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dogkC0Km"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39D241F7
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577967; cv=none; b=K59iRTJaVdLEdNssYQtnSdqqrX4ns3cSwJpjO6wdoQK44cReAMZwzcNYffxRYxFu74OQ7gDHNjP7CaSeJCE1U9wVKciNV4k64ebHTEXQjXvM4EGq8j9kzGJRCLNTlNBbPI6Bh5+gBV/+zvqHHLd+MRtSxf7t7PLLcU/cjSsx+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577967; c=relaxed/simple;
	bh=99kVtTQGqgyKdKt5z1Snj70s9KpVAmJhM85T8r2CjFA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=KMWkWhk1VtiGepvpHYIpe/GTnS8Ah8BPJTCCKKWQuJTjPQWi4WOud0r58Wa769AV8O/+o+JQEs4ZBcbVDy04sl9qtnWJb4mDQEU9XgP/iqGc2rTAuAv+TyMCZ459wetk6Ce9PXyieS+3ZS2ath7mjcUxiRL1xdCtBkUGpR974k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dogkC0Km; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a356f8440so392031a12.2
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 03:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1705577962; x=1706182762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNpGQogZ6nMvhPzDXLu2EM0aCKz/G7JiTMEfiSYUfUA=;
        b=dogkC0KmP8yKfpA6eZMjsrSeXTdQn8nq01Z7MwT3E+MUFN5Nd5ECDdRTx0jzhdMGtL
         gzxrc1PQwi07xs4f3VejW0qYPCX0kslRDNIE8Tm1+J/TESojJ55Htq3psBBFRkEXa80J
         iL+ZCHX6WBeHjHGBksTvhx2N36woBvb+R0FY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705577962; x=1706182762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNpGQogZ6nMvhPzDXLu2EM0aCKz/G7JiTMEfiSYUfUA=;
        b=dXI4bMLmcOjzhdIzcWO5JWmDfj2PkDFj2ZUDSrdED1Wt7bLwR48HXOFoInTLnAGzUs
         OefUnRbGfK7EdroJy1/ZnR9m0elNhlcY+O4YUBNsdoAINkrIkueVuVwuXbAwXkLOin8Z
         JMVRhEJ7WdLVqA+OxdOl/Y4Y2o6szPlCbbe8CuK5zKdY+3h5v5nv87YSzEq71m2kcW9Y
         sNoIqHyMsuxS/g6Dd0/TwL6tEr3UhlaF6lGjY6CKiZeF5przGFjxBzEGt2ATBX3/vd29
         GF0MtMO45Cbhv0g3Myez02HJRhksttxUOjJRxGJ/k5tJtszVbJ7un+9/7yAx9Z0+5UHZ
         d/9A==
X-Gm-Message-State: AOJu0Yy8Ljb0+pj+sYwsvRD16UnEEULoEG+Oqc2Wc2L1dC2zx+K+Elsq
	3l93KgIS3aWN+1DsDnnQdtGl6WsiC7y3Bu+2L7G8pA3G326CU+SDrVgReJMtRQ57bTTME82wfJD
	0ng0uqz9AOvUhAgVP0x2H6CmaXN6kp65ZIJApAA==
X-Google-Smtp-Source: AGHT+IGIAFfQAtQ1ZkWClSLiycVAkl7NbcKu86Xz6RojZM2XBh7VfzBIdj0OHoL28DxfRZD6Y2FGWLJVxORXsBi7cBk=
X-Received: by 2002:a17:906:5ac4:b0:a2e:cf45:5a10 with SMTP id
 x4-20020a1709065ac400b00a2ecf455a10mr441879ejs.141.1705577961322; Thu, 18 Jan
 2024 03:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104144.465158-1-mszeredi@redhat.com> <CAOQ4uxgB3qhqtTGsvgLQ6x4taZ4m-V0MD9rXJ_zacTPrCR+bow@mail.gmail.com>
In-Reply-To: <CAOQ4uxgB3qhqtTGsvgLQ6x4taZ4m-V0MD9rXJ_zacTPrCR+bow@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Jan 2024 12:39:09 +0100
Message-ID: <CAJfpegvhWwmHXzo3dd5VYLrCjUhxAesNAha-dOB+PCP8M2rM2g@mail.gmail.com>
Subject: Re: [PATCH] ovl: require xwhiteout feature flag on layer roots
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jan 2024 at 12:22, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jan 18, 2024 at 12:41=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.=
com> wrote:
> >
> > Add a check on each layer for the xwhiteout feature.  This prevents
> > unnecessary checking the overlay.whiteouts xattr when reading a
> > directory if this feature is not enabled, i.e. most of the time.
>
> Does it really have a significant cost or do you just not like the
> unneeded check?

It's probably insignificant.   But I don't know and it would be hard to pro=
ve.

> IIRC, we anyway check for ORIGIN xattr and IMPURE xattr on
> readdir.

We check those on lookup, not at readdir.  Might make sense to check
XWHITEOUTS at lookup regardless of this patch, just for consistency.

> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -51,6 +51,7 @@ enum ovl_xattr {
> >         OVL_XATTR_PROTATTR,
> >         OVL_XATTR_XWHITEOUT,
> >         OVL_XATTR_XWHITEOUTS,
> > +       OVL_XATTR_FEATURE_XWHITEOUT,
>
> Can we not add a new OVL_XATTR_FEATURE_XWHITEOUT xattr.
>
> Setting OVL_XATTR_XWHITEOUTS on directories with xwhiteouts is
> anyway the responsibility of the layer composer.
>
> Let's just require the layer composer to set OVL_XATTR_XWHITEOUTS
> on the layer root even if it does not have any immediate xwhiteout
> children as "layer may have xwhiteouts" indication. ok?

Okay.

> > @@ -1414,6 +1414,17 @@ int ovl_fill_super(struct super_block *sb, struc=
t fs_context *fc)
> >         if (err)
> >                 goto out_free_oe;
> >
> > +       for (i =3D 0; i < ofs->numlayer; i++) {
> > +               struct path path =3D { .mnt =3D layers[i].mnt };
> > +
> > +               if (path.mnt) {
> > +                       path.dentry =3D path.mnt->mnt_root;
> > +                       err =3D ovl_path_getxattr(ofs, &path, OVL_XATTR=
_FEATURE_XWHITEOUT, NULL, 0);
> > +                       if (err >=3D 0)
> > +                               layers[i].feature_xwhiteout =3D true;
>
>
> Any reason not to do this in ovl_get_layers() when adding the layer?

Well, ovl_get_layers() is called form ovl_get_lowerstack() implying
that it's part of the lower layer setup.

Otherwise I don't see why it could not be in ovl_get_layers().   Maybe
some renaming can help.

Thanks,
Miklos

