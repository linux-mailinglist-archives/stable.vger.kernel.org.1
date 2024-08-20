Return-Path: <stable+bounces-69724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8049D9589EB
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356B21F23B91
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82656193090;
	Tue, 20 Aug 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDPFOc9A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8A719308E
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164711; cv=none; b=jVDoKh73QlC9R+rSNzpqyLDRxUYxz39cyGgnd+thGfk0fzxl23k+vMNKHxeT94hAt8/QdvmSAi45dUZNTtbQlEprRGKMAsJOYFxvAGxdSiWxte91YsA9KWSKXxJdLi9jMz8lo5473c5kW+w/t791bYkwUQ4w1FaciwyVPxIUDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164711; c=relaxed/simple;
	bh=ih/n8CrewKI6D1+9ualLUR3DuDWkOzuYv5KaIh7VetU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjrf4A3GQdsPU92c5mv6X75+4q/wekGNlF6zE9KB39cLdAEpfJRoyUYIorWN/SFSwclpbgCCE05lL9iA3r7YybkX2bGgdiLs7ZxcaWbB45Wc4D+GmrtWbyhwfrbUq7sd/5w/Vhe6ddkrVSeYYKx+r7/VrSh++Nk4tG/BoB7BD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDPFOc9A; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bec4e00978so4781804a12.0
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164708; x=1724769508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlKyZcerJI/b+5rW9w5YGY77JDxGB+71LgW6P71rn+M=;
        b=jDPFOc9AyV9aOcfQbmqMPm4RKqAceEbMJjzSrxtzmOCYI9S/a1yB1Z/c0MGVLIYuAr
         ADIC2C1SMVwletu1vlUYsp3elRRev+rsROfJQRTyQiHF2caDOjQ6eThXdq3LEYDqUwy1
         mo0vlfpG6UtH0SvSFksyGq9dhI+eMwqA2rQOmtUxbkmKG0QjkAi53YBDoKV9Ul72FiPt
         PE/zrwE62CJ0C7jI0JgBEGRN4254S2+Bd3zsbO/fynoiGH4x4/yDAwAkID9BVtVRNM/N
         jJ2YATUg0Tfyyb2/s2RqtCPAjPlXh1FNrOX3ZLP43u7veYcO1rI7NImt8DuLYdio/pNg
         iQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164708; x=1724769508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlKyZcerJI/b+5rW9w5YGY77JDxGB+71LgW6P71rn+M=;
        b=MO97mOdy0VnwP92mFnsHs5ST4v0qxjTqhxs/dyjaiW/QiG/1B9HwAmALr7V1qGl5Ua
         anlOFRW6EXV5i1C+26aIAygTONb4AbIcwX2pWOt8FC/B6NjLx0C0TIi4TndbCrNx2VPL
         yV8rfl6aJ7xnmKAJ6zz2JIZF56kU4ldKUjPQ+sUF8+Ec3NAVaPT5cNfo4qivfYoS+K+o
         8N1utJ1bTDQdIpqoY5CHAzrP2Fp9/s7eM4aKwz+tk8zYqSOxL0yoFlbbgERgcaXoGYeM
         /+4UWBNIQQYawGkkmrunQ2CRQp11zAax1vlDRaBqb2whL6bv4xAidHPGAppJLNhdU0tE
         ypyg==
X-Forwarded-Encrypted: i=1; AJvYcCWpR83bKsfPflwuFGbsd21/x3uxBsT3bihWICsLsLp2QLkCOT+Oiz4iF+yHZzsAeLFRUn17ycs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1As+In+TS7dtDrKyKkxaWtK0AzYEC4+1trfGevS5PmhPXU7q
	9EZs6sdauljnyL9CyQ4xgFtsPRCU6MoF90+jxLJa9noBTJBmtUddaalAo215ZLUvVeP3ujxyOKl
	6bN4bqTYlS5OXMy9xnbGnyUWjlzw=
X-Google-Smtp-Source: AGHT+IE/Q/pID2ImU9RPleC5mWD1P480kdwVLhC0s8JHB9DkygTJCsuzHRZVusRgrZlKdW5KHj8OvpykW/N/5BC9NSk=
X-Received: by 2002:a05:6402:27cd:b0:5be:d5a8:e0e with SMTP id
 4fb4d7f45d1cf-5bf0d2d2ab5mr1738851a12.37.1724164707363; Tue, 20 Aug 2024
 07:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820033148.29662-1-sunjunchao2870@gmail.com> <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
In-Reply-To: <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 20 Aug 2024 22:38:15 +0800
Message-ID: <CAHB1Nagi560YvT_9LKevFGh-yvDxDTtTd04eskQ74OgcOamAeA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix double destroy_workqueue error
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, 
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=882=
0=E6=97=A5=E5=91=A8=E4=BA=8C 22:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, Aug 20, 2024 at 5:32=E2=80=AFAM Julian Sun <sunjunchao2870@gmail.=
com> wrote:
> > When gfs2_fill_super() fails, destroy_workqueue()
> > is called within gfs2_gl_hash_clear(), and the
> > subsequent code path calls destroy_workqueue()
> > on the same work queue again.
> >
> > This issue can be fixed by setting the work
> > queue pointer to NULL after the first
> > destroy_workqueue() call and checking for
> > a NULL pointer before attempting to destroy
> > the work queue again.
> >
> > Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd34c2a269ed512c531b0
> > Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/gfs2/glock.c      | 1 +
> >  fs/gfs2/ops_fstype.c | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > index 12a769077ea0..4775c2cb8ae1 100644
> > --- a/fs/gfs2/glock.c
> > +++ b/fs/gfs2/glock.c
> > @@ -2249,6 +2249,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
> >         gfs2_free_dead_glocks(sdp);
> >         glock_hash_walk(dump_glock_func, sdp);
> >         destroy_workqueue(sdp->sd_glock_wq);
> > +       sdp->sd_glock_wq =3D NULL;
>
> Here, sdp->sd_glock_wq is set to NULL,
>
> >  }
> >
> >  static const char *state2str(unsigned state)
> > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > index ff1f3e3dc65c..c1a7ff713c84 100644
> > --- a/fs/gfs2/ops_fstype.c
> > +++ b/fs/gfs2/ops_fstype.c
> > @@ -1305,7 +1305,8 @@ static int gfs2_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >         gfs2_delete_debugfs_file(sdp);
> >         gfs2_sys_fs_del(sdp);
> >  fail_delete_wq:
> > -       destroy_workqueue(sdp->sd_delete_wq);
> > +       if (sdp->sd_delete_wq)
> > +               destroy_workqueue(sdp->sd_delete_wq);
>
>
> > but here, we check if sdp->sd_delete_wq is NULL? That doesn't make sens=
e.

I'm not sure if I have missed anything important. My understanding is
that in gfs2_fill_super(), if execution jumps to the fail_lm label,
gfs2_gl_hash_clear() is called first, which internally calls
destroy_workqueue(sdp->sd_glock_wq). Subsequently, the code reaches
the fail_delete_wq label, where destroy_workqueue(sdp->sd_glock_wq) is
called again, leading to a bug.
If there is anything important I'm missing, please let me know.

>
> >  fail_glock_wq:
> >         destroy_workqueue(sdp->sd_glock_wq);
> >  fail_free:
> > --
> > 2.39.2
> >
>
> Thanks,
> Andreas
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

