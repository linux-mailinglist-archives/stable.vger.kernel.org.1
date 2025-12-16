Return-Path: <stable+bounces-201142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B2CC13DB
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1351C300E7B3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9BE33C198;
	Tue, 16 Dec 2025 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSKdUGNX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6233B943
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868872; cv=none; b=fiI4gfTRTkPqT57zdZTokZfcjv/7MAGq3J4xcmqaYAZl3xn8t8jzvAf+EkMo3EnzEPau8ciSOU37kfhSuQPJJfMfTWV8VZ16xgfTQI338nQefbPXyYF4vbLyusKMJ0LTgbXCMA5F3x36WrWUbNOD0I101Mhridn2dNuCk99WUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868872; c=relaxed/simple;
	bh=Q+mk+mouamuEEyAnhc0mw3Y5KbvTWFbsXdDe8Twl2c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6+wTZ4bzPalfUbY8dsIpFnyaFHHONk5YRqG0INZmesjl4pCgZp2nBm9D1jGpfVEItV8YDXdcYWOv279F/lYbWkR2/YjopfP3ilI56dpEJX/agP6uDtZesmPhecRRKC39MEhgab5KRgdP6fd8atesY6XK+jVtr/9VF0p3fzmbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSKdUGNX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee2014c228so31105421cf.2
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 23:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765868866; x=1766473666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HScJKo2ZJ/IGih9vrcGVoqKVZ2gLkTQ4915YFT77Pi0=;
        b=OSKdUGNXAdzu840N2QlvAlm6z41pJw/DU//qy6PaCZ+QEqqAuMi4pxHAQHqUzBhWGD
         owy1KcS/S4sN6vCjYIdD6XUUgoJ10BN36mI5jcINDDHSYelvD5gBujOYQyUgqFu/yGdD
         4XGxyLMN9FhYSkR8vao4kIYWcfwUUBPIyH/pN1jR3GS5lx85a88u0ddVESKm+nL1X46+
         0x6rGfoQoY67LohkfFQRYf6CTke/6XX2n5llb+BjzvmQmxhHPRGE/MFV4UX/8BB0aX9/
         2J6s4eyorxatkGHEOrgvj5nSHToQIRejjZ0Mo5iL57AbccD7xNLcm7kmOaQUNQP/VSdY
         Q4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765868866; x=1766473666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HScJKo2ZJ/IGih9vrcGVoqKVZ2gLkTQ4915YFT77Pi0=;
        b=ombtqlTH1UsPd9dAtF97LUfSfgdvuzolKfBxkhP6xmlt0iaDZ2zskQxygy0A/ksbrL
         TAoVyEIWsRx+zWufjc7kWvU/jE0mqSOqO3TRFu+SgFpYyrRKNoN7fBaWEjPunDkz8A/L
         FdqzIuy1MmYP0e/UOLhxiX2yVzUxtJ5nxkrcvcGWBXJ21snHbWqcpspambsoVAUpatpN
         YrFJ3RmpLu80QTi/IWeQ7x2MT8Aq1F76DVuhNhwlZPEslrJT04245Y1h1ZSd8jPi64LE
         dzVvDQ2IrTtXan2DXZEoNZRoLJsNXA8x9HKnXwjvZXASuAU8c6P5MCVX+Bmv4QFEkXY3
         ugyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj04GSVebvbdSuNHhIGisayQhGwuxt5edOHqBpuV2SutwBFEBqqwNdt3Rke12eEu80JA7ZJbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8F28h/RUO+xARLz+f5OpSp83iHpT+dbYKNOPiWpkvtJ2HPHV
	qlRHSlZ1YRd3soiRuQusWDz+DT8EMXk4thQU+AIE5c2e9DvnOIVeQPyGXptWhjXRNMiHzYHUr59
	o7+okws+0fnRbBv842iKq9zTEcfp+dLY=
X-Gm-Gg: AY/fxX7b+k7yMPVtin8x74mgnCU4cKhFP36Qo3i4h9t5e0nDJbo3CeXm9s8PE2x2tZP
	jaUjo0OyEXPWx5FikY//30d0OX3P2uPuFisoHX16wxNcKNMFURV/zTdl16oqeWRrezLQRAUFqSM
	Fgw5c2+2prSWonEPQy2Xyp6QBNlhtmiB/Ne+YhG/Bl6+uIo+sCzuhx2z2Fa+DhW0L7tum4QGhH5
	KFufhMcnukQZRhDnhiXdpb/lJ/lEO5moQHeF45TQcdxx6U/tyZ6U/Edf5Gblo/8tyCSeOZAiKVV
	yDWS9Cd0wZE=
