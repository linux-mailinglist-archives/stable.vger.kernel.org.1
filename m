Return-Path: <stable+bounces-69725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5859589FD
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5119E1F23A72
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66119885D;
	Tue, 20 Aug 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIsh6rMp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF441198A0F
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164899; cv=none; b=eqHBQmG+1R8xnYfeIfcwx+xKgKVoGrlSEJy8rBsx/M1lCyBD7dg48HFsQM6W5G9fmTGSLoarEU7u0PshccLCdM9EK+emTnAu87qEW0M8okrCt5sAQhI6eCGtsVo+lxSC71Whpn2FFK7nTj21oTy523I9zP7FDdbaHtRTWIizo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164899; c=relaxed/simple;
	bh=ol+KLWbA2n+RZgCVOjQA6F0ZFiUQopgZSe8GIuN2fzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqo8p1iGT28EdnEBQQwDbfjYAmS1ufEu2533/vKkZWi6z6vHfgAEZeOIA+PGAXV6giFyM2N5zsgsUozvV/0df0LuH3aNL9Ww5T7PTyPwLtT4J4A9fddlyBy+ckNFXIcjdOzRSQLX+XBK6kDjd1it0roFgOkewUEd+WuIjGiuI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIsh6rMp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3ce5bc7d2so34883591fa.0
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164896; x=1724769696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COJqsdsUimC40QurmxvQ2PDteURpDZpJHvtTTyWWXds=;
        b=fIsh6rMpcKG8QLx0M9lT8zGCZtWMMiLMW89TCVyd29DlkrUF56g/hH4RlNLPzUvgcz
         A4oqskR7d6V/pvczqz/xE3lI/9xVLFO1oC2nKD62EtdEmG4w+tF7FHlevydGONnCWA14
         hks1onKVSJXHLFgrpO8ofjV36Vw9M5WHjVkvo1UREzmcdh5NhLP5l+3eV5/+YE8mv7vu
         mknbx0LNDwyHrNPSWO/1VhrZlljUF+gDayA1Q82zTfXKzdngN3a8pvuBL6E5OaHj8b5E
         y7nD2dNpYXYfH4fGlJ37bCUPYjfvsk+oSh5sPNIUXWsB9gllsCT1U1ShjlNJlMBfBaOn
         xZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164896; x=1724769696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COJqsdsUimC40QurmxvQ2PDteURpDZpJHvtTTyWWXds=;
        b=watjVJ1gTlraemlsQsKpFo/vLkdydv02DLci6azr12txkO+Ka9hJT6mv6BkvtTBykU
         PgEVvgh8EvewKB2VPQGjt/ZlPvOcBCP82oZsMmysoHt5j1C/Oc5CBEZSoiyvBqZrB/zm
         /tH0rNEicyI+HgFcCyf1gsuhfm2QA6L2irPYG4s2p8P5hwgaJ2KWKAyLQcN8oCM86aml
         MrQZwb0FRm/nz4e0PqiwXKRhPtsie5B5aOMN2RIR5XoBeSxgtG6jaChUvZKVOayP04+m
         ZvHXH+OkxTlby7hjdC2MeELcSthyuxfJCOcof13Sx594W+LCEweNXU+QkiY9GxfCnl+M
         Azow==
X-Forwarded-Encrypted: i=1; AJvYcCURqDEUXNeQtFXCLZGnrp0m9uNpMPNQ0r3Rcft3M3iuY+uZsCe5AD0CwZJz6yWAhEmjOvpIUFEt3ET53F5xQCvVgqEiUwxh
X-Gm-Message-State: AOJu0YwqTz/ImWr8NFyOcgOSLfraFgX4I5bOxOkCJ68z5kNLzZzdGIi5
	spl603yAfUpSVbWVJAzjhadnqkqu6ttuBJDSCLnZemXd8lmVh1WM9rcALhXDLon8uzN8rZimUJO
	LBatSc/cbiWEsbT0DlSIb7H4SefI=
X-Google-Smtp-Source: AGHT+IFs3rvyeXkj2tvWqusUlk0Gnjrjtiy6bfyOtPXdZdDMGbtqrAaEhUtsoSoT/xZRdVNT440vMqkHDu8HrJmMptM=
X-Received: by 2002:a2e:bc09:0:b0:2ef:23ec:9356 with SMTP id
 38308e7fff4ca-2f3be574b0amr101743041fa.8.1724164894866; Tue, 20 Aug 2024
 07:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820033148.29662-1-sunjunchao2870@gmail.com> <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
In-Reply-To: <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 20 Aug 2024 22:41:22 +0800
Message-ID: <CAHB1NagXgRMj-Rhb=86L8kaXEe8H24=Of6nrUmhMVR2fxTqYkA@mail.gmail.com>
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
Oh... I see. Sorry for this stupid mistake. I will correct it and send
a patch v2.
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

