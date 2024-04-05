Return-Path: <stable+bounces-36136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB5F89A25E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 18:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2C21F232EF
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A8171083;
	Fri,  5 Apr 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msVXRQ1x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854716EC0B;
	Fri,  5 Apr 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334090; cv=none; b=ZGHY/cXOEA1npCg7aPQwNHz/lcu2UIO+h158Eh4GNxtAA7+QoaFZ6uQbSOmpFTLjj68SvOayE2XgQbZFXAF1PMfCX4t8HcI9K9Ssaonq3l0yP5VtFNnsnGQCtmda9Z/UuRQnC7RpFOZavEyAUTXRe1pMUSA6ID6pk4xMy2grY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334090; c=relaxed/simple;
	bh=P6cPTWlnE8l6poOJpNqlFH0K2aeeZ1oq2S246jOwDBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRJlJltvTbYM2TkpQt8k0AJ/V67MOQdMzFS9S9fCL3S/NMS2YbJG3H60/rcpYmWfWOUb1H1r/XVaLOyBNwy+7UgZU2BQqMYhb9/QhnLlg2IQAz2sM9/calkowiDj+Jr8cWP2j1bpbdtwghhZTSx/Sp8jzxE3pS4KxhDRkIUrE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msVXRQ1x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3c7549078so4006165ad.0;
        Fri, 05 Apr 2024 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712334088; x=1712938888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GUBptl3s2kbvyfICaIUTfihJwzVEYCUouoPcDs5zv0=;
        b=msVXRQ1xBxpXNbFn0hsMoj01BRYw3NnUY0RGPvaRHYhZ/d97ucoY7FDBIALP90E45M
         e0utOqOBw5/868NN3hqt/bmTFN94VTdKVM1ZLiomBXHmFM7YytXCmKVNxuLteE9AZp3C
         yxui1IMM8koSg3/yl0bufwM3R8PJXvvnHZMg20E4DV6OGesUmApnPDyTyu3IfM5AqZGI
         K8CaErD16iu/h54sQsv+TTXoAG9EioLCwd0LxHWOcZb1vxGrvPel+FLY9CHigosfMO8d
         rEyCxl9+EwtMM16qyKNusiIwQTGPqn+SdIrln0Myt+JWouLQTCJ8bAsGUWkpo9tzqyqM
         pYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712334088; x=1712938888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GUBptl3s2kbvyfICaIUTfihJwzVEYCUouoPcDs5zv0=;
        b=cSOrdz297GUOSsdw73lESPe1YcwdhM2vZQVjdD+n+nrQhD7Hiw6q6dIYO3LPFgLh/4
         ECdm46sTlG01RLYzo0kcqNmHAKNlT5OI8jFm6+L2VhpVZTN9gxe2VxN9tOKeOoDzefh/
         9qwvV9h2fAWMWQWYsLMrgAVkIvVvnORBxoQb52Eg4/QjfPyvmSXcEOUY+m6VyV7oY3zv
         q6wrJHb1xJ9zQMPVydMRwzExEy8pio4bm5b+NqjVXJuZ7pYMbWUjrHyWI5O6lNqg6sg4
         lxQNIUjZRNwAaqMTKsawf52WUy2iYV5GyPrrKK0IKa61C4D30hG7l5xnE2Jn/Mktb0FB
         PF3w==
X-Forwarded-Encrypted: i=1; AJvYcCX52J4zZ/xFihXN2KcUvRHx3aNwXfrLJmuGQidMAPFU8J3MApfOsGkleMacPQw9OraAGItsc4ngTbfuSE546QClrnMDylG6As/6cbNS5dzze8YHSOkRzuwsmeRF
X-Gm-Message-State: AOJu0YxHjo/NJSJLDZBbSrShXEGBtbzn+qovgnVu+g1EVZh8SQbsxxVr
	+/u1unztLwKR1y7g6R/imQmQHLs59fnImYpXenlip+U6cFjR27BgFjgxoF6Zu80YMD7Zs/qfCEF
	yEfc+GvpkI0JUVfL1JbNOvcmPgBA=
X-Google-Smtp-Source: AGHT+IE4kqNvLYOs7uXGGvW7cklMW0jMay1Z1cWR26xXAtAMxX7n468pCK0HyRQ6SkK3Nme36tQDb6VMF6yMGIxGh74=
X-Received: by 2002:a17:902:d512:b0:1e0:cea:257e with SMTP id
 b18-20020a170902d51200b001e00cea257emr4501207plg.2.1712334087801; Fri, 05 Apr
 2024 09:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024040527-propeller-immovably-a6d8@gregkh> <CAEf4BzaNmxj2nLyxiugcmC1v1Cs7HEX2Z0-3a=P323-TxHHTXQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaNmxj2nLyxiugcmC1v1Cs7HEX2Z0-3a=P323-TxHHTXQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 09:21:15 -0700
