Return-Path: <stable+bounces-179720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0DB597A7
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAEE1883C63
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B8430C365;
	Tue, 16 Sep 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpzVsbJn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032B21B918
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029390; cv=none; b=ZWTXQAyuKYdwBubkum096YtGBaGTNOdd84556oIvcegrYiehTmg7GyjiVzryRxIm9vwLXJv9nSSyWdtUHrcvglEHeMzrsXcyepZHKXpE88xzQVmRrxkSrrO1JHFmuL6OlLHRFd2nlkhdmWyZTe7ESfgsjNTTX3SFBSXMqChm3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029390; c=relaxed/simple;
	bh=/dlRa3fJmDKHfHaLN7gvlMCOjbtBNW/Z1+IbKo1HKVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op00WmZYdUWgl5pxXhemTragN4eWFfZ/k0G4+7e/bEzLIrEx92Kjz0yb6a4ESYUVeZ+gUl9qgZsDgUdyPB1JtM2PLS1xZpDIBC/BGyL7ffv5pKkSVBGRhr+I2XAoQTxFvRx4jzh228XO3QXcydfKVFBSyFIpW+736dbMBO7FbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpzVsbJn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso6218768a12.1
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758029387; x=1758634187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nUBl38KozCd2EM6dPQpNsN7WfMcH/uyK4YoPI5ee8s=;
        b=YpzVsbJnoFX/l+brAgnsXam5Tq79FkQm5NERsg2M3IMIz1h5/8wmAlaHgwd7M88rN8
         I3al5vkyhDoy4R8wnOfNTyUDjt54ABRBWy3znkYemO0ClP8TSo2B3UMbcFC28Z5W26a7
         xNsha9PDLH19lqhbbMV7R7cRVWTSJ5pjR9TN6KlRymBQh/GCUEqgrbD3DXpJTbJdmVOU
         ZRIeoixcXZ+NkL656p8AB4BJPJjxGLvDifEKq5ZEHLM4fCBSBlDWIKUEu0iIiuPtcUGl
         O2XAdmERgavlDO92bx9XqAnPn6pHZItVz1rnvRoHhNe4bqZ1tBZIUbgsTxbiIqz8kO5l
         d3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029387; x=1758634187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nUBl38KozCd2EM6dPQpNsN7WfMcH/uyK4YoPI5ee8s=;
        b=jFL9TSjQCHiZPXe74jjmAEvTUHwhIwK35rbQA1EkKovczqrD4WI/zKvlXbQarHaNnr
         ju0HIqAdLZX0ZSXGmEtqusI11n8Yuraf/kQac4m2/0xtGIiL1WeGCDvQ3/Cr3ARN8bfK
         3RZ2Gq3/MtP52kssN9FH56YjcZsfmvZl1ArmU2QDUHOyVlWyzKriULLBQn6J1RMJ9Gyc
         mAr53vCW28jnPmfIwTA43XCJC8nFJavQfmUghq074Y9r/E2iYE9xIvJiX8IVhdRUDRtL
         JnBD/TQvmfyrmUAY8kP0AfMhHa67blY4IM5hM5urGsG8I0aesnFfihEBtkticj8d/5de
         AJHA==
X-Forwarded-Encrypted: i=1; AJvYcCX5YTCtH5Oa4Vn6PP4ed7ZtLR1tlrxRxWipLK+CeT+rIHXyzLO1/oe2uag93HkC/4XwNOvsl6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKHpyVwKKIUAnJRylRwANQU1E6Vm4Au+unCJyWr9yKqRqmTsJ
	1e6LHTU/tghxYq9ZBYtFEjY4VwNoJhKl2EarIMmj2UowXZ/z3wyDnnMACkl4J2HBNsCJGKtDgzC
	U6ldZCN809n5+/hSXbC1LUSt65v7E8Gs=
X-Gm-Gg: ASbGncsWMNCbBqU4oRyGIcigf79gdFI44L5N0/lIlWHrsP9kWpJbV1CZkLoVneSo/98
	vb45ejafzWVV5h3SGP+KUhe4+tXstHHVPeXAOyjoWyN6gj0tJL1FlGSvdOpmenIE1lE4v7A0KcE
	al1YMuVg1pjo22XUgtpBEIrT36t1vblT58B/qofZjR0cNdgXhBhfd5Bez3x/wKQHbHRhGNQk2rt
	MCfy4H15BRnku9ojNwnTzi48Wg7F/DrJKkRTD0TRLGWsbwnUfM=
X-Google-Smtp-Source: AGHT+IFx9yd4PB/vn4IjXsoACWwoeCb/LEf5nz0y3KpLeNZ2RitKABUZYjPvumidUpl8exgSkmnuKsZ7bjrh8cCbDhE=
X-Received: by 2002:a05:6402:a0cd:b0:629:54af:4f53 with SMTP id
 4fb4d7f45d1cf-62ed82c6656mr16233534a12.18.1758029386970; Tue, 16 Sep 2025
 06:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915101510.7994-1-acsjakub@amazon.de> <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
 <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
 <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com> <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
