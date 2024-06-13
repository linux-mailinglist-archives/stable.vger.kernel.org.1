Return-Path: <stable+bounces-50404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D300E906536
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316D5B20D0D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A959D13C8EE;
	Thu, 13 Jun 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxoiJ78c"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C313D26B;
	Thu, 13 Jun 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263984; cv=none; b=evd5/AEo9Bx9Wrfqyopn1bT0vI1CnlTIBjPFpR3BPMKFa64dTWjzm9GvBSdcXpHVRZHAJjjmz58Bvjy3iPbE/Xof+xldeacv3m3KCRrV+vfafdqy+rt+L3OvdVLOBETsxTGZ6UchFA2SuKhMzMhMArGEGiu1t53HEjlcNlCWtu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263984; c=relaxed/simple;
	bh=d0mZNWDpRk6kCJv92A4sILZo41s0K1Wp0msT2BRz2HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I58bCfCjT+1AKDlJPXYweCQOpC9gKLVtrK2TxWhkH1pRCLBkLnvZrGh0kFXuOhpO4TxYspdjuZVoLfhH1BoNxRj8AVYpOoWsyOrokEBK3DUeBE5wUYtx2dEnSAYwrEEjA8qQQVQ2+nN0S5xdizJDAlVwdVTeO/5CYqQg1yMFHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxoiJ78c; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so5904341fa.2;
        Thu, 13 Jun 2024 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718263981; x=1718868781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C8KlVl3OW2PC2dRMHxIiA4eTV9+V+jwqso0xqeA27M=;
        b=FxoiJ78ccKBM32cI59ZqY0lEatSjSimSpA+ESw6cUf5FAQ7PrdwZ5CDzNvSZc/0TTE
         sl5IQ6Yv+1VL4NY1kXpVeS+wuZ6u5lMlgtp7jQbq/bPa/1Y62pqFgh96GT03I012OKOu
         HsuDH71fzE54G+0xNSHjNIkBi5KBRnavHADZAlzOZQInlQREUvAQfx5m41Vth2qROF49
         sSJktkIPfLDz3n8ecXgBhumePYi+Z9K50S1LT0qinO0Dg98WatfE1s6CBNbLyS6KGugL
         Wv663QHDF5aiFAi+WisYucRhyGpPmjdZnAmttXwmuWlFy2Tce0CChTW26S8OGX/qFLYg
         GHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263981; x=1718868781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C8KlVl3OW2PC2dRMHxIiA4eTV9+V+jwqso0xqeA27M=;
        b=OU8I3vjy6Xhhg+dd8qsekbwr5Mpt9g9kMumiAR51ZZeaUdFiN05t9NhzrhnzFsxcoc
         AgivUStZ4mu1lLSL8Dg2exUs9DgEpkP+TnmKFCQkAh2KSXR2R/pSj6C7iYCofHyW4vo9
         xpRN8BTh7yLsYmgfpSHvXlkbpp91v44CrY6EtPPNGLxCGK/jNgFLJkrxuaYF3f2T4Fgs
         9uPH13UHgy7BDMCD3QpQtM/4kis/7iB1bYF7k8QcNzeCwvXQUf0SjoJerfMZHtD+ShCv
         vmHtPT8iYoOLC1TYG1CPXtAgdXT1I+8IfAIECp1d6eLcfyPbjtFUm25xH+dmp4u0L1iA
         WNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyGbiFldt7NLOhWtVSDRrYv3/6FuVO1eofpRoxIA/Klm3IVyaw2TZBPkKGfZ5qpaDttzEBDttWIjBg1OZICOeDMpRyAWspKR2MujfvPTE9WuMZDzGfWmVHaWReTBUoGheHHX35QN3PDfeL/tu2OuKP7BhXjlQlqg6bwUatB+N0KMxiJowwXYM4
X-Gm-Message-State: AOJu0YyDL0Dri34QQ74PrIbcfidcik0pltUSRxJyr/ySpHI85epsotEQ
	100Am1djz60HHRkCrwMDqsxe9efmTU/YYiLZC05mb3EhfvEntwTGDdF9J7b07xSTRWUF5EuPa9+
	RVugJRfvMnxbPX9xqR09tjvN9Q/fx/TvA
