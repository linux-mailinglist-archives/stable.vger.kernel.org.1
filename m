Return-Path: <stable+bounces-36135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3555B89A243
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BB11C2108F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37630171087;
	Fri,  5 Apr 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9X4Qqqi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12D171075
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333722; cv=none; b=D9ONDQLoJE+BoccYKxL4Rnh9OE0TILs6ulBtoqAP8DYV4rnYFo9/MGv6XoDFT4pYBEHMeGMfd7/NFp2oQjODPqYCOHQ4SmCsMGxw4Mdw5YUDq5HbfYxYZm6CXL/o7+I3ws7zNA/7cR5Qvcjoub+fYbNUGI83uIa9jNeVGDbbRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333722; c=relaxed/simple;
	bh=kIH66q3ReUt7prEWtuwjTLFN2dfXrbzVgv55dozbzC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvwtEukGRyW0RLuwPma8im1skl3ZU3jDdkmQNz3oOmDlJ1JaPO/55i1zZt4LER4PZsnWtwNDCjM9m6YKVGyK5Nz1YXSauXRB+uM//Gm7bDderJ1VOfUjr8BrFdKUvZXrHsu75CXYoWLhqgaqYS2XldLCV0AvqsAL2vs8HdBgcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9X4Qqqi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e034607879so20824245ad.0
        for <stable@vger.kernel.org>; Fri, 05 Apr 2024 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333719; x=1712938519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlZ7zfeKL1NSw4uEMdtWjKSocZWJWtwOp+8nHlox7X0=;
        b=N9X4QqqiOOXQMJXVv9fVLoAQWAhJrLZRVFb34x/bFFOG0AlNfPTwUXueWnvjGZGhSA
         5yx24h4GfQ15mLRxStMrG3QP3oKx2F/BncNMTGlDsjXxRqb3XuYELLVfhmGEWvsF8eGQ
         c/qa3lzbPoX+Pppa1WxqgU2UEC+GpLskkCS90JtjPpjJLv80XP3xfGuzYK/COh3h+rbJ
         JufHW7ddzpTGkB29L2eOljnHS3bLXnOLcqNkb+CK8b4ahHCn3+rfLMkFv5ma3ud9sO3j
         e1KHRvnI+LaID74nSvHa36feeHnggpPXDhoRixWea9PP2eLvO87jLCRzkjELsq/fB3Au
         41Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333719; x=1712938519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlZ7zfeKL1NSw4uEMdtWjKSocZWJWtwOp+8nHlox7X0=;
        b=Td2pwztn3JxxRj+kzy5vHhiMn2XL3NQ0yZWstEhlZPKinfhGIHiaIE9MsnEbYcLErg
         KywVCSzNXKzfavSYsCP+IvGwlGLpRGU00TMRLLfMBIrDT7cEe5LVPRcg1DkRPH2DthpQ
         qWYAkOUPb1mQcCTs9tCKxXh4qPEEf6HZO5x3CrtN0t7sjNAFZbKtaV3z0DBVpCYRtx5I
         +E6mwcjudFHTEbjW/LDBTb9rfawo2uY4SOAGcOAgthVaYnKyjmjtUEeGF7jt96Lm4cIE
         bjx22EP4/Tg0Bv7eBWCsgXw8kBjSks/fbTks5D0RhteyEc39JcV2GM9q5mFyF7iHOmRl
         jKtg==
X-Forwarded-Encrypted: i=1; AJvYcCUq5DhHOPn10uQbkBkbyc2TQUR3Sb/hj+pXvvqIiusVRw7o9RJ6dZ3wAOypvv8p4QGZSGnm7if/3lO2brti90pNQMJJepqf
X-Gm-Message-State: AOJu0YzWOtg7BomIx/e+rxw1iC+FICyUGcqrGkNCL1OrE3orPDO0RNvs
	8AHfxhZqZJy6QWPYLnXno4gX1Bh4kIcxER3E6GIOnRu23mHVBzT0WCJnwxGyHGGs7aLEQvhxzVF
	smkrJwZ+sROI8sbgjDDTk5AHB0syt/dDxeOg=