Message-ID: <CAEf4BzY03zZrHUXTNop8+PMt=-d0+oOaWBnJyPTSSOvKv1mgNg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] bpf: support deferring bpf_link dealloc to
 after RCU grace" failed to apply to 6.8-stable tree
To: gregkh@linuxfoundation.org
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, 
	stable@vger.kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 9:15=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 5, 2024 at 2:50=E2=80=AFAM <gregkh@linuxfoundation.org> wrote=
:
> >
> >
> > The patch below does not apply to the 6.8-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
>
> This is strange, I get a clean auto-merged cherry-pick:
>
> $ git co linux-6.8.y
> Updating files: 100% (10694/10694), done.
> branch 'linux-6.8.y' set up to track 'stable/linux-6.8.y'.
> Switched to a new branch 'linux-6.8.y'
> $ git cp -x 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce
> Auto-merging include/linux/bpf.h
> Auto-merging kernel/bpf/syscall.c
> Auto-merging kernel/trace/bpf_trace.c
> [linux-6.8.y fd74c60792f5] bpf: support deferring bpf_link dealloc to
> after RCU grace period
>  Date: Wed Mar 27 22:24:26 2024 -0700
>  3 files changed, 49 insertions(+), 6 deletions(-)
>
> Note that e9c856cabefb ("bpf: put uprobe link's path and task in
> release callback") has to be backported at the same time. I'll
> cherry-pick both and will send it just in case.
>

Ah, so it doesn't build (trivial link->prog->sleepable ->
link->prog->aux->sleepable change, will fix up). Not sure if possible,
but it would be nice to distinguish between patch not applying vs it
causing build (or test) failures, but no big deal.