X-Google-Smtp-Source: AGHT+IFSH1cz0gSocHoAg6tJNJ81lHTAApuUDBHX24yt9xXwpzJmO/R+w9fb+7XIYxSNcZJCRE4jhgyWvCzsdILNpcI=
X-Received: by 2002:a2e:878f:0:b0:2eb:ecba:444a with SMTP id
 38308e7fff4ca-2ebfc9fac80mr21389571fa.23.1718263980494; Thu, 13 Jun 2024
 00:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
 <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info> <20240527183139.42b6123c@rorschach.local.home>
 <CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
 <20240528144743.149e351b@rorschach.local.home> <CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
 <20240529144757.79d09eeb@rorschach.local.home> <20240529154824.2db8133a@rorschach.local.home>
 <CAE4VaRGRwsp+KuEWtsUCxjEtgv1FO+_Ey1-A9xr-o+chaUeteg@mail.gmail.com>
 <20240530095953.0020dff9@rorschach.local.home> <CAE4VaRGYoa_CAtttifVzmkdm4vW05WtoCwOrcH7=rSUVeD6n5g@mail.gmail.com>
 <ceb24cb7-dbb0-48b0-9de2-9557f3e310b5@leemhuis.info> <20240612115612.2e5f4b34@rorschach.local.home>
In-Reply-To: <20240612115612.2e5f4b34@rorschach.local.home>
From: =?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Date: Thu, 13 Jun 2024 10:32:24 +0300
Message-ID: <CAE4VaRFwdxNuUWb=S+itDLZf1rOZx9px+xoLWCi+hdUaWJwj6Q@mail.gmail.com>
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During Shutdown/Reboot
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ok, so if you don't have any idea where this bug is after those debug
patches, I'll try to find some time to bisect it as a last resort.
Stay tuned.

--Ilkka