X-Google-Smtp-Source: AGHT+IGI1J+5LBE1lRsSzQjBt5Yv6JS4Y4BkM3I0s8dSecagXgToQ9haFRHsCfTU/a/jdrKIskkVMhDAYNuBo4mWP+A=
X-Received: by 2002:a17:902:da92:b0:1e2:a31e:5e14 with SMTP id
 j18-20020a170902da9200b001e2a31e5e14mr2741849plx.13.1712333719477; Fri, 05
 Apr 2024 09:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024040527-propeller-immovably-a6d8@gregkh>
In-Reply-To: <2024040527-propeller-immovably-a6d8@gregkh>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 09:15:07 -0700
Message-ID: <CAEf4BzaNmxj2nLyxiugcmC1v1Cs7HEX2Z0-3a=P323-TxHHTXQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] bpf: support deferring bpf_link dealloc to
 after RCU grace" failed to apply to 6.8-stable tree
To: gregkh@linuxfoundation.org
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:50=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>

This is strange, I get a clean auto-merged cherry-pick:

$ git co linux-6.8.y
Updating files: 100% (10694/10694), done.
branch 'linux-6.8.y' set up to track 'stable/linux-6.8.y'.
Switched to a new branch 'linux-6.8.y'
$ git cp -x 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce
Auto-merging include/linux/bpf.h
Auto-merging kernel/bpf/syscall.c
Auto-merging kernel/trace/bpf_trace.c
[linux-6.8.y fd74c60792f5] bpf: support deferring bpf_link dealloc to
after RCU grace period
 Date: Wed Mar 27 22:24:26 2024 -0700
 3 files changed, 49 insertions(+), 6 deletions(-)

