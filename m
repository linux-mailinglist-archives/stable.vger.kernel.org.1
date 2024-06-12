Return-Path: <stable+bounces-50300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14AF9057BD
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6852891B6
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24B180A8D;
	Wed, 12 Jun 2024 15:56:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48104180A77;
	Wed, 12 Jun 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207775; cv=none; b=VuUS9wcx3J8w96OcLUzfcGIY70dJjhXPyiJTbzGR8wxEyqxWb2/z34gSSkQjB6Qc7vftjB0mhTTmoHocuhb7yIt6tzz7MgkPvv295R8I0ZZ0sPV/jdfeuoNuSIrLdZ4IkVkPKIGD8BkRfYSXUz4allQCNTenqmeLhYKUya47le8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207775; c=relaxed/simple;
	bh=hEp61NZconNU+jnxkwQl1pyt2D631XSmXBr+s2MhVg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZa3QCsJC5D8ZF1RkofJzHqU+VFGmt2WW9IEvny2sIsMJFI4k3eKTtq2hzB9lI/HsKtoySVRroVjl+XXQ3KP2OgUk1S+XbLmhI2yBeMD6H4VBzpgFwFJBIuRK52x4CGK523OM9G2ZFkXLTOd0SON/MD1W1ExLY34VqGRjp6Dg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DF2C116B1;
	Wed, 12 Jun 2024 15:56:13 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:56:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Ilkka
 =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240612115612.2e5f4b34@rorschach.local.home>
In-Reply-To: <ceb24cb7-dbb0-48b0-9de2-9557f3e310b5@leemhuis.info>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
	<20240527183139.42b6123c@rorschach.local.home>
	<CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
	<20240528144743.149e351b@rorschach.local.home>
	<CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
	<20240529144757.79d09eeb@rorschach.local.home>
	<20240529154824.2db8133a@rorschach.local.home>
	<CAE4VaRGRwsp+KuEWtsUCxjEtgv1FO+_Ey1-A9xr-o+chaUeteg@mail.gmail.com>
	<20240530095953.0020dff9@rorschach.local.home>
	<CAE4VaRGYoa_CAtttifVzmkdm4vW05WtoCwOrcH7=rSUVeD6n5g@mail.gmail.com>
	<ceb24cb7-dbb0-48b0-9de2-9557f3e310b5@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 15:36:22 +0200
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>=
 wrote:

> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>=20
> Ilkka or Steven, what happened to this? This thread looks stalled. I
> also was unsuccessful when looking for other threads related to this
> report or the culprit. Did it fall through the cracks or am I missing
> something here?

Honesty, I have no idea where the bug is. I can't reproduce it. These
patches I sent would check all the places that add to the list to make
sure the proper trace_inode was being added, and the output shows that
they are all correct. Then suddenly, something that came from the
inode cache is calling the tracefs inode cache to free it, and that's
where the bug is happening.

This really looks like another bug that the recent changes have made
more predominate.

-- Steve


>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20
> #regzbot poke
>=20
> On 02.06.24 09:32, Ilkka Naulap=C3=A4=C3=A4 wrote:
> > sorry longer delay, been a bit busy but here is the result from that
> > new patch. Only applied this patch so if the previous one is needed
> > also, let me know and I'll rerun it.
> >=20
> > --Ilkka
> >=20
> > On Thu, May 30, 2024 at 5:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote: =20
> >>
> >> On Thu, 30 May 2024 16:02:37 +0300
> >> Ilkka Naulap=C3=A4=C3=A4 <digirigawa@gmail.com> wrote:
> >> =20
> >>> applied your patch and here's the output.
> >>> =20
> >>
> >> Unfortunately, it doesn't give me any new information. I added one more
> >> BUG on, want to try this? Otherwise, I'm pretty much at a lost. :-/
> >>
> >> -- Steve
> >>
> >> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> >> index de5b72216b1a..a090495e78c9 100644
> >> --- a/fs/tracefs/inode.c
> >> +++ b/fs/tracefs/inode.c
> >> @@ -39,13 +39,17 @@ static struct inode *tracefs_alloc_inode(struct su=
per_block *sb)
> >>                 return NULL;
> >>
> >>         ti->flags =3D 0;
> >> +       ti->magic =3D 20240823;
> >>
> >>         return &ti->vfs_inode;
> >>  }
> >>
> >>  static void tracefs_free_inode(struct inode *inode)
> >>  {
> >> -       kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
> >> +       struct tracefs_inode *ti =3D get_tracefs(inode);
> >> +
> >> +       BUG_ON(ti->magic !=3D 20240823);
> >> +       kmem_cache_free(tracefs_inode_cachep, ti);
> >>  }
> >>
> >>  static ssize_t default_read_file(struct file *file, char __user *buf,
> >> @@ -147,16 +151,6 @@ static const struct inode_operations tracefs_dir_=
inode_operations =3D {
> >>         .rmdir          =3D tracefs_syscall_rmdir,
> >>  };
> >>
> >> -struct inode *tracefs_get_inode(struct super_block *sb)
> >> -{
> >> -       struct inode *inode =3D new_inode(sb);
> >> -       if (inode) {
> >> -               inode->i_ino =3D get_next_ino();
> >> -               inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_=
current(inode);
> >> -       }
> >> -       return inode;
> >> -}
> >> -
> >>  struct tracefs_mount_opts {
> >>         kuid_t uid;
> >>         kgid_t gid;
> >> @@ -384,6 +378,7 @@ static void tracefs_dentry_iput(struct dentry *den=
try, struct inode *inode)
> >>                 return;
> >>
> >>         ti =3D get_tracefs(inode);
> >> +       BUG_ON(ti->magic !=3D 20240823);
> >>         if (ti && ti->flags & TRACEFS_EVENT_INODE)
> >>                 eventfs_set_ef_status_free(dentry);
> >>         iput(inode);
> >> @@ -568,6 +563,18 @@ struct dentry *eventfs_end_creating(struct dentry=
 *dentry)
> >>         return dentry;
> >>  }
> >>
> >> +struct inode *tracefs_get_inode(struct super_block *sb)
> >> +{
> >> +       struct inode *inode =3D new_inode(sb);
> >> +
> >> +       BUG_ON(sb->s_op !=3D &tracefs_super_operations);
> >> +       if (inode) {
> >> +               inode->i_ino =3D get_next_ino();
> >> +               inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_=
current(inode);
> >> +       }
> >> +       return inode;
> >> +}
> >> +
> >>  /**
> >>   * tracefs_create_file - create a file in the tracefs filesystem
> >>   * @name: a pointer to a string containing the name of the file to cr=
eate.
> >> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> >> index 69c2b1d87c46..9059b8b11bb6 100644
> >> --- a/fs/tracefs/internal.h
> >> +++ b/fs/tracefs/internal.h
> >> @@ -9,12 +9,15 @@ enum {
> >>  struct tracefs_inode {
> >>         unsigned long           flags;
> >>         void                    *private;
> >> +       unsigned long           magic;
> >>         struct inode            vfs_inode;
> >>  };
> >>
> >>  static inline struct tracefs_inode *get_tracefs(const struct inode *i=
node)
> >>  {
> >> -       return container_of(inode, struct tracefs_inode, vfs_inode);
> >> +       struct tracefs_inode *ti =3D container_of(inode, struct tracef=
s_inode, vfs_inode);
> >> +       BUG_ON(ti->magic !=3D 20240823);
> >> +       return ti;
> >>  }
> >>
> >>  struct dentry *tracefs_start_creating(const char *name, struct dentry=
 *parent); =20