>
> > To reproduce the conflict and resubmit, you may use the following comma=
nds:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-6.8.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202404052=
7-propeller-immovably-a6d8@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..
> >
> > Possible dependencies:
> >
> >
> >
> > thanks,
> >
> > greg k-h
> >
> > ------------------ original commit in Linus's tree ------------------
> >
> > From 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce Mon Sep 17 00:00:00 2001
> > From: Andrii Nakryiko <andrii@kernel.org>
> > Date: Wed, 27 Mar 2024 22:24:26 -0700
> > Subject: [PATCH] bpf: support deferring bpf_link dealloc to after RCU g=
race
> >  period
> >
> > BPF link for some program types is passed as a "context" which can be
> > used by those BPF programs to look up additional information. E.g., for
> > multi-kprobes and multi-uprobes, link is used to fetch BPF cookie value=
s.
> >
> > Because of this runtime dependency, when bpf_link refcnt drops to zero
> > there could still be active BPF programs running accessing link data.
> >
> > This patch adds generic support to defer bpf_link dealloc callback to
> > after RCU GP, if requested. This is done by exposing two different
> > deallocation callbacks, one synchronous and one deferred. If deferred
> > one is provided, bpf_link_free() will schedule dealloc_deferred()
> > callback to happen after RCU GP.
> >
> > BPF is using two flavors of RCU: "classic" non-sleepable one and RCU
> > tasks trace one. The latter is used when sleepable BPF programs are
> > used. bpf_link_free() accommodates that by checking underlying BPF
> > program's sleepable flag, and goes either through normal RCU GP only fo=
r
> > non-sleepable, or through RCU tasks trace GP *and* then normal RCU GP
> > (taking into account rcu_trace_implies_rcu_gp() optimization), if BPF
> > program is sleepable.
> >
> > We use this for multi-kprobe and multi-uprobe links, which dereference
> > link during program run. We also preventively switch raw_tp link to use
> > deferred dealloc callback, as upcoming changes in bpf-next tree expose
> > raw_tp link data (specifically, cookie value) to BPF program at runtime
> > as well.
> >
> > Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> > Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> > Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
> > Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
> > Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Link: https://lore.kernel.org/r/20240328052426.3042617-2-andrii@kernel.=
org
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 4f20f62f9d63..890e152d553e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1574,12 +1574,26 @@ struct bpf_link {
> >         enum bpf_link_type type;
> >         const struct bpf_link_ops *ops;
> >         struct bpf_prog *prog;
> > -       struct work_struct work;
> > +       /* rcu is used before freeing, work can be used to schedule tha=
t
> > +        * RCU-based freeing before that, so they never overlap
> > +        */
> > +       union {
> > +               struct rcu_head rcu;
> > +               struct work_struct work;
> > +       };
> >  };
> >
> >  struct bpf_link_ops {
> >         void (*release)(struct bpf_link *link);
> > +       /* deallocate link resources callback, called without RCU grace=
 period
> > +        * waiting
> > +        */
> >         void (*dealloc)(struct bpf_link *link);
> > +       /* deallocate link resources callback, called after RCU grace p=
eriod;
> > +        * if underlying BPF program is sleepable we go through tasks t=
race
> > +        * RCU GP and then "classic" RCU GP
> > +        */
> > +       void (*dealloc_deferred)(struct bpf_link *link);
> >         int (*detach)(struct bpf_link *link);
> >         int (*update_prog)(struct bpf_link *link, struct bpf_prog *new_=
prog,
> >                            struct bpf_prog *old_prog);
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index ae2ff73bde7e..c287925471f6 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3024,17 +3024,46 @@ void bpf_link_inc(struct bpf_link *link)
> >         atomic64_inc(&link->refcnt);
> >  }
> >
> > +static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
> > +{
> > +       struct bpf_link *link =3D container_of(rcu, struct bpf_link, rc=
u);
> > +
> > +       /* free bpf_link and its containing memory */
> > +       link->ops->dealloc_deferred(link);
> > +}
> > +
> > +static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
> > +{
> > +       if (rcu_trace_implies_rcu_gp())
> > +               bpf_link_defer_dealloc_rcu_gp(rcu);
> > +       else
> > +               call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
> > +}
> > +
> >  /* bpf_link_free is guaranteed to be called from process context */
> >  static void bpf_link_free(struct bpf_link *link)
> >  {
> > +       bool sleepable =3D false;
> > +
> >         bpf_link_free_id(link->id);
> >         if (link->prog) {
> > +               sleepable =3D link->prog->sleepable;
> >                 /* detach BPF program, clean up used resources */
> >                 link->ops->release(link);
> >                 bpf_prog_put(link->prog);
> >         }
> > -       /* free bpf_link and its containing memory */
> > -       link->ops->dealloc(link);
> > +       if (link->ops->dealloc_deferred) {
> > +               /* schedule BPF link deallocation; if underlying BPF pr=
ogram
> > +                * is sleepable, we need to first wait for RCU tasks tr=
ace
> > +                * sync, then go through "classic" RCU grace period
> > +                */
> > +               if (sleepable)
> > +                       call_rcu_tasks_trace(&link->rcu, bpf_link_defer=
_dealloc_mult_rcu_gp);
> > +               else
> > +                       call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu=
_gp);
> > +       }
> > +       if (link->ops->dealloc)
> > +               link->ops->dealloc(link);
> >  }
> >
> >  static void bpf_link_put_deferred(struct work_struct *work)
> > @@ -3544,7 +3573,7 @@ static int bpf_raw_tp_link_fill_link_info(const s=
truct bpf_link *link,
> >
> >  static const struct bpf_link_ops bpf_raw_tp_link_lops =3D {
> >         .release =3D bpf_raw_tp_link_release,
> > -       .dealloc =3D bpf_raw_tp_link_dealloc,
> > +       .dealloc_deferred =3D bpf_raw_tp_link_dealloc,
> >         .show_fdinfo =3D bpf_raw_tp_link_show_fdinfo,
> >         .fill_link_info =3D bpf_raw_tp_link_fill_link_info,
> >  };
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0b73fe5f7206..9dc605f08a23 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2728,7 +2728,7 @@ static int bpf_kprobe_multi_link_fill_link_info(c=
onst struct bpf_link *link,
> >
> >  static const struct bpf_link_ops bpf_kprobe_multi_link_lops =3D {
> >         .release =3D bpf_kprobe_multi_link_release,
> > -       .dealloc =3D bpf_kprobe_multi_link_dealloc,
> > +       .dealloc_deferred =3D bpf_kprobe_multi_link_dealloc,
> >         .fill_link_info =3D bpf_kprobe_multi_link_fill_link_info,
> >  };
> >
> > @@ -3242,7 +3242,7 @@ static int bpf_uprobe_multi_link_fill_link_info(c=
onst struct bpf_link *link,
> >
> >  static const struct bpf_link_ops bpf_uprobe_multi_link_lops =3D {
> >         .release =3D bpf_uprobe_multi_link_release,
> > -       .dealloc =3D bpf_uprobe_multi_link_dealloc,
> > +       .dealloc_deferred =3D bpf_uprobe_multi_link_dealloc,
> >         .fill_link_info =3D bpf_uprobe_multi_link_fill_link_info,
> >  };
> >
> >

