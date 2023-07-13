Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662017525D7
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjGMO7G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjGMO67 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 10:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF506271F
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TH13VfP2krZahoQXK1VgL3LTSEeQF913+yNrAS5vlAs=;
        b=ZHnroPlByymzareobgi7R7HPhhVPphBjGsI17e6HIaPQ4UJgFSyhDO6ynNAHi6VRgA3TOk
        WyP9ZMXofpAMzag8mQ9dK/t/pJ4GddZT7ObpkMV/7Zb46zKDlABe/iUO/nXIaVkVBJ9u1J
        KxhCSTc6/fRSuJA7XWMO8c9yDFWsGk8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-qqqG4T1MNXmySeJdFLuYIA-1; Thu, 13 Jul 2023 10:57:45 -0400
X-MC-Unique: qqqG4T1MNXmySeJdFLuYIA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39eab5800bdso1130268b6e.0
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 07:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260265; x=1691852265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH13VfP2krZahoQXK1VgL3LTSEeQF913+yNrAS5vlAs=;
        b=C/Up9Eo+HBNumOsacgJomcbjr0jciU2RZfctqMuwSQb7DLoxtfQZY0KOXMuLaj6agg
         xrIPqw9foSHGEZe3IxXF2Y2I/C/XWjBLnkeE0OLHKj0vlj/Iyza/gXFgU8vmXIqMVWJ7
         XgG5nkYtmDsKnFcev489DdA4OlfHbBgv5JzvMLErzpjFNJOCVsngWK3YIwm/N724TsJh
         JiDB+woZF9vXcPW6H9z8Mf3Tq3U2iVOU+5ujLV9BsRQmy7erkMsZDSzTiARRWtRaaFMM
         kioyc0jV1LHU1veqYrYNz0EWByo4lWidfgnGG8Y1iVh2dxhqqr2TeurGl3S7lBJ8wY7g
         HCZA==
X-Gm-Message-State: ABy/qLbSZ/VtLNrFiAFy1DT7Pvnq99UC8mu60h1WGLLMlXPwBloG/ARp
        kgu2EMkH8ymL9fN9WByF67zC54bFXnUajOPiHT3m8UPqJ1wXXPPhecg9H+ToPjPcKhWepgMpDY1
        LPG7GtI6EC1OIe7FQnjaeV+TBJDsu/tYPHff2QNC4
X-Received: by 2002:a05:6808:171c:b0:3a3:4314:8dc0 with SMTP id bc28-20020a056808171c00b003a343148dc0mr1718884oib.5.1689260264753;
        Thu, 13 Jul 2023 07:57:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOhi9e7cYssZgb0dhMgRqQx9O0JPjhqJ2SiCjY+KBIIso6xxDnNiONR+hOOjcFCqb0Oz4LhwleGXARikiM/is=
X-Received: by 2002:a05:6808:171c:b0:3a3:4314:8dc0 with SMTP id
 bc28-20020a056808171c00b003a343148dc0mr1718874oib.5.1689260264494; Thu, 13
 Jul 2023 07:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230713144029.3342637-1-aahringo@redhat.com> <2023071318-traffic-impeding-dc64@gregkh>
In-Reply-To: <2023071318-traffic-impeding-dc64@gregkh>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 13 Jul 2023 10:57:33 -0400
Message-ID: <CAK-6q+j+vQL7nPnr==ZzgWfVoV9idX6k2OT0R_1DJ_qJo4J6mw@mail.gmail.com>
Subject: Re: [PATCH v6.5-rc1 1/2] fs: dlm: introduce DLM_PLOCK_FL_NO_REPLY flag
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org, agruenba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Thu, Jul 13, 2023 at 10:49=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Jul 13, 2023 at 10:40:28AM -0400, Alexander Aring wrote:
> > This patch introduces a new flag DLM_PLOCK_FL_NO_REPLY in case an dlm
> > plock operation should not send a reply back. Currently this is kind of
> > being handled in DLM_PLOCK_FL_CLOSE, but DLM_PLOCK_FL_CLOSE has more
> > meanings that it will remove all waiters for a specific nodeid/owner
> > values in by doing a unlock operation. In case of an error in dlm user
> > space software e.g. dlm_controld we get an reply with an error back.
> > This cannot be matched because there is no op to match in recv_list. We
> > filter now on DLM_PLOCK_FL_NO_REPLY in case we had an error back as
> > reply. In newer dlm_controld version it will never send a result back
> > when DLM_PLOCK_FL_NO_REPLY is set. This filter is a workaround to handl=
e
> > older dlm_controld versions.
> >
> > Fixes: 901025d2f319 ("dlm: make plock operation killable")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
>
> Why is adding a new uapi a stable patch?
>

