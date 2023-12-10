Return-Path: <stable+bounces-5180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1080B871
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 03:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C38280EF0
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 02:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677DF1381;
	Sun, 10 Dec 2023 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlbUBlDj"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF38115
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 18:48:15 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db539ab8e02so3622354276.0
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 18:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702176495; x=1702781295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2mUVPJBxaE7PJUm2IKFM9FS8unihPsYyF9YT+K5P0c=;
        b=ZlbUBlDjpnMTVZnCrI8+KmpleN8/vd6JmLB68pAYiAqE2VKHmaNDTBssuclJM62i2r
         Ygx1c2mB5ZNeKBhQMvBzD9dtC/ynnf8CFJikr+PCHvROfjjWuAbfpdVgTFyiETAsLUR4
         eokar2YBM9IRzeT/mz9gihCpX7J5Ctx2CvVrx/fYZ9eFZTkx4a/oZ5suuN4q0RBSSO5M
         /+h/PfHCiQUYR81+Sk8DL3cZZBP9uKSOT0OgGLF86O7KAN/mwuJDbAsNXVVuwXEERTMs
         ObApdKMY41Z0/VSdPAws6Ckw48QRFv81S/81MHVO4PP9ISJtvLcwbtpv0FdWrTYokg3N
         EO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702176495; x=1702781295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2mUVPJBxaE7PJUm2IKFM9FS8unihPsYyF9YT+K5P0c=;
        b=P5Jt2ibUemCY9uymE8T0KQBpP75BLoTagMuaGJdAZ2pnemcyNii4HpWltYrcTMF18B
         PgwId1jB2JsdAz6oVkVyEW5LTNXtgpjywR22gq4OQeqClzMg27ilWsErVEDn1P/jm5uJ
         MMumWYpB5fKnmotCFY7YGEhMVM1KsY9HchM8uXCS1rnD43oZ6ha2IUK5dX0KsWH9M9Yc
         AFrt01s8hY3o+06YxPA1eB2Ba+avzxAtV9ZLsggw0MwZww8kRdROSufnDBkkYAg+Rx7J
         qzmqWHBbUSQblIA9MOAbAq4It6BOdnzqwPISuDomRHpZVII1AtG69yuu8ZqOLDeQ23MV
         1k0g==
X-Gm-Message-State: AOJu0Yw9ZPUkiw5xied/ugLCYKIC54b53M0hVLwBr3SHtj6jRueALt5Z
	e1XvK70Nt2dAT+TAHa0Wu5obxzIEg1ieivn6cKw3CDWImkk=
X-Google-Smtp-Source: AGHT+IGUz4uuNSxSqL67ib95+QhoVKfL3pbi9EWZPQPp4kz4ngBBKcD5I4y2TydvPeMz03k9HiBsLyNluiSZ6A6jZhA=
X-Received: by 2002:a81:5b46:0:b0:5d7:545e:3bdd with SMTP id
 p67-20020a815b46000000b005d7545e3bddmr1877896ywb.3.1702176494698; Sat, 09 Dec
 2023 18:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023120911-uncouple-derail-3735@gregkh> <CAKFNMokAa1hUUL95wxCZRXzLMuOPiQ6Cu0yOrcdbKvW=zT1z0g@mail.gmail.com>
In-Reply-To: <CAKFNMokAa1hUUL95wxCZRXzLMuOPiQ6Cu0yOrcdbKvW=zT1z0g@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 10 Dec 2023 11:47:58 +0900
Message-ID: <CAKFNMonVBcZxJwnT7wYZS6eR_+PdzXHx=XV_n0zrGF3mZGSvOQ@mail.gmail.com>
Subject: Re: Patch "nilfs2: fix missing error check for sb_set_blocksize call"
 has been added to the 5.4-stable tree
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forward to the stable mailing list.

Ryusuke Konishi