In-Reply-To: <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Sep 2025 15:29:35 +0200
X-Gm-Features: AS18NWAPAV01WXyNb64OPEzkKEyOkzIVEVp3wm-eCN6oWp1E8_sj0VUWGpMMb0M
Message-ID: <CAOQ4uxhOMcaVupVVGXV2Srz_pAG+BzDc9Gb4hFdwKUtk45QypQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
To: Jan Kara <jack@suse.cz>
Cc: Jakub Acs <acsjakub@amazon.de>, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:30=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 15-09-25 17:29:40, Amir Goldstein wrote:
> > On Mon, Sep 15, 2025 at 4:07=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > > > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > > > > index 83f80fdb1567..424c73188e06 100644
> > > > > --- a/fs/overlayfs/export.c
> > > > > +++ b/fs/overlayfs/export.c
> > > > > @@ -195,6 +195,8 @@ static int ovl_check_encode_origin(struct ino=
de *inode)
> > > > >         if (!ovl_inode_lower(inode))
> > > > >                 return 0;
> > > > >
> > > > > +       if (!inode->i_sb->s_root)
> > > > > +               return -ENOENT;
> > > >
> > > > For a filesystem method to have to check that its own root is still=
 alive sounds
> > > > like the wrong way to me.
> > > > That's one of the things that should be taken for granted by fs cod=
e.
> > > >
> > > > I don't think this is an overlayfs specific issue, because other fs=
 would be
> > > > happy if encode_fh() would be called with NULL sb->s_root.
> > >
> > > Actually, I don't see where that would blow up? Generally references =
to
> > > sb->s_root in filesystems outside of mount / remount code are pretty =
rare.
> > > Also most of the code should be unreachable by the time we set sb->s_=
root
> > > to NULL because there are no open files at that moment, no exports et=
c. But
> > > as this report shows, there are occasional surprises (I remember simi=
lar
> > > issue with ext4 sysfs files handlers using s_root without checking co=
uple
> > > years back).
> > >
> >
> > I am not sure that I understand what you are arguing for.
> > I did a very naive grep s_root fs/*/export.c and quickly found:
>
> You're better with grep than me ;). I was grepping for '->s_root' as well
> but all the hits I had looked into were related to mounting and similar a=
nd
> eventually I got bored. Restricting the grep to export ops indeed shows
> ceph, gfs2 and overlayfs are vulnerable to this kind of problem.
>
> > static int gfs2_encode_fh(struct inode *inode, __u32 *p, int *len,
> >                           struct inode *parent)
> > {
> > ...
> >         if (!parent || inode =3D=3D d_inode(sb->s_root))
> >                 return *len;
> >
> > So it's not an overlayfs specific issue, just so happens that zysbot
> > likes to test overlayfs.
> >
> > Are you suggesting that we fix all of those one by one?
>
> No. I agree we need to figure out a way to make sure export ops are not
> called on a filesystem being unmounted. Standard open_by_handle() or NFS
> export cannot race with generic_shutdown_super() (they hold the fs mounte=
d)
> so fsnotify is a special case here.
>
> I actually wonder if fanotify event (e.g. from inode deletion postponed t=
o
> some workqueue or whatever) cannot race with umount as well and cause the
> same problem...
>

Oy. I was thinking that all event happen when holding some mnt ref
but yeh fsnotify_inoderemove() does look like it could be a problem
from sb shutdown context.

How about skipping fsnotify_inoderemove() in case sb is in shutdown?

> > > > Can we change the order of generic_shutdown_super() so that
> > > > fsnotify_sb_delete(sb) is called before setting s_root to NULL?
> > > >
> > > > Or is there a better solution for this race?
> > >
> > > Regarding calling fsnotify_sb_delete() before setting s_root to NULL:
> > > In 2019 (commit 1edc8eb2e9313 ("fs: call fsnotify_sb_delete after
> > > evict_inodes")) we've moved the call after evict_inodes() because oth=
erwise
> > > we were just wasting cycles scanning many inodes without watches. So =
moving
> > > it earlier wouldn't be great...
> >
> > Yes, I noticed that and I figured there were subtleties.
>
> Right. After thinking more about it I think calling fsnotify_sb_delete()
> earlier is the only practical choice we have (not clearing sb->s_root isn=
't
> much of an option - we need to prune all dentries to quiesce the filesyst=
em
> and leaving s_root alive would create odd corner cases). But you don't wa=
nt
> to be iterating millions of inodes just to clear couple of marks so we'll
> have to figure out something more clever there.

I think we only need to suppress the fsnotify_inoderemove() call.
It sounds doable and very local to fs/super.c.

Regarding show_mark_fhandle() WDYT about my suggestion to
guard it with super_trylock_shared()?

Thanks,
Amir.