because the user space is just to copy the flags back to the kernel. I
thought it would work. :)

> > ---
> >  fs/dlm/plock.c                 | 23 +++++++++++++++++++----
> >  include/uapi/linux/dlm_plock.h |  1 +
> >  2 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > index 70a4752ed913..7fe9f4b922d3 100644
> > --- a/fs/dlm/plock.c
> > +++ b/fs/dlm/plock.c
> > @@ -96,7 +96,7 @@ static void do_unlock_close(const struct dlm_plock_in=
fo *info)
> >       op->info.end            =3D OFFSET_MAX;
> >       op->info.owner          =3D info->owner;
> >
> > -     op->info.flags |=3D DLM_PLOCK_FL_CLOSE;
> > +     op->info.flags |=3D (DLM_PLOCK_FL_CLOSE | DLM_PLOCK_FL_NO_REPLY);
> >       send_op(op);
> >  }
> >
> > @@ -293,7 +293,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u6=
4 number, struct file *file,
> >               op->info.owner  =3D (__u64)(long) fl->fl_owner;
> >
> >       if (fl->fl_flags & FL_CLOSE) {
> > -             op->info.flags |=3D DLM_PLOCK_FL_CLOSE;
> > +             op->info.flags |=3D (DLM_PLOCK_FL_CLOSE | DLM_PLOCK_FL_NO=
_REPLY);
> >               send_op(op);
> >               rv =3D 0;
> >               goto out;
> > @@ -392,7 +392,7 @@ static ssize_t dev_read(struct file *file, char __u=
ser *u, size_t count,
> >       spin_lock(&ops_lock);
> >       if (!list_empty(&send_list)) {
> >               op =3D list_first_entry(&send_list, struct plock_op, list=
);
> > -             if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> > +             if (op->info.flags & DLM_PLOCK_FL_NO_REPLY)
> >                       list_del(&op->list);
> >               else
> >                       list_move_tail(&op->list, &recv_list);
> > @@ -407,7 +407,7 @@ static ssize_t dev_read(struct file *file, char __u=
ser *u, size_t count,
> >          that were generated by the vfs cleaning up for a close
> >          (the process did not make an unlock call). */
> >
> > -     if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> > +     if (op->info.flags & DLM_PLOCK_FL_NO_REPLY)
> >               dlm_release_plock_op(op);
> >
> >       if (copy_to_user(u, &info, sizeof(info)))
> > @@ -433,6 +433,21 @@ static ssize_t dev_write(struct file *file, const =
char __user *u, size_t count,
> >       if (check_version(&info))
> >               return -EINVAL;
> >
> > +     /* Some old dlm user space software will send replies back,
> > +      * even if DLM_PLOCK_FL_NO_REPLY is set (because the flag is
> > +      * new) e.g. if a error occur. We can't match them in recv_list
> > +      * because they were never be part of it. We filter it here,
> > +      * new dlm user space software will filter it in user space.
> > +      *
> > +      * In future this handling can be removed.
> > +      */
> > +     if (info.flags & DLM_PLOCK_FL_NO_REPLY) {
> > +             pr_info("Received unexpected reply from op %d, "
> > +                     "please update DLM user space software!\n",
> > +                     info.optype);
>
> Never allow userspace to spam the kernel log.  And this is not going to
> work, you need to handle the error and at most, report this to userspace
> once.
>

I will ignore handling this issue for older kernels because it would
probably be fine that the user space never gets an invalid value
handled.

> Also, don't wrap your strings, checkpatch should have told you this.
>

That is correct and I was ignoring it as the implementation has
another wrapped string somewhere else. It is a warning not an error.

Will send a v2 to not wrap the string around and drop Fixes and cc stable.

- Alex