On Wed, Jun 12, 2024 at 6:56=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 12 Jun 2024 15:36:22 +0200
> "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.inf=
o> wrote:
>
> > Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> > for once, to make this easily accessible to everyone.
> >
> > Ilkka or Steven, what happened to this? This thread looks stalled. I
> > also was unsuccessful when looking for other threads related to this
> > report or the culprit. Did it fall through the cracks or am I missing
> > something here?
>
> Honesty, I have no idea where the bug is. I can't reproduce it. These
> patches I sent would check all the places that add to the list to make
> sure the proper trace_inode was being added, and the output shows that
> they are all correct. Then suddenly, something that came from the
> inode cache is calling the tracefs inode cache to free it, and that's
> where the bug is happening.
>
> This really looks like another bug that the recent changes have made
> more predominate.
>
> -- Steve
>
>
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
> >
> > #regzbot poke
> >
> > On 02.06.24 09:32, Ilkka Naulap=C3=A4=C3=A4 wrote:
> > > sorry longer delay, been a bit busy but here is the result from that
> > > new patch. Only applied this patch so if the previous one is needed
> > > also, let me know and I'll rerun it.
> > >
> > > --Ilkka
> > >
> > > On Thu, May 30, 2024 at 5:00=E2=80=AFPM Steven Rostedt <rostedt@goodm=
is.org> wrote:
> > >>
> > >> On Thu, 30 May 2024 16:02:37 +0300
> > >> Ilkka Naulap=C3=A4=C3=A4 <digirigawa@gmail.com> wrote:
> > >>
> > >>> applied your patch and here's the output.
> > >>>
> > >>
> > >> Unfortunately, it doesn't give me any new information. I added one m=
ore
> > >> BUG on, want to try this? Otherwise, I'm pretty much at a lost. :-/
> > >>
> > >> -- Steve
> > >>
> > >> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > >> index de5b72216b1a..a090495e78c9 100644
> > >> --- a/fs/tracefs/inode.c
> > >> +++ b/fs/tracefs/inode.c
> > >> @@ -39,13 +39,17 @@ static struct inode *tracefs_alloc_inode(struct =
super_block *sb)
> > >>                 return NULL;
> > >>
> > >>         ti->flags =3D 0;
> > >> +       ti->magic =3D 20240823;
> > >>
> > >>         return &ti->vfs_inode;
> > >>  }
> > >>
> > >>  static void tracefs_free_inode(struct inode *inode)
> > >>  {
> > >> -       kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
> > >> +       struct tracefs_inode *ti =3D get_tracefs(inode);
> > >> +
> > >> +       BUG_ON(ti->magic !=3D 20240823);
> > >> +       kmem_cache_free(tracefs_inode_cachep, ti);
> > >>  }
> > >>
> > >>  static ssize_t default_read_file(struct file *file, char __user *bu=
f,
> > >> @@ -147,16 +151,6 @@ static const struct inode_operations tracefs_di=
r_inode_operations =3D {
> > >>         .rmdir          =3D tracefs_syscall_rmdir,
> > >>  };
> > >>
> > >> -struct inode *tracefs_get_inode(struct super_block *sb)
> > >> -{
> > >> -       struct inode *inode =3D new_inode(sb);
> > >> -       if (inode) {
> > >> -               inode->i_ino =3D get_next_ino();
> > >> -               inode->i_atime =3D inode->i_mtime =3D inode_set_ctim=
e_current(inode);
> > >> -       }
> > >> -       return inode;
> > >> -}
> > >> -
> > >>  struct tracefs_mount_opts {
> > >>         kuid_t uid;
> > >>         kgid_t gid;
> > >> @@ -384,6 +378,7 @@ static void tracefs_dentry_iput(struct dentry *d=
entry, struct inode *inode)
> > >>                 return;
> > >>
> > >>         ti =3D get_tracefs(inode);
> > >> +       BUG_ON(ti->magic !=3D 20240823);
> > >>         if (ti && ti->flags & TRACEFS_EVENT_INODE)
> > >>                 eventfs_set_ef_status_free(dentry);
> > >>         iput(inode);
> > >> @@ -568,6 +563,18 @@ struct dentry *eventfs_end_creating(struct dent=
ry *dentry)
> > >>         return dentry;
> > >>  }
> > >>
> > >> +struct inode *tracefs_get_inode(struct super_block *sb)
> > >> +{
> > >> +       struct inode *inode =3D new_inode(sb);
> > >> +
> > >> +       BUG_ON(sb->s_op !=3D &tracefs_super_operations);
> > >> +       if (inode) {
> > >> +               inode->i_ino =3D get_next_ino();
> > >> +               inode->i_atime =3D inode->i_mtime =3D inode_set_ctim=
e_current(inode);
> > >> +       }
> > >> +       return inode;
> > >> +}
> > >> +
> > >>  /**
> > >>   * tracefs_create_file - create a file in the tracefs filesystem
> > >>   * @name: a pointer to a string containing the name of the file to =
create.
> > >> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> > >> index 69c2b1d87c46..9059b8b11bb6 100644
> > >> --- a/fs/tracefs/internal.h
> > >> +++ b/fs/tracefs/internal.h
> > >> @@ -9,12 +9,15 @@ enum {
> > >>  struct tracefs_inode {
> > >>         unsigned long           flags;
> > >>         void                    *private;
> > >> +       unsigned long           magic;
> > >>         struct inode            vfs_inode;
> > >>  };
> > >>
> > >>  static inline struct tracefs_inode *get_tracefs(const struct inode =
*inode)
> > >>  {
> > >> -       return container_of(inode, struct tracefs_inode, vfs_inode);
> > >> +       struct tracefs_inode *ti =3D container_of(inode, struct trac=
efs_inode, vfs_inode);
> > >> +       BUG_ON(ti->magic !=3D 20240823);
> > >> +       return ti;
> > >>  }
> > >>
> > >>  struct dentry *tracefs_start_creating(const char *name, struct dent=
ry *parent);
>