On Sun, Dec 10, 2023 at 11:37=E2=80=AFAM Ryusuke Konishi  wrote:
>
> Hi Greg,
>
> Please drop this patch from the 5.4-stable, 4.19-stable, and 4.14-stable =
queues.
>
> This patch uses nilfs_error() instead of nilfs_err(), which does not
> yet exist in these versions, but these are different routines and
> nilfs_error() should not be used as an alternative for init_nilfs(),
> as it can cause deadlock.
>
> I'll try to post a separate patch to replace it for these versions.
>
> Thanks,
> Ryusuke Konishi
>
> On Sat, Dec 9, 2023 at 9:32=E2=80=AFPM wrote:
> >
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     nilfs2: fix missing error check for sb_set_blocksize call
> >
> > to the 5.4-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
> >
> > The filename of the patch is:
> >      nilfs2-fix-missing-error-check-for-sb_set_blocksize-call.patch
> > and it can be found in the queue-5.4 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree=
,
> > please let <stable@vger.kernel.org> know about it.
> >
> >
> > From d61d0ab573649789bf9eb909c89a1a193b2e3d10 Mon Sep 17 00:00:00 2001
> > From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Date: Wed, 29 Nov 2023 23:15:47 +0900
> > Subject: nilfs2: fix missing error check for sb_set_blocksize call
> >
> > From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> >
> > commit d61d0ab573649789bf9eb909c89a1a193b2e3d10 upstream.
> >
> > When mounting a filesystem image with a block size larger than the page
> > size, nilfs2 repeatedly outputs long error messages with stack traces t=
o
> > the kernel log, such as the following:
> >
> >  getblk(): invalid block size 8192 requested
> >  logical block size: 512
> >  ...
> >  Call Trace:
> >   dump_stack_lvl+0x92/0xd4
> >   dump_stack+0xd/0x10
> >   bdev_getblk+0x33a/0x354
> >   __breadahead+0x11/0x80
> >   nilfs_search_super_root+0xe2/0x704 [nilfs2]
> >   load_nilfs+0x72/0x504 [nilfs2]
> >   nilfs_mount+0x30f/0x518 [nilfs2]
> >   legacy_get_tree+0x1b/0x40
> >   vfs_get_tree+0x18/0xc4
> >   path_mount+0x786/0xa88
> >   __ia32_sys_mount+0x147/0x1a8
> >   __do_fast_syscall_32+0x56/0xc8
> >   do_fast_syscall_32+0x29/0x58
> >   do_SYSENTER_32+0x15/0x18
> >   entry_SYSENTER_32+0x98/0xf1
> >  ...
> >
> > This overloads the system logger.  And to make matters worse, it someti=
mes
> > crashes the kernel with a memory access violation.
> >
> > This is because the return value of the sb_set_blocksize() call, which
> > should be checked for errors, is not checked.
> >
> > The latter issue is due to out-of-buffer memory being accessed based on=
 a
> > large block size that caused sb_set_blocksize() to fail for buffers rea=
d
> > with the initial minimum block size that remained unupdated in the
> > super_block structure.
> >
> > Since nilfs2 mkfs tool does not accept block sizes larger than the syst=
em
> > page size, this has been overlooked.  However, it is possible to create
> > this situation by intentionally modifying the tool or by passing a
> > filesystem image created on a system with a large page size to a system
> > with a smaller page size and mounting it.
> >
> > Fix this issue by inserting the expected error handling for the call to
> > sb_set_blocksize().
> >
> > Link: https://lkml.kernel.org/r/20231129141547.4726-1-konishi.ryusuke@g=
mail.com
> > Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  fs/nilfs2/the_nilfs.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > --- a/fs/nilfs2/the_nilfs.c
> > +++ b/fs/nilfs2/the_nilfs.c
> > @@ -688,7 +688,11 @@ int init_nilfs(struct the_nilfs *nilfs,
> >                         goto failed_sbh;
> >                 }
> >                 nilfs_release_super_block(nilfs);
> > -               sb_set_blocksize(sb, blocksize);
> > +               if (!sb_set_blocksize(sb, blocksize)) {
> > +                       nilfs_error(sb, "bad blocksize %d", blocksize);
> > +                       err =3D -EINVAL;
> > +                       goto out;
> > +               }
> >
> >                 err =3D nilfs_load_super_block(nilfs, sb, blocksize, &s=
bp);
> >                 if (err)
> >
> >
> > Patches currently in stable-queue which might be from konishi.ryusuke@g=
mail.com are
> >
> > queue-5.4/nilfs2-prevent-warning-in-nilfs_sufile_set_segment_usage.patc=
h
> > queue-5.4/nilfs2-fix-missing-error-check-for-sb_set_blocksize-call.patc=
h