Note that e9c856cabefb ("bpf: put uprobe link's path and task in
release callback") has to be backported at the same time. I'll
cherry-pick both and will send it just in case.


> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.8.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040527-=
propeller-immovably-a6d8@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce Mon Sep 17 00:00:00 2001
> From: Andrii Nakryiko <andrii@kernel.org>
> Date: Wed, 27 Mar 2024 22:24:26 -0700
> Subject: [PATCH] bpf: support deferring bpf_link dealloc to after RCU gra=
ce
>  period
>
> BPF link for some program types is passed as a "context" which can be
> used by those BPF programs to look up additional information. E.g., for
> multi-kprobes and multi-uprobes, link is used to fetch BPF cookie values.
>
> Because of this runtime dependency, when bpf_link refcnt drops to zero
> there could still be active BPF programs running accessing link data.
>
> This patch adds generic support to defer bpf_link dealloc callback to
> after RCU GP, if requested. This is done by exposing two different
> deallocation callbacks, one synchronous and one deferred. If deferred
> one is provided, bpf_link_free() will schedule dealloc_deferred()
> callback to happen after RCU GP.
>
> BPF is using two flavors of RCU: "classic" non-sleepable one and RCU
> tasks trace one. The latter is used when sleepable BPF programs are
> used. bpf_link_free() accommodates that by checking underlying BPF
> program's sleepable flag, and goes either through normal RCU GP only for
> non-sleepable, or through RCU tasks trace GP *and* then normal RCU GP
> (taking into account rcu_trace_implies_rcu_gp() optimization), if BPF
> program is sleepable.
>
> We use this for multi-kprobe and multi-uprobe links, which dereference
> link during program run. We also preventively switch raw_tp link to use
> deferred dealloc callback, as upcoming changes in bpf-next tree expose
> raw_tp link data (specifically, cookie value) to BPF program at runtime
> as well.
>
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
> Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
> Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Link: https://lore.kernel.org/r/20240328052426.3042617-2-andrii@kernel.or=
g
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4f20f62f9d63..890e152d553e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1574,12 +1574,26 @@ struct bpf_link {
>         enum bpf_link_type type;
>         const struct bpf_link_ops *ops;
>         struct bpf_prog *prog;
> -       struct work_struct work;
> +       /* rcu is used before freeing, work can be used to schedule that
> +        * RCU-based freeing before that, so they never overlap
> +        */
> +       union {
> +               struct rcu_head rcu;
> +               struct work_struct work;
> +       };
>  };
>
>  struct bpf_link_ops {
>         void (*release)(struct bpf_link *link);
> +       /* deallocate link resources callback, called without RCU grace p=
eriod
> +        * waiting
> +        */
>         void (*dealloc)(struct bpf_link *link);
> +       /* deallocate link resources callback, called after RCU grace per=
iod;
> +        * if underlying BPF program is sleepable we go through tasks tra=
ce
> +        * RCU GP and then "classic" RCU GP
> +        */
> +       void (*dealloc_deferred)(struct bpf_link *link);
>         int (*detach)(struct bpf_link *link);
>         int (*update_prog)(struct bpf_link *link, struct bpf_prog *new_pr=
og,
>                            struct bpf_prog *old_prog);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ae2ff73bde7e..c287925471f6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3024,17 +3024,46 @@ void bpf_link_inc(struct bpf_link *link)
>         atomic64_inc(&link->refcnt);
>  }
>
> +static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
> +{
> +       struct bpf_link *link =3D container_of(rcu, struct bpf_link, rcu)=
;
> +
> +       /* free bpf_link and its containing memory */
> +       link->ops->dealloc_deferred(link);
> +}
> +
> +static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
> +{
> +       if (rcu_trace_implies_rcu_gp())
> +               bpf_link_defer_dealloc_rcu_gp(rcu);
> +       else
> +               call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
> +}
> +
>  /* bpf_link_free is guaranteed to be called from process context */
>  static void bpf_link_free(struct bpf_link *link)
>  {
> +       bool sleepable =3D false;
> +
>         bpf_link_free_id(link->id);
>         if (link->prog) {
> +               sleepable =3D link->prog->sleepable;
>                 /* detach BPF program, clean up used resources */
>                 link->ops->release(link);
>                 bpf_prog_put(link->prog);
>         }
> -       /* free bpf_link and its containing memory */
> -       link->ops->dealloc(link);
> +       if (link->ops->dealloc_deferred) {
> +               /* schedule BPF link deallocation; if underlying BPF prog=
ram
> +                * is sleepable, we need to first wait for RCU tasks trac=
e
> +                * sync, then go through "classic" RCU grace period
> +                */
> +               if (sleepable)
> +                       call_rcu_tasks_trace(&link->rcu, bpf_link_defer_d=
ealloc_mult_rcu_gp);
> +               else
> +                       call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_g=
p);
> +       }
> +       if (link->ops->dealloc)
> +               link->ops->dealloc(link);
>  }
>
>  static void bpf_link_put_deferred(struct work_struct *work)
> @@ -3544,7 +3573,7 @@ static int bpf_raw_tp_link_fill_link_info(const str=
uct bpf_link *link,
>
>  static const struct bpf_link_ops bpf_raw_tp_link_lops =3D {
>         .release =3D bpf_raw_tp_link_release,
> -       .dealloc =3D bpf_raw_tp_link_dealloc,
> +       .dealloc_deferred =3D bpf_raw_tp_link_dealloc,
>         .show_fdinfo =3D bpf_raw_tp_link_show_fdinfo,
>         .fill_link_info =3D bpf_raw_tp_link_fill_link_info,
>  };
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b73fe5f7206..9dc605f08a23 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2728,7 +2728,7 @@ static int bpf_kprobe_multi_link_fill_link_info(con=
st struct bpf_link *link,
>
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops =3D {
>         .release =3D bpf_kprobe_multi_link_release,
> -       .dealloc =3D bpf_kprobe_multi_link_dealloc,
> +       .dealloc_deferred =3D bpf_kprobe_multi_link_dealloc,
>         .fill_link_info =3D bpf_kprobe_multi_link_fill_link_info,
>  };
>
> @@ -3242,7 +3242,7 @@ static int bpf_uprobe_multi_link_fill_link_info(con=
st struct bpf_link *link,
>
>  static const struct bpf_link_ops bpf_uprobe_multi_link_lops =3D {
>         .release =3D bpf_uprobe_multi_link_release,
> -       .dealloc =3D bpf_uprobe_multi_link_dealloc,
> +       .dealloc_deferred =3D bpf_uprobe_multi_link_dealloc,
>         .fill_link_info =3D bpf_uprobe_multi_link_fill_link_info,
>  };
>
>