X-Google-Smtp-Source: AGHT+IHdFbcCr8rDYHyI9PjajR/t+4eN/PBNmV7BmRo8+mJOOy3yb1aGTT+f0yRNO2U2a9JTAylP005Pr7cTKtFcS5w=
X-Received: by 2002:a05:622a:4889:b0:4f0:5dd:c963 with SMTP id
 d75a77b69052e-4f1d04715femr185534361cf.7.1765868865896; Mon, 15 Dec 2025
 23:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <2410c88d-380a-4aef-898e-857307a57959@bsbernd.com>
In-Reply-To: <2410c88d-380a-4aef-898e-857307a57959@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Dec 2025 15:07:34 +0800
X-Gm-Features: AQt7F2qpFeQSv5QD2stCOPk1MGDu8zClAXpXqMgzVuI8pDG-5lp3de5bo6jqHcY
Message-ID: <CAJnrk1Z9gddx9F1oSbq9bWfFefURCqoAg3SDmT2Wqrnb1bwrwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: Bernd Schubert <bernd@bsbernd.com>
Cc: akpm@linux-foundation.org, david@redhat.com, miklos@szeredi.hu, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:09=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 12/15/25 04:00, Joanne Koong wrote:
> > Skip waiting on writeback for inodes that belong to mappings that do no=
t
> > have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> > mapping flag).
> >
> > This restores fuse back to prior behavior where syncs are no-ops. This
> > is needed because otherwise, if a system is running a faulty fuse
> > server that does not reply to issued write requests, this will cause
> > wait_sb_inodes() to wait forever.
> >
> > Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and interna=
l rb tree")
> > Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> > Reported-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >   fs/fs-writeback.c       |  3 ++-
> >   fs/fuse/file.c          |  4 +++-
> >   include/linux/pagemap.h | 11 +++++++++++
> >   3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 6800886c4d10..ab2e279ed3c2 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb=
)
> >                * do not have the mapping lock. Skip it here, wb complet=
ion
> >                * will remove it.
> >                */
> > -             if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> > +             if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> > +                 mapping_no_data_integrity(mapping))
> >                       continue;
> >
> >               spin_unlock_irq(&sb->s_inode_wblist_lock);
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 01bc894e9c2b..3b2a171e652f 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, u=
nsigned int flags)
> >
> >       inode->i_fop =3D &fuse_file_operations;
> >       inode->i_data.a_ops =3D &fuse_file_aops;
> > -     if (fc->writeback_cache)
> > +     if (fc->writeback_cache) {
> >               mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_d=
ata);
> > +             mapping_set_no_data_integrity(&inode->i_data);
> > +     }
>
> For a future commit, maybe we could add a FUSE_INIT flag that allows priv=
ileged
> fuse server to not set this? Maybe even in combination with an enforced r=
equest
> timeout?

That sounds good, thanks for reviewing this, Bernd!

>
> >
> >       INIT_LIST_HEAD(&fi->write_files);
> >       INIT_LIST_HEAD(&fi->queued_writes);
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 31a848485ad9..ec442af3f886 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -210,6 +210,7 @@ enum mapping_flags {
> >       AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
> >       AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that =
shouldn't
> >                                  account usage to user cgroups */
> > +     AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
> >       /* Bits 16-25 are used for FOLIO_ORDER */
> >       AS_FOLIO_ORDER_BITS =3D 5,
> >       AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_=
on_reclaim(const struct addres
> >       return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->f=
lags);
> >   }
> >
> > +static inline void mapping_set_no_data_integrity(struct address_space =
*mapping)
> > +{
> > +     set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> > +}
> > +
> > +static inline bool mapping_no_data_integrity(const struct address_spac=
e *mapping)
> > +{
> > +     return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> > +}
> > +
> >   static inline gfp_t mapping_gfp_mask(const struct address_space *mapp=
ing)
> >   {
> >       return mapping->gfp_mask;
>
>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

