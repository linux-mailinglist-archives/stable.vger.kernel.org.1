Return-Path: <stable+bounces-104509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70A59F4DC7
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1827916D0BE
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C11F5411;
	Tue, 17 Dec 2024 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smruJOT3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB001F3D50
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445891; cv=none; b=gcohScTT6YbkVt+rBRQwmclD+ImODn/zrJ1yBoQr2ukJzdSrXDe1zT85pojNa/8bKEhvUrooVjr/8kmWEkktBhC9I/fHfZXT0qMW6LIG6LRRHWU/f9tceJdUeqoU7+h3wtjGpfvwDxAA+cR4RVkoJa6Ji53J7i8SSzaayg2EEgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445891; c=relaxed/simple;
	bh=zy50t/hza8/qqnHZ5cqN0yNA8hpNOnCQM+jwlTDCTW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJ5qSTn/7OvtSDhI6J3Z+TkZ4wyPiZ7Jbr+l9m4XgYEkAiZm13JnXrGt9rotuke88+OW6QgDV95bxdSpaClxGLM6Qb1mMUp7RwBdyFczldU1gzc/B9u8ploih9kthygNAmTOO27VncOABsbnU96G/5CnX42bCxFa9mw0nX+Z1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smruJOT3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215740b7fb8so150525ad.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 06:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734445889; x=1735050689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IUKnZ0lzp04EWEQI6yO8xDcmIbMp5DmKbv3o4rFPlE=;
        b=smruJOT3NugDErNbgpA1Iqyu/zZwXpmen7P2Tmsqf7e3mn3ZixFxHW22iAg5m4CEVO
         Ez/ilbOKb97OspbpUwAX8j9hMNmO+LxSEDSU4fUqAVPs5CDrHDM0958Ip2WJTtTxjND8
         Agca2EZmCKwpNYe666IHBquB9BbhKP+Mh04+M5lsfRhJ+JxqHS30+v9oCxdDctb6Dlhs
         5UWac3JhBVp/ElTMC3jVajjCgVlo5sRO2hi2myJ45FdLjfkIu4RH/2iC8jsYPGUlsuWu
         5ENr7smAXPYc7/JyGqH5QZVaPrKdK0QgrXtd6CE0TnmAGN+u0Z2Rq5VJ+wYKTcAYRrPV
         vw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445889; x=1735050689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IUKnZ0lzp04EWEQI6yO8xDcmIbMp5DmKbv3o4rFPlE=;
        b=e9zQRfbL2H9gQx9Webklrs4CZt/OuCP+FxsNYwyqRduUw2cL7d/lQuuQssIP6oCw/w
         0RXo4j5ehleyydPzBY151e43/lFPBl0QWqGfT3A1lZC14DO56Oqzqke1TAGEnGMjU2tv
         1ic59gRhs/Dh9sp88FGSiK7DZTpm17XK6k/oANA55ULicDk25TVDQfmtUsSTDKK3LxHo
         a3B9loNBlziJ8stQ3Gha+ON/lm2awQR+vYcJ0P1yPlL1YCUbZwcRrY6ad9QnnuSqG7qq
         mqdriHtlnRZbSDYqnkPF+nZwFXV4ZTf/t/seWaA8TWF0Ov3IaLuSW9McHYfw7junwGg+
         sVuA==
X-Forwarded-Encrypted: i=1; AJvYcCWvjYi9cRaEP84MeQRKpA16PfIY5kxvNg383hF1COwkLruK6n85q4nB0j59d1o6Uu4lBIt9bYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnvCNgHMnAlwrqQ+tg2gOIUoEgeDrA4dQNlyF13L+U/ygCrX+
	Non0r9B1iaG5/BDpwtC+D0xFfXyJKXhEY30Zr1mvAkdq9rIQvFHUTBMLT/AhOJULD43c1jyHuFt
	iHHyo/Kt7QC2JM3O9ErG7VklwonGffN/G/T+qy33M6QgO58roKDZh
