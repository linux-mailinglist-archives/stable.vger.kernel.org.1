Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A937BBC0C
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjJFPpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJFPp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 11:45:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1BE9
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 08:45:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso3821004a12.1
        for <stable@vger.kernel.org>; Fri, 06 Oct 2023 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696607123; x=1697211923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOaUVEjPBQXATZEGgG+vvwePcLV9L3JhHEweMwJrUI0=;
        b=GX/5GNHdtJD7bbQyw8xKLXpVfpaOwczxTUnrAggZSHpqT9F6UeXCSUjvV1r+yG9U7l
         DRLv+vwWwxCr4Vge7XgI5VbNqV2RpHFz+gzDATfF7u/AHZwpdb7t4Jxt2K4vtaUeKgnN
         GINXNmbjaKWeYYeSoRoq71/ybC6IO3Glz0+ZAF3Qej2r1DvJVH0GPQrV+1P7n6H9TusZ
         lKbiKd0oEDVOwGlA9IexFlfCode7N9rvS+VTlgJ4i/9qLNSM76SZDr8UbYDY1a15NKuf
         Wx2cvWXer6KgDGPlwv9RT3Up71WI43UnS285EpqovHj1/hblzCrIJwHiPQM9zTuL9hF5
         Ep7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696607123; x=1697211923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOaUVEjPBQXATZEGgG+vvwePcLV9L3JhHEweMwJrUI0=;
        b=bZudPSNQZsu+HuEpbtEH1NxixwlhAGQmQd9gHAtXt2dezVwVJ0aU71u6w86rJOhcGx
         +YvwSN12sAvbPrzTb3S+LoKSn2Y+J7S39bQefUe/stf4QXm6tT+wuZHqGo+cX72y92sQ
         Zs5FvxSWhSN8wH3OLtKaulGHB/CQsXbLgd/nCUBLd96yOmJQz1M/7P7ciM3TGV9+v57V
         q+xV3S4WxdLNmEmpGaA1wHhME8UZg39zjICFVkDFQVC4GHPcWmwlP7MlRqYVFw127T3R
         +OZsvzTK+NJ1r4DXJq2iJeWxS3jKvJHX8Flzg1BHhPJl59DVoddZLWYcCc/IHG3lm+LU
         OB3g==
X-Gm-Message-State: AOJu0Ywg1BsIi11XOu6capwZgEy9ITX0U98MAdfdCpzYebVwQWWo5VQI
        szt3Ox54STYfOpYQK4hX0lpG4J7OLdlHvUoWrajbQg==
X-Google-Smtp-Source: AGHT+IFhIh+wf+KZojiNsFRvojUNm5KmpfaaXRwATw96JQ1/qlTMNH6aT9qKPiMOxHJjWcBVhHhKEJh2LpVA43Djbjw=
X-Received: by 2002:a17:907:6c14:b0:9ae:588e:142 with SMTP id
 rl20-20020a1709076c1400b009ae588e0142mr7307402ejc.67.1696607123375; Fri, 06
 Oct 2023 08:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231004233827.1274148-1-jrife@google.com> <CAOi1vP-9L7rDxL6Wv_=6uuxVV_d-qK7StyDLBbvpZZcXmg6+Mg@mail.gmail.com>
In-Reply-To: <CAOi1vP-9L7rDxL6Wv_=6uuxVV_d-qK7StyDLBbvpZZcXmg6+Mg@mail.gmail.com>
From:   Jordan Rife <jrife@google.com>
Date:   Fri, 6 Oct 2023 08:45:09 -0700
Message-ID: <CADKFtnT6CYG779McrTQh+Y2fDz8Nzy6sFE-qSGbxWenh=fborg@mail.gmail.com>
Subject: Re: [PATCH] ceph: use kernel_connect()
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com, jlayton@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Ilya,

Sorry for the confusion. I forgot to mark 0bdf399342c5 ("net: Avoid
address overwrite in kernel_connect") for stable initially, so I
forwarded it separately to the stable team a while back. It has since
been backported to all stable branches 4.19+.

-Jordan

On Fri, Oct 6, 2023 at 3:53=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
>
> On Thu, Oct 5, 2023 at 1:39=E2=80=AFAM Jordan Rife <jrife@google.com> wro=
te:
> >
> > Direct calls to ops->connect() can overwrite the address parameter when
> > used in conjunction with BPF SOCK_ADDR hooks. Recent changes to
> > kernel_connect() ensure that callers are insulated from such side
> > effects. This patch wraps the direct call to ops->connect() with
> > kernel_connect() to prevent unexpected changes to the address passed to
> > ceph_tcp_connect().
> >
> > This change was originally part of a larger patch targeting the net tre=
e
> > addressing all instances of unprotected calls to ops->connect()
> > throughout the kernel, but this change was split up into several patche=
s
> > targeting various trees.
> >
> > Link: https://lore.kernel.org/netdev/20230821100007.559638-1-jrife@goog=
le.com/
> > Link: https://lore.kernel.org/netdev/9944248dba1bce861375fcce9de663934d=
933ba9.camel@redhat.com/
> > Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >  net/ceph/messenger.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 10a41cd9c5235..3c8b78d9c4d1c 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -459,8 +459,8 @@ int ceph_tcp_connect(struct ceph_connection *con)
> >         set_sock_callbacks(sock, con);
> >
> >         con_sock_state_connecting(con);
> > -       ret =3D sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof=
(ss),
> > -                                O_NONBLOCK);
> > +       ret =3D kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss)=
,
> > +                            O_NONBLOCK);
> >         if (ret =3D=3D -EINPROGRESS) {
> >                 dout("connect %s EINPROGRESS sk_state =3D %u\n",
> >                      ceph_pr_addr(&con->peer_addr),
> > --
> > 2.42.0.582.g8ccd20d70d-goog
> >
>
> Hi Jordan,
>
> I'm a bit confused.  This is marked as fixing commit d74bad4e74ee
> ("bpf: Hooks for sys_connect") and also for stable, but doesn't
> (explicitly, at least) mention the prerequisite commit 0bdf399342c5
> ("net: Avoid address overwrite in kernel_connect") which isn't marked
> for stable.  Was it forwarded to the stable team separately?
>
> Thanks,
>
>                 Ilya