X-Gm-Gg: ASbGncs3aPZMyug1mLDCRIbNdsuf3JPfrqbFwKLUawvLlr6Lf3x/x6zx/TEpV56RIko
	t8uEXTndlrN+Ynxsp+Awg1p9qjUFszzXbsVlq
X-Google-Smtp-Source: AGHT+IHbAEaUpJMyIaGlrjcJhGwBko6mxJsWZi6pmCmhJ4SsZtC8iAiesZb8JsVR66lmc8LPi188LgFqCcBX8rJnxzU=
X-Received: by 2002:a17:903:120e:b0:215:b077:5c21 with SMTP id
 d9443c01a7336-218c9cd8afcmr2759855ad.26.1734445888799; Tue, 17 Dec 2024
 06:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426080548.8203-1-xuewen.yan@unisoc.com> <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
 <ZxAOgj9RWm4NTl9d@google.com> <Z1saBPCh_oVzbPQy@google.com>
In-Reply-To: <Z1saBPCh_oVzbPQy@google.com>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 17 Dec 2024 09:30:51 -0500
Message-ID: <CADyq12y=MGzcvemZTVVGN4yhzr2ihr96OB-Vpg0yvrtrewnFDg@mail.gmail.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
To: Greg KH <gregkh@linuxfoundation.org>, "# v4 . 10+" <stable@vger.kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, Christian Brauner <brauner@kernel.org>, jack@suse.cz, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, cmllamas@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, jing.xia@unisoc.com, xuewen.yan94@gmail.com, 
	viro@zeniv.linux.org.uk, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, lizeb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:14=E2=80=AFPM Brian Geffon <bgeffon@google.com> =
wrote:
>
> On Wed, Oct 16, 2024 at 03:05:38PM -0400, Brian Geffon wrote:
> > On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> > > On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > > > Now, the epoll only use wake_up() interface to wake up task.
> > > > However, sometimes, there are epoll users which want to use
> > > > the synchronous wakeup flag to hint the scheduler, such as
> > > > Android binder driver.
> > > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > > when the sync is true in ep_poll_callback().
> > > >
> > > > [...]
> > >
> > > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > > Patches in the vfs.misc branch should appear in linux-next soon.
> > >
> > > Please report any outstanding bugs that were missed during review in =
a
> > > new review to the original patch series allowing us to drop it.
> > >
> > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > patch has now been applied. If possible patch trailers will be update=
d.
> > >
> > > Note that commit hashes shown below are subject to change due to reba=
se,
> > > trailer updates or similar. If in doubt, please check the listed bran=
ch.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > branch: vfs.misc
> >
> > This is a bug that's been present for all of time, so I think we should=
:
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
>
> This is in as 900bbaae ("epoll: Add synchronous wakeup support for
> ep_poll_callback"). How do maintainers feel about:
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

Dear stable maintainers, this fixes a bug goes all the way back and
beyond Linux 2.6.12-rc2. Can you please add this commit to the stable
releases?

commit 900bbaae67e980945dec74d36f8afe0de7556d5a upstream.

>
> >
> > I sent a patch which adds a benchmark for nonblocking pipes using epoll=
:
> > https://lore.kernel.org/lkml/20241016190009.866615-1-bgeffon@google.com=
/
> >
> > Using this new benchmark I get the following results without this fix
> > and with this fix:
> >
> > $ tools/perf/perf bench sched pipe -n
> > # Running 'sched/pipe' benchmark:
> > # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 12.194 [sec]
> >
> >       12.194376 usecs/op
> >           82005 ops/sec
> >
> >
> > $ tools/perf/perf bench sched pipe -n
> > # Running 'sched/pipe' benchmark:
> > # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 9.229 [sec]
> >
> >        9.229738 usecs/op
> >          108345 ops/sec
> >
> > >
> > > [1/1] epoll: Add synchronous wakeup support for ep_poll_callback
> > >       https://git.kernel.org/vfs/vfs/c/2ce0e17660a7
>
> Thanks,
> Brian
>

 Thanks,
 Brian

